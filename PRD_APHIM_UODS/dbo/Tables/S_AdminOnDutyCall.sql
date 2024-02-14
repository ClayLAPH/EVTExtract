CREATE TABLE [dbo].[S_AdminOnDutyCall] (
    [AOD_ID]                      INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AOD_DateAndTimeOfCall]       DATETIME      NULL,
    [AOD_DateAndTimeOfLogEntry]   DATETIME      NULL,
    [AOD_Duration]                INT           NULL,
    [AOD_PhoneNumber]             VARCHAR (50)  NULL,
    [AOD_ContactName]             VARCHAR (250) NULL,
    [AOD_PatientName]             VARCHAR (250) NULL,
    [AOD_PatientDOB]              DATETIME      NULL,
    [AOD_PatientAge]              REAL          NULL,
    [AOD_PatientAddress]          VARCHAR (250) NULL,
    [AOD_PatientPhoneNumber]      VARCHAR (50)  NULL,
    [AOD_Physician]               VARCHAR (250) NULL,
    [AOD_PhysicianPhoneNumber]    VARCHAR (50)  NULL,
    [AOD_MRN]                     VARCHAR (100) NULL,
    [AOD_EventLocation]           VARCHAR (250) NULL,
    [AOD_EventAddress]            VARCHAR (250) NULL,
    [AOD_EventCity]               VARCHAR (100) NULL,
    [AOD_EventPhoneNumber]        VARCHAR (50)  NULL,
    [AOD_ActionsTaken]            VARCHAR (250) NULL,
    [AOD_FollowUpRequired]        BIT           NOT NULL,
    [AOD_Notes]                   VARCHAR (MAX) NULL,
    [AOD_PatientCity]             VARCHAR (100) NULL,
    [AOD_PatientState]            VARCHAR (50)  NULL,
    [AOD_PatientZipCode]          VARCHAR (30)  NULL,
    [AOD_PatientAltPhoneNumber]   VARCHAR (30)  NULL,
    [AOD_PhoneNumberAlphaUp]      AS            ([dbo].[ALPHAUP]([AOD_PhoneNumber])) PERSISTED,
    [AOD_CallLogProblemCode_ID]   INT           NULL,
    [AOD_CallLogSituationCode_ID] INT           NULL,
    [AOD_DiseaseCode_ID]          INT           NULL,
    [AOD_DistrictCode_ID]         INT           NULL,
    [AOD_SexCode_ID]              INT           NULL,
    [AOD_EventOutbreakDR]         INT           NULL,
    [AOD_IncidentDR]              INT           NULL,
    [AOD_OrganizationDR]          INT           NULL,
    [AOD_UserDR]                  INT           NULL,
    [AOD_PatientAgeInMonths]      INT           NULL,
    [AOD_PatientAgeInDays]        INT           NULL,
    CONSTRAINT [PK_S_AdminOnDutyCall] PRIMARY KEY CLUSTERED ([AOD_ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_A_S_AdminOnDutyCall_AOD_CallLogProblemCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([AOD_CallLogProblemCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_S_AdminOnDutyCall_AOD_CallLogSituationCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([AOD_CallLogSituationCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_S_AdminOnDutyCall_AOD_DiseaseCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([AOD_DiseaseCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_S_AdminOnDutyCall_AOD_DistrictCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([AOD_DistrictCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_S_AdminOnDutyCall_AOD_SexCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([AOD_SexCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_S_AdminOnDutyCall_A_Outbreak] FOREIGN KEY ([AOD_EventOutbreakDR]) REFERENCES [dbo].[A_Outbreak] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_S_AdminOnDutyCall_A_PublicHealthCase] FOREIGN KEY ([AOD_IncidentDR]) REFERENCES [dbo].[A_PublicHealthCase] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_S_AdminOnDutyCall_E_Entity] FOREIGN KEY ([AOD_OrganizationDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_S_AdminOnDutyCall_E_Entity1] FOREIGN KEY ([AOD_UserDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[S_AdminOnDutyCall] NOCHECK CONSTRAINT [FK_A_S_AdminOnDutyCall_AOD_CallLogProblemCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[S_AdminOnDutyCall] NOCHECK CONSTRAINT [FK_A_S_AdminOnDutyCall_AOD_CallLogSituationCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[S_AdminOnDutyCall] NOCHECK CONSTRAINT [FK_A_S_AdminOnDutyCall_AOD_DiseaseCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[S_AdminOnDutyCall] NOCHECK CONSTRAINT [FK_A_S_AdminOnDutyCall_AOD_DistrictCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[S_AdminOnDutyCall] NOCHECK CONSTRAINT [FK_A_S_AdminOnDutyCall_AOD_SexCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[S_AdminOnDutyCall] NOCHECK CONSTRAINT [FK_S_AdminOnDutyCall_A_Outbreak];


GO
ALTER TABLE [dbo].[S_AdminOnDutyCall] NOCHECK CONSTRAINT [FK_S_AdminOnDutyCall_A_PublicHealthCase];


GO
ALTER TABLE [dbo].[S_AdminOnDutyCall] NOCHECK CONSTRAINT [FK_S_AdminOnDutyCall_E_Entity];


GO
ALTER TABLE [dbo].[S_AdminOnDutyCall] NOCHECK CONSTRAINT [FK_S_AdminOnDutyCall_E_Entity1];

