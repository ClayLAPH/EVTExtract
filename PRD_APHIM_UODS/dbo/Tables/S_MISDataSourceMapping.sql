CREATE TABLE [dbo].[S_MISDataSourceMapping] (
    [ID]            INT           IDENTITY (1, 1) NOT NULL,
    [KeyName]       VARCHAR (100) NOT NULL,
    [ProcedureName] VARCHAR (150) NOT NULL,
    [Description]   VARCHAR (200) NULL,
    [LastUpdated]   DATETIME      DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_S_MISDataSourceMapping] PRIMARY KEY NONCLUSTERED ([ID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_S_MISDataSourceMapping_KeyName]
    ON [dbo].[S_MISDataSourceMapping]([KeyName] ASC);

