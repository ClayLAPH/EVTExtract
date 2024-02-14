﻿Create VIEW [AtlasInternal].VIEW_ClientRecordRACE_CMMode AS  
   
  SELECT RACECAT.ENTITY_ID AS PERSON_ID ,  
         Race.RACE_CAT_ID AS RACE_CAT_ID,  
         Race.RACE_CATEGORY AS RACE_CATEGORY,  
         DBO.STRCONCAT(DBO.MDF_UCS_FULLNAME_UCS_BYUCSID(T_RACE.raceCode_ID)) AS RACE_SUB_CATEGORY  
  FROM   T_RACE RACECAT (nolock)  
         INNER JOIN [AtlasInternal].[VIEW_RaceCategories_CMMode] RACE (NOLOCK) on RACECAT.raceCode_ID=RACE.RACE_CAT_ID and RACECAT.metaCode='PER_RaceCategoryDR'  
         LEFT JOIN [V_CodeProperty] VCP (NOLOCK) ON  VCP.valueCode_ID=RACECAT.RaceCode_ID AND VCP.property = 'Race_CategoryDR'   
         LEFT JOIN T_RACE(NOLOCK)ON T_RACE.Entity_id=RACECAT.Entity_id AND T_RACE.raceCode_ID=VCP.subjCode_ID  
 GROUP BY RACECAT.Entity_ID,RACE.RACE_CAT_ID,RACE.RACE_CATEGORY  
