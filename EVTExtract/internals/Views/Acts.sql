create view internals.Acts as
select
  PR_NOTES = a.text, 
  PR_DATEINVESTIGATORRECEIVED = a.availabilityTime, 
  a.metaCode, 
  PR_LEGACY_ROWID = a.localId, 
  PR_DATEADMITTED = a.valueTS, 
  PR_DATEDISCHARGED = a.ValueTSEnd,
  PR_ROWID = a.ID, 
  PR_REPORTEDBYWEB = ReportedByWeb.valueBool,
  PR_REPORTEDBYLAB = ReportedByLab.valueBool,
  PR_REPORTEDBYEHR = ReportedByEHR.valueBool,
  PR_TRANSMISSIONSTATUS = TransmissionStatusUCS.fullName,

  PR_DIAGSPECIMENTYPES = diagSpecimenTypes.typeNames,
  PR_EXPEXPOSURETYPES = exposureTypes.typeNames,
  PR_HEPATITISDRS = hepTypes.typeNames,
  PR_DISEASEGROUPS = diseases.names,
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

  PR_HOSPITAL = hospitaInfo.trivialName,
  PR_HOSPITALDR = hospitaInfo.player_ID,

  PR_ANIMALREPORTID = animalReport.DVAI_AnimalReportID,

  PR_FBIDR = FBIRelationship.source_ID,
  PR_FBINumber = FBIIdentifier.extension



from
  [$(PRD_APHIM_UODS)].dbo.A_Act                     a with (nolock)
  inner join
  [$(PRD_APHIM_UODS)].dbo.A_PublicHealthCase        phc with (nolock)
  on
    phc.ID = a.ID
  left outer join
  internals.ActCodeIdToDiseaseGroups                diseases with (nolock)
  on
    a.code_ID = diseases.code_id

  outer apply
  internals.DiagnosticTypes(a.ID, 'DIST_ROWID') 
                                                    diagSpecimenTypes
  outer apply
  internals.DiagnosticTypes(a.ID, 'DIET_ROWID') 
                                                    exposureTypes
  outer apply
  internals.DiagnosticTypes(a.ID, 'DIHT_HEPATITISTESTDR') 
                                                    hepTypes
  outer apply
  internals.Hospital( a.ID ) 
                                                    hospitaInfo
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
  left outer join
  [$(PRD_APHIM_UODS)].dbo.A_Act                     otherDisease with (nolock)
  on
    a.ID = otherDisease.Act_Parent_ID and
    otherDisease.metaCode = 'PR_OTHERDISEASENAME' 
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_Attribute               ReportedByWeb with (nolock)
  on
    a.ID = ReportedByWeb.Act_ID and
    ReportedByWeb.name = 'PR_REPORTEDBYWEB'
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_Attribute               ReportedByLab with (nolock)
  on
    a.ID = ReportedByLab.Act_ID and
    ReportedByLab.name = 'PR_REPORTEDBYLAB'
  left outer join
  [$(PRD_APHIM_UODS)].dbo.T_Attribute               ReportedByEHR with (nolock)
  on
    a.ID = ReportedByEHR.Act_ID and
    ReportedByEHR.name = 'PR_REPORTEDBYEHR'
  left outer join
  [$(PRD_APHIM_UODS)].dbo.T_Attribute               TransmissionStatusAttribute with (nolock)
  on
    a.ID = TransmissionStatusAttribute.ACT_ID and
    TransmissionStatusAttribute.name = 'PR_TRANSMISSIONSTATUS'
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          TransmissionStatusUCS with (nolock)
  on
    TransmissionStatusAttribute.valueCode_ID = TransmissionStatusUCS.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.A_Act                     LipTestResult with (nolock)
  on
    a.ID = LipTestResult.Act_Parent_ID and
    LipTestResult.metaCode = 'PR_LIPRESULTVALUE'
  left outer join
  [$(PRD_APHIM_UODS)].dbo.A_Act                     IsPregnant with (nolock)
  on
     a.ID = IsPregnant.Act_Parent_ID and
    IsPregnant.metaCode = 'PR_ISPREGNANT'
  left outer join
  [$(PRD_APHIM_UODS)].dbo.A_Act                     ExpectedDeliveryDate with (nolock)
  on
    a.ID = ExpectedDeliveryDate.Act_Parent_ID and
    ExpectedDeliveryDate.metaCode = 'PR_EXPECTEDDELIVERYDATE'
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_Attribute               LipTestOrdered with (nolock)
  on
    a.ID = LipTestOrdered.Act_ID and 
    LipTestOrdered.name = 'PR_LIPTESTORDERED'
  left outer join
  [$(PRD_APHIM_UODS)].dbo.A_Act                     DateOfDeath with (nolock)
  on
    a.ID = DateOfDeath.Act_Parent_ID and
    DateOfDeath.metaCode = 'PR_DATEOFDEATH'
  left outer join
  [$(PRD_APHIM_UODS)].dbo.A_Act                     IsAsymptomatic with (nolock)
  on
    a.ID = IsAsymptomatic.Act_Parent_ID and
    IsAsymptomatic.metaCode = 'PR_ISASYMPTOMATIC'
  left outer join
  [$(PRD_APHIM_UODS)].dbo.A_Act                     IsPatientDiedDOfTheIllness with (nolock)
  on
    a.ID = IsPatientDiedDOfTheIllness.Act_Parent_ID and
    IsPatientDiedDOfTheIllness.metaCode = 'PR_ISPATIENTDIEDOFTHEILLNESS'
--------------------------------------------------------------------------------
  left outer join
  [$(PRD_APHIM_UODS)].dbo.A_Act                     LabSpecimenCollectedDate with (nolock)
  on
    a.ID = LabSpecimenCollectedDate.Act_Parent_ID and
    LabSpecimenCollectedDate.metaCode = 'PR_LABSPECIMENCOLLECTEDDATE'
  left outer join
  [$(PRD_APHIM_UODS)].dbo.A_Act                     LabSpecimenResultDate with (nolock)
  on
    a.ID = LabSpecimenResultDate.Act_Parent_ID and
    LabSpecimenResultDate.metaCode = 'PR_LABSPECIMENRESULTDATE'
--------------------------------------------------------------------------------
  left outer join
  [$(PRD_APHIM_UODS)].dbo.T_Attribute               Outpatient with (nolock)
  on
    a.ID = Outpatient.Act_ID and
    Outpatient.name = 'PR_OUTPATIENT'
  left outer join
  [$(PRD_APHIM_UODS)].dbo.T_Attribute               Inpatient with (nolock)
  on
    a.ID = Inpatient.Act_ID and
    Inpatient.name = 'PR_INPATIENT'
  left outer join
  [$(PRD_APHIM_UODS)].dbo.T_Attribute               NameOfSubmitter with (nolock)
  on
    a.ID = NameOfSubmitter.Act_ID and
    NameOfSubmitter.name = 'PR_NAMEOFSUBMITTER'
where
  a.metaCode='PR_ROWID'
