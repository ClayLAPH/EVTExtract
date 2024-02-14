CREATE TABLE [dbo].[T_ConceptDescriptor] (
    [code]              VARCHAR (50)  NULL,
    [codeSystem]        VARCHAR (50)  CONSTRAINT [DF_T_ConceptDescriptor_codeSystem] DEFAULT ('V') NULL,
    [codeSystemName]    VARCHAR (100) NULL,
    [codeSystemVersion] VARCHAR (20)  NULL,
    [displayName]       VARCHAR (100) NULL,
    [originalText]      VARCHAR (MAX) NULL,
    [ID]                INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [QualifierList_ID]  INT           NULL,
    [TranslationSet_ID] INT           NULL,
    CONSTRAINT [T_ConceptDescriptor_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [T_ConceptQualifierList_T_ConceptDescriptor_FK1] FOREIGN KEY ([QualifierList_ID]) REFERENCES [dbo].[T_ConceptQualifierList] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_ConceptTranslationSet_T_ConceptDescriptor_FK1] FOREIGN KEY ([TranslationSet_ID]) REFERENCES [dbo].[T_ConceptTranslationSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[T_ConceptDescriptor] NOCHECK CONSTRAINT [T_ConceptQualifierList_T_ConceptDescriptor_FK1];


GO
ALTER TABLE [dbo].[T_ConceptDescriptor] NOCHECK CONSTRAINT [T_ConceptTranslationSet_T_ConceptDescriptor_FK1];

