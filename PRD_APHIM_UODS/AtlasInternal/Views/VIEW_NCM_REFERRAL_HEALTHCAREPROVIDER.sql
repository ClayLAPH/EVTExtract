﻿
CREATE VIEW [AtlasInternal].[VIEW_NCM_REFERRAL_HEALTHCAREPROVIDER]    
AS
WITH CTE_SSNOID(SSNOID)
AS
(
	SELECT dbo.FN_GetSSNOIDBasedOnSiteID(CAST((CASE WHEN VAL.value='' THEN CONFIG.defaultvalue ELSE VAL.value END) AS VARCHAR(20))) 
	FROM S_CONFIGDEFINITION (nolock)CONFIG
	INNER JOIN S_CONFIGVALUE(nolock) VAL ON VAL.configdefinition_id = CONFIG.id
	WHERE CONFIG.[KEY]='SITEID'
)             
SELECT
SVC.ID AS [SVC_ID],                
DVSVC.DVSVC_PATIENT_FK AS [PAT_ID],                
CASE WHEN UCSINOUT.CONCEPTCODE = 'IMP' THEN 'TRUE' ELSE 'FALSE' END AS INPATIENT,                
CASE WHEN UCSINOUT.CONCEPTCODE = 'AMB' THEN 'TRUE' ELSE 'FALSE' END AS OUTPATIENT,                
DBO.[MDF_ENTITYNAME_GETVALUE_BYENTITYID](RPROV.PLAYER_ID,'L','TRIVIALNAME') AS PROVIDER,                
DBO.MDF_UCS_FULLNAME_UCS_BYUCSID(RPROV.CODE_ID) AS [PROVIDER TYPE],                
DBO.[MDF_ADDRPART_ADDRESS_BYROLEIDUSECODE](RPROV.ID,'SAL','WP') AS ADDRESS ,        
DBO.[MDF_ADDRPART_ADDRESS_BYROLEIDUSECODE](RPROV.ID,'CTY','WP') AS ADDRESSCITY ,        
DBO.[MDF_ADDRPART_ADDRESS_BYROLEIDUSECODE](RPROV.ID,'ZIP','WP') AS ADDRESSZIP ,        
DBO.[MDF_ENTTELECOM_ADDRESS_ROLE_BYROLEID](RPROV.ID,'WP','TEL') AS [PROVIDER PHONE],      
DBO.[MDF_ENTITYNAME_GETVALUE_BYENTITYID](RLOCE.SCOPER_ID,'SRCH','TRIVIALNAME')  AS [HOSPITAL/CLINIC],                
DBO.MDF_UCS_FULLNAME_UCS_BYUCSID(ELOC.CODE_ID) AS [HOSPITAL/CLINIC TYPE],                
ACTPROV.EFFECTIVETIME_BEG AS [DATE ADMITTED],                
ACTPROV.EFFECTIVETIME_END AS [DATE DISCHARGED],                
[DBO].MDF_ACT_GETDATEVALUE_ACT_BYPARACTIDMETAVALUETYPE('PROV_DX',ACTPROV.ID,'EFFECTIVETIME_BEG') AS [DATE OF ONSET],                
[DBO].MDF_ACT_GETDATEVALUE_ACT_BYPARACTIDMETAVALUETYPE('PROV_DX',ACTPROV.ID,'AVAILABILITYTIME') AS [DATE OF DIAGNOSIS],                
NPI.EXTENSION AS NPI,                
MRN.EXTENSION AS MRN,                
[DBO].MDF_ACT_GETSTRINGVALUE_ACT_BYPARACTIDMETAVALUETYPE('PROV_DX',ACTPROV.ID,'VALUESTRING') AS DX,                
[DBO].MDF_ACT_GETSTRINGVALUE_ACT_BYPARACTIDMETAVALUETYPE('PROV_SX',ACTPROV.ID,'VALUESTRING') AS SX,                
EPER.DECEASEDTIME AS [DATE OF DEATH],
CASE WHEN PARTPROV.FUNCTIONCODE_ID IS NULL THEN 'FALSE' ELSE 'TRUE' END AS PROV_ISPRIMARYPHYSICIAN  
FROM DV_SERVICE DVSVC (NOLOCK)
INNER JOIN A_ACT (NOLOCK) SVC ON SVC.ID=DVSVC.DVSVC_ROWID AND SVC.CLASSCODE='CASE' AND SVC.STATUSCODE NOT IN ('NULLIFIED','TERMINATED') AND SVC.METACODE='SVC_ID'                
INNER JOIN E_PERSON (NOLOCK) EPER ON EPER.ID=DVSVC.DVSVC_PATIENT_FK                
INNER JOIN R_ROLE (NOLOCK) PATROLE ON PATROLE.PLAYER_ID=EPER.ID AND PATROLE.CLASSCODE='PAT'                
INNER JOIN A_ACT (NOLOCK) FOLDER ON FOLDER.ID=SVC.ACT_PARENT_ID AND FOLDER.CLASSCODE='FOLDER' AND FOLDER.MOODCODE='EVN'
INNER JOIN A_ACTRELATIONSHIP (NOLOCK) ON A_ACTRELATIONSHIP.SOURCE_ID=SVC.ID
INNER JOIN A_ACT (NOLOCK) DOCBODY ON DOCBODY.ID=A_ACTRELATIONSHIP.TARGET_ID AND DOCBODY.CLASSCODE='DOCBODY'
INNER JOIN A_ACT (NOLOCK) ACTPROV ON ACTPROV.ACT_PARENT_ID=DOCBODY.ID AND ACTPROV.CLASSCODE='ENC' AND ACTPROV.STATUSCODE NOT IN ('NULLIFIED','TERMINATED') AND ACTPROV.METACODE='PROV_ID'
INNER JOIN CTE_SSNOID ON 1=1              
LEFT JOIN V_UNIFIEDCODESET (NOLOCK) UCSINOUT ON UCSINOUT.ID=ACTPROV.CODE_ID                
LEFT JOIN P_PARTICIPATION (NOLOCK) PARTPROV ON PARTPROV.ACT_ID=ACTPROV.ID AND PARTPROV.TYPECODE='REF'                
LEFT JOIN R_ROLE (NOLOCK) RPROV ON RPROV.ID=PARTPROV.ROLE_ID AND RPROV.CLASSCODE='PROV'                
LEFT JOIN T_ENTITYADDRESS (NOLOCK) ADDR ON ADDR.ROLE_ID=RPROV.ID AND ADDR.USECODE='WP'                
LEFT JOIN R_ROLE (NOLOCK) RLOCE ON RLOCE.PLAYER_ID=RPROV.PLAYER_ID AND RLOCE.CLASSCODE='LOCE' AND RLOCE.METACODE='HCP_HOSPITALCLINIC_FK'                
LEFT JOIN E_ENTITY (NOLOCK) ELOC ON ELOC.ID=RLOCE.SCOPER_ID AND ELOC.CLASSCODE='PLC' AND ELOC.METACODE='LOC_ROWID'                
LEFT JOIN T_INSTANCEIDENTIFIER (NOLOCK) NPI ON NPI.ROLE_ID=RPROV.ID AND NPI.METACODE = 'HCP_NationalProviderIdentifier'     
LEFT JOIN T_INSTANCEIDENTIFIER (NOLOCK) MRN ON MRN.ENTITY_ID=RPROV.PLAYER_ID AND MRN.ROOT = CTE_SSNOID.SSNOID AND MRN.ROLE_ID = PATROLE.ID

