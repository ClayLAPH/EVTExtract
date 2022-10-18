create view internals.CovidActsView as
select
  PR_NOTES = a.text, 
  PR_DATEINVESTIGATORRECEIVED = a.availabilityTime, 
  PR_LEGACY_ROWID = a.localId, 
  PR_DATEADMITTED = a.valueTS, 
  PR_DATEDISCHARGED = a.ValueTSEnd,
  PR_ROWID = a.ID, 

  PR_REPORTEDBYWEB = ReportedByWeb.valueBool,
  PR_REPORTEDBYLAB = ReportedByLab.valueBool,
  PR_REPORTEDBYEHR = ReportedByEHR.valueBool,
  PR_TRANSMISSIONSTATUS = TransmissionStatusUCS.fullName,

  PR_DIAGSPECIMENTYPES = diagSpecimenTypes.valueString_Txt,
  PR_EXPEXPOSURETYPES = exposureTypes.valueString_Txt,
  PR_HEPATITISDRS = hepTypes.valueString_Txt,
  PR_DISEASEGROUPS = diseases.valueString,
  PR_OTHERDISEASE = otherDisease.valueString_Txt,

  PR_RESULTVALUE = LipTestResult.valueString_Txt,
  PR_LIPTESTORDERED = LipTestOrdered.valueString_Txt,
  PR_ISPREGNANT = IsPregnant.valueBool,
  PR_EXPECTEDDELIVERYDATE = ExpectedDeliveryDate.valueTS,

  PR_DATEOFDEATH = DateOfDeath.effectiveTime_Beg,
  PR_ISSYMPTOMATIC = ~IsAsymptomatic.valueBool,
  PR_ISPATIENTDIEDOFTHEILLNESS = IsPatientDiedDOfTheIllness.valueBool,
  PR_ISPATIENTHOSPITALIZED = phc.hospitalizedInd,

  PR_LABSPECIMENCOLLECTEDDATE = LabSpecimenCollectedDate.effectiveTime_Beg,
  PR_LABSPECIMENRESULTDATE = LabSpecimenResultDate.effectiveTime_Beg,

  PR_OUTPATIENT = Outpatient.valueBool,
  PR_INPATIENT = Inpatient.valueBool,
  PR_NAMEOFSUBMITTER = NameOfSubmitter.valueString,

  PR_HOSPITAL = hospitalEntity.trivialName,
  PR_HOSPITALDR = hospitalRole.player_ID,

  PR_ANIMALREPORTID = animalReport.DVAI_AnimalReportID,

  PR_FBIDR = FBIRelationship.source_ID,
  PR_FBINumber = FBIIdentifier.extension



