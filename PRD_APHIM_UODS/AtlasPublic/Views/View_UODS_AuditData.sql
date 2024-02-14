
CREATE   VIEW [AtlasPublic].[View_UODS_AuditData]
AS
SELECT 
    RECORD_ID,
	RECORD_RowID,
    AM_RowID,
	AM_RecordID,
    AM_FormName,
    AM_TableName,
    AM_ActionType,
    AM_ActionDate,
    AM_UserRowID
    FROM  [AtlasInternal].[View_UODS_AuditData]     
