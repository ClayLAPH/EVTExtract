CREATE VIEW dbo.[uvw_SOGI]
AS
SELECT  
		[OtherGenderSpfy]
		, [SexualOrient]
		, [SOGIRaceEthnOth]
		, [SexatBirthOth]
		, [SexualOrientSpcfy]
		, [CurGenID]
		, [SOGIRaceEthn]
		, [SexatBirth]
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
            WHERE   
              UDF.[SECTION_DEF_DR] = 'SOGIV01' 
        ) AS PivotData
PIVOT (
    MAX([FIELD_VALUE])
    FOR [FIELD_DEF_DR] IN (
		[OtherGenderSpfy]
		, [SexualOrient]
		, [SOGIRaceEthnOth]
		, [SexatBirthOth]
		, [SexualOrientSpcfy]
		, [CurGenID]
		, [SOGIRaceEthn]
		, [SexatBirth]
    )
) AS PivotTable

