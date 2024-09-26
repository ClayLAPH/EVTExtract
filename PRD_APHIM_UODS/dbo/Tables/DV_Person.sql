CREATE TABLE [dbo].[DV_Person] (
    [DVPER_IsPatient]                    BIT           NOT NULL,
    [DVPER_IsContact]                    BIT           NOT NULL,
    [DVPER_IsFamilyMember]               BIT           NOT NULL,
    [DVPER_LastName]                     VARCHAR (100) NULL,
    [DVPER_FirstName]                    VARCHAR (100) NULL,
    [DVPER_SSN]                          VARCHAR (50)  NULL,
    [DVPER_StreetAddress]                VARCHAR (100) NULL,
    [DVPER_Apartment]                    VARCHAR (100) NULL,
    [DVPER_City]                         VARCHAR (100) NULL,
    [DVPER_State]                        VARCHAR (100) NULL,
    [DVPER_Zip]                          VARCHAR (100) NULL,
    [DVPER_DOB]                          DATETIME      NULL,
    [DVPER_CreateDate]                   DATETIME      NULL,
    [DVPER_SourceIdentifier]             VARCHAR (50)  NULL,
    [DVPER_NCMID]                        INT           NULL,
    [DVPER_LastNameAlphaUp]              VARCHAR (100) NULL,
    [DVPER_FirstNameAlphaUp]             VARCHAR (100) NULL,
    [DVPER_HomePhone]                    VARCHAR (100) NULL,
    [DVPER_HomePhoneAlphaUp]             AS            ([dbo].[ALPHAUP]([DVPER_HomePhone])) PERSISTED,
    [DVPER_WorkSchoolPhone]              VARCHAR (100) NULL,
    [DVPER_Address]                      VARCHAR (550) NULL,
    [DVPER_CellPhone]                    VARCHAR (100) NULL,
    [DVPER_EthnicityCode_ID]             INT           NULL,
    [DVPER_ImportOptionsCode_ID]         INT           NULL,
    [DVPER_MaritalStatusCode_ID]         INT           NULL,
    [DVPER_NamespaceCode_ID]             INT           NULL,
    [DVPER_OccupationCode_ID]            INT           NULL,
    [DVPER_RaceCode_ID]                  INT           NULL,
    [DVPER_SexCode_ID]                   INT           NULL,
    [DVPER_RootID]                       INT           NULL,
    [DVPER_RowID]                        INT           NOT NULL,
    [DVPER_WorkSchoolPhoneAlphaUp]       AS            ([dbo].[ALPHAUP]([DVPER_WorkSchoolPhone])) PERSISTED,
    [DVPER_CensusTract]                  VARCHAR (100) NULL,
    [DVPER_CellPhoneAlphaUp]             AS            ([dbo].[ALPHAUP]([DVPER_CellPhone])) PERSISTED,
    [DVPER_ResidenceCountyDR]            INT           NULL,
    [DVPER_DateOfUSArrival]              DATETIME      NULL,
    [DVPER_OccupationSpecify]            VARCHAR (50)  NULL,
    [DVPER_OccupationSettingTypeDR]      INT           NULL,
    [DVPER_OccupationSettingTypeSpecify] VARCHAR (50)  NULL,
    [DVPER_OccupationLocation]           VARCHAR (255) NULL,
    [DVPER_GuardianName]                 VARCHAR (50)  NULL,
    [DVPER_WorkSchoolContact]            VARCHAR (100) NULL,
    [DVPER_EmailID]                      VARCHAR (100) NULL,
    [DVPER_ElectronicContact]            VARCHAR (100) NULL,
    [DVPER_DOD]                          DATETIME      NULL,
    [DVPER_DeceasedStatusDR]             INT           NULL,
    [DVPER_StatusFlagDR]                 INT           NULL,
    [DVPER_PrimaryNationalityDR]         INT           NULL,
    [DVPER_DOBText]                      CHAR (8)      NULL,
    [DVPER_Namespace]                    TINYINT       NULL,
    [DVPER_Age]                          INT           NULL,
    CONSTRAINT [Person_PK] PRIMARY KEY CLUSTERED ([DVPER_RowID] DESC) WITH (FILLFACTOR = 95) ON [DV_DataGroup],
    CONSTRAINT [E_Entity_DV_Person_FK3] FOREIGN KEY ([DVPER_RowID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [E_Entity_DV_Person_FK4] FOREIGN KEY ([DVPER_RootID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_Person_DVPER_DeceasedStatusDR_V_UNIFIEDCODESET] FOREIGN KEY ([DVPER_DeceasedStatusDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_Person_DVPER_EthnicityCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPER_EthnicityCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_Person_DVPER_ImportOptionsCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPER_ImportOptionsCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_Person_DVPER_MaritalStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPER_MaritalStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_Person_DVPER_NamespaceCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPER_NamespaceCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_Person_DVPER_OccupationCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPER_OccupationCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_Person_DVPER_PrimaryNationalityDR_V_UNIFIEDCODESET] FOREIGN KEY ([DVPER_PrimaryNationalityDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_Person_DVPER_RaceCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPER_RaceCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_Person_DVPER_SexCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DVPER_SexCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_DV_Person_DVPER_StatusFlagDR_V_UNIFIEDCODESET] FOREIGN KEY ([DVPER_StatusFlagDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
) ON [DV_DataGroup];


GO
ALTER TABLE [dbo].[DV_Person] NOCHECK CONSTRAINT [E_Entity_DV_Person_FK3];


GO
ALTER TABLE [dbo].[DV_Person] NOCHECK CONSTRAINT [E_Entity_DV_Person_FK4];


GO
ALTER TABLE [dbo].[DV_Person] NOCHECK CONSTRAINT [FK_A_DV_Person_DVPER_DeceasedStatusDR_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Person] NOCHECK CONSTRAINT [FK_A_DV_Person_DVPER_EthnicityCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Person] NOCHECK CONSTRAINT [FK_A_DV_Person_DVPER_ImportOptionsCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Person] NOCHECK CONSTRAINT [FK_A_DV_Person_DVPER_MaritalStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Person] NOCHECK CONSTRAINT [FK_A_DV_Person_DVPER_NamespaceCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Person] NOCHECK CONSTRAINT [FK_A_DV_Person_DVPER_OccupationCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Person] NOCHECK CONSTRAINT [FK_A_DV_Person_DVPER_PrimaryNationalityDR_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Person] NOCHECK CONSTRAINT [FK_A_DV_Person_DVPER_RaceCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Person] NOCHECK CONSTRAINT [FK_A_DV_Person_DVPER_SexCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Person] NOCHECK CONSTRAINT [FK_A_DV_Person_DVPER_StatusFlagDR_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[DV_Person] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_Address]
    ON [dbo].[DV_Person]([DVPER_Address] ASC, [DVPER_Namespace] ASC)
    INCLUDE([DVPER_RootID]) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_AlphaUpFirstName]
    ON [dbo].[DV_Person]([DVPER_FirstNameAlphaUp] ASC, [DVPER_Namespace] ASC)
    INCLUDE([DVPER_RootID]) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_AlphaUpName]
    ON [dbo].[DV_Person]([DVPER_LastNameAlphaUp] ASC, [DVPER_FirstNameAlphaUp] ASC, [DVPER_Namespace] ASC)
    INCLUDE([DVPER_RootID], [DVPER_LastName], [DVPER_FirstName]) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_CellPhoneAlphaUp]
    ON [dbo].[DV_Person]([DVPER_CellPhoneAlphaUp] ASC, [DVPER_Namespace] ASC)
    INCLUDE([DVPER_RootID]) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_CensusTract]
    ON [dbo].[DV_Person]([DVPER_CensusTract] ASC, [DVPER_Namespace] ASC)
    INCLUDE([DVPER_RootID]) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_CreateDate]
    ON [dbo].[DV_Person]([DVPER_CreateDate] ASC, [DVPER_Namespace] ASC)
    INCLUDE([DVPER_RootID]) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_DOBText]
    ON [dbo].[DV_Person]([DVPER_DOBText] ASC, [DVPER_Namespace] ASC)
    INCLUDE([DVPER_RootID]) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_FirstName]
    ON [dbo].[DV_Person]([DVPER_FirstName] ASC, [DVPER_Namespace] ASC)
    INCLUDE([DVPER_RootID]) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_HomePhoneAlphaUp]
    ON [dbo].[DV_Person]([DVPER_HomePhoneAlphaUp] ASC, [DVPER_Namespace] ASC)
    INCLUDE([DVPER_RootID]) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_ImportOption]
    ON [dbo].[DV_Person]([DVPER_ImportOptionsCode_ID] ASC) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_Name]
    ON [dbo].[DV_Person]([DVPER_LastName] ASC, [DVPER_FirstName] ASC, [DVPER_Namespace] ASC)
    INCLUDE([DVPER_RootID], [DVPER_SexCode_ID]) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_NamespaceImportOption]
    ON [dbo].[DV_Person]([DVPER_NamespaceCode_ID] ASC, [DVPER_ImportOptionsCode_ID] ASC) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_NCMID]
    ON [dbo].[DV_Person]([DVPER_NCMID] ASC)
    INCLUDE([DVPER_RootID]) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_RootID]
    ON [dbo].[DV_Person]([DVPER_RootID] ASC) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_SSN]
    ON [dbo].[DV_Person]([DVPER_SSN] ASC, [DVPER_Namespace] ASC)
    INCLUDE([DVPER_RootID]) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_WorkPhoneAlphaUp]
    ON [dbo].[DV_Person]([DVPER_WorkSchoolPhoneAlphaUp] ASC, [DVPER_Namespace] ASC)
    INCLUDE([DVPER_RootID]) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_DOB_RootID]
    ON [dbo].[DV_Person]([DVPER_DOB] ASC, [DVPER_RootID] ASC, [DVPER_NamespaceCode_ID] ASC, [DVPER_ImportOptionsCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_Zip]
    ON [dbo].[DV_Person]([DVPER_Zip] ASC, [DVPER_Namespace] ASC)
    INCLUDE([DVPER_RootID]) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_DOB]
    ON [dbo].[DV_Person]([DVPER_DOB] ASC, [DVPER_Namespace] ASC, [DVPER_Age] ASC)
    INCLUDE([DVPER_RootID]) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_NameAlphaUpPlus]
    ON [dbo].[DV_Person]([DVPER_LastNameAlphaUp] ASC, [DVPER_FirstNameAlphaUp] ASC, [DVPER_NamespaceCode_ID] ASC, [DVPER_ImportOptionsCode_ID] ASC, [DVPER_DOB] ASC, [DVPER_SexCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_DVPER_DOD]
    ON [dbo].[DV_Person]([DVPER_DOD] ASC, [DVPER_Namespace] ASC)
    INCLUDE([DVPER_RootID]) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [IX_DV_Person_Namespace]
    ON [dbo].[DV_Person]([DVPER_Namespace] ASC, [DVPER_IsContact] ASC) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE NONCLUSTERED INDEX [ix_Person_ForIU_JT]
    ON [dbo].[DV_Person]([DVPER_Namespace] ASC)
    INCLUDE([DVPER_FirstName], [DVPER_LastName], [DVPER_DOB], [DVPER_SSN], [DVPER_SexCode_ID], [DVPER_NCMID], [DVPER_RootID], [DVPER_RowID]) WITH (FILLFACTOR = 80)
    ON [DV_IndexGroup];


GO
CREATE STATISTICS [IX_WA_DVPER_EthnicityCode_ID]
    ON [dbo].[DV_Person]([DVPER_EthnicityCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVPER_MaritalStatusCode_ID]
    ON [dbo].[DV_Person]([DVPER_MaritalStatusCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVPER_OccupationCode_ID]
    ON [dbo].[DV_Person]([DVPER_OccupationCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVPER_RaceCode_ID]
    ON [dbo].[DV_Person]([DVPER_RaceCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVPER_RootID]
    ON [dbo].[DV_Person]([DVPER_RootID]);


GO
CREATE STATISTICS [IX_WA_DVPER_SexCode_ID]
    ON [dbo].[DV_Person]([DVPER_SexCode_ID]);


GO
CREATE STATISTICS [IX_WA_DVPER_City]
    ON [dbo].[DV_Person]([DVPER_City]);


GO
CREATE STATISTICS [IX_WA_DVPER_DOB]
    ON [dbo].[DV_Person]([DVPER_DOB]);


GO
CREATE STATISTICS [IX_WA_DVPER_FirstName]
    ON [dbo].[DV_Person]([DVPER_FirstName]);


GO
CREATE STATISTICS [IX_WA_DVPER_IsContact]
    ON [dbo].[DV_Person]([DVPER_IsContact]);


GO
CREATE STATISTICS [IX_WA_DVPER_IsFamilyMember]
    ON [dbo].[DV_Person]([DVPER_IsFamilyMember]);


GO
CREATE STATISTICS [IX_WA_DVPER_IsPatient]
    ON [dbo].[DV_Person]([DVPER_IsPatient]);


GO
CREATE STATISTICS [IX_WA_DVPER_LastName]
    ON [dbo].[DV_Person]([DVPER_LastName]);


GO
CREATE STATISTICS [IX_WA_DVPER_NCMID]
    ON [dbo].[DV_Person]([DVPER_NCMID]);


GO
CREATE STATISTICS [IX_WA_DVPER_State]
    ON [dbo].[DV_Person]([DVPER_State]);


GO
CREATE STATISTICS [IX_WA_DVPER_Zip]
    ON [dbo].[DV_Person]([DVPER_Zip]);

