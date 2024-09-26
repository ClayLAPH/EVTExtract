CREATE TABLE [dbo].[T_ConceptQualifierList] (
    [name] VARCHAR (50) NULL,
    [ID]   INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    CONSTRAINT [T_ConceptQualifierList_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70)
);

