CREATE TABLE [dbo].[S_PageDetails] (
    [ID]          INT           IDENTITY (1, 1) NOT NULL,
    [ConceptCode] VARCHAR (50)  NULL,
    [PageName]    VARCHAR (255) NULL,
    CONSTRAINT [PK_S_PageDetails] PRIMARY KEY CLUSTERED ([ID] ASC)
);

