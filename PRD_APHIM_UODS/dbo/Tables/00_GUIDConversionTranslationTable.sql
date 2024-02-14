CREATE TABLE [dbo].[00_GUIDConversionTranslationTable] (
    [GUIDConversionTranslationTableId] INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TableName]                        VARCHAR (100)    NULL,
    [FieldName]                        VARCHAR (100)    NULL,
    [GUID]                             UNIQUEIDENTIFIER NULL,
    [IntegerValue]                     INT              NULL,
    CONSTRAINT [PK_GUIDConversionTranslationTable] PRIMARY KEY CLUSTERED ([GUIDConversionTranslationTableId] ASC) WITH (FILLFACTOR = 95)
);


GO
CREATE NONCLUSTERED INDEX [IX_GUIDConversionTranslationTable]
    ON [dbo].[00_GUIDConversionTranslationTable]([GUID] ASC, [IntegerValue] ASC) WITH (FILLFACTOR = 70)
    ON [ACTS_IDX];

