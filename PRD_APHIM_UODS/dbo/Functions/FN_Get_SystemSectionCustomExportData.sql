CREATE FUNCTION [dbo].[FN_Get_SystemSectionCustomExportData]
 (@SectionName VARCHAR(20), @ColumnName VARCHAR(200), @OrderByColumnName VARCHAR(200))
RETURNS NVARCHAR(max)
AS
BEGIN
    DECLARE @SQLContact NVARCHAR(max) = ''
    SET @SQLContact = @SQLContact + ' INSERT INTO #tmpExportData SELECT Act_ID '
    SET @SQLContact = @SQLContact + ', ''' + @ColumnName + '~'' + ' 
    SET @SQLContact = @SQLContact + ' RIGHT(''000'' + CAST(convert(varchar(10),dense_rank() over (partition by Act_ID order by '+ @OrderByColumnName +')) AS VARCHAR(4)) , 3)   
    AS ColName '
    SET @SQLContact = @SQLContact + ', ' + @ColumnName + ' AS [FIELD_VALUE]'

    SET @SQLContact = @SQLContact + ' FROM #TMPSystemTable ;'
    Return @SQLContact
END
