﻿CREATE TABLE [dbo].[issue159934] (
    [DVPR_IncidentID]                    INT            NOT NULL,
    [DVPR_CMRID]                         VARCHAR (50)   NOT NULL,
    [DVPR_MRN]                           VARCHAR (50)   NULL,
    [DVPR_CreateDate]                    DATETIME       NOT NULL,
    [DVPR_OnsetDate]                     DATETIME       NULL,
    [DVPR_EpisodeDate]                   DATETIME       NULL,
    [DVPR_ClosedDate]                    DATETIME       NULL,
    [DVPR_DateReportedBy]                DATETIME       NULL,
    [DVPR_StandardAge]                   REAL           NULL,
    [DVPR_DateSubmitted]                 DATETIME       NULL,
    [DVPR_IsIndexCase]                   BIT            NULL,
    [DVPR_ClusterID]                     VARCHAR (8000) NULL,
    [DVPR_DiagnosisDate]                 DATETIME       NULL,
    [DVPR_DiagSpecimenTypes]             VARCHAR (8000) NULL,
    [DVPR_ExpExposureTypes]              VARCHAR (3000) NULL,
    [DVPR_HepatitisDRs]                  VARCHAR (1500) NULL,
    [DVPR_DiseaseCode_ID]                INT            NULL,
    [DVPR_DistrictCode_ID]               INT            NULL,
    [DVPR_OriginalDistrictCode_ID]       INT            NULL,
    [DVPR_ProcessStatusCode_ID]          INT            NULL,
    [DVPR_ResolutionStatusCode_ID]       INT            NULL,
    [DVPR_SecondaryDistrictCode_ID]      INT            NULL,
    [DVPR_TransmissionStatusCode_ID]     INT            NULL,
    [DVPR_NurseInvestigatorDR]           INT            NULL,
    [DVPR_PersonDR]                      INT            NULL,
    [DVPR_ReportSourceDR]                INT            NULL,
    [DVPR_RowID]                         INT            NOT NULL,
    [DVPR_UserDR]                        INT            NULL,
    [DVPR_TypeDR]                        INT            NULL,
    [DVPR_OutbreakDRsText]               VARCHAR (MAX)  NULL,
    [DVPR_OutbreakNumbers]               VARCHAR (MAX)  NULL,
    [DVPR_OutbreakTypes]                 VARCHAR (MAX)  NULL,
    [DVPR_ReceivedDate]                  DATETIME       NULL,
    [DVPR_LABSpecimenCollectedDate]      DATETIME       NULL,
    [DVPR_NameOfSubmitter]               VARCHAR (100)  NULL,
    [DVPR_ImportedStatus]                INT            NULL,
    [DVPR_FinalDisposition]              INT            NULL,
    [DVPR_TRANSMISSIONSTATUS]            INT            NULL,
    [DVPR_OutPatient]                    BIT            NULL,
    [DVPR_InPatient]                     BIT            NULL,
    [DVPR_LIPRESULTVALUE]                VARCHAR (8000) NULL,
    [DVPR_LIPTESTORDERED]                VARCHAR (255)  NULL,
    [DVPR_TypeOfContactDR]               INT            NULL,
    [DVPR_PriorityDR]                    INT            NULL,
    [DVPR_ReportedbyWeb]                 BIT            NULL,
    [DVPR_ProviderName]                  VARCHAR (255)  NULL,
    [DVPR_ReportedByLab]                 BIT            NULL,
    [DVPR_ReportedByEHR]                 BIT            NULL,
    [DVPR_OtherDiseaseName]              VARCHAR (200)  NULL,
    [DVPR_DATEOFDEATH]                   DATETIME       NULL,
    [DVPR_ISPREGNANT]                    BIT            NULL,
    [DVPR_EXPECTEDDELIVERYDATE]          DATETIME       NULL,
    [DVPR_LIPRESULTNOTES]                VARCHAR (8000) NULL,
    [DVPR_ISPATIENTDIEDOFTHEILLNESS]     BIT            NULL,
    [DVPR_DateSent]                      DATETIME       NULL,
    [DVPR_DateLastUpdateSent]            DATETIME       NULL,
    [DVPR_LIPRESULTNAME]                 VARCHAR (255)  NULL,
    [DVPR_ISASYMPTOMATIC]                BIT            NULL,
    [DVPR_LABSpecimenResultDate]         DATETIME       NULL,
    [DVPR_DateAdmitted]                  DATETIME       NULL,
    [DVPR_DateDischarged]                DATETIME       NULL,
    [DVPR_DateLastEdited]                DATETIME       NULL,
    [DVPR_Notes]                         VARCHAR (MAX)  NULL,
    [DVPR_DateInvestigatorReceived]      DATETIME       NULL,
    [DVPR_IsPatientHospitalized]         BIT            NULL,
    [DVPER_IsPatient]                    BIT            NOT NULL,
    [DVPER_IsContact]                    BIT            NOT NULL,
    [DVPER_IsFamilyMember]               BIT            NOT NULL,
    [DVPER_LastName]                     VARCHAR (100)  NULL,
    [DVPER_FirstName]                    VARCHAR (100)  NULL,
    [DVPER_SSN]                          VARCHAR (50)   NULL,
    [DVPER_StreetAddress]                VARCHAR (100)  NULL,
    [DVPER_Apartment]                    VARCHAR (100)  NULL,
    [DVPER_City]                         VARCHAR (100)  NULL,
    [DVPER_State]                        VARCHAR (100)  NULL,
    [DVPER_Zip]                          VARCHAR (100)  NULL,
    [DVPER_DOB]                          DATETIME       NULL,
    [DVPER_CreateDate]                   DATETIME       NULL,
    [DVPER_SourceIdentifier]             VARCHAR (50)   NULL,
    [DVPER_NCMID]                        INT            NULL,
    [DVPER_LastNameAlphaUp]              VARCHAR (100)  NULL,
    [DVPER_FirstNameAlphaUp]             VARCHAR (100)  NULL,
    [DVPER_HomePhone]                    VARCHAR (100)  NULL,
    [DVPER_HomePhoneAlphaUp]             VARCHAR (50)   NULL,
    [DVPER_WorkSchoolPhone]              VARCHAR (100)  NULL,
    [DVPER_Address]                      VARCHAR (550)  NULL,
    [DVPER_CellPhone]                    VARCHAR (100)  NULL,
    [DVPER_EthnicityCode_ID]             INT            NULL,
    [DVPER_ImportOptionsCode_ID]         INT            NULL,
    [DVPER_MaritalStatusCode_ID]         INT            NULL,
    [DVPER_NamespaceCode_ID]             INT            NULL,
    [DVPER_OccupationCode_ID]            INT            NULL,
    [DVPER_RaceCode_ID]                  INT            NULL,
    [DVPER_SexCode_ID]                   INT            NULL,
    [DVPER_RootID]                       INT            NULL,
    [DVPER_RowID]                        INT            NOT NULL,
    [DVPER_WorkSchoolPhoneAlphaUp]       VARCHAR (50)   NULL,
    [DVPER_CensusTract]                  VARCHAR (100)  NULL,
    [DVPER_CellPhoneAlphaUp]             VARCHAR (50)   NULL,
    [DVPER_ResidenceCountyDR]            INT            NULL,
    [DVPER_DateOfUSArrival]              DATETIME       NULL,
    [DVPER_OccupationSpecify]            VARCHAR (50)   NULL,
    [DVPER_OccupationSettingTypeDR]      INT            NULL,
    [DVPER_OccupationSettingTypeSpecify] VARCHAR (50)   NULL,
    [DVPER_OccupationLocation]           VARCHAR (255)  NULL,
    [DVPER_GuardianName]                 VARCHAR (50)   NULL,
    [DVPER_WorkSchoolContact]            VARCHAR (100)  NULL,
    [DVPER_EmailID]                      VARCHAR (100)  NULL,
    [DVPER_ElectronicContact]            VARCHAR (100)  NULL
);

