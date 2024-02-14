CREATE TYPE [dbo].[RecordLockReleaseType] AS TABLE (
    [RecordID]        VARCHAR (250) NOT NULL,
    [LockType]        VARCHAR (100) NOT NULL,
    [LastFetchedDate] VARCHAR (100) NULL);

