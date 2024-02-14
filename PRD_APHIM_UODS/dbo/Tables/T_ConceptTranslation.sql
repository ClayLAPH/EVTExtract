CREATE TABLE [dbo].[T_ConceptTranslation] (
    [ID]          INT IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [tran_Set_ID] INT NULL,
    CONSTRAINT [T_ConceptTranslation_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [T_ConceptTranslationSet_T_ConceptTranslation_FK1] FOREIGN KEY ([tran_Set_ID]) REFERENCES [dbo].[T_ConceptTranslationSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[T_ConceptTranslation] NOCHECK CONSTRAINT [T_ConceptTranslationSet_T_ConceptTranslation_FK1];

