CREATE TABLE [dbo].[VCP_ArnoldLetter] (
    [Body]        VARCHAR (MAX) NULL,
    [Closing]     VARCHAR (MAX) NULL,
    [SubjCode_ID] INT           NULL,
    [ID]          INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    CONSTRAINT [VCP_ArnoldLetter_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [FK_A_VCP_ArnoldLetter_SubjCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([SubjCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[VCP_ArnoldLetter] NOCHECK CONSTRAINT [FK_A_VCP_ArnoldLetter_SubjCode_ID_V_UNIFIEDCODESET];


GO
CREATE NONCLUSTERED INDEX [IX_VCP_ArnoldLetter_SubjCode_SubjCvDo]
    ON [dbo].[VCP_ArnoldLetter]([SubjCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

