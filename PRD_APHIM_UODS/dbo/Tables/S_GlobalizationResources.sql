CREATE TABLE [dbo].[S_GlobalizationResources] (
    [ID]            INT            IDENTITY (1, 1) NOT NULL,
    [ResourceScope] NVARCHAR (255) NULL,
    [ResourceName]  NVARCHAR (255) NULL,
    [ResourceValue] NVARCHAR (MAX) NULL,
    [CultureName]   NVARCHAR (50)  NULL,
    [Description]   VARCHAR (MAX)  NULL,
    CONSTRAINT [PK_S_GlobalizationResources] PRIMARY KEY CLUSTERED ([ID] ASC)
);

