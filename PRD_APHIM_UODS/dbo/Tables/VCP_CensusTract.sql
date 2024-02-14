CREATE TABLE [dbo].[VCP_CensusTract] (
    [CensusBlock]           VARCHAR (255) NULL,
    [SupervisorialDistrict] INT           NULL,
    [Network]               VARCHAR (255) NULL,
    [StudyArea]             VARCHAR (255) NULL,
    [CountyCode_ID]         INT           NULL,
    [DistrictCode_ID]       INT           NULL,
    [SubjCode_ID]           INT           NULL,
    [ID]                    INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    CONSTRAINT [VCP_CensusTract_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_A_VCP_CensusTract_CountyCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([CountyCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_CensusTract_DistrictCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DistrictCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_CensusTract_SubjCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([SubjCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[VCP_CensusTract] NOCHECK CONSTRAINT [FK_A_VCP_CensusTract_CountyCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_CensusTract] NOCHECK CONSTRAINT [FK_A_VCP_CensusTract_DistrictCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_CensusTract] NOCHECK CONSTRAINT [FK_A_VCP_CensusTract_SubjCode_ID_V_UNIFIEDCODESET];


GO
CREATE NONCLUSTERED INDEX [IX_VCP_CensusTract_SubjCode_SubjCvDo]
    ON [dbo].[VCP_CensusTract]([SubjCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

