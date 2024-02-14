CREATE TABLE [dbo].[Alert_Queue] (
    [Q_RowID]           INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Q_ContactTypeDR]   INT            NULL,
    [Q_EventInstanceDR] INT            NULL,
    [Q_DateTime]        DATETIME       NULL,
    [Q_Message]         NVARCHAR (MAX) NULL,
    [Q_Subject]         VARCHAR (1000) NULL,
    [Q_EventName]       NVARCHAR (255) NULL,
    [Q_IsAcknowledged]  BIT            NULL,
    [Q_ContactDetail]   NVARCHAR (255) NULL,
    [Q_UserDR]          INT            NULL,
    CONSTRAINT [PK_Queue] PRIMARY KEY CLUSTERED ([Q_RowID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_Alert_Queue_Q_ContactTypeDR_V_UnifiedCodeSet_ID] FOREIGN KEY ([Q_ContactTypeDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Alert_Queue_Q_EventInstanceDR_Alert_EventInstance_EI_RowID] FOREIGN KEY ([Q_EventInstanceDR]) REFERENCES [dbo].[Alert_EventInstance] ([EI_RowID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Alert_Queue_Q_UserDR_E_entity_ID] FOREIGN KEY ([Q_UserDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION
);

