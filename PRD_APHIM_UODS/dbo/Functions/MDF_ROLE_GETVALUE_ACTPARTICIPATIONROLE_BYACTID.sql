﻿CREATE FUNCTION [dbo].[MDF_ROLE_GETVALUE_ACTPARTICIPATIONROLE_BYACTID]
(@ACTID INT, @VALUETYPE VARCHAR(100))
RETURNS INT
AS
BEGIN

RETURN	(
		SELECT      
					CASE @VALUETYPE
						WHEN 'PLAYER_ID'		THEN R_ROLE.PLAYER_ID
						WHEN 'ROLEHX_ID'		THEN  R_ROLE.ROLEHX_ID
						WHEN 'SCOPER_ID'		THEN R_ROLE.SCOPER_ID
					END
		FROM A_ACT (NOLOCK) 
		INNER JOIN  P_PARTICIPATION (NOLOCK) ON A_ACT.ID = P_PARTICIPATION.ACT_ID AND (P_PARTICIPATION.TYPECODE = 'SBJ')
		INNER JOIN R_ROLE (NOLOCK) ON P_PARTICIPATION.ROLE_ID = R_ROLE.ID AND (R_ROLE.CLASSCODE = 'PAT')
		WHERE (A_ACT.ID = @ACTID) AND (A_ACT.CLASSCODE = 'FOLDER')
		)
END

