CREATE TABLE [dbo].[Alert_DeselectedSubscriptions] (
    [DSPS_SubscriptionDR]   INT NULL,
    [ID]                    INT IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DSPS_EventValueTypeDR] INT NULL,
    [DSPS_EventValueDR]     INT NULL,
    CONSTRAINT [PK_Alert_DeselectedSubscriptionProcessStatus] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_Alert_DeselectedSubscriptionProcessStatus_DSPS_SubscriptionDR_Alert_Subscription_SUB_RowID] FOREIGN KEY ([DSPS_SubscriptionDR]) REFERENCES [dbo].[Alert_Subscription] ([SUB_RowID]) NOT FOR REPLICATION
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Alert_DeselectSubscription_TypeValue]
    ON [dbo].[Alert_DeselectedSubscriptions]([DSPS_SubscriptionDR] ASC, [DSPS_EventValueTypeDR] ASC, [DSPS_EventValueDR] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

