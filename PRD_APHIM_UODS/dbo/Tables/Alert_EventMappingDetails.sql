CREATE TABLE [dbo].[Alert_EventMappingDetails] (
    [EMD_Rowid]        INT IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [EMD_RecordTypeDR] INT NULL,
    [EMD_EventTypeDR]  INT NULL,
    CONSTRAINT [PK_Alert_EventMappingDetails] PRIMARY KEY CLUSTERED ([EMD_Rowid] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_Alert_EventMappingDetails_EMD_EventTypeDR_V_UnifiedCodeSet_ID] FOREIGN KEY ([EMD_EventTypeDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Alert_EventMappingDetails_EMD_RecordTypeDR_V_UnifiedCodeSet_ID] FOREIGN KEY ([EMD_RecordTypeDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);

