CREATE TABLE [dbo].[VCP_EHRCrossReference] (
    [ID]               INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DiseaseDR]        INT           NULL,
    [SubjCode_ID]      INT           NOT NULL,
    [LOINCCode]        VARCHAR (200) NULL,
    [SNOMEDConceptID]  VARCHAR (200) NULL,
    [SNOMEDLegacyCode] VARCHAR (200) NULL,
    CONSTRAINT [PK_VCP_EHRCrossReference] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_VCP_EHRCrossReference_Disease_FK] FOREIGN KEY ([DiseaseDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_VCP_EHRCrossReference_SubjCode_ID] FOREIGN KEY ([SubjCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[VCP_EHRCrossReference] NOCHECK CONSTRAINT [FK_VCP_EHRCrossReference_Disease_FK];


GO
ALTER TABLE [dbo].[VCP_EHRCrossReference] NOCHECK CONSTRAINT [FK_VCP_EHRCrossReference_SubjCode_ID];

