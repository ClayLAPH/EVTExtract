


CREATE VIEW [covid].[COVID_INCIDENT_VIEW_CORE]
AS
SELECT A.id
       AS PR_ROWID,
       dbo.Fn_getucsfullname(PR.dvpr_typedr)
       AS PR_PHTYPE,
       A.localid
       AS PR_LEGACY_ROWID,
       PR.dvpr_persondr
       AS PR_PERSONDR,
       PR.dvpr_userdr
       AS PR_USERDR,
       PR.dvpr_outbreakdrstext
       AS PR_OUTBREAKDRSTEXT,
       PR.dvpr_incidentid
       AS PR_INCIDENTID,
       PR.dvpr_cmrid
       AS PR_CMRRECORD,
       CASE
         WHEN UCSNamespace.conceptcode = 'WEB' THEN 'WEB'
         WHEN UCSNamespace.conceptcode = 'MLR' THEN 'MLR'
         WHEN ( ( UCSNamespace.id IS NULL )
                 OR ( ( UCSNamespace.id IS NOT NULL )
                      AND ( UCSImportOptions.id IS NOT NULL )
                      AND ( UCSImportOptions.conceptcode NOT IN ( 'ALR', 'UDL' )
                          ) ) )
       THEN 'LIVE'
         ELSE 'ELR'
       END
       AS PR_NAMESPACE,
       PR.dvpr_createdate
       AS PR_CREATEDATE,
       PR.dvpr_onsetdate
       AS PR_ONSETDATE,
       PR.dvpr_closeddate
       AS PR_CLOSEDDATE,
       PR.dvpr_episodedate
       AS PR_EPISODEDATE,
       PR.dvpr_standardage
       AS PR_STANDARDAGE,
       PR.dvpr_datesubmitted
       AS PR_DATESUBMITTED,
       PR.dvpr_datereportedby
       AS PR_DATEREPORTEDBY,
       PR.dvpr_reportsourcedr
       AS PR_REPORTSOURCEDR,
       PR.dvpr_mrn
       AS PR_MRN,
       PR.dvpr_clusterid
       AS PR_CLUSTERID,
       PR.dvpr_isindexcase
       AS PR_ISINDEXCASE,
       dbo.Mdf_ucs_fullname_ucs_byucsid(PR.dvpr_districtcode_id)
       AS PR_DISTRICT,
       dbo.Mdf_ucs_fullname_ucs_byucsid(PR.dvpr_processstatuscode_id)
       AS
       PR_PROCESSSTATUS,
       dbo.Mdf_ucs_fullname_ucs_byucsid(PR.dvpr_resolutionstatuscode_id)
       AS
       PR_RESOLUTIONSTATUS,
       dbo.Mdf_attr_getbooleanvalue_actattr_byactid(A.id, 'PR_REPORTEDBYWEB')
       AS
       PR_REPORTEDBYWEB,
       dbo.Mdf_attr_getbooleanvalue_actattr_byactid(A.id, 'PR_REPORTEDBYLAB')
       AS
       PR_REPORTEDBYLAB,
       dbo.Mdf_attr_getbooleanvalue_actattr_byactid(A.id, 'PR_REPORTEDBYEHR')
       AS
       PR_REPORTEDBYEHR,
       dbo.Mdf_ucs_fullname_attrucs_byactid(A.id, 'VALUECODE_ID',
       'PR_TRANSMISSIONSTATUS')
       AS PR_TRANSMISSIONSTATUS,
       PR.dvpr_diseasecode_id
       AS PR_DISEASECODE_DR,
       PR.dvpr_districtcode_id
       AS PR_DISTRICTCODE_DR,
       PR.dvpr_processstatuscode_id
       AS PR_PROCESSSTATUSCODE_DR,
       PR.dvpr_resolutionstatuscode_id
       AS PR_RESOLUTIONSTATUSCODE_DR,
       PR.dvpr_nurseinvestigatordr
       AS PR_NURSEINVESTIGATORDR,
       dbo.Fn_cumulativetypes(A.id, 'DIST_ROWID')
       AS PR_DIAGSPECIMENTYPES,
       dbo.Fn_cumulativetypes(A.id, 'DIET_ROWID')
       AS PR_EXPEXPOSURETYPES,
       dbo.Fn_cumulativetypes(A.id, 'DIHT_HEPATITISTESTDR')
       AS PR_HEPATITISDRS,
       dbo.Fn_diseasegroups(A.code_id)
       AS PR_DISEASEGROUPS,
