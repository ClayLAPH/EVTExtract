CREATE TABLE [dbo].[S_Census] (
    [year]                SMALLINT NULL,
    [month]               SMALLINT NULL,
    [day]                 SMALLINT NULL,
    [population]          REAL     NULL,
    [ageGroup_Code_ID]    INT      NULL,
    [ethnicGroup_Code_ID] INT      NULL,
    [region_Code_ID]      INT      NULL,
    [spa_Code_ID]         INT      NULL,
    [ID]                  INT      IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Site_ID]             INT      NULL,
    [CensusFile_ID]       INT      NULL,
    CONSTRAINT [S_Census_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [E_Entity_S_Census_FK1] FOREIGN KEY ([Site_ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_S_Census_ageGroup_Code_ID_V_UNIFIEDCODESET] FOREIGN KEY ([ageGroup_Code_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_S_Census_ethnicGroup_Code_ID_V_UNIFIEDCODESET] FOREIGN KEY ([ethnicGroup_Code_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_S_Census_region_Code_ID_V_UNIFIEDCODESET] FOREIGN KEY ([region_Code_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_S_Census_spa_Code_ID_V_UNIFIEDCODESET] FOREIGN KEY ([spa_Code_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_SCensus_CensusFile_ID] FOREIGN KEY ([CensusFile_ID]) REFERENCES [dbo].[S_CensusFile] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[S_Census] NOCHECK CONSTRAINT [E_Entity_S_Census_FK1];


GO
ALTER TABLE [dbo].[S_Census] NOCHECK CONSTRAINT [FK_A_S_Census_ageGroup_Code_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[S_Census] NOCHECK CONSTRAINT [FK_A_S_Census_ethnicGroup_Code_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[S_Census] NOCHECK CONSTRAINT [FK_A_S_Census_region_Code_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[S_Census] NOCHECK CONSTRAINT [FK_A_S_Census_spa_Code_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[S_Census] NOCHECK CONSTRAINT [FK_SCensus_CensusFile_ID];

