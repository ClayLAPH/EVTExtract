CREATE TABLE [dbo].[V_CodeRelationship] (
    [otherInfo]     VARCHAR (MAX) NULL,
    [status]        VARCHAR (50)  NULL,
    [relateCode_ID] INT           NULL,
    [sourceCode_ID] INT           NULL,
    [targetCode_ID] INT           NULL,
    [ID]            INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    CONSTRAINT [V_CodeRelationship_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [FK_A_V_CodeRelationship_relateCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([relateCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_V_CodeRelationship_sourceCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([sourceCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_V_CodeRelationship_targetCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([targetCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[V_CodeRelationship] NOCHECK CONSTRAINT [FK_A_V_CodeRelationship_relateCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[V_CodeRelationship] NOCHECK CONSTRAINT [FK_A_V_CodeRelationship_sourceCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[V_CodeRelationship] NOCHECK CONSTRAINT [FK_A_V_CodeRelationship_targetCode_ID_V_UNIFIEDCODESET];

