CREATE TABLE [dbo].[S_SubscriptionProfile] (
    [SUB_RowID]               INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SUB_FrequencyIncidents]  INT           NULL,
    [SUB_FrequencyDays]       INT           NULL,
    [SUB_IncludeEpiCurve]     BIT           NOT NULL,
    [SUB_IncludeGeneral]      BIT           NOT NULL,
    [SUB_IncludeSpecific]     BIT           NOT NULL,
    [SUB_IsActive]            BIT           NOT NULL,
    [SUB_Name]                VARCHAR (250) NULL,
    [SUB_IsDisease]           BIT           NULL,
    [SUB_FileLinkDR]          INT           NULL,
    [SUB_DiseaseCode_ID]      INT           NULL,
    [SUB_DiseaseGroupCode_ID] INT           NULL,
    CONSTRAINT [S_SubscriptionProfile_PK] PRIMARY KEY NONCLUSTERED ([SUB_RowID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [FK_A_S_SubscriptionProfile_SUB_DiseaseCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([SUB_DiseaseCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_S_SubscriptionProfile_SUB_DiseaseGroupCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([SUB_DiseaseGroupCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [S_FileLink_S_SubscriptionProfile_FK3] FOREIGN KEY ([SUB_FileLinkDR]) REFERENCES [dbo].[S_FileLink] ([FL_RowID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[S_SubscriptionProfile] NOCHECK CONSTRAINT [FK_A_S_SubscriptionProfile_SUB_DiseaseCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[S_SubscriptionProfile] NOCHECK CONSTRAINT [FK_A_S_SubscriptionProfile_SUB_DiseaseGroupCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[S_SubscriptionProfile] NOCHECK CONSTRAINT [S_FileLink_S_SubscriptionProfile_FK3];


GO
CREATE NONCLUSTERED INDEX [IX_S_SubscriptionProfile_1]
    ON [dbo].[S_SubscriptionProfile]([SUB_Name] ASC, [SUB_IsActive] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

