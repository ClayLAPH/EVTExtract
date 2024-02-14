
CREATE FUNCTION [dbo].[UDF_GetRootEntityID](  
 @ENTITYID INT 
)  
RETURNS INT
AS  
BEGIN  
    Declare @RootEntityID INT 
	Declare @Count INT = 0

	Select @Count = Count(player_ID) from R_Role MR (NOLOCK)
	Where MR.classCode = 'SUBY'  AND MR.statusCode = 'Completed' AND MR.player_ID = MR.scoper_ID 
	AND MR.player_ID = @ENTITYID
	 
	IF @Count = 0 
		BEGIN
			;With MergedRecords AS
			(
				Select scoper_ID, player_ID from R_Role (NOLOCK) Where classCode = 'SUBY' AND statusCode = 'Completed' AND player_ID = @ENTITYID
				Union ALL
				Select R_Role.scoper_ID, R_Role.player_ID  from MergedRecords MR
				Inner Join R_Role (NOLOCK) ON R_Role.player_ID = MR.scoper_ID and classCode = 'SUBY' and statusCode = 'Completed' 
				AND MR.scoper_ID <> MR.player_ID
			)
			SELECT @RootEntityID= MR.scoper_ID FROM MergedRecords MR
			INNER JOIN E_Entity (NOLOCK) ON E_Entity.ID = MR.scoper_ID AND E_Entity.STATUSCODE <> 'TERMINATED'
		END
	ELSE
		BEGIN
			SELECT @RootEntityID= MR.scoper_ID FROM R_Role MR (NOLOCK)
			INNER JOIN E_Entity (NOLOCK) ON E_Entity.ID = MR.scoper_ID AND E_Entity.STATUSCODE <> 'TERMINATED'
			AND MR.classCode = 'SUBY'  AND MR.statusCode = 'Completed' AND MR.player_ID = @ENTITYID
		END
    RETURN @RootEntityID
END
