CREATE TABLE [dbo].[DV_PHDeletedPersonalRecord] (
    [DVPR_IncidentID]                INT            NOT NULL,
    [DVPR_CMRID]                     VARCHAR (50)   NOT NULL,
    [DVPR_MRN]                       VARCHAR (50)   NULL,
    [DVPR_CreateDate]                DATETIME       NOT NULL,
    [DVPR_OnsetDate]                 DATETIME       NULL,
    [DVPR_EpisodeDate]               DATETIME       NULL,
    [DVPR_ClosedDate]                DATETIME       NULL,
    [DVPR_DateReportedBy]            DATETIME       NULL,
    [DVPR_StandardAge]               REAL           NULL,
    [DVPR_DateSubmitted]             DATETIME       NULL,
    [DVPR_IsIndexCase]               BIT            NULL,
    [DVPR_ClusterID]                 VARCHAR (8000) NULL,
    [DVPR_DiagnosisDate]             DATETIME       NULL,
    [DVPR_DiagSpecimenTypes]         VARCHAR (8000) NULL,
    [DVPR_ExpExposureTypes]          VARCHAR (3000) NULL,
    [DVPR_HepatitisDRs]              VARCHAR (1500) NULL,
    [DVPR_DiseaseCode_ID]            INT            NULL,
    [DVPR_DistrictCode_ID]           INT            NULL,
    [DVPR_OriginalDistrictCode_ID]   INT            NULL,
    [DVPR_ProcessStatusCode_ID]      INT            NULL,
    [DVPR_ResolutionStatusCode_ID]   INT            NULL,
    [DVPR_SecondaryDistrictCode_ID]  INT            NULL,
    [DVPR_TransmissionStatusCode_ID] INT            NULL,
    [DVPR_NurseInvestigatorDR]       INT            NULL,
    [DVPR_PersonDR]                  INT            NULL,
    [DVPR_ReportSourceDR]            INT            NULL,
    [DVPR_RowID]                     INT            NOT NULL,
    [DVPR_UserDR]                    INT            NULL,
    [DVPR_TypeDR]                    INT            NULL,
    [DVPR_OutbreakDRsText]           VARCHAR (MAX)  NULL,
    [DVPR_OutbreakNumbers]           VARCHAR (MAX)  NULL,
    [DVPR_OutbreakTypes]             VARCHAR (MAX)  NULL,
    [DVPR_ReceivedDate]              DATETIME       NULL,
    [DVPR_LABSpecimenCollectedDate]  DATETIME       NULL,
    [DVPR_ISPREGNANT]                BIT            NULL,
    CONSTRAINT [PHDPR_DiseaseIncident_PK] PRIMARY KEY NONCLUSTERED ([DVPR_RowID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [FK_A_DV_PHDeletedPersonalRecord_DVPR_DiseaseCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPR_DiseaseCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_PHDeletedPersonalRecord_DVPR_DistrictCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPR_DistrictCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_PHDeletedPersonalRecord_DVPR_OriginalDistrictCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPR_OriginalDistrictCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_PHDeletedPersonalRecord_DVPR_ProcessStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPR_ProcessStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_PHDeletedPersonalRecord_DVPR_ResolutionStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPR_ResolutionStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_PHDeletedPersonalRecord_DVPR_SecondaryDistrictCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPR_SecondaryDistrictCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_PHDeletedPersonalRecord_DVPR_TransmissionStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPR_TransmissionStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_PHDeletedPersonalRecord_TypeDR_ID_V_UnifiedCodeSet] FOREIGN KEY ([DVPR_TypeDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DV_PHDeletedPersonalRecord_DV_Person] FOREIGN KEY ([DVPR_PersonDR]) REFERENCES [dbo].[DV_Person] ([DVPER_RowID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DV_PHDeletedPersonalRecord_PHCase] FOREIGN KEY ([DVPR_RowID]) REFERENCES [dbo].[A_PublicHealthCase] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK1_DV_PHDeletedPersonalRecord_A_Act] FOREIGN KEY ([DVPR_RowID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK12_DV_PHDeletedPersonalRecord_E_Entity] FOREIGN KEY ([DVPR_NurseInvestigatorDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK2_DV_PHDeletedPersonalRecord_E_Entity] FOREIGN KEY ([DVPR_PersonDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK6_DV_PHDeletedPersonalRecord_E_Entity] FOREIGN KEY ([DVPR_ReportSourceDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK7_DV_PHDeletedPersonalRecord_E_Entity] FOREIGN KEY ([DVPR_UserDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[DV_PHDeletedPersonalRecord] NOCHECK CONSTRAINT [FK_A_DV_PHDeletedPersonalRecord_DVPR_DiseaseCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_PHDeletedPersonalRecord] NOCHECK CONSTRAINT [FK_A_DV_PHDeletedPersonalRecord_DVPR_DistrictCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_PHDeletedPersonalRecord] NOCHECK CONSTRAINT [FK_A_DV_PHDeletedPersonalRecord_DVPR_OriginalDistrictCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_PHDeletedPersonalRecord] NOCHECK CONSTRAINT [FK_A_DV_PHDeletedPersonalRecord_DVPR_ProcessStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_PHDeletedPersonalRecord] NOCHECK CONSTRAINT [FK_A_DV_PHDeletedPersonalRecord_DVPR_ResolutionStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_PHDeletedPersonalRecord] NOCHECK CONSTRAINT [FK_A_DV_PHDeletedPersonalRecord_DVPR_SecondaryDistrictCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_PHDeletedPersonalRecord] NOCHECK CONSTRAINT [FK_A_DV_PHDeletedPersonalRecord_DVPR_TransmissionStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_PHDeletedPersonalRecord] NOCHECK CONSTRAINT [FK_A_DV_PHDeletedPersonalRecord_TypeDR_ID_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[DV_PHDeletedPersonalRecord] NOCHECK CONSTRAINT [FK_DV_PHDeletedPersonalRecord_DV_Person];


GO
ALTER TABLE [dbo].[DV_PHDeletedPersonalRecord] NOCHECK CONSTRAINT [FK_DV_PHDeletedPersonalRecord_PHCase];


GO
ALTER TABLE [dbo].[DV_PHDeletedPersonalRecord] NOCHECK CONSTRAINT [FK1_DV_PHDeletedPersonalRecord_A_Act];


GO
ALTER TABLE [dbo].[DV_PHDeletedPersonalRecord] NOCHECK CONSTRAINT [FK12_DV_PHDeletedPersonalRecord_E_Entity];


GO
ALTER TABLE [dbo].[DV_PHDeletedPersonalRecord] NOCHECK CONSTRAINT [FK2_DV_PHDeletedPersonalRecord_E_Entity];


GO
ALTER TABLE [dbo].[DV_PHDeletedPersonalRecord] NOCHECK CONSTRAINT [FK6_DV_PHDeletedPersonalRecord_E_Entity];


GO
ALTER TABLE [dbo].[DV_PHDeletedPersonalRecord] NOCHECK CONSTRAINT [FK7_DV_PHDeletedPersonalRecord_E_Entity];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_IncidentID] DESC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_1]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_CMRID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_10]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_CreateDate] ASC, [DVPR_DiseaseCode_ID] ASC, [DVPR_ResolutionStatusCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_11]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_ClosedDate] ASC, [DVPR_NurseInvestigatorDR] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_2]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_MRN] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_3]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_PersonDR] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_4]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_UserDR] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_5]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_DiseaseCode_ID] ASC, [DVPR_DistrictCode_ID] ASC, [DVPR_ProcessStatusCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_6]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_DistrictCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_7]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_ProcessStatusCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_8]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_NurseInvestigatorDR] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_9]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_OnsetDate] DESC, [DVPR_RowID] DESC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_PHDeletedPersonalRecordIncidentID]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_IncidentID] ASC, [DVPR_DiseaseCode_ID] ASC, [DVPR_PersonDR] ASC, [DVPR_RowID] ASC) WITH (FILLFACTOR = 70);


