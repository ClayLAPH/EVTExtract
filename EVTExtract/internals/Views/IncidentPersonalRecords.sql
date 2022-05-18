create view internals.IncidentPersonalRecords as
select
  PR_INCIDENTID = DVPR_IncidentID,
  PR_CMRID = DVPR_CMRID,
  PR_MRN = DVPR_MRN,
  PR_CREATEDATE = DVPR_CreateDate,
  PR_ONSETDATE = DVPR_OnsetDate,
  PR_EPISODEDATE = DVPR_EpisodeDate,
  PR_CLOSEDDATE= DVPR_ClosedDate,
  PR_DATEREPORTEDBY = DVPR_DateReportedBy,
  PR_STANDARDAGE= DVPR_StandardAge,
  PR_DATESUBMITTED = DVPR_DateSubmitted,
  PR_ISINDEXCASE = DVPR_IsIndexCase,
  PR_CLUSTERID = DVPR_ClusterID,
  PR_DATEOFDIAGNOSIS = DVPR_DiagnosisDate,
  PR_DIAGSPECIMENTYPES = DVPR_DiagSpecimenTypes,
  PR_EXPEXPOSURETYPES = DVPR_ExpExposureTypes,
  PR_HEPATITISDRS = DVPR_HepatitisDRs,
  PR_DISEASECODE_DR = DVPR_DiseaseCode_ID,
  PR_DISTRICTCODE_DR = DVPR_DistrictCode_ID,
  PR_ORIGINALDISTRICTCODE_DR = DVPR_OriginalDistrictCode_ID,
  PR_PROCESSSTATUSCODE_DR = DVPR_ProcessStatusCode_ID,
  PR_RESOLUTIONSTATUSCODE_DR = DVPR_ResolutionStatusCode_ID,
  PR_SECONDARYDISTRICTCODE_DR = DVPR_SecondaryDistrictCode_ID,
  Secondary_District = UCSSecondaryDistrictCode.fullName,
  PR_TRANSMISSIONSTATUSCODE_DR = DVPR_TransmissionStatusCode_ID,
  PR_NURSEINVESTIGATORDR = DVPR_NurseInvestigatorDR,
  PR_PERSONDR = DVPR_PersonDR,
  PR_REPORTSOURCEDR = DVPR_ReportSourceDR,
  PR_ROWID = DVPR_RowID,
  PR_USERDR = DVPR_UserDR,
  PR_TYPEDR = DVPR_TypeDR,
  PR_OUTBREAKDRSTEXT = DVPR_OutbreakDRsText,
  PR_OUTBREAKNUMBERS = DVPR_OutbreakNumbers,
  PR_OUTBREAKTYPES = DVPR_OutbreakTypes,
  PR_RECEIVEDDATE = DVPR_ReceivedDate,
  PR_LABSPECIMENCOLLECTEDDATE = DVPR_LABSpecimenCollectedDate,
  PR_NAMEOFSUBMITTER = DVPR_NameOfSubmitter,
  PR_IMPORTEDSTATUS = DVPR_ImportedStatus,
  Imported_Status = cast(DVPR_ImportedStatus as varchar),
  Lab_Report =  case when DVPR_ReportedByLab = 1 then 'true' else 'false' end,
  PR_FINALDISPOSITION = DVPR_FinalDisposition,
  Final_Disposition = UCSFinalDispo.fullName,
  PR_OUTPATIENT = DVPR_OutPatient,
  PR_INPATIENT = DVPR_InPatient,
  PR_LIPRESULTVALUE = DVPR_LIPRESULTVALUE,                  --*
  Lab_Report_Test_Name = DVPR_LIPTESTORDERED,
  Lab_Report_Notes = DVPR_LIPRESULTNOTES,
  Medical_Record_Number = pr.DVPR_MRN,

  PR_TYPEOFCONTACTDR = DVPR_TypeOfContactDR,
  PR_PRIORITYDR = DVPR_PriorityDR,
  PR_REPORTEDBYWEB = DVPR_ReportedbyWeb,
  PR_PROVIDERNAME = DVPR_ProviderName,
  PR_REPORTEDBYLAB = DVPR_ReportedByLab,
  PR_REPORTEDBYEHR = DVPR_ReportedByEHR,
  PR_OTHERDISEASENAME = DVPR_OtherDiseaseName,
  PR_DATEOFDEATH = DVPR_DATEOFDEATH,
  PR_ISPREGNANT = DVPR_ISPREGNANT,
  PR_EXPECTEDDELIVERYDATE = DVPR_EXPECTEDDELIVERYDATE,
  PR_LIPRESULTNOTES = DVPR_LIPRESULTNOTES,
  PR_HEALTHCAREPROVIDERLOCATIONDR = HealthCareProviderLocation.Entity2_ID,
  PR_ISPATIENTDIEDOFTHEILLNESS = DVPR_ISPATIENTDIEDOFTHEILLNESS,
  PR_DATESENT = DVPR_DateSent,
  PR_LASTCDCUPDATE = DVPR_DateLastUpdateSent,
  PR_LIPRESULTNAME = DVPR_LIPRESULTNAME,
  PR_ISASYMPTOMATIC = DVPR_ISASYMPTOMATIC,
  PR_LABSPECIMENRESULTDATE = DVPR_LABSpecimenResultDate,
  PR_DATEADMITTED = DVPR_DateAdmitted,
  PR_DATEDISCHARGED = DVPR_DateDischarged,
  PR_DATELASTEDITED = DVPR_DateLastEdited,
  PR_NOTES = DVPR_Notes,
  PR_DATEINVESTIGATORRECEIVED = DVPR_DateInvestigatorReceived,
  PR_ISPATIENTHOSPITALIZED = DVPR_IsPatientHospitalized,
  --
  PR_DISEASE = UCSDiseaseCode.fullName,
  PR_DISEASESHORTNAME = UCSDiseaseCode.shortName,
  PR_DISTRICT = UCSDistrictCode.fullName,
  PR_ORIGINALDISTRICT = UCSOriginalDistrictCode.fullName,
  PR_PROCESSSTATUS = UCSProcessStatusCode.fullName,
  PR_RESOLUTIONSTATUS = UCSResolutionStatusCode.fullName,
  PR_SECONDARYDISTRIC = UCSSecondaryDistrictCode.fullName,
  PR_TRANSMISSIONSTATUS = UCSTransmissionStatusCode.fullName,
  PR_PHTYPE = UCSType.fullName,

  PR_SPA = UCSRegionName.fullName,
  PR_SPACODE_DR = District.SPACode_ID,
  Health_District_Number = District.JurisdictionCode,

  PR_SPECIMENTYPE = IncidentSpecimens.DVIS_SPECIMENTYPES,
  PR_SPECIMENDATECOLLECTED = IncidentSpecimens.DVIS_COLLECTIONDATES,
  PR_SPECIMENDATERECEIVED = IncidentSpecimens.DVIS_RECEIVEDDATES,
  PR_SPECIMENRESULT = IncidentSpecimens.DVIS_SPECIMENRESULTS,
  PR_SPECIMENNOTE = ( select notes from internals.IncidentSpecimensNotes( pr.DVPR_RowID ) ),

  Most_Recent_Lab_Result = pr.DVPR_LIPRESULTNAME,           --*

  PR_LABORATORY = LabResultsName.trivialName,

  PR_NURSEINVESTIGATOR = 
    case
      when isnull(NurseInvestigator.partfam, '') + ', ' + isnull(NurseInvestigator.partgiv, '') = ', ' then '' 
      else isnull(NurseInvestigator.partfam, '') + ', ' + isnull(NurseInvestigator.partgiv, '') 
    end,

  Additional_Provider = TEnProvider.trivialName,
  Additional_Laboratory = TENLab.trivialName,

  Created_By = 
    case UCSNamespaceCreatedBy.conceptCode
      when 'ELR' then 'LAB INTERFACE' 
      when 'WEB' then 'WEB INTERFACE' 
      else 'MAIN INTERFACE' 
     end,

  ImportedBy = 
    case
      when processed.dateprocessed is not null and processed.importedbyuserdr is null then 'System Process' 
      else ImportedBy.partfam + ', ' + ImportedBy.partgiv
    end,

  Priority = UCSPriorityCode.fullName,
  Report_Source = healthCareProvider.trivialName,

  Suspected_Exposure_Types = (select list from internals.SuspectedExposureTypes(pr.DVPR_RowID)),

  Type_of_Contact = UCSContactType.fullName


