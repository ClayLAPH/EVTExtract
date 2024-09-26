CREATE TABLE [dbo].[S_Grid] (
    [GridID]         INT            IDENTITY (1, 1) NOT NULL,
    [GridIdentifier] NVARCHAR (100) NULL,
    [Description]    NVARCHAR (500) NULL,
    CONSTRAINT [PK_S_Grid] PRIMARY KEY CLUSTERED ([GridID] ASC) WITH (FILLFACTOR = 95)
);

