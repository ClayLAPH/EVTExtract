create view dbo.UnifiedCodeSet as
select 
	u.valueSet,
	u.conceptId,
	u.conceptCode,
	u.fullName,
	u.shortName,
	u.otherInfo,
	u.statusActive,
	u.statusCode,
	u.systemVersion,
	u.lastUpdate,
	u.ID,
	u.domain_ID,
	u.equivUCS_ID,
	u.externalOid
from [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet u