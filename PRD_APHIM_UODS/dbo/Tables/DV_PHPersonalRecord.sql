CREATE TABLE [dbo].[DV_PHPersonalRecord] (
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
    [DVPR_NameOfSubmitter]           VARCHAR (100)  NULL,
    [DVPR_ImportedStatus]            INT            NULL,
    [DVPR_FinalDisposition]          INT            NULL,
    [DVPR_OutPatient]                BIT            NULL,
    [DVPR_InPatient]                 BIT            NULL,
    [DVPR_LIPRESULTVALUE]            VARCHAR (8000) NULL,
    [DVPR_LIPTESTORDERED]            VARCHAR (255)  NULL,
    [DVPR_TypeOfContactDR]           INT            NULL,
    [DVPR_PriorityDR]                INT            NULL,
    [DVPR_ReportedbyWeb]             BIT            NULL,
    [DVPR_ProviderName]              VARCHAR (255)  NULL,
    [DVPR_ReportedByLab]             BIT            NULL,
    [DVPR_ReportedByEHR]             BIT            NULL,
    [DVPR_OtherDiseaseName]          VARCHAR (200)  NULL,
    [DVPR_DATEOFDEATH]               DATETIME       NULL,
    [DVPR_ISPREGNANT]                BIT            NULL,
    [DVPR_EXPECTEDDELIVERYDATE]      DATETIME       NULL,
    [DVPR_LIPRESULTNOTES]            VARCHAR (8000) NULL,
    [DVPR_ISPATIENTDIEDOFTHEILLNESS] BIT            NULL,
    [DVPR_DateSent]                  DATETIME       NULL,
    [DVPR_DateLastUpdateSent]        DATETIME       NULL,
    [DVPR_LIPRESULTNAME]             VARCHAR (255)  NULL,
    [DVPR_ISASYMPTOMATIC]            BIT            NULL,
    [DVPR_LABSpecimenResultDate]     DATETIME       NULL,
    [DVPR_DateAdmitted]              DATETIME       NULL,
    [DVPR_DateDischarged]            DATETIME       NULL,
    [DVPR_DateLastEdited]            DATETIME       NULL,
    [DVPR_Notes]                     VARCHAR (MAX)  NULL,
    [DVPR_DateInvestigatorReceived]  DATETIME       NULL,
    [DVPR_IsPatientHospitalized]     BIT            NULL,
    CONSTRAINT [DiseaseIncident_PK] PRIMARY KEY NONCLUSTERED ([DVPR_RowID] ASC) WITH (FILLFACTOR = 70) ON [PRIMARY_IDX],
    CONSTRAINT [FK_A_DV_PHPersonalRecord_DVPR_DiseaseCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPR_DiseaseCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_PHPersonalRecord_DVPR_DistrictCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPR_DistrictCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_PHPersonalRecord_DVPR_OriginalDistrictCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPR_OriginalDistrictCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_PHPersonalRecord_DVPR_ProcessStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPR_ProcessStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_PHPersonalRecord_DVPR_ResolutionStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPR_ResolutionStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_PHPersonalRecord_DVPR_SecondaryDistrictCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPR_SecondaryDistrictCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_PHPersonalRecord_DVPR_TransmissionStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPR_TransmissionStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_PHPersonalRecord_TypeDR_ID_V_UnifiedCodeSet] FOREIGN KEY ([DVPR_TypeDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DV_PHPersonalRecord_DV_Person] FOREIGN KEY ([DVPR_PersonDR]) REFERENCES [dbo].[DV_Person] ([DVPER_RowID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DV_PHPersonalRecord_PHCase] FOREIGN KEY ([DVPR_RowID]) REFERENCES [dbo].[A_PublicHealthCase] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK1_DV_PHPersonalRecord_A_Act] FOREIGN KEY ([DVPR_RowID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK12_DV_PHPersonalRecord_E_Entity] FOREIGN KEY ([DVPR_NurseInvestigatorDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK2_DV_PHPersonalRecord_E_Entity] FOREIGN KEY ([DVPR_PersonDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK6_DV_PHPersonalRecord_E_Entity] FOREIGN KEY ([DVPR_ReportSourceDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK7_DV_PHPersonalRecord_E_Entity] FOREIGN KEY ([DVPR_UserDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION
) ON [PRIMARY_IDX];


GO
ALTER TABLE [dbo].[DV_PHPersonalRecord] NOCHECK CONSTRAINT [FK_A_DV_PHPersonalRecord_DVPR_DiseaseCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_PHPersonalRecord] NOCHECK CONSTRAINT [FK_A_DV_PHPersonalRecord_DVPR_DistrictCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_PHPersonalRecord] NOCHECK CONSTRAINT [FK_A_DV_PHPersonalRecord_DVPR_OriginalDistrictCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_PHPersonalRecord] NOCHECK CONSTRAINT [FK_A_DV_PHPersonalRecord_DVPR_ProcessStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_PHPersonalRecord] NOCHECK CONSTRAINT [FK_A_DV_PHPersonalRecord_DVPR_ResolutionStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_PHPersonalRecord] NOCHECK CONSTRAINT [FK_A_DV_PHPersonalRecord_DVPR_SecondaryDistrictCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_PHPersonalRecord] NOCHECK CONSTRAINT [FK_A_DV_PHPersonalRecord_DVPR_TransmissionStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_PHPersonalRecord] NOCHECK CONSTRAINT [FK_A_DV_PHPersonalRecord_TypeDR_ID_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[DV_PHPersonalRecord] NOCHECK CONSTRAINT [FK_DV_PHPersonalRecord_DV_Person];


GO
ALTER TABLE [dbo].[DV_PHPersonalRecord] NOCHECK CONSTRAINT [FK_DV_PHPersonalRecord_PHCase];


GO
ALTER TABLE [dbo].[DV_PHPersonalRecord] NOCHECK CONSTRAINT [FK1_DV_PHPersonalRecord_A_Act];


GO
ALTER TABLE [dbo].[DV_PHPersonalRecord] NOCHECK CONSTRAINT [FK12_DV_PHPersonalRecord_E_Entity];


GO
ALTER TABLE [dbo].[DV_PHPersonalRecord] NOCHECK CONSTRAINT [FK2_DV_PHPersonalRecord_E_Entity];


GO
ALTER TABLE [dbo].[DV_PHPersonalRecord] NOCHECK CONSTRAINT [FK6_DV_PHPersonalRecord_E_Entity];


GO
ALTER TABLE [dbo].[DV_PHPersonalRecord] NOCHECK CONSTRAINT [FK7_DV_PHPersonalRecord_E_Entity];


GO
ALTER TABLE [dbo].[DV_PHPersonalRecord] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE UNIQUE CLUSTERED INDEX [IX_DV_PHPersonalRecord_RowID]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_RowID] ASC) WITH (FILLFACTOR = 95)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_IncidentID] ASC, [DVPR_DiseaseCode_ID] ASC, [DVPR_DistrictCode_ID] ASC, [DVPR_ProcessStatusCode_ID] ASC)
    INCLUDE([DVPR_CreateDate], [DVPR_PersonDR], [DVPR_OriginalDistrictCode_ID], [DVPR_SecondaryDistrictCode_ID], [DVPR_ReportSourceDR]) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_1]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_CMRID] ASC, [DVPR_DiseaseCode_ID] ASC, [DVPR_DistrictCode_ID] ASC, [DVPR_ProcessStatusCode_ID] ASC)
    INCLUDE([DVPR_OriginalDistrictCode_ID], [DVPR_SecondaryDistrictCode_ID], [DVPR_PersonDR]) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_10]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_CreateDate] ASC, [DVPR_DiseaseCode_ID] ASC, [DVPR_DistrictCode_ID] ASC, [DVPR_ProcessStatusCode_ID] ASC)
    INCLUDE([DVPR_ResolutionStatusCode_ID], [DVPR_OriginalDistrictCode_ID], [DVPR_SecondaryDistrictCode_ID], [DVPR_PersonDR], [DVPR_ReportSourceDR]) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_11]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_ClosedDate] ASC, [DVPR_NurseInvestigatorDR] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_2]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_MRN] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_3]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_PersonDR] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_4]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_UserDR] ASC)
    INCLUDE([DVPR_IncidentID], [DVPR_PersonDR], [DVPR_CreateDate], [DVPR_OnsetDate], [DVPR_CMRID], [DVPR_DiseaseCode_ID]) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_5]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_DiseaseCode_ID] ASC, [DVPR_DistrictCode_ID] ASC, [DVPR_ProcessStatusCode_ID] ASC)
    INCLUDE([DVPR_IncidentID], [DVPR_CreateDate], [DVPR_PersonDR], [DVPR_RowID], [DVPR_LIPRESULTVALUE], [DVPR_LIPRESULTNAME], [DVPR_OriginalDistrictCode_ID], [DVPR_SecondaryDistrictCode_ID]) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_6]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_DistrictCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_7]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_ProcessStatusCode_ID] ASC, [DVPR_TypeDR] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_NurseInvestigator]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_NurseInvestigatorDR] ASC, [DVPR_TypeDR] ASC, [DVPR_CreateDate] ASC)
    INCLUDE([DVPR_RowID], [DVPR_PersonDR], [DVPR_UserDR], [DVPR_PriorityDR]) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_9]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_OnsetDate] DESC, [DVPR_DiseaseCode_ID] ASC, [DVPR_DistrictCode_ID] ASC, [DVPR_ProcessStatusCode_ID] ASC)
    INCLUDE([DVPR_OriginalDistrictCode_ID], [DVPR_SecondaryDistrictCode_ID], [DVPR_PersonDR], [DVPR_ReportSourceDR]) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_PHPersonalRecord_12]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_ReceivedDate] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY];


