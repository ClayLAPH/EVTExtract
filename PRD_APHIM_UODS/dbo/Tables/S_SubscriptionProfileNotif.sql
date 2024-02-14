CREATE TABLE [dbo].[S_SubscriptionProfileNotif] (
    [SUBN_RowID]                 INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SUBN_FilesSent]             VARCHAR (250) NULL,
    [SUBN_DateAndTimeSent]       DATETIME      NULL,
    [SUBN_SubscriptionProfileDR] INT           NULL,
    [SUBN_ReportSourceDR]        INT           NULL,
    CONSTRAINT [S_SubscriptionProfileNotif_PK] PRIMARY KEY NONCLUSTERED ([SUBN_RowID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [E_Entity_S_SubscriptionProfileNotif_FK1] FOREIGN KEY ([SUBN_ReportSourceDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [S_SubscriptionProfile_S_SubscriptionProfileNotif_FK2] FOREIGN KEY ([SUBN_SubscriptionProfileDR]) REFERENCES [dbo].[S_SubscriptionProfile] ([SUB_RowID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[S_SubscriptionProfileNotif] NOCHECK CONSTRAINT [E_Entity_S_SubscriptionProfileNotif_FK1];


GO
ALTER TABLE [dbo].[S_SubscriptionProfileNotif] NOCHECK CONSTRAINT [S_SubscriptionProfile_S_SubscriptionProfileNotif_FK2];

