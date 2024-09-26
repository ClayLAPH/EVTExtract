CREATE TABLE [dbo].[S_DBQueryDefinition] (
    [RowID]            INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [QueryName]        VARCHAR (250)  NOT NULL,
    [QueryDescription] VARCHAR (1000) NULL,
    CONSTRAINT [PK_S_DBQueryDefinition] PRIMARY KEY CLUSTERED ([RowID] ASC) WITH (FILLFACTOR = 95)
);

