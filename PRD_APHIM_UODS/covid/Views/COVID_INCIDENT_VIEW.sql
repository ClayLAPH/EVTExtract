

CREATE VIEW [covid].[COVID_INCIDENT_VIEW]
AS
SELECT        A.ID AS PR_ROWID, dbo.FN_GetUCSFullName(PR.DVPR_TypeDR) AS PR_PHTYPE, A.localId AS PR_LEGACY_ROWID, PR.DVPR_PersonDR AS PR_PERSONDR, PR.DVPR_UserDR AS PR_USERDR, 
                         PR.DVPR_OutbreakDRsText AS PR_OUTBREAKDRSTEXT, PR.DVPR_IncidentID AS PR_INCIDENTID, PR.DVPR_CMRID AS PR_CMRRECORD, 
                         CASE WHEN UCSNamespace.conceptcode = 'WEB' THEN 'WEB' WHEN UCSNamespace.conceptcode = 'MLR' THEN 'MLR' WHEN ((UCSNamespace.id IS NULL) OR
                         ((UCSNamespace.id IS NOT NULL) AND (UCSImportOptions.id IS NOT NULL) AND (UCSImportOptions.conceptcode NOT IN ('ALR', 'UDL')))) THEN 'LIVE' ELSE 'ELR' END AS PR_NAMESPACE, 
                         PR.DVPR_CreateDate AS PR_CREATEDATE, PR.DVPR_OnsetDate AS PR_ONSETDATE, PR.DVPR_ClosedDate AS PR_CLOSEDDATE, PR.DVPR_EpisodeDate AS PR_EPISODEDATE, 
                         PR.DVPR_StandardAge AS PR_STANDARDAGE, PR.DVPR_DateSubmitted AS PR_DATESUBMITTED, PR.DVPR_DateReportedBy AS PR_DATEREPORTEDBY, 
                         PR.DVPR_ReportSourceDR AS PR_REPORTSOURCEDR, PR.DVPR_MRN AS PR_MRN, PR.DVPR_ClusterID AS PR_CLUSTERID, PR.DVPR_IsIndexCase AS PR_ISINDEXCASE, UCS1.fullName AS PR_DISEASE, 
                         UCS1.shortName AS PR_DISEASESHORTNAME, ACT_OTHERDISEASE.valueString_Txt AS PR_OTHERDISEASE, dbo.MDF_UCS_FULLNAME_UCS_BYUCSID(PR.DVPR_DistrictCode_ID) AS PR_DISTRICT, 
                         dbo.MDF_UCS_FULLNAME_UCS_BYUCSID(PR.DVPR_ProcessStatusCode_ID) AS PR_PROCESSSTATUS, dbo.MDF_UCS_FULLNAME_UCS_BYUCSID(REGION.SPACode_ID) AS PR_SPA, 
                         dbo.MDF_UCS_FULLNAME_UCS_BYUCSID(PR.DVPR_ResolutionStatusCode_ID) AS PR_RESOLUTIONSTATUS, CASE WHEN Isnull(TENTN.partfam, '') + ', ' + Isnull(TENTN.partgiv, '') 
                         = ', ' THEN '' ELSE Isnull(TENTN.partfam, '') + ', ' + Isnull(TENTN.partgiv, '') END AS PR_NURSEINVESTIGATOR, dbo.MDF_ATTR_GETBOOLEANVALUE_ACTATTR_BYACTID(A.ID, 'PR_REPORTEDBYWEB') 
                         AS PR_REPORTEDBYWEB, dbo.MDF_ATTR_GETBOOLEANVALUE_ACTATTR_BYACTID(A.ID, 'PR_REPORTEDBYLAB') AS PR_REPORTEDBYLAB, dbo.MDF_ATTR_GETBOOLEANVALUE_ACTATTR_BYACTID(A.ID, 
                         'PR_REPORTEDBYEHR') AS PR_REPORTEDBYEHR, dbo.MDF_UCS_FULLNAME_ATTRUCS_BYACTID(A.ID, 'VALUECODE_ID', 'PR_TRANSMISSIONSTATUS') AS PR_TRANSMISSIONSTATUS, 
                         PR.DVPR_DiseaseCode_ID AS PR_DISEASECODE_DR, PR.DVPR_DistrictCode_ID AS PR_DISTRICTCODE_DR, PR.DVPR_ProcessStatusCode_ID AS PR_PROCESSSTATUSCODE_DR, 
                         REGION.SPACode_ID AS PR_SPACODE_DR, PR.DVPR_ResolutionStatusCode_ID AS PR_RESOLUTIONSTATUSCODE_DR, PR.DVPR_NurseInvestigatorDR AS PR_NURSEINVESTIGATORDR, 
                         STDSPECIMENS.DVIS_SPECIMENTYPES AS PR_SPECIMENTYPE, STDSPECIMENS.DVIS_COLLECTIONDATES AS PR_SPECIMENDATECOLLECTED, 
                         STDSPECIMENS.DVIS_RECEIVEDDATES AS PR_SPECIMENDATERECEIVED, dbo.FN_ConcateDILRResultValueText(STDSPECIMENS.DVIS_IncidentDR) AS PR_SPECIMENRESULT, 
                         dbo.FN_ConcateDILRNoteText(STDSPECIMENS.DVIS_IncidentDR) AS PR_SPECIMENNOTE, dbo.FN_CumulativeTypes(A.ID, 'DIST_ROWID') AS PR_DIAGSPECIMENTYPES, dbo.FN_CumulativeTypes(A.ID, 
                         'DIET_ROWID') AS PR_EXPEXPOSURETYPES, dbo.FN_CumulativeTypes(A.ID, 'DIHT_HEPATITISTESTDR') AS PR_HEPATITISDRS, dbo.FN_DiseaseGroups(A.code_ID) AS PR_DISEASEGROUPS, 
                         dbo.MDF_ACT_GETSTRINGVALUE_ACT_BYPARACTIDMETAVALUETYPE('PR_LIPRESULTVALUE', A.ID, 'VALUESTRING_TXT') AS PR_RESULTVALUE, dbo.MDF_ATTR_GETSTRINGVALUE_ACTATTR_BYACTID(A.ID, 
                         'VALUESTRING_TXT', 'PR_LIPTESTORDERED') AS PR_LIPTESTORDERED, dbo.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('PR_ISPREGNANT', A.ID, 'VALUEBOOL') AS PR_ISPREGNANT, 
                         dbo.MDF_ACT_GETDATETIMEVALUE_ACT_BYPARACTIDMETAVALUETYPE('PR_EXPECTEDDELIVERYDATE', A.ID, 'VALUETS') AS PR_EXPECTEDDELIVERYDATE, CAST(lipnotes.valueString AS NVARCHAR(MAX)) 
                         AS PR_LIPRESULTNOTES, ISNULL(A8.valueString, A5.valueString) AS PR_LIPRESULTNAME, ISNULL(HCP.trivialName, '') AS PR_HEALTHCAREPROVIDER, LOCLINK.Entity2_ID AS PR_HEALTHCAREPROVIDERLOCATIONDR, A.text AS PR_NOTES, 
                         PR.DVPR_DiagnosisDate AS PR_DATEOFDIAGNOSIS, dbo.MDF_ACT_GETDATETIMEVALUE_ACT_BYPARACTIDMETAVALUETYPE('PR_DATEOFDEATH', A.ID, 'EFFECTIVETIME_BEG') AS PR_DATEOFDEATH, 
                         A8.availabilityTime AS PR_DATEOFLABREPORT, A.availabilityTime AS PR_DATEINVESTIGATORRECEIVED, dbo.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('PR_ISASYMPTOMATIC', A.ID, 
                         'VALUEBOOL') AS PR_ISSYMPTOMATIC, dbo.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('PR_ISPATIENTDIEDOFTHEILLNESS', A.ID, 'VALUEBOOL') 
                         AS PR_ISPATIENTDIEDOFTHEILLNESS, PH.hospitalizedInd AS PR_ISPATIENTHOSPITALIZED, dbo.MDF_ACT_GETDATETIMEVALUE_ACT_BYPARACTIDMETAVALUETYPE('PR_LABSPECIMENCOLLECTEDDATE', 
                         A.ID, 'EFFECTIVETIME_BEG') AS PR_LABSPECIMENCOLLECTEDDATE, dbo.MDF_ACT_GETDATETIMEVALUE_ACT_BYPARACTIDMETAVALUETYPE('PR_LABSPECIMENRESULTDATE', A.ID, 'EFFECTIVETIME_BEG') 
                         AS PR_LABSPECIMENRESULTDATE, A.valueTS AS PR_DATEADMITTED, A.ValueTSEnd AS PR_DATEDISCHARGED, LAB.trivialName AS PR_LABORATORY, R_HOSPITAL.player_ID AS PR_HOSPITALDR, 
                         TEN_HOSPITAL.trivialName AS PR_HOSPITAL, dbo.MDF_ATTR_GETBOOLEANVALUE_ACTATTR_BYACTID(A.ID, 'PR_OUTPATIENT') AS PR_OUTPATIENT, 
                         dbo.MDF_ATTR_GETBOOLEANVALUE_ACTATTR_BYACTID(A.ID, 'PR_INPATIENT') AS PR_INPATIENT, DATESENT.activityTime_Beg AS PR_DATESENT, DATESENT.activityTime_End AS PR_LASTCDCUPDATE, 
                         dbo.MDF_ATTR_GETSTRINGVALUE_ACTATTR_BYACTID(A.ID, 'VALUESTRING', 'PR_NAMEOFSUBMITTER') AS PR_NAMEOFSUBMITTER, PR.DVPR_OutbreakNumbers AS PR_OUTBREAKNUMBERS, 
                         PR.DVPR_OutbreakTypes AS PR_OUTBREAKTYPES, AI.DVAI_AnimalReportID AS PR_ANIMALREPORTID, FBIInc.source_ID AS PR_FBIDR, FBIComp.extension AS PR_FBINumber, 
                         PER.DVPER_CensusTract AS PR_CENSUSTRACT, REPLACE(ISNULL(TENAdditionalProvider.trivialName, ''), ',', '&Comma;') AS Additional_Provider, REPLACE(ISNULL(TENAdditionalLaboratory.trivialName, ''), ',', 
                         '&Comma;') AS Additional_Laboratory, PR.DVPR_StandardAge AS Age, ISNULL(AIorAN.Specify, '') AS American_Indian_or_Alaska_Native, ISNULL(Asian.Specify, '') AS Asian___Specify, ISNULL(Black.Specify, '') 
                         AS Black_or_African_American___Spec, PR.DVPR_CMRID AS CMR_ID, ISNULL(dbo.FN_GetUCSFullName(PERCOUNTRY.partCountry), '') AS Country_of_Birth, 
                         ISNULL(CASE UCS_NAMESPACE_CREATED_BY.conceptcode WHEN 'ELR' THEN 'LAB INTERFACE' WHEN 'WEB' THEN 'WEB INTERFACE' ELSE 'MAIN INTERFACE' END, 'MAIN INTERFACE') AS Created_By, 
                         PR.DVPR_DateLastEdited AS Date_Last_Edited, ISNULL(ucs_final_disp.fullName, '') AS Final_Disposition, ISNULL(diag_spec_types.types, '') AS Diagnostic_Specimen_Types, 
                         ISNULL(health_dist.JurisdictionCode, '') AS Health_District_Number, CASE WHEN (s_processedprrecord.[dateprocessed] IS NOT NULL AND s_processedprrecord.[importedbyuserdr] IS NULL) 
                         THEN 'System Process' ELSE ISNULL((ImportedBy.partfam + ', ' + ImportedBy.partgiv), '') END AS ImportedBy, COALESCE (CAST(PR.DVPR_ImportedStatus AS VARCHAR), '') AS Imported_Status, 
                         CASE PR.dvpr_reportedbylab WHEN 1 THEN 'True' ELSE 'False' END AS Lab_Report, ISNULL(PR.DVPR_LIPRESULTNOTES, '') AS Lab_Report_Notes, ISNULL(PR.DVPR_LIPTESTORDERED, '') 
                         AS Lab_Report_Test_Name, ISNULL(ucs_marital_stat.fullName, '') AS Marital_Status, ISNULL(PR.DVPR_MRN, '') AS Medical_Record_Number, ISNULL(CASE WHEN Charindex(' - ', Isnull(dilr_resulttest, '')) 
                         > 1 THEN dilr_resulttest ELSE dilr_localtestdescription END, '') AS Most_Recent_Lab_Result, ISNULL(ISNULL(PR.DVPR_LIPRESULTVALUE, dbo.Ax_LabReport.DILR_ResultValue), '') 
                         AS Most_Recent_Lab_Result_Value, ISNULL(Pacific.Specify, '') AS Native_Hawaiian_or_Other_Pacific, ISNULL(ucs_occ_set.fullName, '') AS Occupation_Setting_Type, ISNULL(Other.Specify, '') 
                         AS Other___Specify, ISNULL(PR.DVPR_OutbreakDRsText, '') AS Outbreak_IDs, ISNULL(PER.DVPER_GuardianName, '') AS Parent_or_Guardian_Name, ISNULL(ucs_priority.fullName, '') AS Priority, 
                         ISNULL(PR.DVPR_ProviderName, '') AS Provider_Name, ISNULL(HCP.trivialName, '') AS Report_Source, ISNULL(dbo.FN_GetUCSFullName(CPSecondaryDistrict.SubjCode_ID), '') AS Secondary_District, 
                         ISNULL(sus_expo_types.types, '') AS Suspected_Exposure_Types, ISNULL(ucs_cont_type.fullName, '') AS Type_of_Contact, ISNULL(Unknown.Specify, '') AS Unknown___Specify, ISNULL(White.Specify, '') 
                         AS White___Specify
