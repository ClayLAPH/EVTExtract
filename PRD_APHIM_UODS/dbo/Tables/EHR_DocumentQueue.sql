CREATE TABLE [dbo].[EHR_DocumentQueue] (
    [ID]          INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Document_ID] INT              NOT NULL,
    [Process_ID]  UNIQUEIDENTIFIER NULL,
    [Priority]    TINYINT          NOT NULL,
    [Status]      TINYINT          NOT NULL,
    [Timestamp]   DATETIME         DEFAULT (getdate()) NOT NULL,
    [Comment]     NVARCHAR (MAX)   NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95)
);

