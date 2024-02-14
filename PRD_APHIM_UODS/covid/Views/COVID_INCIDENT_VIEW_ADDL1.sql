



CREATE VIEW [covid].[COVID_INCIDENT_VIEW_ADDL1]
AS
SELECT A.id
       AS PR_ROWID,
       UCS1.fullname
       AS PR_DISEASE,
       UCS1.shortname
       AS PR_DISEASESHORTNAME,
       dbo.Mdf_ucs_fullname_ucs_byucsid(REGION.spacode_id)
       AS PR_SPA,
       CASE
         WHEN Isnull(TENTN.partfam, '') + ', '
              + Isnull(TENTN.partgiv, '') = ', ' THEN ''
         ELSE Isnull(TENTN.partfam, '') + ', '
              + Isnull(TENTN.partgiv, '')
       END
       AS PR_NURSEINVESTIGATOR,
       REGION.spacode_id
       AS PR_SPACODE_DR,
       STDSPECIMENS.dvis_specimentypes
       AS PR_SPECIMENTYPE,
       STDSPECIMENS.dvis_collectiondates
       AS PR_SPECIMENDATECOLLECTED,
       STDSPECIMENS.dvis_receiveddates
       AS PR_SPECIMENDATERECEIVED,
       dbo.Fn_concatedilrresultvaluetext(STDSPECIMENS.dvis_incidentdr)
       AS
       PR_SPECIMENRESULT,
       dbo.Fn_concatedilrnotetext(STDSPECIMENS.dvis_incidentdr)
       AS PR_SPECIMENNOTE,
Isnull(HCP.trivialname, '')
       AS PR_HEALTHCAREPROVIDER,
LOCLINK.entity2_id
       AS PR_HEALTHCAREPROVIDERLOCATIONDR,
Isnull(AIorAN.specify, '')
       AS American_Indian_or_Alaska_Native,
Isnull(Asian.specify, '')
       AS Asian___Specify,
Isnull(Black.specify, '')
       AS Black_or_African_American___Spec,
Isnull(dbo.Fn_getucsfullname(PERCOUNTRY.partcountry), '')
       AS Country_of_Birth,
Isnull(CASE UCS_NAMESPACE_CREATED_BY.conceptcode
         WHEN 'ELR' THEN 'LAB INTERFACE'
         WHEN 'WEB' THEN 'WEB INTERFACE'
         ELSE 'MAIN INTERFACE'
       END, 'MAIN INTERFACE')
       AS Created_By,
Isnull(ucs_final_disp.fullname, '')
       AS Final_Disposition,
Isnull(health_dist.jurisdictioncode, '')
       AS Health_District_Number,
CASE
  WHEN ( s_processedprrecord.[dateprocessed] IS NOT NULL
         AND s_processedprrecord.[importedbyuserdr] IS NULL ) THEN
  'System Process'
  ELSE Isnull(( ImportedBy.partfam + ', ' + ImportedBy.partgiv ), '')
END
       AS ImportedBy,
Isnull(ucs_marital_stat.fullname, '')
       AS Marital_Status,
Isnull(Pacific.specify, '')
       AS Native_Hawaiian_or_Other_Pacific,
Isnull(ucs_occ_set.fullname, '')
       AS Occupation_Setting_Type,
Isnull(Other.specify, '')
       AS Other___Specify,
Isnull(ucs_priority.fullname, '')
       AS Priority,
Isnull(HCP.trivialname, '')
       AS Report_Source,
Isnull(dbo.Fn_getucsfullname(CPSecondaryDistrict.subjcode_id), '')
       AS
Secondary_District,
Isnull(ucs_cont_type.fullname, '')
       AS Type_of_Contact,
Isnull(Unknown.specify, '')
       AS Unknown___Specify,
Isnull(White.specify, '')
       AS White___Specify
