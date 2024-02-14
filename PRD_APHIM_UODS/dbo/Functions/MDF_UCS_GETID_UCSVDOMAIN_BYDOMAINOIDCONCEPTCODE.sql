﻿
CREATE FUNCTION [DBO].[MDF_UCS_GETID_UCSVDOMAIN_BYDOMAINOIDCONCEPTCODE]
(@DOMAINOID AS VARCHAR(50), @CONCEPTCODE AS VARCHAR(50))
RETURNS INT
AS

BEGIN

RETURN	(
			SELECT		V_UNIFIEDCODESET.ID 
			FROM		V_UNIFIEDCODESET (NOLOCK) 
						INNER JOIN V_DOMAIN  (NOLOCK) ON V_DOMAIN.ID = V_UNIFIEDCODESET.DOMAIN_ID
			WHERE		V_DOMAIN.DOMAINOID = @DOMAINOID AND V_UNIFIEDCODESET.CONCEPTCODE = @CONCEPTCODE
		)
END
