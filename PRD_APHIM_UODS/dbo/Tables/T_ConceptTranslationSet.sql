CREATE TABLE [dbo].[T_ConceptTranslationSet] (
    [name] VARCHAR (50) NULL,
    [ID]   INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    CONSTRAINT [T_ConceptTranslationSet_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70)
);