from
  [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord       pr with (nolock)

  outer apply
  internals.IncidentSpecimensAggregated(pr.DVPR_RowID) 
                                                    IncidentSpecimens
  outer apply
  internals.IncidentSpecimensNotes(pr.DVPR_RowID) 
                                                    IncidentSpecimentsNotes
  outer apply
  internals.LabName( pr.DVPR_RowID )
                                                    LabResultsName

  ----------------------------------------
  left outer join
  [$(PRD_APHIM_UODS)].dbo.S_ProcessedPRRecord       Processed with (nolock)
  on
    Processed.OriginalLiveRecord_ID = PR.DVPR_RowID and
    Processed.StatusCode = 'active' and
    Processed.ImportOptionCode_ID in 
    ( select ucs.ID
      from
        [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet    ucs with (nolock)
        inner join
        [$(PRD_APHIM_UODS)].dbo.V_Domain            vd with (nolock)
        on
          ucs.domain_ID = vd.ID AND 
          vd.domainName = 'NameSpaceImport'
      where ucs.conceptCode != 'ALR'
    )
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          UCSNamespaceCreatedBy with (nolock)
  on 
    Processed.NamespaceCode_ID = UCSNamespaceCreatedBy.ID 
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_EntityName              ImportedBy with (nolock)
  on 
    ImportedBy.Entity_ID = Processed.ImportedByUserDr 
  -----------------------------------------

  left outer join
  [$(PRD_APHIM_UODS)].dbo.S_Link                   HealthCareProviderLocation with (nolock)
  on 
    HealthCareProviderLocation.name = 'RSLOCATION-PRIMARY' and
    HealthCareProviderLocation.Entity1_ID = pr.DVPR_ReportSourceDR   
  left outer join
  [$(PRD_APHIM_UODS)].dbo.T_EntityName              NurseInvestigator with (nolock)
  on
    pr.DVPR_NurseInvestigatorDR = NurseInvestigator.Entity_ID  and
    NurseInvestigator.useCode = 'L'   
  left outer join
  [$(PRD_APHIM_UODS)].dbo.VCP_District              District with (nolock)
  on
    pr.DVPR_DistrictCode_ID = District.SubjCode_ID   
  left outer join
  [$(PRD_APHIM_UODS)].dbo.A_Act                     DateSent with (nolock)
  on 
      pr.DVPR_RowID = DateSent.Act_Parent_ID and
      DateSent.classCode = 'OBS' and 
      DateSent.metaCode = 'PR_DATESENT' 
   left outer join
   [$(PRD_APHIM_UODS)].dbo.T_EntityName             healthCareProvider with (nolock)
   on
    healthCareProvider.Entity_ID = pr.DVPR_ReportSourceDR AND 
    healthCareProvider.useCode = 'SRCH' AND 
    healthCareProvider.metaCode = 'RS_HEALTHCAREPROVIDER' 


  -------------------
  left outer join
  [$(PRD_APHIM_UODS)].dbo.P_Participation           TENProviderParticipation with (nolock)
  on 
    TENProviderParticipation.Act_ID = PR.DVPR_RowID and 
    TENProviderParticipation.typeCode = 'REFB' and 
    TENProviderParticipation.metaCode = 'PR_AdditionalReportSourceDR' 
  left outer join
  [$(PRD_APHIM_UODS)].dbo.R_Role                    TENProviderRole with (nolock)
  on 
    TENProviderRole.ID = TENProviderParticipation.Role_ID and 
    TENProviderRole.classCode = 'QUAL' 
  left outer join
  [$(PRD_APHIM_UODS)].dbo.T_EntityName              TENProvider with (nolock)
  on 
    TENProvider.Entity_ID = TENProviderRole.player_ID and 
    TENProvider.metaCode = 'RS_HealthCareProvider' and 
    TENProvider.useCode = 'SRCH' 
  ----------------
  left outer join
  [$(PRD_APHIM_UODS)].dbo.P_Participation           TENLabParticipation with (nolock)
  on 
    TENLabParticipation.Act_ID = PR.DVPR_RowID and 
    TENLabParticipation.typeCode = 'ELOC' and 
    TENLabParticipation.metaCode = 'PR_AdditionalLaboratoryDR' 
  left outer join
  [$(PRD_APHIM_UODS)].dbo.R_Role                    TENLabRole with (nolock)
  on 
    TENLabRole.ID = TENLabParticipation.Role_ID and 
    TENLabRole.classCode = 'QUAL' 
  left outer join
  [$(PRD_APHIM_UODS)].dbo.T_EntityName              TENLab with (nolock)
  on 
    TENLab.Entity_ID = TENLabRole.player_ID and 
    TENLab.metaCode = 'LOC_Name' and 
    TENLab.useCode = 'SRCH' 
  ----------------
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          UCSPriorityCode with (nolock) 
  on
    pr.DVPR_PriorityDR = UCSPriorityCode.ID
  left outer join
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          UCSRegionName with (nolock) 
  on
    District.SPACode_ID = UCSRegionName.ID
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          UCSDiseaseCode with (nolock)
  on
    pr.DVPR_DiseaseCode_ID = UCSDiseaseCode.ID
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          UCSDistrictCode with (nolock)
  on
    pr.DVPR_DistrictCode_ID = UCSDistrictCode.ID
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          UCSOriginalDistrictCode with (nolock)
  on
   pr.DVPR_OriginalDistrictCode_ID = UCSOriginalDistrictCode.ID
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          UCSProcessStatusCode with (nolock)
  on
    pr.DVPR_ProcessStatusCode_ID = UCSProcessStatusCode.ID
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          UCSResolutionStatusCode with (nolock)
  on
    pr.DVPR_ResolutionStatusCode_ID = UCSResolutionStatusCode.ID
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          UCSSecondaryDistrictCode with (nolock)
  on
    pr.DVPR_SecondaryDistrictCode_ID = UCSSecondaryDistrictCode.ID
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          UCSTransmissionStatusCode with (nolock)
  on
    pr.DVPR_TransmissionStatusCode_ID = UCSTransmissionStatusCode.ID
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          UCSType with (nolock)
  on
    pr.DVPR_TypeDR = UCSType.ID
  left outer join   
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          UCSContactType with (nolock)
  ON 
    PR.DVPR_TypeOfContactDR = UCSContactType.ID   
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          UCSFinalDispo with (nolock)
  on 
    pr.DVPR_FinalDisposition = UCSFinalDispo.ID


