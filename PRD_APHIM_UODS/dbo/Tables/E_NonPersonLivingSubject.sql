CREATE TABLE [dbo].[E_NonPersonLivingSubject] (
    [administrativeGenderCode_OrTx] VARCHAR (50) NULL,
    [birthTime]                     DATETIME     NULL,
    [deceasedInd]                   BIT          NULL,
    [deceasedTime]                  DATETIME     NULL,
    [multipleBirthInd]              BIT          NULL,
    [multipleBirthOrderNumber]      SMALLINT     NULL,
    [OrganDonorInd]                 BIT          NULL,
    [strainText]                    VARCHAR (50) NULL,
    [strainCode_OrTx]               VARCHAR (50) NULL,
    [genderStatusCode_OrTx]         VARCHAR (50) NULL,
    [administrativeGenderCode_ID]   INT          NULL,
    [genderStatusCode_ID]           INT          NULL,
    [strainCode_ID]                 INT          NULL,
    [ServerId]                      INT          NULL,
    [ID]                            INT          NOT NULL,
    CONSTRAINT [E_NonPersonLivingSubject_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [E_Entity_E_NonPersonLivingSubject_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_NonPersonLivingSubject_administrativeGenderCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([administrativeGenderCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_NonPersonLivingSubject_genderStatusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([genderStatusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_E_NonPersonLivingSubject_strainCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([strainCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[E_NonPersonLivingSubject] NOCHECK CONSTRAINT [E_Entity_E_NonPersonLivingSubject_FK1];


GO
ALTER TABLE [dbo].[E_NonPersonLivingSubject] NOCHECK CONSTRAINT [FK_A_E_NonPersonLivingSubject_administrativeGenderCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[E_NonPersonLivingSubject] NOCHECK CONSTRAINT [FK_A_E_NonPersonLivingSubject_genderStatusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[E_NonPersonLivingSubject] NOCHECK CONSTRAINT [FK_A_E_NonPersonLivingSubject_strainCode_ID_V_UNIFIEDCODESET];

