create view [covid].[SARS2_INCIDENT_INCREMENTAL]
as
SELECT v.*, 
replace(isnull(TENAdditionalProvider.TRIVIALNAME,''),',','&amp;Comma;') as Additional_Provider,
replace(isnull(TENAdditionalLaboratory.TRIVIALNAME,''),',','&amp;Comma;') as Additional_Laboratory,

       dvpr_standardage                                                     Age, 
       Isnull((SELECT dbo.[Strconcat]( 
                      dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS 
                             Specify 
               FROM   t_race tr (nolock)
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.entity_id = per.dvper_rowid 
                      AND tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( 
                      [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id) 
                          , 
                          '') = 
                          'American Indian or Alaska Native'), '')          AS 
       American_Indian_or_Alaska_Native, 
       Isnull((SELECT dbo.[Strconcat]( 
                      dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS 
                             Specify 
               FROM   t_race tr (nolock)
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.entity_id = per.dvper_rowid 
                      AND tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( 
                      [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id) 
                          , 
                          '') = 'Asian'), '')                               AS 
       Asian___Specify, 
       Isnull((SELECT dbo.[Strconcat]( 
                      dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS 
                             Specify 
               FROM   t_race tr (nolock)
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.entity_id = per.dvper_rowid 
                      AND tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( 
                      [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id) 
                          , 
                          '') = 
                          'Black or African American'), '')                 AS 
       Black_or_African_American___Spec, 
       dvpr_cmrid 
       CMR_ID, 
       Isnull((SELECT dbo.Fn_getucsfullname(PERCOUNTRY.partcountry) 
               FROM   t_entityaddress PERCOUNTRY (nolock) 
                      JOIN dv_person per (nolock)
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
       dvpr_datelastedited 
       Date_Last_Edited, 
       Isnull((SELECT fullname 
               FROM   dv_phpersonalrecord dvpr (nolock) 
                      JOIN v_unifiedcodeset ucs (nolock) 
                        ON dvpr.dvpr_finaldisposition = ucs.id 
               WHERE  v.pr_rowid = dvpr.dvpr_rowid), '') 
       Final_Disposition, 
       Isnull((SELECT dbo.Strconcat(DISTINCT CASE 
                                               WHEN 
                      ACTOBS.metacode = 'DIST_RowID' THEN 
                                               UCS.fullname 
                                             END) 
               FROM   dv_phpersonalrecord dvpr (nolock) 
                      JOIN a_act a1 (nolock)
                        ON dvpr.dvpr_rowid = a1.act_parent_id 
                      INNER JOIN a_act ACTTOPIC (nolock) 
                              ON ACTTOPIC.act_parent_id = a1.id 
                                 AND ACTTOPIC.classcode = 'TOPIC' 
                      INNER JOIN a_act ACTOBS (nolock) 
                              ON ACTOBS.act_parent_id = ACTTOPIC.id 
                                 AND ACTOBS.classcode = 'OBS' 
                      INNER JOIN dbo.v_unifiedcodeset UCS (nolock) 
                              ON ACTOBS.code_id = UCS.id 
               WHERE  dvpr.dvpr_incidentid = v.pr_incidentid), '') 
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
               FROM   dv_phpersonalrecord dvpr (nolock)
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
               FROM   dv_phpersonalrecord dvpr (nolock)
                      JOIN ax_labreport LABREPORT (nolock) 
                        ON LABREPORT.dilr_id = dbo.Fn_lab_actid(dvpr.dvpr_rowid) 
               WHERE  v.pr_rowid = dvpr.dvpr_rowid), '') 
       Most_Recent_Lab_Result_Value, 
       Isnull((SELECT dbo.[Strconcat]( 
                      dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS 
                             Specify 
               FROM   t_race tr (nolock)
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.entity_id = per.dvper_rowid 
                      AND tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( 
                      [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id) 
                          , 
                          '') = 
                          'Native Hawaiian or Other Pacific Islander'), '') AS 
       Native_Hawaiian_or_Other_Pacific, 
       Isnull((SELECT fullname 
               FROM   dv_person per (nolock) 
                      JOIN v_unifiedcodeset ucs (nolock) 
                        ON per.dvper_occupationsettingtypedr = ucs.id 
               WHERE  v.pr_persondr = per.dvper_rowid), '') 
       Occupation_Setting_Type, 
       Isnull((SELECT dbo.[Strconcat]( 
                      dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS 
                             Specify 
               FROM   t_race tr (nolock)
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.entity_id = per.dvper_rowid 
                      AND tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( 
                      [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id) 
                          , 
                          '') = 'Other'), '')                               AS 
       Other___Specify, 
       Isnull(dvpr_outbreakdrstext, '') 
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
               FROM   dv_phpersonalrecord dvpr (nolock)
                      INNER JOIN t_entityname REPORTSOURCE (nolock) 
                              ON 
                      REPORTSOURCE.entity_id = dvpr.dvpr_reportsourcedr 
                      AND REPORTSOURCE.usecode = 'SRCH' 
                      AND REPORTSOURCE.metacode = 'RS_HEALTHCAREPROVIDER' 
               WHERE  v.pr_rowid = dvpr.dvpr_rowid), '') 
       Report_Source, 
       Isnull((SELECT dbo.Fn_getucsfullname(CPSecondaryDistrict.subjcode_id) 
               FROM   dv_phpersonalrecord dvpr (nolock)
                      LEFT JOIN vcp_district CPSecondaryDistrict (nolock) 
                             ON dvpr.dvpr_secondarydistrictcode_id = 
                                CPSecondaryDistrict.subjcode_id 
               WHERE  v.pr_rowid = dvpr.dvpr_rowid), '') 
       Secondary_District, 
       Isnull((SELECT dbo.Strconcat(DISTINCT CASE 
                                               WHEN 
                      ACTOBS.metacode = 'DIET_ROWID' THEN 
                                               UCS.fullname 
                                             END) 
               FROM   dv_phpersonalrecord dvpr (nolock)
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
                      AND ACTOBS.statuscode = 'active' 
               GROUP  BY dvpr.dvpr_rowid), '') 
       Suspected_Exposure_Types, 
       Isnull((SELECT fullname 
               FROM   dv_phpersonalrecord dvpr (nolock) 
                      JOIN v_unifiedcodeset ucs (nolock) 
                        ON dvpr.dvpr_typeofcontactdr = ucs.id 
               WHERE  v.pr_rowid = dvpr.dvpr_rowid), '') 
       Type_of_Contact, 
       Isnull((SELECT dbo.[Strconcat]( 
                      dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS 
                             Specify 
               FROM   t_race tr (nolock)
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.entity_id = per.dvper_rowid 
                      AND tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( 
                      [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id) 
                          , 
                          '') = 
                          'Unknown'), '')                                   AS 
       Unknown___Specify, 
       Isnull((SELECT dbo.[Strconcat]( 
                      dbo.[Mdf_ucs_fullname_ucs_byucsid](tr.racecode_id)) AS 
                             Specify 
               FROM   t_race tr (nolock)
                      LEFT JOIN v_codeproperty VCP_CAT (nolock) 
                             ON tr.racecode_id = VCP_CAT.subjcode_id 
                                AND VCP_CAT.property = 'Race_CategoryDR' 
               WHERE  tr.entity_id = per.dvper_rowid 
                      AND tr.metacode = 'PER_MultipleRaceDR' 
                      AND Isnull( 
                      [DBO].[Mdf_ucs_fullname_ucs_byucsid](VCP_CAT.valuecode_id) 
                          , 
                          '') = 'White'), '')                               AS 
       White___Specify 
FROM   atlaspublic.view_uods_personalrecord v (nolock)
       JOIN dv_phpersonalrecord pr (nolock)
         ON v.pr_rowid = pr.dvpr_rowid 
       JOIN dv_person per (nolock)
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
and v.PR_NAMESPACE = 'LIVE' 
and pr.DVPR_CreateDate > (select previous_execution_time from [dbo].[job_status] where id='sars-incidents')
and pr.DVPR_CreateDate <= (select execution_time from [dbo].[job_status] where id='sars-incidents');