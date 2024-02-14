CREATE TABLE [dbo].[DV_AnimalReport] (
    [DVAI_AnimalReportID]          INT           NOT NULL,
    [DVAI_HumanLastName]           VARCHAR (100) NULL,
    [DVAI_HumanFirstName]          VARCHAR (100) NULL,
    [DVAI_CreateDate]              DATETIME      NOT NULL,
    [DVAI_AnimalTypeCode_ID]       INT           NULL,
    [DVAI_DiseaseCode_ID]          INT           NULL,
    [DVAI_ReportTypeCode_ID]       INT           NULL,
    [DVAI_SpeciesCode_ID]          INT           NULL,
    [DVAI_RowID]                   INT           NOT NULL,
    [DVAI_OnsetDate]               DATETIME      NULL,
    [DVAI_ClosedDate]              DATETIME      NULL,
    [DVAI_DiagnosisDate]           DATETIME      NULL,
    [DVAI_DistrictCode_ID]         INT           NULL,
    [DVAI_ProcessStatusCode_ID]    INT           NULL,
    [DVAI_NamespaceCode_ID]        INT           NULL,
    [DVAI_ResolutionStatusCode_ID] INT           NULL,
    [DVAI_NurseInvestigatorDR]     INT           NULL,
    [DVAI_UserDR]                  INT           NULL,
    [DVAI_ReportOrganizationDR]    INT           NULL,
    [DVAI_DiseaseIncidentDR]       INT           NULL,
    [DVAI_ContactInvestigationDR]  INT           NULL,
    [DVAI_OutbreakDR]              INT           NULL,
    CONSTRAINT [AnimalReport_PK] PRIMARY KEY NONCLUSTERED ([DVAI_RowID] ASC) WITH (FILLFACTOR = 70) ON [PRIMARY_IDX],
    CONSTRAINT [A_Act_DV_AnimalReport_FK1] FOREIGN KEY ([DVAI_RowID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_AnimalReport_DVAI_AnimalTypeCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVAI_AnimalTypeCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_AnimalReport_DVAI_ContactInvestigationDR_A_Act] FOREIGN KEY ([DVAI_ContactInvestigationDR]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_AnimalReport_DVAI_DiseaseCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVAI_DiseaseCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_AnimalReport_DVAI_DiseaseIncidentDR_A_Act] FOREIGN KEY ([DVAI_DiseaseIncidentDR]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_AnimalReport_DVAI_DistrictCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVAI_DistrictCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_AnimalReport_DVAI_NamespaceCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVAI_NamespaceCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_AnimalReport_DVAI_NurseInvestigatorDR_E_ENTITY] FOREIGN KEY ([DVAI_NurseInvestigatorDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_AnimalReport_DVAI_OutbreakDR_A_Act] FOREIGN KEY ([DVAI_OutbreakDR]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_AnimalReport_DVAI_ProcessStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVAI_ProcessStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_AnimalReport_DVAI_ReportOrganizationDR_E_ENTITY] FOREIGN KEY ([DVAI_ReportOrganizationDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_AnimalReport_DVAI_ReportTypeCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVAI_ReportTypeCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_AnimalReport_DVAI_ResolutionStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVAI_ResolutionStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_AnimalReport_DVAI_SpeciesCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVAI_SpeciesCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_AnimalReport_DVAI_UserDR_E_ENTITY] FOREIGN KEY ([DVAI_UserDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[DV_AnimalReport] NOCHECK CONSTRAINT [A_Act_DV_AnimalReport_FK1];


GO
ALTER TABLE [dbo].[DV_AnimalReport] NOCHECK CONSTRAINT [FK_A_DV_AnimalReport_DVAI_AnimalTypeCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_AnimalReport] NOCHECK CONSTRAINT [FK_A_DV_AnimalReport_DVAI_ContactInvestigationDR_A_Act];


GO
ALTER TABLE [dbo].[DV_AnimalReport] NOCHECK CONSTRAINT [FK_A_DV_AnimalReport_DVAI_DiseaseCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_AnimalReport] NOCHECK CONSTRAINT [FK_A_DV_AnimalReport_DVAI_DiseaseIncidentDR_A_Act];


GO
ALTER TABLE [dbo].[DV_AnimalReport] NOCHECK CONSTRAINT [FK_A_DV_AnimalReport_DVAI_DistrictCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_AnimalReport] NOCHECK CONSTRAINT [FK_A_DV_AnimalReport_DVAI_NamespaceCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_AnimalReport] NOCHECK CONSTRAINT [FK_A_DV_AnimalReport_DVAI_NurseInvestigatorDR_E_ENTITY];


GO
ALTER TABLE [dbo].[DV_AnimalReport] NOCHECK CONSTRAINT [FK_A_DV_AnimalReport_DVAI_OutbreakDR_A_Act];


GO
ALTER TABLE [dbo].[DV_AnimalReport] NOCHECK CONSTRAINT [FK_A_DV_AnimalReport_DVAI_ProcessStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_AnimalReport] NOCHECK CONSTRAINT [FK_A_DV_AnimalReport_DVAI_ReportOrganizationDR_E_ENTITY];


GO
ALTER TABLE [dbo].[DV_AnimalReport] NOCHECK CONSTRAINT [FK_A_DV_AnimalReport_DVAI_ReportTypeCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_AnimalReport] NOCHECK CONSTRAINT [FK_A_DV_AnimalReport_DVAI_ResolutionStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_AnimalReport] NOCHECK CONSTRAINT [FK_A_DV_AnimalReport_DVAI_SpeciesCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_AnimalReport] NOCHECK CONSTRAINT [FK_A_DV_AnimalReport_DVAI_UserDR_E_ENTITY];


GO
ALTER TABLE [dbo].[DV_AnimalReport] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_DV_AnimalReport_DiseaseCode_ID]
    ON [dbo].[DV_AnimalReport]([DVAI_DiseaseCode_ID] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_AnimalReport_AnimalTypeCode_ID]
    ON [dbo].[DV_AnimalReport]([DVAI_AnimalTypeCode_ID] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_AnimalReport_SpeciesCode_ID]
    ON [dbo].[DV_AnimalReport]([DVAI_SpeciesCode_ID] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_AnimalReport_ReportTypeCode_ID]
    ON [dbo].[DV_AnimalReport]([DVAI_ReportTypeCode_ID] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_AnimalReport_HumanLastName]
    ON [dbo].[DV_AnimalReport]([DVAI_HumanLastName] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_AnimalReport_CreateDate]
    ON [dbo].[DV_AnimalReport]([DVAI_CreateDate] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_AnimalReport_OnsetDate]
    ON [dbo].[DV_AnimalReport]([DVAI_OnsetDate] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_AnimalReport_ClosedDate]
    ON [dbo].[DV_AnimalReport]([DVAI_ClosedDate] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_AnimalReport_NamespaceCode_ID]
    ON [dbo].[DV_AnimalReport]([DVAI_NamespaceCode_ID] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_AnimalReport_DistrictCode_ID]
    ON [dbo].[DV_AnimalReport]([DVAI_DistrictCode_ID] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_AnimalReport_ProcessStatusCode_ID]
    ON [dbo].[DV_AnimalReport]([DVAI_ProcessStatusCode_ID] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_AnimalReport_NurseInvestigatorDR]
    ON [dbo].[DV_AnimalReport]([DVAI_NurseInvestigatorDR] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_AnimalReport_DiagnosisDate]
    ON [dbo].[DV_AnimalReport]([DVAI_DiagnosisDate] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];

