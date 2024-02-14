CREATE TABLE [dbo].[SYS_AutoSavedRecords] (
    [RecordID]           INT             NOT NULL,
    [RecordType_Code_ID] INT             NOT NULL,
    [UserDR]             INT             NULL,
    [AutoSavedTime]      DATETIME        NULL,
    [AutoSavedData]      VARBINARY (MAX) NULL,
    CONSTRAINT [PK_SYS_AutoSavedRecords_RecordID] PRIMARY KEY CLUSTERED ([RecordID] ASC, [RecordType_Code_ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_SYS_AutoSavedRecords_A_ACT] FOREIGN KEY ([RecordID]) REFERENCES [dbo].[A_Act] ([ID]),
    CONSTRAINT [FK_SYS_AutoSavedRecords_E_Entity] FOREIGN KEY ([UserDR]) REFERENCES [dbo].[E_Entity] ([ID]),
    CONSTRAINT [FK_SYS_AutoSavedRecords_V_UnifiedCodeSet] FOREIGN KEY ([RecordType_Code_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID])
);

