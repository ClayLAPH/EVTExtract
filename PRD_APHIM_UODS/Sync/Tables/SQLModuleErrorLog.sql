CREATE TABLE [Sync].[SQLModuleErrorLog] (
    [id]                BIGINT         IDENTITY (1, 1) NOT NULL,
    [SQLBlockName]      NVARCHAR (250) NOT NULL,
    [Error_Severity]    INT            NULL,
    [Error_State]       INT            NULL,
    [Error_Message]     NVARCHAR (MAX) NULL,
    [Error_UtcDateTime] DATETIME       NOT NULL,
    [Error_DateTime]    DATETIME       NOT NULL,
    CONSTRAINT [PK_SQLModuleErrorLog] PRIMARY KEY CLUSTERED ([id] ASC) ON [Sync_DataGroup]
) ON [Sync_DataGroup] TEXTIMAGE_ON [Sync_TextDataGroup];

