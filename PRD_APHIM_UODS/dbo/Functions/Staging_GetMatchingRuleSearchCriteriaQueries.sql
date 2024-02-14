
CREATE FUNCTION [dbo].[Staging_GetMatchingRuleSearchCriteriaQueries](@fields varchar(max))
RETURNS @queries table(queryNo int, query nvarchar(max) NULL, parameters nvarchar(max) NULL)
AS
BEGIN
    Declare @matchingRuleFields as table(fieldName varchar(150) NOT NULL,dbFieldName varchar(150) NULL, queryNo int NULL)
    INSERT INTO @matchingRuleFields(fieldName, dbFieldName, queryNo)
    SELECT [Value], 
    CASE 
        WHEN [Value] LIKE 'PER_%' THEN 
                                        CASE 
                                            WHEN [Value]='PER_DOB' THEN 'CONVERT(varchar(4000), [DVPER_DOB], 112) AS ' + QUOTENAME([Value]) 
                                            WHEN [Value]='PER_MRN' THEN 'CAST([DVPR_MRN] as varchar(4000)) AS ' + QUOTENAME([Value]) 
                                            WHEN [Value]='PER_AdditionalIdentifier' THEN 'CAST([AI_Value] as varchar(4000)) as [AI_Value]'
                                            WHEN [Value]='PER_Sex' THEN 'CAST([UCSex].[equivUCS_ID] as varchar(4000)) AS ' + QUOTENAME([Value])
                                            WHEN [Value]='PER_WorkPhone' THEN 'CAST([DVPER_WorkSchoolPhone] as varchar(4000)) AS ' + QUOTENAME([Value])                                                                                                                     
                                            WHEN [Value]='PER_FirstInitial' THEN 'CAST(SUBSTRING(ISNULL([DVPER_FirstNameAlphaUp], ''''),1,1) as varchar(4000)) AS ' + QUOTENAME([Value])                                    
                                            WHEN [Value]='PER_MiddleName' THEN 'CAST([namePart].[partMid] as varchar(4000)) AS ' + QUOTENAME([Value]) 
                                            WHEN [Value]='PER_MiddleNameSoundEx' THEN 'CAST(SoundEx([namePart].[partMid]) as varchar(4000)) AS ' + QUOTENAME([Value])
                                            WHEN CHARINDEX('SoundEx', [Value]) > 0 THEN 'CAST(SoundEx(' + QUOTENAME('DV'+REPLACE([Value],'SoundEx','')) + ') as varchar(4000)) AS ' + QUOTENAME([Value])
                                            ELSE
                                             'CAST(' + QUOTENAME('DV' + [Value]) + ' as varchar(4000)) AS ' + QUOTENAME([Value])
                                        END 
        WHEN [Value] LIKE 'PR_%' THEN
                                        CASE 
                                            WHEN [Value]='PR_ACCNO' THEN  'CAST([DILRAct].[Title] as varchar(4000)) AS ' + QUOTENAME([Value]) 
                                            WHEN [Value]='PR_SPACode_ID' THEN 'CAST([DIST].[SPACode_ID] as varchar(4000)) AS ' + QUOTENAME([Value])                                         
                                            WHEN [Value]='PR_DiseaseDR' THEN 'CAST([DVPR_DiseaseCode_ID] as varchar(4000)) AS ' + QUOTENAME([Value])                                        
                                            WHEN [Value]='PR_DistrictDR' THEN 'CAST([DVPR_DistrictCode_ID] as varchar(4000)) AS ' + QUOTENAME([Value])
                                            WHEN [Value]='PR_DiagnosisDate' THEN 'CONVERT(varchar(4000), [DVPR_DiagnosisDate], 112) AS ' + QUOTENAME([Value])
                                            WHEN [Value]='PR_OnsetDate' THEN 'CONVERT(varchar(4000), [DVPR_OnsetDate], 112) AS ' + QUOTENAME([Value])                                                                           
                                            WHEN CHARINDEX('ReInfectionPeriod', [Value]) > 0 THEN 'CONVERT(varchar(4000),' + QUOTENAME('DV' + REPLACE([Value],'WithinReInfectionPeriod','')) + ', 112) AS ' + QUOTENAME([Value])
                                            ELSE
                                             'CAST(' + QUOTENAME('DV' + [Value]) + ' as varchar(4000)) AS ' + QUOTENAME([Value])
                                        END
        WHEN [Value] LIKE 'RS_%' THEN
                                        CASE 
                                            WHEN [Value]='RS_NationalProviderIdentifier' THEN  'CAST([TNPI].[extension] as varchar(4000)) AS ' + QUOTENAME([Value]) 
                                            WHEN [Value]='RS_HealthCareProvider' THEN 'CAST([providerName].[TrivialName] as varchar(4000)) AS ' + QUOTENAME([Value]) 
                                        END                                                                         
        WHEN [Value] LIKE 'SPEC_%' THEN
                                        'CONVERT(varchar(4000), ' + QUOTENAME(REPLACE(REPLACE([Value],'WithinReInfectionPeriod',''),'SPEC_SpecimenDateCollected','DVIS_CollectionDate')) + ', 112) AS ' + QUOTENAME([Value])
                                    END as dbFieldName,
    CASE 
        WHEN [Value] LIKE 'PER_%' THEN 
                                        CASE 
                                            WHEN [Value]='PER_AdditionalIdentifier' THEN 6
                                            WHEN [Value]='PER_MiddleName' THEN 5
                                            WHEN [Value]='PER_MiddleNameSoundEx' THEN 5
                                            ELSE
                                             1
                                        END 
        WHEN [Value] LIKE 'PR_%' THEN
                                        CASE 
                                            WHEN [Value]='PR_ACCNO' THEN 3
                                            WHEN [Value]='PR_SPACode_ID' THEN 7                                     
                                            ELSE
                                             1
                                        END
        WHEN [Value] LIKE 'RS_%' THEN 2                                                                         
        WHEN [Value] LIKE 'SPEC_%' THEN 4
                                    END as queryNo
      FROM dbo.ParmsToList(@fields)

      delete from @matchingRuleFields where FieldName ='PER_AccountNo'

    --Declare @queries table(queryNo int, query nvarchar(max) NULL, parameters nvarchar(max) NULL)
    INSERT INTO @queries(queryNo)
    SELECT DISTINCT queryNo from @matchingRuleFields order by 1

    Declare @selectPredicate as nvarchar(max)=''
    Declare @unpivotFields as nvarchar(max)=''
    Declare @query as nvarchar(max)
    Declare @queryNo int
    DECLARE @searchCriteriaList AS [MatchValuesListType]
    Declare @reportSourceDR int
    Declare @per_rowId int


    WHILE EXISTS(SELECT 1 FROM @queries WHERE query IS NULL)
    BEGIN
        SELECT TOP 1 @queryNo = queryNo FROM @queries WHERE query IS NULL
        select @selectPredicate = dbo.STRCONCAT(dbFieldName) from @matchingRuleFields WHERE queryNo=@queryNo
        select @unpivotFields =  dbo.STRCONCAT('('''+FieldName +''',[' +FieldName + '])') from @matchingRuleFields WHERE queryNo=@queryNo
        IF @queryNo = 1 -- Demographics, PHCase
        BEGIN       
            SET @query= FORMATMESSAGE(N'SELECT FieldName, FieldValue FROM(select %s FROM [dbo].[DV_PHPersonalRecord] (nolock) 
            INNER JOIN [dbo].[DV_Person] (nolock) ON [dbo].[DV_Person].DVPER_RowID = [dbo].[DV_PHPersonalRecord].DVPR_PersonDR
            LEFT JOIN [dbo].[V_UnifiedCodeSet] [UCSex] (nolock) ON [UCSex].ID = [dbo].[DV_Person].DVPER_SexCode_ID
            WHERE DVPR_RowID = @pr_rowid) RESULT', @selectPredicate)
            SET @query= @query + FORMATMESSAGE(N' CROSS APPLY ( VALUES %s) U (FieldName, FieldValue)', @unpivotFields)
            update @queries set [query] = @query, [parameters] = N'@PR_RowId int=%d'  WHERE queryNo=@queryNo
        END
        ELSE IF @queryNo = 3 -- Accession Number
        BEGIN
            SET @query= FORMATMESSAGE(N'SELECT FieldName, FieldValue FROM(select %s FROM [dbo].[A_Act] AS [DILRAct] (nolock) WHERE Act_Parent_ID = @pr_rowid and metaCode=@metaCode) RESULT ', @selectPredicate)
            SET @query= @query + FORMATMESSAGE(N' CROSS APPLY ( VALUES %s) U (FieldName, FieldValue)', @unpivotFields)
            update @queries set query = @query, parameters = N'@PR_RowId int=%d, @metaCode varchar(50) = ''DILR_ID'''  WHERE queryNo=@queryNo
        END
        ELSE IF @queryNo = 2 -- Report Source Name, NPI
        BEGIN
            SET @query= FORMATMESSAGE(N'SELECT FieldName, FieldValue FROM(SELECT %s    
            FROM [T_EntityName] [providerName] (nolock) 
            LEFT JOIN [T_InstanceIdentifier] [TNPI] (nolock) ON [providerName].[Entity_Id]= [TNPI].[Entity_Id] AND [providerName].[metaCode] = @providerMetaCode  AND [providerName].[UseCode] = @providerUseCode 
            WHERE [TNPI].[Entity_Id] = @reportSourceDR AND [TNPI].[metaCode] = @npiMetaCode AND [TNPI].[Root] = @npiRoot) RESULT ', @selectPredicate)
            SET @query= @query + FORMATMESSAGE(N' CROSS APPLY ( VALUES %s) U (FieldName, FieldValue)', @unpivotFields)
            update @queries set query = @query, parameters = N'@reportSourceDR int=%d, @providerUseCode varchar(50)=''SRCH'', @providerMetaCode varchar(50)=''RS_HealthCareProvider'', @npiMetaCode varchar(50)=''RS_NationalProviderIdentifier'', @npiRoot varchar(50) = ''2.16.840.1.113883.4.6'''  WHERE queryNo=@queryNo
        END
        ELSE IF @queryNo = 4 -- Specimen Dates
        BEGIN
            SET @query= FORMATMESSAGE(N'SELECT FieldName, FieldValue FROM(select TOP 1 %s FROM DV_IncidentSpecimen (nolock) WHERE DVIS_IncidentDR = @pr_rowid ORDER BY DVIS_RowID DESC) RESULT ', @selectPredicate)
            SET @query= @query + FORMATMESSAGE(N' CROSS APPLY ( VALUES %s) U (FieldName, FieldValue)', @unpivotFields)
            update @queries set query = @query, parameters = N'@PR_RowId int=%d'  WHERE queryNo=@queryNo
        END
        ELSE IF @queryNo = 5 -- Name Parts
        BEGIN
            SET @query= FORMATMESSAGE(N'SELECT FieldName, FieldValue FROM(select %s FROM [dbo].[T_EntityName] AS [namePart] (nolock) WHERE [namePart].[Entity_ID] = @per_rowId and useCode=@useCode) RESULT ', @selectPredicate)
            SET @query= @query + FORMATMESSAGE(N' CROSS APPLY ( VALUES %s) U (FieldName, FieldValue)', @unpivotFields)
            update @queries set query = @query, parameters = N'@per_rowId int=%d, @useCode varchar(50)=''L'''  WHERE queryNo=@queryNo
        END
        ELSE IF @queryNo = 6 -- Additional Identifiers
        BEGIN
            SET @query= FORMATMESSAGE(N'SELECT AI_IdentifierTypeDR, AI_Value FROM [dbo].[S_AdditionalIdentifier] (nolock) WHERE [AI_PersonRowID] = @per_rowId', @selectPredicate)
            update @queries set query = @query, parameters = N'@per_rowId int=%d'  WHERE queryNo=@queryNo
        END
        ELSE IF @queryNo = 7 -- Region
        BEGIN
            SET @query= FORMATMESSAGE(N'SELECT FieldName, FieldValue FROM(select %s FROM [dbo].[DV_PHPersonalRecord] AS [DV] (nolock) INNER JOIN [dbo].[VCP_District] AS [DIST] (nolock) ON [DV].[DVPR_DistrictCode_ID] = [DIST].[SubjCode_ID] WHERE [DV].[DVPR_RowID] = @pr_rowid) RESULT ', @selectPredicate)
            SET @query= @query + FORMATMESSAGE(N' CROSS APPLY ( VALUES %s) U (FieldName, FieldValue)', @unpivotFields)
            update @queries set query = @query, parameters = N'@PR_RowId int=%d'  WHERE queryNo=@queryNo
        END
        DELETE FROM @queries WHERE queryNo=@queryNo AND query IS NULL
    END -- END OF LOOP
    RETURN
END

