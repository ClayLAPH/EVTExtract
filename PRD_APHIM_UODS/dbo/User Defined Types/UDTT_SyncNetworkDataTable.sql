CREATE TYPE [dbo].[UDTT_SyncNetworkDataTable] AS TABLE (
    [ID]         INT         NOT NULL,
    [RecordType] VARCHAR (5) NULL,
    [op]         VARCHAR (1) NULL);

