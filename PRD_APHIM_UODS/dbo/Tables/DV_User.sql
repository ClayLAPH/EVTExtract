CREATE TABLE [dbo].[DV_User] (
    [DV_UserID]                      INT           NOT NULL,
    [DV_UserRoleID]                  INT           NOT NULL,
    [DV_DeviceID]                    INT           NULL,
    [DV_FirstName]                   VARCHAR (100) NULL,
    [DV_LastName]                    VARCHAR (100) NULL,
    [DV_CMRUserGroup_RoleID]         INT           NULL,
    [DV_NCMUserGroup_RoleID]         INT           NULL,
    [DV_IsCMRActive]                 BIT           NULL,
    [DV_IsNCMActive]                 BIT           NULL,
    [DV_IsInvestigator]              BIT           NULL,
    [DV_IsAnimalInvestigator]        BIT           NULL,
    [DV_DistrictGroupDR]             INT           NULL,
    [DV_OutbreakDistrictGroupDR]     INT           NULL,
    [DV_GroupEventDistrictGroupDR]   INT           NULL,
    [DV_AnimalReportDistrictGroupDR] INT           NULL,
    [DV_DiseaseGroupDR]              INT           NULL,
    CONSTRAINT [PK_DV_USER] PRIMARY KEY CLUSTERED ([DV_UserID] ASC) WITH (FILLFACTOR = 95) ON [PRIMARY_IDX],
    CONSTRAINT [FK_DV_User_DV_AnimalReportDistrictGroupDR_V_UnifiedCodeset] FOREIGN KEY ([DV_AnimalReportDistrictGroupDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DV_User_DV_CMRUserGroup_RoleID_R_Role] FOREIGN KEY ([DV_CMRUserGroup_RoleID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DV_User_DV_DeviceID_E_Device] FOREIGN KEY ([DV_DeviceID]) REFERENCES [dbo].[E_Device] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DV_User_DV_DiseaseGroupDR_V_UnifiedCodeset] FOREIGN KEY ([DV_DiseaseGroupDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DV_User_DV_DistrictGroupDR_V_UnifiedCodeset] FOREIGN KEY ([DV_DistrictGroupDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DV_User_DV_GroupEventDistrictGroupDR_V_UnifiedCodeset] FOREIGN KEY ([DV_GroupEventDistrictGroupDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DV_User_DV_NCMUserGroup_RoleID_R_Role] FOREIGN KEY ([DV_NCMUserGroup_RoleID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DV_User_DV_OutbreakDistrictGroupDR_V_UnifiedCodeset] FOREIGN KEY ([DV_OutbreakDistrictGroupDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DV_User_DV_UserID_E_Entity] FOREIGN KEY ([DV_UserID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DV_User_DV_UserRoleID_R_ROLE] FOREIGN KEY ([DV_UserRoleID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION
) ON [PRIMARY_IDX];


GO
ALTER TABLE [dbo].[DV_User] NOCHECK CONSTRAINT [FK_DV_User_DV_AnimalReportDistrictGroupDR_V_UnifiedCodeset];


GO
ALTER TABLE [dbo].[DV_User] NOCHECK CONSTRAINT [FK_DV_User_DV_CMRUserGroup_RoleID_R_Role];


GO
ALTER TABLE [dbo].[DV_User] NOCHECK CONSTRAINT [FK_DV_User_DV_DeviceID_E_Device];


GO
ALTER TABLE [dbo].[DV_User] NOCHECK CONSTRAINT [FK_DV_User_DV_DiseaseGroupDR_V_UnifiedCodeset];


GO
ALTER TABLE [dbo].[DV_User] NOCHECK CONSTRAINT [FK_DV_User_DV_DistrictGroupDR_V_UnifiedCodeset];


GO
ALTER TABLE [dbo].[DV_User] NOCHECK CONSTRAINT [FK_DV_User_DV_GroupEventDistrictGroupDR_V_UnifiedCodeset];


GO
ALTER TABLE [dbo].[DV_User] NOCHECK CONSTRAINT [FK_DV_User_DV_NCMUserGroup_RoleID_R_Role];


GO
ALTER TABLE [dbo].[DV_User] NOCHECK CONSTRAINT [FK_DV_User_DV_OutbreakDistrictGroupDR_V_UnifiedCodeset];


GO
ALTER TABLE [dbo].[DV_User] NOCHECK CONSTRAINT [FK_DV_User_DV_UserID_E_Entity];


GO
ALTER TABLE [dbo].[DV_User] NOCHECK CONSTRAINT [FK_DV_User_DV_UserRoleID_R_ROLE];


GO
CREATE NONCLUSTERED INDEX [IX_DV_User_DistrictGroup]
    ON [dbo].[DV_User]([DV_IsCMRActive] ASC, [DV_IsInvestigator] ASC, [DV_DeviceID] ASC, [DV_DistrictGroupDR] ASC, [DV_DiseaseGroupDR] ASC)
    INCLUDE([DV_FirstName], [DV_LastName], [DV_CMRUserGroup_RoleID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_User_OBDistrictGroup]
    ON [dbo].[DV_User]([DV_IsCMRActive] ASC, [DV_IsInvestigator] ASC, [DV_DeviceID] ASC, [DV_OutbreakDistrictGroupDR] ASC, [DV_DiseaseGroupDR] ASC)
    INCLUDE([DV_FirstName], [DV_LastName], [DV_CMRUserGroup_RoleID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_User_GEDistrictGroup]
    ON [dbo].[DV_User]([DV_IsCMRActive] ASC, [DV_IsInvestigator] ASC, [DV_DeviceID] ASC, [DV_GroupEventDistrictGroupDR] ASC)
    INCLUDE([DV_FirstName], [DV_LastName], [DV_CMRUserGroup_RoleID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_User_ARDistrictGroup]
    ON [dbo].[DV_User]([DV_IsCMRActive] ASC, [DV_IsAnimalInvestigator] ASC, [DV_DeviceID] ASC, [DV_AnimalReportDistrictGroupDR] ASC, [DV_DiseaseGroupDR] ASC)
    INCLUDE([DV_FirstName], [DV_LastName], [DV_CMRUserGroup_RoleID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

