
CREATE   Function [dbo].[FN_ContactTracing_BuildWorkListQuery](
    @QueryMode bit,
    @InvestigatorDR INT = NULL
    ,@UserId INT = NULL    
    ,@DistrictGroupCode_ID INT = NULL
    ,@DiseaseGroupCode_ID INT = NULL
    ,@InAccessibleProcessStatusUserGroupId INT = NULL
    ,@AccessibleReportSourceIds VARCHAR(MAX) = NULL
    ,@FieldFilterUDSectionDR INT = NULL
    ,@FieldFilterUDFieldDR INT = NULL
    ,@FieldFilterUDFieldType INT = NULL
    ,@FieldFilterUDFieldValue VARCHAR(MAX) = NULL)
RETURNS nvarchar(max)
AS
BEGIN

    Declare @query nvarchar(max) = N''
    Declare @fields as nvarchar(max)
    Declare @followUpQueryPart nvarchar(max) =N''
    Declare @filterPredicate nvarchar(max) =N''
    Declare @securityFilterPredicate nvarchar(max) = N''
    

    IF @QueryMode = 0 -- GetResultSet
    BEGIN
        SET @fields = N''
        SET @followUpQueryPart = N'
        OUTER APPLY(
                SELECT MIN([SCH].[DueDate]) AS DVPR_FollowUpDate 
                FROM [dbo].[S_IssuedPasscode] [SIP] (nolock)
                INNER JOIN [dbo].[S_FollowUpSchedule] [SCH] (nolock) ON [SCH].IssuedPasscode_RowID = [SIP].[ID]   
                LEFT JOIN (SELECT MAX([SCH_IN].[ID]) AS ID
                            FROM [dbo].[S_IssuedPasscode] [SIP_IN] (nolock)
                            INNER JOIN [dbo].[S_FollowUpSchedule] [SCH_IN] (nolock) ON [SCH_IN].IssuedPasscode_RowID = [SIP_IN].[ID]   
                            WHERE [SIP_IN].[Record_RowID] = DVG.DVPR_RowID
                            AND [SCH_IN].[SubmissionDate] IS NOT NULL 
                            GROUP BY [SIP_IN].[Record_RowID]) LAST_SUBMISSION ON 1=1
                WHERE [SIP].[Record_RowID] = DVG.DVPR_RowID 
                AND [SCH].[SubmissionDate] IS NULL 
                AND (LAST_SUBMISSION.ID IS NULL OR ([SCH].ID >= LAST_SUBMISSION.ID))
                GROUP BY [SIP].[Record_RowID]
        ) FollowUp '
    END
    ELSE
    BEGIN
        SET @fields = N' SELECT COUNT(0) '
    END
    SET @filterPredicate = @filterPredicate + N' WHERE DVG.DVPR_TypeDR= @recordTypeDR '
    SET @filterPredicate = @filterPredicate + CASE WHEN ISNULL(@InvestigatorDR, 0)> 0 THEN N'AND DVG.DVPR_NurseInvestigatorDR = @InvestigatorDR ' ELSE 'AND DVG.DVPR_NurseInvestigatorDR IS NULL ' END
    SET @filterPredicate = @filterPredicate + 'AND REL.DVPR_RowID IS NULL '

    SET @query = @fields + N'

    FROM DV_PHPersonalRecord DVG (nolock)
    INNER JOIN DV_Person DVPER (nolock)  ON DVPER.DVPER_RowID = DVG.DVPR_PersonDR
    INNER JOIN A_Act ACT (nolock) ON DVG.DVPR_RowID = ACT.ID AND ACT.statusCode<>''completed'' '
    IF ISNULL(@DistrictGroupCode_ID, 0) > 0 OR ISNULL(@DiseaseGroupCode_ID, 0) > 0 OR ISNULL(@AccessibleReportSourceIds, '') <> '' 
    BEGIN
        SET @query = @query + N' 
        OUTER APPLY(
            SELECT DISTINCT DVPR_RowID FROM DV_PHPersonalRecord (nolock) DV '
            + CASE WHEN ISNULL(@DiseaseGroupCode_ID, 0) > 0 THEN N'INNER JOIN CEDisease ON CEDisease.disease_Id = DV.DVPR_DiseaseCode_ID ' ELSE N'' END
            + CASE WHEN ISNULL(@AccessibleReportSourceIds, N'') <> N'' THEN N'INNER JOIN STRING_SPLIT(@AccessibleReportSourceIds,'','') AccessibleRS ON AccessibleRS.[value] = DV.DVPR_ReportSourceDR ' ELSE N'' END
            + CASE WHEN ISNULL(@DistrictGroupCode_ID, 0) > 0 THEN N' 
                INNER JOIN CEDistrict District ON (CASE 
                WHEN DV.DVPR_DistrictCode_ID = district_id  THEN 1
                WHEN DV.DVPR_SecondaryDistrictCode_ID = district_id  THEN 1
                WHEN DV.DVPR_OriginalDistrictCode_ID = district_id  THEN 1
            END) = 1
            ' ELSE N'' END
            +N' WHERE DV.DVPR_RowID = DVG.DVPR_RowID '
        +') DiseaseDistrictAndReportSourceFilter'
        SET @securityFilterPredicate = @securityFilterPredicate +  N'AND DiseaseDistrictAndReportSourceFilter.DVPR_RowID IS NOT NULL '
    END
    IF ISNULL(@InAccessibleProcessStatusUserGroupId,0) > 0
    BEGIN
        SET @query = @query + N' 
        OUTER APPLY(
             SELECT DV.DVPR_RowID  
                    FROM DV_PHPersonalRecord DV (NOLOCK) 
                    INNER JOIN S_UserGroupInAccessibleProcessStatus UGIP WITH (NOLOCK) ON UGIP.UG_ProcessStatusID=DV.DVPR_ProcessStatusCode_ID AND UGIP.UG_RowID=@inAccessibleProcessStatusUserGroupId WHERE DV.DVPR_RowID = DVG.DVPR_RowID 
        ) InAccessibleProcessFilter '   
        SET @securityFilterPredicate = @securityFilterPredicate +  N'AND InAccessibleProcessFilter.DVPR_RowID IS NULL '
    END

    IF ISNULL(@FieldFilterUDSectionDR,0) > 0
    BEGIN
        SET @query = @query + N'
        OUTER APPLY (
            SELECT DVG.DVPR_RowID AS DVPR_ROWID FROM A_ACTRELATIONSHIP ACTREL WITH (NOLOCK) 
            INNER JOIN AX_UDFVALUES WITH (NOLOCK) ON AX_UDFVALUES.UDF_InstanceID = ACTREL.target_ID AND AX_UDFVALUES.SEC_DefinitionID = @fieldFilterUDSectionDR AND AX_UDFVALUES.METACODE_UCSID = @fieldFilterUDFieldDR   
            WHERE ACTREL.source_ID = DVG.DVPR_RowID AND ACTREL.TYPECODE=''COMP'' AND
            (     
                (@fieldFilterUDFieldType=10 AND AX_UDFVALUES.VALUESTRING = @fieldFilterUDFieldValue)  
                OR  
                (@fieldFilterUDFieldType <> 10 AND AX_UDFVALUES.VALUE_UCSID = @fieldFilterUDFieldValueUCSID)     
            ) 
        ) UDFilter '
        SET @securityFilterPredicate = @securityFilterPredicate +  N'AND UDFilter.DVPR_RowID IS NOT NULL '      
    END 

    SET @query = @query + N' 
    OUTER APPLY(
                SELECT DVG.DVPR_RowID as DVPR_RowID FROM [dbo].[A_ActRelationship] ACTREL WITH(NOLOCK) 
                WHERE ACTREL.target_ID = DVG.DVPR_RowID AND ACTREL.[typeCode] = ''DRIV'' AND ACTREL.[metaCode] = ''PR_IncidentDR''  AND ACTREL.[typeCode_OrTx] IS NOT NULL
    ) REL' + @followUpQueryPart
    
    IF @QueryMode = 0
    BEGIN
        SET @query = @query + N'
        LEFT JOIN V_UnifiedCodeSet UCSDisease (nolock) ON UCSDisease.ID = DVG.DVPR_DiseaseCode_ID
        LEFT JOIN V_UnifiedCodeSet UCSPriority (nolock) ON UCSPriority.ID = DVG.DVPR_PriorityDR
        LEFT JOIN T_LanguageCommunication LAN (NOLOCK) ON LAN.ENTITY_ID= DVPER.DVPER_RowID AND LAN.metaCode=''PER_PrimaryLanguage_FK''
        LEFT JOIN V_UnifiedCodeSet UCSLanguage (nolock) ON UCSLanguage.ID = LAN.languageCode_ID '
    END

    SET @query = @query + @filterPredicate + CASE WHEN @securityFilterPredicate <> N'' THEN ' AND (DVG.DVPR_UserDR= @UserId OR 1=1 ' + @securityFilterPredicate + N')' ELSE N'' END

    RETURN @query
END

