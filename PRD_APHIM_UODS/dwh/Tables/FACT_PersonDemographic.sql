CREATE TABLE [dwh].[FACT_PersonDemographic] (
    [PER_IDENTRowID]             INT            NOT NULL,
    [PER_ParentRowID]            INT            NOT NULL,
    [PER_IsPrimaryDemo]          BIT            DEFAULT ((0)) NOT NULL,
    [PER_IsVersionDemo]          BIT            DEFAULT ((0)) NOT NULL,
    [PER_IdentityType]           INT            NULL,
    [PER_LastName]               NVARCHAR (100) NULL,
    [PER_FirstName]              NVARCHAR (100) NULL,
    [PER_MiddleName]             NVARCHAR (100) NULL,
    [PER_ThirdName]              NVARCHAR (100) NULL,
    [PER_FourthName]             NVARCHAR (100) NULL,
    [PER_NamePrefix]             NVARCHAR (50)  NULL,
    [PER_NameSuffix]             NVARCHAR (50)  NULL,
    [PER_SSN]                    NVARCHAR (50)  NULL,
    [PER_DOB]                    DATETIME       NULL,
    [PER_GenderDR]               INT            NULL,
    [PER_HomePhone]              NVARCHAR (100) NULL,
    [PER_CellPhone]              NVARCHAR (100) NULL,
    [PER_WorkSchoolPhone]        NVARCHAR (100) NULL,
    [PER_Email]                  NVARCHAR (100) NULL,
    [PER_ElectronicContact]      NVARCHAR (100) NULL,
    [PER_DemoSourceTypeDR]       INT            NULL,
    [PER_SourceIdentifier]       NVARCHAR (50)  NULL,
    [PER_SourceDesc]             NVARCHAR (50)  NULL,
    [PER_FromDate]               DATETIME       NULL,
    [PER_ToDate]                 DATETIME       NULL,
    [PER_LastNameAlphaUp]        VARCHAR (100)  NULL,
    [PER_FirstNameAlphaUp]       VARCHAR (100)  NULL,
    [PER_FirstInitialAlphaUp]    VARCHAR (1)    NULL,
    [PER_HomePhoneAlphaUp]       VARCHAR (100)  NULL,
    [PER_WorkSchoolPhoneAlphaUp] VARCHAR (100)  NULL,
    [PER_IsActive]               BIT            CONSTRAINT [FACT_PersonDemographic_IsActive] DEFAULT ((0)) NOT NULL,
    [PER_LastNameSoundEx]        VARCHAR (5)    NULL,
    [PER_FirstNameSoundEx]       VARCHAR (5)    NULL,
    CONSTRAINT [FACT_PersonDemographic_PK] PRIMARY KEY CLUSTERED ([PER_IDENTRowID] DESC) ON [DWH_DataGroup],
    CONSTRAINT [FK_FACT_PersonDemographic_FACT_Person] FOREIGN KEY ([PER_ParentRowID]) REFERENCES [dwh].[FACT_Person] ([PER_RowID]) ON DELETE CASCADE
) ON [DWH_DataGroup];


GO
CREATE NONCLUSTERED INDEX [FACT_PersonDemographic_PER_ParentRowID_NonClusteredIndex]
    ON [dwh].[FACT_PersonDemographic]([PER_ParentRowID] ASC) WITH (FILLFACTOR = 80)
    ON [DWH_IndexGroup];


GO
CREATE COLUMNSTORE INDEX [FACT_PersonDemographic_NonClusteredColumnStoreIndex]
    ON [dwh].[FACT_PersonDemographic]([PER_IDENTRowID], [PER_ParentRowID], [PER_IsPrimaryDemo], [PER_IsVersionDemo], [PER_IdentityType], [PER_LastName], [PER_FirstName], [PER_MiddleName], [PER_ThirdName], [PER_FourthName], [PER_NamePrefix], [PER_NameSuffix], [PER_SSN], [PER_DOB], [PER_GenderDR], [PER_HomePhone], [PER_CellPhone], [PER_WorkSchoolPhone], [PER_Email], [PER_ElectronicContact], [PER_DemoSourceTypeDR], [PER_SourceIdentifier], [PER_SourceDesc], [PER_FromDate], [PER_ToDate], [PER_LastNameAlphaUp], [PER_FirstNameAlphaUp], [PER_FirstInitialAlphaUp], [PER_HomePhoneAlphaUp], [PER_WorkSchoolPhoneAlphaUp], [PER_IsActive], [PER_LastNameSoundEx], [PER_FirstNameSoundEx])
    ON [DWH_IndexGroup];


GO

CREATE TRIGGER [dwh].[TR_FPDSoundEx_AfterInsertUpdate] ON [DWH].[FACT_PersonDemographic]
AFTER INSERT,UPDATE
AS
UPDATE [DWH].[FACT_PersonDemographic]
SET [DWH].[FACT_PersonDemographic].PER_FirstNameSoundEx = SOUNDEX([DWH].[FACT_PersonDemographic].PER_FirstName)
    ,[DWH].[FACT_PersonDemographic].PER_LastNameSoundEx = SOUNDEX([DWH].[FACT_PersonDemographic].PER_LastName)
FROM [DWH].[FACT_PersonDemographic]
INNER JOIN inserted i ON [DWH].[FACT_PersonDemographic].PER_IDENTRowID = i.PER_IDENTRowID
