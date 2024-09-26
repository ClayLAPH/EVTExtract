CREATE TABLE [dbo].[A_SubstanceAdministration] (
    [routeCode_OrTx]           VARCHAR (50) NULL,
    [approachSite_OrTx]        VARCHAR (50) NULL,
    [doseQuantity_Lo]          REAL         NULL,
    [doseQuantity_Hi]          REAL         NULL,
    [doseQuantity_Unit]        VARCHAR (50) NULL,
    [doseQuantity_UnPr]        VARCHAR (50) NULL,
    [doseQuantity_Alt_Lo]      REAL         NULL,
    [doseQuantity_Alt_Hi]      REAL         NULL,
    [rateQuantity_Lo]          REAL         NULL,
    [rateQuantity_Hi]          REAL         NULL,
    [rateQuantity_Unit]        VARCHAR (50) NULL,
    [rateQuantity_UnPr]        VARCHAR (50) NULL,
    [rateQuantity_Alt_Lo]      REAL         NULL,
    [rateQuantity_Alt_Hi]      REAL         NULL,
    [doseCheckQuantity_Nmr]    VARCHAR (50) NULL,
    [doseCheckQuantity_Dnm]    VARCHAR (50) NULL,
    [maxDoseQuantity_Nmr]      VARCHAR (50) NULL,
    [maxDoseQuantity_Dnm]      VARCHAR (50) NULL,
    [approachSite_ID]          INT          NULL,
    [doseQuantity_Alt_Unit_ID] INT          NULL,
    [rateQuantity_Alt_Unit_ID] INT          NULL,
    [routeCode_ID]             INT          NULL,
    [ServerId]                 INT          NULL,
    [ID]                       INT          NOT NULL,
    CONSTRAINT [A_SubstanceAdministration_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [A_Act_A_SubstanceAdministration_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_SubstanceAdministration_approachSite_ID_V_UNIFIEDCODESET] FOREIGN KEY ([approachSite_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_SubstanceAdministration_doseQuantity_Alt_Unit_ID_V_UNIFIEDCODESET] FOREIGN KEY ([doseQuantity_Alt_Unit_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_SubstanceAdministration_rateQuantity_Alt_Unit_ID_V_UNIFIEDCODESET] FOREIGN KEY ([rateQuantity_Alt_Unit_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_SubstanceAdministration_routeCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([routeCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[A_SubstanceAdministration] NOCHECK CONSTRAINT [A_Act_A_SubstanceAdministration_FK1];


GO
ALTER TABLE [dbo].[A_SubstanceAdministration] NOCHECK CONSTRAINT [FK_A_A_SubstanceAdministration_approachSite_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_SubstanceAdministration] NOCHECK CONSTRAINT [FK_A_A_SubstanceAdministration_doseQuantity_Alt_Unit_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_SubstanceAdministration] NOCHECK CONSTRAINT [FK_A_A_SubstanceAdministration_rateQuantity_Alt_Unit_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_SubstanceAdministration] NOCHECK CONSTRAINT [FK_A_A_SubstanceAdministration_routeCode_ID_V_UNIFIEDCODESET];

