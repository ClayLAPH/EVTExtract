CREATE TABLE [dbo].[S_RecentlyViewedRecord] (
    [ID]             INT      IDENTITY (1, 1) NOT NULL,
    [RecordTypeID]   INT      NOT NULL,
    [UserID]         INT      NOT NULL,
    [RecordID]       INT      NOT NULL,
    [DateLastViewed] DATETIME NOT NULL,
    CONSTRAINT [PK_S_RecentlyViewedRecord] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95)
);


GO
CREATE NONCLUSTERED INDEX [IX_S_RecentlyViewedRecord_UIDType]
    ON [dbo].[S_RecentlyViewedRecord]([UserID] ASC, [RecordTypeID] ASC, [RecordID] ASC)
    INCLUDE([DateLastViewed]) WITH (FILLFACTOR = 70);

