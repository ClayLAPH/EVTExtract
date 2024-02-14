CREATE TABLE [dbo].[S_CensusFile] (
    [ID]             INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [UploadDateTime] DATETIME       NOT NULL,
    [FileName]       NVARCHAR (300) NOT NULL,
    [UploadStatus]   VARCHAR (8000) NULL,
    CONSTRAINT [PK_SCensus_ID] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95)
);

