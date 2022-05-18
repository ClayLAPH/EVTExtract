CREATE VIEW dbo.[uvw_RESP_OB_PROCESS_STATUS]
AS
SELECT  P.[OUTB_RowID]                                                 AS 'Row_ID'
        , O.[OUTB_OUTBREAKID]                                          AS 'Outbreak_ID'
        , O.[OUTB_OutbreakNumber]                                      AS 'Outbreak_Number'
        , O.[OUTB_OutbreakLocation]                                    AS 'Location'
        , P.[AUD_ID]                                                   AS 'AUD_ID'
        , P.[AUD_OldValue]                                             AS 'Old_Value'
        , P.[AUD_NewValue]                                             AS 'New_Value'
        , try_CONVERT(DATETIME,P.[AUD_ActionDate])                     AS 'Action_Date'
        , P.[AUD_Username]                                             AS 'Username'
FROM    
  dbo.[UNKNOWN_REPSIRATORY_PROCESS_STATUS_HISTORY] AS P with (nolock) 
	INNER JOIN 
  dbo.[UNKNOWN_RESPIRATORY_OUTBREAK] AS O with (nolock)
  ON P.[OUTB_RowID] = O.[OUTB_RowID]
GO


