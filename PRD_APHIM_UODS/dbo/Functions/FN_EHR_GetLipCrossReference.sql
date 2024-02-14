
Create Function FN_EHR_GetLipCrossReference(@code varchar(200), @codeSystem varchar(50), @diseaseDR int)
RETURNS INT
AS
BEGIN
	Declare @returnValue int=0
	IF @codeSystem='2.16.840.1.113883.6.96'
	BEGIN
		SELECT TOP 1 @returnValue=SubjCode_ID from VCP_EHRCrossReference (nolock) WHERE DiseaseDR=@diseaseDR AND (SNOMEDConceptID=@code OR SNOMEDLegacyCode=@code)
	END
	ELSE IF @codeSystem='2.16.840.1.113883.6.1'
	BEGIN
		SELECT TOP 1 @returnValue=SubjCode_ID from VCP_EHRCrossReference (nolock) WHERE DiseaseDR=@diseaseDR AND LOINCCode=@code
	END
return @returnValue
END

