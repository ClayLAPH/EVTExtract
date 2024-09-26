



CREATE VIEW [covid].[COVID_INCIDENT_VIEW_ADDL2]
AS
SELECT A.id
       AS PR_ROWID,
       ACT_OTHERDISEASE.valuestring_txt
       AS PR_OTHERDISEASE,
Cast(lipnotes.valuestring AS NVARCHAR(max))
       AS PR_LIPRESULTNOTES,
Isnull(A8.valuestring, A5.valuestring)
       AS PR_LIPRESULTNAME,
A8.availabilitytime
       AS PR_DATEOFLABREPORT,
LAB.trivialname
       AS PR_LABORATORY,
R_HOSPITAL.player_id
       AS PR_HOSPITALDR,
TEN_HOSPITAL.trivialname
       AS PR_HOSPITAL,
DATESENT.activitytime_beg
       AS PR_DATESENT,
DATESENT.activitytime_end
       AS PR_LASTCDCUPDATE,
AI.dvai_animalreportid
       AS PR_ANIMALREPORTID,
FBIInc.source_id
       AS PR_FBIDR,
FBIComp.extension
       AS PR_FBINumber,
Replace(Isnull(TENAdditionalProvider.trivialname, ''), ',', '&Comma;')
       AS
Additional_Provider,
Replace(Isnull(TENAdditionalLaboratory.trivialname, ''), ',', '&Comma;')
       AS
Additional_Laboratory,
Isnull(diag_spec_types.types, '')
       AS Diagnostic_Specimen_Types,
Isnull(CASE
         WHEN Charindex(' - ', Isnull(dilr_resulttest, '')) > 1 THEN
         dilr_resulttest
         ELSE dilr_localtestdescription
       END, '')
       AS Most_Recent_Lab_Result,
Isnull(Isnull(PR.dvpr_lipresultvalue, dbo.ax_labreport.dilr_resultvalue), '')
       AS
Most_Recent_Lab_Result_Value,
Isnull(sus_expo_types.types, '')
       AS Suspected_Exposure_Types
FROM   dbo.dv_phpersonalrecord AS PR WITH (nolock)
       INNER JOIN dbo.dv_person AS PER WITH (nolock)
               ON PER.dvper_rowid = PR.dvpr_persondr
       LEFT OUTER JOIN dbo.v_unifiedcodeset AS UCSNamespace WITH (nolock)
                    ON PER.dvper_namespacecode_id = UCSNamespace.id
       LEFT OUTER JOIN dbo.v_unifiedcodeset AS UCSImportOptions WITH (nolock)
                    ON PER.dvper_importoptionscode_id = UCSImportOptions.id
       INNER JOIN dbo.a_act AS A WITH (nolock)
               ON A.id = PR.dvpr_rowid
                  AND A.metacode = 'PR_ROWID'
       INNER JOIN dbo.a_publichealthcase AS PH WITH (nolock)
               ON PH.id = A.id
       LEFT OUTER JOIN dbo.a_act AS lipnotes WITH (nolock)
                    ON lipnotes.act_parent_id = A.id
                       AND lipnotes.metacode = 'PR_LIPRESULTNOTES'
       LEFT OUTER JOIN dbo.a_act AS ACT_OTHERDISEASE WITH (nolock)
                    ON ACT_OTHERDISEASE.act_parent_id = A.id
                       AND ACT_OTHERDISEASE.metacode = 'PR_OTHERDISEASENAME'
       LEFT OUTER JOIN dbo.a_act AS A5 WITH (nolock)
                    ON A5.act_parent_id = A.id
                       AND A5.metacode = 'PR_LIPRESULTNAME'
       LEFT OUTER JOIN dbo.a_act AS A8 WITH (nolock)
                    ON A8.act_parent_id = A.id
                       AND A8.metacode = 'DILR_ID'
                       AND A8.id = dbo.Fn_lab_actid(A.id)
