CREATE TABLE [dbo].[T_EntityNamePart] (
    [sequence]       INT           NULL,
    [partType]       VARCHAR (50)  NULL,
    [partType_OrTx]  VARCHAR (50)  NULL,
    [qualifier]      VARCHAR (50)  NULL,
    [qualifier_OrTx] VARCHAR (50)  NULL,
    [name]           VARCHAR (100) NULL,
    [metaCode]       VARCHAR (50)  NULL,
    [ServerId]       INT           NULL,
    [ID]             INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [EntityName_ID]  INT           NULL,
    CONSTRAINT [T_EntityNamePart_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [T_EntityName_T_EntityNamePart_FK1] FOREIGN KEY ([EntityName_ID]) REFERENCES [dbo].[T_EntityName] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[T_EntityNamePart] NOCHECK CONSTRAINT [T_EntityName_T_EntityNamePart_FK1];


GO
CREATE NONCLUSTERED INDEX [IX_T_EntityNamePart]
    ON [dbo].[T_EntityNamePart]([EntityName_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE STATISTICS [IX_WA_name]
    ON [dbo].[T_EntityNamePart]([name]);


GO
CREATE STATISTICS [IX_WA_partType]
    ON [dbo].[T_EntityNamePart]([partType]);

