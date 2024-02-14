CREATE TABLE [dwh].[FACT_LabInfo_String] (
    [DILR_RowID]                       INT             NOT NULL,
    [DILR_PRRowID]                     INT             NOT NULL,
    [DILR_MessageIdentifier]           VARCHAR (50)    NULL,
    [DILR_AccessionNumber]             NVARCHAR (300)  NULL,
    [DILR_SpecimenSourceDR]            INT             NULL,
    [DILR_SpecimenSourceText]          VARCHAR (705)   NULL,
    [DILR_TestDescriptionDR]           INT             NULL,
    [DILR_TestDescriptionText]         NVARCHAR (1000) NULL,
    [DILR_TestCode]                    NVARCHAR (255)  NULL,
    [DILR_LocalTestDescription]        NVARCHAR (1000) NULL,
    [DILR_LocalTestCode]               NVARCHAR (255)  NULL,
    [DILR_ResultTest]                  NVARCHAR (1100) NULL,
    [DILR_ResultValue]                 VARCHAR (4000)  NULL,
    [DILR_ResultUnit]                  NVARCHAR (255)  NULL,
    [DILR_ReferenceRange]              NVARCHAR (255)  NULL,
    [DILR_OrganismDescriptionDR]       INT             NULL,
    [DILR_OrganismDescriptionText]     NVARCHAR (300)  NULL,
    [DILR_OrganismCode]                NVARCHAR (255)  NULL,
    [DILR_LocalOrganismDescription]    NVARCHAR (1550) NULL,
    [DILR_LocalOrganismCode]           NVARCHAR (1270) NULL,
    [DILR_PerformingFacilityID]        NVARCHAR (255)  NULL,
    [DILR_PersonVerifiedResult]        NVARCHAR (255)  NULL,
    [DILR_RelevantClinicalInformation] NVARCHAR (300)  NULL,
    [DILR_ReasonForStudy]              NVARCHAR (199)  NULL,
    [DILR_Notes]                       NVARCHAR (MAX)  NULL,
    [DILR_Species]                     NVARCHAR (300)  NULL,
    [DILR_Serogroup]                   NVARCHAR (300)  NULL,
    [DILR_Serotype]                    NVARCHAR (300)  NULL,
    [DILR_PFGEPattern1st]              NVARCHAR (255)  NULL,
    [DILR_PFGEPattern2nd]              NVARCHAR (255)  NULL,
    [DILR_ProviderName]                NVARCHAR (255)  NULL,
    [DILR_ProviderID]                  NVARCHAR (255)  NULL,
    [DILR_ProviderPhone]               NVARCHAR (255)  NULL,
    [DILR_ProviderAddress]             NVARCHAR (255)  NULL,
    [DILR_ProviderCity]                NVARCHAR (255)  NULL,
    [DILR_ProviderState]               NVARCHAR (255)  NULL,
    [DILR_ProviderZip]                 NVARCHAR (255)  NULL,
    [DILR_ProviderCounty]              NVARCHAR (255)  NULL,
    [DILR_ProviderFax]                 NVARCHAR (255)  NULL,
    [DILR_ProviderEmail]               NVARCHAR (255)  NULL,
    [DILR_FacilityName]                NVARCHAR (255)  NULL,
    [DILR_FacilityID]                  NVARCHAR (255)  NULL,
    [DILR_PlacerOrderNo]               NVARCHAR (255)  NULL,
    [DILR_FacilityAddress]             NVARCHAR (255)  NULL,
    [DILR_FacilityCity]                NVARCHAR (255)  NULL,
    [DILR_FacilityState]               NVARCHAR (255)  NULL,
    [DILR_FacilityZip]                 NVARCHAR (255)  NULL,
    [DILR_FacilityCounty]              NVARCHAR (255)  NULL,
    [DILR_FacilityPhone]               NVARCHAR (255)  NULL,
    [DILR_FacilityEmail]               NVARCHAR (255)  NULL,
    [DILR_ProviderPhoneAlphaUp]        VARCHAR (255)   NULL,
    [DILR_ProviderFaxAlphaUp]          VARCHAR (255)   NULL,
    [DILR_FacilityPhoneAlphaUp]        VARCHAR (255)   NULL,
    CONSTRAINT [FACT_LabInfo_String_PK] PRIMARY KEY CLUSTERED ([DILR_RowID] ASC) ON [DWH_DataGroup],
    CONSTRAINT [FK_FACT_LabInfo_String_FACT_LabInfo] FOREIGN KEY ([DILR_RowID]) REFERENCES [dwh].[FACT_LabInfo] ([DILR_RowID]) ON DELETE CASCADE
) ON [DWH_DataGroup] TEXTIMAGE_ON [DWH_TextDataGroup];


GO
CREATE NONCLUSTERED INDEX [FACT_LabInfo_String_DILR_PRRowID_NonClusteredIndex]
    ON [dwh].[FACT_LabInfo_String]([DILR_PRRowID] ASC) WITH (FILLFACTOR = 80)
    ON [DWH_IndexGroup];


GO
CREATE COLUMNSTORE INDEX [FACT_LabInfo_String_NonClusteredColumnStoreIndex]
    ON [dwh].[FACT_LabInfo_String]([DILR_RowID], [DILR_PRRowID], [DILR_MessageIdentifier], [DILR_AccessionNumber], [DILR_SpecimenSourceText], [DILR_SpecimenSourceDR], [DILR_TestDescriptionDR], [DILR_TestDescriptionText], [DILR_TestCode], [DILR_LocalTestDescription], [DILR_LocalTestCode], [DILR_ResultTest], [DILR_ResultValue], [DILR_ResultUnit], [DILR_ReferenceRange], [DILR_OrganismDescriptionDR], [DILR_OrganismDescriptionText], [DILR_OrganismCode], [DILR_LocalOrganismDescription], [DILR_LocalOrganismCode], [DILR_PerformingFacilityID], [DILR_PersonVerifiedResult], [DILR_RelevantClinicalInformation], [DILR_ReasonForStudy], [DILR_Species], [DILR_Serogroup], [DILR_Serotype], [DILR_PFGEPattern1st], [DILR_PFGEPattern2nd], [DILR_ProviderName], [DILR_ProviderID], [DILR_ProviderPhone], [DILR_ProviderAddress], [DILR_ProviderCity], [DILR_ProviderState], [DILR_ProviderZip], [DILR_ProviderCounty], [DILR_ProviderFax], [DILR_ProviderEmail], [DILR_FacilityName], [DILR_FacilityID], [DILR_PlacerOrderNo], [DILR_FacilityAddress], [DILR_FacilityCity], [DILR_FacilityState], [DILR_FacilityZip], [DILR_FacilityCounty], [DILR_FacilityPhone], [DILR_FacilityEmail], [DILR_ProviderPhoneAlphaUp], [DILR_ProviderFaxAlphaUp], [DILR_FacilityPhoneAlphaUp])
    ON [DWH_IndexGroup];