GO
CREATE NONCLUSTERED INDEX [IX_DV_PHDeletedPersonalRecord_12]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_ReceivedDate] ASC) WITH (FILLFACTOR = 70);


GO
CREATE NONCLUSTERED INDEX [IX_DV_PHDeletedPersonalRecord_13]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_LABSpecimenCollectedDate] ASC) WITH (FILLFACTOR = 70);


GO
CREATE STATISTICS [IX_WA_DVDI_ClosedDate]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_ClosedDate]);


GO
CREATE STATISTICS [IX_WA_DVDI_DateReportedBy]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_DateReportedBy]);


GO
CREATE STATISTICS [IX_WA_DVDI_DateSubmitted]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_DateSubmitted]);


GO
CREATE STATISTICS [IX_WA_DVDI_DiseaseCode_ID]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_DiseaseCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVDI_DistrictCode_ID]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_DistrictCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVDI_EpisodeDate]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_EpisodeDate]);


GO
CREATE STATISTICS [IX_WA_DVDI_NurseInvestigatorDR]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_NurseInvestigatorDR]);


GO
CREATE STATISTICS [IX_WA_DVDI_ProcessStatusCode_ID]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_ProcessStatusCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVDI_ReportSourceDR]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_ReportSourceDR]);


GO
CREATE STATISTICS [IX_WA_DVDI_ResolutionStatusCode_ID]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_ResolutionStatusCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVDI_StandardAge]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_StandardAge]);


GO
CREATE STATISTICS [IX_WA_SYS_DVDI_DiseaseCode_ID]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_DiseaseCode_ID]);


GO
CREATE STATISTICS [IX_WA_SYS_DVDI_DistrictCode_ID]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_DistrictCode_ID]);


GO
CREATE STATISTICS [IX_WA_SYS_DVDI_ProcessStatusCode_ID]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_ProcessStatusCode_ID]);


GO
CREATE STATISTICS [IX_WA_SYS_DVDI_ReportSourceDR]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_ReportSourceDR]);


GO
CREATE STATISTICS [IX_WA_SYS_DVDI_ResolutionStatusCode_ID]
    ON [dbo].[DV_PHDeletedPersonalRecord]([DVPR_ResolutionStatusCode_ID]);

