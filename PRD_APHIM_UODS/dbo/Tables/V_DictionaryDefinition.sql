CREATE TABLE [dbo].[V_DictionaryDefinition] (
    [ID]                          INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [name]                        VARCHAR (110) NULL,
    [domain_ID]                   INT           NULL,
    [IsSystemDefined]             BIT           NULL,
    [APPLICATION_UCSID]           INT           NOT NULL,
    [SHOWINUDVOCABULARY]          BIT           CONSTRAINT [DF_V_DICTIONARYDEFINITION_SHOWINUDVOCABULARY] DEFAULT ((1)) NOT NULL,
    [AllowInUDF]                  BIT           NULL,
    [ShowInUDVocabularyForCMMode] BIT           NULL,
    CONSTRAINT [PK_V_DictionaryDefinition] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_V_Domain_FK] FOREIGN KEY ([domain_ID]) REFERENCES [dbo].[V_Domain] ([ID]),
    CONSTRAINT [FK_V_UNIFIEDCODESET_FK] FOREIGN KEY ([APPLICATION_UCSID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID])
);


GO
ALTER TABLE [dbo].[V_DictionaryDefinition] NOCHECK CONSTRAINT [FK_V_Domain_FK];


GO
ALTER TABLE [dbo].[V_DictionaryDefinition] NOCHECK CONSTRAINT [FK_V_UNIFIEDCODESET_FK];


GO
CREATE NONCLUSTERED INDEX [IX_V_DictionaryDefinition_Name]
    ON [dbo].[V_DictionaryDefinition]([name] ASC) WITH (FILLFACTOR = 70);


GO
CREATE NONCLUSTERED INDEX [IX_V_DictionaryDefinition_Domain_ID]
    ON [dbo].[V_DictionaryDefinition]([domain_ID] ASC) WITH (FILLFACTOR = 70);

