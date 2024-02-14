CREATE TABLE [dbo].[S_ConfigValue] (
    [ID]                  INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [configDefinition_ID] INT           NOT NULL,
    [LastUpdated]         DATETIME      NOT NULL,
    [Value]               SQL_VARIANT   NULL,
    [specialValue]        VARCHAR (MAX) NULL,
    CONSTRAINT [PK_S_ConfigValue] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_S_ConfigValue_S_ConfigDefinition] FOREIGN KEY ([configDefinition_ID]) REFERENCES [dbo].[S_ConfigDefinition] ([ID])
);


GO
ALTER TABLE [dbo].[S_ConfigValue] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO

CREATE TRIGGER [dbo].[S_ConfigValue_LastUpdated]
ON  [dbo].[S_ConfigValue]
AFTER  INSERT,UPDATE
AS 
BEGIN
	DECLARE @CURRDATE AS VARCHAR(MAX)
	SELECT @CURRDATE= CONVERT(VARCHAR,GETDATE(),126)
		
	UPDATE [dbo].[S_CONFIGVALUE]
	SET [dbo].[S_CONFIGVALUE].LASTUPDATED = @CURRDATE
	FROM [dbo].[S_CONFIGVALUE] 
	INNER JOIN inserted i 
	ON [dbo].[S_CONFIGVALUE].ID = i.ID
	
	EXEC USP_UpdateGlobalStatusbyKey 'LatestConfigUpdateTime',@CURRDATE
END


