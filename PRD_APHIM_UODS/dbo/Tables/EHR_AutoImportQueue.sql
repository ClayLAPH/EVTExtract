CREATE TABLE [dbo].[EHR_AutoImportQueue] (
    [ID]           INT      IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [RecordID]     INT      NOT NULL,
    [ProviderID]   INT      NOT NULL,
    [DateReceived] DATETIME NOT NULL,
    [Status]       TINYINT  NOT NULL,
    [Timestamp]    DATETIME DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95)
);