FROM            dbo.DV_PHPersonalRecord AS PR WITH (nolock) INNER JOIN
                         dbo.DV_Person AS PER WITH (nolock) ON PER.DVPER_RowID = PR.DVPR_PersonDR LEFT OUTER JOIN
                         dbo.S_ProcessedPRRecord WITH (nolock) ON dbo.S_ProcessedPRRecord.OriginalLiveRecord_ID = PR.DVPR_RowID AND dbo.S_ProcessedPRRecord.StatusCode = 'active' AND 
                         dbo.S_ProcessedPRRecord.ImportOptionCode_ID <>
                             (SELECT        UCS.ID
                               FROM            dbo.V_UnifiedCodeSet AS UCS WITH (nolock) INNER JOIN
                                                         dbo.V_Domain AS VD WITH (nolock) ON UCS.domain_ID = VD.ID AND VD.domainName = 'NameSpaceImport'
                               WHERE        (UCS.conceptCode = 'ALR')) LEFT OUTER JOIN
                         dbo.V_UnifiedCodeSet AS UCS_NAMESPACE_CREATED_BY WITH (nolock) ON dbo.S_ProcessedPRRecord.NamespaceCode_ID = UCS_NAMESPACE_CREATED_BY.ID LEFT OUTER JOIN
                         dbo.T_EntityName AS ImportedBy WITH (nolock) ON ImportedBy.Entity_ID = dbo.S_ProcessedPRRecord.ImportedByUserDr LEFT OUTER JOIN
                         dbo.V_UnifiedCodeSet AS UCSNamespace WITH (nolock) ON PER.DVPER_NamespaceCode_ID = UCSNamespace.ID LEFT OUTER JOIN
                         dbo.V_UnifiedCodeSet AS UCSImportOptions WITH (nolock) ON PER.DVPER_ImportOptionsCode_ID = UCSImportOptions.ID INNER JOIN
                         dbo.A_Act AS A WITH (nolock) ON A.ID = PR.DVPR_RowID AND A.metaCode = 'PR_ROWID' INNER JOIN
                         dbo.A_PublicHealthCase AS PH WITH (nolock) ON PH.ID = A.ID LEFT OUTER JOIN
                         dbo.A_Act AS lipnotes WITH (nolock) ON lipnotes.Act_Parent_ID = A.ID AND lipnotes.metaCode = 'PR_LIPRESULTNOTES' LEFT OUTER JOIN
                         dbo.A_Act AS ACT_OTHERDISEASE WITH (nolock) ON ACT_OTHERDISEASE.Act_Parent_ID = A.ID AND ACT_OTHERDISEASE.metaCode = 'PR_OTHERDISEASENAME' LEFT OUTER JOIN
                         dbo.VCP_District AS REGION WITH (nolock) ON PR.DVPR_DistrictCode_ID = REGION.SubjCode_ID LEFT OUTER JOIN
                         dbo.V_UnifiedCodeSet AS UCS1 WITH (nolock) ON PR.DVPR_DiseaseCode_ID = UCS1.ID LEFT OUTER JOIN
                         dbo.T_EntityName AS TENTN WITH (nolock) ON PR.DVPR_NurseInvestigatorDR = TENTN.Entity_ID AND TENTN.useCode = 'L' LEFT OUTER JOIN
                         dbo.A_Act AS A5 WITH (nolock) ON A5.Act_Parent_ID = A.ID AND A5.metaCode = 'PR_LIPRESULTNAME' LEFT OUTER JOIN
                         dbo.A_Act AS A8 WITH (nolock) ON A8.Act_Parent_ID = A.ID AND A8.metaCode = 'DILR_ID' AND A8.ID = dbo.FN_LAB_ACTID(A.ID) LEFT OUTER JOIN
                         dbo.T_EntityName AS HCP WITH (nolock) ON HCP.Entity_ID = PR.DVPR_ReportSourceDR AND HCP.useCode = 'SRCH' AND HCP.metaCode = 'RS_HEALTHCAREPROVIDER' LEFT OUTER JOIN
                         dbo.S_Link AS LOCLINK WITH (nolock) ON LOCLINK.name = 'RSLOCATION-PRIMARY' AND LOCLINK.Entity1_ID = PR.DVPR_ReportSourceDR LEFT OUTER JOIN
                             (SELECT        dbo.STRCONCAT(dbo.DV_IncidentSpecimen.DVIS_CollectionDate) AS DVIS_COLLECTIONDATES, dbo.STRCONCAT(dbo.DV_IncidentSpecimen.DVIS_ReceivedDate) AS DVIS_RECEIVEDDATES, 
                                                         dbo.STRCONCAT(ISNULL(UCS1.fullName, '')) AS DVIS_SPECIMENTYPES, dbo.STRCONCAT(dbo.DV_IncidentSpecimen.DVIS_SpecimenResults) AS DVIS_SPECIMENRESULTS, 
                                                         dbo.DV_IncidentSpecimen.DVIS_IncidentDR
                               FROM            dbo.DV_IncidentSpecimen WITH (nolock) LEFT OUTER JOIN
                                                         dbo.V_UnifiedCodeSet AS UCS1 WITH (nolock) ON UCS1.ID = dbo.DV_IncidentSpecimen.DVIS_SpecimenTypeCode_ID
                               GROUP BY dbo.DV_IncidentSpecimen.DVIS_IncidentDR) AS STDSPECIMENS ON STDSPECIMENS.DVIS_IncidentDR = PR.DVPR_RowID LEFT OUTER JOIN
                         dbo.P_Participation AS PART WITH (nolock) ON PART.Act_ID = PR.DVPR_RowID AND PART.typeCode = 'ELOC' AND PART.metaCode = 'PR_LABORATORYDR' LEFT OUTER JOIN
                         dbo.R_Role AS RLAB WITH (nolock) ON RLAB.ID = PART.Role_ID AND RLAB.classCode = 'QUAL' LEFT OUTER JOIN
                         dbo.T_EntityName AS LAB WITH (nolock) ON LAB.Entity_ID = RLAB.player_ID AND LAB.useCode = 'SRCH' LEFT OUTER JOIN
                         dbo.P_Participation AS P_HOSPITAL WITH (nolock) ON P_HOSPITAL.Act_ID = A.ID AND P_HOSPITAL.metaCode = 'PR_HOSPITALDR' LEFT OUTER JOIN
                         dbo.R_Role AS R_HOSPITAL WITH (nolock) ON R_HOSPITAL.ID = P_HOSPITAL.Role_ID AND R_HOSPITAL.classCode = 'QUAL' LEFT OUTER JOIN
                         dbo.A_Act AS DATESENT WITH (nolock) ON PR.DVPR_RowID = DATESENT.Act_Parent_ID AND DATESENT.classCode = 'OBS' AND DATESENT.metaCode = 'PR_DATESENT' LEFT OUTER JOIN
                         dbo.T_EntityName AS TEN_HOSPITAL WITH (nolock) ON TEN_HOSPITAL.Entity_ID = R_HOSPITAL.player_ID AND TEN_HOSPITAL.useCode = 'SRCH' AND 
                         TEN_HOSPITAL.metaCode = 'LOC_NAME' LEFT OUTER JOIN
                         dbo.A_ActRelationship AS ACTREL_ANIMAL WITH (nolock) ON A.ID = ACTREL_ANIMAL.target_ID AND ACTREL_ANIMAL.typeCode = 'COMP' AND ACTREL_ANIMAL.metaCode IN ('AI_CONTACTINVESTIGATIONDR', 
                         'AI_DISEASEINCIDENTDR') LEFT OUTER JOIN
                         dbo.DV_AnimalReport AS AI WITH (nolock) ON AI.DVAI_RowID = ACTREL_ANIMAL.source_ID LEFT OUTER JOIN
                         dbo.A_ActRelationship AS FBIInc WITH (nolock) ON PH.ID = FBIInc.target_ID AND FBIInc.typeCode = 'COMP' AND FBIInc.metaCode = 'PR_FBIDR' LEFT OUTER JOIN
                         dbo.T_InstanceIdentifier AS FBIComp WITH (nolock) ON FBIInc.source_ID = FBIComp.Act_ID LEFT OUTER JOIN
                         dbo.Ax_LabReport WITH (nolock) ON dbo.Ax_LabReport.DILR_ID = A8.ID LEFT OUTER JOIN
                         dbo.T_EntityAddress AS PERCOUNTRY WITH (nolock) ON PERCOUNTRY.Entity_ID = PER.DVPER_RowID AND PERCOUNTRY.useCode = 'BIR' LEFT OUTER JOIN
                         dbo.V_UnifiedCodeSet AS ucs_marital_stat WITH (nolock) ON PER.DVPER_MaritalStatusCode_ID = ucs_marital_stat.ID LEFT OUTER JOIN
                         dbo.V_UnifiedCodeSet AS ucs_occ_set WITH (nolock) ON PER.DVPER_OccupationSettingTypeDR = ucs_occ_set.ID LEFT OUTER JOIN
                         dbo.P_Participation AS PPAdditionalReportSource WITH (nolock) ON PPAdditionalReportSource.Act_ID = PR.DVPR_RowID AND PPAdditionalReportSource.typeCode = 'REFB' AND 
                         PPAdditionalReportSource.metaCode = 'PR_AdditionalReportSourceDR' LEFT OUTER JOIN
                         dbo.R_Role AS RAdditionalReportSource WITH (nolock) ON RAdditionalReportSource.ID = PPAdditionalReportSource.Role_ID AND RAdditionalReportSource.classCode = 'QUAL' LEFT OUTER JOIN
                         dbo.T_EntityName AS TENAdditionalProvider WITH (nolock) ON TENAdditionalProvider.Entity_ID = RAdditionalReportSource.player_ID AND TENAdditionalProvider.metaCode = 'RS_HealthCareProvider' AND 
                         TENAdditionalProvider.useCode = 'SRCH' LEFT OUTER JOIN
                         dbo.P_Participation AS PPAdditionalLaboratory WITH (nolock) ON PPAdditionalLaboratory.Act_ID = PR.DVPR_RowID AND PPAdditionalLaboratory.typeCode = 'ELOC' AND 
                         PPAdditionalLaboratory.metaCode = 'PR_AdditionalLaboratoryDR' LEFT OUTER JOIN
                         dbo.R_Role AS RRAdditionalLaboratory WITH (nolock) ON RRAdditionalLaboratory.ID = PPAdditionalLaboratory.Role_ID AND RRAdditionalLaboratory.classCode = 'QUAL' LEFT OUTER JOIN
                         dbo.T_EntityName AS TENAdditionalLaboratory WITH (nolock) ON TENAdditionalLaboratory.Entity_ID = RRAdditionalLaboratory.player_ID AND TENAdditionalLaboratory.metaCode = 'LOC_Name' AND 
                         TENAdditionalLaboratory.useCode = 'SRCH' LEFT OUTER JOIN
                         dbo.V_UnifiedCodeSet AS ucs_final_disp WITH (nolock) ON PR.DVPR_FinalDisposition = ucs_final_disp.ID LEFT OUTER JOIN
                             (SELECT        dbo.STRCONCAT(DISTINCT CASE WHEN ACTOBS.metacode = 'DIST_RowID' THEN UCS.fullname END) AS types, a1.Act_Parent_ID AS dvpr_rowid
                               FROM            dbo.A_Act AS a1 WITH (nolock) INNER JOIN
                                                         dbo.A_Act AS ACTTOPIC WITH (nolock) ON ACTTOPIC.Act_Parent_ID = a1.ID AND ACTTOPIC.classCode = 'TOPIC' INNER JOIN
                                                         dbo.A_Act AS ACTOBS WITH (nolock) ON ACTOBS.Act_Parent_ID = ACTTOPIC.ID AND ACTOBS.classCode = 'OBS' INNER JOIN
                                                         dbo.V_UnifiedCodeSet AS UCS WITH (nolock) ON ACTOBS.code_ID = UCS.ID
                               GROUP BY a1.Act_Parent_ID) AS diag_spec_types ON diag_spec_types.dvpr_rowid = PR.DVPR_RowID LEFT OUTER JOIN
                         dbo.VCP_District AS health_dist WITH (nolock) ON PR.DVPR_DistrictCode_ID = health_dist.SubjCode_ID LEFT OUTER JOIN
                         dbo.V_UnifiedCodeSet AS ucs_priority WITH (nolock) ON PR.DVPR_PriorityDR = ucs_priority.ID LEFT OUTER JOIN
                         dbo.V_UnifiedCodeSet AS ucs_cont_type WITH (nolock) ON PR.DVPR_TypeOfContactDR = ucs_cont_type.ID LEFT OUTER JOIN
                             (SELECT        dbo.STRCONCAT(dbo.MDF_UCS_FULLNAME_UCS_BYUCSID(tr.raceCode_ID)) AS Specify, per.DVPER_RowID
                               FROM            dbo.DV_Person AS per WITH (nolock) LEFT OUTER JOIN
                                                         dbo.T_Race AS tr WITH (nolock) ON tr.Entity_ID = per.DVPER_RowID LEFT OUTER JOIN
                                                         dbo.V_CodeProperty AS VCP_CAT WITH (nolock) ON tr.raceCode_ID = VCP_CAT.subjCode_ID AND VCP_CAT.property = 'Race_CategoryDR'
                               WHERE        (tr.metaCode = 'PER_MultipleRaceDR') AND (ISNULL(dbo.MDF_UCS_FULLNAME_UCS_BYUCSID(VCP_CAT.valueCode_ID), '') = 'American Indian or Alaska Native')
                               GROUP BY per.DVPER_RowID) AS AIorAN ON AIorAN.DVPER_RowID = PER.DVPER_RowID LEFT OUTER JOIN
                             (SELECT        dbo.STRCONCAT(dbo.MDF_UCS_FULLNAME_UCS_BYUCSID(tr.raceCode_ID)) AS Specify, per.DVPER_RowID
                               FROM            dbo.DV_Person AS per WITH (nolock) LEFT OUTER JOIN
                                                         dbo.T_Race AS tr WITH (nolock) ON tr.Entity_ID = per.DVPER_RowID LEFT OUTER JOIN
                                                         dbo.V_CodeProperty AS VCP_CAT WITH (nolock) ON tr.raceCode_ID = VCP_CAT.subjCode_ID AND VCP_CAT.property = 'Race_CategoryDR'
                               WHERE        (tr.Entity_ID = per.DVPER_RowID) AND (tr.metaCode = 'PER_MultipleRaceDR') AND (ISNULL(dbo.MDF_UCS_FULLNAME_UCS_BYUCSID(VCP_CAT.valueCode_ID), '') = 'Asian')
                               GROUP BY per.DVPER_RowID) AS Asian ON Asian.DVPER_RowID = PER.DVPER_RowID LEFT OUTER JOIN
                             (SELECT        dbo.STRCONCAT(dbo.MDF_UCS_FULLNAME_UCS_BYUCSID(tr.raceCode_ID)) AS Specify, per.DVPER_RowID
                               FROM            dbo.DV_Person AS per WITH (nolock) LEFT OUTER JOIN
                                                         dbo.T_Race AS tr WITH (nolock) ON tr.Entity_ID = per.DVPER_RowID LEFT OUTER JOIN
                                                         dbo.V_CodeProperty AS VCP_CAT WITH (nolock) ON tr.raceCode_ID = VCP_CAT.subjCode_ID AND VCP_CAT.property = 'Race_CategoryDR'
                               WHERE        (tr.Entity_ID = per.DVPER_RowID) AND (tr.metaCode = 'PER_MultipleRaceDR') AND (ISNULL(dbo.MDF_UCS_FULLNAME_UCS_BYUCSID(VCP_CAT.valueCode_ID), '') = 'Black or African American')
                               GROUP BY per.DVPER_RowID) AS Black ON Black.DVPER_RowID = PER.DVPER_RowID LEFT OUTER JOIN
                             (SELECT        dbo.STRCONCAT(dbo.MDF_UCS_FULLNAME_UCS_BYUCSID(tr.raceCode_ID)) AS Specify, tr.Entity_ID AS dvper_rowid
                               FROM            dbo.T_Race AS tr WITH (nolock) LEFT OUTER JOIN
                                                         dbo.V_CodeProperty AS VCP_CAT WITH (nolock) ON tr.raceCode_ID = VCP_CAT.subjCode_ID AND VCP_CAT.property = 'Race_CategoryDR'
                               WHERE        (tr.metaCode = 'PER_MultipleRaceDR') AND (ISNULL(dbo.MDF_UCS_FULLNAME_UCS_BYUCSID(VCP_CAT.valueCode_ID), '') = 'Native Hawaiian or Other Pacific Islander')
                               GROUP BY tr.Entity_ID) AS Pacific ON Pacific.dvper_rowid = PER.DVPER_RowID LEFT OUTER JOIN
                             (SELECT        dbo.STRCONCAT(dbo.MDF_UCS_FULLNAME_UCS_BYUCSID(tr.raceCode_ID)) AS Specify, tr.Entity_ID AS dvper_rowid
                               FROM            dbo.T_Race AS tr WITH (nolock) LEFT OUTER JOIN
                                                         dbo.V_CodeProperty AS VCP_CAT WITH (nolock) ON tr.raceCode_ID = VCP_CAT.subjCode_ID AND VCP_CAT.property = 'Race_CategoryDR'
                               WHERE        (tr.metaCode = 'PER_MultipleRaceDR') AND (ISNULL(dbo.MDF_UCS_FULLNAME_UCS_BYUCSID(VCP_CAT.valueCode_ID), '') = 'Other')
                               GROUP BY tr.Entity_ID) AS Other ON Other.dvper_rowid = PER.DVPER_RowID LEFT OUTER JOIN
                             (SELECT        dbo.STRCONCAT(dbo.MDF_UCS_FULLNAME_UCS_BYUCSID(tr.raceCode_ID)) AS Specify, tr.Entity_ID AS dvper_rowid
                               FROM            dbo.T_Race AS tr WITH (nolock) LEFT OUTER JOIN
                                                         dbo.V_CodeProperty AS VCP_CAT WITH (nolock) ON tr.raceCode_ID = VCP_CAT.subjCode_ID AND VCP_CAT.property = 'Race_CategoryDR'
                               WHERE        (tr.metaCode = 'PER_MultipleRaceDR') AND (ISNULL(dbo.MDF_UCS_FULLNAME_UCS_BYUCSID(VCP_CAT.valueCode_ID), '') = 'Unknown')
                               GROUP BY tr.Entity_ID) AS Unknown ON Unknown.dvper_rowid = PER.DVPER_RowID LEFT OUTER JOIN
                             (SELECT        dbo.STRCONCAT(dbo.MDF_UCS_FULLNAME_UCS_BYUCSID(tr.raceCode_ID)) AS Specify, tr.Entity_ID AS dvper_rowid
                               FROM            dbo.T_Race AS tr WITH (nolock) LEFT OUTER JOIN
                                                         dbo.V_CodeProperty AS VCP_CAT WITH (nolock) ON tr.raceCode_ID = VCP_CAT.subjCode_ID AND VCP_CAT.property = 'Race_CategoryDR'
                               WHERE        (tr.metaCode = 'PER_MultipleRaceDR') AND (ISNULL(dbo.MDF_UCS_FULLNAME_UCS_BYUCSID(VCP_CAT.valueCode_ID), '') = 'White')
                               GROUP BY tr.Entity_ID) AS White ON White.dvper_rowid = PER.DVPER_RowID LEFT OUTER JOIN
                         dbo.VCP_District AS CPSecondaryDistrict WITH (nolock) ON PR.DVPR_SecondaryDistrictCode_ID = CPSecondaryDistrict.SubjCode_ID LEFT OUTER JOIN
                             (SELECT        dbo.STRCONCAT(DISTINCT CASE WHEN ACTOBS.metacode = 'DIET_ROWID' THEN UCS.fullname END) AS types, ACTDOCBODY.Act_Parent_ID AS dvpr_rowid
                               FROM            dbo.A_Act AS ACTDOCBODY WITH (nolock) INNER JOIN
                                                         dbo.A_Act AS ACTTOPIC WITH (nolock) ON ACTTOPIC.Act_Parent_ID = ACTDOCBODY.ID AND ACTTOPIC.classCode = 'TOPIC' INNER JOIN
                                                         dbo.A_Act AS ACTOBS WITH (nolock) ON ACTOBS.Act_Parent_ID = ACTTOPIC.ID AND ACTOBS.classCode = 'OBS' INNER JOIN
                                                         dbo.V_UnifiedCodeSet AS UCS WITH (nolock) ON ACTOBS.code_ID = UCS.ID LEFT OUTER JOIN
                                                         dbo.A_Observation AS OBSERVATION WITH (nolock) ON OBSERVATION.ID = ACTOBS.ID AND ACTOBS.metaCode = 'DIHT_HEPATITISTESTDR' LEFT OUTER JOIN
                                                         dbo.V_UnifiedCodeSet AS UCSOBSERVATION WITH (nolock) ON UCSOBSERVATION.ID = OBSERVATION.interpretationCode_ID
                               WHERE        (ACTDOCBODY.classCode = 'DOCBODY') AND (ACTOBS.metaCode IN ('DIET_ROWID', 'DIST_RowID', 'DIHT_HEPATITISTESTDR')) AND (ACTOBS.statusCode = 'active')
                               GROUP BY ACTDOCBODY.Act_Parent_ID) AS sus_expo_types ON PR.DVPR_RowID = sus_expo_types.dvpr_rowid
