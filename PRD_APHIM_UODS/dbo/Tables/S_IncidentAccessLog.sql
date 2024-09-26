CREATE TABLE [dbo].[S_IncidentAccessLog] (
    [IAL_RowID]         INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IAL_RequestedFrom] VARCHAR (50)   NULL,
    [IAL_DateRequested] DATETIME       NULL,
    [IAL_UserDR]        INT            NULL,
    [IAL_PersonDR]      INT            NULL,
    [IAL_ReasonDR]      INT            NULL,
    [IAL_Notes]         VARCHAR (1000) NULL,
    CONSTRAINT [PK_S_IncidentAccessLog] PRIMARY KEY CLUSTERED ([IAL_RowID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [E_Entity_S_IncidentAccessLog_FK1] FOREIGN KEY ([IAL_PersonDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [E_Entity_S_IncidentAccessLog_FK2] FOREIGN KEY ([IAL_UserDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_ReasonDR_V_UNIFIEDCODESET] FOREIGN KEY ([IAL_ReasonDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[S_IncidentAccessLog] NOCHECK CONSTRAINT [E_Entity_S_IncidentAccessLog_FK1];


GO
ALTER TABLE [dbo].[S_IncidentAccessLog] NOCHECK CONSTRAINT [E_Entity_S_IncidentAccessLog_FK2];


GO
ALTER TABLE [dbo].[S_IncidentAccessLog] NOCHECK CONSTRAINT [FK_ReasonDR_V_UNIFIEDCODESET];


GO
CREATE NONCLUSTERED INDEX [IX_IAL_UserDR_PERSONDR]
    ON [dbo].[S_IncidentAccessLog]([IAL_UserDR] ASC, [IAL_PersonDR] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

