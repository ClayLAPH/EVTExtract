CREATE TABLE [dbo].[T_Race] (
    [raceCode_OrTx] VARCHAR (50) NULL,
    [metaCode]      VARCHAR (50) NULL,
    [raceCode_ID]   INT          NULL,
    [ServerId]      INT          NULL,
    [ID]            INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Entity_ID]     INT          NULL,
    CONSTRAINT [T_Race_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [E_Person_T_Race_FK1] FOREIGN KEY ([Entity_ID]) REFERENCES [dbo].[E_Person] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_T_Race_raceCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([raceCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[T_Race] NOCHECK CONSTRAINT [E_Person_T_Race_FK1];


GO
ALTER TABLE [dbo].[T_Race] NOCHECK CONSTRAINT [FK_A_T_Race_raceCode_ID_V_UNIFIEDCODESET];


GO
CREATE NONCLUSTERED INDEX [IX_T_Race]
    ON [dbo].[T_Race]([Entity_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_Race_metaCode]
    ON [dbo].[T_Race]([metaCode] ASC, [Entity_ID] ASC, [raceCode_ID] ASC);


GO
CREATE STATISTICS [IX_WA_metaCode]
    ON [dbo].[T_Race]([metaCode]);

