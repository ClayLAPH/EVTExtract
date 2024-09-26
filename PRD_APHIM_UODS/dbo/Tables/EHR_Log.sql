CREATE TABLE [dbo].[EHR_Log] (
    [ID]        INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Source]    NVARCHAR (100)  NOT NULL,
    [LogType]   TINYINT         DEFAULT ((0)) NOT NULL,
    [Message]   NVARCHAR (1000) NOT NULL,
    [Details]   NVARCHAR (MAX)  NULL,
    [Timestamp] DATETIME        DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95)
);

