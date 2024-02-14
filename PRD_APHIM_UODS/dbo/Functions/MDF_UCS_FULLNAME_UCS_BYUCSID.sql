﻿
CREATE FUNCTION [DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID]
(@UCSID INT)
RETURNS VARCHAR(255)
AS
BEGIN
	RETURN 
	(SELECT     FULLNAME
	FROM         V_UNIFIEDCODESET (NOLOCK)
	WHERE     (ID = @UCSID))
END