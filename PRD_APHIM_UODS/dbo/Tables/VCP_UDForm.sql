CREATE TABLE [dbo].[VCP_UDForm] (
    [FRM_LoadValidationScript]                  VARCHAR (MAX) NULL,
    [FRM_SaveValidationScript]                  VARCHAR (MAX) NULL,
    [FRM_IsTab]                                 BIT           NULL,
    [FRM_InCMR]                                 BIT           NULL,
    [FRM_InNCM]                                 BIT           NULL,
    [FRM_IsLocked]                              BIT           NULL,
    [FRM_ID]                                    VARCHAR (50)  NULL,
    [FRM_InPDA]                                 BIT           NULL,
    [FRM_DESC]                                  VARCHAR (255) NULL,
    [FRM_LoadPostbackValidationScript]          VARCHAR (MAX) NULL,
    [SubjCode_ID]                               INT           NULL,
    [ID]                                        INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FRM_IsMultipleInstance]                    BIT           NULL,
    [FRM_InProtocol]                            BIT           NULL,
    [FRM_DiscardExistingInstancesOnImportMatch] BIT           NULL,
    CONSTRAINT [VCP_UDForm_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [FK_A_VCP_UDForm_SubjCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([SubjCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[VCP_UDForm] NOCHECK CONSTRAINT [FK_A_VCP_UDForm_SubjCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_UDForm] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_VCP_UDForm_SubjCode_ID]
    ON [dbo].[VCP_UDForm]([SubjCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

