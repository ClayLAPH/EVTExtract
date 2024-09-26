CREATE FUNCTION [dbo].[FN_EHR_GetDisease]
(
	@isLoinc AS bit=0,
	@code AS VARCHAR(100)
)
RETURNS INT
AS
BEGIN
	
	SET @code=ISNULL(@code,'')
	
	IF @code<>''
	BEGIN
		DECLARE @diseaseDR AS INT
		DECLARE @matchedRecords table(diseaseDR int)

		IF @isLoinc=0
		BEGIN
			INSERT INTO @matchedRecords(diseaseDR)
			SELECT DiseaseDR FROM VCP_EHRCrossReference (nolock) WHERE SNOMEDConceptID = @code OR SNOMEDLegacyCode = @code
		END
			ELSE
		BEGIN
			INSERT INTO @matchedRecords(diseaseDR)
			SELECT DiseaseDR FROM VCP_EHRCrossReference (nolock) WHERE LOINCCode=@code
		END

		SELECT TOP 1 @diseaseDR=MR.diseaseDR FROM @matchedRecords MR
		JOIN VCP_Disease DIS (nolock) ON MR.diseaseDR=DIS.SubjCode_ID AND ISNULL(DIS.ShowInEHRGateway,0)=1
		JOIN V_TermDictionary VT (nolock) ON VT.termCode_ID=DIS.SubjCode_ID AND VT.[name]='Disease'
		WHERE ISNULL(VT.active,0)=1

	END

	RETURN @DiseaseDR
END
