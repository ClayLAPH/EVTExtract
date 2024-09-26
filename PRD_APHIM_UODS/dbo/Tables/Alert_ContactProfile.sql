CREATE TABLE [dbo].[Alert_ContactProfile] (
    [CP_RowID]             INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [CP_PriorityDR]        INT            NULL,
    [CP_UserDR]            INT            NULL,
    [CP_ContactTypeDR]     INT            NULL,
    [CP_Name]              NVARCHAR (100) NULL,
    [CP_ContactDetail]     NVARCHAR (255) NULL,
    [CP_OnMonday]          BIT            NULL,
    [CP_OnTuesday]         BIT            NULL,
    [CP_OnWednesday]       BIT            NULL,
    [CP_OnThursday]        BIT            NULL,
    [CP_OnFriday]          BIT            NULL,
    [CP_OnSaturday]        BIT            NULL,
    [CP_OnSunday]          BIT            NULL,
    [CP_StartTime]         TIME (0)       NOT NULL,
    [CP_EndTime]           TIME (0)       NOT NULL,
    [CP_IsActive]          BIT            NULL,
    [CP_IsTwentyFourHours] BIT            NULL,
    CONSTRAINT [PK_ContactProfile] PRIMARY KEY CLUSTERED ([CP_RowID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_Alert_ContactProfile_CP_ContactTypeDR_V_UnifiedCodeSet_ID] FOREIGN KEY ([CP_ContactTypeDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Alert_ContactProfile_CP_PriorityDR_V_UnifiedCodeSet_ID] FOREIGN KEY ([CP_PriorityDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Alert_ContactProfile_CP_UserDR_E_Entity_ID] FOREIGN KEY ([CP_UserDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION
);

