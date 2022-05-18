create view internals.Lab as
select
  INCIDENTID = instanceId.EXTENSION,
  PHRECORDID = phCase.ID,
  LabReportID = act.ID,
  ACCESSIONNUMBER = act.title, 
  HL7FILENAME = act.code_OrTx, 
  RESULTTEXT = lab.DILR_ResultTest,
  ABNORMALFLAG = abnormalFlag.fullName,
  IMPORTSTATUS = lab.DILR_ImportStatus, 
  ISFROMHL7 = lab.DILR_IsFromHL7,
  LABRESULTSTATUS = labResultStatus.fullName, 
  LOCALORGANISMCODE = substring(lab.DILR_LocalOrganismCode,0,charindex('||',lab.DILR_LocalOrganismCode)), 
  LOCALORGANISMDESCRIPTION = substring(lab.DILR_LocalOrganismDescription,0,charindex('||',lab.DILR_LocalOrganismDescription)),
  LOCALTESTCODE = lab.DILR_LocalTestCode,
  LOCALTESTDESCRIPTION = lab.DILR_LocalTestDescription,
  NOTES = lab.DILR_Notes, 
  ORGANISMCODE = lab.DILR_OrganismCode,
  ORGANISMCODINGSYSTEM = organismCodingSystem.CONCEPTCODE, 
  ORGANISMDESCRIPTION =
    case 
      when lab.DILR_ISFROMHL7 is null and lab.DILR_MessageTypeID<>2 
      then isnull(orgTerms.TERMDISPLAY, orgDescription.fullName )
      else DILR_OrganismDescription 
    end,
  PATIENTNAME = lab.DILR_PatientName, 
  PERFORMINGFACILITYID = lab.DILR_PerformingFacilityID, 
  PERSONVERIFIEDRESULT = lab.DILR_PersonVerifiedResult, 
  PFGEPATTERN1ST = lab.DILR_PFGEPattern1st, 
  PFGEPATTERN2ND = lab.DILR_PFGEPattern2nd, 
  REFERENCERANGE = lab.DILR_ReferenceRange, 
  RESULTDATE = lab.DILR_ResultDate,
  RESULTSTATUS = resultName.fullName, 
  RESULTUNIT =lab.DILR_ResultUnit,
  RESULTVALUE = lab.DILR_ResultValue,
  SEROGROUP = lab.DILR_Serogroup, 
  SEROLOGY = lab.DILR_Serology, 
  SEROTYPE = lab.DILR_Serotype,
  SPECIES = lab.DILR_Species, 
  SPECBODYSITE = specBodySite.fullName, 
  SPECCOLLECTEDDATE = lab.DILR_SpecCollectedDate, 
  SPECIMENSOURCE = specimenSource.fullName, 
  SPECIMENSOURCETEXT = lab.DILR_SpecimenSourceText,
  SPECRECEIVEDDATE = lab.DILR_SpecReceivedDate, 
  TESTCODE = lab.DILR_TestCode,
  TESTCODINGSYSTEM = testCodingSystem.CONCEPTCODE, 
  TESTDESCRIPTION = 
    case 
      when lab.DILR_IsFromHL7 is null then coalesce( testDescription.fullName, lab.DILR_TestDescription, '' )
      else lab.DILR_TestDescription 
    end, 
  PROVIDERNAME = lab.DILR_ProviderName, 
  PROVIDERID = lab.DILR_ProviderID, 
  PROVIDERADDRESS = lab.DILR_ProviderAddress, 
  PROVIDERCITY = lab.DILR_ProviderCity, 
  PROVIDERSTATE = lab.DILR_ProviderState, 
  PROVIDERCOUNTY = lab.DILR_ProviderCounty, 
  PROVIDERZIP = lab.DILR_ProviderZip,
  PROVIDERPHONE = lab.DILR_ProviderPhone, 
  PROVIDEREMAIL = lab.DILR_ProviderEmail, 
  PROVIDERFAX = lab.DILR_ProviderFax, 
  FACILITYNAME = lab.DILR_FacilityName,
  FACILITYADDRESS = lab.DILR_FacilityAddress, 
  FACILITYCITY = lab.DILR_FacilityCity, 
  FACILITYSTATE = lab.DILR_FacilityState,
  FACILITYCOUNTY = lab.DILR_FacilityCounty, 
  FACILITYZIP = lab.DILR_FacilityZip, 
  FACILITYPHONE = lab.DILR_FacilityPhone, 
  PLACERORDERNO = lab.DILR_PlacerOrderNo, 
  FACILITYEMAIL = lab.DILR_FacilityEmail, 
  FACILITYID = lab.DILR_FacilityID,
  DILR_StatusCode = act.statusCode,
  EXTENDEDRESULTVALUE = lab.DILR_ResultValueEx,
  RELEVANTCLINICALINFORMATION = lab.DILR_RelevantClinicalInformation,
  REASONFORSTUDY = lab.DILR_ReasonForStudy,
  RESULTEDORGANISM = isnull(lab.dilr_organismdescription, ''),
  LOCALORGANISMDESCRIPTIONTEXT = 
    case 
      when charindex('||',DILR_LocalOrganismDescription) > 0 
      then right(DILR_LocalOrganismDescription, len(DILR_LocalOrganismDescription) - charindex('||',DILR_LocalOrganismDescription) - 1) 
      else '' 
    end,
  LOCALORGANISMCODETEXT = 
    case 
      when charindex('||',DILR_LOCALORGANISMCODE) > 0 
      then right(DILR_LOCALORGANISMCODE, len(DILR_LOCALORGANISMCODE) - charindex('||',DILR_LOCALORGANISMCODE) - 1) 
      else '' 
    end
