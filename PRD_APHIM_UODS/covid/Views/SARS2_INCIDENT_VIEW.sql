


CREATE view [covid].[SARS2_INCIDENT_VIEW]
as
SELECT 
       A.id                                                                                       AS PR_ROWID, 
       dbo.Fn_getucsfullname(dvpr_typedr)                                                         AS PR_PHTYPE, 
       A.localid                                                                                  AS PR_LEGACY_ROWID, 
       PR.dvpr_persondr                                                                           AS PR_PERSONDR, 
       PR.dvpr_userdr                                                                             AS PR_USERDR, 
       PR.dvpr_outbreakdrstext                                                                    AS PR_OUTBREAKDRSTEXT, 
       PR.dvpr_incidentid                                                                         AS PR_INCIDENTID, 
       PR.dvpr_cmrid                                                                              AS PR_CMRRECORD, 
       CASE 
         WHEN UCSNamespace.conceptcode = 'WEB'   THEN 'WEB' 
         WHEN UCSNamespace.conceptcode = 'MLR'   THEN 'MLR' 
         WHEN ( ( UCSNamespace.id IS NULL ) 
                 OR ( ( UCSNamespace.id IS NOT NULL ) 
                      AND ( UCSImportOptions.id IS NOT NULL ) 
                      AND ( UCSImportOptions.conceptcode NOT IN ( 'ALR', 'UDL' ) 
                          ) ) )                  THEN 'LIVE' 
         ELSE 'ELR' 
       END                                                                                        AS PR_NAMESPACE, 
       PR.dvpr_createdate                                                                         AS PR_CREATEDATE, 
       PR.dvpr_onsetdate                                                                          AS PR_ONSETDATE, 
       PR.dvpr_closeddate                                                                         AS PR_CLOSEDDATE, 
       PR.dvpr_episodedate                                                                        AS PR_EPISODEDATE, 
       PR.dvpr_standardage                                                                        AS PR_STANDARDAGE, 
       PR.dvpr_datesubmitted                                                                      AS PR_DATESUBMITTED, 
       PR.dvpr_datereportedby                                                                     AS PR_DATEREPORTEDBY, 
       PR.dvpr_reportsourcedr                                                                     AS PR_REPORTSOURCEDR, 
       PR.dvpr_mrn                                                                                AS PR_MRN, 
       PR.dvpr_clusterid                                                                          AS PR_CLUSTERID, 
       PR.dvpr_isindexcase                                                                        AS PR_ISINDEXCASE, 
       UCS1.fullname                                                                              AS PR_DISEASE, 
       UCS1.shortname                                                                             AS PR_DISEASESHORTNAME, 
       ACT_OTHERDISEASE.valuestring_txt                                                           AS PR_OTHERDISEASE, 
       [DBO].[Mdf_ucs_fullname_ucs_byucsid](PR.dvpr_districtcode_id)                              AS PR_DISTRICT, 
       [DBO].[Mdf_ucs_fullname_ucs_byucsid](PR.dvpr_processstatuscode_id)                         AS PR_PROCESSSTATUS, 
       [DBO].[Mdf_ucs_fullname_ucs_byucsid](REGION.spacode_id)                                    AS PR_SPA, 
       [DBO].[Mdf_ucs_fullname_ucs_byucsid](PR.dvpr_resolutionstatuscode_id)                      AS PR_RESOLUTIONSTATUS, 
       CASE 
         WHEN Isnull(TENTN.partfam, '') + ', ' 
              + Isnull(TENTN.partgiv, '') = ', ' THEN '' 
         ELSE Isnull(TENTN.partfam, '') + ', ' 
              + Isnull(TENTN.partgiv, '') 
       END                                                                                        AS PR_NURSEINVESTIGATOR, 
       [DBO].[Mdf_attr_getbooleanvalue_actattr_byactid](A.id, 'PR_REPORTEDBYWEB')                 AS PR_REPORTEDBYWEB, 
       [DBO].[Mdf_attr_getbooleanvalue_actattr_byactid](A.id, 'PR_REPORTEDBYLAB')                 AS PR_REPORTEDBYLAB, 
       [DBO].[Mdf_attr_getbooleanvalue_actattr_byactid](A.id, 'PR_REPORTEDBYEHR')                 AS PR_REPORTEDBYEHR, 
       [DBO].[Mdf_ucs_fullname_attrucs_byactid](A.id, 'VALUECODE_ID', 'PR_TRANSMISSIONSTATUS')    AS PR_TRANSMISSIONSTATUS,
       PR.dvpr_diseasecode_id                                                                     AS PR_DISEASECODE_DR, 
       PR.dvpr_districtcode_id                                                                    AS PR_DISTRICTCODE_DR, 
       PR.dvpr_processstatuscode_id                                                               AS PR_PROCESSSTATUSCODE_DR, 
       REGION.spacode_id                                                                          AS PR_SPACODE_DR, 
       PR.dvpr_resolutionstatuscode_id                                                            AS PR_RESOLUTIONSTATUSCODE_DR, 
       PR.dvpr_nurseinvestigatordr                                                                AS PR_NURSEINVESTIGATORDR, 
       STDSPECIMENS.dvis_specimentypes                                                            AS PR_SPECIMENTYPE, 
       STDSPECIMENS.dvis_collectiondates                                                          AS PR_SPECIMENDATECOLLECTED, 
       STDSPECIMENS.dvis_receiveddates                                                            AS PR_SPECIMENDATERECEIVED, 
       [dbo].Fn_concatedilrresultvaluetext(STDSPECIMENS.dvis_incidentdr)                          AS PR_SPECIMENRESULT, 
       [dbo].Fn_concatedilrnotetext(STDSPECIMENS.dvis_incidentdr)                                 AS PR_SPECIMENNOTE, 
       [dbo].Fn_cumulativetypes(A.id, 'DIST_ROWID')                                               AS PR_DIAGSPECIMENTYPES, 
       [dbo].Fn_cumulativetypes(A.id, 'DIET_ROWID')                                               AS PR_EXPEXPOSURETYPES, 
       [dbo].Fn_cumulativetypes(A.id, 'DIHT_HEPATITISTESTDR')                                     AS PR_HEPATITISDRS, 
       [dbo].Fn_diseasegroups(A.code_id)                                                          AS PR_DISEASEGROUPS, 
       [DBO].[Mdf_act_getstringvalue_act_byparactidmetavaluetype](
              'PR_LIPRESULTVALUE', 
              A.id, 
              'VALUESTRING_TXT')                                                                  AS PR_RESULTVALUE, 
       [DBO].[Mdf_attr_getstringvalue_actattr_byactid](
              A.id, 
              'VALUESTRING_TXT', 
              'PR_LIPTESTORDERED')                                                                AS PR_LIPTESTORDERED, 
       [DBO].[Mdf_act_getbooleanvalue_act_byparactidmetavaluetype](
              'PR_ISPREGNANT', 
              A.id, 
              'VALUEBOOL')                                                                        AS PR_ISPREGNANT, 
       [DBO].[Mdf_act_getdatetimevalue_act_byparactidmetavaluetype](
              'PR_EXPECTEDDELIVERYDATE', 
              A.id, 
              'VALUETS')                                                                          AS PR_EXPECTEDDELIVERYDATE, 
       Cast(lipnotes.valuestring AS NVARCHAR(max))                                                AS PR_LIPRESULTNOTES, 
       Isnull(A8.valuestring, A5.valuestring)                                                     AS PR_LIPRESULTNAME, 
       LOCLINK.entity2_id                                                                         AS PR_HEALTHCAREPROVIDERLOCATIONDR, 
       A.[text]                                                                                   AS PR_NOTES, 
       PR.dvpr_diagnosisdate                                                                      AS PR_DATEOFDIAGNOSIS, 
       [DBO].[Mdf_act_getdatetimevalue_act_byparactidmetavaluetype](
              'PR_DATEOFDEATH', 
              A.id, 
              'EFFECTIVETIME_BEG')                                                                AS PR_DATEOFDEATH, 
       A8.availabilitytime                                                                        AS PR_DATEOFLABREPORT, 
       A.availabilitytime                                                                         AS PR_DATEINVESTIGATORRECEIVED, 
       [DBO].[Mdf_act_getbooleanvalue_act_byparactidmetavaluetype](
              'PR_ISASYMPTOMATIC', 
              A.id, 
              'VALUEBOOL')                                                                        AS PR_ISSYMPTOMATIC, 
       [DBO].[Mdf_act_getbooleanvalue_act_byparactidmetavaluetype](
              'PR_ISPATIENTDIEDOFTHEILLNESS', 
              A.id, 
              'VALUEBOOL')                                                                        AS PR_ISPATIENTDIEDOFTHEILLNESS, 
       PH.hospitalizedind                                                                         AS PR_ISPATIENTHOSPITALIZED, 
       [DBO].[Mdf_act_getdatetimevalue_act_byparactidmetavaluetype](
              'PR_LABSPECIMENCOLLECTEDDATE', 
              A.id, 
              'EFFECTIVETIME_BEG')                                                                AS PR_LABSPECIMENCOLLECTEDDATE, 
       [DBO].[Mdf_act_getdatetimevalue_act_byparactidmetavaluetype](
              'PR_LABSPECIMENRESULTDATE', 
              A.id, 
              'EFFECTIVETIME_BEG')                                                                AS PR_LABSPECIMENRESULTDATE, 
       A.valuets                                                                                  AS PR_DATEADMITTED, 
       A.valuetsend                                                                               AS PR_DATEDISCHARGED, 
       LAB.trivialname                                                                            AS PR_LABORATORY, 
       R_HOSPITAL.player_id                                                                       AS PR_HOSPITALDR, 
       TEN_HOSPITAL.trivialname                                                                   AS PR_HOSPITAL, 
       [DBO].[Mdf_attr_getbooleanvalue_actattr_byactid](A.id, 'PR_OUTPATIENT')                    AS PR_OUTPATIENT, 
       [DBO].[Mdf_attr_getbooleanvalue_actattr_byactid](A.id, 'PR_INPATIENT')                     AS PR_INPATIENT, 
       DATESENT.activitytime_beg                                                                  AS PR_DATESENT, 
       DATESENT.activitytime_end                                                                  AS PR_LASTCDCUPDATE, 
       [DBO].[Mdf_attr_getstringvalue_actattr_byactid](A.id, 'VALUESTRING', 'PR_NAMEOFSUBMITTER') AS PR_NAMEOFSUBMITTER, 
       PR.dvpr_outbreaknumbers                                                                    AS PR_OUTBREAKNUMBERS, 
       PR.dvpr_outbreaktypes                                                                      AS PR_OUTBREAKTYPES, 
       AI.dvai_animalreportid                                                                     AS PR_ANIMALREPORTID, 
       FBIInc.source_id                                                                           AS PR_FBIDR, 
       FBIComp.extension                                                                          AS PR_FBINumber, 
       PER.dvper_censustract                                                                      AS PR_CENSUSTRACT, 
       Replace(Isnull(TENAdditionalProvider.trivialname, ''), ',', '&Comma;')                     AS Additional_Provider, 
       Replace(Isnull(TENAdditionalLaboratory.trivialname, ''), ',', '&Comma;')                   AS Additional_Laboratory, 
       dvpr_standardage                                                                           AS Age, 
       Isnull(AIorAN.Specify, '')                                                                 AS American_Indian_or_Alaska_Native, 
       Isnull(Asian.Specify, '')                                                                  AS Asian___Specify, 
       Isnull(Black.Specify, '')                                                                  AS Black_or_African_American___Spec, 
       dvpr_cmrid                                                                                 AS CMR_ID, 
       Isnull(dbo.Fn_getucsfullname(PERCOUNTRY.partcountry), '')                                  AS Country_of_Birth, 
       Isnull(CASE UCS_NAMESPACE_CREATED_BY.conceptcode 
                WHEN 'ELR' THEN 'LAB INTERFACE' 
                WHEN 'WEB' THEN 'WEB INTERFACE' 
                ELSE 'MAIN INTERFACE' 
              END, 'MAIN INTERFACE')                                                              AS Created_By, 
       PR.dvpr_datelastedited                                                                     AS Date_Last_Edited, 
       Isnull(ucs_final_disp.fullname, '')                                                        AS Final_Disposition, 
       Isnull(diag_spec_types.types, '')                                                          AS Diagnostic_Specimen_Types, 
       Isnull(health_dist.jurisdictioncode, '')                                                   AS Health_District_Number, 
       Isnull(CASE 
         WHEN( s_processedprrecord.[dateprocessed] IS NOT NULL 
             AND s_processedprrecord.[importedbyuserdr] IS NULL ) THEN 'System Process' 
         ELSE ( ImportedBy.partfam + ', ' + ImportedBy.partgiv ) 
       END, '')                                                                                   AS ImportedBy, 
       COALESCE(Cast(PR.dvpr_importedstatus AS VARCHAR), '')                                      AS Imported_Status, 
       CASE PR.dvpr_reportedbylab 
         WHEN 1 THEN 'True' 
         ELSE 'False' 
       END                                                                                        AS Lab_Report, 
       Isnull(PR.dvpr_lipresultnotes, '')                                                         AS Lab_Report_Notes, 
       Isnull(PR.dvpr_liptestordered, '')                                                         AS Lab_Report_Test_Name, 
       Isnull(ucs_marital_stat.fullname, '')                                                      AS Marital_Status, 
       Isnull(PR.dvpr_mrn, '')                                                                    AS Medical_Record_Number, 
       Isnull(CASE 
                WHEN Charindex(' - ', Isnull(dilr_resulttest, '')) > 1 THEN dilr_resulttest 
                ELSE dilr_localtestdescription 
              END, '')                                                                            AS Most_Recent_Lab_Result, 
       Isnull(Isnull(PR.dvpr_lipresultvalue, ax_labreport.dilr_resultvalue), '')                  AS Most_Recent_Lab_Result_Value, 
       Isnull(Pacific.Specify, '')                                                                AS Native_Hawaiian_or_Other_Pacific, 
       Isnull(ucs_occ_set.fullname, '')                                                           AS Occupation_Setting_Type, 
       Isnull(Other.Specify, '')                                                                  AS Other___Specify, 
       Isnull(PR.dvpr_outbreakdrstext, '')                                                        AS Outbreak_IDs, 
       Isnull(dvper_guardianname, '')                                                             AS Parent_or_Guardian_Name, 
       Isnull(ucs_priority.fullname, '')                                                          AS Priority, 
       Isnull(dvpr_providername, '')                                                              AS Provider_Name, 
       Isnull(HCP.trivialname, '')                                                                AS Report_Source, 
       Isnull(dbo.Fn_getucsfullname(CPSecondaryDistrict.subjcode_id), '')                         AS Secondary_District,
       Isnull(sus_expo_types.types, '')                                                           AS Suspected_Exposure_Types, 
       Isnull(ucs_cont_type.fullname, '')                                                         AS Type_of_Contact, 
       Isnull(Unknown.Specify, '')                                                                AS Unknown___Specify, 
       Isnull(White.Specify, '')                                                                  AS White___Specify 
