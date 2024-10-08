﻿CREATE View [AtlasInternal].[VIEWSYSTEMCONTACTDATA_FOR_CM_MODE] AS
SELECT  ACTCASE.ID AS DIID,  
       PERSON.ID AS CONTACTID,  
       TINS.extension AS INSTANCEID,  
       (CASE WHEN ACTCASE.metaCode='PR_ROWID' THEN 'DI' WHEN ACTCASE.metaCode='AI_ROWID' THEN 'AR' WHEN ACTCASE.metaCode='SVC_ID' THEN 'SVC' END) AS RECORDTYPE,
       DP.DVPER_FIRSTNAME AS RLENT_FIRSTNAME,  
       DP.DVPER_LASTNAME AS RLENT_LASTNAME,  
       EN.PARTMID AS RLENT_MIDDLEINITIAL,  
       EN.PARTSFX AS RLENT_NAMESUFFIX,  
       AGE.VALUEINTEGER AS RLENT_AGE,  
	   DP.DVPER_DOB AS RLENT_DOB,
       UCSSEX.FULLNAME AS RLENT_SEX,  
       UCSCONTTYPE.FULLNAME AS RLENT_CONTACTTYPE,  
       CONVERT(DATETIME, CONDATE.VALUETS, 110) AS RLENT_DATESOFCONTACT,  
       DP.DVPER_STREETADDRESS AS RLENT_STREETADDRESS,  
       DP.DVPER_APARTMENT AS RLENT_APARTMENT,  
       DP.DVPER_CITY AS RLENT_CITY,  
       DP.DVPER_ZIP AS RLENT_ZIP,  
       DP.DVPER_HOMEPHONE AS RLENT_PHONE,  
       UCSDISTRICT.FULLNAME AS RLENT_DISTRICT,  
       SBADM.TEXT AS RLENT_PROPHYLAXISMEDICATION,  
       (ENTINVEST.PARTFAM + ', ' +  ENTINVEST.PARTGIV) AS RLENT_INVESTIGATORDR,  
       EXPACT.ID AS RLENT_EXPEVENTDR,  
		LOCNAME.TRIVIALNAME AS RLENT_EXPEVENT,
       UCSPRIORITY.FULLNAME AS RLENT_PRIORITYDR, 
       --NG 07/30/2010 ISSUE#83086    
       ATTR_CLUSTER.VALUESTRING AS RLENT_CLUSTERID,  
       UCSSTATUS.FULLNAME AS RLENT_STATUSDR,  
    FOLDER.ID AS FOLDERID,
	ECONTACT.VALUESTRING AS  RLENT_ELECTRONICCONTACT,
	EMAIL.VALUESTRING AS  RLENT_EMAIL,
	DP.DVPER_STATE AS RLENT_STATE,
	DBO.FN_GETUCSFULLNAME(DP.DVPER_RACECODE_ID) AS RLENT_RACE
	FROM   E_ENTITY PERSON  
       INNER JOIN DV_PERSON DP (NOLOCK)  
            ON  DP.DVPER_ROWID = PERSON.ID  
            AND DP.DVPER_ISCONTACT = 1  
       INNER JOIN R_ROLE MBR (NOLOCK)  
            ON  PERSON.ID = MBR.PLAYER_ID  
            AND MBR.CLASSCODE = 'MBR'  
            AND MBR.STATUSCODE NOT IN ('NULLIFIED', 'TERMINATED')  
       INNER JOIN E_ENTITY ENTGROUP (NOLOCK)  
            ON  MBR.SCOPER_ID = ENTGROUP.ID  
            AND ENTGROUP.CLASSCODE = 'ENT'  
       INNER JOIN R_ROLE EXPR (NOLOCK)  
            ON  ENTGROUP.ID = EXPR.PLAYER_ID  
            AND EXPR.CLASSCODE = 'EXPR'  
       INNER JOIN P_PARTICIPATION IND (NOLOCK)  
            ON  EXPR.ID = IND.ROLE_ID  
            AND IND.TYPECODE = 'IND'  
       INNER JOIN A_Act ACTCASE (NOLOCK)  
            ON  ACTCASE.ID = IND.ACT_ID AND  ACTCASE.metaCode IN ('AI_ROWID','PR_ROWID','SVC_ID') AND ACTCASE.statusCode IN ('ACTIVE','COMPLETED')
		LEFT JOIN T_InstanceIdentifier TINS (NOLOCK)              
			ON TINS.Act_ID=ACTCASE.ID AND (TINS.[root] LIKE '2.16.840.1.113883.3.33.4.2.2.11.1%' OR TINS.[root] LIKE '2.16.840.1.113883.3.33.4.2.2.11.8%')
       LEFT JOIN P_PARTICIPATION PART (NOLOCK)  
            ON  MBR.ID = PART.ROLE_ID  
            AND PART.TYPECODE = 'SBJ'  
       LEFT JOIN A_ACT FOLDER (NOLOCK)  
            ON  PART.ACT_ID = FOLDER.ID  
            AND FOLDER.CLASSCODE = 'FOLDER'  
       LEFT JOIN V_UNIFIEDCODESET VCFOLDER (NOLOCK) ON  
        FOLDER.CODE_ID=VCFOLDER.ID AND VCFOLDER.CONCEPTCODE = 'EXPR'  
       LEFT JOIN A_ACT SBADM (NOLOCK)  
            ON  FOLDER.ID = SBADM.ACT_PARENT_ID  
            AND SBADM.CLASSCODE = 'SBADM'  
            AND SBADM.METACODE = 'RLENT_PROPHYLAXISMEDICATION'  
       LEFT JOIN A_ACTRELATIONSHIP PERT (NOLOCK)  
            ON  FOLDER.ID = PERT.SOURCE_ID  
            AND PERT.TYPECODE = 'PERT'  
       LEFT JOIN A_ACT INC (NOLOCK)  
            ON  PERT.TARGET_ID = INC.ACT_PARENT_ID  
            AND INC.CLASSCODE = 'INC'  
            AND INC.METACODE = 'DEE_ROWID'  
       LEFT JOIN P_PARTICIPATION DIR (NOLOCK)  
            ON  INC.ID = DIR.ACT_ID  
            AND DIR.TYPECODE = 'DIR'  
            AND DIR.METACODE = 'DEE_LABORATORYDR'  
       LEFT JOIN R_ROLE LOCE (NOLOCK)  
            ON  DIR.ROLE_ID = LOCE.ID  
            AND LOCE.CLASSCODE = 'LOCE' 
		LEFT JOIN A_ACTRELATIONSHIP ON A_ACTRELATIONSHIP.SOURCE_ID= FOLDER.ID AND A_ACTRELATIONSHIP.TypeCode='PERT'
		LEFT JOIN A_ACT EXPACT ON EXPACT.ID=A_ACTRELATIONSHIP.TARGET_ID AND EXPACT.CLASSCODE='INC' AND EXPACT.MOODCODE='EVN' AND EXPACT.METACODE='DEE_RowID'
		LEFT JOIN P_PARTICIPATION EXPLOCPART ON EXPLOCPART.ACT_ID=EXPACT.ID AND EXPLOCPART.METACODE='DEE_LaboratoryDR'
		LEFT JOIN R_ROLE EXPLOCROLE ON EXPLOCROLE.ID=EXPLOCPART.ROLE_ID
       LEFT JOIN T_ENTITYNAME LOCNAME (NOLOCK)  
            ON  EXPLOCROLE.SCOPER_ID = LOCNAME.ENTITY_ID  
            AND LOCNAME.USECODE = 'SRCH'  
            AND LOCNAME.METACODE = 'LOC_NAME'  
       LEFT JOIN T_ENTITYNAME EN (NOLOCK)  
            ON  DP.DVPER_ROWID = EN.ENTITY_ID  
            AND EN.USECODE = 'L'  
		LEFT JOIN T_ATTRIBUTE AGE (NOLOCK)  
            ON  PERSON.ID = AGE.ENTITY_ID  
            AND AGE.NAME = 'PER_AGE'  
            AND AGE.TYPE = 'INT'
           --+NG 07/30/2010 ISSUE#83086   
       LEFT JOIN T_ATTRIBUTE ATTR_STATUS (NOLOCK)  
            ON  FOLDER.ID = ATTR_STATUS.ACT_ID  
            AND ATTR_STATUS.NAME = 'RLENT_StatusDR'  
            AND ATTR_STATUS.TYPE = 'CV'
       LEFT JOIN T_ATTRIBUTE ATTR_DISTRICT (NOLOCK)  
            ON  FOLDER.ID = ATTR_DISTRICT.ACT_ID  
            AND ATTR_DISTRICT.NAME = 'RLENT_DistrictDR'  
            AND ATTR_DISTRICT.TYPE = 'CV'
       LEFT JOIN T_ATTRIBUTE ATTR_CLUSTER (NOLOCK)  
            ON  FOLDER.ID = ATTR_CLUSTER.ACT_ID  
            AND ATTR_CLUSTER.NAME = 'RLENT_ClusterID'  
            AND ATTR_CLUSTER.TYPE = 'ST'
       LEFT JOIN T_ATTRIBUTE PRIODR ON MBR.ID=PRIODR.Role_ID AND PRIODR.NAME='RLENT_Priority' AND PRIODR.TYPE='CV'
	LEFT JOIN V_UNIFIEDCODESET UCSPRIORITY ON PRIODR.ValueCode_ID=UCSPRIORITY.ID  
            --NG 07/30/2010 ISSUE#83086      
       LEFT JOIN V_UNIFIEDCODESET UCSSEX (NOLOCK)  
            ON  DP.DVPER_SEXCODE_ID = UCSSEX.ID  
       LEFT JOIN T_ATTRIBUTE CONTTYPE (NOLOCK)  
            ON  MBR.ID = CONTTYPE.ROLE_ID  
            AND CONTTYPE.NAME = 'RLENT_CONTACTTYPE'  
            AND CONTTYPE.TYPE = 'CV'  
       LEFT JOIN V_UNIFIEDCODESET UCSCONTTYPE (NOLOCK)  
            ON  CONTTYPE.VALUECODE_ID = UCSCONTTYPE.ID  
       LEFT JOIN T_ATTRIBUTE CONDATE (NOLOCK)  
            ON  MBR.ID = CONDATE.ROLE_ID  
            AND CONDATE.NAME = 'RLENT_DATESOFCONTACT'  
            AND CONDATE.TYPE = 'TS'  
       LEFT JOIN V_UNIFIEDCODESET UCSDISTRICT (NOLOCK) 
       --NG 07/30/2010 ISSUE#83086    
            ON  ATTR_DISTRICT.VALUECODE_ID = UCSDISTRICT.ID  
       LEFT JOIN R_ROLELINK RLNK (NOLOCK)  
            ON  MBR.ID = RLNK.SOURCEROLE_ID  
            AND RLNK.METACODE = 'RLENT_INVESTIGATORDR'  
            AND RLNK.TypeCode = 'REL'  
       LEFT JOIN R_ROLE INVEST (NOLOCK)  
            ON  RLNK.TARGETROLE_ID = INVEST.ID  
            AND INVEST.CLASSCODE = 'AGNT'  
       LEFT JOIN T_ENTITYNAME ENTINVEST (NOLOCK)  
            ON  INVEST.PLAYER_ID = ENTINVEST.ENTITY_ID  
              
       LEFT JOIN V_UNIFIEDCODESET UCSSTATUS (NOLOCK)
       --NG 07/30/2010 ISSUE#83086     
            ON  ATTR_STATUS.VALUECODE_ID = UCSSTATUS.ID  
		LEFT JOIN T_ATTRIBUTE EMAIL (NOLOCK) ON EMAIL.ENTITY_ID=PERSON.ID AND EMAIL.NAME='PSNID_EmailID' AND EMAIL.TYPE='ST'
		LEFT JOIN T_ATTRIBUTE ECONTACT (NOLOCK) ON ECONTACT.ENTITY_ID=PERSON.ID AND ECONTACT.NAME='PSNID_ElectronicContact' AND ECONTACT.TYPE='ST'
WHERE  PERSON.CLASSCODE = 'PSN'
