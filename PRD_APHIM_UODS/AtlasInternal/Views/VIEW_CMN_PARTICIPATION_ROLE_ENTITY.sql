﻿
CREATE VIEW [ATLASINTERNAL].[VIEW_CMN_PARTICIPATION_ROLE_ENTITY]
AS
SELECT
	DBO.P_PARTICIPATION.ACT_ID, 
	DBO.T_ENTITYNAME.TRIVIALNAME, 
	DBO.V_UNIFIEDCODESET.FULLNAME, 
	DBO.P_PARTICIPATION.TYPECODE, 
	DBO.T_ENTITYNAME.PARTFAM, 
	DBO.T_ENTITYNAME.PARTGIV, 
	DBO.T_ENTITYNAME.PARTFAM + ', ' + DBO.T_ENTITYNAME.PARTGIV AS NAMECOMBINED, 
	DBO.R_ROLE.ID AS ROLEID, 
	DBO.R_ROLE.CODE_ID AS ROLE_CODE_ID, 
	DBO.T_ENTITYNAME.USECODE
FROM
	DBO.P_PARTICIPATION (NOLOCK) 
	INNER JOIN DBO.R_ROLE  (NOLOCK) ON DBO.R_ROLE.ID = DBO.P_PARTICIPATION.ROLE_ID 
	INNER JOIN DBO.E_ENTITY  (NOLOCK) ON DBO.E_ENTITY.ID = DBO.R_ROLE.PLAYER_ID 
	INNER JOIN DBO.T_ENTITYNAME  (NOLOCK) ON DBO.T_ENTITYNAME.ENTITY_ID = DBO.E_ENTITY.ID 
INNER JOIN DBO.V_UNIFIEDCODESET  (NOLOCK) ON DBO.R_ROLE.CODE_ID = DBO.V_UNIFIEDCODESET.ID