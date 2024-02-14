CREATE TABLE [dbo].[S_DBQueryFieldJoin] (
    [RowId]                INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [QueryId]              INT           NOT NULL,
    [FIELD_Name]           VARCHAR (250) NOT NULL,
    [DBFieldName]          VARCHAR (250) NOT NULL,
    [DBFieldTableAlias]    VARCHAR (250) NULL,
    [FIELD_IsComputed]     BIT           NOT NULL,
    [DBTableName]          VARCHAR (250) NOT NULL,
    [DBTableAlias]         VARCHAR (250) NULL,
    [DBTableJoinType]      VARCHAR (250) NULL,
    [DBTableJoinCondition] VARCHAR (MAX) NULL,
    [DBTableJoinOrder]     INT           NULL,
    [DBTableHints]         VARCHAR (500) DEFAULT ('(nolock)') NOT NULL,
    CONSTRAINT [PK_S_DBQueryFieldJoin] PRIMARY KEY CLUSTERED ([RowId] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_S_DBQueryFieldJoin_S_DBQueryDefinition] FOREIGN KEY ([QueryId]) REFERENCES [dbo].[S_DBQueryDefinition] ([RowID])
);

