CREATE TABLE [dbo].[T_Value] (
    [createTime]                   DATETIME        NULL,
    [updateTime]                   DATETIME        NULL,
    [type]                         VARCHAR (50)    NOT NULL,
    [isValueNull]                  BIT             NULL,
    [valueNullFlavor]              VARCHAR (50)    NULL,
    [valueNullFlaveor_OrTx]        VARCHAR (50)    NULL,
    [valueReal]                    REAL            NULL,
    [valueInteger]                 INT             NULL,
    [valueImage]                   VARBINARY (MAX) NULL,
    [valueBool]                    BIT             NULL,
    [valueTS]                      DATETIME        NULL,
    [valueTSEnd]                   DATETIME        NULL,
    [valueString]                  VARCHAR (8000)  NULL,
    [valueNumerator]               REAL            NULL,
    [valueNumerator_Unit]          VARCHAR (50)    NULL,
    [valueNumerator_UnPr]          VARCHAR (50)    NULL,
    [valueNumerator_Alt]           REAL            NULL,
    [valueDenominator]             REAL            NULL,
    [valueDenominator_Unit]        VARCHAR (50)    NULL,
    [valueDenominator_UnPr]        VARCHAR (50)    NULL,
    [valueDenominator_Alt]         REAL            NULL,
    [valueCode_OrTx]               VARCHAR (50)    NULL,
    [metaCode]                     VARCHAR (50)    NULL,
    [valueString_Code]             VARCHAR (50)    NULL,
    [valueString_Txt]              VARCHAR (200)   NULL,
    [valueCode_ID]                 INT             NULL,
    [valueDenominator_Alt_Unit_ID] INT             NULL,
    [valueNumerator_Alt_Unit_ID]   INT             NULL,
    [ServerId]                     INT             NULL,
    [Value_ID]                     INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Act_ID]                       INT             NULL,
    [valueLink_ID]                 INT             NULL,
    CONSTRAINT [T_Value_PK] PRIMARY KEY CLUSTERED ([Value_ID] ASC) WITH (FILLFACTOR = 95) ON [TVALUE_DATA],
    CONSTRAINT [A_Act_T_Value_FK1] FOREIGN KEY ([Act_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_T_Value_valueCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([valueCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_T_Value_valueDenominator_Alt_Unit_ID_V_UNIFIEDCODESET] FOREIGN KEY ([valueDenominator_Alt_Unit_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_T_Value_valueNumerator_Alt_Unit_ID_V_UNIFIEDCODESET] FOREIGN KEY ([valueNumerator_Alt_Unit_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [S_Link_T_Value_FK1] FOREIGN KEY ([valueLink_ID]) REFERENCES [dbo].[S_Link] ([ID]) NOT FOR REPLICATION
) ON [TVALUE_DATA] TEXTIMAGE_ON [TVALUE_DATA];


GO
ALTER TABLE [dbo].[T_Value] NOCHECK CONSTRAINT [A_Act_T_Value_FK1];


GO
ALTER TABLE [dbo].[T_Value] NOCHECK CONSTRAINT [FK_A_T_Value_valueCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[T_Value] NOCHECK CONSTRAINT [FK_A_T_Value_valueDenominator_Alt_Unit_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[T_Value] NOCHECK CONSTRAINT [FK_A_T_Value_valueNumerator_Alt_Unit_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[T_Value] NOCHECK CONSTRAINT [S_Link_T_Value_FK1];


GO
CREATE NONCLUSTERED INDEX [IX_T_Value]
    ON [dbo].[T_Value]([Act_ID] ASC) WITH (FILLFACTOR = 70)
    ON [TVALUE_IDX];

