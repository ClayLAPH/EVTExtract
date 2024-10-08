﻿
CREATE FUNCTION [DBO].[MDF_ADDRPART_ADDRESS_ENTADDRADDRPART_BYADDRIDUSECODE]
(@ENTITYADRESSID INT, @PARTTYPE VARCHAR(50), @USECODE VARCHAR(20))

RETURNS VARCHAR(100)
AS
BEGIN

RETURN
	(
	 SELECT T_ADDRESSPART.ADDRESS 
	 FROM T_ENTITYADDRESS (NOLOCK) 
	 INNER JOIN T_ADDRESSPART  (NOLOCK) ON T_ADDRESSPART.ADDRESS_ID = T_ENTITYADDRESS.ID AND T_ADDRESSPART.PARTTYPE = @PARTTYPE
	 WHERE T_ENTITYADDRESS.USECODE = @USECODE AND T_ENTITYADDRESS.ENTITY_ID = @ENTITYADRESSID
	)
END
