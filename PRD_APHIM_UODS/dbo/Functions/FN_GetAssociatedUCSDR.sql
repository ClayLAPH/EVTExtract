
CREATE FUNCTION [dbo].[FN_GetAssociatedUCSDR]
(
    @sourceConceptCode AS VARCHAR(50),
    @sourceTermName AS VARCHAR(50),
    @targetConceptCode AS VARCHAR(50)
)
RETURNS INT
AS
BEGIN
    DECLARE @UCSID AS INT

    SELECT TOP (1) @UCSID = [UCSAUTHY].[ID] FROM V_UnifiedCodeSet UCSIdentifier (NOLOCK) 
    INNER JOIN V_Domain VDUCS (NOLOCK)  ON UCSIdentifier.domain_ID=VDUCS.ID AND VDUCS.domainName=@sourceTermName
    INNER JOIN V_DictionaryDefinition VDDAUTHY (NOLOCK)  ON VDDAUTHY.[name] = [UCSIdentifier].[shortName]
    INNER JOIN V_UnifiedCodeSet UCSAUTHY (NOLOCK)  ON UCSAUTHY.domain_ID = VDDAUTHY.domain_ID AND UCSAUTHY.conceptCode=@targetConceptCode
    WHERE [UCSIdentifier].[conceptCode] = @sourceConceptCode

    RETURN @UCSID
END

