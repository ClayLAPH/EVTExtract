create view dbo.Domain as
select 
  d.ID,
  d.domainOid,
  d.domainName,
  d.systemOid,
  d.systemName,
  d.externalOid,
  d.internal,
  d.[external],
  d.description
from [$(PRD_APHIM_UODS)].dbo.V_Domain d
