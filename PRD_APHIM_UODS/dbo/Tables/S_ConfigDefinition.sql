CREATE TABLE [dbo].[S_ConfigDefinition] (
    [ID]                INT           NOT NULL,
    [key]               VARCHAR (100) NOT NULL,
    [type_UCSId]        INT           NOT NULL,
    [description]       VARCHAR (MAX) NULL,
    [application_UCSId] INT           NOT NULL,
    [required]          BIT           NULL,
    [TermName]          VARCHAR (100) NULL,
    [defaultValue]      SQL_VARIANT   NULL,
    CONSTRAINT [PK_AppConfigs] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_S_ConfigDefinition_V_UnifiedCodeSet] FOREIGN KEY ([application_UCSId]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]),
    CONSTRAINT [FK_S_ConfigDefinition_V_UnifiedCodeSet1] FOREIGN KEY ([type_UCSId]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID])
);

