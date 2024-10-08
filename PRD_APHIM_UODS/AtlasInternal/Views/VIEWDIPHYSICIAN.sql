﻿
CREATE VIEW [AtlasInternal].[VIEWDIPHYSICIAN]    
AS    
SELECT   
DV_PHPersonalRecord.DVPR_ROWID AS PR_ROWID,    
ENTNAME.TRIVIALNAME AS PR_PHYSICIAN, 
T_ENTITYADDRESS.PartAptNum LOC_STREETNUMBER,
T_ENTITYADDRESS.PartSAL LOC_STREETNAME ,     
T_ENTITYADDRESS.PartCty AS LOC_CITY,     
T_ENTITYADDRESS.PartSta AS LOC_STATE,     
T_ENTITYADDRESS.PartCty AS LOC_ZIPCODE, 
ENTPHONE.ADDRESS AS LOC_PHONE    
FROM     
DV_PHPERSONALRECORD (NOLOCK) 
INNER JOIN P_PARTICIPATION PART (NOLOCK) ON DV_PHPersonalRecord.DVPR_ROWID=PART.ACT_ID AND PART.TYPECODE='REFB' AND PART.METACODE='PR_PHYSICIANDR'   
INNER JOIN R_ROLE PHYROLE (NOLOCK) ON PART.ROLE_ID=PHYROLE.[ID] AND PART.TYPECODE='REFB' AND PART.METACODE='PR_PHYSICIANDR'    
INNER JOIN E_ORGANIZATION ORG (NOLOCK) ON PHYROLE.PLAYER_ID=ORG.[ID]
INNER JOIN T_ENTITYNAME ENTNAME (NOLOCK) ON ENTNAME.ENTITY_ID=ORG.[ID] AND ENTNAME.USECODE='SRCH' AND ENTNAME.METACODE='RS_HEALTHCAREPROVIDER'    
LEFT JOIN S_LINK (NOLOCK) ON S_LINK.ENTITY1_ID=PHYROLE.PLAYER_ID AND S_LINK.NAME='RSLocation-Primary'
LEFT JOIN E_PLACE ENTLOC (NOLOCK) ON S_LINK.ENTITY2_ID=ENTLOC.ID    
LEFT JOIN T_ENTITYADDRESS (NOLOCK) ON ENTLOC.ID = DBO.T_ENTITYADDRESS.ENTITY_ID  
LEFT JOIN T_ENTITYTELECOM ENTPHONE (NOLOCK) ON ENTPHONE.ENTITY_ID=ENTLOC.ID AND ENTPHONE.SCHEME='TEL' AND ENTPHONE.USECODE='PHYS' 

