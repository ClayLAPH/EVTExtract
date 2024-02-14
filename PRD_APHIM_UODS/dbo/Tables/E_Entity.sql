CREATE TABLE [dbo].[E_Entity] (
    [classCode]           VARCHAR (50)    NOT NULL,
    [classCode_OrTx]      VARCHAR (50)    NULL,
    [determinerCode]      VARCHAR (50)    NOT NULL,
    [determinerCode_OrTx] VARCHAR (50)    NULL,
    [code_OrTx]           VARCHAR (50)    NULL,
    [quantity]            REAL            NULL,
    [desc_Text]           VARCHAR (MAX)   NULL,
    [desc_Img]            VARBINARY (MAX) NULL,
    [statusCode]          VARCHAR (50)    CONSTRAINT [DF_E_Entity_statusCode] DEFAULT ('active') NULL,
    [statusCode_OrTx]     VARCHAR (50)    NULL,
    [existenceTime_Beg]   DATETIME        CONSTRAINT [DF_E_Entity_existenceTime_Beg] DEFAULT (getdate()) NULL,
    [existenceTime_End]   DATETIME        NULL,
    [riskCode_OrTx]       VARCHAR (50)    NULL,
    [handlingCode_OrTx]   VARCHAR (50)    NULL,
    [metaCode]            VARCHAR (50)    NULL,
    [desc_Txt]            VARCHAR (100)   NULL,
    [localId]             VARCHAR (50)    NULL,
    [code_ID]             INT             NULL,
    [handlingCode_ID]     INT             NULL,
    [riskCode_ID]         INT             NULL,
    [ServerId]            INT             NULL,
    [ID]                  INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [EntityHx_ID]         INT             NULL,
    CONSTRAINT [E_Entity_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [E_Entity_E_Entity_FK1] FOREIGN KEY ([EntityHx_ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_Entity_code_ID_V_UNIFIEDCODESET] FOREIGN KEY ([code_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_Entity_handlingCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([handlingCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_Entity_riskCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([riskCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[E_Entity] NOCHECK CONSTRAINT [E_Entity_E_Entity_FK1];


GO
ALTER TABLE [dbo].[E_Entity] NOCHECK CONSTRAINT [FK_A_E_Entity_code_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[E_Entity] NOCHECK CONSTRAINT [FK_A_E_Entity_handlingCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[E_Entity] NOCHECK CONSTRAINT [FK_A_E_Entity_riskCode_ID_V_UNIFIEDCODESET];


GO
CREATE NONCLUSTERED INDEX [IX_E_Entity]
    ON [dbo].[E_Entity]([EntityHx_ID] ASC, [classCode] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_Metacode_StatusCode_CodeID]
    ON [dbo].[E_Entity]([metaCode] ASC, [statusCode] ASC, [code_ID] ASC)
    INCLUDE([ID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_E_Entity_2]
    ON [dbo].[E_Entity]([classCode] ASC, [determinerCode] ASC, [metaCode] ASC, [statusCode] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_E_Entity_3]
    ON [dbo].[E_Entity]([desc_Txt] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_E_Entity_4]
    ON [dbo].[E_Entity]([classCode] ASC, [determinerCode] ASC, [statusCode] ASC)
    INCLUDE([ID], [existenceTime_Beg]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
ALTER INDEX [IX_E_Entity_4]
    ON [dbo].[E_Entity] DISABLE;


GO
CREATE NONCLUSTERED INDEX [IX_E_Entity_classCode_metacode_inc]
    ON [dbo].[E_Entity]([classCode] ASC, [metaCode] ASC)
    INCLUDE([ID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE STATISTICS [IX_E_ENTITY_ID_CODECVDO_CODE_CLASSCODE_DETIRMINERCODE_METACODE]
    ON [dbo].[E_Entity]([ID], [code_ID], [classCode], [determinerCode], [metaCode]);

