CREATE TABLE [dbo].[EHR_DocumentIdentifier] (
    [ID]                   INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IdentifierXPath]      NVARCHAR (2000) NOT NULL,
    [SchemaFileName]       NVARCHAR (500)  NOT NULL,
    [NamespacePrefix]      NVARCHAR (200)  NOT NULL,
    [TargetNamespace]      NVARCHAR (200)  NOT NULL,
    [StylesheetAttributes] NVARCHAR (500)  NOT NULL,
    [Active]               BIT             NOT NULL,
    [DateCreated]          DATETIME        DEFAULT (getdate()) NOT NULL,
    [DateUpdated]          DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95)
);

