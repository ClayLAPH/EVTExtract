CREATE TABLE [dbo].[T_ConceptQualifier] (
    [sequenceNumber] INT NULL,
    [ID]             INT IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [qual_CR_ID]     INT NULL,
    [qual_List_ID]   INT NULL,
    CONSTRAINT [T_ConceptQualifier_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [T_ConceptQualifierList_T_ConceptQualifier_FK1] FOREIGN KEY ([qual_List_ID]) REFERENCES [dbo].[T_ConceptQualifierList] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_ConceptRole_T_ConceptQualifier_FK1] FOREIGN KEY ([qual_CR_ID]) REFERENCES [dbo].[T_ConceptRole] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[T_ConceptQualifier] NOCHECK CONSTRAINT [T_ConceptQualifierList_T_ConceptQualifier_FK1];


GO
ALTER TABLE [dbo].[T_ConceptQualifier] NOCHECK CONSTRAINT [T_ConceptRole_T_ConceptQualifier_FK1];

