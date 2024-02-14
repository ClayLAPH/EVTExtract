CREATE TABLE [dbo].[EHR_Document] (
    [ID]                    INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FUID]                  NVARCHAR (MAX)  NULL,
    [Document_IdentifierID] INT             NULL,
    [ProviderID]            NVARCHAR (510)  NULL,
    [Document]              VARBINARY (MAX) NOT NULL,
    [DateReceived]          DATETIME        DEFAULT (getdate()) NOT NULL,
    [DateProcessed]         DATETIME        NULL,
    [Status]                TINYINT         NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95)
);

