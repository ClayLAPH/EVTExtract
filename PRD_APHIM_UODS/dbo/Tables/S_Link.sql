CREATE TABLE [dbo].[S_Link] (
    [name]                VARCHAR (50) NOT NULL,
    [editDate]            DATETIME     NULL,
    [ServerId]            INT          NULL,
    [ID]                  INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Act1_ID]             INT          NULL,
    [Act2_ID]             INT          NULL,
    [ActRelationship1_ID] INT          NULL,
    [ActRelationship2_ID] INT          NULL,
    [Entity1_ID]          INT          NULL,
    [Entity2_ID]          INT          NULL,
    [Participation1_ID]   INT          NULL,
    [Participation2_ID]   INT          NULL,
    [Role1_ID]            INT          NULL,
    [Role2_ID]            INT          NULL,
    [RoleLink1_ID]        INT          NULL,
    [RoleLink2_ID]        INT          NULL,
    [tAddress1_ID]        INT          NULL,
    [tAddress2_ID]        INT          NULL,
    [tAddressPart1_ID]    INT          NULL,
    [tAddressPart2_ID]    INT          NULL,
    [tAttribute1_ID]      BIGINT       NULL,
    [tAttribute2_ID]      BIGINT       NULL,
    [tIdentifier1_ID]     INT          NULL,
    [tIdentifier2_ID]     INT          NULL,
    [tLanguage1_ID]       INT          NULL,
    [tLanguage2_ID]       INT          NULL,
    [tName1_ID]           INT          NULL,
    [tName2_ID]           INT          NULL,
    [tNamePart1_ID]       INT          NULL,
    [tNamePart2_ID]       INT          NULL,
    [tTelecom1_ID]        INT          NULL,
    [tTelecom2_ID]        INT          NULL,
    [tValue1_ID]          INT          NULL,
    [tValue2_ID]          INT          NULL,
    CONSTRAINT [S_Link_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [SLinkConstraintOnEntity1Act1] CHECK ([DBO].[CheckDuplicateSLinkUsingEntity1Act1]([NAME],[ACT1_ID],[ENTITY1_ID])=(0)),
    CONSTRAINT [A_Act_S_Link_FK1] FOREIGN KEY ([Act1_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [A_Act_S_Link_FK2] FOREIGN KEY ([Act2_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [A_ActRelationship_S_Link_FK1] FOREIGN KEY ([ActRelationship1_ID]) REFERENCES [dbo].[A_ActRelationship] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [E_Entity_S_Link_FK1] FOREIGN KEY ([Entity1_ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [E_Entity_S_Link_FK2] FOREIGN KEY ([Entity2_ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [P_Participation_S_Link_FK1] FOREIGN KEY ([Participation1_ID]) REFERENCES [dbo].[P_Participation] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [P_Participation_S_Link_FK2] FOREIGN KEY ([Participation2_ID]) REFERENCES [dbo].[P_Participation] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [R_Role_S_Link_FK2] FOREIGN KEY ([Role2_ID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [R_RoleLink_S_Link_FK1] FOREIGN KEY ([RoleLink1_ID]) REFERENCES [dbo].[R_RoleLink] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [R_RoleLink_S_Link_FK2] FOREIGN KEY ([RoleLink2_ID]) REFERENCES [dbo].[R_RoleLink] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [S_Link_A_ActRelationship_FK2] FOREIGN KEY ([ActRelationship2_ID]) REFERENCES [dbo].[A_ActRelationship] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [S_Link_R_Role_FK1] FOREIGN KEY ([Role1_ID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_AddressPart_S_Link_FK1] FOREIGN KEY ([tAddressPart1_ID]) REFERENCES [dbo].[T_AddressPart] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_AddressPart_S_Link_FK2] FOREIGN KEY ([tAddressPart2_ID]) REFERENCES [dbo].[T_AddressPart] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_Attribute_S_Link_FK1] FOREIGN KEY ([tAttribute1_ID]) REFERENCES [dbo].[T_Attribute] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_Attribute_S_Link_FK2] FOREIGN KEY ([tAttribute2_ID]) REFERENCES [dbo].[T_Attribute] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_EntityAddress_S_Link_FK1] FOREIGN KEY ([tAddress1_ID]) REFERENCES [dbo].[T_EntityAddress] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_EntityAddress_S_Link_FK2] FOREIGN KEY ([tAddress2_ID]) REFERENCES [dbo].[T_EntityAddress] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_EntityName_S_Link_FK1] FOREIGN KEY ([tName1_ID]) REFERENCES [dbo].[T_EntityName] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_EntityName_S_Link_FK2] FOREIGN KEY ([tName2_ID]) REFERENCES [dbo].[T_EntityName] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_EntityNamePart_S_Link_FK1] FOREIGN KEY ([tNamePart1_ID]) REFERENCES [dbo].[T_EntityNamePart] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_EntityNamePart_S_Link_FK2] FOREIGN KEY ([tNamePart2_ID]) REFERENCES [dbo].[T_EntityNamePart] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_EntityTelecom_S_Link_FK1] FOREIGN KEY ([tTelecom1_ID]) REFERENCES [dbo].[T_EntityTelecom] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_EntityTelecom_S_Link_FK2] FOREIGN KEY ([tTelecom2_ID]) REFERENCES [dbo].[T_EntityTelecom] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_InstanceIdentifier_S_Link_FK1] FOREIGN KEY ([tIdentifier1_ID]) REFERENCES [dbo].[T_InstanceIdentifier] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_InstanceIdentifier_S_Link_FK2] FOREIGN KEY ([tIdentifier2_ID]) REFERENCES [dbo].[T_InstanceIdentifier] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_LanguageCommunication_S_Link_FK1] FOREIGN KEY ([tLanguage1_ID]) REFERENCES [dbo].[T_LanguageCommunication] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_LanguageCommunication_S_Link_FK2] FOREIGN KEY ([tLanguage2_ID]) REFERENCES [dbo].[T_LanguageCommunication] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_Value_S_Link_FK1] FOREIGN KEY ([tValue1_ID]) REFERENCES [dbo].[T_Value] ([Value_ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_Value_S_Link_FK2] FOREIGN KEY ([tValue2_ID]) REFERENCES [dbo].[T_Value] ([Value_ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [A_Act_S_Link_FK1];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [A_Act_S_Link_FK2];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [A_ActRelationship_S_Link_FK1];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [E_Entity_S_Link_FK1];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [E_Entity_S_Link_FK2];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [P_Participation_S_Link_FK1];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [P_Participation_S_Link_FK2];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [R_Role_S_Link_FK2];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [R_RoleLink_S_Link_FK1];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [R_RoleLink_S_Link_FK2];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [S_Link_A_ActRelationship_FK2];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [S_Link_R_Role_FK1];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [T_AddressPart_S_Link_FK1];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [T_AddressPart_S_Link_FK2];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [T_Attribute_S_Link_FK1];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [T_Attribute_S_Link_FK2];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [T_EntityAddress_S_Link_FK1];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [T_EntityAddress_S_Link_FK2];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [T_EntityName_S_Link_FK1];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [T_EntityName_S_Link_FK2];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [T_EntityNamePart_S_Link_FK1];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [T_EntityNamePart_S_Link_FK2];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [T_EntityTelecom_S_Link_FK1];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [T_EntityTelecom_S_Link_FK2];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [T_InstanceIdentifier_S_Link_FK1];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [T_InstanceIdentifier_S_Link_FK2];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [T_LanguageCommunication_S_Link_FK1];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [T_LanguageCommunication_S_Link_FK2];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [T_Value_S_Link_FK1];


GO
ALTER TABLE [dbo].[S_Link] NOCHECK CONSTRAINT [T_Value_S_Link_FK2];


GO
ALTER TABLE [dbo].[S_Link] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_S_Link]
    ON [dbo].[S_Link]([name] ASC, [Entity2_ID] ASC)
    INCLUDE([Entity1_ID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_S_Link_Entity1_name]
    ON [dbo].[S_Link]([Entity1_ID] ASC, [name] ASC)
    INCLUDE([Entity2_ID], [tAddress1_ID]) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_S_Link_Act1_Name_Entity1]
    ON [dbo].[S_Link]([Act1_ID] ASC, [name] ASC, [Entity1_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_S_Link_Act2_Name_Entity1]
    ON [dbo].[S_Link]([Act2_ID] ASC, [name] ASC, [Entity1_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
ALTER INDEX [IX_S_Link_Act2_Name_Entity1]
    ON [dbo].[S_Link] DISABLE;


GO
CREATE NONCLUSTERED INDEX [IX_S_Link_4]
    ON [dbo].[S_Link]([tAddress1_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [S_Link_Entity2_ID]
    ON [dbo].[S_Link]([Entity2_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE STATISTICS [IX_WA_Entity2_ID]
    ON [dbo].[S_Link]([Entity2_ID]);


GO
CREATE STATISTICS [IX_WA_tAddress1_ID]
    ON [dbo].[S_Link]([tAddress1_ID]);


GO
CREATE STATISTICS [IX_WA_name]
    ON [dbo].[S_Link]([name]);

