CREATE TABLE [dbo].[A_Investigation] (
    [mmwrWeek]                  SMALLINT     NULL,
    [mmwrYear]                  SMALLINT     NULL,
    [reportingStateCode_OrTx]   VARCHAR (50) NULL,
    [reportingCountyCode_OrTx]  VARCHAR (50) NULL,
    [caseJurisdictionCode_OrTx] VARCHAR (50) NULL,
    [notificationId]            VARCHAR (50) NULL,
    [personLocalId]             VARCHAR (50) NULL,
    [investigationLocalId]      VARCHAR (50) NULL,
    [conditionCodeText]         VARCHAR (50) NULL,
    [dateReportedPHC]           DATETIME     NULL,
    [dateReportedCDC]           DATETIME     NULL,
    [caseClassStatusCode_OrTx]  VARCHAR (50) NULL,
    [conditionCode]             VARCHAR (50) NULL,
    [conditionCode_CvDO]        VARCHAR (50) NULL,
    [caseClassStatusCode_ID]    INT          NULL,
    [caseJurisdictionCode_ID]   INT          NULL,
    [reportingCountyCode_ID]    INT          NULL,
    [reportingStateCode_ID]     INT          NULL,
    [ID]                        INT          NOT NULL,
    CONSTRAINT [A_Investigation_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [A_Act_A_Investigation_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Investigation_caseClassStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([caseClassStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Investigation_caseJurisdictionCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([caseJurisdictionCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Investigation_reportingCountyCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([reportingCountyCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_Investigation_reportingStateCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([reportingStateCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[A_Investigation] NOCHECK CONSTRAINT [A_Act_A_Investigation_FK1];


GO
ALTER TABLE [dbo].[A_Investigation] NOCHECK CONSTRAINT [FK_A_A_Investigation_caseClassStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Investigation] NOCHECK CONSTRAINT [FK_A_A_Investigation_caseJurisdictionCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Investigation] NOCHECK CONSTRAINT [FK_A_A_Investigation_reportingCountyCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_Investigation] NOCHECK CONSTRAINT [FK_A_A_Investigation_reportingStateCode_ID_V_UNIFIEDCODESET];

