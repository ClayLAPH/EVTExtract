CREATE TABLE [dbo].[EHR_ValueMapping] (
    [ID]             INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Mapping_CodeID] INT             NOT NULL,
    [Value]          NVARCHAR (2000) NOT NULL,
    [ValueID]        INT             NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95)
);

