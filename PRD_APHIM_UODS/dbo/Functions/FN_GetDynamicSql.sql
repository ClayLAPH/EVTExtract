
CREATE FUNCTION [dbo].[FN_GetDynamicSql] 
(
    @QueryName varchar(250),
    @SelectFields NVARCHAR(MAX),
    @JoinFields NVARCHAR(MAX),
    @ConditionFields NVARCHAR(MAX),
    @OrderByFields NVARCHAR(MAX),
    @DataSize int = 0,
    @SelectFieldsExtended NVARCHAR(MAX) = N''
)
RETURNS NVARCHAR(MAX)
AS
BEGIN

DECLARE @SelectedFieldsText NVARCHAR(MAX)
DECLARE @JoinText NVARCHAR(MAX)
DECLARE @WhereConditionText NVARCHAR(MAX)
DECLARE @OrderByText NVARCHAR(MAX)
DECLARE @DataSizeText nvarchar(50)

SET @SelectedFieldsText=''
SET @JoinText=''
SET @WhereConditionText=''
SET @OrderByText=''
SET @DataSizeText=''

BEGIN   --BLK_CreateSelect
    IF @SelectFields <> '' 
    BEGIN
        SELECT @SelectedFieldsText = @SelectedFieldsText + 
            CASE WHEN ISNULL(SQueryFieldJoin.FIELD_IsComputed, 0) = 0 
                THEN  ISNULL(SQueryFieldJoin.DBTableAlias + '.', '') 
                ELSE '' END 
            + SQueryFieldJoin.DBFieldName +  ISNULL(' ' + SQueryFieldJoin.FIELD_Name, '') + ', ' 
        FROM  
            [S_DBQueryDefinition] SQueryDef (NOLOCK)
            INNER JOIN [S_DBQueryFieldJoin] SQueryFieldJoin (NOLOCK) ON SQueryFieldJoin.QueryId = SQueryDef.RowId
        WHERE 
            SQueryDef.QueryName = @QueryName AND 
            SQueryFieldJoin.FIELD_Name in (select value  from dbo.ParmsToList(@SelectFields)) ORDER BY SQueryFieldJoin.DBTableJoinOrder, SQueryFieldJoin.RowId
    END

    IF ISNULL(@DataSize,0) > 0 
    BEGIN
        SET @DataSizeText='TOP (@DataSetSize)'
    END

    DECLARE @SelectedFieldsTextLength INT
    SET @SelectedFieldsTextLength = LEN(@SelectedFieldsText)
    IF @SelectedFieldsTextLength > 0
    BEGIN
        SET @SelectedFieldsText = SUBSTRING(@SelectedFieldsText, 1, @SelectedFieldsTextLength - 1)
        SET @SelectedFieldsText='SELECT DISTINCT ' + @DataSizeText + ' ' +  @SelectedFieldsText + @SelectFieldsExtended
    END
END


BEGIN   --BLK_CreateJoins
    IF @JoinFields <> '' 
    BEGIN
        SELECT   
            @JoinText = 
                CASE WHEN @JoinText = '' 
                    THEN DBTableName + ISNULL(' ' + DBTableAlias, '') + ' ' + DBTableHints + ' '
                    ELSE @JoinText + ' ' + ISNULL(' ' + DBTableJoinType, '')+ ' ' + DBTableName +
                                ISNULL(' ' + DBTableAlias, '') + ' ' + DBTableHints + ' ' + ISNULL(' ON ' + DBTableJoinCondition, '') 
                END  
        FROM (
            SELECT DISTINCT  
                SQueryFieldJoin.DBTableName, 
                SQueryFieldJoin.DBTableAlias, 
                SQueryFieldJoin.DBTableJoinType, 
                SQueryFieldJoin.DBTableJoinCondition, 
                SQueryFieldJoin.DBTableJoinOrder,
                SQueryFieldJoin.DBTableHints
            FROM 
                [S_DBQueryDefinition] SQueryDef (NOLOCK)
                INNER JOIN [S_DBQueryFieldJoin] SQueryFieldJoin (NOLOCK) ON SQueryFieldJoin.[QueryId] = SQueryDef.RowID
            WHERE 
                SQueryDef.QueryName = @QueryName AND 
                SQueryFieldJoin.FIELD_Name IN (SELECT value FROM dbo.ParmsToList(@JoinFields))
         )AS tmp ORDER BY DBTableJoinOrder
    END
    ELSE 
    BEGIN
        RETURN N''
    END
    SET @JoinText = ' From ' + @JoinText
END


BEGIN   --BLK_CreateCondition
    IF @ConditionFields <> '' 
    BEGIN
        SET @WhereConditionText = ' ' + @ConditionFields + ' ' 
        SELECT  @WhereConditionText = 
        CASE WHEN 
            CHARINDEX(' ' + SQueryFieldJoin.FIELD_Name + ' ', @WhereConditionText) > 0 
                THEN REPLACE(@WhereConditionText, ' ' + SQueryFieldJoin.FIELD_Name + ' ', ' ' + 
                    CASE WHEN ISNULL(SQueryFieldJoin.FIELD_IsComputed, 0) = 0 
                        THEN ISNULL(SQueryFieldJoin.DBTableAlias + '.', '') 
                    ELSE '' 
                    END + SQueryFieldJoin.DBFieldName + ' ') 
            ELSE 
                @WhereConditionText 
            END 
        FROM [S_DBQueryDefinition] SQueryDef (NOLOCK)
        INNER JOIN [S_DBQueryFieldJoin] SQueryFieldJoin (NOLOCK) on SQueryFieldJoin.[QueryId] = SQueryDef.RowID
        WHERE SQueryDef.QueryName = @QueryName 
    END

    IF @WhereConditionText <> '' 
    BEGIN
        SET @WhereConditionText =' WHERE ' + @WhereConditionText
    END
END

BEGIN   --BLK_CreateOrderBy
    IF @OrderByFields <> '' 
    BEGIN
        SET @OrderByText = @OrderByFields + ' ' 
        SELECT @OrderByText = 
            CASE WHEN CHARINDEX(SQueryFieldJoin.FIELD_Name, @OrderByText) > 0 
                THEN REPLACE(@OrderByText, SQueryFieldJoin.FIELD_Name, ' ' + ISNULL(SQueryFieldJoin.DBTableAlias + '.', '') + SQueryFieldJoin.DBFieldName ) 
            ELSE @OrderByText 
            END 
        FROM [S_DBQueryDefinition] SQueryDef (NOLOCK)
        INNER JOIN [S_DBQueryFieldJoin] SQueryFieldJoin (NOLOCK) on SQueryDef.RowID = SQueryFieldJoin.QueryId
        WHERE SQueryDef.QueryName = @QueryName 
    END

    IF @OrderByText <> '' 
    BEGIN
        SET @OrderByText = ' ORDER BY ' + @OrderByText
    END
END

RETURN  @SelectedFieldsText + char(13) + char(10) +  @JoinText +  @WhereConditionText + @OrderByText

END

