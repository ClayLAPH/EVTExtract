CREATE TABLE [dbo].[P_Participation] (
    [typeCode]                       VARCHAR (50)  NULL,
    [typeCode_OrTx]                  VARCHAR (50)  NULL,
    [functionCode_OrTx]              VARCHAR (50)  NULL,
    [contextControlCode]             VARCHAR (50)  NULL,
    [contextControlCode_OrTx]        VARCHAR (50)  NULL,
    [sequenceNumber]                 INT           NULL,
    [negationInd]                    BIT           NULL,
    [noteText]                       VARCHAR (MAX) NULL,
    [time_Beg]                       DATETIME      CONSTRAINT [DF_P_Participation_time_Beg] DEFAULT (getdate()) NULL,
    [time_End]                       DATETIME      NULL,
    [modeCode_OrTx]                  VARCHAR (50)  NULL,
    [awarenessCode_OrTx]             VARCHAR (50)  NULL,
    [signatureCode_OrTx]             VARCHAR (50)  NULL,
    [signatureText]                  VARCHAR (MAX) NULL,
    [performInd]                     BIT           NULL,
    [substitutionConditionCode_OrTx] VARCHAR (50)  NULL,
    [statusCode]                     VARCHAR (50)  CONSTRAINT [DF_P_Participation_statusCode] DEFAULT ('active') NULL,
    [statusCode_OrTx]                VARCHAR (50)  NULL,
    [metaCode]                       VARCHAR (50)  NULL,
    [subsetCode]                     VARCHAR (50)  NULL,
    [subsetCode_OrTx]                VARCHAR (50)  NULL,
    [localId]                        VARCHAR (50)  NULL,
    [awarenessCode_ID]               INT           NULL,
    [functionCode_ID]                INT           NULL,
    [modeCode_ID]                    INT           NULL,
    [signatureCode_ID]               INT           NULL,
    [substitutionConditionCode_ID]   INT           NULL,
    [ServerId]                       INT           NULL,
    [ID]                             INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Act_ID]                         INT           NULL,
    [ParticipationHx_ID]             INT           NULL,
    [Role_ID]                        INT           NULL,
    CONSTRAINT [P_Participation_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95) ON [PARTICIPATION_DATA],
    CONSTRAINT [A_Act_P_Participation_FK1] FOREIGN KEY ([Act_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_P_Participation_awarenessCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([awarenessCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_P_Participation_functionCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([functionCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_P_Participation_modeCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([modeCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_P_Participation_signatureCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([signatureCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_P_Participation_substitutionConditionCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([substitutionConditionCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [P_Participation_P_Participation_FK1] FOREIGN KEY ([ParticipationHx_ID]) REFERENCES [dbo].[P_Participation] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [R_Role_P_Participation_FK1] FOREIGN KEY ([Role_ID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION
) ON [PARTICIPATION_DATA] TEXTIMAGE_ON [PARTICIPATION_DATA];


GO
ALTER TABLE [dbo].[P_Participation] NOCHECK CONSTRAINT [A_Act_P_Participation_FK1];


GO
ALTER TABLE [dbo].[P_Participation] NOCHECK CONSTRAINT [FK_A_P_Participation_awarenessCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[P_Participation] NOCHECK CONSTRAINT [FK_A_P_Participation_functionCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[P_Participation] NOCHECK CONSTRAINT [FK_A_P_Participation_modeCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[P_Participation] NOCHECK CONSTRAINT [FK_A_P_Participation_signatureCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[P_Participation] NOCHECK CONSTRAINT [FK_A_P_Participation_substitutionConditionCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[P_Participation] NOCHECK CONSTRAINT [P_Participation_P_Participation_FK1];


GO
ALTER TABLE [dbo].[P_Participation] NOCHECK CONSTRAINT [R_Role_P_Participation_FK1];


GO
CREATE NONCLUSTERED INDEX [IX_P_Participation]
    ON [dbo].[P_Participation]([Role_ID] ASC, [typeCode] ASC, [metaCode] ASC)
    INCLUDE([Act_ID]) WITH (FILLFACTOR = 70)
    ON [PARTICIPATION_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_P_Participation_1]
    ON [dbo].[P_Participation]([Act_ID] ASC, [typeCode] ASC, [metaCode] ASC)
    INCLUDE([Role_ID]) WITH (FILLFACTOR = 70)
    ON [PARTICIPATION_IDX];

