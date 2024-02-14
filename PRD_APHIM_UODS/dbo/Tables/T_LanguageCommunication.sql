CREATE TABLE [dbo].[T_LanguageCommunication] (
    [languageCode_OrTx]         VARCHAR (50) NULL,
    [modeCode_OrTx]             VARCHAR (50) NULL,
    [proficiencyLevelCode_OrTx] VARCHAR (50) NULL,
    [preferenceInd]             BIT          NULL,
    [metaCode]                  VARCHAR (50) NULL,
    [languageCode_ID]           INT          NULL,
    [modeCode_ID]               INT          NULL,
    [proficiencyLevelCode_ID]   INT          NULL,
    [ServerId]                  INT          NULL,
    [ID]                        INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Entity_ID]                 INT          NULL,
    CONSTRAINT [T_LanguageCommunication_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [E_Entity_T_LanguageCommunication_FK1] FOREIGN KEY ([Entity_ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_T_LanguageCommunication_languageCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([languageCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_T_LanguageCommunication_modeCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([modeCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_T_LanguageCommunication_proficiencyLevelCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([proficiencyLevelCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[T_LanguageCommunication] NOCHECK CONSTRAINT [E_Entity_T_LanguageCommunication_FK1];


GO
ALTER TABLE [dbo].[T_LanguageCommunication] NOCHECK CONSTRAINT [FK_A_T_LanguageCommunication_languageCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[T_LanguageCommunication] NOCHECK CONSTRAINT [FK_A_T_LanguageCommunication_modeCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[T_LanguageCommunication] NOCHECK CONSTRAINT [FK_A_T_LanguageCommunication_proficiencyLevelCode_ID_V_UNIFIEDCODESET];


GO
CREATE NONCLUSTERED INDEX [IX_T_LanguageCommunication]
    ON [dbo].[T_LanguageCommunication]([Entity_ID] ASC, [metaCode] ASC)
    INCLUDE([languageCode_ID]) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];

