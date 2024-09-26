CREATE TABLE [dbo].[T_ConceptRole] (
    [name_Code]              VARCHAR (50)  NULL,
    [name_CodeSystem]        VARCHAR (50)  CONSTRAINT [DF_T_ConceptRole_name_CodeSystem] DEFAULT ('V') NULL,
    [name_CodeSystemName]    VARCHAR (100) NULL,
    [name_CodeSystemVersion] VARCHAR (20)  NULL,
    [name_DisplayName]       VARCHAR (100) NULL,
    [name_OriginalText]      VARCHAR (MAX) NULL,
    [inverted]               BIT           NULL,
    [ID]                     INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    CONSTRAINT [T_ConceptRole_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70)
);

