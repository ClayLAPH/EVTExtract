CREATE TABLE [dbo].[VCP_SystemFormFields] (
    [FIELD_SQLName]             VARCHAR (100)  NULL,
    [FIELD_DataTableName]       VARCHAR (100)  NULL,
    [FIELD_ShowInRequiredField] BIT            NULL,
    [FIELD_Visible]             BIT            NULL,
    [SubjCode_ID]               INT            NULL,
    [ID]                        INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FIELD_DataType_ID]         INT            NULL,
    [FIELD_ExportColumnOrder]   FLOAT (53)     NULL,
    [FIELD_ExportHeaderName]    VARCHAR (100)  NULL,
    [FIELD_DisplayName]         NVARCHAR (510) NULL,
    [LastModifiedOn]            DATETIME       NULL,
    [FIELD_VisibilityEditable]  BIT            CONSTRAINT [D_VCP_SystemFormFields_FIELD_VisibilityEditable] DEFAULT ((0)) NULL,
    [FIELD_LabelEditable]       BIT            CONSTRAINT [D_VCP_SystemFormFields_FIELD_LabelEditable] DEFAULT ((0)) NULL,
    CONSTRAINT [VCP_SystemFormFields_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [FK_A_VCP_SystemFormFields_FIELD_DataType_ID_V_UNIFIEDCODESET] FOREIGN KEY ([FIELD_DataType_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]),
    CONSTRAINT [FK_VCP_SystemFormFields_V_UnifiedCodeSet] FOREIGN KEY ([SubjCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID])
);


GO
ALTER TABLE [dbo].[VCP_SystemFormFields] NOCHECK CONSTRAINT [FK_A_VCP_SystemFormFields_FIELD_DataType_ID_V_UNIFIEDCODESET];


GO
CREATE NONCLUSTERED INDEX [IX_VCP_SystemFormFields_SV_SC]
    ON [dbo].[VCP_SystemFormFields]([SubjCode_ID] ASC, [FIELD_ShowInRequiredField] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

