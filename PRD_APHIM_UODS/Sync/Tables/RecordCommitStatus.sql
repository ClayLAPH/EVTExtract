CREATE TABLE [Sync].[RecordCommitStatus] (
    [CommitedChangeID]    BIGINT   NOT NULL,
    [CommitedTime]        DATETIME NOT NULL,
    [LastUpdatedDateTime] DATETIME NOT NULL,
    CONSTRAINT [PK_RecordCommitStatus] PRIMARY KEY CLUSTERED ([CommitedChangeID] ASC) ON [Sync_DataGroup]
) ON [Sync_DataGroup];

