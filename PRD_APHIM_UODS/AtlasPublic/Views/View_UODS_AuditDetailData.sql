
CREATE   VIEW [AtlasPublic].[View_UODS_AuditDetailData]
AS
SELECT 
    AD_AMRowID,
	AD_ColumnName,
    AD_OldValue,
    AD_NewValue    
    FROM  [AtlasInternal].[View_UODS_AuditDetailData]     
