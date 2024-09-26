CREATE TABLE [dbo].[Ax_DrugSusceptibility] (
    [DSR_ID]            INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DSR_LabreportID]   INT           NULL,
    [DSR_DrugDR]        INT           NULL,
    [DSR_OtherDrugName] VARCHAR (550) NULL,
    [DSR_Concentration] VARCHAR (255) NULL,
    [DSR_Method]        VARCHAR (255) NULL,
    [DSR_ResultDR]      INT           NULL,
    [DSR_StatusCode]    VARCHAR (50)  NULL,
    [DSR_DrugLoincCode] VARCHAR (255) NULL,
    [DSR_DrugLocalCode] VARCHAR (255) NULL,
    CONSTRAINT [PK_Ax_DrugSusceptibility] PRIMARY KEY CLUSTERED ([DSR_ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_Ax_DrugSusceptibility_A_Act] FOREIGN KEY ([DSR_LabreportID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ax_DrugSusceptibility_V_UnifiedCodeSet] FOREIGN KEY ([DSR_DrugDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ax_DrugSusceptibility_V_UnifiedCodeSet1] FOREIGN KEY ([DSR_ResultDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[Ax_DrugSusceptibility] NOCHECK CONSTRAINT [FK_Ax_DrugSusceptibility_A_Act];


GO
ALTER TABLE [dbo].[Ax_DrugSusceptibility] NOCHECK CONSTRAINT [FK_Ax_DrugSusceptibility_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[Ax_DrugSusceptibility] NOCHECK CONSTRAINT [FK_Ax_DrugSusceptibility_V_UnifiedCodeSet1];


GO
ALTER TABLE [dbo].[Ax_DrugSusceptibility] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_Ax_DrugSusceptibility]
    ON [dbo].[Ax_DrugSusceptibility]([DSR_LabreportID] ASC) WITH (FILLFACTOR = 70);

