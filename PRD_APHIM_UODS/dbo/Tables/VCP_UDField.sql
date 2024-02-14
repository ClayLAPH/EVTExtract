CREATE TABLE [dbo].[VCP_UDField] (
    [FIELD_ID]                  VARCHAR (50)  NULL,
    [FIELD_IsRequired]          BIT           NULL,
    [FIELD_ValidationScript]    VARCHAR (MAX) NULL,
    [FIELD_DESC]                VARCHAR (200) NULL,
    [FIELD_LinkedSystemField]   VARCHAR (50)  NULL,
    [FIELD_TypeCode_ID]         INT           NULL,
    [SubjCode_ID]               INT           NULL,
    [ID]                        INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FIELD_ValueString]         VARCHAR (MAX) NULL,
    [FIELD_SpanPageWidth]       BIT           DEFAULT ((0)) NULL,
    [FIELD_GenerateArnoldAlert] BIT           NULL,
    [FIELD_AlertTriggerValueDR] INT           NULL,
    [FIELD_AlertDisplayName]    VARCHAR (200) NULL,
    [FIELD_TextBoxIsEditable]   BIT           NULL,
    [FIELD_TextBoxNoOfLines]    INT           NULL,
    [FIELD_VocDefaultValueDR]   INT           NULL,
    CONSTRAINT [VCP_UDField_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [FK_A_VCP_UDField_FIELD_TypeCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([FIELD_TypeCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_UDField_SubjCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([SubjCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_UNIFIEDCODESET_VOCDEFAULTVALUEDR] FOREIGN KEY ([FIELD_VocDefaultValueDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]),
    CONSTRAINT [FK_VCP_UDField_AlertTriggerValueDR_V_UnifiedCodeSet] FOREIGN KEY ([FIELD_AlertTriggerValueDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[VCP_UDField] NOCHECK CONSTRAINT [FK_A_VCP_UDField_FIELD_TypeCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_UDField] NOCHECK CONSTRAINT [FK_A_VCP_UDField_SubjCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_UDField] NOCHECK CONSTRAINT [FK_UNIFIEDCODESET_VOCDEFAULTVALUEDR];


GO
ALTER TABLE [dbo].[VCP_UDField] NOCHECK CONSTRAINT [FK_VCP_UDField_AlertTriggerValueDR_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[VCP_UDField] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_VCP_UDField_SV_SC]
    ON [dbo].[VCP_UDField]([SubjCode_ID] ASC, [FIELD_IsRequired] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_VCP_UDField_SubjCode_ID]
    ON [dbo].[VCP_UDField]([SubjCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_VCP_FIELD_ID]
    ON [dbo].[VCP_UDField]([FIELD_ID] ASC)
    INCLUDE([FIELD_TypeCode_ID]) WITH (FILLFACTOR = 70);

