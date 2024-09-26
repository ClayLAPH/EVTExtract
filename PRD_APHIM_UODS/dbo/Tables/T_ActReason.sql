CREATE TABLE [dbo].[T_ActReason] (
    [reasonCode_OrTx] VARCHAR (50) NULL,
    [statusChange]    VARCHAR (50) NULL,
    [metaCode]        VARCHAR (50) NULL,
    [reasonCode_ID]   INT          NULL,
    [ServerId]        INT          NULL,
    [ID]              INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Act_ID]          INT          NULL,
    CONSTRAINT [T_ActReason_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [A_Act_T_ActReason_FK1] FOREIGN KEY ([Act_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_T_ActReason_reasonCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([reasonCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[T_ActReason] NOCHECK CONSTRAINT [A_Act_T_ActReason_FK1];


GO
ALTER TABLE [dbo].[T_ActReason] NOCHECK CONSTRAINT [FK_A_T_ActReason_reasonCode_ID_V_UNIFIEDCODESET];


GO
CREATE NONCLUSTERED INDEX [T_ActReason_1]
    ON [dbo].[T_ActReason]([Act_ID] ASC) WITH (FILLFACTOR = 70);

