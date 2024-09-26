

CREATE   FUNCTION [dbo].[FN_Get_DynamicQuery_ForSystemFormFields]
 (@TblSystemDefinedFieldLinks SystemFormFields READONLY, @RECORDTYPE AS VARCHAR(20), @TableExtension as VARCHAR(20))
RETURNS NVARCHAR(max)
AS
BEGIN

DECLARE @SqlSysDefinedField AS NVARCHAR(max)

IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField_Form = 'DiPat')
BEGIN

    SET @SqlSysDefinedField = ' SELECT DISTINCT [LPA_D2].[DVPER_RowID] AS [PER_RowID],  '
    IF @RECORDTYPE = 'DI' OR @RECORDTYPE = 'CI'
    BEGIN
        SET @SqlSysDefinedField = @SqlSysDefinedField + '  #tmp_DI_UDVals_temp.Act_ID AS DVPR_RowID, [LPA_D4].[DVPR_IncidentID] AS Incident_ID '      
    END
    ELSE 
    BEGIN
        SET @SqlSysDefinedField = @SqlSysDefinedField + '  PH_CASEACT.ID AS DVPR_RowID  '      
    END
    SET @SqlSysDefinedField = @SqlSysDefinedField + '  , [LPA_D2].[DVPER_NCMID] AS Client_ID '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_Apartment')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_Apartment] AS [PER_Apartment] '
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_LastName')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_LastName] AS [PER_LastName] '
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_FirstName')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_FirstName] AS [PER_FirstName] '
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_SSN')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_SSN] AS [PER_SSN] '
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_DOB')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_DOB] AS [PER_DOB] '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_StreetAddress')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_StreetAddress] AS [PER_StreetAddress] '      
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_City')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_City] AS [PER_City] '        

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_State')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_State] AS [PER_State] '      

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_Zip')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_Zip] AS [PER_Zip] '          

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_CensusTract')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_CensusTract] AS [PER_CensusTract] '  
            
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_CensusBlock')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', CASE WHEN [LPA_D2].[DVPER_RowID]=[LPA_D2].[DVPER_RootID] THEN [LPA_I11].[PARTCENBLOCK] 
        ELSE [LPA_P12].[PARTCENBLOCK] END AS [PER_CensusBlock] '     
                 
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_AddressStandardized')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', CASE WHEN [LPA_D2].[DVPER_RowID]=[LPA_D2].[DVPER_RootID] THEN [LPA_I11].[USECODE_ORTX] 
        ELSE [LPA_P12].[USECODE_ORTX] END AS [PER_AddressStandardized] '    
             
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_COUNTY')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', CASE WHEN [LPA_D2].[DVPER_RowID]=[LPA_D2].[DVPER_RootID] THEN [LPA_I11].[PARTCOUNTY] 
        ELSE [LPA_P12].[PARTCOUNTY] END AS [PER_COUNTY] '  

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_CountyFIPS')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', CASE WHEN [LPA_D2].[DVPER_RowID]=[LPA_D2].[DVPER_RootID] THEN [LPA_I11].[PARTCOUNTYFIPS] 
        ELSE [LPA_P12].[PARTCOUNTYFIPS] END AS [PER_CountyFIPS] '  

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_Latitude')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', CASE WHEN [LPA_D2].[DVPER_RowID]=[LPA_D2].[DVPER_RootID] THEN [LPA_I11].[PARTGEOLAT] 
        ELSE [LPA_P12].[PARTGEOLAT] END AS [PER_Latitude] '  

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_Longitude')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', CASE WHEN [LPA_D2].[DVPER_RowID]=[LPA_D2].[DVPER_RootID] THEN [LPA_I11].[PARTGEOLONG] 
        ELSE [LPA_P12].[PARTGEOLONG] END AS [PER_Longitude] '  

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_ZIPPLUS4')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', CASE WHEN [LPA_D2].[DVPER_RowID]=[LPA_D2].[DVPER_RootID] THEN [LPA_I11].[PARTZIPPLUS4] 
        ELSE [LPA_P12].[PARTZIPPLUS4] END AS [PER_ZIPPLUS4] '  

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_HomePhone')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_HomePhone] AS [PER_HomePhone] '      

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_CellPhone')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_CellPhone] AS [PER_CellPhone] '
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_WorkSchoolPhone')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_WorkSchoolPhone] AS [PER_WorkSchoolPhone] ' 

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_WorkSchoolContact')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_WorkSchoolContact] AS [PER_WorkSchoolContact] '  

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_WorkSchoolLocation')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', SCHOOL_LOC_NAME.TRIVIALNAME AS [PER_WorkSchoolLocation] '  
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_SexText')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName]([LPA_D2].[DVPER_SexCode_ID]) AS [PER_SexText] '    
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_MaritalStatus')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName]([LPA_D2].[DVPER_MaritalStatusCode_ID]) AS [PER_MaritalStatus] '    
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_OccupationSettingType')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName]([LPA_D2].[DVPER_OccupationSettingTypeDR]) AS [PER_OccupationSettingType] ' 
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_OccupationSettingTypeSpecify')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_OccupationSettingTypeSpecify] AS [PER_OccupationSettingTypeSpecify] '        
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_Occupation')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName]([LPA_D2].[DVPER_OccupationCode_ID]) AS [PER_Occupation] '  

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_OccupationSpecify')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_OccupationSpecify] AS [PER_OccupationSpecify] '  

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_OccupationLocation')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_OccupationLocation] AS [PER_OccupationLocation] '    

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_Ethnicity')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName]([LPA_D2].[DVPER_EthnicityCode_ID]) AS [PER_Ethnicity] '            

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_PrimaryNationality')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName]([LPA_D2].[DVPER_PrimaryNationalityDR]) AS [PER_PrimaryNationality] '   
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_GuardianName')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_GuardianName] AS [PER_GuardianName] '    
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_Email')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_EmailID] AS [PER_Email] '
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_ElectronicContact')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_ElectronicContact] AS [PER_ElectronicContact]  '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField IN ('PER_Race', 'PER_RACECATEGORY', 'PER_RACECATEGORYANDRACE', 'PER_REPORTEDRACE'))
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName]([LPA_D2].[DVPER_RaceCode_ID]) AS [PER_ReportedRace]  '
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_MiddleName')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', CASE WHEN [LPA_E1].[ID] <> [LPA_S7].[Entity2_ID] THEN [LPA_I9].[partMID] ELSE [LPA_P10].[partMID] END AS [PER_MiddleName] '
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_NameSuffix')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', CASE WHEN [LPA_E1].[ID] <> [LPA_S7].[Entity2_ID] THEN [LPA_I9].[partSfx] ELSE [LPA_P10].[partSfx] END AS [PER_NameSuffix] '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_ThirdName')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', CASE WHEN [LPA_E1].[ID] <> [LPA_S7].[Entity2_ID] THEN [LPA_I9].[partThird] ELSE [LPA_P10].[partThird] END AS [PER_ThirdName] '
           
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_FourthName')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', CASE WHEN [LPA_E1].[ID] <> [LPA_S7].[Entity2_ID] THEN [LPA_I9].[partFourth] ELSE [LPA_P10].[partFourth] END AS [PER_FourthName] '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_NamePrefix')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', CASE WHEN [LPA_E1].[ID] <> [LPA_S7].[Entity2_ID] THEN [LPA_I9].[partPrefix] ELSE [LPA_P10].[partPrefix] END AS [PER_NamePrefix] '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_ResidenceCounty')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName]([LPA_D2].[DVPER_ResidenceCountyDR]) AS [PER_ResidenceCounty] '     
        
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_CountryText')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName](CASE WHEN [LPA_D2].[DVPER_RowID]=[LPA_D2].[DVPER_RootID] THEN [LPA_I11].[partCountry] ELSE [LPA_P12].[partCountry] END) AS [PER_CountryText] '     
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_CountryOfBirth')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName]([LPA_P18].[partCountry]) AS [PER_CountryOfBirth] '     

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_DateOfUSArrival')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_DateOfUSArrival]  AS [PER_DateOfUSArrival] '      

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_PrimaryLanguage')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName]([LPA_P17].[languageCode_ID]) AS [PER_PrimaryLanguage] '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_CDCGenderCode')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_C31].[conceptCode] AS [PER_CDCGenderCode] ' 
            
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_DiseaseName')
        IF @RECORDTYPE = ''
            SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName]([PH_CASEACT].[Code_ID])  AS [PR_DiseaseName] '
        ELSE IF @RECORDTYPE = 'CR'
            SET @SqlSysDefinedField = @SqlSysDefinedField + ', ''''  AS [PR_DiseaseName] '
        ELSE
            SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName]([LPA_D4].[DVPR_DiseaseCode_ID])  AS [PR_DiseaseName] '
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'DiseaseGroups')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].FN_DiseaseGroups([LPA_D4].[DVPR_DiseaseCode_ID]) AS [DiseaseGroups] '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_DiseaseShortName')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', UCSShortName.SHORTNAME AS [PR_DiseaseShortName] '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_StandardAge')
        IF @RECORDTYPE = ''
            SET @SqlSysDefinedField = @SqlSysDefinedField + ', CASE WHEN ISNULL(PHCASEAge.AgeReported,'''')='''' THEN CASE WHEN (DATEDIFF(yy, [LPA_D2].[DVPER_DOB], GETDATE())) = 0 THEN ''0'' ELSE  (DATEDIFF(yy, [LPA_D2].[DVPER_DOB], GETDATE()) - 1) END ELSE PHCASEAge.AgeReported END AS [PR_StandardAge] '
        ELSE IF @RECORDTYPE = 'CR'
            SET @SqlSysDefinedField = @SqlSysDefinedField + ', ''''  AS [PR_StandardAge] '
        ELSE
            SET @SqlSysDefinedField = @SqlSysDefinedField + ', CASE WHEN ISNULL([LPA_D4].[DVPR_StandardAge],'''')='''' THEN CASE WHEN (DATEDIFF(yy, [LPA_D2].[DVPER_DOB], GETDATE())) = 0 THEN ''0'' ELSE  (DATEDIFF(yy, [LPA_D2].[DVPER_DOB], GETDATE()) - 1) END ELSE [LPA_D4].[DVPR_StandardAge] END AS [PR_StandardAge] '
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_MedRecNum')
        IF @RECORDTYPE = ''
            SET @SqlSysDefinedField = @SqlSysDefinedField + ', CASE WHEN II3.EXTENSION IS NULL THEN '''' ELSE II3.EXTENSION END AS [PR_MedRecNum]  '
        ELSE IF @RECORDTYPE = 'CR'
            SET @SqlSysDefinedField = @SqlSysDefinedField + ', ''''  AS [PR_MedRecNum]  '
        ELSE
            SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D4].[DVPR_MRN] AS [PR_MedRecNum] '
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_StandardAgeMonths')
        IF @RECORDTYPE <> 'CR'
             SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_A32].[valueString] AS [PR_StandardAgeMonths] '  
        ELSE
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', ''''  AS [PR_StandardAgeMonths] '
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_StandardAgeDays')
        IF @RECORDTYPE <> 'CR'
            SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_A33].[valueString] AS [PR_StandardAgeDays] '    
       ELSE 
       SET @SqlSysDefinedField = @SqlSysDefinedField + ', ''''  AS [PR_StandardAgeDays] '
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_IsPregnant' and LinkedSystemField_Form = 'DiPat')
        IF @RECORDTYPE = ''
            SET @SqlSysDefinedField = @SqlSysDefinedField + ', [OBSACT1].[valueBool]  AS [PR_IsPregnant] '
        ELSE IF @RECORDTYPE = 'CR'
            SET @SqlSysDefinedField = @SqlSysDefinedField + ', ''''  AS [PR_IsPregnant] '
        ELSE
            SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D4].[DVPR_ISPREGNANT]   AS [PR_IsPregnant] '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_CMRRECORD')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D4].[DVPR_CMRID] AS [PR_CMRRECORD] '  

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_ExpectedDeliveryDate') 
        IF @RECORDTYPE = ''
            SET @SqlSysDefinedField = @SqlSysDefinedField + ', [OBSACT2].[valueTS] AS [PR_ExpectedDeliveryDate] '
        ELSE IF @RECORDTYPE = 'CR'
            SET @SqlSysDefinedField = @SqlSysDefinedField + ', NULL  AS [PR_ExpectedDeliveryDate] '
        ELSE
            SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D4].[DVPR_EXPECTEDDELIVERYDATE] AS [PR_ExpectedDeliveryDate] '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_OtherDiseaseName')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [ACT_OTHERDISEASE].[VALUESTRING_TXT] AS [PR_OtherDiseaseName] '  

    --KR TASK#23668
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_DOD')  
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [LPA_D2].[DVPER_DOD] AS [PER_DOD] '  

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_DeceasedStatus')  
    SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName]([LPA_D2].[DVPER_DeceasedStatusDR]) AS [PER_DeceasedStatus] '   

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_StatusFlag')  
    SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName]([LPA_D2].[DVPER_StatusFlagDR]) AS [PER_StatusFlag] '   
    --KR TASK#23668

    SET @SqlSysDefinedField = @SqlSysDefinedField + '
        INTO #TMP_DiPAT' + @TableExtension + ' 
        FROM 
        [E_Entity] [LPA_E1] (nolock) 
        INNER JOIN [DV_Person] [LPA_D2] (nolock) ON  [LPA_E1].[ID]=[LPA_D2].[DVPER_RowID] '
      
    SET @SqlSysDefinedField = @SqlSysDefinedField + '
        INNER JOIN [S_Link] [LPA_S3] (nolock) ON  [LPA_E1].[ID]=[LPA_S3].[Entity2_ID] 
        INNER JOIN [E_Person] [LPA_E5] (nolock) ON  [LPA_E1].[ID]=[LPA_E5].[ID] 
        INNER JOIN [E_Entity] [LPA_E6] (nolock) ON  [LPA_E6].[ID]=[LPA_E1].[EntityHx_ID]
        INNER JOIN [S_Link] [LPA_S7] (nolock) ON  [LPA_E6].[ID]=[LPA_S7].[Entity1_ID] AND [LPA_S7].[name] = ''Person-Primary'' '


    IF OBJECT_ID('tempdb..#tmp_CR_UDVals_temp') IS NULL
    BEGIN    
        IF @RECORDTYPE <> 'CR' AND @RECORDTYPE <> ''
        BEGIN
            SET @SqlSysDefinedField = @SqlSysDefinedField + '
                INNER JOIN [DV_PHPersonalRecord] [LPA_D4] (nolock) ON  [LPA_D2].[DVPER_RowID]=[LPA_D4].[DVPR_PersonDR] 
                INNER JOIN #tmp_DI_UDVals_temp ON #tmp_DI_UDVals_temp.Act_ID = [LPA_D4].[DVPR_ROWID]  '
        END
        ELSE
        BEGIN
            SET @SqlSysDefinedField = @SqlSysDefinedField + ' 
                INNER JOIN R_Role RolePlayer (NOLOCK) ON RolePlayer.Player_ID=[LPA_D2].[DVPER_RowID] AND RolePlayer.CLASSCODE=''PAT'' 
                    AND RolePlayer.statusCode <> ''nullified'' AND RolePlayer.statusCode <> ''terminated''
                INNER JOIN P_Participation Participation (NOLOCK) ON Participation.Role_ID = RolePlayer.ID  AND Participation.TypeCode=''SBJ''
                INNER JOIN A_Act PH_CASEACT (NOLOCK) ON PH_CASEACT.Act_Parent_ID = Participation.Act_ID AND PH_CASEACT.Metacode = ''PR_RowID'' AND PH_CASEACT.classCode = ''CASE''  AND PH_CASEACT.statusCode <> ''nullified'' AND PH_CASEACT.statusCode <> ''terminated''  
                INNER JOIN #tmp_DI_UDVals_temp ON #tmp_DI_UDVals_temp.Act_ID = PH_CASEACT.ID '
            
                IF @RECORDTYPE = 'CR'
                    SET @SqlSysDefinedField = @SqlSysDefinedField + ' 
                        INNER JOIN A_PUBLICHEALTHCASE PHCASE (NOLOCK) ON PH_CASEACT.ID = PHCASE.ID 
                        INNER JOIN V_UnifiedCodeSet VUCS (NOLOCK) ON VUCS.ID = PHCASE.phRecordTypeCode_ID AND VUCS.ConceptCode = ''CR'' '
        END
    END
    ELSE
    BEGIN
        SET @SqlSysDefinedField = @SqlSysDefinedField + '
                INNER JOIN #tmp_CR_UDVals_temp ON #tmp_CR_UDVals_temp.EntityID = [LPA_D2].[DVPER_RowID]  
                LEFT JOIN ( SELECT RolePlayer.Player_ID, PH_CASEACT.ID FROM R_Role RolePlayer (NOLOCK) 
                    INNER JOIN P_Participation Participation (NOLOCK) ON Participation.Role_ID = RolePlayer.ID  AND Participation.TypeCode=''SBJ''
                        AND RolePlayer.CLASSCODE=''PAT'' AND RolePlayer.statusCode <> ''nullified'' AND RolePlayer.statusCode <> ''terminated''
                    INNER JOIN A_Act PH_CASEACT (NOLOCK) ON PH_CASEACT.Act_Parent_ID = Participation.Act_ID AND PH_CASEACT.Metacode = ''PR_RowID''
                        AND PH_CASEACT.classCode = ''CASE'' AND PH_CASEACT.statusCode <> ''nullified'' AND PH_CASEACT.statusCode <> ''terminated''
                    INNER JOIN A_PUBLICHEALTHCASE PHCASE (NOLOCK) ON PH_CASEACT.ID = PHCASE.ID 
                    INNER JOIN V_UnifiedCodeSet VUCS (NOLOCK) ON VUCS.ID = PHCASE.phRecordTypeCode_ID AND VUCS.ConceptCode = ''CR'' 
                ) PH_CASEACT ON [LPA_D2].[DVPER_RowID] = PH_CASEACT.player_ID '
    END
    IF @RECORDTYPE <> 'CR'
    BEGIN
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField IN ('PR_StandardAgeMonths', 'PR_StandardAgeDays'))
    BEGIN
    SET @SqlSysDefinedField = @SqlSysDefinedField + '
        LEFT JOIN [A_Act] [LPA_A32] (nolock) ON  #tmp_DI_UDVals_temp.Act_ID=[LPA_A32].[Act_Parent_ID] AND [LPA_A32].[classCode] = ''OBS'' AND [LPA_A32].[moodCode] = ''EVN'' AND [LPA_A32].[metaCode] = ''PR_StandardAgeMonths''
        LEFT JOIN [A_Act] [LPA_A33] (nolock) ON  #tmp_DI_UDVals_temp.Act_ID=[LPA_A33].[Act_Parent_ID] AND [LPA_A33].[classCode] = ''OBS'' AND [LPA_A33].[moodCode] = ''EVN'' AND [LPA_A33].[metaCode] = ''PR_StandardAgeDays'' '
    END
    END

    IF @RECORDTYPE = ''
    BEGIN    
        IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_IsPregnant' AND LinkedSystemField_Form = 'DiPat')
            SET @SqlSysDefinedField = @SqlSysDefinedField + '
                LEFT JOIN [A_Act] [OBSACT1] (nolock) ON  [OBSACT1].[Act_Parent_ID]=PH_CASEACT.ID AND [OBSACT1].[classCode] = ''OBS'' AND [OBSACT1].[metaCode] = ''PR_IsPregnant'' AND  [OBSACT1].moodCode=''EVN'' '
        
         IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_ExpectedDeliveryDate')
            SET @SqlSysDefinedField = @SqlSysDefinedField + '
                LEFT JOIN [A_Act] [OBSACT2] (nolock) ON  [OBSACT2].[Act_Parent_ID]=PH_CASEACT.ID AND [OBSACT2].[classCode] = ''OBS'' AND [OBSACT2].[metaCode] = ''PR_ExpectedDeliveryDate'' AND  [OBSACT2].moodCode=''EVN'' '       
                    
         IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_MedRecNum')
          SET @SqlSysDefinedField = @SqlSysDefinedField + ' 
            LEFT JOIN R_Role R3 (nolock) ON R3.PLAYER_ID=[LPA_D2].[DVPER_RowID] AND R3.classCode=''PAT'' AND R3.statusCode <> ''TERMINATED'' 
            AND R3.statusCode <> ''NULLIFIED''
            LEFT JOIN P_Participation PartMRN (nolock) ON #tmp_DI_UDVals_temp.Act_ID=PartMRN.ACT_ID AND PartMRN.typeCode=''REFB'' AND PartMRN.metaCode=''PR_MRNReportSourceDR''   
            LEFT JOIN R_Role RoleMRN (nolock) ON PartMRN.ROLE_ID=RoleMRN.ID AND RoleMRN.classCode=''QUAL''
            LEFT JOIN T_InstanceIdentifier II3 (nolock) ON R3.ID=II3.ROLE_ID AND RoleMRN.PLAYER_ID=II3.ENTITY_ID AND II3.metaCode=''PER_MedRecNum'' '
              
         IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_StandardAge')
            SET @SqlSysDefinedField = @SqlSysDefinedField + '
                 INNER JOIN A_PUBLICHEALTHCASE PHCASEAge (NOLOCK) ON PH_CASEACT.ID = PHCASEAge.ID '
    END
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField IN ('PER_MiddleName', 'PER_NameSuffix','PER_ThirdName','PER_FourthName','PER_NamePrefix'))
        SET @SqlSysDefinedField = @SqlSysDefinedField + '
            LEFT JOIN [T_EntityName] [LPA_I9] (nolock) ON  [LPA_E6].[ID]=[LPA_I9].[Entity_ID] AND [LPA_I9].[useCode] = ''L'' 
            LEFT JOIN [T_EntityName] [LPA_P10] (nolock) ON  [LPA_E1].[ID]=[LPA_P10].[Entity_ID] AND [LPA_P10].[useCode] = ''L'' '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField IN 
    ('PER_CountryText','PER_CensusBlock','PER_AddressStandardized','PER_County','PER_CountyFIPS','PER_Latitude','PER_Longitude','PER_ZipPlus4'))
        SET @SqlSysDefinedField = @SqlSysDefinedField + '
            LEFT JOIN [T_EntityAddress] [LPA_I11] (nolock) ON  [LPA_I11].[ID]=[LPA_S7].[tAddress1_ID] AND [LPA_I11].[useCode] = ''H''
            LEFT JOIN [T_EntityAddress] [LPA_P12] (nolock) ON  [LPA_E1].[ID]=[LPA_P12].[Entity_ID] AND [LPA_P12].[useCode] = ''H'' '
                
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField IN ('PER_PrimaryLanguage'))
        SET @SqlSysDefinedField = @SqlSysDefinedField + '
            LEFT JOIN [T_LanguageCommunication] [LPA_P17] (nolock) ON  [LPA_E1].[ID]=[LPA_P17].[Entity_ID] AND [LPA_P17].[metaCode] = ''PER_PrimaryLanguage_FK'' '
       
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField IN ('PER_WorkSchoolLocation'))
        SET @SqlSysDefinedField = @SqlSysDefinedField + '
        LEFT JOIN R_ROLE(NOLOCK) R_LOCE ON R_LOCE.player_id=[LPA_E1].[ID] AND R_LOCE.classCode=''LOCE'' AND R_LOCE.metaCode=''PER_WorkSchoolLocationDR''
        LEFT JOIN T_ENTITYNAME(NOLOCK) SCHOOL_LOC_NAME ON R_LOCE.Scoper_ID=SCHOOL_LOC_NAME.Entity_ID AND SCHOOL_LOC_NAME.metaCode=''LOC_Name'' AND 
        SCHOOL_LOC_NAME.useCode=''SRCH''  '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField IN ('PER_CountryOfBirth'))
        SET @SqlSysDefinedField = @SqlSysDefinedField + '
            LEFT JOIN [T_EntityAddress] [LPA_P18] (nolock) ON  [LPA_E1].[ID]=[LPA_P18].[Entity_ID] AND [LPA_P18].[useCode] = ''BIR'' '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PER_CDCGenderCode')
        SET @SqlSysDefinedField = @SqlSysDefinedField + '
            LEFT JOIN [V_UnifiedCodeSet] [LPA_C31] (nolock) ON  [LPA_G29].[equivUCS_ID]=[LPA_C31].[ID] '
            
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_OtherDiseaseName')
        SET @SqlSysDefinedField = @SqlSysDefinedField + '
            LEFT JOIN [dbo].A_ACT ACT_OTHERDISEASE (NOLOCK) ON  ACT_OTHERDISEASE.ACT_PARENT_ID = #tmp_DI_UDVals_temp.Act_ID 
            AND ACT_OTHERDISEASE.METACODE = ''PR_OTHERDISEASENAME'' '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_DiseaseShortName')
        SET @SqlSysDefinedField = @SqlSysDefinedField + '
            LEFT JOIN [dbo].V_UNIFIEDCODESET UCSShortName(NOLOCK) ON  [LPA_D4].[DVPR_DiseaseCode_ID] = UCSShortName.ID '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField IN ('PER_Race','PER_RACECATEGORY', 'PER_RACECATEGORYANDRACE'))
    BEGIN
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' SELECT DISTINCT [T_Race].[ID] AS [PMR_RowID], 
        CASE [T_Race].[metaCode] WHEN ''PER_MultipleRaceDR'' THEN [V_UnifiedCodeSet].[ID] END AS [PMR_MultipleRaceDR], 
        CASE [T_Race].[metaCode] WHEN ''PER_MultipleRaceDR'' THEN [LPA_U1].[ID] ELSE [V_UnifiedCodeSet].[ID] END AS [PMR_RaceCategoryDR], 
        CASE [T_Race].[metaCode] WHEN ''PER_MultipleRaceDR'' THEN [V_UnifiedCodeSet].[fullName] END AS [PMR_MultipleRace], 
        CASE [T_Race].[metaCode] WHEN ''PER_MultipleRaceDR'' THEN [LPA_U2].[termDisplay]  
            ELSE ( SELECT termDisplay FROM V_TermDictionary (NOLOCK) WHERE TermCode_ID = [V_UnifiedCodeSet].[ID] AND V_TermDictionary.Name = ''RaceCategory'') END AS [PMR_RaceCategory], 
        [T_Race].[Entity_ID] AS [PMR_PersonDR], 
        CASE WHEN ([V_TermDictionary].[termOrder] IS NULL OR [V_TermDictionary].[termOrder] < 0) THEN ''100000000.000'' ELSE [V_TermDictionary].[termOrder] END AS [RaceOrder] '

        SET @SqlSysDefinedField = @SqlSysDefinedField + ' INTO #TMP_DiPATRace' + @TableExtension + ' FROM [E_Entity] [LPA_E1] (nolock) 
        INNER JOIN [DV_Person] [LPA_D2] (nolock) ON  [LPA_E1].[ID]=[LPA_D2].[DVPER_RowID] '
        
        IF @RECORDTYPE <> 'CR' AND @RECORDTYPE <> ''
        BEGIN
            SET @SqlSysDefinedField = @SqlSysDefinedField + ' 
                INNER JOIN [DV_PHPersonalRecord] [LPA_D4] (nolock) ON  [LPA_D2].[DVPER_RowID]=[LPA_D4].[DVPR_PersonDR] 
                INNER JOIN #tmp_DI_UDVals_temp ON #tmp_DI_UDVals_temp.Act_ID = [LPA_D4].[DVPR_ROWID] '
        END
        ELSE
        BEGIN
            IF @RECORDTYPE = 'CR'
            BEGIN
                SET @SqlSysDefinedField = @SqlSysDefinedField + ' 
                INNER JOIN R_Role RolePlayer (NOLOCK) ON RolePlayer.Player_ID=[LPA_D2].[DVPER_RowID] AND RolePlayer.CLASSCODE=''PAT'' 
                AND  RolePlayer.statusCode <> ''nullified'' AND RolePlayer.statusCode <> ''terminated''
                INNER JOIN #tmp_CR_UDVals_temp (NOLOCK) CRTEMP ON CRTEMP.EntityID=RolePlayer.Player_ID'
            END
            ELSE
            BEGIN
                SET @SqlSysDefinedField = @SqlSysDefinedField + ' 
                INNER JOIN R_Role RolePlayer (NOLOCK) ON RolePlayer.Player_ID=[LPA_D2].[DVPER_RowID] AND RolePlayer.CLASSCODE=''PAT'' 
                AND RolePlayer.statusCode <> ''nullified'' AND RolePlayer.statusCode <> ''terminated''
                INNER JOIN P_Participation Participation (NOLOCK) ON Participation.Role_ID = RolePlayer.ID  AND Participation.TypeCode=''SBJ''
                INNER JOIN A_Act PH_CASEACT (NOLOCK) ON PH_CASEACT.Act_Parent_ID = Participation.Act_ID AND PH_CASEACT.Metacode = ''PR_RowID'' AND PH_CASEACT.classCode = ''CASE''  
                INNER JOIN #tmp_DI_UDVals_temp ON #tmp_DI_UDVals_temp.Act_ID = PH_CASEACT.ID '
            END
        END
        
        --Sbharathi Issue#229242
        SET @SqlSysDefinedField = @SqlSysDefinedField + '
            LEFT JOIN [T_Race] (nolock) ON [T_Race].[Entity_ID] = [LPA_D2].[DVPER_RowID]
            LEFT JOIN [V_UnifiedCodeSet] (nolock) ON  [V_UnifiedCodeSet].[ID]=[T_Race].[raceCode_ID]
            LEFT JOIN [V_TermDictionary] (nolock) ON  [V_UnifiedCodeSet].[ID]=[V_TermDictionary].[termCode_ID] 
            LEFT JOIN [V_CodeProperty] (nolock) ON  [V_CodeProperty].[subjCode_ID]=[T_Race].[raceCode_ID] AND ( ( [V_CodeProperty].[property] = ''Race_CategoryDR'')) 
            LEFT JOIN [V_UnifiedCodeSet] [LPA_U1] (nolock) ON  [LPA_U1].[ID]=[V_CodeProperty].[valueCode_ID] 
             LEFT JOIN [V_TermDictionary] [LPA_U2] (nolock) ON  [LPA_U2].[termCode_ID]=[V_CodeProperty].[valueCode_ID]
            
            WHERE ( [T_Race].[metaCode] IN (''PER_MultipleRaceDR'', ''PER_RaceCategoryDR'')) 
            
            SELECT  PMR_PersonDR,
            dbo.STRCONCAT(distinct PMR_MultipleRace) as ''PER_Race'', 
            dbo.STRCONCAT(distinct PMR_RaceCategory) as ''PER_RACECATEGORY'' ,
            CAST('''' AS VARCHAR(MAX)) as ''PER_RACECATEGORYANDRACE'' INTO #TMP_RACE' + @TableExtension + '
            FROM  #TMP_DiPATRace' + @TableExtension + '     
            GROUP BY PMR_PersonDR

            UPDATE TR
            SET TR.PER_RACECATEGORYANDRACE = TMP.RaceCategoryNRace
            FROM #TMP_RACE' + @TableExtension + ' TR
            INNER JOIN 
            (
              SELECT PMR_PersonDR, REPLACE(dbo.STRCONCAT(PMR_MultipleRace), '';,'', '';'' ) AS RaceCategoryNRace 
              FROM (
              SELECT PMR_PersonDR, concat( PMR_RaceCategory, CASE WHEN PMR_MultipleRace = '''' THEN '''' ELSE '':'' END,  PMR_MultipleRace, '';'' ) AS PMR_MultipleRace 
              FROM (
              SELECT PMR_PersonDR, PMR_RaceCategory, dbo.STRCONCAT(PMR_MultipleRace) AS PMR_MultipleRace  FROm #TMP_DiPATRace' + @TableExtension + '    
              GROUP BY PMR_PersonDR, PMR_RaceCategory ) A 
              ) B GROUP BY PMR_PersonDR
            ) TMP ON TMP.PMR_PersonDR = TR.PMR_PersonDR'                                            
    END
    ELSE
    BEGIN
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' SELECT NULL AS [PMR_RowID], 
        NULL AS [PMR_MultipleRaceDR], 
        NULL AS [PMR_RaceCategoryDR], 
        NULL AS [PMR_MultipleRace], 
        NULL AS [PMR_RaceCategory], 
        NULL AS [PMR_PersonDR], 
        NULL AS [RaceOrder] INTO #TMP_DiPATRace' + @TableExtension + ' FROM T_RACE (NOLOCK) WHERE 1 <> 1 '
    END
END
ELSE
BEGIN
    SET @SqlSysDefinedField = ' SELECT NULL AS [PER_RowID], NULL AS [DVPR_RowID] INTO #TMP_DiPAT' + @TableExtension + ' FROM A_ACT (NOLOCK) WHERE 1 <> 1 '
    SET @SqlSysDefinedField = @SqlSysDefinedField + ' SELECT NULL AS [PMR_RowID], 
        NULL AS [PMR_MultipleRaceDR], 
        NULL AS [PMR_RaceCategoryDR], 
        NULL AS [PMR_MultipleRace], 
        NULL AS [PMR_RaceCategory], 
        NULL AS [PMR_PersonDR], 
        NULL AS [RaceOrder] INTO #TMP_DiPATRace' + @TableExtension + ' FROM T_RACE (NOLOCK) WHERE 1 <> 1 '
END

IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField_Form = 'DiCase')
BEGIN
 
    SET @SqlSysDefinedField = @SqlSysDefinedField + '  SELECT DISTINCT PHCASE.ID AS PR_RowID '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_ProcessStatusName')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName](PHCASE.CaseOutcomeCode_ID) AS PR_ProcessStatusName ' 
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_ProcessStatusDR')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', PHCASE.CaseOutcomeCode_ID AS PR_ProcessStatusDR ' 
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_IsPregnant' AND LinkedSystemField_Form = 'DiCase')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DVPR.DVPR_ISPREGNANT AS PR_IsPregnant '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_DistrictName')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName](DVPR.DVPR_DistrictCode_ID) AS PR_DistrictName '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_OutbreakNumbers')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DVPR.DVPR_OutbreakNumbers AS PR_OutbreakNumbers '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_DateCreated')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DVPR.DVPR_createdate AS PR_DateCreated '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_DiseaseDR')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DVPR.DVPR_DiseaseCode_ID AS PR_DiseaseDR '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_DateClosed')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DVPR.DVPR_closedDate AS PR_DateClosed '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_DateOfOnset')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', PHCASE.SxDate AS PR_DateOfOnset '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_DateInvestigatorReceived')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', ACASE.AvailabilityTime AS PR_DateInvestigatorReceived '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_DeathSubmittedBy')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DeathSubmitted.ValueString AS PR_DeathSubmittedBy '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_DeathSubmittedDate')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DeathSubmitted.AvailabilityTime AS PR_DeathSubmittedDate '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_ResolutionStatusName')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName](PHCASE.InterpretationCode_ID) AS PR_ResolutionStatusName '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_ResolutionStatus')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', PHCASE.InterpretationCode_ID AS PR_ResolutionStatus '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_ReportedBy')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', PHCASE.DetectionMethodCode_ID AS PR_ReportedBy '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_ReportedByText')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName](PHCASE.DetectionMethodCode_ID) AS PR_ReportedByText '
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_ImportedStatusText')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName](DVPR.DVPR_ImportedStatus) AS PR_ImportedStatusText '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_IsPatientDiedOfTheIllness')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', ISNULL(DVPR.DVPR_ISPATIENTDIEDOFTHEILLNESS,0) AS PR_IsPatientDiedOfTheIllness '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_IsAsymptomatic')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DVPR.DVPR_ISASYMPTOMATIC AS PR_IsAsymptomatic '
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_DateSent')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DVPR.DVPR_DateSent AS PR_DateSent '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_InPatient')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', ISNULL(DVPR.DVPR_InPatient,0) AS PR_InPatient '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_OutPatient')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', ISNULL(DVPR.DVPR_OutPatient,0) AS PR_OutPatient '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_EpisodeDate')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', PHCASE.CaseOutcomeDate AS PR_EpisodeDate '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_SecondaryDistrictText')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName](DVPR.DVPR_SecondaryDistrictCode_ID) AS PR_SecondaryDistrictText '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField  = 'HealthSecondaryDistrict')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName](DVPR.DVPR_SecondaryDistrictCode_ID) AS HealthSecondaryDistrict '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_ClusterID')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DVPR.DVPR_clusterID AS PR_ClusterID '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_IsIndexCase')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DVPR.DVPR_isIndexCase AS PR_IsIndexCase '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_DateAdmitted')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', ACASE.ValueTS AS PR_DateAdmitted '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_DateDischarged')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', ACASE.ValueTSEnd AS PR_DateDischarged '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_IsPatientHospitalized')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', ISNULL(PHCASE.HospitalizedInd,0) AS PR_IsPatientHospitalized '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_DateOfDiagnosis')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', PHCASE.DxDate AS PR_DateOfDiagnosis '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_TransmissionStatus')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DVPR.DVPR_transmissionstatusCode_ID AS PR_TransmissionStatus '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_TransmissionStatusText')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName](DVPR.DVPR_transmissionstatusCode_ID) AS PR_TransmissionStatusText '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_ProviderName')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DVPR.DVPR_ProviderName AS PR_ProviderName '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_NurseInvestigatorName')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', EInvestName.PartGIV + '' '' + EInvestName.PartFAM AS PR_NurseInvestigatorName ' 
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_Provider')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', TENReportSource.TrivialName AS PR_Provider '
         
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_Laboratory')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', CAST(NULL AS VARCHAR(250)) AS PR_Laboratory '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_AdditionalProvider')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', CAST(NULL AS VARCHAR(250)) AS PR_AdditionalProvider '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_AdditionalLaboratory')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', CAST(NULL AS VARCHAR(250)) AS PR_AdditionalLaboratory '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_Hospital')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', CAST(NULL AS VARCHAR(250)) AS PR_Hospital '  

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_FBIDR')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', FBIInc.SOURCE_ID AS PR_FBIDR '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_FBIComputedID')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', FBIComp.extension AS PR_FBIComputedID '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_LABSpecimenCollectedDate')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DVPR.DVPR_LABSpecimenCollectedDate AS PR_LABSpecimenCollectedDate '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_LABSpecimenResultDate')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DVPR.DVPR_LABSpecimenResultDate AS PR_LABSpecimenResultDate '
        
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_FinalDispositionText')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName](DVPR.DVPR_FinalDisposition) AS PR_FinalDispositionText '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_NameOfSubmitter')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DVPR.DVPR_NameOfSubmitter AS PR_NameOfSubmitter '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_ReportedByLab')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', ISNULL(DVPR.DVPR_ReportedByLab,0) AS PR_ReportedByLab '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_ReportedByWeb')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', ISNULL(DVPR.DVPR_ReportedbyWeb,0) AS PR_ReportedByWeb '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_ReportedByEHR')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', ISNULL(DVPR.DVPR_ReportedByEHR,0) AS PR_ReportedByEHR ' 
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_DateOfDeath')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DVPR.DVPR_DATEOFDEATH AS PR_DateOfDeath '         
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_DATESUBMITTED')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DVPR.DVPR_DateSubmitted AS PR_DATESUBMITTED '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_LIPResultNotes')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DVPR.DVPR_Notes AS PR_LIPResultNotes '  
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_DATELASTUPDATESENT')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DVPR.DVPR_DateLastUpdateSent AS PR_DATELASTUPDATESENT '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_AnimalReportID')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', AI.DVAI_ANIMALREPORTID AS PR_AnimalReportID '    
        
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_IncidentDR')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', DI.DVPR_IncidentID AS PR_IncidentDR '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_DateofLabReport')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', LabReportAct.AVAILABILITYTIME AS PR_DateofLabReport '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'DiagnosticSpecimenTypes')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].FN_CumulativeTypes(DVPR.DVPR_RowID, ''DIST_ROWID'') AS DiagnosticSpecimenTypes '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'SuspectedExposureTypes')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].FN_CumulativeTypes(DVPR.DVPR_RowID, ''DIET_ROWID'') AS SuspectedExposureTypes '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_ContactTypeDR')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName](DVPR.DVPR_TypeOfContactDR) AS PR_ContactTypeDR '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_PriorityDR')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', [dbo].[FN_GetUCSFullName](DVPR.DVPR_PriorityDR) AS PR_PriorityDR '
        
    SET @SqlSysDefinedField = @SqlSysDefinedField + ' INTO #TMP_DiCase' + @TableExtension + ' From A_PublicHealthCase PHCASE (nolock) ' 
    SET @SqlSysDefinedField = @SqlSysDefinedField + ' INNER JOIN A_Act ACASE (nolock) on ACASE.ID=PHCASE.ID ' 
    SET @SqlSysDefinedField = @SqlSysDefinedField + ' INNER JOIN DV_PHPersonalRecord DVPR (NOLOCK) on PHCASE.ID=DVPR.DVPR_RowID ' 
    SET @SqlSysDefinedField = @SqlSysDefinedField + ' INNER JOIN #tmp_DI_UDVals_temp ON #tmp_DI_UDVals_temp.Act_ID = [DVPR].[DVPR_ROWID] '

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_Provider')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' LEFT JOIN T_EntityName TENReportSource (nolock) on TENReportSource.Entity_ID=DVPR.DVPR_reportsourcedr 
        and TENReportSource.MetaCode=''RS_HealthCareProvider'' and TENReportSource.UseCode=''SRCH'' ' 
        
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_NurseInvestigatorName')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' LEFT JOIN T_EntityName EInvestName (nolock) ON DVPR.DVPR_NurseInvestigatorDR =EInvestName.Entity_ID ' 

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField IN ('PR_FBIDR', 'PR_FBIComputedID'))
    BEGIN
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' LEFT JOIN A_ActRelationship FBIInc (nolock) on FBIInc.Target_ID=PHCASE.ID 
        and FBIInc.TypeCode=''COMP'' and FBIInc.METACODE=''PR_FBIDR''' 
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' LEFT JOIN T_INSTANCEIDENTIFIER FBIComp (nolock) on FBIInc.source_ID=FBIComp.ACT_ID' 
    END

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField IN ('PR_AnimalReportID'))
    BEGIN
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' LEFT JOIN [dbo].A_ACTRELATIONSHIP ACTREL_ANIMAL (NOLOCK) ON PHCASE.ID  = ACTREL_ANIMAL.TARGET_ID 
        AND ACTREL_ANIMAL.TYPECODE=''COMP'' AND ACTREL_ANIMAL.METACODE IN (''AI_CONTACTINVESTIGATIONDR'',''AI_DISEASEINCIDENTDR'')
        LEFT JOIN [dbo].DV_ANIMALREPORT AI (NOLOCK) ON AI.DVAI_ROWID = ACTREL_ANIMAL.SOURCE_ID ' 
    END


    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField IN ('PR_IncidentDR'))
    BEGIN
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' LEFT JOIN [dbo].A_ACTRELATIONSHIP ACTREL_INCIDENT (NOLOCK) ON PHCASE.ID  = ACTREL_INCIDENT.TARGET_ID 
        AND ACTREL_INCIDENT.TYPECODE=''DRIV'' AND ACTREL_INCIDENT.ID IN
        (
            SELECT TOP 1 ACTREL_CI.ID FROM A_ACTRELATIONSHIP ACTREL_CI (NOLOCK) 
            INNER JOIN DV_PHPERSONALRECORD DVPRA (NOLOCK) ON DVPRA.DVPR_ROWID=ACTREL_CI.source_ID  
            WHERE ACTREL_CI.METACODE=''PR_IncidentDR'' AND ACTREL_CI.TYPECODE=''DRIV'' AND ACTREL_CI.target_ID IN (ACTREL_INCIDENT.TARGET_ID) 
            ORDER BY ACTREL_CI.typeCode_OrTx DESC, ACTREL_CI.SOURCE_ID DESC
            ) 
        LEFT JOIN [dbo].DV_PHPERSONALRECORD DI (NOLOCK) ON DI.DVPR_ROWID = ACTREL_INCIDENT.SOURCE_ID ' 
    END         
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField IN ('PR_DateofLabReport'))
    BEGIN
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' LEFT JOIN [dbo].A_ACT LabReportAct (NOLOCK) ON  LabReportAct.ACT_PARENT_ID = PHCASE.ID AND 
        LabReportAct.METACODE = ''DILR_ID'' AND LabReportAct.ID = [dbo].FN_LAB_ACTID(PHCASE.ID)' 
    END
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField IN ('PR_DeathSubmittedBy', 'PR_DeathSubmittedDate'))
    BEGIN
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' LEFT JOIN A_ACT DeathSubmitted (nolock) on DeathSubmitted.Act_Parent_ID = PHCASE.ID 
        and DeathSubmitted.MetaCode=''PR_DateOfDeath''' 
    END
    /************************************************************/
     IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_Laboratory')
    BEGIN
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' UPDATE TMP SET TMP.PR_Laboratory = TENLaboratory.TrivialName
            FROM #TMP_DiCase'+ @TableExtension +' TMP '
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' INNER JOIN P_Participation PPLaboratory (nolock) on PPLaboratory.Act_ID=TMP.PR_RowID 
        and PPLaboratory.TypeCode = ''ELOC'' and PPLaboratory.MetaCode = ''PR_LaboratoryDR'' ' 
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' INNER JOIN R_Role RRLaboratory (nolock) on RRLaboratory.ID=PPLaboratory.Role_ID 
        and RRLaboratory.ClassCode = ''QUAL'' ' 
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' INNER JOIN T_EntityName TENLaboratory (nolock) on TENLaboratory.Entity_ID=RRLaboratory.Player_ID 
        and TENLaboratory.metacode=''LOC_Name'' and TENLaboratory.UseCode=''SRCH'' ' 
    END

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField IN ('PR_Hospital'))
    BEGIN
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' UPDATE TMP SET TMP.PR_Hospital = TENHospital.TrivialName
            FROM #TMP_DiCase'+ @TableExtension +' TMP '
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' INNER JOIN P_Participation PPHospital (nolock) on PPHospital.Act_ID=TMP.PR_RowID 
        and PPHospital.TypeCode = ''LOC'' and PPHospital.MetaCode = ''PR_HospitalDR'' ' 
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' INNER JOIN R_Role RRHospital (nolock) on RRHospital.ID=PPHospital.Role_ID and RRHospital.ClassCode = ''QUAL'' ' 
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' INNER JOIN T_EntityName TENHospital (nolock) on TENHospital.Entity_ID=RRHospital.Player_ID 
        and TENHospital.metacode=''LOC_Name'' and TENHospital.UseCode=''SRCH'' ' 
    END

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_AdditionalProvider')
    BEGIN
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' UPDATE TMP SET TMP.PR_AdditionalProvider = TENAdditionalProvider.TrivialName
            FROM #TMP_DiCase'+ @TableExtension +' TMP '
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' INNER JOIN P_Participation PPAdditionalReportSource (nolock) on PPAdditionalReportSource.Act_ID=TMP.PR_RowID 
        and PPAdditionalReportSource.TypeCode = ''REFB'' And PPAdditionalReportSource.MetaCode = ''PR_AdditionalReportSourceDR'' ' 
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' INNER JOIN R_Role RAdditionalReportSource (nolock) on RAdditionalReportSource.ID=PPAdditionalReportSource.Role_ID 
        and RAdditionalReportSource.ClassCode = ''QUAL'' ' 
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' INNER JOIN T_EntityName TENAdditionalProvider (nolock) on 
        TENAdditionalProvider.Entity_ID=RAdditionalReportSource.Player_ID
        and TENAdditionalProvider.MetaCode=''RS_HealthCareProvider'' and TENAdditionalProvider.UseCode=''SRCH'' ' 
    END

    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'PR_AdditionalLaboratory')
    BEGIN
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' UPDATE TMP SET TMP.PR_AdditionalLaboratory = TENAdditionalLaboratory.TrivialName
            FROM #TMP_DiCase'+ @TableExtension + ' TMP '
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' INNER JOIN P_Participation PPAdditionalLaboratory (nolock) on PPAdditionalLaboratory.Act_ID= TMP.PR_RowID 
        and PPAdditionalLaboratory.TypeCode=''ELOC'' and PPAdditionalLaboratory.MetaCode=''PR_AdditionalLaboratoryDR'' ' 
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' INNER JOIN R_Role RRAdditionalLaboratory (nolock) on RRAdditionalLaboratory.ID=PPAdditionalLaboratory.Role_ID 
        and RRAdditionalLaboratory.ClassCode=''QUAL'' ' 
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' INNER JOIN T_EntityName TENAdditionalLaboratory (nolock) on 
        TENAdditionalLaboratory.Entity_ID=RRAdditionalLaboratory.Player_ID and TENAdditionalLaboratory.MetaCode=''LOC_Name'' 
        and TENAdditionalLaboratory.UseCode=''SRCH'' ' 
    END

