﻿
CREATE FUNCTION [DBO].[MDF_ENTTELECOM_ADDRESS_ROLE_BYROLEID]
(@ROLEID INT, @USECODE VARCHAR(50), @SCHEME VARCHAR(50))
RETURNS VARCHAR(100)
AS
BEGIN

RETURN
	   (
		SELECT ENTTELECOM.[ADDRESS]
		FROM 
			R_ROLE (NOLOCK) 
			INNER JOIN T_ENTITYTELECOM ENTTELECOM  (NOLOCK) ON ENTTELECOM.ROLE_ID = R_ROLE.ID
		WHERE
			ENTTELECOM.USECODE = @USECODE AND ENTTELECOM.[SCHEME] = @SCHEME AND R_ROLE.ID =@ROLEID
		)
END
