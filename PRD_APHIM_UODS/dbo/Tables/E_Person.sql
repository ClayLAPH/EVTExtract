CREATE TABLE [dbo].[E_Person] (
    [administrativeGenderCode_OrTx] VARCHAR (50) NULL,
    [birthTime]                     DATETIME     NULL,
    [deceasedInd]                   BIT          NULL,
    [deceasedTime]                  DATETIME     NULL,
    [multipleBirthInd]              BIT          NULL,
    [multipleBithOrderNumber]       SMALLINT     NULL,
    [organDonorInd]                 BIT          NULL,
    [maritalStatusCode_OrTx]        VARCHAR (50) NULL,
    [educationLevelCode_OrTx]       VARCHAR (50) NULL,
    [livingArrangementCode_OrTx]    VARCHAR (50) NULL,
    [religiousAffiliationCode_OrTx] VARCHAR (50) NULL,
    [administrativeGenderCode_ID]   INT          NULL,
    [educationLevelCode_ID]         INT          NULL,
    [livingArrangementCode_ID]      INT          NULL,
    [maritalStatusCode_ID]          INT          NULL,
    [religiousAffiliationCode_ID]   INT          NULL,
    [ServerId]                      INT          NULL,
    [ID]                            INT          NOT NULL,
    [deceasedStatusCode_ID]         INT          NULL,
    CONSTRAINT [E_Person_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [E_Entity_E_Person_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_Person_administrativeGenderCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([administrativeGenderCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_Person_deceasedStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([deceasedStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_Person_educationLevelCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([educationLevelCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_Person_livingArrangementCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([livingArrangementCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_Person_maritalStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([maritalStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_Person_religiousAffiliationCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([religiousAffiliationCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[E_Person] NOCHECK CONSTRAINT [E_Entity_E_Person_FK1];


GO
ALTER TABLE [dbo].[E_Person] NOCHECK CONSTRAINT [FK_A_E_Person_administrativeGenderCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[E_Person] NOCHECK CONSTRAINT [FK_A_E_Person_deceasedStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[E_Person] NOCHECK CONSTRAINT [FK_A_E_Person_educationLevelCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[E_Person] NOCHECK CONSTRAINT [FK_A_E_Person_livingArrangementCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[E_Person] NOCHECK CONSTRAINT [FK_A_E_Person_maritalStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[E_Person] NOCHECK CONSTRAINT [FK_A_E_Person_religiousAffiliationCode_ID_V_UNIFIEDCODESET];

