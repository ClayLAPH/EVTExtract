CREATE TABLE [dbo].[Alert_ContactHistory] (
    [CH_RowID]                 INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [CH_EventInstanceDR]       INT            NULL,
    [CH_ContactTypeDR]         INT            NULL,
    [CH_DateTime]              DATETIME       NULL,
    [CH_SuccessStatusDR]       INT            NULL,
    [CH_AcknowledgementStatus] NVARCHAR (20)  NULL,
    [CH_ContactDetail]         NVARCHAR (255) NULL,
    [CH_UserDR]                INT            NULL,
    CONSTRAINT [PK_ContactHistory] PRIMARY KEY CLUSTERED ([CH_RowID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_Alert_ContactHistory_CH_ContactTypeDR_V_UnifiedCodeSet_ID] FOREIGN KEY ([CH_ContactTypeDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Alert_ContactHistory_CH_EventInstanceDR_Alert_EventInstance_EI_RowID] FOREIGN KEY ([CH_EventInstanceDR]) REFERENCES [dbo].[Alert_EventInstance] ([EI_RowID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Alert_ContactHistory_CH_UserDR_E_entity_ID] FOREIGN KEY ([CH_UserDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION
);


GO
CREATE NONCLUSTERED INDEX [IX_Alert_ContactHistory_UserDR]
    ON [dbo].[Alert_ContactHistory]([CH_UserDR] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_Alert_ContactHistory_DateTime]
    ON [dbo].[Alert_ContactHistory]([CH_DateTime] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
ALTER INDEX [IX_Alert_ContactHistory_DateTime]
    ON [dbo].[Alert_ContactHistory] DISABLE;

