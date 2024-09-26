CREATE TYPE [dbo].[UDTT_SyncRelationsDataTable] AS TABLE (
    [ID]         INT         NOT NULL,
    [RecordType] VARCHAR (5) NULL,
    [op]         VARCHAR (1) NULL);

