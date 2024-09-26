CREATE TABLE [dbo].[S_ImportUtilityPERINC] (
    [S_ID]                                   INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PR_RowID]                               INT           NULL,
    [PR_Type]                                VARCHAR (10)  NULL,
    [PER_RowID]                              INT           NULL,
    [PR_InstanceID]                          VARCHAR (50)  NULL,
    [PER_LastName]                           VARCHAR (100) NULL,
    [PER_FirstName]                          VARCHAR (100) NULL,
    [PER_FirstInitial]                       VARCHAR (1)   NULL,
    [PER_DOB]                                DATETIME      NULL,
    [PER_SSN]                                VARCHAR (50)  NULL,
    [PER_Sex]                                INT           NULL,
    [PR_MedRecNum]                           VARCHAR (50)  NULL,
    [PR_DistrictDR]                          INT           NULL,
    [PR_DiseaseDR]                           INT           NULL,
    [SPEC_SpecimenDateCollected]             DATETIME      NULL,
    [SPEC_SpecimenDateCollectedWithin30Days] DATETIME      NULL,
    [PR_DateOfDiagnosis]                     DATETIME      NULL,
    [PR_DateOfDiagnosisWithin30Days]         DATETIME      NULL,
    [PER_IsCurrentVersion]                   VARCHAR (1)   NULL,
    [PER_CDCGender]                          VARCHAR (255) NULL,
    [PER_CLIENTID]                           INT           NULL,
    [SVC_CURRENTSERVICEDR]                   INT           NULL,
    [SVC_ID]                                 INT           NULL,
    [SPEC_RowID]                             INT           NULL,
    [PER_RootID]                             INT           NULL,
    CONSTRAINT [S_ImportUtilityPERINC_PK] PRIMARY KEY CLUSTERED ([S_ID] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_S_ImportUtilityPERINC_PR_Type_PR_InstanceID]
    ON [dbo].[S_ImportUtilityPERINC]([PR_Type] ASC, [PR_InstanceID] ASC) WITH (FILLFACTOR = 100)
    ON [PRIMARY_IDX];

