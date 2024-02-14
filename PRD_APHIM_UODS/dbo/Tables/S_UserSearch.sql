CREATE TABLE [dbo].[S_UserSearch] (
    [ID]             INT            IDENTITY (1, 1) NOT NULL,
    [PageNameID]     INT            NOT NULL,
    [UserID]         INT            NOT NULL,
    [SearchParams]   NVARCHAR (MAX) NOT NULL,
    [HashValue]      VARCHAR (255)  NOT NULL,
    [SearchType]     VARCHAR (255)  NOT NULL,
    [SaveSearchName] VARCHAR (255)  NULL,
    [SearchDate]     DATETIME       NOT NULL,
    CONSTRAINT [PK_S_UserSearch] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_S_UserSearch_S_PageDetails] FOREIGN KEY ([PageNameID]) REFERENCES [dbo].[S_PageDetails] ([ID])
);


GO
CREATE NONCLUSTERED INDEX [IX_S_UserSearch_UsrID]
    ON [dbo].[S_UserSearch]([UserID] ASC, [PageNameID] ASC, [SearchType] ASC, [HashValue] ASC) WITH (FILLFACTOR = 80);

