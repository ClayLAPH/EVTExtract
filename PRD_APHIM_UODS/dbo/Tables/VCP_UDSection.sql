CREATE TABLE [dbo].[VCP_UDSection] (
    [SEC_IsListSection]     BIT           NULL,
    [SEC_ID]                VARCHAR (50)  NULL,
    [SEC_IsLocked]          BIT           NULL,
    [SEC_DESC]              VARCHAR (200) NULL,
    [SubjCode_ID]           INT           NULL,
    [ID]                    INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SEC_ShareAcrossRecord] BIT           NULL,
    [SEC_ShareAcrossPerson] BIT           NULL,
    CONSTRAINT [VCP_UDSection_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [FK_A_VCP_UDSection_SubjCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([SubjCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[VCP_UDSection] NOCHECK CONSTRAINT [FK_A_VCP_UDSection_SubjCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_UDSection] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_VCP_UDSection_SubjCode_ID]
    ON [dbo].[VCP_UDSection]([SubjCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_VCPUDSection_SubjCode_ID_IsListSection]
    ON [dbo].[VCP_UDSection]([SEC_IsListSection] ASC, [SubjCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

