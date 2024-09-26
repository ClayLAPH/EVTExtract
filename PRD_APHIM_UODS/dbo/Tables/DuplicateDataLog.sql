CREATE TABLE [dbo].[DuplicateDataLog] (
    [ID]                 INT           IDENTITY (1, 1) NOT NULL,
    [LogTimeStamp]       DATETIME      NULL,
    [TableName]          VARCHAR (50)  NULL,
    [DuplicateRecordIDs] VARCHAR (MAX) NULL,
    [RecordType]         VARCHAR (10)  NULL,
    [Description]        VARCHAR (255) NULL
);

