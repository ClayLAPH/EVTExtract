CREATE TABLE [dbo].[R_Employee] (
    [jobCode_OrTx]            VARCHAR (50) NULL,
    [jobTitleNameCode]        VARCHAR (50) NULL,
    [jobTitleNameText]        VARCHAR (50) NULL,
    [jobClassCode_OrTx]       VARCHAR (50) NULL,
    [occupationCode_OrTx]     VARCHAR (50) NULL,
    [salaryTypeCode_OrTx]     VARCHAR (50) NULL,
    [salaryQuantity]          MONEY        NULL,
    [salaryQuantity_Unit]     VARCHAR (50) NULL,
    [hazardExposureText]      VARCHAR (50) NULL,
    [protectiveEquipmentText] VARCHAR (50) NULL,
    [jobClassCode_ID]         INT          NULL,
    [jobCode_ID]              INT          NULL,
    [occupationCode_ID]       INT          NULL,
    [salaryTypeCode_ID]       INT          NULL,
    [ID]                      INT          NOT NULL,
    CONSTRAINT [R_Employee_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [FK_A_R_Employee_jobClassCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([jobClassCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_R_Employee_jobCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([jobCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_R_Employee_occupationCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([occupationCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_R_Employee_salaryTypeCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([salaryTypeCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [R_Role_R_Employee_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[R_Employee] NOCHECK CONSTRAINT [FK_A_R_Employee_jobClassCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[R_Employee] NOCHECK CONSTRAINT [FK_A_R_Employee_jobCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[R_Employee] NOCHECK CONSTRAINT [FK_A_R_Employee_occupationCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[R_Employee] NOCHECK CONSTRAINT [FK_A_R_Employee_salaryTypeCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[R_Employee] NOCHECK CONSTRAINT [R_Role_R_Employee_FK1];

