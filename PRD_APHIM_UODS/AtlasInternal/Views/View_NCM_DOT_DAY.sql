﻿CREATE VIEW [AtlasInternal].[View_NCM_DOT_DAY] 
AS  
SELECT SERVICEACT.ID AS SERVICEID,
       DOT.[ID] AS DOTDAY_ID,
       ACT_DOTDETAIL.[ID] AS DOTDAY_DOTDETAIL_FK,
       ACUITYBOTH.VALUECODE_ID  AS 
       DOTDAY_ACUITYBOTH_FK,
       UCS_ACUITYBOTH.FULLNAME AS DOTDAY_ACUITYBOTH,
       ACUITYLEFT.VALUECODE_ID  AS 
       DOTDAY_ACUITYLEFT_FK,
       UCS_ACUITYLEFT.FULLNAME AS DOTDAY_ACUITYLEFT,
       ACUITYRIGHT.VALUECODE_ID  AS 
       DOTDAY_ACUITYRIGHT_FK,
       UCS_ACUITYRIGHT.FULLNAME AS DOTDAY_ACUITYRIGHT,
       ADVERSEREACTION.VALUECODE_ID  AS 
       DOTDAY_ADVERSEREACTION_FK,
       UCS_ADVERSEREACTION.FULLNAME AS DOTDAY_ADVERSEREACTION,
       BALANCE.VALUECODE_ID  AS DOTDAY_BALANCE_FK,
       UCS_BALANCE.FULLNAME AS DOTDAY_BALANCE,
       COLORVISION.VALUECODE_ID  AS 
       DOTDAY_COLORVISION_FK,
       UCS_COLORVISION.FULLNAME AS DOTDAY_COLORVISION,
       ACTDOT.[TEXT] AS DOTDAY_COMMENTS,
       CONTACTS.VALUEBOOL AS DOTDAY_CONTACTS,
       OBS_CULTURE.INTERPRETATIONCODE_ID AS 
       DOTDAY_CULTURE_FK,
       UCS_CULTURE.FULLNAME AS DOTDAY_CULTURE,
       OBS_CXR.INTERPRETATIONCODE_ID   AS 
       DOTDAY_CXR_FK,
       UCS_CXR.FULLNAME AS DOTDAY_CXR,
       ACTDOT.EFFECTIVETIME_BEG AS DOTDAY_DATE,
       ACTREL_DOTDETAIL.SEQUENCENUMBER AS DOTDAY_DAYNUMBER,
       DEPRESSED.VALUEBOOL AS DOTDAY_DEPRESSED,
       ETHO.VALUEBOOL AS DOTDAY_ETHO,
       GLASSES.VALUEBOOL AS DOTDAY_GLASSES,
       HEARINGLEFT.VALUECODE_ID   AS 
       DOTDAY_HEARINGLEFT_FK,
       HEARINGRIGHT.VALUECODE_ID   AS 
       DOTDAY_HEARINGRIGHT_FK,
       HEPATITIS.VALUEBOOL AS DOTDAY_HEPATITIS,
       HIVPOSITIVE.VALUEBOOL AS DOTDAY_HIVPOSITIVE,
       IMMUNECOMPROMISED.VALUEBOOL AS DOTDAY_IMMUNECOMPROMISED,
       USR_ROLE.PLAYER_ID AS DOTDAY_INITIALS_FK,
       LIVERFUNCTION.VALUECODE_ID   AS 
       DOTDAY_LIVERFUNCTION_FK,
       UCS_LIVERFUNCTION.FULLNAME AS DOTDAY_LIVERFUNCTION,
       PREGNANT.VALUEBOOL AS DOTDAY_PREGNANT,
       OBS_SMEAR.INTERPRETATIONCODE_ID   AS 
       DOTDAY_SMEAR_FK,
       UCS_SMEAR.FULLNAME AS DOTDAY_SMEAR,
       ENT_SPUT.QUANTITY AS DOTDAY_SPUTUMS,
       ACTDOT.CODE_ID   AS DOTDAY_THERAPY_FK,
       UCS_THERAPY.FULLNAME AS DOTDAY_THERAPY_TEXT,
       ACTDOT.EFFECTIVETIME_DUR AS DOTDAY_TIME,
       BEGINWEIGHT.VALUENUMERATOR AS DOTDAY_BEGINWEIGHT,
       SUBMITTED.VALUEBOOL AS DOTDAY_SUBMITTED
