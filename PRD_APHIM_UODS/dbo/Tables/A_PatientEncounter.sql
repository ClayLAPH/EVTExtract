CREATE TABLE [dbo].[A_PatientEncounter] (
    [preAdmitTestInd]                  BIT          NULL,
    [admissionReferralSourceCode_OrTx] VARCHAR (50) NULL,
    [lengthOfStayQuantity]             REAL         NULL,
    [lengthOfStayQuantity_Unit]        VARCHAR (50) NULL,
    [lengthOfStayQuantity_OrTx]        VARCHAR (50) NULL,
    [dischargeDispositionCode_OrTx]    VARCHAR (50) NULL,
    [acuityLevelCode_OrTx]             VARCHAR (50) NULL,
    [specialCourtesiesCode_OrTx]       VARCHAR (50) NULL,
    [specialArrangementCode_OrTx]      VARCHAR (50) NULL,
    [acuityLevelCode_ID]               INT          NULL,
    [admissionReferralSourceCode_ID]   INT          NULL,
    [dischargeDispositionCode_ID]      INT          NULL,
    [specialArrangementCode_ID]        INT          NULL,
    [specialCourtesiesCode_ID]         INT          NULL,
    [ServerId]                         INT          NULL,
    [ID]                               INT          NOT NULL,
    CONSTRAINT [A_PatientEncounter_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [A_Act_A_PatientEncounter_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_PatientEncounter_acuityLevelCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([acuityLevelCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_PatientEncounter_admissionReferralSourceCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([admissionReferralSourceCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_PatientEncounter_dischargeDispositionCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([dischargeDispositionCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_PatientEncounter_specialArrangementCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([specialArrangementCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_PatientEncounter_specialCourtesiesCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([specialCourtesiesCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[A_PatientEncounter] NOCHECK CONSTRAINT [A_Act_A_PatientEncounter_FK1];


GO
ALTER TABLE [dbo].[A_PatientEncounter] NOCHECK CONSTRAINT [FK_A_A_PatientEncounter_acuityLevelCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_PatientEncounter] NOCHECK CONSTRAINT [FK_A_A_PatientEncounter_admissionReferralSourceCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_PatientEncounter] NOCHECK CONSTRAINT [FK_A_A_PatientEncounter_dischargeDispositionCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_PatientEncounter] NOCHECK CONSTRAINT [FK_A_A_PatientEncounter_specialArrangementCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_PatientEncounter] NOCHECK CONSTRAINT [FK_A_A_PatientEncounter_specialCourtesiesCode_ID_V_UNIFIEDCODESET];