from
  [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr with (nolock)
  inner join
  [$(PRD_APHIM_UODS)].dbo.A_Act                     a with (nolock)
  on 
    pr.DVPR_RowID = a.ID
  inner join
  [$(PRD_APHIM_UODS)].dbo.A_PublicHealthCase        phc with (nolock)
  on
    phc.ID = a.ID

  left outer join
  internals.CovidActsAndAtts                        diseases with (nolock)
  on
    a.id = diseases.id and
    diseases.kind = 'PR_ROWID'
  left outer join
  internals.CovidActsAndAtts                        diagSpecimenTypes with (nolock)
  on
    a.id = diagSpecimenTypes.id and
    diagSpecimenTypes.kind = 'DIST_ROWID'
  left outer join
  internals.CovidActsAndAtts                        exposureTypes with (nolock)
  on
    a.id = exposureTypes.id and
    exposureTypes.kind = 'DIET_ROWID'
  left outer join
  internals.CovidActsAndAtts                        hepTypes with (nolock)
  on
    a.id = hepTypes.id and
    hepTypes.kind = 'DIHT_HEPATITISTESTDR'
  left outer join
  internals.CovidActsAndAtts                        otherDisease with (nolock)
  on
    a.id = otherDisease.id and
    otherDisease.kind = 'PR_OTHERDISEASENAME'
  left outer join
  internals.CovidActsAndAtts                        ReportedByWeb with (nolock)
  on
    a.id = ReportedByWeb.id and
    ReportedByWeb.kind = 'PR_REPORTEDBYWEB'
  left outer join
  internals.CovidActsAndAtts                        ReportedByLab with (nolock)
  on
    a.id = ReportedByLab.id and
    ReportedByLab.kind = 'PR_REPORTEDBYLAB'
  left outer join
  internals.CovidActsAndAtts                        ReportedByEHR with (nolock)
  on
    a.id = ReportedByEHR.id and
    ReportedByEHR.kind = 'PR_REPORTEDBYEHR'
  left outer join
  internals.CovidActsAndAtts                        LipTestResult with (nolock)
  on
    a.id = LipTestResult.id and
    LipTestResult.kind = 'PR_LIPRESULTVALUE'
  left outer join
  internals.CovidActsAndAtts                        IsPregnant with (nolock)
  on
    a.id = IsPregnant.id and
    IsPregnant.kind = 'PR_ISPREGNANT'
  left outer join
  internals.CovidActsAndAtts                        ExpectedDeliveryDate with (nolock)
  on
    a.id = ExpectedDeliveryDate.id and
    ExpectedDeliveryDate.kind = 'PR_EXPECTEDDELIVERYDATE'
  left outer join
  internals.CovidActsAndAtts                        LipTestOrdered with (nolock)
  on
    a.id = LipTestOrdered.id and
    LipTestOrdered.kind = 'PR_LIPTESTORDERED'
  left outer join
  internals.CovidActsAndAtts                        DateOfDeath with (nolock)
  on
    a.id = DateOfDeath.id and
    DateOfDeath.kind = 'PR_DATEOFDEATH'
  left outer join
  internals.CovidActsAndAtts                        IsAsymptomatic with (nolock)
  on
    a.id = IsAsymptomatic.id and
    IsAsymptomatic.kind = 'PR_ISASYMPTOMATIC'
  left outer join
  internals.CovidActsAndAtts                        IsPatientDiedDOfTheIllness with (nolock)
  on
    a.id = IsPatientDiedDOfTheIllness.id and
    IsPatientDiedDOfTheIllness.kind = 'PR_ISPATIENTDIEDOFTHEILLNESS'
  left outer join
  internals.CovidActsAndAtts                        LabSpecimenCollectedDate with (nolock)
  on
    a.id = LabSpecimenCollectedDate.id and
    LabSpecimenCollectedDate.kind = 'PR_LABSPECIMENCOLLECTEDDATE'
  left outer join
  internals.CovidActsAndAtts                        LabSpecimenResultDate with (nolock)
  on
    a.id = LabSpecimenResultDate.id and
    LabSpecimenResultDate.kind = 'PR_LABSPECIMENRESULTDATE'
  left outer join
  internals.CovidActsAndAtts                        Outpatient with (nolock)
  on
    a.id = Outpatient.id and
    Outpatient.kind = 'PR_OUTPATIENT'
  left outer join
  internals.CovidActsAndAtts                        Inpatient with (nolock)
  on
    a.id = Inpatient.id and
    Inpatient.kind = 'PR_INPATIENT'
  left outer join
  internals.CovidActsAndAtts                        NameOfSubmitter with (nolock)
  on
    a.id = NameOfSubmitter.id and
    NameOfSubmitter.kind = 'PR_NAMEOFSUBMITTER'
  left outer join
  internals.CovidActsAndAtts                        TransmissionStatusAttribute with (nolock)
  on
    a.id = TransmissionStatusAttribute.id and
    TransmissionStatusAttribute.kind = 'PR_TRANSMISSIONSTATUS'
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          TransmissionStatusUCS with (nolock)
  on
    TransmissionStatusAttribute.valueCode_ID = TransmissionStatusUCS.ID
  -------------------------------------------------------------------
  left outer join
  [$(PRD_APHIM_UODS)].dbo.P_Participation part with (nolock)
  on
    part.Act_Id = a.Id and
    part.metaCode = 'PR_HOSPITALDR'
  left outer join
  [$(PRD_APHIM_UODS)].dbo.R_Role hospitalRole with (nolock)
  on 
    hospitalRole.ID = part.Role_ID and
    hospitalRole.classCode = 'QUAL' 
  left outer join
  [$(PRD_APHIM_UODS)].dbo.T_EntityName hospitalEntity with (nolock)
  on 
    hospitalEntity.Entity_ID = hospitalRole.player_ID and 
    hospitalEntity.useCode = 'SRCH' and 
    hospitalEntity.metaCode = 'LOC_NAME' 
  -------------------------------------------------------------------
  left outer join
  [$(PRD_APHIM_UODS)].dbo.A_ActRelationship         FBIRelationship with (nolock)
  on 
    a.ID = FBIRelationship.target_ID and 
    FBIRelationship.typeCode = 'COMP' and 
    FBIRelationship.metaCode = 'PR_FBIDR' 
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_InstanceIdentifier      FBIIdentifier with (nolock)
  on 
    FBIRelationship.source_ID = FBIIdentifier.Act_ID
  -------------------------------------------------------------------
  left outer join
  [$(PRD_APHIM_UODS)].dbo.A_ActRelationship         animalRelationship with (nolock)
  on 
    a.ID = animalRelationship.target_ID and
    animalRelationship.typeCode = 'COMP' and
    animalRelationship.metaCode in ('AI_CONTACTINVESTIGATIONDR', 'AI_DISEASEINCIDENTDR') 
  left outer join
  [$(PRD_APHIM_UODS)].dbo.DV_AnimalReport           animalReport with (nolock)
  on
    animalReport.DVAI_RowID = animalRelationship.source_ID



where
  a.metaCode='PR_ROWID'
  and
  pr.DVPR_DiseaseCode_ID = 543030;
