CREATE TABLE [dbo].[T_EntityAddress] (
    [useCode]                    VARCHAR (50)  NULL,
    [useCode_OrTx]               VARCHAR (50)  NULL,
    [validTime_Beg]              DATETIME      CONSTRAINT [DF_T_EntityAddress_validTime_Beg] DEFAULT (getdate()) NULL,
    [validTime_End]              DATETIME      NULL,
    [simpleAddress]              VARCHAR (MAX) NULL,
    [metaCode]                   VARCHAR (50)  NULL,
    [partSal]                    VARCHAR (100) NULL,
    [partAptNum]                 VARCHAR (100) NULL,
    [partCty]                    VARCHAR (100) NULL,
    [partSta]                    VARCHAR (100) NULL,
    [partZip]                    VARCHAR (100) NULL,
    [partCen]                    VARCHAR (100) NULL,
    [partCountyFIPS]             VARCHAR (100) NULL,
    [partCounty]                 VARCHAR (100) NULL,
    [partCountry]                VARCHAR (100) NULL,
    [partCenBlock]               VARCHAR (100) NULL,
    [partZipPlus4]               VARCHAR (100) NULL,
    [partGeoLong]                VARCHAR (100) NULL,
    [partGeoLat]                 VARCHAR (100) NULL,
    [partGeoError]               VARCHAR (100) NULL,
    [ServerId]                   INT           NULL,
    [ID]                         INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Entity_ID]                  INT           NULL,
    [Role_ID]                    INT           NULL,
    [PARTSTREETADDRESSFORSEARCH] AS            (CONVERT([varchar](500),replace((((isnull([PARTSAL],'')+isnull([PARTAPTNUM],''))+isnull([PARTCTY],''))+CONVERT([varchar](100),isnull([partSta],''),(0)))+isnull([PARTZIP],''),' ',''),(0))) PERSISTED,
    CONSTRAINT [T_EntityAddress_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [E_Entity_T_EntityAddress_FK1] FOREIGN KEY ([Entity_ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [R_Role_T_EntityAddress_FK1] FOREIGN KEY ([Role_ID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[T_EntityAddress] NOCHECK CONSTRAINT [E_Entity_T_EntityAddress_FK1];


GO
ALTER TABLE [dbo].[T_EntityAddress] NOCHECK CONSTRAINT [R_Role_T_EntityAddress_FK1];


GO
CREATE NONCLUSTERED INDEX [IX_T_EntityAddress_EntityID_PartStreetAddForSearch]
    ON [dbo].[T_EntityAddress]([Entity_ID] ASC, [PARTSTREETADDRESSFORSEARCH] ASC)
    INCLUDE([partSal], [partAptNum], [partCty], [partSta], [partZip], [partCountry], [useCode], [ID]) WITH (FILLFACTOR = 70);


GO
CREATE NONCLUSTERED INDEX [IX_T_EntityAddress_PartStreetAddForSearch_usecode]
    ON [dbo].[T_EntityAddress]([PARTSTREETADDRESSFORSEARCH] ASC, [useCode] ASC)
    INCLUDE([Entity_ID], [ID]) WITH (FILLFACTOR = 70);


GO
CREATE NONCLUSTERED INDEX [ix_T_EntityAddress_jt]
    ON [dbo].[T_EntityAddress]([useCode] ASC, [partGeoLong] ASC, [partGeoLat] ASC)
    INCLUDE([Entity_ID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
ALTER INDEX [ix_T_EntityAddress_jt]
    ON [dbo].[T_EntityAddress] DISABLE;


GO
CREATE NONCLUSTERED INDEX [IX_T_EntityAddress_2]
    ON [dbo].[T_EntityAddress]([Role_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_T_EntityAddress_UseCode]
    ON [dbo].[T_EntityAddress]([useCode] ASC, [useCode_OrTx] ASC)
    INCLUDE([Entity_ID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_T_EntityAddress_PartSal_UseCode]
    ON [dbo].[T_EntityAddress]([partSal] ASC, [useCode] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [ix_T_EntityAddress_2_jt]
    ON [dbo].[T_EntityAddress]([useCode] ASC, [partGeoLong] ASC, [partGeoLat] ASC, [partSal] ASC)
    INCLUDE([Entity_ID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

