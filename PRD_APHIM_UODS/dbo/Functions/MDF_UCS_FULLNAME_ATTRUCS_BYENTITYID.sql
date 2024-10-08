﻿

CREATE FUNCTION [dbo].[MDF_UCS_FULLNAME_ATTRUCS_BYENTITYID]
(@ENTITYID INT, @VALUETYPE VARCHAR(100), @NAME VARCHAR(100))
RETURNS VARCHAR(255)
AS
--THIS FUNCTION USES A CASE STATEMENT TO DETERMINE WHICH FIELD TO USE IN THE JOIN CLAUSE
BEGIN                    
	RETURN
		(               
			SELECT TOP 1 V_UNIFIEDCODESET.FULLNAME
			FROM         T_ATTRIBUTE (NOLOCK)  INNER JOIN  V_UNIFIEDCODESET (NOLOCK) ON 
							CASE @VALUETYPE
								WHEN 'VALUECODE_ID'					THEN T_ATTRIBUTE.VALUECODE_ID
								WHEN 'VALUEDENOMINATOR_ALT_UNIT_ID'	THEN T_ATTRIBUTE.VALUEDENOMINATOR_ALT_UNIT_ID
								WHEN 'VALUENUMERATOR_ALT_UNIT_ID'	THEN T_ATTRIBUTE.VALUENUMERATOR_ALT_UNIT_ID
							END
						= V_UNIFIEDCODESET.ID
			WHERE     (T_ATTRIBUTE.ENTITY_ID = @ENTITYID AND T_ATTRIBUTE.NAME = @NAME)
		)
END

