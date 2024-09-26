﻿







CREATE view [covid].[SARS2_PERSON_VIEW_ADDL2]
as


SELECT
    PER.DVPER_ROWID AS PER_ROWID,
    [dbo].[MDF_ATTR_GETDATETIMEVALUE_ENTATTR_BYENTITYID](PER.DVPER_ROWID,'VALUETS', 'PER_DATEOFUSARRIVAL') AS PER_DATEOFARRIVAL,
    [dbo].[MDF_ATTR_GETSTRINGVALUE_ENTATTR_BYENTITYID](PER.DVPER_ROWID,'VALUESTRING_TXT','PER_OCCUPATIONLOCATION') AS PER_OCCUPATIONLOCATION,
    [dbo].[MDF_ATTR_GETSTRINGVALUE_ENTATTR_BYENTITYID](PER.DVPER_ROWID,'VALUECODE_ORTX','PER_OCCUPATIONDR') AS PER_OCCUPATIONSPECIFY,
    ATTOCCSETTING.VALUECODE_ID AS PER_OCCUPATIONSETTINGTYPEDR,
    ATTOCCSETTING.VALUECODE_ORTX AS PER_OCCUPATIONSETTINGTYPESPECIFY,
    [dbo].[MDF_ATTR_GETSTRINGVALUE_ENTATTR_BYENTITYID](PER.DVPER_RootID,'VALUESTRING_TXT','PER_StateNumber') AS PER_STATENUMBER,
    [dbo].[MDF_ATTR_GETSTRINGVALUE_ENTATTR_BYENTITYID](ENTPER.ID,'VALUESTRING','PER_WorkSchoolContact') AS PER_WORKSCHOOLCONTACT
FROM DBO.DV_PERSON(NOLOCK) AS PER
    INNER JOIN DBO.E_ENTITY ENTPER (NOLOCK) ON PER.DVPER_ROWID = ENTPER.[ID]
    LEFT OUTER JOIN R_ROLE(NOLOCK) R_LOCE ON R_LOCE.player_id=ENTPER.[ID] AND R_LOCE.classCode='LOCE' AND R_LOCE.metaCode='PER_WorkSchoolLocationDR'
    LEFT OUTER JOIN T_ENTITYNAME(NOLOCK) SCHOOL_LOC_NAME ON R_LOCE.Scoper_ID=SCHOOL_LOC_NAME.Entity_ID AND SCHOOL_LOC_NAME.metaCode='LOC_Name' AND SCHOOL_LOC_NAME.useCode='SRCH'
    LEFT JOIN DBO.V_UNIFIEDCODESET UCSNAME (NOLOCK) ON  PER.DVPER_NAMESPACECODE_ID = UCSNAME.ID
    LEFT JOIN DBO.V_UNIFIEDCODESET UCSOP (NOLOCK) ON  PER.DVPER_IMPORTOPTIONSCODE_ID = UCSOP.ID
    LEFT OUTER JOIN DBO.T_ATTRIBUTE ATTOCCSETTING (NOLOCK) ON  ATTOCCSETTING.ENTITY_ID = PER.DVPER_ROWID AND ATTOCCSETTING.NAME = 'PER_OCCUPATIONSETTINGTYPEDR' AND ATTOCCSETTING.TYPE = 'CV'
    WHERE ((ISNULL(UCSNAME.CONCEPTCODE,'') = ''
        OR (
            ISNULL(UCSNAME.CONCEPTCODE,'') <> ''
            AND (UCSNAME.CONCEPTCODE <> 'WEB')
            AND ISNULL(UCSOP.CONCEPTCODE,'') <> ''
            AND (UCSOP.CONCEPTCODE NOT IN ('ALR', 'UDL'))
        ))
        AND PER.DVPER_RowID IN (SELECT PR.DVPR_PERSONDR
    FROM [dbo].DV_PHPERSONALRECORD PR (NOLOCK)
    INNER JOIN dbo.DV_Person PER (NOLOCK) ON PER.DVPER_RowID=PR.DVPR_PersonDR
    WHERE PR.DVPR_DiseaseCode_ID = 544041))


