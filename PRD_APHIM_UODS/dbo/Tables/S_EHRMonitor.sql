CREATE TABLE [dbo].[S_EHRMonitor] (
    [ID]               UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [IncomingXML]      NVARCHAR (MAX)   NULL,
    [RetrievedValues]  NVARCHAR (MAX)   NULL,
    [locationOID]      VARCHAR (255)    NULL,
    [Status]           VARCHAR (255)    NULL,
    [PatientLastName]  VARCHAR (255)    NULL,
    [PatientFirstName] VARCHAR (255)    NULL,
    [DateTimeReceived] DATETIME         NOT NULL,
    [LocationID]       INT              NULL,
    [NPI]              VARCHAR (255)    NULL,
    [PHPR_ROWID]       INT              NULL,
    [Message]          VARCHAR (MAX)    NULL,
    [Document_ID]      INT              NULL,
    CONSTRAINT [PK_S_EHRMonitor] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_S_CaseAct_FK] FOREIGN KEY ([PHPR_ROWID]) REFERENCES [dbo].[A_Act] ([ID]),
    CONSTRAINT [FK_S_Location_FK] FOREIGN KEY ([LocationID]) REFERENCES [dbo].[E_Entity] ([ID])
);


GO
ALTER TABLE [dbo].[S_EHRMonitor] NOCHECK CONSTRAINT [FK_S_CaseAct_FK];


GO
ALTER TABLE [dbo].[S_EHRMonitor] NOCHECK CONSTRAINT [FK_S_Location_FK];


GO
CREATE NONCLUSTERED INDEX [IX_Status_PHPR_RowID]
    ON [dbo].[S_EHRMonitor]([Status] ASC, [PHPR_ROWID] ASC)
    INCLUDE([DateTimeReceived]) WITH (FILLFACTOR = 80)
    ON [PRIMARY_IDX];