FROM   dbo.dv_phpersonalrecord AS PR WITH (nolock)
       INNER JOIN dbo.dv_person AS PER WITH (nolock)
               ON PER.dvper_rowid = PR.dvpr_persondr
       LEFT OUTER JOIN dbo.s_processedprrecord WITH (nolock)
                    ON dbo.s_processedprrecord.originalliverecord_id =
                       PR.dvpr_rowid
                       AND dbo.s_processedprrecord.statuscode = 'active'
                       AND dbo.s_processedprrecord.importoptioncode_id <>
                           (SELECT UCS.id
                            FROM
                               dbo.v_unifiedcodeset AS UCS WITH (nolock)
                               INNER JOIN dbo.v_domain AS VD WITH (nolock)
                                       ON UCS.domain_id = VD.id
                                          AND VD.domainname = 'NameSpaceImport'
                                                                           WHERE
                               ( UCS.conceptcode = 'ALR' ))
       LEFT OUTER JOIN dbo.v_unifiedcodeset AS UCS_NAMESPACE_CREATED_BY WITH (
                       nolock)
                    ON dbo.s_processedprrecord.namespacecode_id =
                       UCS_NAMESPACE_CREATED_BY.id
       LEFT OUTER JOIN dbo.t_entityname AS ImportedBy WITH (nolock)
                    ON ImportedBy.entity_id =
                       dbo.s_processedprrecord.importedbyuserdr
       LEFT OUTER JOIN dbo.v_unifiedcodeset AS UCSNamespace WITH (nolock)
                    ON PER.dvper_namespacecode_id = UCSNamespace.id
       LEFT OUTER JOIN dbo.v_unifiedcodeset AS UCSImportOptions WITH (nolock)
                    ON PER.dvper_importoptionscode_id = UCSImportOptions.id
       INNER JOIN dbo.a_act AS A WITH (nolock)
               ON A.id = PR.dvpr_rowid
                  AND A.metacode = 'PR_ROWID'
       INNER JOIN dbo.a_publichealthcase AS PH WITH (nolock)
               ON PH.id = A.id
       LEFT OUTER JOIN dbo.vcp_district AS REGION WITH (nolock)
                    ON PR.dvpr_districtcode_id = REGION.subjcode_id
       LEFT OUTER JOIN dbo.v_unifiedcodeset AS UCS1 WITH (nolock)
                    ON PR.dvpr_diseasecode_id = UCS1.id
       LEFT OUTER JOIN dbo.t_entityname AS TENTN WITH (nolock)
                    ON PR.dvpr_nurseinvestigatordr = TENTN.entity_id
                       AND TENTN.usecode = 'L'
       LEFT OUTER JOIN dbo.t_entityname AS HCP WITH (nolock)
                    ON HCP.entity_id = PR.dvpr_reportsourcedr
                       AND HCP.usecode = 'SRCH'
                       AND HCP.metacode = 'RS_HEALTHCAREPROVIDER'
       LEFT OUTER JOIN dbo.s_link AS LOCLINK WITH (nolock)
                    ON LOCLINK.NAME = 'RSLOCATION-PRIMARY'
                       AND LOCLINK.entity1_id = PR.dvpr_reportsourcedr
       LEFT OUTER JOIN (SELECT dbo.Strconcat(
                               dbo.dv_incidentspecimen.dvis_collectiondate)  AS
                               DVIS_COLLECTIONDATES,
dbo.Strconcat(dbo.dv_incidentspecimen.dvis_receiveddate)
AS
DVIS_RECEIVEDDATES,
dbo.Strconcat(Isnull(UCS1.fullname, ''))
AS
DVIS_SPECIMENTYPES,
dbo.Strconcat(
dbo.dv_incidentspecimen.dvis_specimenresults) AS
DVIS_SPECIMENRESULTS,
dbo.dv_incidentspecimen.dvis_incidentdr
FROM   dbo.dv_incidentspecimen WITH (nolock)
LEFT OUTER JOIN dbo.v_unifiedcodeset AS UCS1 WITH (
                nolock)
             ON UCS1.id =
dbo.dv_incidentspecimen.dvis_specimentypecode_id
GROUP  BY dbo.dv_incidentspecimen.dvis_incidentdr) AS STDSPECIMENS
ON STDSPECIMENS.dvis_incidentdr = PR.dvpr_rowid
LEFT OUTER JOIN dbo.t_entityaddress AS PERCOUNTRY WITH (nolock)
ON PERCOUNTRY.entity_id = PER.dvper_rowid
AND PERCOUNTRY.usecode = 'BIR'
LEFT OUTER JOIN dbo.v_unifiedcodeset AS ucs_marital_stat WITH (nolock)
ON PER.dvper_maritalstatuscode_id = ucs_marital_stat.id
LEFT OUTER JOIN dbo.v_unifiedcodeset AS ucs_occ_set WITH (nolock)
ON PER.dvper_occupationsettingtypedr = ucs_occ_set.id
LEFT OUTER JOIN dbo.v_unifiedcodeset AS ucs_final_disp WITH (nolock)
ON PR.dvpr_finaldisposition = ucs_final_disp.id
LEFT OUTER JOIN dbo.vcp_district AS health_dist WITH (nolock)
ON PR.dvpr_districtcode_id = health_dist.subjcode_id
LEFT OUTER JOIN dbo.v_unifiedcodeset AS ucs_priority WITH (nolock)
ON PR.dvpr_prioritydr = ucs_priority.id
LEFT OUTER JOIN dbo.v_unifiedcodeset AS ucs_cont_type WITH (nolock)
ON PR.dvpr_typeofcontactdr = ucs_cont_type.id
LEFT OUTER JOIN
                                   (SELECT
dbo.Strconcat(dbo.Mdf_ucs_fullname_ucs_byucsid(tr.racecode_id)) AS
Specify,
per.dvper_rowid
FROM   dbo.dv_person AS per WITH (nolock)
LEFT OUTER JOIN dbo.t_race AS tr WITH (nolock)
ON tr.entity_id = per.dvper_rowid
LEFT OUTER JOIN dbo.v_codeproperty AS VCP_CAT WITH (nolock)
ON tr.racecode_id = VCP_CAT.subjcode_id
AND VCP_CAT.property = 'Race_CategoryDR'
WHERE  ( tr.metacode = 'PER_MultipleRaceDR' )
AND ( Isnull(dbo.Mdf_ucs_fullname_ucs_byucsid(VCP_CAT.valuecode_id), '')
=
'American Indian or Alaska Native' )
GROUP  BY per.dvper_rowid) AS AIorAN
ON AIorAN.dvper_rowid = PER.dvper_rowid
LEFT OUTER JOIN
                             (SELECT
dbo.Strconcat(dbo.Mdf_ucs_fullname_ucs_byucsid(tr.racecode_id)) AS
Specify,
per.dvper_rowid
FROM   dbo.dv_person AS per WITH (nolock)
LEFT OUTER JOIN dbo.t_race AS tr WITH (nolock)
ON tr.entity_id = per.dvper_rowid
LEFT OUTER JOIN dbo.v_codeproperty AS VCP_CAT WITH (nolock)
ON tr.racecode_id = VCP_CAT.subjcode_id
AND VCP_CAT.property = 'Race_CategoryDR'
WHERE  ( tr.entity_id = per.dvper_rowid )
AND ( tr.metacode = 'PER_MultipleRaceDR' )
AND ( Isnull(dbo.Mdf_ucs_fullname_ucs_byucsid(VCP_CAT.valuecode_id), '')
= 'Asian' )
GROUP  BY per.dvper_rowid) AS Asian
ON Asian.dvper_rowid = PER.dvper_rowid
LEFT OUTER JOIN
                            (SELECT
dbo.Strconcat(dbo.Mdf_ucs_fullname_ucs_byucsid(tr.racecode_id)) AS
Specify,
per.dvper_rowid
FROM   dbo.dv_person AS per WITH (nolock)
LEFT OUTER JOIN dbo.t_race AS tr WITH (nolock)
ON tr.entity_id = per.dvper_rowid
LEFT OUTER JOIN dbo.v_codeproperty AS VCP_CAT WITH (nolock)
ON tr.racecode_id = VCP_CAT.subjcode_id
AND VCP_CAT.property = 'Race_CategoryDR'
WHERE  ( tr.entity_id = per.dvper_rowid )
AND ( tr.metacode = 'PER_MultipleRaceDR' )
AND ( Isnull(dbo.Mdf_ucs_fullname_ucs_byucsid(VCP_CAT.valuecode_id), '')
=
'Black or African American' )
GROUP  BY per.dvper_rowid) AS Black
ON Black.dvper_rowid = PER.dvper_rowid
LEFT OUTER JOIN
                            (SELECT
dbo.Strconcat(dbo.Mdf_ucs_fullname_ucs_byucsid(tr.racecode_id)) AS
Specify,
tr.entity_id                                                    AS
dvper_rowid
FROM   dbo.t_race AS tr WITH (nolock)
LEFT OUTER JOIN dbo.v_codeproperty AS VCP_CAT WITH (nolock)
ON tr.racecode_id = VCP_CAT.subjcode_id
AND VCP_CAT.property = 'Race_CategoryDR'
WHERE  ( tr.metacode = 'PER_MultipleRaceDR' )
AND ( Isnull(dbo.Mdf_ucs_fullname_ucs_byucsid(VCP_CAT.valuecode_id), '')
=
'Native Hawaiian or Other Pacific Islander' )
GROUP  BY tr.entity_id) AS Pacific
ON Pacific.dvper_rowid = PER.dvper_rowid
LEFT OUTER JOIN
                              (SELECT
dbo.Strconcat(dbo.Mdf_ucs_fullname_ucs_byucsid(tr.racecode_id)) AS
Specify,
tr.entity_id                                                    AS
dvper_rowid
FROM   dbo.t_race AS tr WITH (nolock)
LEFT OUTER JOIN dbo.v_codeproperty AS VCP_CAT WITH (nolock)
ON tr.racecode_id = VCP_CAT.subjcode_id
AND VCP_CAT.property = 'Race_CategoryDR'
WHERE  ( tr.metacode = 'PER_MultipleRaceDR' )
AND ( Isnull(dbo.Mdf_ucs_fullname_ucs_byucsid(VCP_CAT.valuecode_id), '')
= 'Other' )
GROUP  BY tr.entity_id) AS Other
ON Other.dvper_rowid = PER.dvper_rowid
LEFT OUTER JOIN
                            (SELECT
dbo.Strconcat(dbo.Mdf_ucs_fullname_ucs_byucsid(tr.racecode_id)) AS
Specify,
tr.entity_id                                                    AS
dvper_rowid
FROM   dbo.t_race AS tr WITH (nolock)
LEFT OUTER JOIN dbo.v_codeproperty AS VCP_CAT WITH (nolock)
ON tr.racecode_id = VCP_CAT.subjcode_id
AND VCP_CAT.property = 'Race_CategoryDR'
WHERE  ( tr.metacode = 'PER_MultipleRaceDR' )
AND ( Isnull(dbo.Mdf_ucs_fullname_ucs_byucsid(VCP_CAT.valuecode_id), '')
= 'Unknown'
)
GROUP  BY tr.entity_id) AS Unknown
ON Unknown.dvper_rowid = PER.dvper_rowid
LEFT OUTER JOIN
                              (SELECT
dbo.Strconcat(dbo.Mdf_ucs_fullname_ucs_byucsid(tr.racecode_id)) AS
Specify,
tr.entity_id                                                    AS
dvper_rowid
FROM   dbo.t_race AS tr WITH (nolock)
LEFT OUTER JOIN dbo.v_codeproperty AS VCP_CAT WITH (nolock)
ON tr.racecode_id = VCP_CAT.subjcode_id
AND VCP_CAT.property = 'Race_CategoryDR'
WHERE  ( tr.metacode = 'PER_MultipleRaceDR' )
AND ( Isnull(dbo.Mdf_ucs_fullname_ucs_byucsid(VCP_CAT.valuecode_id), '')
= 'White' )
GROUP  BY tr.entity_id) AS White
ON White.dvper_rowid = PER.dvper_rowid
LEFT OUTER JOIN dbo.vcp_district AS CPSecondaryDistrict WITH (nolock)
ON PR.dvpr_secondarydistrictcode_id =
CPSecondaryDistrict.subjcode_id
WHERE  ( PR.dvpr_diseasecode_id = 543030 )
       AND ( UCSNamespace.id IS NULL )
        OR ( PR.dvpr_diseasecode_id = 543030 )
           AND ( UCSNamespace.id IS NOT NULL )
           AND ( UCSImportOptions.id IS NOT NULL )
           AND ( UCSImportOptions.conceptcode NOT IN ( 'ALR', 'UDL' ) ) 