GO
CREATE NONCLUSTERED INDEX [IX_DV_PHPersonalRecord_13]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_LABSpecimenCollectedDate] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY];


GO
CREATE NONCLUSTERED INDEX [IX_DV_PHPersonalRecord_ReportSourceDR]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_ReportSourceDR] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_OriginalDistrict]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_OriginalDistrictCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DiseaseIncident_SecondaryDistrict]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_SecondaryDistrictCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_PHPersonalRecord_DateOfDeath]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_DATEOFDEATH] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY];


GO
CREATE NONCLUSTERED INDEX [IX_DV_PHPersonalRecord_PersonDR_DistrictCodeID_DiseaseCodeID_inc]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_PersonDR] ASC, [DVPR_DistrictCode_ID] ASC, [DVPR_DiseaseCode_ID] ASC)
    INCLUDE([DVPR_ProcessStatusCode_ID], [DVPR_ResolutionStatusCode_ID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [ix_PHPR_ForIU_JT]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_PersonDR] ASC)
    INCLUDE([DVPR_TypeDR], [DVPR_IncidentID], [DVPR_RowID], [DVPR_DiseaseCode_ID]) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE STATISTICS [IX_WA_DVDI_DiseaseCode_ID]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_DiseaseCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVDI_DistrictCode_ID]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_DistrictCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVDI_NurseInvestigatorDR]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_NurseInvestigatorDR]);


GO
CREATE STATISTICS [IX_WA_DVDI_ProcessStatusCode_ID]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_ProcessStatusCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVDI_ReportSourceDR]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_ReportSourceDR]);


GO
CREATE STATISTICS [IX_WA_DVDI_ResolutionStatusCode_ID]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_ResolutionStatusCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVDI_ClosedDate]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_ClosedDate]);


GO
CREATE STATISTICS [IX_WA_DVDI_DateReportedBy]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_DateReportedBy]);


GO
CREATE STATISTICS [IX_WA_DVDI_DateSubmitted]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_DateSubmitted]);


GO
CREATE STATISTICS [IX_WA_DVDI_EpisodeDate]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_EpisodeDate]);


GO
CREATE STATISTICS [IX_WA_DVDI_StandardAge]
    ON [dbo].[DV_PHPersonalRecord]([DVPR_StandardAge]);

