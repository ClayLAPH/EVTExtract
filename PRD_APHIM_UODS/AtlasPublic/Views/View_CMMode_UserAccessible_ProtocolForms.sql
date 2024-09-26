
CREATE VIEW [AtlasPublic].[View_CMMode_UserAccessible_ProtocolForms]
AS
    SELECT 
        vSysUser.[USR_RowID] [USR_ROWID], 
        vSysUser.[USR_Login] [USR_LOGIN],
        UCS_FORM.ID AS [USR_ACCESSIBLE_FORM_DEF_DR],
        ISPROT.FRM_ID AS [USR_ACCESSIBLE_FORM_ID],  
        UCS_FORM.FULLNAME [USR_ACCESSIBLE_FORM_NAME],
        UCS_SVC_CAT.[ID] AS [USR_ACCESSIBLE_SERVICE_ID],
        UCS_SVC_CAT.fullName as [USR_ACCESSIBLE_SERVICE_NAME]
    FROM [AtlasPublic].[View_CMMode_SystemUsers] [vSysUser] (NOLOCK)      
        INNER JOIN [R_RoleLink] [UGRLNK] (NOLOCK) ON  vSysUser.USR_RoleID = UGRLNK.targetRole_ID AND UGRLNK.typeCode = 'PART' 
            AND UGRLNK.metaCode='USR_CMRUserGroupDR'
        INNER JOIN [R_Role] [UROL] (NOLOCK) ON [UGRLNK].sourceRole_ID = UROL.ID and urol.classCode = 'ASSIGNED' AND UROL.metaCode = 'UG_ROWID' 
            AND UROL.statusCode = 'active'
        INNER JOIN T_Attribute ATTRFrmAcc (NOLOCK) ON [UROL].[ID] = ATTRFrmAcc.Role_ID and ATTRFrmAcc.name = 'FORMACC'
        INNER JOIN V_Codeproperty VCPFrmAcc (NOLOCK) ON VCPFrmAcc.[subjCode_ID] = ATTRFrmAcc.[valueCode_ID] AND VCPFrmAcc.Property = CAST(ATTRFrmAcc.ID AS VARCHAR(50)) and VCPFrmAcc.valuebool = 1
        INNER JOIN V_UnifiedCodeSet UCS_FORM(NOLOCK) ON UCS_FORM.ID=VCPFrmAcc.Valuecode_ID
        INNER JOIN VCP_UDForm ISPROT (NOLOCK) ON VCPFrmAcc.Valuecode_ID = ISPROT.Subjcode_ID AND ISPROT.FRM_InProtocol = 1
        INNER JOIN V_UnifiedCodeSet (NOLOCK) UCS_SVC_CAT ON UCS_SVC_CAT.ID=VCPFrmAcc.[subjCode_ID]
        INNER JOIN A_Act (NOLOCK) PROT_Act on PROT_Act.[classCode] = 'ACT' AND PROT_Act.[metaCode] = 'PROT_ID' AND PROT_Act.[moodCode] = 'DEF' 
            AND PROT_Act.statusCode='active' AND CAST(PROT_Act.title AS VARCHAR)= cast(UCS_SVC_CAT.otherInfo AS VARCHAR)
        INNER JOIN T_Attribute (NOLOCK) ATTRPROTForm ON ATTRPROTForm.Act_ID=PROT_Act.ID and ATTRPROTForm.name='PROT_FormName_FK' and ATTRPROTForm.valueCode_ID=VCPFrmAcc.[valueCode_ID]
