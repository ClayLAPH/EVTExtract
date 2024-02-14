
create view [covid].[SARS2_INCIDENT_VIEW_LEGACY]
as
SELECT v.PR_ROWID,
v.PR_PHTYPE,
v.PR_LEGACY_ROWID,
v.PR_PERSONDR,
v.PR_USERDR,
CAST(v.PR_OUTBREAKDRSTEXT AS text) AS PR_OUTBREAKDRSTEXT,
v.PR_INCIDENTID,
v.PR_CMRRECORD,
v.PR_NAMESPACE,
CAST(v.PR_CREATEDATE AS datetime2(3)) AS PR_CREATEDATE,
CAST(v.PR_ONSETDATE AS datetime2(3)) AS PR_ONSETDATE,
CAST(v.PR_CLOSEDDATE AS datetime2(3)) AS PR_CLOSEDDATE,
CAST(v.PR_EPISODEDATE AS datetime2(3)) AS PR_EPISODEDATE,
v.PR_STANDARDAGE,
CAST(v.PR_DATESUBMITTED AS datetime2(3)) AS PR_DATESUBMITTED,
CAST(v.PR_DATEREPORTEDBY AS datetime2(3)) AS PR_DATEREPORTEDBY,
v.PR_REPORTSOURCEDR,
v.PR_MRN,
v.PR_CLUSTERID,
v.PR_ISINDEXCASE,
v.PR_DISEASE,
v.PR_DISEASESHORTNAME,
v.PR_OTHERDISEASE,
v.PR_DISTRICT,
v.PR_PROCESSSTATUS,
v.PR_SPA,
v.PR_RESOLUTIONSTATUS,
v.PR_NURSEINVESTIGATOR,
v.PR_REPORTEDBYWEB,
v.PR_REPORTEDBYLAB,
v.PR_REPORTEDBYEHR,
v.PR_TRANSMISSIONSTATUS,
v.PR_DISEASECODE_DR,
v.PR_DISTRICTCODE_DR,
v.PR_PROCESSSTATUSCODE_DR,
v.PR_SPACODE_DR,
v.PR_RESOLUTIONSTATUSCODE_DR,
v.PR_NURSEINVESTIGATORDR,
CAST(v.PR_SPECIMENTYPE AS ntext) AS PR_SPECIMENTYPEPR_SPECIMENTYPE,
CAST(v.PR_SPECIMENDATECOLLECTED AS ntext) AS PR_SPECIMENDATECOLLECTED,
CAST(v.PR_SPECIMENDATERECEIVED AS ntext) AS PR_SPECIMENDATERECEIVED,
CAST(v.PR_SPECIMENRESULT AS ntext) AS PR_SPECIMENRESULT,
CAST(v.PR_SPECIMENNOTE AS ntext) AS PR_SPECIMENNOTEPR_SPECIMENNOTE,
v.PR_DIAGSPECIMENTYPES,
v.PR_EXPEXPOSURETYPES,
v.PR_HEPATITISDRS,
v.PR_DISEASEGROUPS,
CAST(v.PR_RESULTVALUE AS ntext) AS PR_RESULTVALUE,
v.PR_LIPTESTORDERED,
v.PR_ISPREGNANT,
CAST(v.PR_EXPECTEDDELIVERYDATE AS datetime2(3)) AS PR_EXPECTEDDELIVERYDATE,
CAST(v.PR_LIPRESULTNOTES AS ntext) AS PR_LIPRESULTNOTES,
v.PR_LIPRESULTNAME,
v.PR_HEALTHCAREPROVIDER,
v.PR_HEALTHCAREPROVIDERLOCATIONDR,
CAST(v.PR_NOTES AS text) AS PR_NOTES,
CAST(v.PR_DATEOFDIAGNOSIS AS datetime2(3)) AS PR_DATEOFDIAGNOSIS,
CAST(v.PR_DATEOFDEATH AS datetime2(3)) AS PR_DATEOFDEATH,
CAST(v.PR_DATEOFLABREPORT AS datetime2(3)) AS PR_DATEOFLABREPORT,
CAST(v.PR_DATEINVESTIGATORRECEIVED AS datetime2(3)) AS PR_DATEINVESTIGATORRECEIVED,
v.PR_ISSYMPTOMATIC,
v.PR_ISPATIENTDIEDOFTHEILLNESS,
v.PR_ISPATIENTHOSPITALIZED,
CAST(v.PR_LABSPECIMENCOLLECTEDDATE AS datetime2(3)) AS PR_LABSPECIMENCOLLECTEDDATE,
CAST(v.PR_LABSPECIMENRESULTDATE AS datetime2(3)) AS PR_LABSPECIMENRESULTDATE,
CAST(v.PR_DATEADMITTED AS datetime2(3)) AS PR_DATEADMITTED,
CAST(v.PR_DATEDISCHARGED AS datetime2(3)) AS PR_DATEDISCHARGED,
v.PR_LABORATORY,
v.PR_HOSPITALDR,
v.PR_HOSPITAL,
v.PR_OUTPATIENT,
v.PR_INPATIENT,
CAST(v.PR_DATESENT AS datetime2(3)) AS PR_DATESENT,
CAST(v.PR_LASTCDCUPDATE AS datetime2(3)) AS PR_LASTCDCUPDATE,
v.PR_NAMEOFSUBMITTER,
CAST(v.PR_OUTBREAKNUMBERS AS text) AS PR_OUTBREAKNUMBERS,
CAST(v.PR_OUTBREAKTYPES AS text) AS PR_OUTBREAKTYPES,
v.PR_ANIMALREPORTID,
v.PR_FBIDR,
v.PR_FBINumber,
v.PR_CENSUSTRACT, 
replace(isnull(TENAdditionalProvider.TRIVIALNAME,''),',','&Comma;') as Additional_Provider,
replace(isnull(TENAdditionalLaboratory.TRIVIALNAME,''),',','&Comma;') as Additional_Laboratory,

       dvpr_standardage                                                     Age, 
       CAST(Isnull((SELECT dbo.[Strconcat]( 
                      dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS 
                             Specify 
               FROM   t_race tr 
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.entity_id = per.dvper_rowid 
                      AND tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( 
                      [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id) 
                          , 
                          '') = 
                          'American Indian or Alaska Native'), '') AS ntext)          AS 
       American_Indian_or_Alaska_Native, 
       CAST(Isnull((SELECT dbo.[Strconcat]( 
                      dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS 
                             Specify 
               FROM   t_race tr 
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.entity_id = per.dvper_rowid 
                      AND tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( 
                      [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id) 
                          , 
                          '') = 'Asian'), '') AS ntext)                               AS 
       Asian___Specify, 
       CAST(Isnull((SELECT dbo.[Strconcat]( 
                      dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS 
                             Specify 
               FROM   t_race tr 
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.entity_id = per.dvper_rowid 
                      AND tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( 
                      [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id) 
                          , 
                          '') = 
                          'Black or African American'), '') AS ntext)                 AS 
       Black_or_African_American___Spec, 
       dvpr_cmrid 
       CMR_ID, 
       Isnull((SELECT dbo.Fn_getucsfullname(PERCOUNTRY.partcountry) 
               FROM   t_entityaddress PERCOUNTRY (nolock) 
                      JOIN dv_person per 
                        ON PERCOUNTRY.entity_id = per.dvper_rowid 
               WHERE  per.dvper_rowid = v.pr_persondr 
                      AND PERCOUNTRY.usecode = 'BIR'), '') 
       Country_of_Birth, 
       Isnull((SELECT CASE UCS_NAMESPACE.conceptcode 
                        WHEN 'ELR' THEN 'LAB INTERFACE' 
                        WHEN 'WEB' THEN 'WEB INTERFACE' 
                        ELSE 'MAIN INTERFACE' 
                      END val 
               FROM   dv_phpersonalrecord dvpr (nolock) 
                      INNER JOIN s_processedprrecord (nolock) 
                              ON ( s_processedprrecord.originalliverecord_id = 
                                   dvpr.dvpr_rowid 
                                 ) 
                                 AND s_processedprrecord.statuscode = 'active' 
                                 AND s_processedprrecord.importoptioncode_id <> 
                                     (SELECT UCS.id 
                                      FROM 
                                     v_unifiedcodeset UCS (nolock) 
                                     INNER JOIN v_domain VD ( 
                                                nolock) 
                                             ON UCS.domain_id = 
                                                VD.id 
                                                AND 
                                         VD.domainname = 'NameSpaceImport' 
                                     WHERE 
                                     UCS.conceptcode = 'ALR') 
                      INNER JOIN v_unifiedcodeset UCS_NAMESPACE (nolock) 
                              ON s_processedprrecord.namespacecode_id = 
                                 UCS_NAMESPACE.id 
               WHERE  v.pr_rowid = dvpr.dvpr_rowid), 'MAIN INTERFACE') 
       Created_By, 
       CAST(dvpr_datelastedited AS datetime2(3)) AS 
       Date_Last_Edited, 
       Isnull((SELECT fullname 
               FROM   dv_phpersonalrecord dvpr (nolock) 
                      JOIN v_unifiedcodeset ucs (nolock) 
                        ON dvpr.dvpr_finaldisposition = ucs.id 
               WHERE  v.pr_rowid = dvpr.dvpr_rowid), '') 
       Final_Disposition, 
       CAST(Isnull((SELECT dbo.Strconcat(DISTINCT CASE 
                                               WHEN 
                      ACTOBS.metacode = 'DIST_RowID' THEN 
                                               UCS.fullname 
                                             END) 
               FROM   dv_phpersonalrecord dvpr (nolock) 
                      JOIN a_act a1 
                        ON dvpr.dvpr_rowid = a1.act_parent_id 
                      INNER JOIN a_act ACTTOPIC (nolock) 
                              ON ACTTOPIC.act_parent_id = a1.id 
                                 AND ACTTOPIC.classcode = 'TOPIC' 
                      INNER JOIN a_act ACTOBS (nolock) 
                              ON ACTOBS.act_parent_id = ACTTOPIC.id 
                                 AND ACTOBS.classcode = 'OBS' 
                      INNER JOIN dbo.v_unifiedcodeset UCS (nolock) 
                              ON ACTOBS.code_id = UCS.id 
               WHERE  dvpr.dvpr_incidentid = v.pr_incidentid), '') AS ntext) AS 
       Diagnostic_Specimen_Types, 
       Isnull((SELECT jurisdictioncode 
               FROM   dv_phpersonalrecord dvpr (nolock) 
                      JOIN vcp_district dist (nolock) 
                        ON dvpr.dvpr_districtcode_id = dist.subjcode_id 
               WHERE  v.pr_rowid = dvpr.dvpr_rowid), '') 
       Health_District_Number, 
       Isnull((SELECT CASE 
                        WHEN( [s_processedprrecord].[dateprocessed] IS NOT NULL 
                              AND [s_processedprrecord].[importedbyuserdr] IS 
                                  NULL ) 
                      THEN 
                        'System Process' 
                        ELSE ( ImportedBy.partfam + ', ' + ImportedBy.partgiv ) 
                      END 
               FROM   dv_phpersonalrecord dvpr (nolock) 
                      JOIN [s_processedprrecord] (nolock) 
                        ON ( [originalliverecord_id] = dvpr.dvpr_rowid ) 
                           AND s_processedprrecord.statuscode = 'active' 
                           AND s_processedprrecord.importoptioncode_id <> 
                               (SELECT UCS.id 
                                FROM 
                               v_unifiedcodeset UCS (nolock) 
                               INNER JOIN v_domain VD ( 
                                          nolock) 
                                       ON UCS.domain_id = 
                                          VD.id 
                                          AND 
                                   VD.domainname = 'NameSpaceImport' 
                                                                           WHERE 
                               UCS.conceptcode = 'ALR') 
                      LEFT JOIN t_entityname ImportedBy (nolock) 
                             ON ImportedBy.entity_id = 
                                s_processedprrecord.[importedbyuserdr] 
               WHERE  v.pr_rowid = dvpr.dvpr_rowid), '') 
       ImportedBy, 
       COALESCE(Cast(dvpr_importedstatus AS VARCHAR), '') 
       Imported_Status, 
       CASE dvpr_reportedbylab 
         WHEN 1 THEN 'True' 
         ELSE 'False' 
       END 
       Lab_Report, 
       Isnull(dvpr_lipresultnotes, '') 
       Lab_Report_Notes, 
       Isnull(dvpr_liptestordered, '') 
       Lab_Report_Test_Name, 
       Isnull((SELECT fullname 
               FROM   dv_person per (nolock) 
                      JOIN v_unifiedcodeset ucs (nolock) 
                        ON per.dvper_maritalstatuscode_id = ucs.id 
               WHERE  v.pr_persondr = per.dvper_rowid), '') 
       Marital_Status, 
       Isnull(dvpr_mrn, '') 
       Medical_Record_Number, 
       Isnull((SELECT CASE 
                        WHEN Charindex(' - ', Isnull(dilr_resulttest, '')) > 1 
                      THEN 
                        dilr_resulttest 
                        ELSE dilr_localtestdescription 
                      END 
               FROM   dv_phpersonalrecord dvpr 
                      LEFT JOIN a_act LABREPORT (nolock) 
                             ON LABREPORT.act_parent_id = dvpr.dvpr_rowid 
                                AND LABREPORT.metacode = 'DILR_ID' 
                                AND LABREPORT.id = 
                                    dbo.Fn_lab_actid(dvpr.dvpr_rowid) 
                      LEFT JOIN ax_labreport (nolock) 
                             ON dilr_id = LABREPORT.id 
               WHERE  dvpr.dvpr_rowid = v.pr_rowid), '') 
       Most_Recent_Lab_Result, 
       Isnull((SELECT Isnull(dvpr.dvpr_lipresultvalue, 
                      LABREPORT.dilr_resultvalue) 
               FROM   dv_phpersonalrecord dvpr 
                      JOIN ax_labreport LABREPORT (nolock) 
                        ON LABREPORT.dilr_id = dbo.Fn_lab_actid(dvpr.dvpr_rowid) 
               WHERE  v.pr_rowid = dvpr.dvpr_rowid), '') 
       Most_Recent_Lab_Result_Value, 
       CAST(Isnull((SELECT dbo.[Strconcat]( 
                      dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS 
                             Specify 
               FROM   t_race tr 
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.entity_id = per.dvper_rowid 
                      AND tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( 
                      [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id) 
                          , 
                          '') = 
                          'Native Hawaiian or Other Pacific Islander'), '') AS ntext) AS 
       Native_Hawaiian_or_Other_Pacific, 
       Isnull((SELECT fullname 
               FROM   dv_person per (nolock) 
                      JOIN v_unifiedcodeset ucs (nolock) 
                        ON per.dvper_occupationsettingtypedr = ucs.id 
               WHERE  v.pr_persondr = per.dvper_rowid), '') 
       Occupation_Setting_Type, 
       CAST(Isnull((SELECT dbo.[Strconcat]( 
                      dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS 
                             Specify 
               FROM   t_race tr 
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.entity_id = per.dvper_rowid 
                      AND tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( 
                      [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id) 
                          , 
                          '') = 'Other'), '') AS ntext)                               AS 
       Other___Specify, 
       CAST(Isnull(dvpr_outbreakdrstext, '') AS text) AS 
       Outbreak_IDs, 
       Isnull(dvper_guardianname, '') 
       Parent_or_Guardian_Name, 
       Isnull((SELECT fullname 
               FROM   dv_phpersonalrecord dvpr (nolock) 
                      JOIN v_unifiedcodeset ucs (nolock) 
                        ON dvpr.dvpr_prioritydr = ucs.id 
               WHERE  v.pr_rowid = dvpr.dvpr_rowid), '') 
       Priority, 
       Isnull(dvpr_providername, '') 
       Provider_Name, 
       Isnull((SELECT REPORTSOURCE.trivialname 
               FROM   dv_phpersonalrecord dvpr 
                      INNER JOIN t_entityname REPORTSOURCE (nolock) 
                              ON 
                      REPORTSOURCE.entity_id = dvpr.dvpr_reportsourcedr 
                      AND REPORTSOURCE.usecode = 'SRCH' 
                      AND REPORTSOURCE.metacode = 'RS_HEALTHCAREPROVIDER' 
               WHERE  v.pr_rowid = dvpr.dvpr_rowid), '') 
       Report_Source, 
       Isnull((SELECT dbo.Fn_getucsfullname(CPSecondaryDistrict.subjcode_id) 
               FROM   dv_phpersonalrecord dvpr 
                      LEFT JOIN vcp_district CPSecondaryDistrict (nolock) 
                             ON dvpr.dvpr_secondarydistrictcode_id = 
                                CPSecondaryDistrict.subjcode_id 
               WHERE  v.pr_rowid = dvpr.dvpr_rowid), '') 
       Secondary_District, 
       CAST(Isnull((SELECT dbo.Strconcat(DISTINCT CASE 
                                               WHEN 
                      ACTOBS.metacode = 'DIET_ROWID' THEN 
                                               UCS.fullname 
                                             END) 
               FROM   dv_phpersonalrecord dvpr 
                      INNER JOIN a_act ACTDOCBODY (nolock) 
                              ON dvpr.dvpr_rowid = ACTDOCBODY.act_parent_id 
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
               WHERE  v.pr_rowid = dvpr.dvpr_rowid 
                      AND ACTDOCBODY.classcode = 'DOCBODY' 
                      AND ACTOBS.metacode IN ( 'DIET_ROWID', 'DIST_RowID', 
                                               'DIHT_HEPATITISTESTDR' ) 
                      --AND ACTDOCBODY.ACT_PARENT_ID IN (SELECT DVPR_ROWID FROM #TMPMAIN)             
                      AND ACTOBS.statuscode = 'active' 
               GROUP  BY dvpr.dvpr_rowid), '') AS ntext) AS 
       Suspected_Exposure_Types, 
       Isnull((SELECT fullname 
               FROM   dv_phpersonalrecord dvpr (nolock) 
                      JOIN v_unifiedcodeset ucs (nolock) 
                        ON dvpr.dvpr_typeofcontactdr = ucs.id 
               WHERE  v.pr_rowid = dvpr.dvpr_rowid), '') 
       Type_of_Contact, 
       CAST(Isnull((SELECT dbo.[Strconcat]( 
                      dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS 
                             Specify 
               FROM   t_race tr 
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.entity_id = per.dvper_rowid 
                      AND tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( 
                      [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id) 
                          , 
                          '') = 
                          'Unknown'), '') AS ntext)                                   AS 
       Unknown___Specify, 
       CAST(Isnull((SELECT dbo.[Strconcat]( 
                      dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS 
                             Specify 
               FROM   t_race tr 
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.entity_id = per.dvper_rowid 
                      AND tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( 
                      [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id) 
                          , 
                          '') = 'White'), '') AS ntext)                               AS 
       White___Specify 
FROM   atlaspublic.view_uods_personalrecord v 
       JOIN dv_phpersonalrecord pr 
         ON v.pr_rowid = pr.dvpr_rowid 
       JOIN dv_person per 
         ON v.pr_persondr = per.dvper_rowid 
		--AddtionalReportSource
		LEFT JOIN P_Participation PPAdditionalReportSource (nolock) on PPAdditionalReportSource.Act_ID=PR.DVPR_RowID
        and PPAdditionalReportSource.TypeCode = 'REFB' And PPAdditionalReportSource.MetaCode = 'PR_AdditionalReportSourceDR'
         LEFT JOIN R_Role RAdditionalReportSource (nolock) on RAdditionalReportSource.ID=PPAdditionalReportSource.Role_ID 
        and RAdditionalReportSource.ClassCode = 'QUAL'
        LEFT JOIN T_EntityName TENAdditionalProvider (nolock) on 
        TENAdditionalProvider.Entity_ID=RAdditionalReportSource.Player_ID
        and TENAdditionalProvider.MetaCode='RS_HealthCareProvider' and TENAdditionalProvider.UseCode='SRCH'
		--AddtionalLab
		LEFT JOIN P_Participation PPAdditionalLaboratory (nolock) on PPAdditionalLaboratory.Act_ID= PR.DVPR_RowID 
        and PPAdditionalLaboratory.TypeCode='ELOC' and PPAdditionalLaboratory.MetaCode='PR_AdditionalLaboratoryDR'
        LEFT JOIN R_Role RRAdditionalLaboratory (nolock) on RRAdditionalLaboratory.ID=PPAdditionalLaboratory.Role_ID 
        and RRAdditionalLaboratory.ClassCode='QUAL'
        LEFT JOIN T_EntityName TENAdditionalLaboratory (nolock) on 
        TENAdditionalLaboratory.Entity_ID=RRAdditionalLaboratory.Player_ID and TENAdditionalLaboratory.MetaCode='LOC_Name'
        and TENAdditionalLaboratory.UseCode='SRCH'

WHERE  pr_diseasecode_dr = 544041 
and v.PR_NAMESPACE = 'LIVE';
