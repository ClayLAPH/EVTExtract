CREATE TABLE [dbo].[VCP_MessageAlert] (
    [IsInstantAlert]               BIT           NULL,
    [DateCreated]                  DATETIME      NULL,
    [DateTimeTransmit]             DATETIME      NULL,
    [Message]                      VARCHAR (MAX) NULL,
    [SubjCode_ID]                  INT           NULL,
    [TransmitToCode_ID]            INT           NULL,
    [ID]                           INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TypeDR]                       INT           NOT NULL,
    [UrgencyDR]                    INT           NULL,
    [IsRepeatingAlert]             BIT           DEFAULT ((0)) NULL,
    [TransmitToUserDR]             INT           NULL,
    [TransmitToRegionGroupDR]      INT           NULL,
    [Record_ActID]                 INT           NULL,
    [PropagateToAssociatedRecords] BIT           NULL,
    CONSTRAINT [VCP_SystemMessage_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [FK_A_VCP_MessageAlert_Record_ActID_A_ACT] FOREIGN KEY ([Record_ActID]) REFERENCES [dbo].[A_Act] ([ID]),
    CONSTRAINT [FK_A_VCP_MessageAlert_TransmitToRegionGroupDR_V_UNIFIEDCODESET] FOREIGN KEY ([TransmitToRegionGroupDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]),
    CONSTRAINT [FK_A_VCP_MessageAlert_TransmitToUserDR_E_ENTITY] FOREIGN KEY ([TransmitToUserDR]) REFERENCES [dbo].[E_Entity] ([ID]),
    CONSTRAINT [FK_A_VCP_MessageAlert_TypeDR_V_UNIFIEDCODESET] FOREIGN KEY ([TypeDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]),
    CONSTRAINT [FK_A_VCP_MessageAlert_UrgencyDR_V_UNIFIEDCODESET] FOREIGN KEY ([UrgencyDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]),
    CONSTRAINT [FK_A_VCP_SystemMessage_SubjCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([SubjCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_VCP_SystemMessage_TransmitToCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([TransmitToCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[VCP_MessageAlert] NOCHECK CONSTRAINT [FK_A_VCP_MessageAlert_Record_ActID_A_ACT];


GO
ALTER TABLE [dbo].[VCP_MessageAlert] NOCHECK CONSTRAINT [FK_A_VCP_MessageAlert_TransmitToRegionGroupDR_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_MessageAlert] NOCHECK CONSTRAINT [FK_A_VCP_MessageAlert_TransmitToUserDR_E_ENTITY];


GO
ALTER TABLE [dbo].[VCP_MessageAlert] NOCHECK CONSTRAINT [FK_A_VCP_MessageAlert_TypeDR_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_MessageAlert] NOCHECK CONSTRAINT [FK_A_VCP_MessageAlert_UrgencyDR_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_MessageAlert] NOCHECK CONSTRAINT [FK_A_VCP_SystemMessage_SubjCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[VCP_MessageAlert] NOCHECK CONSTRAINT [FK_A_VCP_SystemMessage_TransmitToCode_ID_V_UNIFIEDCODESET];


GO
CREATE NONCLUSTERED INDEX [IX_VCP_SystemMessage_SubjCode_SubjCvDo]
    ON [dbo].[VCP_MessageAlert]([SubjCode_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_VCP_MessageAlert_RecordAct_ID]
    ON [dbo].[VCP_MessageAlert]([Record_ActID] ASC) WITH (FILLFACTOR = 70);


GO
ALTER INDEX [IX_VCP_MessageAlert_RecordAct_ID]
    ON [dbo].[VCP_MessageAlert] DISABLE;


GO
CREATE NONCLUSTERED INDEX [IX_VCP_SystemMessage_TypeDR_DateCreated_DateTimeTransmit]
    ON [dbo].[VCP_MessageAlert]([TypeDR] ASC, [DateCreated] ASC, [DateTimeTransmit] ASC)
    INCLUDE([SubjCode_ID], [TransmitToCode_ID], [TransmitToUserDR], [TransmitToRegionGroupDR], [IsRepeatingAlert], [Record_ActID], [PropagateToAssociatedRecords]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

