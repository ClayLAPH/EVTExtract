CREATE TABLE [dbo].[EHR_TransformedDocument] (
    [ID]                         INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Document_ID]                INT              NOT NULL,
    [MessageMonitor_ID]          UNIQUEIDENTIFIER NOT NULL,
    [CaseReportFilter]           NVARCHAR (2000)  NOT NULL,
    [RawTransformedContent]      VARBINARY (MAX)  NOT NULL,
    [ToImportTransformedContent] VARBINARY (MAX)  NULL,
    [IsProcessed]                BIT              DEFAULT ((0)) NOT NULL,
    [Timestamp]                  DATETIME         NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95)
);

