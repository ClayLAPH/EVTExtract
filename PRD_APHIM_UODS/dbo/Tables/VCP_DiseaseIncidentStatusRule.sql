CREATE TABLE [dbo].[VCP_DiseaseIncidentStatusRule] (
    [ID]            INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SubjCode_ID]   INT           NULL,
    [Order]         INT           NULL,
    [RuleCondition] VARCHAR (MAX) NULL,
    [RuleOutput]    VARCHAR (255) NULL,
    CONSTRAINT [PK_VCP_DiseaseIncidentStatusRule] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_VCP_DiseaseISR_Subjode_V_UCS_ID] FOREIGN KEY ([SubjCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[VCP_DiseaseIncidentStatusRule] NOCHECK CONSTRAINT [FK_VCP_DiseaseISR_Subjode_V_UCS_ID];

