CREATE TABLE [dbo].[T_Attribute] (
    [name]                         VARCHAR (50)    NOT NULL,
    [createTime]                   DATETIME        NULL,
    [updateTime]                   DATETIME        NULL,
    [type]                         VARCHAR (50)    NULL,
    [isValueNull]                  BIT             NULL,
    [valueNullFlavor]              VARCHAR (50)    NULL,
    [valueNullFlavor_OrTx]         VARCHAR (50)    NULL,
    [valueBool]                    BIT             NULL,
    [valueInteger]                 INT             NULL,
    [valueReal]                    REAL            NULL,
    [valueImage]                   VARBINARY (MAX) NULL,
    [valueTS]                      DATETIME        NULL,
    [valueTSEnd]                   DATETIME        NULL,
    [valueString]                  VARCHAR (8000)  NULL,
    [valueString_Code]             VARCHAR (50)    NULL,
    [valueString_Txt]              VARCHAR (255)   NULL,
    [valueNumerator]               REAL            NULL,
    [valueNumerator_Unit]          VARCHAR (50)    NULL,
    [valueNumerator_UnPr]          VARCHAR (50)    NULL,
    [valueNumerator_Alt]           REAL            NULL,
    [valueDenominator]             REAL            NULL,
    [valueDenominator_Unit]        VARCHAR (50)    NULL,
    [valueDenominator_UnPr]        VARCHAR (50)    NULL,
    [valueDenominator_Alt]         REAL            NULL,
    [valueCode_OrTx]               VARCHAR (50)    NULL,
    [metaCode]                     VARCHAR (50)    NULL,
    [IF_FileType]                  VARCHAR (250)   NULL,
    [IF_FileName]                  VARCHAR (250)   NULL,
    [IF_Content]                   VARBINARY (MAX) NULL,
    [IF_DateAndTimeCreated]        DATETIME        NULL,
    [IF_FileLinkDR]                INT             NULL,
    [valueCode_ID]                 INT             NULL,
    [valueDenominator_Alt_Unit_ID] INT             NULL,
    [valueNumerator_Alt_Unit_ID]   INT             NULL,
    [ServerId]                     INT             NULL,
    [ID]                           BIGINT          IDENTITY (1, 1) NOT NULL,
    [Act_ID]                       INT             NULL,
    [ActRelationship_ID]           INT             NULL,
    [Entity_ID]                    INT             NULL,
    [EntityAddress_ID]             INT             NULL,
    [EntityName_ID]                INT             NULL,
    [EntityTelecom_ID]             INT             NULL,
    [parentAttrib_ID]              BIGINT          NULL,
    [Participation_ID]             INT             NULL,
    [Role_ID]                      INT             NULL,
    [valueLink_ID]                 INT             NULL,
    CONSTRAINT [T_Attribute_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95) ON [ATTRIBUTE_DATA_GROUP],
    CONSTRAINT [A_Act_T_Attribute_FK1] FOREIGN KEY ([Act_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [A_ActRelationship_T_Attribute_FK1] FOREIGN KEY ([ActRelationship_ID]) REFERENCES [dbo].[A_ActRelationship] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [E_Entity_T_Attribute_FK1] FOREIGN KEY ([Entity_ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_T_Attribute_valueCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([valueCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_T_Attribute_valueDenominator_Alt_Unit_ID_V_UNIFIEDCODESET] FOREIGN KEY ([valueDenominator_Alt_Unit_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_T_Attribute_valueNumerator_Alt_Unit_ID_V_UNIFIEDCODESET] FOREIGN KEY ([valueNumerator_Alt_Unit_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [P_Participation_T_Attribute_FK1] FOREIGN KEY ([Participation_ID]) REFERENCES [dbo].[P_Participation] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [R_Role_T_Attribute_FK1] FOREIGN KEY ([Role_ID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [S_FileLink_T_Attribute_FK1] FOREIGN KEY ([IF_FileLinkDR]) REFERENCES [dbo].[S_FileLink] ([FL_RowID]) NOT FOR REPLICATION,
    CONSTRAINT [S_Link_T_Attribute_FK1] FOREIGN KEY ([valueLink_ID]) REFERENCES [dbo].[S_Link] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_Attribute_T_Attribute_FK1] FOREIGN KEY ([parentAttrib_ID]) REFERENCES [dbo].[T_Attribute] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_EntityAddress_T_Attribute_FK1] FOREIGN KEY ([EntityAddress_ID]) REFERENCES [dbo].[T_EntityAddress] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_EntityName_T_Attribute_FK1] FOREIGN KEY ([EntityName_ID]) REFERENCES [dbo].[T_EntityName] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_EntityTelecom_T_Attribute_FK1] FOREIGN KEY ([EntityTelecom_ID]) REFERENCES [dbo].[T_EntityTelecom] ([ID]) NOT FOR REPLICATION
) ON [ATTRIBUTE_DATA_GROUP] TEXTIMAGE_ON [ATTRIBUTE_DATA_GROUP];


GO
ALTER TABLE [dbo].[T_Attribute] NOCHECK CONSTRAINT [A_Act_T_Attribute_FK1];


GO
ALTER TABLE [dbo].[T_Attribute] NOCHECK CONSTRAINT [A_ActRelationship_T_Attribute_FK1];


GO
ALTER TABLE [dbo].[T_Attribute] NOCHECK CONSTRAINT [E_Entity_T_Attribute_FK1];


GO
ALTER TABLE [dbo].[T_Attribute] NOCHECK CONSTRAINT [FK_A_T_Attribute_valueCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[T_Attribute] NOCHECK CONSTRAINT [FK_A_T_Attribute_valueDenominator_Alt_Unit_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[T_Attribute] NOCHECK CONSTRAINT [FK_A_T_Attribute_valueNumerator_Alt_Unit_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[T_Attribute] NOCHECK CONSTRAINT [P_Participation_T_Attribute_FK1];


GO
ALTER TABLE [dbo].[T_Attribute] NOCHECK CONSTRAINT [R_Role_T_Attribute_FK1];


GO
ALTER TABLE [dbo].[T_Attribute] NOCHECK CONSTRAINT [S_FileLink_T_Attribute_FK1];


GO
ALTER TABLE [dbo].[T_Attribute] NOCHECK CONSTRAINT [S_Link_T_Attribute_FK1];


GO
ALTER TABLE [dbo].[T_Attribute] NOCHECK CONSTRAINT [T_Attribute_T_Attribute_FK1];


GO
ALTER TABLE [dbo].[T_Attribute] NOCHECK CONSTRAINT [T_EntityAddress_T_Attribute_FK1];


GO
ALTER TABLE [dbo].[T_Attribute] NOCHECK CONSTRAINT [T_EntityName_T_Attribute_FK1];


GO
ALTER TABLE [dbo].[T_Attribute] NOCHECK CONSTRAINT [T_EntityTelecom_T_Attribute_FK1];


GO
CREATE NONCLUSTERED INDEX [IX_T_Attribute_11]
    ON [dbo].[T_Attribute]([name] ASC, [Role_ID] ASC, [ID] ASC)
    INCLUDE([valueBool]) WITH (FILLFACTOR = 80)
    ON [ATTRIBUTE_IDX_GROUP];


GO
CREATE NONCLUSTERED INDEX [IX_T_Attribute_1]
    ON [dbo].[T_Attribute]([Entity_ID] ASC, [name] ASC)
    INCLUDE([type], [valueCode_ID], [valueBool], [valueInteger], [valueString_Txt], [metaCode], [valueTS]) WITH (FILLFACTOR = 80)
    ON [ATTRIBUTE_IDX_GROUP];


GO
CREATE NONCLUSTERED INDEX [IX_T_Attribute_ActName]
    ON [dbo].[T_Attribute]([Act_ID] ASC, [name] ASC)
    INCLUDE([valueCode_ID], [valueString_Txt]) WITH (FILLFACTOR = 80)
    ON [ATTRIBUTE_IDX_GROUP];


GO
CREATE NONCLUSTERED INDEX [IX_T_Attribute_4]
    ON [dbo].[T_Attribute]([name] ASC, [type] ASC, [valueBool] ASC)
    INCLUDE([metaCode], [Entity_ID]) WITH (FILLFACTOR = 80)
    ON [ATTRIBUTE_IDX_GROUP];


GO
CREATE NONCLUSTERED INDEX [IX_T_Attribute_5]
    ON [dbo].[T_Attribute]([name] ASC, [valueCode_ID] ASC) WITH (FILLFACTOR = 80)
    ON [ATTRIBUTE_IDX_GROUP];


GO
CREATE NONCLUSTERED INDEX [IX_T_Attribute_ActRelID]
    ON [dbo].[T_Attribute]([ActRelationship_ID] ASC) WITH (FILLFACTOR = 80)
    ON [ATTRIBUTE_IDX_GROUP];


GO
CREATE NONCLUSTERED INDEX [IX_T_Attribute_EADRID]
    ON [dbo].[T_Attribute]([EntityAddress_ID] ASC) WITH (FILLFACTOR = 80)
    ON [ATTRIBUTE_IDX_GROUP];


GO
CREATE NONCLUSTERED INDEX [IX_T_Attribute_FLDR]
    ON [dbo].[T_Attribute]([IF_FileLinkDR] ASC) WITH (FILLFACTOR = 80)
    ON [ATTRIBUTE_IDX_GROUP];


GO
CREATE NONCLUSTERED INDEX [IX_T_Attribute_NameValueStringCode]
    ON [dbo].[T_Attribute]([name] ASC, [valueString_Code] ASC)
    INCLUDE([ActRelationship_ID], [Entity_ID]) WITH (FILLFACTOR = 80)
    ON [ATTRIBUTE_IDX_GROUP];


GO
CREATE NONCLUSTERED INDEX [IX_T_Attribute_NameValueTS]
    ON [dbo].[T_Attribute]([name] ASC, [valueTS] ASC) WITH (FILLFACTOR = 80)
    ON [ATTRIBUTE_IDX_GROUP];


GO
CREATE NONCLUSTERED INDEX [IX_T_Attribute_NM_VST]
    ON [dbo].[T_Attribute]([name] ASC, [valueString_Txt] ASC)
    INCLUDE([Act_ID], [Entity_ID]) WITH (FILLFACTOR = 80)
    ON [ATTRIBUTE_IDX_GROUP];


GO
CREATE NONCLUSTERED INDEX [IX_T_Attribute_ParAttrID]
    ON [dbo].[T_Attribute]([parentAttrib_ID] ASC) WITH (FILLFACTOR = 80)
    ON [ATTRIBUTE_IDX_GROUP];


GO
CREATE NONCLUSTERED INDEX [IX_T_Attribute_Role]
    ON [dbo].[T_Attribute]([Role_ID] ASC, [name] ASC)
    INCLUDE([valueBool], [valueCode_ID]) WITH (FILLFACTOR = 80)
    ON [ATTRIBUTE_IDX_GROUP];


GO
CREATE NONCLUSTERED INDEX [IX_T_Attribute_UpdateTime_Name]
    ON [dbo].[T_Attribute]([name] ASC, [Entity_ID] ASC, [updateTime] ASC) WHERE ([name] IN ('LOC_LastUpdatedDateTime', 'RS_LastUpdatedDateTime')) WITH (FILLFACTOR = 80)
    ON [ATTRIBUTE_IDX_GROUP];


GO
CREATE STATISTICS [IX_WA_parentAttrib_ID]
    ON [dbo].[T_Attribute]([parentAttrib_ID]);


GO
CREATE STATISTICS [IX_WA_type]
    ON [dbo].[T_Attribute]([type]);


GO
CREATE STATISTICS [IX_WA_valueString_Txt]
    ON [dbo].[T_Attribute]([valueString_Txt]);

