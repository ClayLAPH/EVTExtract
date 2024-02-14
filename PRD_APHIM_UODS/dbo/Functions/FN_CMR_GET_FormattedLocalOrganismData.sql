

CREATE FUNCTION [dbo].[FN_CMR_GET_FormattedLocalOrganismData] (@LocOrg VARCHAR(2000))
	RETURNS VARCHAR(2000)
AS
BEGIN
	DECLARE @LocalOrg VARCHAR(2000)
	SET @LocOrg = ISNULL(@LocOrg, '')
	SELECT @LocalOrg =  SUBSTRING(@LocOrg, 0, CHARINDEX('||', @LocOrg))
	If @LocalOrg <> ''
	BEGIN
		RETURN 	@LocalOrg
	END
	RETURN 	SUBSTRING(@LocOrg, CHARINDEX('||', @LocOrg)+2, LEN(@LocOrg))
END
