CREATE TABLE [dbo].[R_Patient] (
    [confidentialityCode_OrTx]     VARCHAR (50) NULL,
    [veryImportantPersonCode_OrTx] VARCHAR (50) NULL,
    [confidentialityCode_ID]       INT          NULL,
    [veryImportantPersonCode_ID]   INT          NULL,
    [ServerId]                     INT          NULL,
    [ID]                           INT          NOT NULL,
    CONSTRAINT [R_Patient_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [FK_A_R_Patient_confidentialityCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([confidentialityCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_R_Patient_veryImportantPersonCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([veryImportantPersonCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [R_Role_R_Patient_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[R_Patient] NOCHECK CONSTRAINT [FK_A_R_Patient_confidentialityCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[R_Patient] NOCHECK CONSTRAINT [FK_A_R_Patient_veryImportantPersonCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[R_Patient] NOCHECK CONSTRAINT [R_Role_R_Patient_FK1];

