CREATE TABLE [dbo].[EHR_ImportQueueDependency] (
    [ID]            INT      IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ImportQueueID] INT      NOT NULL,
    [Dependency]    XML      NOT NULL,
    [Status]        TINYINT  DEFAULT ((1)) NOT NULL,
    [Timestamp]     DATETIME DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_EHR_ImportQueueDependency] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95)
);

