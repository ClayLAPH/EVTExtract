CREATE TABLE [dwh].[FACT_Person] (
    [PER_RowID]                        INT            NOT NULL,
    [PER_RootID]                       INT            NOT NULL,
    [PER_IsPatient]                    BIT            NULL,
    [PER_IsContact]                    BIT            NULL,
    [PER_IsFamily]                     BIT            NULL,
    [PER_PrimaryLanguageDR]            INT            NULL,
    [PER_PrimaryNationalityDR]         INT            NULL,
    [PER_EthnicityDR]                  INT            NULL,
    [PER_ReportedRaceDR]               INT            NULL,
    [PER_CountryOfBirthDR]             INT            NULL,
    [PER_ResidenceCountyDR]            INT            NULL,
    [PER_DateOfUSArrival]              DATETIME       NULL,
    [PER_MaritalStatusDR]              INT            NULL,
    [PER_WorkSchoolLocationDR]         INT            NULL,
    [PER_WorkSchoolContact]            NVARCHAR (100) NULL,
    [PER_GuardianName]                 NVARCHAR (50)  NULL,
    [PER_OccupationSettingTypeDR]      INT            NULL,
    [PER_OccupationSettingTypeSpecify] NVARCHAR (50)  NULL,
    [PER_OccupationDR]                 INT            NULL,
    [PER_OccupationSpecify]            NVARCHAR (50)  NULL,
    [PER_OccupationLocation]           NVARCHAR (255) NULL,
    [PER_DeceasedStatusDR]             INT            NULL,
    [PER_DOD]                          DATETIME       NULL,
    [PER_StatusFlagDR]                 INT            NULL,
    CONSTRAINT [FACT_Person_PK] PRIMARY KEY CLUSTERED ([PER_RowID] DESC) ON [DWH_DataGroup]
) ON [DWH_DataGroup];


GO
CREATE NONCLUSTERED INDEX [FACT_Person_PER_RootID_NonClusteredIndex]
    ON [dwh].[FACT_Person]([PER_RootID] ASC)
    INCLUDE([PER_RowID]) WITH (FILLFACTOR = 80)
    ON [DWH_IndexGroup];


GO
CREATE COLUMNSTORE INDEX [FACT_Person_NonClusteredColumnStoreIndex]
    ON [dwh].[FACT_Person]([PER_RowID], [PER_RootID], [PER_IsPatient], [PER_IsContact], [PER_IsFamily], [PER_PrimaryLanguageDR], [PER_PrimaryNationalityDR], [PER_EthnicityDR], [PER_ReportedRaceDR], [PER_CountryOfBirthDR], [PER_ResidenceCountyDR], [PER_DateOfUSArrival], [PER_MaritalStatusDR], [PER_WorkSchoolLocationDR], [PER_WorkSchoolContact], [PER_GuardianName], [PER_OccupationSettingTypeDR], [PER_OccupationSettingTypeSpecify], [PER_OccupationDR], [PER_OccupationSpecify], [PER_OccupationLocation], [PER_DeceasedStatusDR], [PER_DOD], [PER_StatusFlagDR])
    ON [DWH_IndexGroup];

