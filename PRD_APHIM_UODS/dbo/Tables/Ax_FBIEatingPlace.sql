CREATE TABLE [dbo].[Ax_FBIEatingPlace] (
    [FBIEP_RowID]         INT      NOT NULL,
    [FBIEP_EatingDate]    DATETIME NULL,
    [FBIEP_EatingPlaceDR] INT      NULL,
    [FBIEP_Primary]       BIT      NULL,
    CONSTRAINT [PK_Ax_FBIEatingPlace] PRIMARY KEY CLUSTERED ([FBIEP_RowID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_Ax_FBIEatingPlace_A_Act] FOREIGN KEY ([FBIEP_RowID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ax_FBIEatingPlace_E_Entity] FOREIGN KEY ([FBIEP_EatingPlaceDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[Ax_FBIEatingPlace] NOCHECK CONSTRAINT [FK_Ax_FBIEatingPlace_A_Act];


GO
ALTER TABLE [dbo].[Ax_FBIEatingPlace] NOCHECK CONSTRAINT [FK_Ax_FBIEatingPlace_E_Entity];


GO
CREATE NONCLUSTERED INDEX [IX_Ax_FBIEatingPlace_Location]
    ON [dbo].[Ax_FBIEatingPlace]([FBIEP_EatingPlaceDR] ASC)
    INCLUDE([FBIEP_RowID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
ALTER INDEX [IX_Ax_FBIEatingPlace_Location]
    ON [dbo].[Ax_FBIEatingPlace] DISABLE;