WHERE        (PR.DVPR_DiseaseCode_ID = 543030) AND (UCSNamespace.ID IS NULL) OR
                         (PR.DVPR_DiseaseCode_ID = 543030) AND (UCSNamespace.ID IS NOT NULL) AND (UCSImportOptions.ID IS NOT NULL) AND (UCSImportOptions.conceptCode NOT IN ('ALR', 'UDL'))



GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PR"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 321
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PER"
            Begin Extent = 
               Top = 6
               Left = 359
               Bottom = 136
               Right = 651
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "S_ProcessedPRRecord"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 321
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UCS_NAMESPACE_CREATED_BY"
            Begin Extent = 
               Top = 138
               Left = 359
               Bottom = 268
               Right = 529
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ImportedBy"
            Begin Extent = 
               Top = 138
               Left = 567
               Bottom = 268
               Right = 737
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UCSNamespace"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UCSImportOptions"
            Begin Extent = 
               Top = 270
               Left = 246
               Bottom = 400
               Right = 416
           ', @level0type = N'SCHEMA', @level0name = N'covid', @level1type = N'VIEW', @level1name = N'COVID_INCIDENT_VIEW';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "A"
            Begin Extent = 
               Top = 270
               Left = 454
               Bottom = 400
               Right = 700
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PH"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 532
               Right = 294
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "lipnotes"
            Begin Extent = 
               Top = 402
               Left = 332
               Bottom = 532
               Right = 578
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ACT_OTHERDISEASE"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 664
               Right = 284
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "REGION"
            Begin Extent = 
               Top = 402
               Left = 616
               Bottom = 532
               Right = 793
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UCS1"
            Begin Extent = 
               Top = 534
               Left = 322
               Bottom = 664
               Right = 492
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TENTN"
            Begin Extent = 
               Top = 534
               Left = 530
               Bottom = 664
               Right = 700
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "A5"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 796
               Right = 284
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "A8"
            Begin Extent = 
               Top = 666
               Left = 322
               Bottom = 796
               Right = 568
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "HCP"
            Begin Extent = 
               Top = 666
               Left = 606
               Bottom = 796
               Right = 776
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LOCLINK"
            Begin Extent = 
               Top = 798
               Left = 38
               Bottom = 928
               Right = 232
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "STDSPECIMENS"
            Begin Extent = 
               Top = 798
               Left = 270
               Bottom = 928
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PART"
            Begin Extent = 
               Top = 798
               Left = 532
               Bottom = 928
               Right = 795
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RLAB"
            Begin Extent = 
               Top = 930
               Left = 38
               Bottom = 1060
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin', @level0type = N'SCHEMA', @level0name = N'covid', @level1type = N'VIEW', @level1name = N'COVID_INCIDENT_VIEW';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane3', @value = N' Table = "LAB"
            Begin Extent = 
               Top = 930
               Left = 286
               Bottom = 1060
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "P_HOSPITAL"
            Begin Extent = 
               Top = 930
               Left = 494
               Bottom = 1060
               Right = 757
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "R_HOSPITAL"
            Begin Extent = 
               Top = 1062
               Left = 38
               Bottom = 1192
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DATESENT"
            Begin Extent = 
               Top = 1062
               Left = 286
               Bottom = 1192
               Right = 532
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TEN_HOSPITAL"
            Begin Extent = 
               Top = 1062
               Left = 570
               Bottom = 1192
               Right = 740
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ACTREL_ANIMAL"
            Begin Extent = 
               Top = 1194
               Left = 38
               Bottom = 1324
               Right = 264
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AI"
            Begin Extent = 
               Top = 1194
               Left = 302
               Bottom = 1324
               Right = 554
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FBIInc"
            Begin Extent = 
               Top = 1194
               Left = 592
               Bottom = 1324
               Right = 818
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FBIComp"
            Begin Extent = 
               Top = 1326
               Left = 38
               Bottom = 1456
               Right = 259
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Ax_LabReport"
            Begin Extent = 
               Top = 1326
               Left = 297
               Bottom = 1456
               Right = 562
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PERCOUNTRY"
            Begin Extent = 
               Top = 1458
               Left = 38
               Bottom = 1588
               Right = 310
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ucs_marital_stat"
            Begin Extent = 
               Top = 1326
               Left = 600
               Bottom = 1456
               Right = 770
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ucs_occ_set"
            Begin Extent = 
               Top = 1458
               Left = 348
               Bottom = 1588
               Right = 518
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PPAdditionalReportSource"
            Begin Extent = 
               Top = 1458
               Left = 556
               Bottom = 1588
               Right = 819
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begi', @level0type = N'SCHEMA', @level0name = N'covid', @level1type = N'VIEW', @level1name = N'COVID_INCIDENT_VIEW';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane4', @value = N'n Table = "RAdditionalReportSource"
            Begin Extent = 
               Top = 1590
               Left = 38
               Bottom = 1720
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TENAdditionalProvider"
            Begin Extent = 
               Top = 1590
               Left = 286
               Bottom = 1720
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PPAdditionalLaboratory"
            Begin Extent = 
               Top = 1590
               Left = 494
               Bottom = 1720
               Right = 757
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RRAdditionalLaboratory"
            Begin Extent = 
               Top = 1722
               Left = 38
               Bottom = 1852
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TENAdditionalLaboratory"
            Begin Extent = 
               Top = 1722
               Left = 286
               Bottom = 1852
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ucs_final_disp"
            Begin Extent = 
               Top = 1722
               Left = 494
               Bottom = 1852
               Right = 664
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "diag_spec_types"
            Begin Extent = 
               Top = 1854
               Left = 38
               Bottom = 1950
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "health_dist"
            Begin Extent = 
               Top = 1854
               Left = 246
               Bottom = 1984
               Right = 423
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ucs_priority"
            Begin Extent = 
               Top = 1854
               Left = 461
               Bottom = 1984
               Right = 631
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ucs_cont_type"
            Begin Extent = 
               Top = 1950
               Left = 38
               Bottom = 2080
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AIorAN"
            Begin Extent = 
               Top = 1986
               Left = 246
               Bottom = 2082
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Asian"
            Begin Extent = 
               Top = 1986
               Left = 454
               Bottom = 2082
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Black"
            Begin Extent = 
               Top = 2082
               Left = 38
               Bottom = 2178
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Pacific"
            Begin Extent = 
               Top = 2082
               Left = 246
               Bottom = 2178
               Right = 416
            End
            DisplayFlags = 28', @level0type = N'SCHEMA', @level0name = N'covid', @level1type = N'VIEW', @level1name = N'COVID_INCIDENT_VIEW';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane5', @value = N'0
            TopColumn = 0
         End
         Begin Table = "Other"
            Begin Extent = 
               Top = 2082
               Left = 454
               Bottom = 2178
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Unknown"
            Begin Extent = 
               Top = 2178
               Left = 38
               Bottom = 2274
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "White"
            Begin Extent = 
               Top = 2178
               Left = 246
               Bottom = 2274
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CPSecondaryDistrict"
            Begin Extent = 
               Top = 2178
               Left = 454
               Bottom = 2308
               Right = 631
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sus_expo_types"
            Begin Extent = 
               Top = 2274
               Left = 38
               Bottom = 2370
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'covid', @level1type = N'VIEW', @level1name = N'COVID_INCIDENT_VIEW';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 5, @level0type = N'SCHEMA', @level0name = N'covid', @level1type = N'VIEW', @level1name = N'COVID_INCIDENT_VIEW';

