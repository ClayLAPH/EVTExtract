﻿
CREATE VIEW [AtlasInternal].[VIEW_NCM_CD_CONTACT_RISK]
AS
SELECT 
CONTACTINFOVIEW.PATIENT_ID AS PATIENT_ID,
CONTACTINFOVIEW.SERVICE_ID AS SERVICE_ID,     --Saravanakumar Issue #110413 08/16/2011
CONTACTINFOVIEW.CONTDEMO_CONTACT_ID AS CONTDEMO_ID,
ACT_CONTACTRISK.ID AS CDCONTRISK_ID,
DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTRISK_HANDLESFOOD',ACT_CONTACTRISK.ID,'VALUEBOOL') AS CDCONTRISK_HANDLESFOOD,
DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTRISK_CARESFORELDERLY',ACT_CONTACTRISK.ID,'VALUEBOOL') AS CDCONTRISK_CARESFORELDERLY,
DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTRISK_CARESFORCHILDREN',ACT_CONTACTRISK.ID,'VALUEBOOL') AS CDCONTRISK_CARESFORCHILDREN,
DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTRISK_HEALTHCAREWORKER',ACT_CONTACTRISK.ID,'VALUEBOOL') AS CDCONTRISK_HEALTHCAREWORKER,
DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTRISK_ATTENDSDAYCARE',ACT_CONTACTRISK.ID,'VALUEBOOL') AS CDCONTRISK_ATTENDSDAYCARE,
DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTRISK_WEARSGLOVES',ACT_CONTACTRISK.ID,'VALUEBOOL') AS CDCONTRISK_WEARSGLOVES,
DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTRISK_PRACTICESHANDWASHING',ACT_CONTACTRISK.ID,'VALUEBOOL') AS CDCONTRISK_PRACTICESHANDWASHING,
DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTRISK_ASSISTSWITHTOILET',ACT_CONTACTRISK.ID,'VALUEBOOL') AS CDCONTRISK_ASSISTSWITHTOILET,
DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTRISK_WEARSDIAPERS',ACT_CONTACTRISK.ID,'VALUEBOOL') AS CDCONTRISK_WEARSDIAPERS
FROM   A_ACT ACT_CONTACTRISK (NOLOCK) 
INNER JOIN [ATLASINTERNAL].[VIEW_SUB_NCM_CONTACT_INFORMATION] CONTACTINFOVIEW (NOLOCK) ON ACT_CONTACTRISK.ACT_PARENT_ID=CONTACTINFOVIEW.CONTACT_FOLDER_ID AND CONTACTINFOVIEW.CONTACT_FORMLINK='CDI'
WHERE
ACT_CONTACTRISK.METACODE='CDCONTRISK_ID' AND
ACT_CONTACTRISK.STATUSCODE<>'NULLIFIED'
