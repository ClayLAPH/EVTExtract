



CREATE view [covid].[COVID_LAB_2]
as
SELECT v.*,
       Isnull(ucs.conceptcode, '')                    ORGANISMCODINGSYSTEM, 
       Isnull(labreport.dilr_organismdescription, '') RESULTEDORGANISM, 
       Isnull(labreport.dilr_resulttest, '')          RESULTTEXT,
	   --Isnull(labreport.DILR_SpecimenSourceText,'')   SPECIMENSOURCETEXT,
	   CASE WHEN CHARINDEX('||',DILR_LocalOrganismDescription) > 0 THEN 
	   RIGHT(DILR_LocalOrganismDescription, LEN(DILR_LocalOrganismDescription) - CHARINDEX('||',DILR_LocalOrganismDescription) - 1) ELSE '' END LOCALORGANISMDESCRIPTIONTEXT,
  	   CASE WHEN CHARINDEX('||',DILR_LOCALORGANISMCODE) > 0 THEN 
	   RIGHT(DILR_LOCALORGANISMCODE, LEN(DILR_LOCALORGANISMCODE) - CHARINDEX('||',DILR_LOCALORGANISMCODE) - 1) ELSE '' END LOCALORGANISMCODETEXT,
	   -- added below via IT#257545 2022-07-18 GRS
	   LAB.trivialName LABNAME,
	   CLIA.extension CLIA,
	   LABADDR1.[address] LABADDR1,
	   LABADDR2.[address] LABADDR2,
	   LABADDR3.[address] LABADDR3,
--	   labreport.DILR_RelevantClinicalInformation RELEVANTCLINICALINFORAMTION,
--	   labreport.DILR_ReasonForStudy REASONFORSTUDY,
	   DILRACT.availabilityTime HL7TimestampOfMessage,
	   DILRACT.effectiveTime_Beg TimestampMessageReceived
	   -- added above via IT#257545 2022-07-18 GRS
FROM   atlaspublic.view_cmr_systemlaboratoryinformationwithproviderfacility v 
       JOIN ax_labreport labreport 
         ON v.labreportid = labreport.dilr_id 
       LEFT JOIN v_unifiedcodeset ucs 
              ON labreport.dilr_organismcodingsystem_id = ucs.id 
       LEFT JOIN T_EntityName LAB on labreport.DILR_LaboratoryDR = LAB.Entity_ID
	   LEFT JOIN T_InstanceIdentifier CLIA on labreport.DILR_LaboratoryDR = CLIA.Entity_ID
	   LEFT JOIN T_EntityAddress LABADR on labreport.DILR_LaboratoryDR = LABADR.Entity_ID
	   LEFT JOIN T_AddressPart LABADDR1 on LABADR.ID = LABADDR1.Address_ID and LABADDR1.[sequence] = 1 and LABADDR1.partType = 'SAL'
	   LEFT JOIN T_AddressPart LABADDR2 on LABADR.ID = LABADDR2.Address_ID and LABADDR2.[sequence] = 2 and LABADDR2.partType = 'SAL'
	   LEFT JOIN T_AddressPart LABADDR3 on LABADR.ID = LABADDR3.Address_ID and LABADDR3.[sequence] = 3 and LABADDR3.partType = 'SAL'
	   LEFT JOIN A_Act DILRACT on DILRACT.ID = labreport.DILR_ID
WHERE  phrecordid IN (SELECT pr_rowid 
                      FROM   atlaspublic.view_uods_personalrecord 
                      WHERE  pr_diseasecode_dr = 543030);




