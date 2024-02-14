CREATE TABLE [dbo].[VCP_IdentitySource] (
    [NamespaceID]   VARCHAR (255) NULL,
    [SourceType]    VARCHAR (255) NULL,
    [UniversalID]   VARCHAR (255) NULL,
    [UniversalType] VARCHAR (255) NULL,
    [SubjCode_ID]   INT           NULL,
    [ID]            INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    CONSTRAINT [VCP_IdentitySource_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [FK_A_VCP_IdentitySource_SubjCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([SubjCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[VCP_IdentitySource] NOCHECK CONSTRAINT [FK_A_VCP_IdentitySource_SubjCode_ID_V_UNIFIEDCODESET];


GO
CREATE NONCLUSTERED INDEX [IX_VCP_IdentitySource_SubjCode_SubjCvDo]
    ON [dbo].[VCP_IdentitySource]([SubjCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

