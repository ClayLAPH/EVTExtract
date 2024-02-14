CREATE TABLE [dbo].[S_FormField] (
    [FIELD_FormID]                     INT           NOT NULL,
    [FIELD_ID]                         INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FIELD_TableName]                  NVARCHAR (50) NULL,
    [FIELD_FieldName]                  NVARCHAR (50) NULL,
    [FIELD_Text]                       NVARCHAR (50) NULL,
    [FIELD_SpecialHandling]            BIT           NULL,
    [FIELD_AllowInPublicTransmissions] BIT           NULL,
    CONSTRAINT [S_FormField_PK] PRIMARY KEY CLUSTERED ([FIELD_ID] ASC) WITH (FILLFACTOR = 95) ON [PRIMARY_IDX],
    CONSTRAINT [FK_S_FormField_S_Form] FOREIGN KEY ([FIELD_FormID]) REFERENCES [dbo].[S_Form] ([FORM_ID]) NOT FOR REPLICATION
) ON [PRIMARY_IDX];


GO
ALTER TABLE [dbo].[S_FormField] NOCHECK CONSTRAINT [FK_S_FormField_S_Form];


GO
CREATE NONCLUSTERED INDEX [IX_S_FormField]
    ON [dbo].[S_FormField]([FIELD_FormID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE STATISTICS [IX_WA_FIELD_FieldName]
    ON [dbo].[S_FormField]([FIELD_FieldName]);


GO
CREATE STATISTICS [IX_WA_FIELD_TableName]
    ON [dbo].[S_FormField]([FIELD_TableName]);

