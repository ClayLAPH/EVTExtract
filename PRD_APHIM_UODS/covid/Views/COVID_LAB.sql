
CREATE view [covid].[COVID_LAB]
as
SELECT v.*,
       Isnull(ucs.conceptcode, '')                    ORGANISMCODINGSYSTEM, 
       Isnull(labreport.dilr_organismdescription, '') RESULTEDORGANISM, 
       Isnull(labreport.dilr_resulttest, '')          RESULTTEXT,
	   --Isnull(labreport.DILR_SpecimenSourceText,'')   SPECIMENSOURCETEXT,
	   CASE WHEN CHARINDEX('||',DILR_LocalOrganismDescription) > 0 THEN 
	   RIGHT(DILR_LocalOrganismDescription, LEN(DILR_LocalOrganismDescription) - CHARINDEX('||',DILR_LocalOrganismDescription) - 1) ELSE '' END LOCALORGANISMDESCRIPTIONTEXT,
  	   CASE WHEN CHARINDEX('||',DILR_LOCALORGANISMCODE) > 0 THEN 
	   RIGHT(DILR_LOCALORGANISMCODE, LEN(DILR_LOCALORGANISMCODE) - CHARINDEX('||',DILR_LOCALORGANISMCODE) - 1) ELSE '' END LOCALORGANISMCODETEXT
FROM   atlaspublic.view_cmr_systemlaboratoryinformationwithproviderfacility v 
       JOIN ax_labreport labreport 
         ON v.labreportid = labreport.dilr_id 
       LEFT JOIN v_unifiedcodeset ucs 
              ON labreport.dilr_organismcodingsystem_id = ucs.id 
WHERE  phrecordid IN (SELECT pr_rowid 
                      FROM   atlaspublic.view_uods_personalrecord 
                      WHERE  pr_diseasecode_dr = 543030);
