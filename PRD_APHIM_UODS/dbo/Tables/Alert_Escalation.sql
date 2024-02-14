CREATE TABLE [dbo].[Alert_Escalation] (
    [ESC_RowID]                   INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ESC_EscalationContactTypeDR] INT            NULL,
    [ESC_PriorityDR]              INT            NULL,
    [ESC_UserDR]                  INT            NULL,
    [ESC_IntervalInMinutes]       SMALLINT       NULL,
    [ESC_NumberOfAttempts]        SMALLINT       NULL,
    [ESC_MinutesBeforeEscalation] SMALLINT       NULL,
    [ESC_EscalationDetail]        NVARCHAR (255) NULL,
    CONSTRAINT [PK_Escalation] PRIMARY KEY CLUSTERED ([ESC_RowID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_Alert_Escalation_ESC_EscalationContactTypeDR_V_UnifiedCodeSet_ID] FOREIGN KEY ([ESC_EscalationContactTypeDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Alert_Escalation_ESC_PriorityDR_V_UnifiedCodeSet_ID] FOREIGN KEY ([ESC_PriorityDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Alert_Escalation_ESC_UserDR_E_entity_ID] FOREIGN KEY ([ESC_UserDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION
);


GO
CREATE NONCLUSTERED INDEX [IX_Alert_Escalation_Priority_User]
    ON [dbo].[Alert_Escalation]([ESC_PriorityDR] ASC, [ESC_UserDR] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

