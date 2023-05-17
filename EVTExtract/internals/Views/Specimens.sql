create view internals.Specimens as
select        
  PR_INCIDENTID                 = ph.DVPR_IncidentID, 
  [Specimen Types]              = specTypeName.fullName, 
  [Specimen Collected Date]     = specs.DVIS_CollectionDate, 
  [Specimen Received Date]      = specs.DVIS_ReceivedDate, 
  Result                        = specs.DVIS_SpecimenResults, 
  [Specimen Notes]              = lab.DILR_Notes, 
  [Lab Report ID]               = lab.DILR_ID,
  DiseaseCode                   = ph.DVPR_DiseaseCode_ID
from
  [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord       ph with (nolock)
  inner join
  [$(PRD_APHIM_UODS)].dbo.DV_IncidentSpecimen       specs with (nolock) 
  on 
    specs.DVIS_IncidentDR = ph.DVPR_RowID 
  inner join
  [$(PRD_APHIM_UODS)].dbo.A_Act                     act with (nolock) 
  on 
    act.ID = specs.DVIS_RowID AND 
    act.statusCode <> 'nullified' 
  inner join
  internals.Ax_LabReport                            lab with (nolock) 
  on 
    act.ID = lab.DILR_ID 
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          specTypeName with (nolock) 
  on 
    specTypeName.ID = specs.DVIS_SpecimenTypeCode_ID
where
  ph.DVPR_RowID not in ( select DVPR_RowID from internals.Sars2Archive )
