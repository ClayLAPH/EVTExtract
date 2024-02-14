CREATE TABLE [dbo].[A_Act] (
    [classCode]                 VARCHAR (50)   NOT NULL,
    [classCode_OrTx]            VARCHAR (50)   NULL,
    [moodCode]                  VARCHAR (50)   NULL,
    [moodCode_OrTx]             VARCHAR (50)   NULL,
    [code_OrTx]                 VARCHAR (255)  NULL,
    [code_CD_ID]                INT            NULL,
    [negationInd]               BIT            NULL,
    [derivationExpr]            VARCHAR (50)   NULL,
    [title]                     VARCHAR (300)  NULL,
    [text]                      VARCHAR (MAX)  NULL,
    [statusCode]                VARCHAR (50)   CONSTRAINT [DF_A_Act_statusCode] DEFAULT ('active') NULL,
    [statusCode_OrTx]           VARCHAR (50)   NULL,
    [effectiveTime_Beg]         DATETIME       CONSTRAINT [DF_A_Act_effectiveTime_Beg] DEFAULT (getdate()) NULL,
    [effectiveTime_End]         DATETIME       NULL,
    [effectiveTime_Dur]         REAL           NULL,
    [effectiveTime_Dur_Unit]    VARCHAR (50)   NULL,
    [effectiveTime_Txt]         VARCHAR (50)   NULL,
    [activityTime_Beg]          DATETIME       NULL,
    [activityTime_End]          DATETIME       NULL,
    [availabilityTime]          DATETIME       NULL,
    [priorityCode_OrTx]         VARCHAR (50)   NULL,
    [confidentialityCode_OrTx]  VARCHAR (50)   NULL,
    [repeatNumber_Min]          INT            NULL,
    [repeatNumber_Max]          INT            NULL,
    [interruptibleInd]          BIT            NULL,
    [independentInd]            BIT            NULL,
    [uncertaintyCode_OrTx]      VARCHAR (50)   NULL,
    [languageCode_OrTx]         VARCHAR (50)   NULL,
    [metaCode]                  VARCHAR (50)   NULL,
    [localId]                   VARCHAR (50)   NULL,
    [Act_Parent_TypeCode]       VARCHAR (50)   NULL,
    [Act_Parent_SequenceNumber] INT            NULL,
    [Act_Parent_PriorityNumber] INT            NULL,
    [valueBool]                 BIT            NULL,
    [valueInteger]              INT            NULL,
    [valueReal]                 REAL           NULL,
    [valueTS]                   DATETIME       NULL,
    [ValueTSEnd]                DATETIME       NULL,
    [valueString]               VARCHAR (8000) NULL,
    [valueString_Txt]           VARCHAR (200)  NULL,
    [valueNumerator]            REAL           NULL,
    [valueNumerator_Unit]       VARCHAR (50)   NULL,
    [valueDenominator]          REAL           NULL,
    [valueDenominator_Unit]     VARCHAR (50)   NULL,
    [isValueNull]               BIT            NULL,
    [code_ID]                   INT            NULL,
    [confidentialityCode_ID]    INT            NULL,
    [effectiveTime_Frq_ID]      INT            NULL,
    [languageCode_ID]           INT            NULL,
    [priorityCode_ID]           INT            NULL,
    [uncertaintyCode_ID]        INT            NULL,
    [valueCode_ID]              INT            NULL,
    [ServerId]                  INT            NULL,
    [ID]                        INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Act_CaseCmr_ID]            INT            NULL,
    [Act_CaseNcm_ID]            INT            NULL,
    [Act_Parent_ID]             INT            NULL,
    [ActHx_ID]                  INT            NULL,
    CONSTRAINT [A_Act_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95) ON [ACTS_DATA],
    CONSTRAINT [A_Act_A_Act_Act_CaseCmr_FK1] FOREIGN KEY ([Act_CaseCmr_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [A_Act_A_Act_Act_CaseNcm_FK1] FOREIGN KEY ([Act_CaseNcm_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [A_Act_A_Act_Act_code_CD_ID_FK] FOREIGN KEY ([code_CD_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [A_Act_A_Act_Act_Parent_FK1] FOREIGN KEY ([Act_Parent_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [A_Act_A_Act_FK1] FOREIGN KEY ([ActHx_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Act_code_ID_V_UNIFIEDCODESET] FOREIGN KEY ([code_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Act_confidentialityCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([confidentialityCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Act_effectiveTime_Frq_ID_V_UNIFIEDCODESET] FOREIGN KEY ([effectiveTime_Frq_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Act_languageCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([languageCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Act_priorityCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([priorityCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Act_uncertaintyCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([uncertaintyCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Act_valueCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([valueCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
) ON [ACTS_DATA] TEXTIMAGE_ON [ACTS_DATA];


GO
ALTER TABLE [dbo].[A_Act] NOCHECK CONSTRAINT [A_Act_A_Act_Act_CaseCmr_FK1];


GO
ALTER TABLE [dbo].[A_Act] NOCHECK CONSTRAINT [A_Act_A_Act_Act_CaseNcm_FK1];


GO
ALTER TABLE [dbo].[A_Act] NOCHECK CONSTRAINT [A_Act_A_Act_Act_code_CD_ID_FK];


GO
ALTER TABLE [dbo].[A_Act] NOCHECK CONSTRAINT [A_Act_A_Act_Act_Parent_FK1];


GO
ALTER TABLE [dbo].[A_Act] NOCHECK CONSTRAINT [A_Act_A_Act_FK1];


GO
ALTER TABLE [dbo].[A_Act] NOCHECK CONSTRAINT [FK_A_A_Act_code_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Act] NOCHECK CONSTRAINT [FK_A_A_Act_confidentialityCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Act] NOCHECK CONSTRAINT [FK_A_A_Act_effectiveTime_Frq_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Act] NOCHECK CONSTRAINT [FK_A_A_Act_languageCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Act] NOCHECK CONSTRAINT [FK_A_A_Act_priorityCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Act] NOCHECK CONSTRAINT [FK_A_A_Act_uncertaintyCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Act] NOCHECK CONSTRAINT [FK_A_A_Act_valueCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Act] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_A_Act]
    ON [dbo].[A_Act]([classCode] ASC, [title] ASC) WITH (FILLFACTOR = 70)
    ON [ACTS_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_A_Act_11]
    ON [dbo].[A_Act]([Act_CaseCmr_ID] ASC) WITH (FILLFACTOR = 70)
    ON [ACTS_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_A_Act_3]
    ON [dbo].[A_Act]([statusCode] ASC) WITH (FILLFACTOR = 70)
    ON [ACTS_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_A_Act_5]
    ON [dbo].[A_Act]([ActHx_ID] ASC) WITH (FILLFACTOR = 70)
    ON [ACTS_IDX];


GO
ALTER INDEX [IX_A_Act_5]
    ON [dbo].[A_Act] DISABLE;


GO
CREATE NONCLUSTERED INDEX [IX_A_Act_6]
    ON [dbo].[A_Act]([code_ID] ASC, [classCode] ASC, [Act_Parent_ID] ASC) WITH (FILLFACTOR = 80)
    ON [ACTS_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_A_Act_7]
    ON [dbo].[A_Act]([interruptibleInd] ASC) WITH (FILLFACTOR = 70)
    ON [ACTS_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_A_Act_8]
    ON [dbo].[A_Act]([activityTime_Beg] ASC) WITH (FILLFACTOR = 70)
    ON [ACTS_IDX];


GO
ALTER INDEX [IX_A_Act_8]
    ON [dbo].[A_Act] DISABLE;


GO
CREATE NONCLUSTERED INDEX [IX_A_Act_9]
    ON [dbo].[A_Act]([metaCode] ASC, [activityTime_End] ASC) WITH (FILLFACTOR = 70)
    ON [ACTS_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_A_Act_ETBeg]
    ON [dbo].[A_Act]([effectiveTime_Beg] ASC)
    INCLUDE([metaCode], [Act_Parent_ID]) WITH (FILLFACTOR = 70)
    ON [ACTS_DATA];


GO
CREATE NONCLUSTERED INDEX [IX_A_Act_PrtID]
    ON [dbo].[A_Act]([Act_Parent_ID] ASC)
    INCLUDE([metaCode], [activityTime_Beg], [activityTime_End], [code_ID], [title], [effectiveTime_Beg]) WITH (FILLFACTOR = 80)
    ON [ACTS_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_A_Act_MetaStatus]
    ON [dbo].[A_Act]([metaCode] ASC, [statusCode] ASC)
    INCLUDE([title], [effectiveTime_Beg], [Act_Parent_ID], [ID], [code_OrTx], [effectiveTime_End]) WITH (FILLFACTOR = 70)
    ON [ACTS_DATA];


GO
CREATE NONCLUSTERED INDEX [IX_A_Act_classCode_metaCode_code_OrTx_availabilityTime_inc]
    ON [dbo].[A_Act]([classCode] ASC, [metaCode] ASC, [code_OrTx] ASC, [availabilityTime] ASC)
    INCLUDE([ID]) WITH (FILLFACTOR = 70)
    ON [ACTS_IDX];


GO
CREATE NONCLUSTERED INDEX [ix_a_act_jt]
    ON [dbo].[A_Act]([title] ASC, [metaCode] ASC) WITH (FILLFACTOR = 70)
    ON [ACTS_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_A_Act_Mood]
    ON [dbo].[A_Act]([moodCode] ASC) WITH (FILLFACTOR = 70)
    ON [ACTS_IDX];


GO
ALTER INDEX [IX_A_Act_Mood]
    ON [dbo].[A_Act] DISABLE;


GO
CREATE NONCLUSTERED INDEX [IX_A_Act_NCMID]
    ON [dbo].[A_Act]([Act_CaseNcm_ID] ASC) WITH (FILLFACTOR = 70)
    ON [ACTS_IDX];


GO
ALTER INDEX [IX_A_Act_NCMID]
    ON [dbo].[A_Act] DISABLE;


GO
CREATE NONCLUSTERED INDEX [IX_A_Act_AvailTime]
    ON [dbo].[A_Act]([availabilityTime] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY];


GO
CREATE NONCLUSTERED INDEX [IX_A_Act_FilteredMetaCode_RH]
    ON [dbo].[A_Act]([Act_Parent_ID] ASC, [metaCode] ASC, [Act_Parent_TypeCode] ASC) WHERE ([classCode]='OBS' AND [moodCode]='EVN')
    ON [ACTS_DATA];

