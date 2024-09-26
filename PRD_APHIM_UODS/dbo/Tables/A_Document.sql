CREATE TABLE [dbo].[A_Document] (
    [localId]             VARCHAR (50) NULL,
    [versionNumber]       INT          NULL,
    [completionCode_OrTx] VARCHAR (50) NULL,
    [storageCode_OrTx]    VARCHAR (50) NULL,
    [copyTime]            DATETIME     NULL,
    [completionCode_ID]   INT          NULL,
    [storageCode_ID]      INT          NULL,
    [ID]                  INT          NOT NULL,
    CONSTRAINT [A_Document_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [A_Act_A_Document_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Document_completionCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([completionCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Document_storageCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([storageCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[A_Document] NOCHECK CONSTRAINT [A_Act_A_Document_FK1];


GO
ALTER TABLE [dbo].[A_Document] NOCHECK CONSTRAINT [FK_A_A_Document_completionCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Document] NOCHECK CONSTRAINT [FK_A_A_Document_storageCode_ID_V_UNIFIEDCODESET];

