﻿ 
CREATE VIEW [AtlasInternal].[VIEW_NCM_CD_CONTACT_CONTROL]
AS
SELECT 
CONTACTINFOVIEW.PATIENT_ID AS PATIENT_ID,
CONTACTINFOVIEW.SERVICE_ID AS SERVICE_ID,     --Saravanakumar Issue #110413 08/16/2011
CONTACTINFOVIEW.CONTDEMO_CONTACT_ID AS CONTDEMO_CONTACT_ID,
ACT_CONTACTCONTROL.ID AS CDCONTCTRL_ID,
DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTCTRL_NEEDSLABCLEARANCE',ACT_CONTACTCONTROL.ID,'VALUEBOOL') AS CDCONTCTRL_NEEDSLABCLEARANCE,
DBO.MDF_ACT_GETDATEVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTCTRL_NEEDSLABCLEARANCE',ACT_CONTACTCONTROL.ID,'EFFECTIVETIME_BEG') AS CDCONTCTRL_CLEARANCEBEGUN,
DBO.MDF_ACT_GETDATEVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTCTRL_NEEDSLABCLEARANCE',ACT_CONTACTCONTROL.ID,'EFFECTIVETIME_END') AS CDCONTCTRL_CLEARANCECOMPLETED,
ACT_NEEDSRESTRICTION.VALUEBOOL AS CDCONTCTRL_NEEDSRESTRICTION,
ACT_NEEDSRESTRICTION.EFFECTIVETIME_BEG AS CDCONTCTRL_RESTRICTIONBEGUN,
DBO.MDF_ACT_GETDATEVALUE_ACTRELSRCACT_BYTRGACTIDMETACLASSMOODTYPEVALUETYPE(ACT_NEEDSRESTRICTION.ID,'CDCONTCTRL_RESTRICTIONLETTERSENT','SUBJ','EFFECTIVETIME_BEG') AS CDCONTCTRL_RESTRICTIONLETTERSENT,
ACT_NEEDSRESTRICTION.EFFECTIVETIME_END AS CDCONTCTRL_RESTRICTIONREMOVED,
DBO.MDF_ACT_GETDATEVALUE_ACTRELSRCACT_BYTRGACTIDMETACLASSMOODTYPEVALUETYPE(ACT_NEEDSRESTRICTION.ID,'CDCONTCTRL_RESTRICTIONREMOVALLETTERSENT','SUBJ','EFFECTIVETIME_BEG') AS CDCONTCTRL_RESTRICTIONREMOVALLETTERSENT,
DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTCTRL_NEEDSOBSERVATION',ACT_CONTACTCONTROL.ID,'VALUEBOOL') AS CDCONTCTRL_NEEDSOBSERVATION,
DBO.MDF_ACT_GETDATEVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTCTRL_NEEDSOBSERVATION',ACT_CONTACTCONTROL.ID,'EFFECTIVETIME_BEG') AS CDCONTCTRL_OBSERVATIONBEGUN,
DBO.MDF_ACT_GETDATEVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTCTRL_NEEDSOBSERVATION',ACT_CONTACTCONTROL.ID,'EFFECTIVETIME_END') AS CDCONTCTRL_OBSERVATIONREMOVED,
ACT_NEEDSISOLATION.VALUEBOOL AS CDCONTCTRL_NEEDSISOLATION,
ACT_NEEDSISOLATION.EFFECTIVETIME_BEG AS CDCONTCTRL_ISOLATIONBEGUN,
DBO.MDF_ACT_GETDATEVALUE_ACTRELSRCACT_BYTRGACTIDMETACLASSMOODTYPEVALUETYPE(ACT_NEEDSISOLATION.ID,'CDCONTCTRL_ISOLATIONLETTERSENT','SUBJ','EFFECTIVETIME_BEG') AS CDCONTCTRL_ISOLATIONLETTERSENT,
ACT_NEEDSISOLATION.EFFECTIVETIME_END AS CDCONTCTRL_ISOLATIONREMOVED,
DBO.MDF_ACT_GETDATEVALUE_ACTRELSRCACT_BYTRGACTIDMETACLASSMOODTYPEVALUETYPE(ACT_NEEDSISOLATION.ID,'CDCONTCTRL_ISOLATIONREMOVALLETTERSENT','SUBJ','EFFECTIVETIME_BEG') AS CDCONTCTRL_ISOLATIONREMOVALLETTERSENT,
DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTCTRL_NEEDSTREATMENT',ACT_CONTACTCONTROL.ID,'VALUEBOOL') AS CDCONTCTRL_NEEDSTREATMENT,
DBO.MDF_ACT_GETDATEVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTCTRL_NEEDSTREATMENT',ACT_CONTACTCONTROL.ID,'EFFECTIVETIME_BEG') AS CDCONTCTRL_TREATMENTBEGUN,
DBO.MDF_ACT_GETDATEVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTCTRL_NEEDSTREATMENT',ACT_CONTACTCONTROL.ID,'EFFECTIVETIME_END') AS CDCONTCTRL_TREATMENTCOMPLETED,
DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTCTRL_NEEDSPROPHYLAXIS',ACT_CONTACTCONTROL.ID,'VALUEBOOL') AS CDCONTCTRL_NEEDSPROPHYLAXIS,
DBO.MDF_ACT_GETDATEVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTCTRL_NEEDSPROPHYLAXIS',ACT_CONTACTCONTROL.ID,'EFFECTIVETIME_BEG') AS CDCONTCTRL_PROPHYLAXISBEGUN,
DBO.MDF_ACT_GETDATEVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTCTRL_NEEDSPROPHYLAXIS',ACT_CONTACTCONTROL.ID,'EFFECTIVETIME_END') AS CDCONTCTRL_PROPHYLAXISCOMPLETED,
DBO.MDF_ACT_GETBOOLEANVALUE_ACT_BYPARACTIDMETAVALUETYPE('CDCONTCTRL_NEEDSIMMUNIZATION',ACT_CONTACTCONTROL.ID,'VALUEBOOL') AS CDCONTCTRL_NEEDSIMMUNIZATION

FROM   A_ACT ACT_CONTACTCONTROL (NOLOCK) 
INNER JOIN [ATLASINTERNAL].[VIEW_SUB_NCM_CONTACT_INFORMATION] CONTACTINFOVIEW (NOLOCK) ON ACT_CONTACTCONTROL.ACT_PARENT_ID=CONTACTINFOVIEW.CONTACT_FOLDER_ID AND CONTACTINFOVIEW.CONTACT_FORMLINK='CDI'
	LEFT JOIN A_ACT ACT_NEEDSRESTRICTION (NOLOCK) ON ACT_CONTACTCONTROL.ID=ACT_NEEDSRESTRICTION.ACT_PARENT_ID AND ACT_NEEDSRESTRICTION.METACODE= 'CDCONTCTRL_NEEDSRESTRICTION' AND ACT_NEEDSRESTRICTION.CLASSCODE='OBS'
LEFT JOIN A_ACT ACT_NEEDSISOLATION (NOLOCK) ON ACT_CONTACTCONTROL.ID=ACT_NEEDSISOLATION.ACT_PARENT_ID AND ACT_NEEDSISOLATION.METACODE= 'CDCONTCTRL_NEEDSISOLATION' AND ACT_NEEDSISOLATION.CLASSCODE='OBS'

WHERE
ACT_CONTACTCONTROL.METACODE='CDCONTCTRL_ID' AND
	ACT_CONTACTCONTROL.STATUSCODE<>'NULLIFIED'

