CREATE TABLE [dbo].[Alert_RequestQueue] (
    [ID]                INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
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
    [Type]              VARCHAR (50)    NULL,
    CONSTRAINT [PK_Temp_Queue] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95)
);


GO
CREATE NONCLUSTERED INDEX [ix_Alert_RequestQueue_jt]
    ON [dbo].[Alert_RequestQueue]([ID] ASC)
    INCLUDE([EventDefinitionID], [EventType], [Subject], [Message], [DistrictGroup], [District], [RecordType], [EventValueName], [EventValueDR], [Type]);

