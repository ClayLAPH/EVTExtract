﻿
CREATE FUNCTION [DBO].[MDF_ATTR_GETDATETIMEVALUE_ACTATTR_BYACTID]
(@ACTID INT, @VALUETYPE VARCHAR(100), @NAME VARCHAR(50))
RETURNS DATETIME
AS
BEGIN

RETURN	(
		SELECT      
			CASE @VALUETYPE
				WHEN 'VALUETS'	THEN  T_ATTRIBUTE.VALUETS  
				WHEN 'VALUETSEND' THEN  T_ATTRIBUTE.VALUETSEND  
			END
		FROM         A_ACT (NOLOCK) INNER JOIN T_ATTRIBUTE  (NOLOCK) ON A_ACT.ID = T_ATTRIBUTE.ACT_ID
		WHERE     (A_ACT.ID = @ACTID AND T_ATTRIBUTE.[NAME] = @NAME)
		)
END
