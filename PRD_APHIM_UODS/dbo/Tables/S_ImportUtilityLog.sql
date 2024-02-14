CREATE TABLE [dbo].[S_ImportUtilityLog] (
    [IUL_ID]         INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IUL_IUMID]      INT           NOT NULL,
    [IUL_LineNumber] INT           NULL,
    [IUL_Content]    VARCHAR (255) NULL,
    [IUL_ImportTime] DATETIME      NULL,
    CONSTRAINT [PK_S_ImportUtilityLog] PRIMARY KEY CLUSTERED ([IUL_IUMID] ASC, [IUL_ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_S_ImportUtilityLog_S_ImportUtilityManager] FOREIGN KEY ([IUL_IUMID]) REFERENCES [dbo].[S_ImportUtilityManager] ([IUM_ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[S_ImportUtilityLog] NOCHECK CONSTRAINT [FK_S_ImportUtilityLog_S_ImportUtilityManager];


GO
CREATE NONCLUSTERED INDEX [IX_S_IUL_LineNumber]
    ON [dbo].[S_ImportUtilityLog]([IUL_IUMID] ASC, [IUL_LineNumber] ASC)
    INCLUDE([IUL_ID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

