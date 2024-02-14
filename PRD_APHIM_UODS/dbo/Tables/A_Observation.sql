CREATE TABLE [dbo].[A_Observation] (
    [interpretationCode_OrTx] VARCHAR (50) NULL,
    [methodCode_OrTx]         VARCHAR (50) NULL,
    [targetSiteCode_OrTx]     VARCHAR (50) NULL,
    [interpretationCode_ID]   INT          NULL,
    [methodCode_ID]           INT          NULL,
    [targetSiteCode_ID]       INT          NULL,
    [ServerId]                INT          NULL,
    [ID]                      INT          NOT NULL,
    CONSTRAINT [A_Observation_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95) ON [OBSERVATION_DATA],
    CONSTRAINT [A_Act_A_Observation_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Observation_interpretationCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([interpretationCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Observation_methodCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([methodCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Observation_targetSiteCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([targetSiteCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
) ON [OBSERVATION_DATA];


GO
ALTER TABLE [dbo].[A_Observation] NOCHECK CONSTRAINT [A_Act_A_Observation_FK1];


GO
ALTER TABLE [dbo].[A_Observation] NOCHECK CONSTRAINT [FK_A_A_Observation_interpretationCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Observation] NOCHECK CONSTRAINT [FK_A_A_Observation_methodCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Observation] NOCHECK CONSTRAINT [FK_A_A_Observation_targetSiteCode_ID_V_UNIFIEDCODESET];

