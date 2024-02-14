CREATE TABLE [dbo].[DV_Outbreak] (
    [DVOB_OutbreakID]              INT          NOT NULL,
    [DVOB_OutbreakNumber]          VARCHAR (50) NOT NULL,
    [DVOB_CreateDate]              DATETIME     NOT NULL,
    [DVOB_OnsetDate]               DATETIME     NULL,
    [DVOB_ClosedDate]              DATETIME     NULL,
    [DVOB_DateSubmitted]           DATETIME     NULL,
    [DVOB_DiseaseCode_ID]          INT          NULL,
    [DVOB_DistrictCode_ID]         INT          NULL,
    [DVOB_HealthFacilityCode_ID]   INT          NULL,
    [DVOB_OutbreakTypeCode_ID]     INT          NULL,
    [DVOB_ProcessStatusCode_ID]    INT          NULL,
    [DVOB_ResolutionStatusCode_ID] INT          NULL,
    [DVOB_LocationDR]              INT          NULL,
    [DVOB_NurseInvestigatorDR]     INT          NULL,
    [DVOB_RowID]                   INT          NOT NULL,
    [DVOB_UserDR]                  INT          NULL,
    [DVOB_PriorityDR]              INT          NULL,
    CONSTRAINT [Outbreak_PK] PRIMARY KEY NONCLUSTERED ([DVOB_RowID] ASC) WITH (FILLFACTOR = 70) ON [PRIMARY_IDX],
    CONSTRAINT [FK_A_DV_Outbreak_DVOB_DiseaseCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVOB_DiseaseCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_Outbreak_DVOB_DistrictCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVOB_DistrictCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_Outbreak_DVOB_HealthFacilityCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVOB_HealthFacilityCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_Outbreak_DVOB_OutbreakTypeCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVOB_OutbreakTypeCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_Outbreak_DVOB_PriorityDR_V_UNIFIEDCODESET] FOREIGN KEY ([DVOB_PriorityDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_Outbreak_DVOB_ProcessStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVOB_ProcessStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_Outbreak_DVOB_ResolutionStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVOB_ResolutionStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK1_DV_Outbreak_A_Act] FOREIGN KEY ([DVOB_RowID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK11_DV_Outbreak_E_Entity] FOREIGN KEY ([DVOB_NurseInvestigatorDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK2_DV_Outbreak_E_Entity] FOREIGN KEY ([DVOB_UserDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK3_DV_Outbreak_E_Entity] FOREIGN KEY ([DVOB_LocationDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[DV_Outbreak] NOCHECK CONSTRAINT [FK_A_DV_Outbreak_DVOB_DiseaseCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Outbreak] NOCHECK CONSTRAINT [FK_A_DV_Outbreak_DVOB_DistrictCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Outbreak] NOCHECK CONSTRAINT [FK_A_DV_Outbreak_DVOB_HealthFacilityCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Outbreak] NOCHECK CONSTRAINT [FK_A_DV_Outbreak_DVOB_OutbreakTypeCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Outbreak] NOCHECK CONSTRAINT [FK_A_DV_Outbreak_DVOB_PriorityDR_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Outbreak] NOCHECK CONSTRAINT [FK_A_DV_Outbreak_DVOB_ProcessStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Outbreak] NOCHECK CONSTRAINT [FK_A_DV_Outbreak_DVOB_ResolutionStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Outbreak] NOCHECK CONSTRAINT [FK1_DV_Outbreak_A_Act];


GO
ALTER TABLE [dbo].[DV_Outbreak] NOCHECK CONSTRAINT [FK11_DV_Outbreak_E_Entity];


GO
ALTER TABLE [dbo].[DV_Outbreak] NOCHECK CONSTRAINT [FK2_DV_Outbreak_E_Entity];


GO
ALTER TABLE [dbo].[DV_Outbreak] NOCHECK CONSTRAINT [FK3_DV_Outbreak_E_Entity];


GO
ALTER TABLE [dbo].[DV_Outbreak] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_DV_Outbreak]
    ON [dbo].[DV_Outbreak]([DVOB_OutbreakID] ASC, [DVOB_DiseaseCode_ID] ASC, [DVOB_DistrictCode_ID] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Outbreak_1]
    ON [dbo].[DV_Outbreak]([DVOB_OutbreakNumber] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Outbreak_10]
    ON [dbo].[DV_Outbreak]([DVOB_HealthFacilityCode_ID] ASC, [DVOB_CreateDate] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Outbreak_11]
    ON [dbo].[DV_Outbreak]([DVOB_HealthFacilityCode_ID] ASC, [DVOB_OnsetDate] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Outbreak_12]
    ON [dbo].[DV_Outbreak]([DVOB_OutbreakID] ASC, [DVOB_DistrictCode_ID] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Outbreak_2]
    ON [dbo].[DV_Outbreak]([DVOB_CreateDate] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Outbreak_3]
    ON [dbo].[DV_Outbreak]([DVOB_OnsetDate] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Outbreak_4]
    ON [dbo].[DV_Outbreak]([DVOB_UserDR] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Outbreak_5]
    ON [dbo].[DV_Outbreak]([DVOB_LocationDR] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Outbreak_6]
    ON [dbo].[DV_Outbreak]([DVOB_DiseaseCode_ID] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Outbreak_8]
    ON [dbo].[DV_Outbreak]([DVOB_HealthFacilityCode_ID] ASC, [DVOB_DiseaseCode_ID] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Outbreak_9]
    ON [dbo].[DV_Outbreak]([DVOB_DistrictCode_ID] ASC, [DVOB_OutbreakID] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Outbreak_DVOB_PriorityDR]
    ON [dbo].[DV_Outbreak]([DVOB_PriorityDR] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE STATISTICS [IX_WA_DVOB_DiseaseCode_ID]
    ON [dbo].[DV_Outbreak]([DVOB_DiseaseCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVOB_DistrictCode_ID]
    ON [dbo].[DV_Outbreak]([DVOB_DistrictCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVOB_OutbreakTypeCode_ID]
    ON [dbo].[DV_Outbreak]([DVOB_OutbreakTypeCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVOB_ProcessStatusCode_ID]
    ON [dbo].[DV_Outbreak]([DVOB_ProcessStatusCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVOB_ClosedDate]
    ON [dbo].[DV_Outbreak]([DVOB_ClosedDate]);

