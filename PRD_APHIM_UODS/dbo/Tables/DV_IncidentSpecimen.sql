CREATE TABLE [dbo].[DV_IncidentSpecimen] (
    [DVIS_CollectionDate]      DATETIME       NULL,
    [DVIS_ReceivedDate]        DATETIME       NULL,
    [DVIS_SpecimenTypeCode_ID] INT            NULL,
    [DVIS_IncidentDR]          INT            NULL,
    [DVIS_RowID]               INT            NOT NULL,
    [DVIS_SpecimenResults]     VARCHAR (4000) NULL,
    CONSTRAINT [PK_DV_IncidentSpecimen] PRIMARY KEY NONCLUSTERED ([DVIS_RowID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_A_DV_IncidentSpecimen_DVIS_SpecimenTypeCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVIS_SpecimenTypeCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DV_IncidentSpecimen_DV_PHPersonalRecord] FOREIGN KEY ([DVIS_IncidentDR]) REFERENCES [dbo].[DV_PHPersonalRecord] ([DVPR_RowID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[DV_IncidentSpecimen] NOCHECK CONSTRAINT [FK_A_DV_IncidentSpecimen_DVIS_SpecimenTypeCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_IncidentSpecimen] NOCHECK CONSTRAINT [FK_DV_IncidentSpecimen_DV_PHPersonalRecord];


GO
CREATE NONCLUSTERED INDEX [IX_DV_IncidentSpecimen_IncidentDR]
    ON [dbo].[DV_IncidentSpecimen]([DVIS_IncidentDR] ASC)
    INCLUDE([DVIS_SpecimenTypeCode_ID]) WITH (FILLFACTOR = 80);