LEFT OUTER JOIN dbo.p_participation AS PART WITH (nolock)
ON PART.act_id = PR.dvpr_rowid
AND PART.typecode = 'ELOC'
AND PART.metacode = 'PR_LABORATORYDR'
LEFT OUTER JOIN dbo.r_role AS RLAB WITH (nolock)
ON RLAB.id = PART.role_id
AND RLAB.classcode = 'QUAL'
LEFT OUTER JOIN dbo.t_entityname AS LAB WITH (nolock)
ON LAB.entity_id = RLAB.player_id
AND LAB.usecode = 'SRCH'
LEFT OUTER JOIN dbo.p_participation AS P_HOSPITAL WITH (nolock)
ON P_HOSPITAL.act_id = A.id
AND P_HOSPITAL.metacode = 'PR_HOSPITALDR'
LEFT OUTER JOIN dbo.r_role AS R_HOSPITAL WITH (nolock)
ON R_HOSPITAL.id = P_HOSPITAL.role_id
AND R_HOSPITAL.classcode = 'QUAL'
LEFT OUTER JOIN dbo.a_act AS DATESENT WITH (nolock)
ON PR.dvpr_rowid = DATESENT.act_parent_id
AND DATESENT.classcode = 'OBS'
AND DATESENT.metacode = 'PR_DATESENT'
LEFT OUTER JOIN dbo.t_entityname AS TEN_HOSPITAL WITH (nolock)
ON TEN_HOSPITAL.entity_id = R_HOSPITAL.player_id
AND TEN_HOSPITAL.usecode = 'SRCH'
AND TEN_HOSPITAL.metacode = 'LOC_NAME'
LEFT OUTER JOIN dbo.a_actrelationship AS ACTREL_ANIMAL WITH (nolock)
ON A.id = ACTREL_ANIMAL.target_id
AND ACTREL_ANIMAL.typecode = 'COMP'
AND ACTREL_ANIMAL.metacode IN ( 'AI_CONTACTINVESTIGATIONDR',
                        'AI_DISEASEINCIDENTDR'
                      )
