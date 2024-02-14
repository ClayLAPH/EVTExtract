
CREATE FUNCTION [dbo].[FN_GetNextConceptCode]  (@Domain_ID int)
	RETURNS INT
AS
BEGIN
	DECLARE @NextConceptCode INT
	SELECT @NextConceptCode=Max(ConceptId) FROM V_UnifiedCodeSet (nolock) WHERE Domain_ID=@Domain_ID
	If(@NextConceptCode<0)
	BEGIN
		SET @NextConceptCode = 0
	END
	RETURN ISNULL(@NextConceptCode, 0) + 1
END


