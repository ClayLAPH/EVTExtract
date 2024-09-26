CREATE TABLE [dbo].[S_ThresholdAlert] (
    [TA_RowID]                    INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TA_Name]                     VARCHAR (250) NULL,
    [TA_TimeFrameInDays]          INT           NULL,
    [TA_DiseaseFilterDetail]      VARCHAR (250) NULL,
    [TA_AlertModel]               VARCHAR (50)  NULL,
    [TA_AlertModelDetail]         REAL          NULL,
    [TA_IsActive]                 BIT           NOT NULL,
    [TA_Status]                   VARCHAR (50)  NULL,
    [TA_DefinitionType]           VARCHAR (50)  NULL,
    [TA_BaseLineCode_ID]          INT           NULL,
    [TA_CaseTypeCode_ID]          INT           NULL,
    [TA_DiseaseFilterTypeCode_ID] INT           NULL,
    [TA_GeographicGroupCode_ID]   INT           NULL,
    [TA_ResolutionStatusCode_ID]  INT           NULL,
    [TA_ScaleTypeCode_ID]         INT           NULL,
    [TA_TimeFrameCode_ID]         INT           NULL,
    [TA_ReportSourceDR]           INT           NULL,
    CONSTRAINT [S_ThresholdAlert_PK] PRIMARY KEY NONCLUSTERED ([TA_RowID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [E_Entity_S_ThresholdAlert_FK8] FOREIGN KEY ([TA_ReportSourceDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_S_ThresholdAlert_TA_BaseLineCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([TA_BaseLineCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_S_ThresholdAlert_TA_CaseTypeCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([TA_CaseTypeCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_S_ThresholdAlert_TA_DiseaseFilterTypeCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([TA_DiseaseFilterTypeCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_S_ThresholdAlert_TA_GeographicGroupCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([TA_GeographicGroupCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_S_ThresholdAlert_TA_ResolutionStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([TA_ResolutionStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_S_ThresholdAlert_TA_ScaleTypeCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([TA_ScaleTypeCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_S_ThresholdAlert_TA_TimeFrameCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([TA_TimeFrameCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[S_ThresholdAlert] NOCHECK CONSTRAINT [E_Entity_S_ThresholdAlert_FK8];


GO
ALTER TABLE [dbo].[S_ThresholdAlert] NOCHECK CONSTRAINT [FK_A_S_ThresholdAlert_TA_BaseLineCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[S_ThresholdAlert] NOCHECK CONSTRAINT [FK_A_S_ThresholdAlert_TA_CaseTypeCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[S_ThresholdAlert] NOCHECK CONSTRAINT [FK_A_S_ThresholdAlert_TA_DiseaseFilterTypeCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[S_ThresholdAlert] NOCHECK CONSTRAINT [FK_A_S_ThresholdAlert_TA_GeographicGroupCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[S_ThresholdAlert] NOCHECK CONSTRAINT [FK_A_S_ThresholdAlert_TA_ResolutionStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[S_ThresholdAlert] NOCHECK CONSTRAINT [FK_A_S_ThresholdAlert_TA_ScaleTypeCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[S_ThresholdAlert] NOCHECK CONSTRAINT [FK_A_S_ThresholdAlert_TA_TimeFrameCode_ID_V_UNIFIEDCODESET];


GO
CREATE NONCLUSTERED INDEX [IX_S_ThresholdAlert_TA_Name]
    ON [dbo].[S_ThresholdAlert]([TA_Name] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

