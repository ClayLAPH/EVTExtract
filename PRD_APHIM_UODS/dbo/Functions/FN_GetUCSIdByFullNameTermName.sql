
CREATE FUNCTION [dbo].[FN_GetUCSIdByFullNameTermName]
(
	@FullName AS VARCHAR(255),
	@TermName AS VARCHAR(110)
)
RETURNS INT
AS
BEGIN
	DECLARE @UCSID AS INT

	SELECT TOP(1) @UCSID = VUCS.[ID]
	FROM [V_DictionaryDefinition] VDD (NOLOCK) 
	INNER JOIN [V_UnifiedCodeSet] VUCS (NOLOCK) ON VUCS.domain_ID = VDD.domain_ID
	WHERE VUCS.fullName = @FullName AND VDD.Name = @TermName

	RETURN @UCSID
END
