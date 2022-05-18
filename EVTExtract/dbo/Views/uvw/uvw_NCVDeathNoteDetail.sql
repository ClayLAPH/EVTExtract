CREATE VIEW dbo.[uvw_NCVDeathNoteDetail]
AS
SELECT          
		 (
            CASE 
                WHEN [NCVDeathNotProv]='No' THEN 'N' 
                WHEN [NCVDeathNotProv]='Yes' THEN 'Y' 
                WHEN [NCVDeathNotProv]='Unknown' THEN 'U' 
                ELSE NULL 
            END
        ) AS 'NCVDeathNotProv' 
        , try_CAST([NCVDateKinNot] AS DATETIME) AS [NCVDateKinNot]  
        , [NCVDeathNoteWhyNo] 
        , [NCVDeathRes] 
        , [NCVNonCoviDeath]
		, [NCVDIClassPostVacInfDeath]
		, [NCVDIPostVacDeathMore28days]
		, [NCVDIPostVacDeath14to28days]
		, [NCVDIPostVacDeathImmunocom]
		, [NCVDIPostVacDeath]
		, [NCVDIPostVacDeathNotes]
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
              UDF.[SECTION_DEF_DR] = 'NCVDeathNoteDetail'  AND [FORM_DEF_DR] = 'NCOVPUI'
        ) AS PivotData
PIVOT (
    MAX([FIELD_VALUE])
    FOR [FIELD_DEF_DR] IN (
		[NCVDeathNotProv] 
        , [NCVDateKinNot] 
        , [NCVDeathNoteWhyNo] 
        , [NCVDeathRes]
        , [NCVNonCoviDeath]
		, [NCVDIClassPostVacInfDeath]
		, [NCVDIPostVacDeathMore28days]
		, [NCVDIPostVacDeath14to28days]
		, [NCVDIPostVacDeathImmunocom]
		, [NCVDIPostVacDeath]
		, [NCVDIPostVacDeathNotes]
    )
) AS PivotTable