END
ELSE
BEGIN
    SET @SqlSysDefinedField = @SqlSysDefinedField + '  SELECT NULL AS PR_RowID INTO #TMP_DiCase' + @TableExtension + ' FROM A_ACT (NOLOCK) WHERE 1<>1 '
END

IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField_Form = 'DiRVCT')
BEGIN
    SET @SqlSysDefinedField = @SqlSysDefinedField + '  SELECT PHCASE.ID AS PR_RowID '
    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'RVCTPG_StateCaseNumber')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', StateCaseNumber.Title AS RVCTPG_StateCaseNumber '    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'RVCTPG_CityCountyCaseNumber')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', CityCountyCaseNumber.Title AS RVCTPG_CityCountyCaseNumber '  
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'RVCTPG_LinkingState1CaseNumber')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', LinkingState1CaseNumber.Title AS RVCTPG_LinkingState1CaseNumber '    
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'RVCTPG_LinkingState2CaseNumber')
        SET @SqlSysDefinedField = @SqlSysDefinedField + ', LinkingState2CaseNumber.Title AS RVCTPG_LinkingState2CaseNumber '    

    SET @SqlSysDefinedField = @SqlSysDefinedField + ' INTO #TMP_DiRVCT' + @TableExtension + ' From A_PublicHealthCase PHCASE (nolock)  
        INNER JOIN A_Act ACASE (nolock) on ACASE.ID=PHCASE.ID
        INNER JOIN A_ACT RVTDOC (NOLOCK) ON RVTDOC.Act_CaseCmr_ID=ACASE.ID
        INNER JOIN A_Act RVT (NOLOCK) on RVT.Act_Parent_ID=RVTDOC.ID AND RVT.metaCode = ''RVCTPG_ID'' and RVT.statusCode <> ''nullified''   ' 
    SET @SqlSysDefinedField = @SqlSysDefinedField + ' INNER JOIN #tmp_DI_UDVals_temp ON #tmp_DI_UDVals_temp.Act_ID = ACASE.ID '
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'RVCTPG_StateCaseNumber' )
    BEGIN
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' LEFT JOIN A_ACT StateCaseNumber (nolock) on StateCaseNumber.Act_Parent_ID = RVT.ID and StateCaseNumber.MetaCode=''RVCTPG_StateReporting_FK''' 
    END
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'RVCTPG_CityCountyCaseNumber' )
    BEGIN
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' LEFT JOIN A_ACT CityCountyCaseNumber (nolock) on CityCountyCaseNumber.Act_Parent_ID = RVT.ID and CityCountyCaseNumber.MetaCode=''RVCTPG_CityCountyCaseState_FK''' 
    END
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'RVCTPG_LinkingState1CaseNumber' )
    BEGIN
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' LEFT JOIN A_ACT LinkingState1CaseNumber (nolock) on LinkingState1CaseNumber.Act_Parent_ID = RVT.ID and LinkingState1CaseNumber.MetaCode=''RVCTPG_LinkingState1State_FK''' 
    END
    IF EXISTS (SELECT * FROM @TblSystemDefinedFieldLinks WHERE LinkedSystemField = 'RVCTPG_LinkingState2CaseNumber' )
    BEGIN
        SET @SqlSysDefinedField = @SqlSysDefinedField + ' LEFT JOIN A_ACT LinkingState2CaseNumber (nolock) on LinkingState2CaseNumber.Act_Parent_ID = RVT.ID and LinkingState2CaseNumber.MetaCode=''RVCTPG_LinkingState2State_FK''' 
    END
END
ELSE
BEGIN
    SET @SqlSysDefinedField = @SqlSysDefinedField + '  SELECT NULL AS PR_RowID INTO #TMP_DiRVCT' + @TableExtension + ' FROM A_ACT (NOLOCK) WHERE 1<> 1 '
END

RETURN @SqlSysDefinedField
END
