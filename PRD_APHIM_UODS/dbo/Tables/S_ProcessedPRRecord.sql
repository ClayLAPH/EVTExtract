CREATE TABLE [dbo].[S_ProcessedPRRecord] (
    [ID]                              INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ReportedByNamespace]             VARCHAR (20)   NULL,
    [NamespaceCode_ID]                INT            NULL,
    [ImportOptionCode_ID]             INT            NULL,
    [DemographicImportOptionsCode_ID] INT            NULL,
    [StagePerson_ID]                  INT            NULL,
    [StageRecord_ID]                  INT            NULL,
    [StageInstanceID]                 INT            NULL,
    [StagePersonLastName]             VARCHAR (255)  NULL,
    [StagePersonFirstName]            VARCHAR (255)  NULL,
    [StageDiseaseDR]                  INT            NULL,
    [StageDateCreated]                DATETIME       NULL,
    [OriginalLivePerson_ID]           INT            NULL,
    [OriginalLivePersonRoot_ID]       INT            NULL,
    [OriginalLiveRecord_ID]           INT            NULL,
    [StatusCode]                      VARCHAR (50)   NOT NULL,
    [DateProcessed]                   DATETIME       NULL,
    [ImportedByUserDr]                INT            NULL,
    [CurrentLiveRecord_ID]            INT            NULL,
    [MultipleIdentityIDs]             VARCHAR (MAX)  NULL,
    [MultipleAddressIDs]              VARCHAR (MAX)  NULL,
    [HistoricalData]                  NVARCHAR (MAX) NULL,
    [RoutingRules]                    NVARCHAR (MAX) NULL,
    CONSTRAINT [S_ProcessedPRRecord_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95) ON [PRIMARY_IDX],
    CONSTRAINT [CK_S_ProcessedPRRecord_StatusCode] CHECK ([StatusCode]='Terminated' OR [StatusCode]='Unmerged' OR [StatusCode]='Merged' OR [StatusCode]='Active'),
    CONSTRAINT [FK_S_ProcessedPRRecord_CurrentLiveRecord_ID_A_Act] FOREIGN KEY ([CurrentLiveRecord_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_S_ProcessedPRRecord_DemographicImportOptionsCode_ID_V_UnifiedCodeSet] FOREIGN KEY ([DemographicImportOptionsCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_S_ProcessedPRRecord_ImportedByUserDr_E_Entity] FOREIGN KEY ([ImportedByUserDr]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_S_ProcessedPRRecord_ImportOptionCode_ID_V_UnifiedCodeSet] FOREIGN KEY ([ImportOptionCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_S_ProcessedPRRecord_NamespaceCode_ID_V_UnifiedCodeSet] FOREIGN KEY ([NamespaceCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_S_ProcessedPRRecord_OriginalLivePerson_ID_E_Entity] FOREIGN KEY ([OriginalLivePerson_ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_S_ProcessedPRRecord_OriginalLivePersonRoot_ID_E_Entity] FOREIGN KEY ([OriginalLivePersonRoot_ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_S_ProcessedPRRecord_OriginalLiveRecord_ID_A_Act] FOREIGN KEY ([OriginalLiveRecord_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_S_ProcessedPRRecord_StageDiseaseDR_V_UnifiedCodeSet] FOREIGN KEY ([StageDiseaseDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_S_ProcessedPRRecord_StagePerson_ID_E_Entity] FOREIGN KEY ([StagePerson_ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_S_ProcessedPRRecord_StageRecord_ID_A_Act] FOREIGN KEY ([StageRecord_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION
) ON [PRIMARY_IDX] TEXTIMAGE_ON [PRIMARY_IDX];


GO
ALTER TABLE [dbo].[S_ProcessedPRRecord] NOCHECK CONSTRAINT [FK_S_ProcessedPRRecord_CurrentLiveRecord_ID_A_Act];


GO
ALTER TABLE [dbo].[S_ProcessedPRRecord] NOCHECK CONSTRAINT [FK_S_ProcessedPRRecord_DemographicImportOptionsCode_ID_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[S_ProcessedPRRecord] NOCHECK CONSTRAINT [FK_S_ProcessedPRRecord_ImportedByUserDr_E_Entity];


GO
ALTER TABLE [dbo].[S_ProcessedPRRecord] NOCHECK CONSTRAINT [FK_S_ProcessedPRRecord_ImportOptionCode_ID_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[S_ProcessedPRRecord] NOCHECK CONSTRAINT [FK_S_ProcessedPRRecord_NamespaceCode_ID_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[S_ProcessedPRRecord] NOCHECK CONSTRAINT [FK_S_ProcessedPRRecord_OriginalLivePerson_ID_E_Entity];


GO
ALTER TABLE [dbo].[S_ProcessedPRRecord] NOCHECK CONSTRAINT [FK_S_ProcessedPRRecord_OriginalLivePersonRoot_ID_E_Entity];


GO
ALTER TABLE [dbo].[S_ProcessedPRRecord] NOCHECK CONSTRAINT [FK_S_ProcessedPRRecord_OriginalLiveRecord_ID_A_Act];


GO
ALTER TABLE [dbo].[S_ProcessedPRRecord] NOCHECK CONSTRAINT [FK_S_ProcessedPRRecord_StageDiseaseDR_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[S_ProcessedPRRecord] NOCHECK CONSTRAINT [FK_S_ProcessedPRRecord_StagePerson_ID_E_Entity];


GO
ALTER TABLE [dbo].[S_ProcessedPRRecord] NOCHECK CONSTRAINT [FK_S_ProcessedPRRecord_StageRecord_ID_A_Act];


GO
CREATE NONCLUSTERED INDEX [IX_S_ProcessedPRRecord_OrgLivePerID]
    ON [dbo].[S_ProcessedPRRecord]([OriginalLivePerson_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
ALTER INDEX [IX_S_ProcessedPRRecord_OrgLivePerID]
    ON [dbo].[S_ProcessedPRRecord] DISABLE;


GO
CREATE NONCLUSTERED INDEX [IX_S_ProcessedPRRecord_StatusCode_StageInstanceID]
    ON [dbo].[S_ProcessedPRRecord]([StatusCode] ASC, [StageInstanceID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
ALTER INDEX [IX_S_ProcessedPRRecord_StatusCode_StageInstanceID]
    ON [dbo].[S_ProcessedPRRecord] DISABLE;


GO
CREATE NONCLUSTERED INDEX [IX_S_ProcessedPRRecord_OrgLivePecID]
    ON [dbo].[S_ProcessedPRRecord]([OriginalLiveRecord_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_S_ProcessedPRRecord_StagePerID]
    ON [dbo].[S_ProcessedPRRecord]([StagePerson_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_S_ProcessedPRRecord_StageRecID_StatusCode]
    ON [dbo].[S_ProcessedPRRecord]([StageRecord_ID] ASC, [StatusCode] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_S_ProcessedPRRecord_DateProcessed_StatusCode]
    ON [dbo].[S_ProcessedPRRecord]([DateProcessed] ASC, [StatusCode] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
ALTER INDEX [IX_S_ProcessedPRRecord_DateProcessed_StatusCode]
    ON [dbo].[S_ProcessedPRRecord] DISABLE;


GO
CREATE NONCLUSTERED INDEX [IX_S_ProcessedPRRecord_DateCreated_Statuscode]
    ON [dbo].[S_ProcessedPRRecord]([StageDateCreated] ASC, [StatusCode] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_S_ProcessedPRRecord_CurrLiveRecordID]
    ON [dbo].[S_ProcessedPRRecord]([CurrentLiveRecord_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_S_ProcessedPRRecord_Disease]
    ON [dbo].[S_ProcessedPRRecord]([StageDiseaseDR] ASC, [StageInstanceID] DESC, [StatusCode] ASC)
    INCLUDE([DateProcessed], [ID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

