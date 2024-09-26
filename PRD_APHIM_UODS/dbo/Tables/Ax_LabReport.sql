CREATE TABLE [dbo].[Ax_LabReport] (
    [DILR_PatientName]                 VARCHAR (255)  NULL,
    [DILR_ImportStatus]                VARCHAR (1500) NULL,
    [DILR_SpecCollectedDate]           DATETIME       NULL,
    [DILR_SpecReceivedDate]            DATETIME       NULL,
    [DILR_TestCode]                    VARCHAR (255)  NULL,
    [DILR_TestDescription]             VARCHAR (1000) NULL,
    [DILR_TestCodingSystem_ID]         INT            NULL,
    [DILR_LocalTestCode]               VARCHAR (255)  NULL,
    [DILR_LocalTestDescription]        VARCHAR (1000) NULL,
    [DILR_OrganismCode]                VARCHAR (255)  NULL,
    [DILR_OrganismDescription]         VARCHAR (300)  NULL,
    [DILR_OrganismCodingSystem_ID]     INT            NULL,
    [DILR_LocalOrganismCode]           VARCHAR (1270) NULL,
    [DILR_LocalOrganismDescription]    VARCHAR (1550) NULL,
    [DILR_ResultValue]                 VARCHAR (4000) NULL,
    [DILR_ResultUnit]                  VARCHAR (255)  NULL,
    [DILR_ReferenceRange]              VARCHAR (255)  NULL,
    [DILR_ResultDate]                  DATETIME       NULL,
    [DILR_PerformingFacilityID]        VARCHAR (255)  NULL,
    [DILR_PersonVerifiedResult]        VARCHAR (255)  NULL,
    [DILR_Notes]                       VARCHAR (MAX)  NULL,
    [DILR_ProviderName]                VARCHAR (255)  NULL,
    [DILR_ProviderID]                  VARCHAR (255)  NULL,
    [DILR_ProviderPhone]               VARCHAR (255)  NULL,
    [DILR_ProviderAddress]             VARCHAR (255)  NULL,
    [DILR_ProviderCity]                VARCHAR (255)  NULL,
    [DILR_ProviderState]               VARCHAR (255)  NULL,
    [DILR_ProviderZip]                 VARCHAR (255)  NULL,
    [DILR_ProviderCounty]              VARCHAR (255)  NULL,
    [DILR_ProviderFax]                 VARCHAR (255)  NULL,
    [DILR_ProviderEmail]               VARCHAR (255)  NULL,
    [DILR_FacilityName]                VARCHAR (255)  NULL,
    [DILR_FacilityID]                  VARCHAR (255)  NULL,
    [DILR_PlacerOrderNo]               VARCHAR (255)  NULL,
    [DILR_FacilityAddress]             VARCHAR (255)  NULL,
    [DILR_FacilityCity]                VARCHAR (255)  NULL,
    [DILR_FacilityState]               VARCHAR (255)  NULL,
    [DILR_FacilityZip]                 VARCHAR (255)  NULL,
    [DILR_FacilityCounty]              VARCHAR (255)  NULL,
    [DILR_FacilityPhone]               VARCHAR (255)  NULL,
    [DILR_FacilityEmail]               VARCHAR (255)  NULL,
    [DILR_IsFromHL7]                   BIT            NULL,
    [DILR_Serology]                    VARCHAR (300)  NULL,
    [DILR_Species]                     VARCHAR (300)  NULL,
    [DILR_Serogroup]                   VARCHAR (300)  NULL,
    [DILR_Serotype]                    VARCHAR (300)  NULL,
    [DILR_PFGEPattern1st]              VARCHAR (255)  NULL,
    [DILR_PFGEPattern2nd]              VARCHAR (255)  NULL,
    [DILR_SpecimenSourceText]          VARCHAR (705)  NULL,
    [DILR_AbnormalFlagCode_ID]         INT            NULL,
    [DILR_LIPTestStatusCode_ID]        INT            NULL,
    [DILR_ResultStatusCode_ID]         INT            NULL,
    [DILR_SourceCode_ID]               INT            NULL,
    [DILR_SpecBodySiteCode_ID]         INT            NULL,
    [DILR_SpecimenSourceCode_ID]       INT            NULL,
    [DILR_StatusCode_ID]               INT            NULL,
    [DILR_ID]                          INT            NOT NULL,
    [DILR_LaboratoryDR]                INT            NULL,
    [DILR_SpecimenResult_ID]           INT            NULL,
    [DILR_SpecimenType_ID]             INT            NULL,
    [DILR_ImportStatus_ID]             INT            NULL,
    [DILR_ResultTest]                  VARCHAR (1100) NULL,
    [DILR_MessageType]                 VARCHAR (50)   NULL,
    [DILR_ProviderPhoneAlphaUp]        AS             ([dbo].[ALPHAUP]([DILR_ProviderPhone])) PERSISTED,
    [DILR_FacilityPhoneAlphaUp]        AS             ([dbo].[ALPHAUP]([DILR_FacilityPhone])) PERSISTED,
    [DILR_IsAttachedToLive]            AS             (case when [DILR_ImportStatus]='Attached' then CONVERT([bit],(1)) else CONVERT([bit],(0)) end) PERSISTED,
    [DILR_MessageTypeID]               AS             (case when [DILR_MessageType]='OUL^R22' then (1) when [DILR_MessageType]='EICR' then (2) else (0) end),
    [DILR_ResultValueEx]               NVARCHAR (MAX) NULL,
    [DILR_RelevantClinicalInformation] NVARCHAR (300) NULL,
    [DILR_ReasonForStudy]              NVARCHAR (199) NULL,
    [DILR_StandardResultValue]         NUMERIC (18)   NULL,
    [DILR_StandardResultUnitDR]        INT            NULL,
    CONSTRAINT [Ax_LabReport_PK] PRIMARY KEY CLUSTERED ([DILR_ID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [A_ACT_Ax_LabReport_FK3] FOREIGN KEY ([DILR_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [E_ENTITY_Ax_LabReport_FK4] FOREIGN KEY ([DILR_LaboratoryDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_Ax_LabReport_DILR_AbnormalFlagCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DILR_AbnormalFlagCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_Ax_LabReport_DILR_LIPTestStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DILR_LIPTestStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_Ax_LabReport_DILR_OrganismCodingSystem_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DILR_OrganismCodingSystem_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]),
    CONSTRAINT [FK_A_Ax_LabReport_DILR_ResultStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DILR_ResultStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_Ax_LabReport_DILR_SourceCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DILR_SourceCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_Ax_LabReport_DILR_SpecBodySiteCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DILR_SpecBodySiteCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_Ax_LabReport_DILR_SpecimenResult_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DILR_SpecimenResult_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_Ax_LabReport_DILR_SpecimenSourceCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DILR_SpecimenSourceCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_Ax_LabReport_DILR_SpecimenType_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DILR_SpecimenType_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_Ax_LabReport_DILR_StandardResultUnitDR_V_UNIFIEDCODESET] FOREIGN KEY ([DILR_StandardResultUnitDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]),
    CONSTRAINT [FK_A_Ax_LabReport_DILR_StatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DILR_StatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_Ax_LabReport_DILR_TestCodingSystem_ID_V_UNIFIEDCODESET] FOREIGN KEY ([DILR_TestCodingSystem_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]),
    CONSTRAINT [FK_Ax_LabReport_V_UnifiedCodeSet] FOREIGN KEY ([DILR_ImportStatus_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[Ax_LabReport] NOCHECK CONSTRAINT [A_ACT_Ax_LabReport_FK3];


GO
ALTER TABLE [dbo].[Ax_LabReport] NOCHECK CONSTRAINT [E_ENTITY_Ax_LabReport_FK4];


GO
ALTER TABLE [dbo].[Ax_LabReport] NOCHECK CONSTRAINT [FK_A_Ax_LabReport_DILR_AbnormalFlagCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[Ax_LabReport] NOCHECK CONSTRAINT [FK_A_Ax_LabReport_DILR_LIPTestStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[Ax_LabReport] NOCHECK CONSTRAINT [FK_A_Ax_LabReport_DILR_ResultStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[Ax_LabReport] NOCHECK CONSTRAINT [FK_A_Ax_LabReport_DILR_SourceCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[Ax_LabReport] NOCHECK CONSTRAINT [FK_A_Ax_LabReport_DILR_SpecBodySiteCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[Ax_LabReport] NOCHECK CONSTRAINT [FK_A_Ax_LabReport_DILR_SpecimenResult_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[Ax_LabReport] NOCHECK CONSTRAINT [FK_A_Ax_LabReport_DILR_SpecimenSourceCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[Ax_LabReport] NOCHECK CONSTRAINT [FK_A_Ax_LabReport_DILR_SpecimenType_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[Ax_LabReport] NOCHECK CONSTRAINT [FK_A_Ax_LabReport_DILR_StatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[Ax_LabReport] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_Ax_LabReport]
    ON [dbo].[Ax_LabReport]([DILR_IsFromHL7] ASC, [DILR_ID] ASC)
    INCLUDE([DILR_FacilityCity], [DILR_FacilityName]) WITH (FILLFACTOR = 70);


GO
CREATE NONCLUSTERED INDEX [IX_Ax_Lab_Report_ImportStatusID]
    ON [dbo].[Ax_LabReport]([DILR_ImportStatus_ID] ASC)
    INCLUDE([DILR_TestDescription]) WITH (FILLFACTOR = 70);


GO
CREATE NONCLUSTERED INDEX [IX_AX_HL7_MessageType_Attached]
    ON [dbo].[Ax_LabReport]([DILR_MessageTypeID] ASC, [DILR_IsFromHL7] ASC, [DILR_IsAttachedToLive] ASC, [DILR_ID] ASC) WITH (FILLFACTOR = 70);


GO
CREATE NONCLUSTERED INDEX [IX_AX_PatientName]
    ON [dbo].[Ax_LabReport]([DILR_PatientName] ASC) WITH (FILLFACTOR = 70);


GO
CREATE NONCLUSTERED INDEX [IX_Ax_LabReport_LaboratoryDR]
    ON [dbo].[Ax_LabReport]([DILR_LaboratoryDR] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_Ax_LabReport_FaciliyName_City_IsFromHL7]
    ON [dbo].[Ax_LabReport]([DILR_FacilityName] ASC, [DILR_FacilityCity] ASC, [DILR_IsFromHL7] ASC)
    INCLUDE([DILR_ID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

