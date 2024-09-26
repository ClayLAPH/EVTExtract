CREATE TABLE [dbo].[T_InstanceIdentifier] (
    [root]                   VARCHAR (100) NOT NULL,
    [extension]              VARCHAR (50)  NULL,
    [source]                 INT           NULL,
    [source_OrTx]            VARCHAR (50)  NULL,
    [name]                   VARCHAR (50)  NULL,
    [assigningAuthorityName] VARCHAR (100) NULL,
    [validTime_Beg]          DATETIME      NULL,
    [validTime_End]          DATETIME      NULL,
    [statusCode_OrTx]        VARCHAR (50)  NULL,
    [metaCode]               VARCHAR (50)  NULL,
    [sourceCode_ID]          INT           NULL,
    [statusCode_ID]          INT           NULL,
    [ServerId]               INT           NULL,
    [ID]                     INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Act_ID]                 INT           NULL,
    [ActRelationship_ID]     INT           NULL,
    [Entity_ID]              INT           NULL,
    [EntityAddress_ID]       INT           NULL,
    [EntityName_ID]          INT           NULL,
    [EntityTelecom_ID]       INT           NULL,
    [Participation_ID]       INT           NULL,
    [Role_ID]                INT           NULL,
    [RoleLink_ID]            INT           NULL,
    CONSTRAINT [T_InstanceIdentifier_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [A_Act_T_InstanceIdentifier_FK1] FOREIGN KEY ([Act_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [A_ActRelationship_T_InstanceIdentifier_FK1] FOREIGN KEY ([ActRelationship_ID]) REFERENCES [dbo].[A_ActRelationship] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [E_Entity_T_InstanceIdentifier_FK1] FOREIGN KEY ([Entity_ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_T_InstanceIdentifier_sourceCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([sourceCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_T_InstanceIdentifier_statusCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([statusCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [P_Participation_T_InstanceIdentifier_FK1] FOREIGN KEY ([Participation_ID]) REFERENCES [dbo].[P_Participation] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [R_Role_T_InstanceIdentifier_FK1] FOREIGN KEY ([Role_ID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [R_RoleLink_T_InstanceIdentifier_FK1] FOREIGN KEY ([RoleLink_ID]) REFERENCES [dbo].[R_RoleLink] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_EntityAddress_T_InstanceIdentifier_FK1] FOREIGN KEY ([EntityAddress_ID]) REFERENCES [dbo].[T_EntityAddress] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_EntityName_T_InstanceIdentifier_FK1] FOREIGN KEY ([EntityName_ID]) REFERENCES [dbo].[T_EntityName] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [T_EntityTelecom_T_InstanceIdentifier_FK1] FOREIGN KEY ([EntityTelecom_ID]) REFERENCES [dbo].[T_EntityTelecom] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[T_InstanceIdentifier] NOCHECK CONSTRAINT [A_Act_T_InstanceIdentifier_FK1];


GO
ALTER TABLE [dbo].[T_InstanceIdentifier] NOCHECK CONSTRAINT [A_ActRelationship_T_InstanceIdentifier_FK1];


GO
ALTER TABLE [dbo].[T_InstanceIdentifier] NOCHECK CONSTRAINT [E_Entity_T_InstanceIdentifier_FK1];


GO
ALTER TABLE [dbo].[T_InstanceIdentifier] NOCHECK CONSTRAINT [FK_A_T_InstanceIdentifier_sourceCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[T_InstanceIdentifier] NOCHECK CONSTRAINT [FK_A_T_InstanceIdentifier_statusCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[T_InstanceIdentifier] NOCHECK CONSTRAINT [P_Participation_T_InstanceIdentifier_FK1];


GO
ALTER TABLE [dbo].[T_InstanceIdentifier] NOCHECK CONSTRAINT [R_Role_T_InstanceIdentifier_FK1];


GO
ALTER TABLE [dbo].[T_InstanceIdentifier] NOCHECK CONSTRAINT [R_RoleLink_T_InstanceIdentifier_FK1];


GO
ALTER TABLE [dbo].[T_InstanceIdentifier] NOCHECK CONSTRAINT [T_EntityAddress_T_InstanceIdentifier_FK1];


GO
ALTER TABLE [dbo].[T_InstanceIdentifier] NOCHECK CONSTRAINT [T_EntityName_T_InstanceIdentifier_FK1];


GO
ALTER TABLE [dbo].[T_InstanceIdentifier] NOCHECK CONSTRAINT [T_EntityTelecom_T_InstanceIdentifier_FK1];


GO
CREATE NONCLUSTERED INDEX [IX_T_InstanceIdentifier_3]
    ON [dbo].[T_InstanceIdentifier]([Act_ID] ASC)
    INCLUDE([extension]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_T_InstanceIdentifier_1]
    ON [dbo].[T_InstanceIdentifier]([Entity_ID] ASC, [root] ASC)
    INCLUDE([extension]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_T_InstanceIdentifier_2]
    ON [dbo].[T_InstanceIdentifier]([Role_ID] ASC)
    INCLUDE([extension], [metaCode], [Entity_ID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_T_InstanceIdentifier_extension]
    ON [dbo].[T_InstanceIdentifier]([extension] ASC, [root] ASC)
    INCLUDE([metaCode], [Role_ID]) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_T_InstanceIdentifier_4]
    ON [dbo].[T_InstanceIdentifier]([root] ASC, [metaCode] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
ALTER INDEX [IX_T_InstanceIdentifier_4]
    ON [dbo].[T_InstanceIdentifier] DISABLE;


GO
CREATE NONCLUSTERED INDEX [IX_T_InstanceIdentifier_5]
    ON [dbo].[T_InstanceIdentifier]([EntityAddress_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_T_InstanceIdentifier]
    ON [dbo].[T_InstanceIdentifier]([root] ASC, [Act_ID] ASC)
    INCLUDE([extension]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE STATISTICS [IX_WA_metaCode]
    ON [dbo].[T_InstanceIdentifier]([metaCode]);


GO
CREATE STATISTICS [IX_WA_Role_ID]
    ON [dbo].[T_InstanceIdentifier]([Role_ID]);


GO
 
CREATE TRIGGER [dbo].[TR_InstanceIdentifier_AfterInsertUpdate]
ON  [dbo].[T_InstanceIdentifier]
AFTER  INSERT,UPDATE
AS 
BEGIN
	DECLARE @ID AS INT
	DECLARE @ROOT AS VARCHAR(200) 
	SET @ROOT = ''''
	DECLARE @EXTENSION AS VARCHAR(50)
	--SiteID has to be hardcoded for respective Client to avoid the performance impact.
	--Select dbo.[FN_GetSiteID]()  

	SELECT @ID=ID, @ROOT=ROOT, @EXTENSION=EXTENSION FROM INSERTED
	IF NOT EXISTS(SELECT TOP 1 1 FROM DELETED) 
	AND NOT EXISTS(SELECT TOP 1 1 FROM S_ProcessedPRRecord (NOLOCK) WHERE OriginalLiveRecord_ID = @ID 
	AND @ROOT= '2.16.840.1.113883.3.33.4.2.2.11.1.0.101.1') -- DI/CI
	AND (@ROOT= '2.16.840.1.113883.3.33.4.2.4.11.2.0.101.1' OR --CR
	@ROOT= '2.16.840.1.113883.3.33.4.2.2.11.7.0.101.1' OR -- OB
	@ROOT= '2.16.840.1.113883.3.33.4.2.2.11.8.0.101.1' -- AR
	 ) AND ISNUMERIC(@EXTENSION) = 1 
	BEGIN 
		ROLLBACK TRANSACTION
		RAISERROR ('Duplicate instance identified...', 16, 1); 
	END
	ELSE
	BEGIN
		EXEC USP_INSTANCEIDENTIFIER_UPDATE @ID, @ROOT, @EXTENSION
	END
	 
	 
END
