
CREATE FUNCTION [dbo].[FN_GetUCSIdByConceptCodeTermName]
(
	@ConceptCode AS VARCHAR(50),
	@TermName AS VARCHAR(110)
)
RETURNS INT
AS
BEGIN
	DECLARE @UCSID AS INT

	SELECT TOP(1) @UCSID = VUCS.[ID]
	FROM [V_DictionaryDefinition] VDD (NOLOCK) 
	INNER JOIN [V_UnifiedCodeSet] VUCS (NOLOCK) ON VUCS.domain_ID = VDD.domain_ID
	WHERE VUCS.ConceptCode = @ConceptCode AND VDD.Name = @TermName

	RETURN @UCSID
END
