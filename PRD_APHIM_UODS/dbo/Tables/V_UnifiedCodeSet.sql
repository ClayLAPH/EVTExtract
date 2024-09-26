CREATE TABLE [dbo].[V_UnifiedCodeSet] (
    [valueSet]      VARCHAR (100) NULL,
    [conceptId]     INT           NULL,
    [conceptCode]   VARCHAR (50)  NOT NULL,
    [fullName]      VARCHAR (255) NULL,
    [shortName]     VARCHAR (100) NULL,
    [otherInfo]     VARCHAR (MAX) NULL,
    [statusActive]  BIT           NULL,
    [statusCode]    VARCHAR (10)  NULL,
    [systemVersion] VARCHAR (20)  NULL,
    [lastUpdate]    DATETIME      NULL,
    [ID]            INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [domain_ID]     INT           NULL,
    [equivUCS_ID]   INT           NULL,
    [externalOid]   VARCHAR (50)  NULL,
    CONSTRAINT [V_UnifiedCodeSet_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95) ON [PRIMARY_IDX],
    CONSTRAINT [FK_V_UnifiedCodeSet_V_Domain] FOREIGN KEY ([domain_ID]) REFERENCES [dbo].[V_Domain] ([ID]) NOT FOR REPLICATION
) ON [PRIMARY_IDX];


GO
ALTER TABLE [dbo].[V_UnifiedCodeSet] NOCHECK CONSTRAINT [FK_V_UnifiedCodeSet_V_Domain];


GO
ALTER TABLE [dbo].[V_UnifiedCodeSet] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_V_UnifiedCodeSet_1]
    ON [dbo].[V_UnifiedCodeSet]([domain_ID] ASC, [statusActive] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_V_UnifiedCodeSet_2]
    ON [dbo].[V_UnifiedCodeSet]([domain_ID] ASC, [statusActive] ASC, [fullName] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_V_UnifiedCodeSet_3]
    ON [dbo].[V_UnifiedCodeSet]([domain_ID] ASC, [statusActive] ASC, [valueSet] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_V_UnifiedCodeSet_4]
    ON [dbo].[V_UnifiedCodeSet]([fullName] ASC, [domain_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_V_UnifiedCodeSet_5]
    ON [dbo].[V_UnifiedCodeSet]([conceptCode] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE STATISTICS [IX_WA_lastUpdate]
    ON [dbo].[V_UnifiedCodeSet]([lastUpdate]);


GO

CREATE TRIGGER [dbo].[TR_UCSLastUpdate_AfterInsert] ON [dbo].[V_UnifiedCodeSet] 
FOR INSERT
AS
BEGIN
	UPDATE [dbo].[V_UnifiedCodeSet]
	SET [dbo].[V_UnifiedCodeSet].lastUpdate = getdate()
	FROM [dbo].[V_UnifiedCodeSet] 
	INNER JOIN inserted i 
	ON [dbo].[V_UnifiedCodeSet].id=i.id
	WHERE i.lastUpdate IS NULL
END

GO

CREATE TRIGGER [dbo].[TR_UCSLastUpdate_AfterUpdate] 
ON [dbo].[V_UnifiedCodeSet] 
FOR UPDATE
AS
BEGIN
	UPDATE [dbo].[V_UnifiedCodeSet]
	SET [dbo].[V_UnifiedCodeSet].lastUpdate = getdate()
	FROM [dbo].[V_UnifiedCodeSet] 
	INNER JOIN inserted i 
	ON [dbo].[V_UnifiedCodeSet].id=i.id
END
