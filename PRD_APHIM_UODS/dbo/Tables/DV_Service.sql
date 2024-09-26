CREATE TABLE [dbo].[DV_Service] (
    [DVSVC_InitialDate]             DATETIME NULL,
    [DVSVC_CurrentServiceCode_ID]   INT      NULL,
    [DVSVC_JurisdictionCode_ID]     INT      NULL,
    [DVSVC_StatusCode_ID]           INT      NULL,
    [DVSVC_CaseManager_FK]          INT      NULL,
    [DVSVC_Patient_FK]              INT      NULL,
    [DVSVC_RowID]                   INT      NOT NULL,
    [DVSVC_CaseManagerDateAssigned] DATETIME NULL,
    CONSTRAINT [PK_DV_Service] PRIMARY KEY NONCLUSTERED ([DVSVC_RowID] ASC) WITH (FILLFACTOR = 70) ON [PRIMARY_IDX],
    CONSTRAINT [FK_A_DV_Service_DVSVC_CurrentServiceCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVSVC_CurrentServiceCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_Service_DVSVC_JurisdictionCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVSVC_JurisdictionCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_Service_DVSVC_StatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVSVC_StatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DV_Service_DV_Person] FOREIGN KEY ([DVSVC_Patient_FK]) REFERENCES [dbo].[DV_Person] ([DVPER_RowID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DV_Service_PHCase] FOREIGN KEY ([DVSVC_RowID]) REFERENCES [dbo].[A_PublicHealthCase] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK1_DV_Service_A_Act] FOREIGN KEY ([DVSVC_RowID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK2_DV_Service_E_Entity] FOREIGN KEY ([DVSVC_Patient_FK]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK6_DV_Service_E_Entity] FOREIGN KEY ([DVSVC_CaseManager_FK]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[DV_Service] NOCHECK CONSTRAINT [FK_A_DV_Service_DVSVC_CurrentServiceCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Service] NOCHECK CONSTRAINT [FK_A_DV_Service_DVSVC_JurisdictionCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Service] NOCHECK CONSTRAINT [FK_A_DV_Service_DVSVC_StatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Service] NOCHECK CONSTRAINT [FK_DV_Service_DV_Person];


GO
ALTER TABLE [dbo].[DV_Service] NOCHECK CONSTRAINT [FK_DV_Service_PHCase];


GO
ALTER TABLE [dbo].[DV_Service] NOCHECK CONSTRAINT [FK1_DV_Service_A_Act];


GO
ALTER TABLE [dbo].[DV_Service] NOCHECK CONSTRAINT [FK2_DV_Service_E_Entity];


GO
ALTER TABLE [dbo].[DV_Service] NOCHECK CONSTRAINT [FK6_DV_Service_E_Entity];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Service]
    ON [dbo].[DV_Service]([DVSVC_CaseManager_FK] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Service_Patient_FK]
    ON [dbo].[DV_Service]([DVSVC_Patient_FK] ASC) WITH (FILLFACTOR = 70);


GO
CREATE STATISTICS [IX_WA_DVSVC_CurrentServiceCode_ID]
    ON [dbo].[DV_Service]([DVSVC_CurrentServiceCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVSVC_JurisdictionCode_ID]
    ON [dbo].[DV_Service]([DVSVC_JurisdictionCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVSVC_Patient_FK]
    ON [dbo].[DV_Service]([DVSVC_Patient_FK]);


GO
CREATE STATISTICS [IX_WA_DVSVC_StatusCode_ID]
    ON [dbo].[DV_Service]([DVSVC_StatusCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVSVC_InitialDate]
    ON [dbo].[DV_Service]([DVSVC_InitialDate]);

