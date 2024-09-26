CREATE TABLE [dbo].[alert_requestqueue_IT250552] (
    [ID]                INT             IDENTITY (1, 1) NOT NULL,
    [EventDefinitionID] INT             NULL,
    [EventType]         INT             NULL,
    [RecordID]          INT             NULL,
    [Subject]           NVARCHAR (1000) NULL,
    [District]          NVARCHAR (MAX)  NULL,
    [DistrictGroup]     NVARCHAR (MAX)  NULL,
    [RecordType]        NVARCHAR (100)  NULL,
    [CurrentDateTime]   NVARCHAR (50)   NULL,
    [EventValueDR]      INT             NULL,
    [EventValueName]    NVARCHAR (1000) NULL,
    [Message]           NVARCHAR (MAX)  NULL,
    [Type]              VARCHAR (50)    NULL
);

