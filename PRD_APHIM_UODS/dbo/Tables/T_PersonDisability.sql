CREATE TABLE [dbo].[T_PersonDisability] (
    [disabilityCode_OrTx] VARCHAR (50) NULL,
    [metaCode]            VARCHAR (50) NULL,
    [disabilityCode_ID]   INT          NULL,
    [ID]                  INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Entity_ID]           INT          NULL,
    CONSTRAINT [T_PersonDisability_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [E_Person_T_PersonDisability_FK1] FOREIGN KEY ([Entity_ID]) REFERENCES [dbo].[E_Person] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_T_PersonDisability_disabilityCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([disabilityCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[T_PersonDisability] NOCHECK CONSTRAINT [E_Person_T_PersonDisability_FK1];


GO
ALTER TABLE [dbo].[T_PersonDisability] NOCHECK CONSTRAINT [FK_A_T_PersonDisability_disabilityCode_ID_V_UNIFIEDCODESET];