LEFT OUTER JOIN dbo.dv_animalreport AS AI WITH (nolock)
ON AI.dvai_rowid = ACTREL_ANIMAL.source_id
LEFT OUTER JOIN dbo.a_actrelationship AS FBIInc WITH (nolock)
ON PH.id = FBIInc.target_id
AND FBIInc.typecode = 'COMP'
AND FBIInc.metacode = 'PR_FBIDR'
LEFT OUTER JOIN dbo.t_instanceidentifier AS FBIComp WITH (nolock)
ON FBIInc.source_id = FBIComp.act_id
LEFT OUTER JOIN dbo.ax_labreport WITH (nolock)
ON dbo.ax_labreport.dilr_id = A8.id
LEFT OUTER JOIN dbo.p_participation AS PPAdditionalReportSource WITH (nolock)
ON PPAdditionalReportSource.act_id = PR.dvpr_rowid
AND PPAdditionalReportSource.typecode = 'REFB'
AND PPAdditionalReportSource.metacode =
'PR_AdditionalReportSourceDR'
LEFT OUTER JOIN dbo.r_role AS RAdditionalReportSource WITH (nolock)
ON RAdditionalReportSource.id = PPAdditionalReportSource.role_id
AND RAdditionalReportSource.classcode = 'QUAL'
LEFT OUTER JOIN dbo.t_entityname AS TENAdditionalProvider WITH (nolock)
ON TENAdditionalProvider.entity_id =
RAdditionalReportSource.player_id
AND TENAdditionalProvider.metacode = 'RS_HealthCareProvider'
AND TENAdditionalProvider.usecode = 'SRCH'
LEFT OUTER JOIN dbo.p_participation AS PPAdditionalLaboratory WITH (nolock)
ON PPAdditionalLaboratory.act_id = PR.dvpr_rowid
AND PPAdditionalLaboratory.typecode = 'ELOC'
AND PPAdditionalLaboratory.metacode =
'PR_AdditionalLaboratoryDR'
LEFT OUTER JOIN dbo.r_role AS RRAdditionalLaboratory WITH (nolock)
ON RRAdditionalLaboratory.id = PPAdditionalLaboratory.role_id
AND RRAdditionalLaboratory.classcode = 'QUAL'
LEFT OUTER JOIN dbo.t_entityname AS TENAdditionalLaboratory WITH (nolock)
ON TENAdditionalLaboratory.entity_id =
RRAdditionalLaboratory.player_id
AND TENAdditionalLaboratory.metacode = 'LOC_Name'
AND TENAdditionalLaboratory.usecode = 'SRCH'
LEFT OUTER JOIN (SELECT dbo.Strconcat(DISTINCT CASE
                         WHEN
ACTOBS.metacode = 'DIST_RowID' THEN
                         UCS.fullname
                       END) AS types,
a1.act_parent_id            AS dvpr_rowid
FROM   dbo.a_act AS a1 WITH (nolock)
INNER JOIN dbo.a_act AS ACTTOPIC WITH (nolock)
        ON ACTTOPIC.act_parent_id = a1.id
           AND ACTTOPIC.classcode = 'TOPIC'
INNER JOIN dbo.a_act AS ACTOBS WITH (nolock)
        ON ACTOBS.act_parent_id = ACTTOPIC.id
           AND ACTOBS.classcode = 'OBS'
INNER JOIN dbo.v_unifiedcodeset AS UCS WITH (nolock)
        ON ACTOBS.code_id = UCS.id
GROUP  BY a1.act_parent_id) AS diag_spec_types
ON diag_spec_types.dvpr_rowid = PR.dvpr_rowid
LEFT OUTER JOIN (SELECT dbo.Strconcat(DISTINCT CASE
                         WHEN
ACTOBS.metacode = 'DIET_ROWID' THEN
                         UCS.fullname
                       END) AS types,
ACTDOCBODY.act_parent_id    AS dvpr_rowid
FROM   dbo.a_act AS ACTDOCBODY WITH (nolock)
INNER JOIN dbo.a_act AS ACTTOPIC WITH (nolock)
        ON ACTTOPIC.act_parent_id = ACTDOCBODY.id
           AND ACTTOPIC.classcode = 'TOPIC'
INNER JOIN dbo.a_act AS ACTOBS WITH (nolock)
        ON ACTOBS.act_parent_id = ACTTOPIC.id
           AND ACTOBS.classcode = 'OBS'
INNER JOIN dbo.v_unifiedcodeset AS UCS WITH (nolock)
        ON ACTOBS.code_id = UCS.id
LEFT OUTER JOIN dbo.a_observation AS OBSERVATION WITH (
                nolock)
             ON OBSERVATION.id = ACTOBS.id
                AND
ACTOBS.metacode = 'DIHT_HEPATITISTESTDR'
LEFT OUTER JOIN dbo.v_unifiedcodeset AS UCSOBSERVATION
                WITH (nolock)
             ON UCSOBSERVATION.id =
                OBSERVATION.interpretationcode_id
WHERE  ( ACTDOCBODY.classcode = 'DOCBODY' )
AND ( ACTOBS.metacode IN ( 'DIET_ROWID', 'DIST_RowID',
                           'DIHT_HEPATITISTESTDR' )
    )
AND ( ACTOBS.statuscode = 'active' )
GROUP  BY ACTDOCBODY.act_parent_id) AS sus_expo_types
ON PR.dvpr_rowid = sus_expo_types.dvpr_rowid
WHERE  ( PR.dvpr_diseasecode_id = 543030 )
       AND ( UCSNamespace.id IS NULL )
        OR ( PR.dvpr_diseasecode_id = 543030 )
           AND ( UCSNamespace.id IS NOT NULL )
           AND ( UCSImportOptions.id IS NOT NULL )
           AND ( UCSImportOptions.conceptcode NOT IN ( 'ALR', 'UDL' ) ) 



