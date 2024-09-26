CREATE TABLE [dbo].[CachedDataForELR] (
    [Module]    VARCHAR (50) NOT NULL,
    [TimeStamp] DATETIME     NULL,
    CONSTRAINT [PK_CachedDataForELR] PRIMARY KEY CLUSTERED ([Module] ASC) WITH (FILLFACTOR = 95)
);

