CREATE VIEW dbo.[uvw_NCVHopsitalRx]
AS
SELECT          
		 (
            CASE 
                WHEN [NCVCloroquine]='No' THEN 'N' 
                WHEN [NCVCloroquine]='Yes' THEN 'Y' 
                WHEN [NCVCloroquine]='Unknown' THEN 'U' 
                ELSE NULL 
            END
        ) as 'NCVCloroquine'
        , (
            CASE 
                WHEN [NCVHydroxychloroquine]='No' THEN 'N' 
                WHEN [NCVHydroxychloroquine]='Yes' THEN 'Y' 
                WHEN [NCVHydroxychloroquine]='Unknown' THEN 'U' 
                ELSE NULL 
            END
        ) as 'NCVHydroxychloroquine' 
        , (
            CASE 
                WHEN [NCVKaletra]='No' THEN 'N' 
                WHEN [NCVKaletra]='Yes' THEN 'Y' 
                WHEN [NCVKaletra]='Unknown' THEN 'U' 
                ELSE NULL 
            END
        ) as 'NCVKaletra' 
        , [NCVOtherRx] 
        , (
            CASE 
                WHEN [CNVRemdesivir]='No' THEN 'N' 
                WHEN [CNVRemdesivir]='Yes' THEN 'Y' 
                WHEN [CNVRemdesivir]='Unknown' THEN 'U' 
                ELSE NULL 
            END
        ) as 'CNVRemdesivir' 
        , (
            CASE 
                WHEN [NCVRemdesivirClinTrail]='No' THEN 'N' 
                WHEN [NCVRemdesivirClinTrail]='Yes' THEN 'Y' 
                WHEN [NCVRemdesivirClinTrail]='Unknown' THEN 'U' 
                ELSE NULL 
            END
        ) as 'NCVRemdesivirClinTrail' 
        , try_CAST([NCVStartChloroquine] AS DATETIME) AS [NCVStartChloroquine]
        , try_CAST([NCVStartHydroxychloroquine] AS DATETIME) AS [NCVStartHydroxychloroquine]
        , try_CAST([NCVStartKaletra] AS DATETIME) AS [NCVStartKaletra]
        , try_CAST([NCVstartRemdesivir] AS DATETIME) AS [NCVstartRemdesivir]
        , try_CAST([NCVStopChloroquine] AS DATETIME) AS [NCVStopChloroquine]
        , try_CAST([NCVStopHydroxychloroquine] AS DATETIME) AS [NCVStopHydroxychloroquine]
        , try_CAST([NCVStopKaletra] AS DATETIME) AS [NCVStopKaletra]
        , CAST([NCVStopRemdesivir] AS DATETIME) AS [NCVStopRemdesivir]
		, [NCVSteriods]
		, [NCVToci]
		, try_CAST([NCVStartDateToci] AS DATETIME) AS [NCVStartDateToci]
		, try_CAST([NCVStartDateSteriod] AS DATETIME) AS [NCVStartDateSteriod]
		, try_CAST([NCVStopDateToci] AS DATETIME) AS [NCVStopDateToci]
		, try_CAST([NCVStopDateSteriods] AS DATETIME) AS [NCVStopDateSteriods]
		, [NCVDIREMDESIVIR]
        , [RECORD_ID] as 'DIID'
        , [PR_INCIDENTID] as 'INSTANCEID'
        , [PER_ClientID] as 'Person_ID'
		, [SECTION_INSTANCE_ID] as 'UDSectionActID'
        , [PR_PHTYPE] as 'RecordType'
        , [PR_DISEASE] as 'Disease'
        , [PR_DISTRICT] as 'District'
        , [FORM_INSTANCE_ID] as 'FormInstanceID'
        , [FORM_NAME] as 'FormName'
        , [FORM_DESCRIPTION] as 'FormDescription'
        , try_CONVERT(DATETIME,[FORM_CREATEDATE]) as 'FormCreateDateTime'
FROM    (
            SELECT  UDF.[RECORD_ID]
                    , UDF.[FORM_INSTANCE_ID]
                    , UDF.[FORM_NAME]
                    , UDF.[FORM_DESCRIPTION]
                    , UDF.[FORM_CREATEDATE]
					, UDF.[SECTION_INSTANCE_ID] 
                    , UDF.[FIELD_DEF_DR] AS [FIELD_DEF_DR]
                    , CAST([FIELD_VALUE] AS VARCHAR(MAX)) AS [FIELD_VALUE]
                    , P.[PER_ClientID]
                    , I.[PR_PHTYPE]
                    , I.[PR_DISEASE]
                    , I.[PR_INCIDENTID]
                    , I.[PR_DISTRICT]
            FROM   
              dbo.[COVID_UDF_DATA] AS UDF with (nolock) 
					    INNER JOIN 
              dbo.[COVID_INCIDENT] AS I with (nolock)
                ON UDF.[RECORD_ID] = I.[PR_ROWID]
              INNER JOIN 
              dbo.[COVID_PERSON] AS P with (nolock)
                ON P.[PER_ROWID] = I.[PR_PersonDR]
            WHERE   UDF.[SECTION_DEF_DR] = 'NCVHopsitalRx'  AND [FORM_DEF_DR] = 'NCOVPUI'
        ) AS PivotData
PIVOT (
    MAX([FIELD_VALUE])
    FOR [FIELD_DEF_DR] IN (
		[NCVCloroquine] 
        , [NCVHydroxychloroquine] 
        , [NCVKaletra] 
        , [NCVOtherRx] 
        , [CNVRemdesivir] 
        , [NCVRemdesivirClinTrail] 
        , [NCVStartChloroquine] 
        , [NCVStartHydroxychloroquine] 
        , [NCVStartKaletra] 
        , [NCVstartRemdesivir] 
        , [NCVStopChloroquine] 
        , [NCVStopHydroxychloroquine] 
        , [NCVStopKaletra] 
        , [NCVStopRemdesivir]
		, [NCVSteriods]
		, [NCVToci]
		, [NCVStartDateToci]
		, [NCVStartDateSteriod]
		, [NCVStopDateToci]
		, [NCVStopDateSteriods]
		, [NCVDIREMDESIVIR]
    )
) AS PivotTable

GO
