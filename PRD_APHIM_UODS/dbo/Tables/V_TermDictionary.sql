CREATE TABLE [dbo].[V_TermDictionary] (
    [name]        VARCHAR (110) NOT NULL,
    [active]      BIT           NULL,
    [termDisplay] VARCHAR (255) NULL,
    [termOrder]   FLOAT (53)    NULL,
    [lastUpdate]  DATETIME      NULL,
    [ID]          INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [termCode_ID] INT           NULL,
    CONSTRAINT [V_TermDictionary_PK] PRIMARY KEY CLUSTERED ([name] ASC, [ID] ASC) WITH (FILLFACTOR = 95) ON [PRIMARY_IDX],
    CONSTRAINT [FK_A_V_TermDictionary_termCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([termCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID])
) ON [PRIMARY_IDX];


GO
ALTER TABLE [dbo].[V_TermDictionary] NOCHECK CONSTRAINT [FK_A_V_TermDictionary_termCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[V_TermDictionary] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_V_TermDictionary]
    ON [dbo].[V_TermDictionary]([name] ASC, [termCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_V_TermDictionary_1]
    ON [dbo].[V_TermDictionary]([termCode_ID] ASC, [active] ASC)
    INCLUDE([termDisplay], [name]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE STATISTICS [IX_WA_lastUpdate]
    ON [dbo].[V_TermDictionary]([lastUpdate]);


GO
CREATE STATISTICS [IX_WA_name]
    ON [dbo].[V_TermDictionary]([name]);


GO

CREATE TRIGGER [dbo].[TR_TDLastUpdate_AfterInsert] ON [dbo].[V_TermDictionary] 
FOR INSERT
AS
BEGIN
	UPDATE [dbo].[V_TermDictionary]
	SET [dbo].[V_TermDictionary].lastUpdate = getdate()
	FROM [dbo].[V_TermDictionary] 
	INNER JOIN inserted i 
	ON [V_TermDictionary].termCode_ID = i.termCode_ID 
	WHERE i.lastUpdate IS NULL
END

GO

CREATE TRIGGER [dbo].[TR_TDLastUpdate_AfterUpdate] ON [dbo].[V_TermDictionary] 
FOR UPDATE
AS
BEGIN
	UPDATE [dbo].[V_TermDictionary]
	SET [dbo].[V_TermDictionary].lastUpdate = getdate()
	FROM [dbo].[V_TermDictionary] 
	INNER JOIN inserted i 
	ON [V_TermDictionary].termCode_ID = i.termCode_ID 
END
