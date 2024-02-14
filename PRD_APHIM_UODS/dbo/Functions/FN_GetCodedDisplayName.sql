
CREATE   FUNCTION [dbo].[FN_GetCodedDisplayName]
(
    @ConceptCode AS VARCHAR(50),
    @TermName as VARCHAR(110),
    @attributeNo tinyint = 1
)
RETURNS varchar(255)
AS
BEGIN
    DECLARE @displayName AS varchar(255)

    SELECT TOP(1) @displayName = CASE 
                                        WHEN @attributeNo = 1 THEN  VUCS.shortName
                                        WHEN @attributeNo = 2 THEN  VUCS.fullName
                                        WHEN @attributeNo = 3 THEN  VTERM.termDisplay
                                        WHEN @attributeNo = 0 THEN  ISNULL(NULLIF(VTERM.termDisplay,''), VUCS.fullName)
                                END     
    FROM [V_DictionaryDefinition] VDD (NOLOCK) 
    INNER JOIN [V_UnifiedCodeSet] VUCS (NOLOCK) ON VUCS.domain_ID = VDD.domain_ID
    LEFT JOIN [V_TermDictionary] VTERM (NOLOCK) ON VTERM.termCode_ID = VUCS.ID AND VTERM.[name] = @TermName
    WHERE VUCS.ConceptCode = @ConceptCode AND VDD.Name = @TermName ORDER BY VUCS.ID DESC

    RETURN @displayName
END
