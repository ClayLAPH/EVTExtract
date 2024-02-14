CREATE TABLE [dwh].[FACT_PHPersonalRecord] (
    [PR_RowID]                     INT      NOT NULL,
    [PR_RecordTypeCodeID]          TINYINT  NULL,
    [PR_PersonDR]                  INT      NOT NULL,
    [PR_DiseaseDR]                 INT      NULL,
    [PR_StandardAge]               REAL     NULL,
    [PR_StandardAgeMonths]         SMALLINT NULL,
    [PR_StandardAgeDays]           SMALLINT NULL,
    [PR_IsPregnant]                TINYINT  NULL,
    [PR_ExpectedDeliveryDate]      DATETIME NULL,
    [PR_DistrictDR]                INT      NULL,
    [PR_SecondaryDistrictDR]       INT      NULL,
    [PR_NurseInvestigatorDR]       INT      NULL,
    [PR_ProviderDR]                INT      NULL,
    [PR_LaboratoryDR]              INT      NULL,
    [PR_AdditionalLaboratoryDR]    INT      NULL,
    [PR_AdditionalProviderDR]      INT      NULL,
    [PR_IsIndexCase]               BIT      NULL,
    [PR_IsPatientDiedOfTheIllness] BIT      NULL,
    [PR_IsPatientHospitalized]     BIT      NULL,
    [PR_HospitalDR]                INT      NULL,
    [PR_InPatient]                 BIT      NULL,
    [PR_OutPatient]                BIT      NULL,
    [PR_DateOfOnset]               DATETIME NULL,
    [PR_IsAsymptomatic]            BIT      NULL,
    [PR_LABSpecimenCollectedDate]  DATETIME NULL,
    [PR_LABSpecimenResultDate]     DATETIME NULL,
    [PR_DateOfDiagnosis]           DATETIME NULL,
    [PR_DateOfDeath]               DATETIME NULL,
    [PR_DateReceived]              DATETIME NULL,
    [PR_DateCreated]               DATETIME NULL,
    [PR_EpisodeDate]               DATETIME NULL,
    [PR_DateClosed]                DATETIME NULL,
    [PR_DateAdmitted]              DATETIME NULL,
    [PR_DateDischarged]            DATETIME NULL,
    [PR_DateLastEdited]            DATETIME NULL,
    [PR_ProcessStatusDR]           INT      NULL,
    [PR_ReportedByWeb]             BIT      NULL,
    [PR_ReportedByEHR]             BIT      NULL,
    [PR_ReportedByLab]             BIT      NULL,
    [PR_ResolutionStatusDR]        INT      NULL,
    [PR_FinalDispositionDR]        INT      NULL,
    [PR_TransmissionStatusDR]      INT      NULL,
    [PR_MinTiters]                 INT      NULL,
    CONSTRAINT [FACT_PHPersonalRecord_PK] PRIMARY KEY CLUSTERED ([PR_RowID] DESC) ON [DWH_DataGroup],
    CONSTRAINT [FK_FACT_PHPersonalRecord_FACT_Person] FOREIGN KEY ([PR_PersonDR]) REFERENCES [dwh].[FACT_Person] ([PER_RowID]) ON DELETE CASCADE
) ON [DWH_DataGroup];


GO
CREATE NONCLUSTERED INDEX [FACT_PHPersonalRecord_PersonDR_NonClusteredIndex]
    ON [dwh].[FACT_PHPersonalRecord]([PR_PersonDR] ASC)
    INCLUDE([PR_RowID]) WITH (FILLFACTOR = 80)
    ON [DWH_IndexGroup];


GO
CREATE COLUMNSTORE INDEX [FACT_PHPersonalRecord_NonClusteredColumnStoreIndex]
    ON [dwh].[FACT_PHPersonalRecord]([PR_RowID], [PR_PersonDR], [PR_DiseaseDR], [PR_StandardAge], [PR_StandardAgeMonths], [PR_StandardAgeDays], [PR_IsPregnant], [PR_ExpectedDeliveryDate], [PR_DistrictDR], [PR_SecondaryDistrictDR], [PR_NurseInvestigatorDR], [PR_ProviderDR], [PR_LaboratoryDR], [PR_AdditionalLaboratoryDR], [PR_AdditionalProviderDR], [PR_IsIndexCase], [PR_IsPatientDiedOfTheIllness], [PR_IsPatientHospitalized], [PR_HospitalDR], [PR_InPatient], [PR_OutPatient], [PR_DateOfOnset], [PR_IsAsymptomatic], [PR_LABSpecimenCollectedDate], [PR_LABSpecimenResultDate], [PR_DateOfDiagnosis], [PR_DateOfDeath], [PR_DateReceived], [PR_DateCreated], [PR_EpisodeDate], [PR_DateClosed], [PR_DateAdmitted], [PR_DateDischarged], [PR_DateLastEdited], [PR_ProcessStatusDR], [PR_ReportedByWeb], [PR_ReportedByEHR], [PR_ReportedByLab], [PR_ResolutionStatusDR], [PR_FinalDispositionDR], [PR_TransmissionStatusDR], [PR_MinTiters], [PR_RecordTypeCodeID])
    ON [DWH_IndexGroup];

