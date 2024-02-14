﻿
CREATE FUNCTION [DBO].[MDF_ENTTELECOM_ADDRESS_ENTITY_BYENTITYID]
(@ENTITYID INT, @USECODE VARCHAR(50), @SCHEME VARCHAR(50))
RETURNS VARCHAR(100)
AS
BEGIN

RETURN
	   (
		SELECT ENTTELECOM.[ADDRESS]
		FROM 
			E_ENTITY (NOLOCK) 
			INNER JOIN T_ENTITYTELECOM ENTTELECOM  (NOLOCK) ON ENTTELECOM.ENTITY_ID = E_ENTITY.ID
		WHERE
			ENTTELECOM.USECODE = @USECODE AND ENTTELECOM.[SCHEME] = @SCHEME AND E_ENTITY.ID =@ENTITYID
		)
END