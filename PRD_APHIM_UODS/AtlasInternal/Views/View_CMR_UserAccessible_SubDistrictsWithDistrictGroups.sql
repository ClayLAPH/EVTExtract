
CREATE VIEW [AtlasInternal].[View_CMR_UserAccessible_SubDistrictsWithDistrictGroups]
AS
    --Create row with NULL values


    
WITH OIDSToIGNORE (DOMAINID)
      AS
      (
         SELECT  VD.ID  FROM V_DOMAIN VD (NOLOCK)
        INNER JOIN [DBO].[PARMSTOLIST](CAST((SELECT CAST(VALUE AS VARCHAR(MAX)) AS COL1 FROM S_CONFIGVALUE (NOLOCK) INNER JOIN S_CONFIGDEFINITION SD (NOLOCK) ON SD.ID=CONFIGDEFINITION_ID WHERE SD.[KEY]='OIDSTOIGNORE') AS VARCHAR(200))) NULLFL ON NULLFL.Value =VD.domainOid
      )

    SELECT 
        -1 AS DistrictGroupDR, 
        NULL AS DistrictID, 
        NULL AS DistrictName, 
        NULL AS DistrictActive
    UNION

    --Fetch the list of all districts assuming -1 DistrictGroup ID
    SELECT 
        -1 AS DistrictGroupDR, 
        V_UnifiedCodeSet.ID AS DistrictID, 
        V_UnifiedCodeSet.fullName AS DistrictName, 
        V_TermDictionary.active AS DistrictActive
    FROM 
        V_DictionaryDefinition (NOLOCK)
        INNER JOIN V_UnifiedCodeSet (NOLOCK) ON V_DictionaryDefinition.domain_ID=V_UnifiedCodeSet.domain_ID
        LEFT JOIN OIDSToIGNORE WITH (NOLOCK) ON DOMAINID =V_DictionaryDefinition.domain_ID        
        LEFT JOIN V_TermDictionary (NOLOCK) ON V_UnifiedCodeSet.ID=V_TermDictionary.termCode_ID AND V_TermDictionary.[name]='District' 
    WHERE 
        V_DictionaryDefinition.[Name]='District' AND DOMAINID IS NULL

    UNION 

    --Fetch the list of all districts assuming associated to DistrictGroup ID
    SELECT 
        ISNULL([VCP].subjCode_ID,-1) AS DistrictGroupDR, 
        V_UnifiedCodeSet.ID AS DistrictID, 
        V_UnifiedCodeSet.fullName AS DistrictName,
        V_TermDictionary.active AS DistrictActive
    FROM 
        V_DictionaryDefinition (NOLOCK)
             INNER JOIN V_UnifiedCodeSet (NOLOCK) ON V_DictionaryDefinition.domain_ID=V_UnifiedCodeSet.domain_ID 
       
        LEFT JOIN [V_CodeProperty] [VCP] (NOLOCK) ON [VCP].valueCode_ID = V_UnifiedCodeSet.ID AND [VCP].property='GRPD_DistrictDR' 
        LEFT JOIN V_TermDictionary (NOLOCK) ON V_UnifiedCodeSet.ID=V_TermDictionary.termCode_ID AND V_TermDictionary.[name]='District' 
        LEFT JOIN OIDSToIGNORE WITH (NOLOCK) ON DOMAINID =V_DictionaryDefinition.domain_ID     
    WHERE 
        V_DictionaryDefinition.[Name]='District' AND  DOMAINID IS NULL

