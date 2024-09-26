﻿CREATE VIEW [AtlasInternal].[VIEW_RaceCategories_CMMode] AS

SELECT DISTINCT UCS.ID AS RACE_CAT_ID ,UCS.FULLNAME AS RACE_CATEGORY ,VT.active AS IsActive
FROM    V_UNIFIEDCODESET UCS (nolock)
        LEFT JOIN V_TermDictionary VT (nolock) ON VT.termCode_ID= UCS.ID 
WHERE   VT.Name='RaceCategory'

