CREATE TABLE [dbo].[TRACE20160322] (
    [RowNumber]       INT             IDENTITY (0, 1) NOT FOR REPLICATION NOT NULL,
    [EventClass]      INT             NULL,
    [TextData]        NVARCHAR (MAX)  NULL,
    [ApplicationName] NVARCHAR (128)  NULL,
    [NTUserName]      NVARCHAR (128)  NULL,
    [LoginName]       NVARCHAR (128)  NULL,
    [CPU]             INT             NULL,
    [Reads]           BIGINT          NULL,
    [Writes]          BIGINT          NULL,
    [Duration]        BIGINT          NULL,
    [ClientProcessID] INT             NULL,
    [SPID]            INT             NULL,
    [StartTime]       DATETIME        NULL,
    [EndTime]         DATETIME        NULL,
    [BinaryData]      VARBINARY (MAX) NULL,
    PRIMARY KEY CLUSTERED ([RowNumber] ASC) WITH (FILLFACTOR = 95)
);

