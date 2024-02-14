

CREATE PROCEDURE [AtlasInternal].[USP_UODS_DEL_QueryFields] 
(
	@QueryName varchar(250),
	@FieldName varchar(250)
)
AS
BEGIN

	DECLARE @SQL AS Varchar(4000)
	
	CREATE TABLE #TMPQueryID(
	[QueryID] [int] NOT NULL
	)
	
	If @FieldName = ''
	SET @FieldName = NULL
	
	BEGIN	--BLK_RetreiveQueryRowID
		INSERT INTO #TMPQueryID SELECT QueryDef.RowID 
			FROM S_DBQueryDefinition QueryDef (NOLOCK)
			INNER JOIN S_DBQueryFieldJoin QueryFieldJoin (NOLOCK) ON QueryFieldJoin.QueryId = QueryDef.RowID 
			WHERE QueryDef.QueryName = @QueryName AND ISNULL(QueryFieldJoin.FIELD_Name, '') = ISNULL(@FieldName, ISNULL(QueryFieldJoin.FIELD_Name, ''))
	END		
	
	BEGIN	--BLK_DeleteRecords
		
		DELETE FROM S_DBQueryFieldJoin
			FROM dbo.S_DBQueryFieldJoin 
			INNER JOIN #TMPQueryID ON #TMPQueryID.QueryID = S_DBQueryFieldJoin.QueryId
			
		DELETE FROM S_DBQueryDefinition
			FROM dbo.S_DBQueryDefinition 
			INNER JOIN #TMPQueryID ON #TMPQueryID.QueryID = S_DBQueryDefinition.RowID	
			
	END 
	
	DROP TABLE #TMPQueryID
END


