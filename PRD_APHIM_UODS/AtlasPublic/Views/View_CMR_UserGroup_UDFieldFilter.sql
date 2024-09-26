
Create View AtlasPublic.View_CMR_UserGroup_UDFieldFilter
As
select UG_ENT.ID AS UG_RowID,UG_ENT.desc_Txt AS UG_UserGroup_Name, ATTR_SEC.valueCode_ID AS UG_Access_SectionDef_ID, SEC_UCS.fullName AS UG_Access_Section_Name, ATTR_FIELD.valueCode_ID AS UG_Access_FieldDef_ID,FIELD_UCS.fullName AS UG_Access_Field_Name, CASE ATTR_FIELDVALUE.valueString WHEN '' THEN NULL ELSE ATTR_FIELDVALUE.valueString END  AS UG_Access_Field_Value_ID,(SELECT CASE WHEN ATTR_FIELDVALUE.valueString = 'Y' THEN 'Yes' ELSE (SELECT fullName FROM V_UnifiedCodeSet (NOLOCK) WHERE ID = CAST(ATTR_FIELDVALUE.ValueString AS INT)) END) AS UG_Access_Field_Value,CASE R_Role.statusCode WHEN 'active' THEN 1 ELSE 0 END AS  UG_Active
 FROM E_Entity UG_ENT (NOLOCK)
INNER JOIN R_Role (NOLOCK) ON R_Role.player_ID=UG_ENT.ID AND R_Role.classCode='ASSIGNED'
LEFT JOIN T_Attribute ATTR_SEC (NOLOCK) ON ATTR_SEC.Role_ID=R_Role.ID AND ATTR_SEC.name='UG_FieldFilterUDSectionDR'
LEFT JOIN V_UnifiedCodeSet SEC_UCS (NOLOCK) ON SEC_UCS.ID=ATTR_SEC.valueCode_ID
LEFT JOIN T_Attribute ATTR_FIELD (NOLOCK) ON ATTR_FIELD.Role_ID=R_Role.ID AND ATTR_FIELD.name='UG_FieldFilterUDFieldDR'
LEFT JOIN V_UnifiedCodeSet FIELD_UCS (NOLOCK) ON FIELD_UCS.ID=ATTR_FIELD.valueCode_ID
LEFT JOIN T_Attribute ATTR_FIELDVALUE (NOLOCK) ON ATTR_FIELDVALUE.Role_ID=R_Role.ID AND ATTR_FIELDVALUE.name='UG_FieldFilterUDFieldValue'
WHERE UG_ENT.metaCode='UG_RowID' AND UG_ENT.classCode='ENT' AND UG_ENT.determinerCode='QUANTIFIED_KIND'
