
CREATE VIEW [AtlasPublic].[VIEW_CMR_AR_VeterinaryTab] AS
SELECT 
[ChildTopic].[AI_RowID] AS [AI_Vet_AnimalRowId], 
[ChildTopic].[AI_AnimalReportID] AS [AI_Vet_AnimalID], 
[UCS_ATYPE].[FullName] AS [AI_Vet_AnimalType], 
[UCS_SPECIES].[FullName] AS [AI_Vet_Species], 
[UCS_BREED].[FullName] AS [AI_Vet_Breed], 
[UCS_PC].[FullName] AS [AI_Vet_Primary_Color], 
[UCS_SC].[FullName] AS [AI_Vet_Secondary_Color], 
[UCS_SEX].[FullName] AS [AI_Vet_Sex], 
[A_PublicHealthCase].[ageReported_OrTx] AS [AI_Vet_Age], 
[T_EntityName].[trivialName] AS [AI_Vet_Name], 
CONVERT(CHAR(10),[A_PublicHealthCase].[sxDate], 110)AS [AI_Vet_Date_of_Illness_Onset],
CONVERT(CHAR(10),[A_PublicHealthCase].[dxDate], 110) AS [AI_Vet_Date_Of_Diagnosis], 
[UCS_IHD].[FullName] AS [AI_Vet_Indicator_of_Human_Disease],
[UCS_ZIL].[FullName] AS [AI_Vet_Zoonotic_illness],
(CASE WHEN [E_NonPersonLivingSubject].[deceasedInd]='1' THEN 'Yes' ELSE 'No' END)  AS [AI_Vet_Did_Animal_Die],
CONVERT(CHAR(10),[E_NonPersonLivingSubject].[deceasedTime],110) AS [AI_Vet_Date_Of_Death],
[ActTopic].[text] AS [AI_Vet_Notes] 
FROM  [AtlasInternal].VIEW_CMR_AR_Vet_ChildActTopic ChildTopic  (NOLOCK)
INNER JOIN [A_PublicHealthCase]  (NOLOCK) ON  [A_PublicHealthCase].[ID]=ChildTopic.[AI_RowID]
INNER JOIN [A_ACT] ActTopic (NOLOCK) ON [ActTopic].ID=[ChildTopic].AI_VET_ACTTOPIC
INNER JOIN [P_Participation] (NOLOCK) ON  ChildTopic.[AI_RowID]=[P_Participation].[Act_ID] AND  [P_Participation].[typeCode] = 'SBJ' AND [P_Participation].[metaCode] = 'AI_AnimalTypeDR'
INNER JOIN [R_Role] (NOLOCK) ON  [R_Role].[ID]=[P_Participation].[Role_ID] AND  [R_Role].[classCode] = 'CASESBJ'
INNER JOIN [E_Entity] (NOLOCK) ON  [E_Entity].[ID]= [R_Role].[Player_ID]
LEFT JOIN [V_UnifiedCodeSet] [UCS_ATYPE] (NOLOCK) ON [UCS_ATYPE].[ID] = [R_Role].[Code_ID]
LEFT JOIN [V_UnifiedCodeSet] [UCS_SPECIES] (NOLOCK) ON [UCS_SPECIES].[ID] = [E_Entity].[code_ID]
LEFT JOIN [E_NonPersonLivingSubject] (NOLOCK) ON  [E_Entity].[ID]=[E_NonPersonLivingSubject].[ID]
LEFT JOIN [V_UnifiedCodeSet] [UCS_BREED] (NOLOCK) ON [UCS_BREED].[ID] = [E_NonPersonLivingSubject].[strainCode_ID]
LEFT JOIN [T_Attribute] [AttPColor] (NOLOCK) ON  [E_Entity].[ID]=[AttPColor].[Entity_ID] AND  [AttPColor].[name] = 'AI_PrimaryColorDR'
LEFT JOIN [V_UnifiedCodeSet] [UCS_PC] (NOLOCK) ON [UCS_PC].[ID] = [AttPColor].[valueCode_ID] 
LEFT JOIN [T_Attribute] [AttSColor] (NOLOCK) ON  [E_Entity].[ID]=[AttSColor].[Entity_ID] AND  [AttSColor].[name] = 'AI_SecondaryColorDR'
LEFT JOIN [V_UnifiedCodeSet] [UCS_SC] (NOLOCK) ON [UCS_SC].[ID] = [AttSColor].[valueCode_ID]
LEFT JOIN [V_UnifiedCodeSet] [UCS_SEX] (NOLOCK) ON [UCS_SEX].[ID] = [E_NonPersonLivingSubject].[administrativeGenderCode_ID]
LEFT JOIN [T_EntityName] (NOLOCK) ON  [E_Entity].[ID]=[T_EntityName].[Entity_ID]
LEFT JOIN [A_Act] [LPA_A1] (NOLOCK) ON  ChildTopic.[AI_RowID]=[LPA_A1].[Act_Parent_ID] AND  [LPA_A1].[classCode] = 'OBS' AND [LPA_A1].[metaCode] = 'AI_IndicatorOfHumanDisease' 
LEFT JOIN [V_UnifiedCodeSet] [UCS_IHD] (NOLOCK) ON [UCS_IHD].[ID] =[LPA_A1].[valueCode_ID]
LEFT JOIN [A_Act] [LPA_A2] (NOLOCK) ON  ChildTopic.[AI_RowID]=[LPA_A2].[Act_Parent_ID] AND  [LPA_A2].[classCode] = 'OBS' AND [LPA_A2].[metaCode] = 'AI_Zoonose'
LEFT JOIN [V_UnifiedCodeSet] [UCS_ZIL] (NOLOCK) ON [UCS_ZIL].[ID] =[LPA_A2].[valueCode_ID]

