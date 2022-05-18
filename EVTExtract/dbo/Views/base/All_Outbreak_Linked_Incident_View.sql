create view dbo.ALL_OUTBREAK_LINKED_INCIDENT_VIEW as 
select 
  Disease = ob.DVOB_DiseaseCode_ID,
  ob.dvob_rowid,
  dv_person.dvper_lastname + ', ' + dv_person.dvper_firstname LinkedIndividuals, 
  dv_phpersonalrecord.dvpr_incidentid IncidentID,
  v_unifiedcodeset.conceptcode RecordType,
  dv_person.dvper_lastname + ', ' +dv_person.dvper_firstname + ' ' +  CAST(dv_phpersonalrecord.dvpr_incidentid AS VARCHAR) + ' ' + v_unifiedcodeset.conceptcode concatendated
from
  [$(PRD_APHIM_UODS)].dbo.dv_outbreak ob with (nolock) 
  INNER JOIN 
  [$(PRD_APHIM_UODS)].dbo.a_act LPA_O1 (nolock) 
  ON 
    LPA_O1.id = ob.dvob_rowid AND 
    ( 
      LPA_O1.valuestring_txt <> 'STAGE' OR 
      LPA_O1.valuestring_txt IS NULL
    )
  LEFT outer JOIN 
  [$(PRD_APHIM_UODS)].dbo.a_act LPA_O2 with (nolock) 
  ON 
    LPA_O1.id = LPA_O2.act_parent_id AND 
    LPA_O2.classcode = 'OBS' AND 
    LPA_O2.metacode = 'OB_SUBMITTEDBY' 

  INNER JOIN 
  [$(PRD_APHIM_UODS)].dbo.a_actrelationship with (nolock) 
  ON 
    ob.dvob_rowid = a_actrelationship.source_id
  INNER JOIN 
  [$(PRD_APHIM_UODS)].dbo.dv_phpersonalrecord with (nolock) 
  ON 
    a_actrelationship.target_id = dv_phpersonalrecord.dvpr_rowid
  INNER JOIN 
  internals.dv_person (nolock) 
  ON 
    dv_person.dvper_rowid = dv_phpersonalrecord.dvpr_persondr 
  INNER JOIN 
  [$(PRD_APHIM_UODS)].dbo.v_unifiedcodeset (nolock) 
  ON 
    v_unifiedcodeset.id = dv_phpersonalrecord.dvpr_typedr 
where  
  ob.dvob_rowid in (select DVOB_RowID from [$(PRD_APHIM_UODS)].dbo.DV_Outbreak with (nolock) where DVPR_DiseaseCode_ID not in ( 543030, 544041, 509985 ) ) -- covid, sars2, unknown respiratory
