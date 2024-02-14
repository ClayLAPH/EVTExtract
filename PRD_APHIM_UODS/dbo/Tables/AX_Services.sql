CREATE TABLE [dbo].[AX_Services] (
    [SVC_ID]                      INT      NOT NULL,
    [SVC_InstanceID]              INT      IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SVC_PersonDR]                INT      NULL,
    [SVC_InitialServiceDR]        INT      NULL,
    [SVC_InitialDate]             DATETIME NULL,
    [SVC_CurrentServiceDR]        INT      NULL,
    [SVC_CurrentServiceDate]      DATETIME NULL,
    [SVC_StatusDR]                INT      NULL,
    [SVC_StatusChangeDate]        DATETIME NULL,
    [SVC_JurisdictionCode_ID]     INT      NULL,
    [SVC_CaseManagerDR]           INT      NULL,
    [SVC_CaseManagerDateAssigned] DATETIME NULL,
    [SVC_UserDR]                  INT      NULL,
    CONSTRAINT [PK_Ax_Services] PRIMARY KEY CLUSTERED ([SVC_ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [AX_Services_A_Act_FK1] FOREIGN KEY ([SVC_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [AX_Services_E_Entity_FK1] FOREIGN KEY ([SVC_PersonDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [AX_Services_E_Entity_FK2] FOREIGN KEY ([SVC_CaseManagerDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [AX_Services_E_Entity_FK3] FOREIGN KEY ([SVC_UserDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_AX_Services_V_UnifiedCodeSet_FK1] FOREIGN KEY ([SVC_InitialServiceDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_AX_Services_V_UnifiedCodeSet_FK2] FOREIGN KEY ([SVC_CurrentServiceDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_AX_Services_V_UnifiedCodeSet_FK3] FOREIGN KEY ([SVC_StatusDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_AX_Services_V_UnifiedCodeSet_FK4] FOREIGN KEY ([SVC_JurisdictionCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[AX_Services] NOCHECK CONSTRAINT [AX_Services_A_Act_FK1];


GO
ALTER TABLE [dbo].[AX_Services] NOCHECK CONSTRAINT [AX_Services_E_Entity_FK1];


GO
ALTER TABLE [dbo].[AX_Services] NOCHECK CONSTRAINT [AX_Services_E_Entity_FK2];


GO
ALTER TABLE [dbo].[AX_Services] NOCHECK CONSTRAINT [AX_Services_E_Entity_FK3];


GO
ALTER TABLE [dbo].[AX_Services] NOCHECK CONSTRAINT [FK_AX_Services_V_UnifiedCodeSet_FK1];


GO
ALTER TABLE [dbo].[AX_Services] NOCHECK CONSTRAINT [FK_AX_Services_V_UnifiedCodeSet_FK2];


GO
ALTER TABLE [dbo].[AX_Services] NOCHECK CONSTRAINT [FK_AX_Services_V_UnifiedCodeSet_FK3];


GO
ALTER TABLE [dbo].[AX_Services] NOCHECK CONSTRAINT [FK_AX_Services_V_UnifiedCodeSet_FK4];


GO
CREATE NONCLUSTERED INDEX [IX_AX_Services_PersonDR]
    ON [dbo].[AX_Services]([SVC_PersonDR] ASC)
    INCLUDE([SVC_ID]) WITH (FILLFACTOR = 70)
    ON [ACTS_IDX];

