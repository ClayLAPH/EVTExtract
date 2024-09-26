CREATE TABLE [dbo].[V_CodeProperty] (
    [property]      VARCHAR (50)    NOT NULL,
    [counter]       INT             NULL,
    [active]        BIT             NULL,
    [lastUpdate]    DATETIME        NULL,
    [sortOrder]     REAL            NULL,
    [valueBool]     BIT             NULL,
    [valueDate]     DATETIME        NULL,
    [valueImage]    VARBINARY (MAX) NULL,
    [valueInt]      INT             NULL,
    [valueReal]     REAL            NULL,
    [valueString]   VARCHAR (255)   NULL,
    [valueText]     VARCHAR (MAX)   NULL,
    [subjCode_ID]   INT             NULL,
    [valueCode_ID]  INT             NULL,
    [ID]            INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [parentProp_ID] INT             NULL,
    [Entity_ID]     INT             NULL,
    CONSTRAINT [V_CodeProperty_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_A_V_CodeProperty_subjCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([subjCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_V_CodeProperty_valueCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([valueCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_V_CodeProperty_E_Entity] FOREIGN KEY ([Entity_ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [V_CodeProperty_V_CodeProperty_FK1] FOREIGN KEY ([parentProp_ID]) REFERENCES [dbo].[V_CodeProperty] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[V_CodeProperty] NOCHECK CONSTRAINT [FK_A_V_CodeProperty_subjCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[V_CodeProperty] NOCHECK CONSTRAINT [FK_A_V_CodeProperty_valueCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[V_CodeProperty] NOCHECK CONSTRAINT [FK_V_CodeProperty_E_Entity];


GO
ALTER TABLE [dbo].[V_CodeProperty] NOCHECK CONSTRAINT [V_CodeProperty_V_CodeProperty_FK1];


GO
ALTER TABLE [dbo].[V_CodeProperty] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_V_CodeProperty]
    ON [dbo].[V_CodeProperty]([property] ASC, [valueString] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_V_CodeProperty_3]
    ON [dbo].[V_CodeProperty]([valueBool] ASC, [valueCode_ID] ASC, [property] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_V_CodeProperty_5]
    ON [dbo].[V_CodeProperty]([parentProp_ID] ASC)
    INCLUDE([property], [valueCode_ID]) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_V_CodeProperty_SC_SV]
    ON [dbo].[V_CodeProperty]([subjCode_ID] ASC)
    INCLUDE([valueCode_ID], [property]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_V_CodeProperty_VC_VV]
    ON [dbo].[V_CodeProperty]([valueCode_ID] ASC)
    INCLUDE([valueText]) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IX_V_CodeProperty_property_valueCode_ID_inc]
    ON [dbo].[V_CodeProperty]([property] ASC, [valueCode_ID] ASC)
    INCLUDE([subjCode_ID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_V_CodeProperty_Entity_ID]
    ON [dbo].[V_CodeProperty]([Entity_ID] ASC) WITH (FILLFACTOR = 70);


GO
CREATE STATISTICS [IX_WA_subjCode_ID]
    ON [dbo].[V_CodeProperty]([subjCode_ID]);


GO
CREATE STATISTICS [IX_WA_valueCode_ID]
    ON [dbo].[V_CodeProperty]([valueCode_ID]);


GO
CREATE STATISTICS [IX_WA_property]
    ON [dbo].[V_CodeProperty]([property]);


GO
CREATE STATISTICS [IX_WA_valueBool]
    ON [dbo].[V_CodeProperty]([valueBool]);


GO
CREATE STATISTICS [IX_WA_valueInt]
    ON [dbo].[V_CodeProperty]([valueInt]);


GO
CREATE STATISTICS [IX_WA_valueString]
    ON [dbo].[V_CodeProperty]([valueString]);


GO

CREATE TRIGGER [dbo].[TR_CodePropertyLastUpdate_AfterInsert] ON [dbo].[V_CodeProperty] 
FOR INSERT
AS
BEGIN
	UPDATE [dbo].[V_CodeProperty]
	SET [dbo].[V_CodeProperty].lastUpdate = getdate()
	FROM [dbo].[V_CodeProperty] 
	INNER JOIN inserted i 
	ON [dbo].[V_CodeProperty].ID = i.ID
	WHERE i.lastUpdate IS NULL
END

GO

CREATE TRIGGER [dbo].[TR_CodePropertyLastUpdate_AfterUpdate] ON [dbo].[V_CodeProperty] 
FOR UPDATE
AS
BEGIN
	UPDATE [dbo].[V_CodeProperty]
	SET [dbo].[V_CodeProperty].lastUpdate = getdate()
	FROM [dbo].[V_CodeProperty] 
	INNER JOIN inserted i 
	ON [dbo].[V_CodeProperty].ID = i.ID
END
