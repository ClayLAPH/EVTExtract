CREATE TABLE [dbo].[Alert_ContactOverride] (
    [CO_RowID]             INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [CO_UserDR]            INT            NULL,
    [CO_PriorityDR]        INT            NULL,
    [CO_Name]              NVARCHAR (100) NULL,
    [CO_StartDate]         DATE           NOT NULL,
    [CO_StartTime]         TIME (0)       NOT NULL,
    [CO_EndDate]           DATE           NOT NULL,
    [CO_EndTime]           TIME (0)       NOT NULL,
    [CO_ContactTypeDR]     INT            NULL,
    [CO_ContactDetail]     NVARCHAR (255) NULL,
    [CO_IsActive]          BIT            NULL,
    [CO_IsTwentyFourHours] BIT            NULL,
    CONSTRAINT [PK_ContactOverride] PRIMARY KEY CLUSTERED ([CO_RowID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_Alert_ContactOverride_CO_ContactTypeDR_V_UnifiedCodeSet_ID] FOREIGN KEY ([CO_ContactTypeDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Alert_ContactOverride_CO_PriorityDR_V_UnifiedCodeSet_ID] FOREIGN KEY ([CO_PriorityDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Alert_ContactOverride_CO_UserDR_E_Entity_ID] FOREIGN KEY ([CO_UserDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION
);


GO
CREATE NONCLUSTERED INDEX [IX_Alert_ContactOverride_User_Priority_Status_Date]
    ON [dbo].[Alert_ContactOverride]([CO_UserDR] ASC, [CO_PriorityDR] ASC, [CO_IsActive] ASC, [CO_StartDate] ASC, [CO_EndDate] ASC)
    INCLUDE([CO_Name], [CO_StartTime], [CO_EndTime], [CO_ContactTypeDR], [CO_ContactDetail], [CO_IsTwentyFourHours]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