dbo.Mdf_act_getstringvalue_act_byparactidmetavaluetype('PR_LIPRESULTVALUE',
A.id, 'VALUESTRING_TXT')
       AS PR_RESULTVALUE,
dbo.Mdf_attr_getstringvalue_actattr_byactid(A.id, 'VALUESTRING_TXT',
'PR_LIPTESTORDERED')
       AS PR_LIPTESTORDERED,
dbo.Mdf_act_getbooleanvalue_act_byparactidmetavaluetype('PR_ISPREGNANT', A.id,
'VALUEBOOL')
       AS PR_ISPREGNANT,
dbo.Mdf_act_getdatetimevalue_act_byparactidmetavaluetype('PR_EXPECTEDDELIVERYDATE', A.id, 'VALUETS')               AS PR_EXPECTEDDELIVERYDATE,
A.text
       AS PR_NOTES,
PR.dvpr_diagnosisdate
       AS PR_DATEOFDIAGNOSIS,
dbo.Mdf_act_getdatetimevalue_act_byparactidmetavaluetype('PR_DATEOFDEATH', A.id,
'EFFECTIVETIME_BEG')
       AS PR_DATEOFDEATH,
A.availabilitytime
       AS PR_DATEINVESTIGATORRECEIVED,
dbo.Mdf_act_getbooleanvalue_act_byparactidmetavaluetype('PR_ISASYMPTOMATIC',
A.id, 'VALUEBOOL')
       AS PR_ISSYMPTOMATIC,
dbo.Mdf_act_getbooleanvalue_act_byparactidmetavaluetype('PR_ISPATIENTDIEDOFTHEILLNESS', A.id, 'VALUEBOOL')         AS PR_ISPATIENTDIEDOFTHEILLNESS,
PH.hospitalizedind
       AS PR_ISPATIENTHOSPITALIZED,
dbo.Mdf_act_getdatetimevalue_act_byparactidmetavaluetype('PR_LABSPECIMENCOLLECTEDDATE', A.id, 'EFFECTIVETIME_BEG') AS PR_LABSPECIMENCOLLECTEDDATE,
dbo.Mdf_act_getdatetimevalue_act_byparactidmetavaluetype('PR_LABSPECIMENRESULTDATE', A.id, 'EFFECTIVETIME_BEG')    AS PR_LABSPECIMENRESULTDATE,
A.valuets
       AS PR_DATEADMITTED,
A.valuetsend
       AS PR_DATEDISCHARGED,
dbo.Mdf_attr_getbooleanvalue_actattr_byactid(A.id, 'PR_OUTPATIENT')
       AS
PR_OUTPATIENT,
dbo.Mdf_attr_getbooleanvalue_actattr_byactid(A.id, 'PR_INPATIENT')
       AS
PR_INPATIENT,
dbo.Mdf_attr_getstringvalue_actattr_byactid(A.id, 'VALUESTRING',
'PR_NAMEOFSUBMITTER')
       AS PR_NAMEOFSUBMITTER,
PR.dvpr_outbreaknumbers
       AS PR_OUTBREAKNUMBERS,
PR.dvpr_outbreaktypes
       AS PR_OUTBREAKTYPES,
PER.dvper_censustract
       AS PR_CENSUSTRACT,
PR.dvpr_standardage
       AS Age,
PR.dvpr_cmrid
       AS CMR_ID,
PR.dvpr_datelastedited
       AS Date_Last_Edited,
COALESCE (Cast(PR.dvpr_importedstatus AS VARCHAR), '')
       AS Imported_Status,
CASE PR.dvpr_reportedbylab
  WHEN 1 THEN 'True'
  ELSE 'False'
END
       AS Lab_Report,
Isnull(PR.dvpr_lipresultnotes, '')
       AS Lab_Report_Notes,
Isnull(PR.dvpr_liptestordered, '')
       AS Lab_Report_Test_Name,
Isnull(PR.dvpr_mrn, '')
       AS Medical_Record_Number,
Isnull(PR.dvpr_outbreakdrstext, '')
       AS Outbreak_IDs,
Isnull(PER.dvper_guardianname, '')
       AS Parent_or_Guardian_Name,
Isnull(PR.dvpr_providername, '')
       AS Provider_Name
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
WHERE  ( PR.dvpr_diseasecode_id = 543030 )
       AND ( UCSNamespace.id IS NULL )
        OR ( PR.dvpr_diseasecode_id = 543030 )
           AND ( UCSNamespace.id IS NOT NULL )
           AND ( UCSImportOptions.id IS NOT NULL )
           AND ( UCSImportOptions.conceptcode NOT IN ( 'ALR', 'UDL' ) ) 