from 
  internals.Ax_LabReport lab with (nolock)
  inner join
  [$(PRD_APHIM_UODS)].dbo.A_Act act with (nolock) 
  on 
    lab.DILR_ID = act.ID  and 
    act.classCode='OBS' and 
    act.metaCode = 'DILR_ID' and 
    act.statusCode='active'
  inner join
  [$(PRD_APHIM_UODS)].dbo.A_ACT phCase with (nolock) 
  on 
    act.ACT_PARENT_ID=phCase.ID and 
    phCase.METACODE in('PR_RowID','AI_RowID','OB_RowID') and 
    (
      phCase.STATUSCODE is null or
      phCase.STATUSCODE not in ('terminated', 'NULLIFIED')
    )  
  inner join
  [$(PRD_APHIM_UODS)].dbo.T_INSTANCEIDENTIFIER instanceId with (nolock) 
  on 
    phCase.ID=instanceId.ACT_ID  and 
    (
      instanceId.[root] like '2.16.840.1.113883.3.33.4.2.2.11.1%' or 
      instanceId.[root] like '2.16.840.1.113883.3.33.4.2.2.11.8%' or 
      instanceId.[root] like '2.16.840.1.113883.3.33.4.2.2.11.7%'
    )

  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet abnormalFlag with (nolock) 
  on 
    lab.DILR_AbnormalFlagCode_ID = abnormalFlag.ID   
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet labResultStatus with (nolock) 
  on 
    lab.DILR_LIPTestStatusCode_ID = labResultStatus.ID  
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet resultName with (nolock) 
  on 
    lab.DILR_ResultStatusCode_ID = resultName.ID   
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet specBodySite with (nolock) 
  on 
    lab.DILR_SpecBodySiteCode_ID = specBodySite.ID   
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet specimenSource with (nolock) 
  on 
    lab.DILR_SpecimenSourceCode_ID = specimenSource.ID  
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET testCodingSystem with (nolock) 
  on 
    lab.DILR_TestCodingSystem_ID=testCodingSystem.ID  
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET organismCodingSystem with (nolock) 
  on 
    lab.DILR_OrganismCodingSystem_ID=organismCodingSystem.ID   
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet concept with (nolock) 
  on 
    concept.ID = lab.DILR_SourceCode_ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet testDescription with (nolock) 
  on 
    testDescription.ID = try_convert( int, lab.DILR_TestDescription )

  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_Unifiedcodeset orgDescription with (nolock) 
  on
    orgDescription.ID = try_convert( int, lab.DILR_OrganismDescription )
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_TERMDICTIONARY orgTerms with (nolock) 
  on 
    orgTerms.termCode_Id = orgDescription.ID 
where  
  isnull(concept.conceptCode, '') <> 'WEB'