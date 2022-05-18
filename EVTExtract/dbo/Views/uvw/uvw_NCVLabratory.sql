CREATE VIEW dbo.[uvw_NCVLabratory]
AS

SELECT  *
FROM    (
            SELECT  [RECORD_ID]
                    , [FORM_INSTANCE_ID]
                    , [FORM_NAME]
                    , [FORM_DESCRIPTION]
                    , [FORM_CREATEDATE]
                    , [FIELD_DEF_DR]
                    , CAST([FIELD_VALUE] AS VARCHAR(MAX)) AS [FIELD_VALUE]
            FROM    dbo.[COVID_UDF_DATA] with (nolock)
            WHERE   [SECTION_DEF_DR] = 'TRVHXDTL'
        ) AS PivotData
PIVOT (
    MAX([FIELD_VALUE])
    FOR [FIELD_DEF_DR] IN (
        [NCVLRTSpecimen]
        , [NCVSerumStatus]
        , [NCVStool]
        , [NCVTestStatus]
        , [NCVUrine]
        , [NCVURTSpecimen]
    )
) AS PivotTable

