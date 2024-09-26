CREATE TABLE [dbo].[T_EthnicGroup] (
    [ethnicGroupCode_OrTx] VARCHAR (50) NULL,
    [metaCode]             VARCHAR (50) NULL,
    [ethnicGroupCode_ID]   INT          NULL,
    [ServerId]             INT          NULL,
    [ID]                   INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Entity_ID]            INT          NULL,
    CONSTRAINT [T_EthnicGroup_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [E_Person_T_EthnicGroup_FK1] FOREIGN KEY ([Entity_ID]) REFERENCES [dbo].[E_Person] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_T_EthnicGroup_ethnicGroupCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([ethnicGroupCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[T_EthnicGroup] NOCHECK CONSTRAINT [E_Person_T_EthnicGroup_FK1];


GO
ALTER TABLE [dbo].[T_EthnicGroup] NOCHECK CONSTRAINT [FK_A_T_EthnicGroup_ethnicGroupCode_ID_V_UNIFIEDCODESET];


GO
CREATE NONCLUSTERED INDEX [IX_T_EthnicGroup]
    ON [dbo].[T_EthnicGroup]([Entity_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE STATISTICS [IX_WA_metaCode]
    ON [dbo].[T_EthnicGroup]([metaCode]);

