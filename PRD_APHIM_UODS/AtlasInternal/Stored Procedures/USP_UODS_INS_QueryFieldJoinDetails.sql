
CREATE PROCEDURE [AtlasInternal].[USP_UODS_INS_QueryFieldJoinDetails]
(
	@QueryNameRowId int, 
	@Field_Name varchar(250), 
	@DBFieldName varchar(250), 
	@DBFieldTableAlias varchar(250), 
	@Field_IsComputed bit, 
	@DBTableName varchar(250), 
	@DBTableAlias varchar(250),
	@DBTableJoinType varchar(250), 
	@DBTableJoinCondition varchar(250),
	@DBTableJoinOrder int
)
AS 
BEGIN

BEGIN	--BLK_VarDeclaration
	DECLARE @FieldJoinEntry AS BIT
	SET @FieldJoinEntry = 0
END

BEGIN	--BLK_CreateDefinition
	If Exists (SELECT 1 FROM S_DBQueryFieldJoin (NOLOCK)
					WHERE QueryId = @QueryNameRowId AND FIELD_Name = @Field_Name AND ISNULL(DBTableName, '') = ISNULL(@DBTableName, '') 
								AND ISNULL(DBTableAlias, '') = ISNULL(@DBTableAlias, '') AND ISNULL(DBTableJoinOrder, '') = ISNULL(@DBTableJoinOrder, ''))
	BEGIN
		SET @FieldJoinEntry = 1
	END
	ELSE
	BEGIN
		INSERT INTO S_DBQueryFieldJoin (QueryId, FIELD_Name, DBFieldName, DBFieldTableAlias, 
											FIELD_IsComputed, DBTableName, DBTableAlias, DBTableJoinType, DBTableJoinCondition, DBTableJoinOrder)
				VALUES(@QueryNameRowId, @Field_Name, @DBFieldName, @DBFieldTableAlias, 
							@Field_IsComputed, @DBTableName, @DBTableAlias,@DBTableJoinType, @DBTableJoinCondition, @DBTableJoinOrder)
		RETURN
	END
END

BEGIN	--BLK_ExistingRecords
	If @FieldJoinEntry = 1
	BEGIN
		IF EXISTS (SELECT 1 FROM S_DBQueryFieldJoin (NOLOCK)
					WHERE QueryId = @QueryNameRowId AND FIELD_Name = @Field_Name AND DBTableName = @DBTableName AND DBTableAlias = @DBTableAlias 
						AND DBTableJoinType = @DBTableJoinType AND DBTableJoinCondition = @DBTableJoinCondition AND DBTableJoinOrder = @DBTableJoinOrder)
		BEGIN
			PRINT 'Record already exists'
		END
		ELSE
		BEGIN
			RAISERROR('Record found with different values',16,100)
		END
	END
END

END



--------******* CREATE Stored Proc USP_UODS_DEL_QueryFields *******--------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[AtlasInternal].[USP_UODS_DEL_QueryFields]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [AtlasInternal].[USP_UODS_DEL_QueryFields]

