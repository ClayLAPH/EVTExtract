CREATE TABLE [dbo].[EHR_Template] (
    [ID]          INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]        NVARCHAR (300)  NOT NULL,
    [Description] NVARCHAR (1000) NULL,
    [Active]      BIT             NOT NULL,
    [DateCreated] DATETIME        DEFAULT (getdate()) NOT NULL,
    [DateUpdated] DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [CK_Template] UNIQUE NONCLUSTERED ([Name] ASC) WITH (FILLFACTOR = 70)
);