FROM   A_PATIENTENCOUNTER DOT (NOLOCK)
       INNER JOIN A_ACT ACTDOT (NOLOCK)
            ON  DOT.[ID] = ACTDOT.[ID]
            AND ACTDOT.METACODE = 'DOTDAY_ID'
       INNER JOIN A_ACTRELATIONSHIP ACTREL_DOTDETAIL (NOLOCK)
            ON  ACTREL_DOTDETAIL.SOURCE_ID = ACTDOT.[ID]
            AND ACTREL_DOTDETAIL.TYPECODE = 'OCCR'
       INNER JOIN A_ACT ACT_DOTDETAIL (NOLOCK)
            ON  ACTREL_DOTDETAIL.TARGET_ID = ACT_DOTDETAIL.[ID]
            AND ACT_DOTDETAIL.CLASSCODE = 'ENC'
            AND ACT_DOTDETAIL.METACODE = 'DOTDTL_ID'
            AND ACT_DOTDETAIL.MOODCODE = 'INT'
       INNER JOIN A_ACT CFDDOCBODYACT (NOLOCK)
            ON  ACT_DOTDETAIL.ACT_PARENT_ID = CFDDOCBODYACT.ID
            
       LEFT JOIN V_UNIFIEDCODESET VUCR (NOLOCK) ON CFDDOCBODYACT.CODE_ID=VUCR.ID 
            AND VUCR.CONCEPTCODE = 'CFD'
           
            
       INNER JOIN A_ACT SERVICEACT (NOLOCK)
            ON  CFDDOCBODYACT.ACT_PARENT_ID = SERVICEACT.ID
       LEFT JOIN A_ACT ACUITYBOTH (NOLOCK)
            ON  ACUITYBOTH.ACT_PARENT_ID = ACTDOT.[ID]
            AND ACUITYBOTH.CLASSCODE = 'OBS'
            AND ACUITYBOTH.METACODE = 'DOTDAY_ACUITYBOTH_FK'
       LEFT JOIN V_UNIFIEDCODESET UCS_ACUITYBOTH (NOLOCK)
            ON  UCS_ACUITYBOTH.ID = ACUITYBOTH.VALUECODE_ID
             
       LEFT JOIN A_ACT ACUITYLEFT (NOLOCK)
            ON  ACUITYLEFT.ACT_PARENT_ID = ACTDOT.[ID]
            AND ACUITYLEFT.CLASSCODE = 'OBS'
            AND ACUITYLEFT.METACODE = 'DOTDAY_ACUITYLEFT_FK'
       LEFT JOIN V_UNIFIEDCODESET UCS_ACUITYLEFT (NOLOCK)
            ON  UCS_ACUITYLEFT.ID = ACUITYLEFT.VALUECODE_ID
             
       LEFT JOIN A_ACT ACUITYRIGHT (NOLOCK)
            ON  ACUITYRIGHT.ACT_PARENT_ID = ACTDOT.[ID]
            AND ACUITYRIGHT.CLASSCODE = 'OBS'
            AND ACUITYRIGHT.METACODE = 'DOTDAY_ACUITYRIGHT_FK'
       LEFT JOIN V_UNIFIEDCODESET UCS_ACUITYRIGHT (NOLOCK)
            ON  UCS_ACUITYRIGHT.ID = ACUITYRIGHT.VALUECODE_ID
            
       LEFT JOIN A_ACT ADVERSEREACTION (NOLOCK)
            ON  ADVERSEREACTION.ACT_PARENT_ID = ACTDOT.[ID]
            AND ADVERSEREACTION.CLASSCODE = 'OBS'
            AND ADVERSEREACTION.METACODE = 'DOTDAY_ADVERSEREACTION_FK'
       LEFT JOIN V_UNIFIEDCODESET UCS_ADVERSEREACTION (NOLOCK)
            ON  UCS_ADVERSEREACTION.ID = ADVERSEREACTION.VALUECODE_ID
            
       LEFT JOIN A_ACT BALANCE (NOLOCK)
            ON  BALANCE.ACT_PARENT_ID = ACTDOT.[ID]
            AND BALANCE.CLASSCODE = 'OBS'
            AND BALANCE.METACODE = 'DOTDAY_BALANCE_FK'
       LEFT JOIN V_UNIFIEDCODESET UCS_BALANCE (NOLOCK)
            ON  UCS_BALANCE.ID = BALANCE.VALUECODE_ID
             
       LEFT JOIN A_ACT COLORVISION (NOLOCK)
            ON  COLORVISION.ACT_PARENT_ID = ACTDOT.[ID]
            AND COLORVISION.CLASSCODE = 'OBS'
            AND COLORVISION.METACODE = 'DOTDAY_COLORVISION_FK'
       LEFT JOIN V_UNIFIEDCODESET UCS_COLORVISION (NOLOCK)
            ON  UCS_COLORVISION.ID = COLORVISION.VALUECODE_ID
             
       LEFT JOIN DBO.A_ACT CONTACTS (NOLOCK)
            ON  CONTACTS.ACT_PARENT_ID = ACTDOT.ID
            AND CONTACTS.CLASSCODE = 'OBS'
            AND CONTACTS.METACODE = 'DOTDAY_CONTACTS'
       LEFT JOIN DBO.A_ACT CULTURE (NOLOCK)
            ON  CULTURE.ACT_PARENT_ID = ACTDOT.[ID]
            AND CULTURE.CLASSCODE = 'OBS'
            AND CULTURE.METACODE = 'DOTDAY_CULTURE_FK'
       LEFT JOIN DBO.A_OBSERVATION OBS_CULTURE (NOLOCK)
            ON  OBS_CULTURE.[ID] = CULTURE.[ID]
       LEFT JOIN V_UNIFIEDCODESET UCS_CULTURE (NOLOCK)
            ON  UCS_CULTURE.ID = OBS_CULTURE.INTERPRETATIONCODE_ID
            
       LEFT JOIN DBO.A_ACT CXR (NOLOCK)
            ON  CXR.ACT_PARENT_ID = ACTDOT.[ID]
            AND CXR.CLASSCODE = 'OBS'
            AND CXR.METACODE = 'DOTDAY_CXR_FK'
       LEFT JOIN DBO.A_OBSERVATION OBS_CXR (NOLOCK)
            ON  OBS_CXR.[ID] = CXR.[ID]
       LEFT JOIN V_UNIFIEDCODESET UCS_CXR (NOLOCK)
            ON  UCS_CXR.ID = OBS_CXR.INTERPRETATIONCODE_ID
            
       LEFT JOIN DBO.A_ACT DEPRESSED (NOLOCK)
            ON  DEPRESSED.ACT_PARENT_ID = ACTDOT.[ID]
            AND DEPRESSED.CLASSCODE = 'OBS'
            AND DEPRESSED.METACODE = 'DOTDAY_DEPRESSED'
       LEFT JOIN DBO.A_ACT ETHO (NOLOCK)
            ON  ETHO.ACT_PARENT_ID = ACTDOT.[ID]
            AND ETHO.CLASSCODE = 'OBS'
            AND ETHO.METACODE = 'DOTDAY_ETHO'
       LEFT JOIN DBO.A_ACT GLASSES (NOLOCK)
            ON  GLASSES.ACT_PARENT_ID = ACTDOT.[ID]
            AND GLASSES.CLASSCODE = 'OBS'
            AND GLASSES.METACODE = 'DOTDAY_GLASSES'
       LEFT JOIN A_ACT HEARINGLEFT (NOLOCK)
            ON  HEARINGLEFT.ACT_PARENT_ID = ACTDOT.[ID]
            AND HEARINGLEFT.CLASSCODE = 'OBS'
            AND HEARINGLEFT.METACODE = 'DOTDAY_HEARINGLEFT_FK'
       LEFT JOIN V_UNIFIEDCODESET UCS_HEARINGLEFT (NOLOCK)
            ON  UCS_HEARINGLEFT.ID = HEARINGLEFT.VALUECODE_ID
             
       LEFT JOIN A_ACT HEARINGRIGHT (NOLOCK)
            ON  HEARINGRIGHT.ACT_PARENT_ID = ACTDOT.[ID]
            AND HEARINGRIGHT.CLASSCODE = 'OBS'
            AND HEARINGRIGHT.METACODE = 'DOTDAY_HEARINGRIGHT_FK'
       LEFT JOIN V_UNIFIEDCODESET UCS_HEARINGRIGHT (NOLOCK)
            ON  UCS_HEARINGRIGHT.ID = HEARINGRIGHT.VALUECODE_ID
             
       LEFT JOIN DBO.A_ACT HEPATITIS (NOLOCK)
            ON  HEPATITIS.ACT_PARENT_ID = ACTDOT.[ID]
            AND HEPATITIS.CLASSCODE = 'OBS'
            AND HEPATITIS.METACODE = 'DOTDAY_HEPATITIS'
       LEFT JOIN DBO.A_ACT HIVPOSITIVE (NOLOCK)
            ON  HIVPOSITIVE.ACT_PARENT_ID = ACTDOT.[ID]
            AND HIVPOSITIVE.CLASSCODE = 'OBS'
            AND HIVPOSITIVE.METACODE = 'DOTDAY_HIVPOSITIVE'
       LEFT JOIN DBO.A_ACT IMMUNECOMPROMISED (NOLOCK)
            ON  IMMUNECOMPROMISED.ACT_PARENT_ID = ACTDOT.[ID]
            AND IMMUNECOMPROMISED.CLASSCODE = 'OBS'
            AND IMMUNECOMPROMISED.METACODE = 'DOTDAY_IMMUNECOMPROMISED'
       LEFT JOIN P_PARTICIPATION USR_PART (NOLOCK)
            ON  USR_PART.ACT_ID = ACTDOT.[ID]
            AND USR_PART.TYPECODE = 'PRF'
       LEFT JOIN R_ROLE USR_ROLE (NOLOCK)
            ON  USR_PART.ROLE_ID = USR_ROLE.[ID]
            AND USR_ROLE.CLASSCODE = 'AGNT'
       LEFT JOIN A_ACT LIVERFUNCTION (NOLOCK)
            ON  LIVERFUNCTION.ACT_PARENT_ID = ACTDOT.[ID]
            AND LIVERFUNCTION.CLASSCODE = 'OBS'
            AND LIVERFUNCTION.METACODE = 'DOTDAY_LIVERFUNCTION_FK'
       LEFT JOIN V_UNIFIEDCODESET UCS_LIVERFUNCTION (NOLOCK)
            ON  UCS_LIVERFUNCTION.ID = LIVERFUNCTION.VALUECODE_ID
            
       LEFT JOIN DBO.A_ACT PREGNANT (NOLOCK)
            ON  PREGNANT.ACT_PARENT_ID = ACTDOT.[ID]
            AND PREGNANT.CLASSCODE = 'OBS'
            AND PREGNANT.METACODE = 'DOTDAY_PREGNANT'
       LEFT JOIN DBO.A_ACT SMEAR (NOLOCK)
            ON  SMEAR.ACT_PARENT_ID = CULTURE.[ID]
            AND SMEAR.CLASSCODE = 'OBS'
            AND SMEAR.METACODE = 'DOTDAY_SMEAR_FK'
       LEFT JOIN DBO.A_OBSERVATION OBS_SMEAR (NOLOCK)
            ON  OBS_SMEAR.[ID] = SMEAR.[ID]
       LEFT JOIN V_UNIFIEDCODESET UCS_SMEAR (NOLOCK)
            ON  UCS_SMEAR.ID = OBS_SMEAR.INTERPRETATIONCODE_ID
            
       LEFT JOIN P_PARTICIPATION PART_SPUT (NOLOCK)
            ON  PART_SPUT.ACT_ID = CULTURE.[ID]
            AND PART_SPUT.TYPECODE = 'SPC'
       LEFT JOIN R_ROLE ROLE_SPUT (NOLOCK)
            ON  ROLE_SPUT.ID = PART_SPUT.ROLE_ID
            AND ROLE_SPUT.CLASSCODE = 'SPEC'
                        LEFT JOIN V_UNIFIEDCODESET VUCROLE (NOLOCK) ON ROLE_SPUT.CODE_ID=VUCR.ID 
               AND VUCROLE.CONCEPTCODE = 'P'
            
            
       LEFT JOIN E_ENTITY ENT_SPUT (NOLOCK)
            ON  ENT_SPUT.ID = ROLE_SPUT.PLAYER_ID
            AND ENT_SPUT.CLASSCODE = 'MAT'
       LEFT JOIN V_UNIFIEDCODESET UCS_THERAPY (NOLOCK)
            ON  UCS_THERAPY.ID = ACTDOT.CODE_ID
            LEFT JOIN V_UNIFIEDCODESET VUCR1 (NOLOCK) ON ACTDOT.CODE_ID=VUCR.ID 
               AND UCS_THERAPY.CONCEPTCODE = VUCR1.CONCEPTCODE
            
       LEFT JOIN DBO.A_ACT BEGINWEIGHT (NOLOCK)
            ON  BEGINWEIGHT.ACT_PARENT_ID = ACTDOT.[ID]
            AND BEGINWEIGHT.CLASSCODE = 'OBS'
            AND BEGINWEIGHT.METACODE = 'DOTDAY_BEGINWEIGHT'
       LEFT JOIN DBO.A_ACT SUBMITTED (NOLOCK)
            ON  SUBMITTED.ACT_PARENT_ID = ACTDOT.[ID]
            AND SUBMITTED.CLASSCODE = 'OBS'
            AND SUBMITTED.METACODE = 'DOTDAY_SUBMITTED'

