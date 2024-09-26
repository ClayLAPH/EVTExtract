CREATE TABLE [dbo].[T_AttributeRelationship] (
    [validTime_Beg]      DATETIME     NULL,
    [validTime_End]      DATETIME     NULL,
    [type]               VARCHAR (50) NULL,
    [type_Code_ID]       INT          NULL,
    [ServerId]           INT          NULL,
    [ID]                 INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Act_ID]             INT          NULL,
    [ActRelationship_ID] INT          NULL,
    [Attribute_ID]       BIGINT       NULL,
    [Entity_ID]          INT          NULL,
    [Participation_ID]   INT          NULL,
    [Role_ID]            INT          NULL,
    CONSTRAINT [T_AttributeRelationship_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [A_Act_T_AttributeRelationship_FK1] FOREIGN KEY ([Act_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [A_ActRelationship_T_AttributeRelationship_FK1] FOREIGN KEY ([ActRelationship_ID]) REFERENCES [dbo].[A_ActRelationship] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [E_Entity_T_AttributeRelationship_FK1] FOREIGN KEY ([Entity_ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_T_AttributeRelationship_type_Code_ID_V_UNIFIEDCODESET] FOREIGN KEY ([type_Code_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [P_Participation_T_AttributeRelationship_FK1] FOREIGN KEY ([Participation_ID]) REFERENCES [dbo].[P_Participation] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [R_Role_T_AttributeRelationship_FK1] FOREIGN KEY ([Role_ID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_Attribute_T_AttributeRelationship_FK1] FOREIGN KEY ([Attribute_ID]) REFERENCES [dbo].[T_Attribute] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[T_AttributeRelationship] NOCHECK CONSTRAINT [A_Act_T_AttributeRelationship_FK1];


GO
ALTER TABLE [dbo].[T_AttributeRelationship] NOCHECK CONSTRAINT [A_ActRelationship_T_AttributeRelationship_FK1];


GO
ALTER TABLE [dbo].[T_AttributeRelationship] NOCHECK CONSTRAINT [E_Entity_T_AttributeRelationship_FK1];


GO
ALTER TABLE [dbo].[T_AttributeRelationship] NOCHECK CONSTRAINT [FK_A_T_AttributeRelationship_type_Code_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[T_AttributeRelationship] NOCHECK CONSTRAINT [P_Participation_T_AttributeRelationship_FK1];


GO
ALTER TABLE [dbo].[T_AttributeRelationship] NOCHECK CONSTRAINT [R_Role_T_AttributeRelationship_FK1];


GO
ALTER TABLE [dbo].[T_AttributeRelationship] NOCHECK CONSTRAINT [T_Attribute_T_AttributeRelationship_FK1];


GO
CREATE NONCLUSTERED INDEX [IX_T_AttributeRelationship]
    ON [dbo].[T_AttributeRelationship]([Attribute_ID] ASC) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_T_AttributeRelationship_1]
    ON [dbo].[T_AttributeRelationship]([Act_ID] ASC)
    INCLUDE([validTime_Beg]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE STATISTICS [IX_WA_Attribute_ID]
    ON [dbo].[T_AttributeRelationship]([Attribute_ID]);

