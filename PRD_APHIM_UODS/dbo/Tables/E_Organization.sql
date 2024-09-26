CREATE TABLE [dbo].[E_Organization] (
    [standardIndustryClassCode_OrTx] VARCHAR (50) NULL,
    [standardIndustryClassCode_ID]   INT          NULL,
    [ServerId]                       INT          NULL,
    [ID]                             INT          NOT NULL,
    CONSTRAINT [E_Organization_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [E_Entity_E_Organization_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_Organization_standardIndustryClassCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([standardIndustryClassCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[E_Organization] NOCHECK CONSTRAINT [E_Entity_E_Organization_FK1];


GO
ALTER TABLE [dbo].[E_Organization] NOCHECK CONSTRAINT [FK_A_E_Organization_standardIndustryClassCode_ID_V_UNIFIEDCODESET];


GO
CREATE NONCLUSTERED INDEX [IX_E_Organization]
    ON [dbo].[E_Organization]([standardIndustryClassCode_OrTx] ASC) WITH (FILLFACTOR = 70);


GO
CREATE STATISTICS [IX_WA_standardIndustryClassCode_OrTx]
    ON [dbo].[E_Organization]([standardIndustryClassCode_OrTx]);

