CREATE TABLE [dbo].[VCP_Disease] (
    [WebName]                                         VARCHAR (255)  NULL,
    [ICD9]                                            VARCHAR (255)  NULL,
    [NETSS]                                           VARCHAR (255)  NULL,
    [ShowInOutbreakLookup]                            BIT            NULL,
    [ShowInIncidentLookup]                            BIT            NULL,
    [ShowInWeb]                                       BIT            NULL,
    [ShowInAnimalReportLookUp]                        BIT            NULL,
    [CanConfirmForOutbreak]                           BIT            NULL,
    [CanConfirmForIncident]                           BIT            NULL,
    [IsAutomaticallyConfirmed]                        BIT            NULL,
    [Unusual]                                         BIT            NULL,
    [IsHepatitis]                                     BIT            NULL,
    [IsAutoInserted]                                  BIT            NULL,
    [ExportForNETSS]                                  BIT            NULL,
    [ExportProbableForNETSS]                          BIT            NULL,
    [ImmunizationPreventable]                         BIT            NULL,
    [IncludeSexPartnerFields]                         BIT            NULL,
    [DISGRPName]                                      VARCHAR (MAX)  NULL,
    [TransmissionFactors]                             VARCHAR (MAX)  NULL,
    [IncubationPeriod]                                VARCHAR (250)  NULL,
    [Symptoms]                                        VARCHAR (MAX)  NULL,
    [Treatment]                                       VARCHAR (MAX)  NULL,
    [Containment]                                     VARCHAR (MAX)  NULL,
    [ShowSerotype]                                    BIT            NULL,
    [ExportOpenForNETSS]                              BIT            NULL,
    [ExportSuspectForNETSS]                           BIT            NULL,
    [ExportUnknownForNETSS]                           BIT            NULL,
    [HistoricalIncidentReadAccess]                    BIT            NULL,
    [HistoricalIncidentWriteAccess]                   BIT            NULL,
    [ARDLetterCode_ID]                                INT            NULL,
    [CMRSectionARptGroupCode_ID]                      INT            NULL,
    [ContactsUDSectionCode_ID]                        INT            NULL,
    [ContactsWorkFlowCode_ID]                         INT            NULL,
    [EpiTypeCode_ID]                                  INT            NULL,
    [IncidentDiseaseProcessStatusCode_ID]             INT            NULL,
    [LabSectionCode_ID]                               INT            NULL,
    [OutbreakDiseaseProcessStatusCode_ID]             INT            NULL,
    [ReportingStatusCode_ID]                          INT            NULL,
    [SNOMEDCode_ID]                                   INT            NULL,
    [SubjCode_ID]                                     INT            NULL,
    [SupplementalTab1Code_ID]                         INT            NULL,
    [SupplementalTab2Code_ID]                         INT            NULL,
    [SupplementalTab3Code_ID]                         INT            NULL,
    [UrgencyCode_ID]                                  INT            NULL,
    [WorkFlowCode_ID]                                 INT            NULL,
    [ID]                                              INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactInvestigationSuppTab1Code_ID]             INT            NULL,
    [ContactInvestigationSuppTab2Code_ID]             INT            NULL,
    [ContactInvestigationSuppTab3Code_ID]             INT            NULL,
    [ContactInvestigationWorkFlowCode_ID]             INT            NULL,
    [ContactInvestigationDiseaseProcessStatusCode_ID] INT            NULL,
    [ShowInContactInvestigationLookup]                BIT            NULL,
    [OutbreakDiseaseGroupDR]                          INT            NULL,
    [OutbreakWorkFlowDR]                              INT            NULL,
    [OutbreakSupplementalTab1DR]                      INT            NULL,
    [OutbreakSupplementalTab2DR]                      INT            NULL,
    [OutbreakSupplementalTab3DR]                      INT            NULL,
    [ContactToIncidentDiseaseCode_ID]                 INT            NULL,
    [DIS_RequireLabConfirmation]                      BIT            NULL,
    [ShowExposureEvent]                               BIT            NULL,
    [ShowSystemSuppTabInDI]                           BIT            NULL,
    [SupplementalTab4Code_ID]                         INT            NULL,
    [ShowSystemSuppTabInCI]                           BIT            NULL,
    [ContactInvestigationSuppTab4Code_ID]             INT            NULL,
    [DIS_DemographicUDSectionDR]                      INT            NULL,
    [DIS_InvestigationUDSectionDR]                    INT            NULL,
    [Demographics_LoadValidationScript]               VARCHAR (MAX)  NULL,
    [Demographics_LoadPostbackValidationScript]       VARCHAR (MAX)  NULL,
    [Demographics_SaveValidationScript]               VARCHAR (MAX)  NULL,
    [Investigation_LoadValidationScript]              VARCHAR (MAX)  NULL,
    [Investigation_LoadPostbackValidationScript]      VARCHAR (MAX)  NULL,
    [Investigation_SaveValidationScript]              VARCHAR (MAX)  NULL,
    [Incident_SaveValidationScript]                   VARCHAR (MAX)  NULL,
    [IncidentTaskListDR]                              INT            NULL,
    [ContactTaskListDR]                               INT            NULL,
    [OutbreakTaskListDR]                              INT            NULL,
    [AnimalReportSupplementalTab1DR]                  INT            NULL,
    [AnimalReportSupplementalTab2DR]                  INT            NULL,
    [AnimalReportSupplementalTab3DR]                  INT            NULL,
    [EHRSupplementalTabDR]                            INT            NULL,
    [ShowInEHRGateway]                                BIT            NULL,
    [AnimalReportWorkflowDR]                          INT            NULL,
    [ShowLabSystemSectionInVetTab]                    BIT            NULL,
    [Identification_LoadValidationScript]             VARCHAR (MAX)  NULL,
    [Identification_LoadPostbackValidationScript]     VARCHAR (MAX)  NULL,
    [Identification_SaveValidationScript]             VARCHAR (MAX)  NULL,
    [CanEditClosedIncidentUDTabs]                     BIT            NULL,
    [DIS_DestinationFolder]                           VARCHAR (1000) NULL,
    [DIS_CopyHL7MessageOptionDR]                      INT            NULL,
    [OneIncidentPerLabreport]                         BIT            NULL,
    [DIS_DisableDefaultMatchingRules]                 BIT            NULL,
    [ShowStateNumber]                                 BIT            DEFAULT ((0)) NOT NULL,
    [DIS_AutoJurisdictionLevels]                      VARCHAR (100)  NULL,
    [ExcludeProcessStatusesFromCaseLoadForDI]         VARCHAR (8000) NULL,
    [ExcludeProcessStatusesFromCaseLoadForCI]         VARCHAR (8000) NULL,
    [ExcludeProcessStatusesFromCaseLoadForOB]         VARCHAR (8000) NULL,
    [IsAutoAttachMatchedELR]                          BIT            NULL,
    [DIS_ReinfectionInDays]                           INT            CONSTRAINT [ReinfectionInDays_Default_31] DEFAULT ((31)) NULL,
    [EnableAdvancedAutoImportRules]                   BIT            DEFAULT ((0)) NULL,
    CONSTRAINT [VCP_Disease_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [FK_A_VCP_Disease_AnimalReportSupplementalTab1DR_V_UNIFIEDCODESET] FOREIGN KEY ([AnimalReportSupplementalTab1DR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_AnimalReportSupplementalTab2DR_V_UNIFIEDCODESET] FOREIGN KEY ([AnimalReportSupplementalTab2DR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_AnimalReportSupplementalTab3DR_V_UNIFIEDCODESET] FOREIGN KEY ([AnimalReportSupplementalTab3DR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_AnimalReportWorkFlowDR_V_UNIFIEDCODESET] FOREIGN KEY ([AnimalReportWorkflowDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]),
    CONSTRAINT [FK_A_VCP_Disease_ARDLetterCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([ARDLetterCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_CMRSectionARptGroupCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([CMRSectionARptGroupCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_ContactInvestigationDiseaseProcessStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([ContactInvestigationDiseaseProcessStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_ContactInvestigationSuppTab1Code_ID_V_UNIFIEDCODESET] FOREIGN KEY ([ContactInvestigationSuppTab1Code_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_ContactInvestigationSuppTab2Code_ID_V_UNIFIEDCODESET] FOREIGN KEY ([ContactInvestigationSuppTab2Code_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_ContactInvestigationSuppTab3Code_ID_V_UNIFIEDCODESET] FOREIGN KEY ([ContactInvestigationSuppTab3Code_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_ContactInvestigationSuppTab4Code_ID_V_UNIFIEDCODESET] FOREIGN KEY ([ContactInvestigationSuppTab4Code_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_ContactInvestigationWorkFlowCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([ContactInvestigationWorkFlowCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_ContactsUDSectionCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([ContactsUDSectionCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_ContactsWorkFlowCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([ContactsWorkFlowCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_ContactTaskListDR_V_UNIFIEDCODESET] FOREIGN KEY ([ContactTaskListDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]),
    CONSTRAINT [FK_A_VCP_Disease_DIS_DemographicUDSectionDR_V_UNIFIEDCODESET] FOREIGN KEY ([DIS_DemographicUDSectionDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]),
    CONSTRAINT [FK_A_VCP_Disease_EHRSupplementalTabDR_V_UNIFIEDCODESET] FOREIGN KEY ([EHRSupplementalTabDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_EpiTypeCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([EpiTypeCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_IncidentDiseaseProcessStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([IncidentDiseaseProcessStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_IncidentTaskListDR_V_UNIFIEDCODESET] FOREIGN KEY ([IncidentTaskListDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]),
    CONSTRAINT [FK_A_VCP_Disease_LabSectionCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([LabSectionCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_OutbreakDiseaseGroupDR_V_UNIFIEDCODESET] FOREIGN KEY ([OutbreakDiseaseGroupDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_OutbreakDiseaseProcessStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([OutbreakDiseaseProcessStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_OutbreakSupplementalTab1DR_V_UNIFIEDCODESET] FOREIGN KEY ([OutbreakSupplementalTab1DR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_OutbreakSupplementalTab2DR_V_UNIFIEDCODESET] FOREIGN KEY ([OutbreakSupplementalTab2DR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_OutbreakSupplementalTab3DR_V_UNIFIEDCODESET] FOREIGN KEY ([OutbreakSupplementalTab3DR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_OutbreakTaskListDR_V_UNIFIEDCODESET] FOREIGN KEY ([OutbreakTaskListDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]),
    CONSTRAINT [FK_A_VCP_Disease_OutbreakWorkFlowDR_V_UNIFIEDCODESET] FOREIGN KEY ([OutbreakWorkFlowDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_ReportingStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([ReportingStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_SNOMEDCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([SNOMEDCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_SubjCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([SubjCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_SupplementalTab1Code_ID_V_UNIFIEDCODESET] FOREIGN KEY ([SupplementalTab1Code_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_SupplementalTab2Code_ID_V_UNIFIEDCODESET] FOREIGN KEY ([SupplementalTab2Code_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_SupplementalTab3Code_ID_V_UNIFIEDCODESET] FOREIGN KEY ([SupplementalTab3Code_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_SupplementalTab4Code_ID_V_UNIFIEDCODESET] FOREIGN KEY ([SupplementalTab4Code_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_UrgencyCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([UrgencyCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_Disease_WorkFlowCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([WorkFlowCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_VCP_Disease_ContactToIncident_V_UNIFIEDCODESET] FOREIGN KEY ([ContactToIncidentDiseaseCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]),
    CONSTRAINT [FK_VCP_Disease_DIS_CopyHL7MessageOptionDR_ID_V_UnifiedCodeSet] FOREIGN KEY ([DIS_CopyHL7MessageOptionDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_VCP_Disease_DIS_InvestigationUDSectionDR_V_UNIFIEDCODESET] FOREIGN KEY ([DIS_InvestigationUDSectionDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID])
);


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_AnimalReportSupplementalTab1DR_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_AnimalReportSupplementalTab2DR_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_AnimalReportSupplementalTab3DR_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_ARDLetterCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_CMRSectionARptGroupCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_ContactInvestigationDiseaseProcessStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_ContactInvestigationSuppTab1Code_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_ContactInvestigationSuppTab2Code_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_ContactInvestigationSuppTab3Code_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_ContactInvestigationSuppTab4Code_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_ContactInvestigationWorkFlowCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_ContactsUDSectionCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_ContactsWorkFlowCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_ContactTaskListDR_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_EHRSupplementalTabDR_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_EpiTypeCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_IncidentDiseaseProcessStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_IncidentTaskListDR_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_LabSectionCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_OutbreakDiseaseGroupDR_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_OutbreakDiseaseProcessStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_OutbreakSupplementalTab1DR_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_OutbreakSupplementalTab2DR_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_OutbreakSupplementalTab3DR_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_OutbreakTaskListDR_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_OutbreakWorkFlowDR_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_ReportingStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_SNOMEDCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_SubjCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_SupplementalTab1Code_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_SupplementalTab2Code_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_SupplementalTab3Code_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_SupplementalTab4Code_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_UrgencyCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] NOCHECK CONSTRAINT [FK_A_VCP_Disease_WorkFlowCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_Disease] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_VCP_Disease_SubjCode_SubjCvDo]
    ON [dbo].[VCP_Disease]([SubjCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

