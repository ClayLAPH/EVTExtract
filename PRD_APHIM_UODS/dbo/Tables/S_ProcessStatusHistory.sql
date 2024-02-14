CREATE TABLE [dbo].[S_ProcessStatusHistory] (
    [RecordType]         VARCHAR (2) NOT NULL,
    [RowID]              INT         NOT NULL,
    [ActionDate]         DATETIME    NOT NULL,
    [OldProcessStatusDR] INT         NULL,
    [NewProcessStatusDR] INT         NULL,
    [UserDR]             INT         NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_S_ProcessStatusHistory]
    ON [dbo].[S_ProcessStatusHistory]([RecordType] ASC, [RowID] ASC, [ActionDate] ASC) WITH (FILLFACTOR = 70);


GO
ALTER INDEX [IX_S_ProcessStatusHistory]
    ON [dbo].[S_ProcessStatusHistory] DISABLE;


GO
CREATE NONCLUSTERED INDEX [IX_S_ProcessStatusHistory_RecordType_RowID]
    ON [dbo].[S_ProcessStatusHistory]([RecordType] ASC, [RowID] ASC)
    INCLUDE([ActionDate], [NewProcessStatusDR]) WITH (FILLFACTOR = 80);

