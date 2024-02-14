﻿CREATE TABLE [dbo].[Ax_FBISymptom] (
    [FBIS_RowID]     INT NOT NULL,
    [FBIS_SymptomDR] INT NULL,
    CONSTRAINT [PK_Ax_FBISymptom] PRIMARY KEY CLUSTERED ([FBIS_RowID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_Ax_FBISymptom_A_Act] FOREIGN KEY ([FBIS_RowID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ax_FBISymptom_V_UnifiedCodeSet] FOREIGN KEY ([FBIS_SymptomDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[Ax_FBISymptom] NOCHECK CONSTRAINT [FK_Ax_FBISymptom_A_Act];


GO
ALTER TABLE [dbo].[Ax_FBISymptom] NOCHECK CONSTRAINT [FK_Ax_FBISymptom_V_UnifiedCodeSet];
