
CREATE PROCEDURE [AtlasInternal].[USP_UODS_INS_QueryDefinition]
(
	@QueryName VARCHAR(250), 
	@QueryDescription VARCHAR(500), 
	@outQueryNameRowId INT OUTPUT
)
AS
BEGIN
	BEGIN -- BLK_VarDeclaration -- Variable declaration
		DECLARE @QueryNameRowId int
	END

	BEGIN -- BLK_FindExisting -- Find existing query definition
		select  @QueryNameRowId = QueryDef.Rowid
		from [S_DBQueryDefinition] QueryDef (NOLOCK)
		where QueryDef.QueryName=@QueryName
	END

	BEGIN -- BLK_CreateDefinition -- If found return found RowID otherwise create new
		If @QueryNameRowId IS NULL 
		BEGIN
			INSERT INTO [S_DBQueryDefinition]
					   ([QueryName]
					   ,[QueryDescription])
				 VALUES
					   (@QueryName
					   ,@QueryDescription)
			SET @QueryNameRowId=SCOPE_IDENTITY()
		END
		SET @outQueryNameRowId=@QueryNameRowId
	END
END


