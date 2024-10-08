﻿
CREATE FUNCTION [DBO].[MDF_ATTR_GETINTEGERVALUE_ACTATTR_BYACTID]
(@ACTID INT, @NAME VARCHAR(50))
RETURNS INT
AS
BEGIN

RETURN	(
	SELECT      
		T_ATTRIBUTE.VALUEINTEGER 
	FROM         A_ACT (NOLOCK) INNER JOIN T_ATTRIBUTE  (NOLOCK) ON A_ACT.ID = T_ATTRIBUTE.ACT_ID
	WHERE     (A_ACT.ID = @ACTID AND T_ATTRIBUTE.[NAME] = @NAME)
	)
END
