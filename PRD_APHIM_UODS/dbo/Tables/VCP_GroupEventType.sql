CREATE TABLE [dbo].[VCP_GroupEventType] (
    [ID]                                      INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [subjCode_Id]                             INT            NULL,
    [TaskListDR]                              INT            NULL,
    [WorkFlowDR]                              INT            NULL,
    [SupplementalTab1DR]                      INT            NULL,
    [SupplementalTab2DR]                      INT            NULL,
    [SupplementalTab3DR]                      INT            NULL,
    [ExcludeProcessStatusesFromCaseLoadForGE] VARCHAR (8000) NULL,
    CONSTRAINT [VCP_GroupEventType_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_VCP_GroupEventType_subjCode_Id_V_UnifiedCodeSet] FOREIGN KEY ([subjCode_Id]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_VCP_GroupEventType_SupplementalTab1DR_V_UnifiedCodeSet] FOREIGN KEY ([SupplementalTab1DR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_VCP_GroupEventType_SupplementalTab2DR_V_UnifiedCodeSet] FOREIGN KEY ([SupplementalTab2DR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_VCP_GroupEventType_SupplementalTab3DR_V_UnifiedCodeSet] FOREIGN KEY ([SupplementalTab3DR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_VCP_GroupEventType_TaskListDR_V_UnifiedCodeSet] FOREIGN KEY ([TaskListDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_VCP_GroupEventType_WorkFlowDR_V_UnifiedCodeSet] FOREIGN KEY ([WorkFlowDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[VCP_GroupEventType] NOCHECK CONSTRAINT [FK_VCP_GroupEventType_subjCode_Id_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[VCP_GroupEventType] NOCHECK CONSTRAINT [FK_VCP_GroupEventType_SupplementalTab1DR_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[VCP_GroupEventType] NOCHECK CONSTRAINT [FK_VCP_GroupEventType_SupplementalTab3DR_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[VCP_GroupEventType] NOCHECK CONSTRAINT [FK_VCP_GroupEventType_TaskListDR_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[VCP_GroupEventType] NOCHECK CONSTRAINT [FK_VCP_GroupEventType_WorkFlowDR_V_UnifiedCodeSet];


GO
CREATE NONCLUSTERED INDEX [IX_VCP_GroupEventType_subjCode_ID]
    ON [dbo].[VCP_GroupEventType]([subjCode_Id] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

