CREATE TABLE [dbo].[VCP_ArnoldGroup] (
    [EventInstanceCount]   INT NULL,
    [DiseaseGroupCode_ID]  INT NULL,
    [DistrictGroupCode_ID] INT NULL,
    [MessageCode_ID]       INT NULL,
    [SubjCode_ID]          INT NULL,
    [TypeCode_ID]          INT NULL,
    [ID]                   INT IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [GRP_FromAge]          INT NULL,
    [GRP_ToAge]            INT NULL,
    [GRP_GenderDR]         INT NULL,
    [GRP_CurrentAge]       BIT NULL,
    CONSTRAINT [VCP_ArnoldGroup_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [FK_A_VCP_ArnoldGroup_DiseaseGroupCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DiseaseGroupCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_ArnoldGroup_DistrictGroupCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DistrictGroupCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_ArnoldGroup_MessageCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([MessageCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_ArnoldGroup_SubjCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([SubjCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_ArnoldGroup_TypeCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([TypeCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_VCP_ArnoldGroup_GRP_GenderDR_ID_V_UnifiedCodeSet] FOREIGN KEY ([GRP_GenderDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[VCP_ArnoldGroup] NOCHECK CONSTRAINT [FK_A_VCP_ArnoldGroup_DiseaseGroupCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_ArnoldGroup] NOCHECK CONSTRAINT [FK_A_VCP_ArnoldGroup_DistrictGroupCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_ArnoldGroup] NOCHECK CONSTRAINT [FK_A_VCP_ArnoldGroup_MessageCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_ArnoldGroup] NOCHECK CONSTRAINT [FK_A_VCP_ArnoldGroup_SubjCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_ArnoldGroup] NOCHECK CONSTRAINT [FK_A_VCP_ArnoldGroup_TypeCode_ID_V_UNIFIEDCODESET];


GO
CREATE NONCLUSTERED INDEX [IX_VCP_ArnoldGroup_SubjCode_SubjCvDo]
    ON [dbo].[VCP_ArnoldGroup]([SubjCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