FROM   [dbo].dv_phpersonalrecord PR (nolock) 
       INNER JOIN dbo.dv_person PER (nolock) 
               ON PER.dvper_rowid = PR.dvpr_persondr 
       --CreatedBy
       LEFT JOIN s_processedprrecord (nolock) 
              ON ( s_processedprrecord.originalliverecord_id = PR.dvpr_rowid ) 
                  AND s_processedprrecord.statuscode = 'active' 
                  AND s_processedprrecord.importoptioncode_id <> 
                     (SELECT UCS.id 
                     FROM v_unifiedcodeset UCS (nolock) 
                     INNER JOIN v_domain VD (nolock) 
                            ON UCS.domain_id = VD.id 
                                AND VD.domainname = 'NameSpaceImport' 
                     WHERE UCS.conceptcode = 'ALR') 
       LEFT JOIN v_unifiedcodeset UCS_NAMESPACE_CREATED_BY (nolock) 
              ON s_processedprrecord.namespacecode_id = UCS_NAMESPACE_CREATED_BY.id 
       --importedBy
       LEFT JOIN t_entityname ImportedBy (nolock) 
              ON ImportedBy.entity_id = s_processedprrecord.[importedbyuserdr] 
       --original view joins
       LEFT OUTER JOIN [dbo].v_unifiedcodeset UCSNamespace(nolock) 
               ON PER.dvper_namespacecode_id = UCSNamespace.id 
       LEFT OUTER JOIN [dbo].v_unifiedcodeset UCSImportOptions(nolock) 
               ON PER.dvper_importoptionscode_id = UCSImportOptions.id 
       INNER JOIN [dbo].a_act A(nolock) 
               ON A.id = PR.dvpr_rowid 
                  AND A.metacode = 'PR_ROWID' 
       INNER JOIN [dbo].a_publichealthcase PH(nolock) 
               ON PH.id = A.id 
       LEFT JOIN a_act lipnotes (nolock) 
              ON lipnotes.act_parent_id = a.id 
                 AND lipnotes.metacode = 'PR_LIPRESULTNOTES' 
       LEFT JOIN [dbo].a_act ACT_OTHERDISEASE(nolock) 
              ON ACT_OTHERDISEASE.act_parent_id = A.id 
                 AND ACT_OTHERDISEASE.metacode = 'PR_OTHERDISEASENAME' 
       LEFT JOIN vcp_district REGION (nolock) 
              ON PR.dvpr_districtcode_id = REGION.subjcode_id 
       LEFT JOIN [dbo].v_unifiedcodeset UCS1(nolock) 
              ON PR.dvpr_diseasecode_id = UCS1.id 
       LEFT JOIN [dbo].t_entityname TENTN (nolock) 
              ON PR.dvpr_nurseinvestigatordr = TENTN.entity_id 
                 AND TENTN.usecode = 'L' 
       LEFT JOIN [dbo].a_act A5(nolock) 
              ON A5.act_parent_id = A.id 
                 AND A5.metacode = 'PR_LIPRESULTNAME' 
       LEFT JOIN [dbo].a_act A8(nolock) 
              ON A8.act_parent_id = A.id 
                 AND A8.metacode = 'DILR_ID' 
                 AND A8.id = [dbo].Fn_lab_actid(A.id) 
       LEFT JOIN [dbo].t_entityname HCP(nolock) 
              ON HCP.entity_id = PR.dvpr_reportsourcedr 
                 AND HCP.usecode = 'SRCH' 
                 AND HCP.metacode = 'RS_HEALTHCAREPROVIDER' 
       LEFT JOIN [dbo].s_link LOCLINK(nolock) 
              ON LOCLINK.NAME = 'RSLOCATION-PRIMARY' 
                 AND LOCLINK.entity1_id = PR.dvpr_reportsourcedr 
       LEFT JOIN (SELECT [dbo].Strconcat(dvis_collectiondate)       AS DVIS_COLLECTIONDATES, 
                         [dbo].Strconcat(dvis_receiveddate)         AS DVIS_RECEIVEDDATES, 
                         [dbo].Strconcat(Isnull(UCS1.fullname, '')) AS DVIS_SPECIMENTYPES, 
                         [dbo].Strconcat(dvis_specimenresults)      AS DVIS_SPECIMENRESULTS, 
                         dvis_incidentdr 
                  FROM   [dbo].dv_incidentspecimen (nolock) 
                         LEFT JOIN [dbo].v_unifiedcodeset UCS1 (nolock) 
                                ON UCS1.id = dvis_specimentypecode_id 
                  GROUP BY dvis_incidentdr) STDSPECIMENS 
              ON STDSPECIMENS.dvis_incidentdr = PR.dvpr_rowid 
       LEFT JOIN [dbo].p_participation PART (nolock) 
              ON PART.act_id = PR.dvpr_rowid 
                 AND PART.typecode = 'ELOC' 
                 AND PART.metacode = 'PR_LABORATORYDR' 
       LEFT JOIN [dbo].r_role RLAB (nolock) 
              ON RLAB.id = PART.role_id 
                 AND RLAB.classcode = 'QUAL' 
       LEFT JOIN [dbo].t_entityname LAB (nolock) 
              ON LAB.entity_id = RLAB.player_id 
                 AND LAB.usecode = 'SRCH' 
       LEFT JOIN [dbo].p_participation P_HOSPITAL (nolock) 
              ON P_HOSPITAL.act_id = A.id 
                 AND P_HOSPITAL.metacode = 'PR_HOSPITALDR' 
       LEFT JOIN [dbo].r_role R_HOSPITAL (nolock) 
              ON R_HOSPITAL.id = P_HOSPITAL.role_id 
                 AND R_HOSPITAL.classcode = 'QUAL' 
       LEFT JOIN [dbo].a_act DATESENT (nolock) 
              ON PR.dvpr_rowid = DATESENT.act_parent_id 
                 AND DATESENT.classcode = 'OBS' 
                 AND DATESENT.metacode = 'PR_DATESENT' 
       LEFT JOIN [dbo].t_entityname TEN_HOSPITAL (nolock) 
              ON TEN_HOSPITAL.entity_id = R_HOSPITAL.player_id 
                 AND TEN_HOSPITAL.usecode = 'SRCH' 
                 AND TEN_HOSPITAL.metacode = 'LOC_NAME' 
       LEFT JOIN [dbo].a_actrelationship ACTREL_ANIMAL (nolock) 
              ON A.id = ACTREL_ANIMAL.target_id 
                 AND ACTREL_ANIMAL.typecode = 'COMP' 
                 AND ACTREL_ANIMAL.metacode IN( 'AI_CONTACTINVESTIGATIONDR', 
                                                'AI_DISEASEINCIDENTDR' ) 
       LEFT JOIN [dbo].dv_animalreport AI (nolock) 
              ON AI.dvai_rowid = ACTREL_ANIMAL.source_id 
       LEFT JOIN a_actrelationship(nolock) FBIInc 
              ON PH.id = FBIInc.target_id 
                 AND FBIInc.typecode = 'COMP' 
                 AND FBIInc.metacode = 'PR_FBIDR' 
       LEFT JOIN t_instanceidentifier (nolock) FBIComp 
              ON FBIInc.source_id = FBIComp.act_id 
       --Most recent lab
       LEFT JOIN ax_labreport (nolock) 
              ON dilr_id = A8.id 
       --CountryOfBirth
       LEFT JOIN t_entityaddress PERCOUNTRY (nolock) 
              ON PERCOUNTRY.entity_id = per.dvper_rowid 
                 AND PERCOUNTRY.usecode = 'BIR' 
       --MaritalStatus
       LEFT JOIN v_unifiedcodeset ucs_marital_stat (nolock) 
              ON PER.dvper_maritalstatuscode_id = ucs_marital_stat.id 
       --OccupationalSetting
       LEFT JOIN v_unifiedcodeset ucs_occ_set (nolock) 
              ON PER.dvper_occupationsettingtypedr = ucs_occ_set.id 
       --AddtionalReportSource 
       LEFT JOIN p_participation PPAdditionalReportSource (nolock) 
              ON PPAdditionalReportSource.act_id = PR.dvpr_rowid 
                 AND PPAdditionalReportSource.typecode = 'REFB' 
                 AND PPAdditionalReportSource.metacode = 'PR_AdditionalReportSourceDR' 
       LEFT JOIN r_role RAdditionalReportSource (nolock) 
              ON RAdditionalReportSource.id = PPAdditionalReportSource.role_id 
                 AND RAdditionalReportSource.classcode = 'QUAL' 
       LEFT JOIN t_entityname TENAdditionalProvider (nolock) 
              ON TENAdditionalProvider.entity_id = RAdditionalReportSource.player_id 
                 AND TENAdditionalProvider.metacode = 'RS_HealthCareProvider' 
                 AND TENAdditionalProvider.usecode = 'SRCH' 
       --AddtionalLab 
       LEFT JOIN p_participation PPAdditionalLaboratory (nolock) 
              ON PPAdditionalLaboratory.act_id = PR.dvpr_rowid 
                 AND PPAdditionalLaboratory.typecode = 'ELOC' 
                 AND PPAdditionalLaboratory.metacode = 'PR_AdditionalLaboratoryDR' 
       LEFT JOIN r_role RRAdditionalLaboratory (nolock) 
              ON RRAdditionalLaboratory.id = PPAdditionalLaboratory.role_id 
                 AND RRAdditionalLaboratory.classcode = 'QUAL' 
       LEFT JOIN t_entityname TENAdditionalLaboratory (nolock) 
              ON TENAdditionalLaboratory.entity_id = RRAdditionalLaboratory.player_id 
                 AND TENAdditionalLaboratory.metacode = 'LOC_Name' 
                 AND TENAdditionalLaboratory.usecode = 'SRCH' 
       --FinalDisposition
       LEFT JOIN v_unifiedcodeset ucs_final_disp (nolock) 
              ON PR.dvpr_finaldisposition = ucs_final_disp.id 
       --diagnosis specimen types
       LEFT JOIN (SELECT dbo.Strconcat(DISTINCT CASE WHEN ACTOBS.metacode = 'DIST_RowID' THEN UCS.fullname END) AS types,
                         a1.act_parent_id                                                                       AS dvpr_rowid
                  FROM   a_act a1 (nolock)
                      INNER JOIN a_act ACTTOPIC (nolock) 
                             ON ACTTOPIC.act_parent_id = a1.id 
                                 AND ACTTOPIC.classcode = 'TOPIC' 
                      INNER JOIN a_act ACTOBS (nolock) 
                             ON ACTOBS.act_parent_id = ACTTOPIC.id 
                                 AND ACTOBS.classcode = 'OBS' 
                      INNER JOIN dbo.v_unifiedcodeset UCS (nolock) 
                             ON ACTOBS.code_id = UCS.id 
                  GROUP BY a1.act_parent_id ) diag_spec_types
              ON diag_spec_types.dvpr_rowid = PR.dvpr_rowid
       --health district number
       LEFT JOIN vcp_district health_dist (nolock) 
              ON PR.dvpr_districtcode_id = health_dist.subjcode_id 
       --priority
       LEFT JOIN v_unifiedcodeset ucs_priority (nolock) 
              ON PR.dvpr_prioritydr = ucs_priority.id 
       --Contact type
       LEFT JOIN v_unifiedcodeset ucs_cont_type (nolock) 
              ON PR.dvpr_typeofcontactdr = ucs_cont_type.id 
       --Race/Ethnicity
       LEFT JOIN (SELECT dbo.[Strconcat]( dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS Specify,
                         dvper_rowid
               FROM   dv_person per (nolock)
                      LEFT JOIN t_race tr (nolock)
                             ON tr.entity_id = per.dvper_rowid
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id), '') 
                          = 'American Indian or Alaska Native'
               GROUP BY dvper_rowid) AIorAN
              ON AIorAN.dvper_rowid = PER.dvper_rowid
       LEFT JOIN (SELECT dbo.[Strconcat]( dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS Specify, 
                         dvper_rowid
               FROM   dv_person per (nolock)
                      LEFT JOIN t_race tr (nolock) 
                             ON tr.entity_id = per.dvper_rowid
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.entity_id = per.dvper_rowid 
                      AND tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id), '') 
                          = 'Asian'
               GROUP BY dvper_rowid) Asian
              ON Asian.dvper_rowid = PER.dvper_rowid
       LEFT JOIN (SELECT dbo.[Strconcat]( dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS Specify, 
                         dvper_rowid
               FROM   dv_person per (nolock)
                      LEFT JOIN t_race tr (nolock)
                             ON tr.entity_id = per.dvper_rowid
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.entity_id = per.dvper_rowid 
                      AND tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id), '') 
                          = 'Black or African American'
               GROUP BY dvper_rowid) Black
              ON Black.dvper_rowid = PER.dvper_rowid
       LEFT JOIN (SELECT dbo.[Strconcat]( dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS Specify, 
                         tr.entity_id                                                         AS dvper_rowid
               FROM   t_race tr (nolock)
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id), '') 
                          = 'Native Hawaiian or Other Pacific Islander'
               GROUP BY tr.entity_id) Pacific
              ON Pacific.dvper_rowid = PER.dvper_rowid
       LEFT JOIN (SELECT dbo.[Strconcat]( dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS Specify, 
                         tr.entity_id                                                         AS dvper_rowid
               FROM   t_race tr (nolock)
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id), '') 
                          = 'Other'
               GROUP BY tr.entity_id) Other
              ON Other.dvper_rowid = PER.dvper_rowid
       LEFT JOIN (SELECT dbo.[Strconcat]( dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS Specify, 
                         tr.entity_id                                                         AS dvper_rowid
               FROM   t_race tr (nolock) 
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id), '') 
                          = 'Unknown'
               GROUP BY tr.entity_id) Unknown
              ON Unknown.dvper_rowid = PER.dvper_rowid
       LEFT JOIN (SELECT dbo.[Strconcat]( dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS Specify, 
                         tr.entity_id                                                         AS dvper_rowid
               FROM   t_race tr (nolock) 
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id), '') 
                          = 'White'
               GROUP BY tr.entity_id) White
              ON White.dvper_rowid = PER.dvper_rowid
       --secondary district
       LEFT JOIN vcp_district CPSecondaryDistrict (nolock) 
              ON PR.dvpr_secondarydistrictcode_id = CPSecondaryDistrict.subjcode_id 
       --suspected exposure types
       LEFT JOIN (SELECT dbo.Strconcat(DISTINCT CASE WHEN ACTOBS.metacode = 'DIET_ROWID' THEN UCS.fullname END) AS types,
                         ACTDOCBODY.act_parent_id                                                               AS dvpr_rowid
               FROM   a_act ACTDOCBODY (nolock) 
                      INNER JOIN a_act ACTTOPIC (nolock) 
                              ON ACTTOPIC.act_parent_id = ACTDOCBODY.id 
                                 AND ACTTOPIC.classcode = 'TOPIC' 
                      INNER JOIN a_act ACTOBS (nolock) 
                              ON ACTOBS.act_parent_id = ACTTOPIC.id 
                                 AND ACTOBS.classcode = 'OBS' 
                      INNER JOIN dbo.v_unifiedcodeset UCS (nolock) 
                              ON ACTOBS.code_id = UCS.id 
                      LEFT JOIN a_observation OBSERVATION (nolock) 
                             ON OBSERVATION.id = ACTOBS.id 
                                AND ACTOBS.metacode = 'DIHT_HEPATITISTESTDR' 
                      LEFT JOIN v_unifiedcodeset UCSOBSERVATION (nolock) 
                             ON UCSOBSERVATION.id = 
                                OBSERVATION.interpretationcode_id 
               WHERE  ACTDOCBODY.classcode = 'DOCBODY' 
                      AND ACTOBS.metacode IN ( 'DIET_ROWID', 'DIST_RowID', 'DIHT_HEPATITISTESTDR' ) 
                      AND ACTOBS.statuscode = 'active' 
               GROUP BY ACTDOCBODY.act_parent_id) sus_expo_types
              ON PR.dvpr_rowid = sus_expo_types.dvpr_rowid
WHERE  dvpr_diseasecode_id = 544041 
       AND ( ( UCSNamespace.id IS NULL ) 
           OR ( ( UCSNamespace.id IS NOT NULL ) 
               AND ( UCSImportOptions.id IS NOT NULL ) 
               AND ( UCSImportOptions.conceptcode NOT IN ( 'ALR', 'UDL' ) ) ) ) ;

