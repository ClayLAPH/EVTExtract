

CREATE   VIEW [AtlasInternal].[View_UODS_AuditDetailData]
AS
Select 
AD.AuditID AS [AD_AMRowID],
AD.ColumnName AS [AD_ColumnName],
AD.OldValue AS [AD_OldValue],
AD.NewValue AS [AD_NewValue]
from S_AuditDetail AD WITH(NOLOCK) 
