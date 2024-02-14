
Create FUNCTION Sync.fn_GetUDDropScript (@StoredProcedureName  varchar(500))
	RETURNS varchar(max)
AS
BEGIN
	Declare @SQL varchar(max)
	set @SQL = '
	IF EXISTS (SELECT * FROM SYSCOMMENTS WHERE ID = OBJECT_ID ('''+ @StoredProcedureName +'''))
	BEGIN
		DROP PROC '+ @StoredProcedureName +'
	END	
	[GO] 
	'
	return @SQL
end
