CREATE TABLE [dwh].[FACT_PersonAddress] (
    [PER_ADDRRowID]        INT            NOT NULL,
    [PER_ParentRowID]      INT            NOT NULL,
    [PER_IsPrimaryAdd]     BIT            DEFAULT ((0)) NOT NULL,
    [PER_IsVersionAddr]    BIT            DEFAULT ((0)) NOT NULL,
    [PER_StreetAddress]    NVARCHAR (100) NULL,
    [PER_Apartment]        NVARCHAR (100) NULL,
    [PER_City]             NVARCHAR (100) NULL,
    [PER_State]            NVARCHAR (100) NULL,
    [PER_Zip]              NVARCHAR (100) NULL,
    [PER_CountryDR]        INT            NULL,
    [PER_County]           NVARCHAR (100) NULL,
    [PER_AddressTypeDR]    INT            NULL,
    [PER_AddrSourceTypeDR] INT            NULL,
    [PER_FromDate]         DATETIME       NULL,
    [PER_ToDate]           DATETIME       NULL,
    [PER_IsActive]         BIT            CONSTRAINT [FACT_PersonAddress_IsActive] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [FACT_PersonAddress_PK] PRIMARY KEY CLUSTERED ([PER_ADDRRowID] DESC) ON [DWH_DataGroup],
    CONSTRAINT [FK_FACT_PersonAddress_FACT_Person] FOREIGN KEY ([PER_ParentRowID]) REFERENCES [dwh].[FACT_Person] ([PER_RowID]) ON DELETE CASCADE
) ON [DWH_DataGroup];


GO
CREATE NONCLUSTERED INDEX [FACT_PersonAddress_PER_ParentRowID_NonClusteredIndex]
    ON [dwh].[FACT_PersonAddress]([PER_ParentRowID] ASC) WITH (FILLFACTOR = 80)
    ON [DWH_IndexGroup];


GO
CREATE COLUMNSTORE INDEX [FACT_PersonAddress_NonClusteredColumnStoreIndex]
    ON [dwh].[FACT_PersonAddress]([PER_ADDRRowID], [PER_ParentRowID], [PER_IsPrimaryAdd], [PER_IsVersionAddr], [PER_StreetAddress], [PER_Apartment], [PER_City], [PER_State], [PER_Zip], [PER_CountryDR], [PER_County], [PER_AddressTypeDR], [PER_AddrSourceTypeDR], [PER_FromDate], [PER_ToDate], [PER_IsActive])
    ON [DWH_IndexGroup];

