CREATE FUNCTION [dbo].[FN_Get_ContactDataQueryForCustomExport]
 (@TblContactSection SystemFormFields READONLY)
RETURNS NVARCHAR(max)
AS
BEGIN
    DECLARE @SQLContact NVARCHAR(max) = ''
    DECLARE @SQLContactUpdate NVARCHAR(max) = ''
    DECLARE @SQLContactExportData NVARCHAR(max) = ''
    IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField_Form = 'CONTACT')
    BEGIN
        SET @SQLContact = ' 
        SELECT TMP.Act_ID, MBR_Role.ID AS MBRRoleID , FOLDER.ID AS FolderID '
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_FirstName')
        BEGIN
            SET @SQLContact = @SQLContact + ', [DV_Person].DVPER_FirstName AS RLENT_FirstName '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_FirstName', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_LastName')
        BEGIN
            SET @SQLContact = @SQLContact + ', [DV_Person].DVPER_LastName AS RLENT_LastName '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_LastName', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_MiddleName')
        BEGIN
            SET @SQLContact = @SQLContact + ', TE.PartMID AS RLENT_MiddleName '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_MiddleName', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_NAMESUFFIX')
        BEGIN
            SET @SQLContact = @SQLContact + ', TE.PARTSFX AS RLENT_NAMESUFFIX '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_NAMESUFFIX', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_DOB')
        BEGIN
            SET @SQLContact = @SQLContact + ', Cast([DV_Person].[DVPER_DOB] As Date) AS RLENT_DOB '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_DOB', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_Age')
        BEGIN
            SET @SQLContact = @SQLContact + ', [dbo].MDF_ATTR_GETINTEGERVALUE_ENTATTR_BYENTITYID([DV_Person].[DVPER_RowID],''PER_Age'') AS [RLENT_Age] '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_Age', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_Sex')
        BEGIN
            SET @SQLContact = @SQLContact + ', dbo.FN_GetUCSFullName([DV_Person].DVPER_SexCode_ID) AS RLENT_Sex '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_Sex', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_Phone')
        BEGIN
            SET @SQLContact = @SQLContact + ', [DV_Person].[DVPER_HomePhone] AS RLENT_Phone '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_Phone', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_StreetAddress')
        BEGIN
            SET @SQLContact = @SQLContact + ', [DV_Person].[DVPER_StreetAddress] AS RLENT_StreetAddress '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_StreetAddress', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_Apartment')
        BEGIN
            SET @SQLContact = @SQLContact + ', [DV_Person].[DVPER_Apartment] AS RLENT_Apartment '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_Apartment', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_City')
        BEGIN
            SET @SQLContact = @SQLContact + ', [DV_Person].[DVPER_City] AS RLENT_City '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_City', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_State')
        BEGIN
            SET @SQLContact = @SQLContact + ', [DV_Person].[DVPER_State] AS RLENT_State '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_State', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_Zip')
        BEGIN
            SET @SQLContact = @SQLContact + ', [DV_Person].[DVPER_Zip] AS RLENT_Zip '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_Zip', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_DistrictDR')
        BEGIN
            SET @SQLContact = @SQLContact + ', dbo.FN_GetUCSFullName([TADistrict].valueCode_ID) AS RLENT_DistrictDR '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_DistrictDR', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_INVESTIGATORDR')
        BEGIN
            SET @SQLContact = @SQLContact + ', CAST(NULL AS VARCHAR(210)) AS RLENT_INVESTIGATORDR '
            SET @SQLContactUpdate = @SQLContactUpdate + ' UPDATE #TMPSystemTable
                SET [RLENT_INVESTIGATORDR] = ISNULL(EName_Investigator.[partFAM]+ '' '', '''')+ISNULL(EName_Investigator.[partGIV], '''')
                FROM 
                #TMPSystemTable
                INNER JOIN [R_RoleLink] RLink_Investigator (nolock) ON  #TMPSystemTable.[MBRRoleID]=RLink_Investigator.[sourceRole_ID] 
                AND (RLink_Investigator.[metaCode] = ''RLENT_InvestigatorDR'' AND RLink_Investigator.[typeCode] = ''REL'')
                INNER JOIN [R_Role] AGNT_Role (nolock) ON  AGNT_Role.[ID]=RLink_Investigator.[targetRole_ID] AND (AGNT_Role.[classCode] = ''AGNT'')
                INNER JOIN [E_Entity] Entity_Investigator (nolock) ON  Entity_Investigator.[ID]=AGNT_Role.[player_ID]
                INNER JOIN [T_EntityName] EName_Investigator (nolock) ON  Entity_Investigator.[ID]=EName_Investigator.[Entity_ID]; '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_InvestigatorDR', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_ReportedRace')
        BEGIN
            SET @SQLContact = @SQLContact + ', dbo.FN_GetUCSFullName([DV_Person].DVPER_RaceCode_ID) AS RLENT_ReportedRace '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_ReportedRace', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_ContactTypeDR')
        BEGIN
            SET @SQLContact = @SQLContact + ', CAST(NULL AS VARCHAR(210)) AS RLENT_ContactTypeDR '
            SET @SQLContactUpdate = @SQLContactUpdate + ' UPDATE #TMPSystemTable
                SET [RLENT_ContactTypeDR] = UCS.FullName
                FROM 
                #TMPSystemTable
                INNER JOIN T_Attribute TAContactType (NOLOCK) ON TAContactType.Role_ID = #TMPSystemTable.[MBRRoleID] AND TAContactType.[Name] = ''RLENT_ContactType''
                INNER JOIN V_UNIFIEDCODESET UCS (NOLOCK) ON UCS.ID = TAContactType.ValueCode_ID ; '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_ContactTypeDR', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_DATESOFCONTACT')
        BEGIN
             SET @SQLContact = @SQLContact + ', Cast(NULL As Date) AS RLENT_DATESOFCONTACT '
            SET @SQLContactUpdate = @SQLContactUpdate + ' UPDATE #TMPSystemTable
                SET [RLENT_DATESOFCONTACT] = Cast(CONDATE.VALUETS As Date)
                FROM #TMPSystemTable
                LEFT JOIN T_ATTRIBUTE CONDATE (NOLOCK) ON #TMPSystemTable.[MBRRoleID] = CONDATE.ROLE_ID AND CONDATE.NAME = ''RLENT_DATESOFCONTACT'' AND CONDATE.TYPE = ''TS'' ; '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_DATESOFCONTACT', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_ExpEventDR')
        BEGIN
            SET @SQLContact = @SQLContact + ', CAST(NULL AS VARCHAR(250)) AS RLENT_ExpEventDR '
            SET @SQLContactUpdate = @SQLContactUpdate + ' UPDATE #TMPSystemTable
                SET [RLENT_ExpEventDR] = LOCNAME.TRIVIALNAME
                FROM #TMPSystemTable
                LEFT JOIN A_ACTRELATIONSHIP (NOLOCK) ON A_ACTRELATIONSHIP.SOURCE_ID= #TMPSystemTable.FolderID AND A_ACTRELATIONSHIP.TypeCode=''PERT''
                LEFT JOIN A_ACT EXPACT (NOLOCK) ON EXPACT.ID=A_ACTRELATIONSHIP.TARGET_ID AND EXPACT.CLASSCODE=''INC'' AND EXPACT.MOODCODE=''EVN'' AND EXPACT.METACODE=''DEE_RowID''
                LEFT JOIN P_PARTICIPATION EXPLOCPART (NOLOCK) ON EXPLOCPART.ACT_ID=EXPACT.ID AND EXPLOCPART.METACODE=''DEE_LaboratoryDR''
                LEFT JOIN R_ROLE EXPLOCROLE (NOLOCK) ON EXPLOCROLE.ID=EXPLOCPART.ROLE_ID
                LEFT JOIN T_ENTITYNAME LOCNAME (NOLOCK) ON  EXPLOCROLE.SCOPER_ID = LOCNAME.ENTITY_ID AND LOCNAME.USECODE = ''SRCH'' AND LOCNAME.METACODE = ''LOC_NAME'' ; '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_ExpEventDR', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_CLUSTERID')
        BEGIN
            SET @SQLContact = @SQLContact + ', CAST(NULL AS VARCHAR(8000)) AS RLENT_CLUSTERID '
            SET @SQLContactUpdate = @SQLContactUpdate + ' UPDATE #TMPSystemTable
                SET [RLENT_CLUSTERID] = ATTR_CLUSTER.VALUESTRING 
                FROM #TMPSystemTable
                LEFT JOIN T_ATTRIBUTE ATTR_CLUSTER (NOLOCK) ON  #TMPSystemTable.FOLDERID = ATTR_CLUSTER.ACT_ID  
                AND ATTR_CLUSTER.NAME = ''RLENT_ClusterID'' AND ATTR_CLUSTER.TYPE = ''ST''  ; '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_CLUSTERID', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_PRIORITYDR')
        BEGIN
            SET @SQLContact = @SQLContact + ', CAST(NULL AS VARCHAR(255)) AS RLENT_PRIORITYDR '
            SET @SQLContactUpdate = @SQLContactUpdate + ' UPDATE #TMPSystemTable
                SET [RLENT_PRIORITYDR] = UCSPRIORITY.FULLNAME 
                FROM #TMPSystemTable
                INNER JOIN T_ATTRIBUTE PRIODR (NOLOCK) ON #TMPSystemTable.MBRRoleID= PRIODR.Role_ID AND PRIODR.NAME=''RLENT_Priority'' AND PRIODR.TYPE=''CV''
                INNER JOIN V_UNIFIEDCODESET UCSPRIORITY (NOLOCK) ON PRIODR.ValueCode_ID=UCSPRIORITY.ID   ; '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_PRIORITYDR', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_STATUSDR')
        BEGIN
            SET @SQLContact = @SQLContact + ', CAST(NULL AS VARCHAR(255)) AS RLENT_STATUSDR '
            SET @SQLContactUpdate = @SQLContactUpdate + ' UPDATE #TMPSystemTable
                SET [RLENT_STATUSDR] = UCSSTATUS.FULLNAME 
                FROM #TMPSystemTable
                INNER JOIN T_ATTRIBUTE ATTR_STATUS (NOLOCK) ON  #TMPSystemTable.FOLDERID = ATTR_STATUS.ACT_ID 
                AND ATTR_STATUS.NAME = ''RLENT_StatusDR'' AND ATTR_STATUS.TYPE = ''CV''
                INNER JOIN V_UNIFIEDCODESET UCSSTATUS (NOLOCK) ON  ATTR_STATUS.VALUECODE_ID = UCSSTATUS.ID     ; '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_STATUSDR', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_PROPHYLAXISMEDICATION')
        BEGIN
            SET @SQLContact = @SQLContact + ', CAST(NULL AS VARCHAR(MAX)) AS RLENT_PROPHYLAXISMEDICATION '
            SET @SQLContactUpdate = @SQLContactUpdate + ' UPDATE #TMPSystemTable
                SET [RLENT_PROPHYLAXISMEDICATION] = SBADM.[TEXT]
                FROM #TMPSystemTable
                INNER JOIN A_ACT SBADM (NOLOCK) ON #TMPSystemTable.FOLDERID = SBADM.ACT_PARENT_ID AND SBADM.CLASSCODE = ''SBADM'' 
                AND SBADM.METACODE = ''RLENT_PROPHYLAXISMEDICATION''  ; '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_PROPHYLAXISMEDICATION', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_EMAIL')
        BEGIN
            SET @SQLContact = @SQLContact + ', [DV_Person].[DVPER_EmailID] AS RLENT_EMAIL '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_EMAIL', 'MBRRoleID')
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_ELECTRONICCONTACT')
        BEGIN
            SET @SQLContact = @SQLContact + ', [DV_Person].[DVPER_ElectronicContact] AS RLENT_ELECTRONICCONTACT '
            SET @SQLContactExportData = @SQLContactExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Contact', 'RLENT_ELECTRONICCONTACT', 'MBRRoleID')
        END

        SET @SQLContact = @SQLContact + ' INTO #TMPSystemTable 
        FROM #tmp_DI_UDVals_temp TMP (NOLOCK)
        LEFT JOIN [P_Participation] IND_PART (nolock) ON TMP.Act_ID = IND_PART.Act_ID AND (IND_PART.[typeCode] = ''IND'')
        LEFT JOIN [R_Role] EXPR_Role (nolock) ON EXPR_Role.[ID]=IND_PART.[Role_ID] AND  (EXPR_Role.[classCode] = ''EXPR'')
        LEFT JOIN [E_Entity] Entity_QuantifiedKind (nolock) ON Entity_QuantifiedKind.[ID]=EXPR_Role.[player_ID] AND (Entity_QuantifiedKind.[classCode] = ''ENT'') 
        LEFT JOIN [R_Role] MBR_Role (nolock) ON Entity_QuantifiedKind.[ID]=MBR_Role.[scoper_ID] AND (MBR_Role.[classCode] = ''MBR'' AND MBR_Role.[statusCode] <> ''nullified'' 
        AND MBR_Role.[statusCode] <> ''terminated'')        
        LEFT JOIN [DV_Person] (nolock) ON MBR_Role.[player_ID]=[DV_Person].[DVPER_RowID] 
        LEFT JOIN P_PARTICIPATION SBJ (NOLOCK) ON SBJ.[Role_ID] = [MBR_Role].[ID] AND SBJ.TYPECODE = ''SBJ'' 
        LEFT JOIN A_ACT FOLDER (NOLOCK) ON SBJ.ACT_ID = FOLDER.ID AND FOLDER.CLASSCODE = ''FOLDER''   ' 
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField IN ('RLENT_MiddleName','RLENT_NAMESUFFIX'))
        BEGIN
            SET @SQLContact = @SQLContact + ' LEFT JOIN T_EntityName TE (NOLOCK) ON TE.[Entity_ID] = [DV_Person].[DVPER_RowID] '
        END
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_DistrictDR')
        BEGIN
            SET @SQLContact = @SQLContact + ' LEFT JOIN T_Attribute TADistrict (NOLOCK) ON TADistrict.[Act_ID] = [SBJ].[Act_ID] AND TADistrict.Name = ''RLENT_DistrictDR'' '
        END
        SET @SQLContact = @SQLContact + @SQLContactUpdate + @SQLContactExportData
        IF EXISTS (SELECT * FROM @TblContactSection WHERE LinkedSystemField = 'RLENT_RaceCategory')
        BEGIN
            SET @SQLContact = @SQLContact + ' SELECT [V_UnifiedCodeSet].[ID] AS [RACECAT_RowID], 
        [V_UnifiedCodeSet].[fullName] AS [RACECAT_Name], 
        [V_TermDictionary].[termDisplay] AS [RACECAT_DisplayName], 
        CASE WHEN ([V_TermDictionary].[termOrder] IS NULL OR [V_TermDictionary].[termOrder] < 0) THEN ''100000000.000'' 
            ELSE [V_TermDictionary].[termOrder] END AS [RaceCategoryOrder] 
        INTO #tmp_dicRace
        FROM 
        [V_Domain] (nolock) 
        INNER JOIN [V_UnifiedCodeSet] (nolock) ON  [V_Domain].[ID]=[V_UnifiedCodeSet].[domain_ID] 
            AND domainOid = ''2.16.840.1.113883.3.33.4.2.2.5.715'' and domainName = ''RaceCategory''
        LEFT JOIN [V_TermDictionary] (nolock) ON  [V_UnifiedCodeSet].[ID]=[V_TermDictionary].[termCode_ID] AND [V_TermDictionary].[name] = ''RACECATEGORY''
        LEFT JOIN [V_CodeProperty] [LPA_C1] (nolock) ON  [V_UnifiedCodeSet].[ID]=[LPA_C1].[valueCode_ID] 
        LEFT JOIN [V_UnifiedCodeSet] [LPA_U2] (nolock) ON  [LPA_U2].[ID]=[LPA_C1].[subjCode_ID] AND [LPA_U2].[conceptCode] <> ''MUL''
        WHERE [V_TermDictionary].[active] = ''1''
        GROUP BY [V_UnifiedCodeSet].[ID], [V_UnifiedCodeSet].[fullName], [V_TermDictionary].[termDisplay], 
            (CASE WHEN [V_TermDictionary].[active] = ''1'' THEN 1 ELSE 0 END) , CASE WHEN ([V_TermDictionary].[termOrder] IS NULL OR [V_TermDictionary].[termOrder] < 0) 
            THEN ''100000000.000'' ELSE [V_TermDictionary].[termOrder] END 
        ORDER BY [RaceCategoryOrder] ASC,[V_UnifiedCodeSet].[fullName] ASC 
        '

            SET @SQLContact = @SQLContact + ' SELECT DISTINCT [T_Race].[ID] AS [PMR_RowID], 
            CASE [T_Race].[metaCode] WHEN ''PER_MultipleRaceDR'' THEN [V_UnifiedCodeSet].[ID] END AS [PMR_MultipleRaceDR], 
            CASE [T_Race].[metaCode] WHEN ''PER_MultipleRaceDR'' THEN [LPA_U1].[ID] ELSE [V_UnifiedCodeSet].[ID] END AS [PMR_RaceCategoryDR], 
            CASE [T_Race].[metaCode] WHEN ''PER_MultipleRaceDR'' THEN [V_UnifiedCodeSet].[fullName] END AS [PMR_MultipleRace], 
            CASE [T_Race].[metaCode] WHEN ''PER_MultipleRaceDR'' THEN [LPA_U1].[fullName] 
                ELSE ( SELECT termDisplay FROM V_TermDictionary (NOLOCK) WHERE TermCode_ID = [V_UnifiedCodeSet].[ID] AND V_TermDictionary.Name = ''RaceCategory'') END AS [PMR_RaceCategory], TMP.Act_ID,
            [T_Race].[Entity_ID] AS [PMR_PersonDR], 
            CASE WHEN ([V_TermDictionary].[termOrder] IS NULL OR [V_TermDictionary].[termOrder] < 0) THEN ''100000000.000'' ELSE [V_TermDictionary].[termOrder] END AS [RaceOrder] '

            SET @SQLContact = @SQLContact + ' INTO #TMP_DiRLENTRace 
            FROM #tmp_DI_UDVals_temp TMP (NOLOCK)
            LEFT JOIN [P_Participation] IND_PART (nolock) ON TMP.Act_ID = IND_PART.Act_ID AND (IND_PART.[typeCode] = ''IND'')
            LEFT JOIN [R_Role] EXPR_Role (nolock) ON EXPR_Role.[ID]=IND_PART.[Role_ID] AND  (EXPR_Role.[classCode] = ''EXPR'')
            LEFT JOIN [E_Entity] Entity_QuantifiedKind (nolock) ON Entity_QuantifiedKind.[ID]=EXPR_Role.[player_ID] AND (Entity_QuantifiedKind.[classCode] = ''ENT'') 
            LEFT JOIN [R_Role] MBR_Role (nolock) ON Entity_QuantifiedKind.[ID]=MBR_Role.[scoper_ID] AND (MBR_Role.[classCode] = ''MBR'' AND MBR_Role.[statusCode] <> ''nullified'' 
            AND MBR_Role.[statusCode] <> ''terminated'')        
            LEFT JOIN [DV_Person] [LPA_D2] (nolock) ON MBR_Role.[player_ID]=[LPA_D2].[DVPER_RowID]  
            LEFT JOIN [T_Race] (nolock) ON [T_Race].[Entity_ID] = [LPA_D2].[DVPER_RowID]
            LEFT JOIN [V_UnifiedCodeSet] (nolock) ON  [V_UnifiedCodeSet].[ID]=[T_Race].[raceCode_ID]
            LEFT JOIN [V_TermDictionary] (nolock) ON  [V_UnifiedCodeSet].[ID]=[V_TermDictionary].[termCode_ID] 
            LEFT JOIN [V_CodeProperty] (nolock) ON  [V_CodeProperty].[subjCode_ID]=[T_Race].[raceCode_ID] AND ( ( [V_CodeProperty].[property] = ''Race_CategoryDR'')) 
            LEFT JOIN [V_UnifiedCodeSet] [LPA_U1] (nolock) ON  [LPA_U1].[ID]=[V_CodeProperty].[valueCode_ID]    
            WHERE ( [T_Race].[metaCode] IN (''PER_MultipleRaceDR'', ''PER_RaceCategoryDR''))  '
        

            SET @SQLContact = @SQLContact + ' INSERT INTO #tmpExportData 
            SELECT Act_ID, ColName + ''~'' + RIGHT(''000'' + CAST(convert(varchar(10),dense_rank() over (partition by Act_ID order by PMR_PersonDR)) AS VARCHAR(4)) , 3)  
            AS ColName, FIELD_VALUE
            FROM (
            SELECT Act_ID,PMR_PersonDR, ''RLENT_RaceCategory_'' + D.RACECAT_DisplayName  AS COLName,
             CASE WHEN D.RACECAT_RowID = A.PMR_RaceCategoryDR THEN FIELD_VALUE ELSE 0 END AS FIELD_VALUE
             FROM #tmp_dicRace D
            CROSS JOIN
            (SELECT P.Act_ID AS Act_ID, PMR_PersonDR,
            ''PER_RaceCategory_'' + P.PMR_RaceCategory as ColName, PMR_RaceCategoryDR,
            CASE WHEN P.Act_ID IS NULL THEN 0 ELSE 1 END AS FIELD_VALUE
            FROM  #TMP_DiRLENTRace P
            GROUP BY P.Act_ID, P.PMR_PersonDR, P.PMR_RaceCategory, P.PMR_RaceCategoryDR) A
            ) B '

            SET @SQLContact = @SQLContact + ' INSERT INTO #tmpExportData            
            SELECT Act_ID, ColName + ''~'' + RIGHT(''000'' + CAST(convert(varchar(10),dense_rank() over 
            (partition by Act_ID order by PMR_PersonDR)) AS VARCHAR(4)) , 3)  AS ColName, FIELD_VALUE
            FROM (
            SELECT Act_ID,PMR_PersonDR, ''RLENT_RaceCategory_'' + D.RACECAT_DisplayName  + ''_Specify'' AS COLName,
             CASE WHEN D.RACECAT_RowID = A.PMR_RaceCategoryDR THEN FIELD_VALUE ELSE NULL END AS FIELD_VALUE
             FROM #tmp_dicRace D
            CROSS JOIN
            (SELECT P.Act_ID AS Act_ID, PMR_PersonDR,
            ''PER_RaceCategory_'' + P.PMR_RaceCategory as ColName, PMR_RaceCategoryDR,
            dbo.STRCONCAT(P.PMR_MultipleRace) AS FIELD_VALUE 
            FROM  #TMP_DiRLENTRace P
            GROUP BY P.Act_ID, P.PMR_PersonDR, P.PMR_RaceCategory, P.PMR_RaceCategoryDR) A
            ) B '
        END
    END
    RETURN @SQLContact
END

