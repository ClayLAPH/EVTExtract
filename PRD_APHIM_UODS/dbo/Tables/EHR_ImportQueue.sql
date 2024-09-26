CREATE TABLE [dbo].[EHR_ImportQueue] (
    [ID]                     INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TransformedDocument_ID] INT              NOT NULL,
    [MessageMonitor_ID]      UNIQUEIDENTIFIER NOT NULL,
    [Process_ID]             UNIQUEIDENTIFIER NULL,
    [Priority]               TINYINT          NOT NULL,
    [Status]                 TINYINT          NOT NULL,
    [Timestamp]              DATETIME         NOT NULL,
    [Comment]                NVARCHAR (MAX)   NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95)
);

