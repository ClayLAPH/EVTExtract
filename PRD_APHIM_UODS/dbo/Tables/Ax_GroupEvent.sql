CREATE TABLE [dbo].[Ax_GroupEvent] (
    [ID]                 INT           NOT NULL,
    [InstanceID]         INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [EventNumber]        VARCHAR (50)  NOT NULL,
    [Description]        VARCHAR (255) NULL,
    [LocationDR]         INT           NULL,
    [DistrictDR]         INT           NULL,
    [DateOfEvent]        DATETIME      NULL,
    [ProcessStatusDR]    INT           NULL,
    [ResolutionStatusDR] INT           NULL,
    [UserDR]             INT           NULL,
    [InvestigatorDR]     INT           NULL,
    [PriorityDR]         INT           NULL,
    [isSubmitted]        BIT           NULL,
    [StatusDR]           INT           NULL,
    [CaseManagerDR]      INT           NULL,
    [StatusChangeDate]   DATETIME      NULL,
    CONSTRAINT [Ax_GroupEvent_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_Ax_GroupEvent_CaseManagerDR_E_Entity] FOREIGN KEY ([CaseManagerDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ax_GroupEvent_DistrictDR_V_UnifiedCodeSet] FOREIGN KEY ([DistrictDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ax_GroupEvent_ID_A_Act] FOREIGN KEY ([ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ax_GroupEvent_InvestigatorDR_E_Entity] FOREIGN KEY ([InvestigatorDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ax_GroupEvent_LocationDR_E_Entity] FOREIGN KEY ([LocationDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ax_GroupEvent_PriorityDR_V_UnifiedCodeSet] FOREIGN KEY ([PriorityDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ax_GroupEvent_ProcessStatusDR_V_UnifiedCodeSet] FOREIGN KEY ([ProcessStatusDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ax_GroupEvent_ResolutionStatusDR_V_UnifiedCodeSet] FOREIGN KEY ([ResolutionStatusDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ax_GroupEvent_StatusDR_V_UnifiedCodeSet] FOREIGN KEY ([StatusDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ax_GroupEvent_UserDR_E_Entity] FOREIGN KEY ([UserDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[Ax_GroupEvent] NOCHECK CONSTRAINT [FK_Ax_GroupEvent_CaseManagerDR_E_Entity];


GO
ALTER TABLE [dbo].[Ax_GroupEvent] NOCHECK CONSTRAINT [FK_Ax_GroupEvent_DistrictDR_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[Ax_GroupEvent] NOCHECK CONSTRAINT [FK_Ax_GroupEvent_ID_A_Act];


GO
ALTER TABLE [dbo].[Ax_GroupEvent] NOCHECK CONSTRAINT [FK_Ax_GroupEvent_InvestigatorDR_E_Entity];


GO
ALTER TABLE [dbo].[Ax_GroupEvent] NOCHECK CONSTRAINT [FK_Ax_GroupEvent_LocationDR_E_Entity];


GO
ALTER TABLE [dbo].[Ax_GroupEvent] NOCHECK CONSTRAINT [FK_Ax_GroupEvent_PriorityDR_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[Ax_GroupEvent] NOCHECK CONSTRAINT [FK_Ax_GroupEvent_ProcessStatusDR_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[Ax_GroupEvent] NOCHECK CONSTRAINT [FK_Ax_GroupEvent_ResolutionStatusDR_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[Ax_GroupEvent] NOCHECK CONSTRAINT [FK_Ax_GroupEvent_StatusDR_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[Ax_GroupEvent] NOCHECK CONSTRAINT [FK_Ax_GroupEvent_UserDR_E_Entity];


GO
ALTER TABLE [dbo].[Ax_GroupEvent] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_Ax_GroupEvent_EventNumber]
    ON [dbo].[Ax_GroupEvent]([EventNumber] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_Ax_GroupEvent_InstanceID]
    ON [dbo].[Ax_GroupEvent]([InstanceID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_Ax_GroupEvent_PriorityDR]
    ON [dbo].[Ax_GroupEvent]([PriorityDR] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_Ax_GroupEvent_DateOfEvent]
    ON [dbo].[Ax_GroupEvent]([DateOfEvent] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_AX_GroupEvent_InvestigatorDR]
    ON [dbo].[Ax_GroupEvent]([InvestigatorDR] ASC, [DistrictDR] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO

CREATE TRIGGER [dbo].[TR_GroupEvent_AfterInsertUpdate]
ON  [dbo].[Ax_GroupEvent]
WITH EXECUTE AS SELF 
AFTER  INSERT,UPDATE
AS 
BEGIN
    DECLARE @ID As INT, @COUNTERVALUE As INT, @TEMPEVENTNUMBER As VARCHAR(50), @EVENTNUMBER As VARCHAR(50)
    SELECT @ID=ID, @TEMPEVENTNUMBER = EVENTNUMBER FROM INSERTED
    Set @COUNTERVALUE = 0
    IF CHARINDEX('GE_Counter', @TEMPEVENTNUMBER) = 1
    BEGIN   
        DECLARE @TEMPYEAROFCOUNTER AS VARCHAR(4)
        DECLARE @CURRENTYEAR AS VARCHAR(4) = DATEPART(YEAR,GETDATE())

        SELECT TOP 1 @TEMPYEAROFCOUNTER=YEAROFCOUNTER FROM SYS_GroupEventCounter (NOLOCK)
        IF @CURRENTYEAR > @TEMPYEAROFCOUNTER
        BEGIN
            TRUNCATE TABLE SYS_GroupEventCounter
            DBCC CHECKIDENT ('SYS_GroupEventCounter', RESEED, 1)
        END

        INSERT INTO SYS_GroupEventCounter(GroupEvent_ID, YearOfCounter)
        VALUES(@ID, @CURRENTYEAR)
        SELECT @COUNTERVALUE=SCOPE_IDENTITY()

        IF @TEMPEVENTNUMBER='GE_Counter'
        BEGIN
            SET @EVENTNUMBER = 'GE'+ @CURRENTYEAR + CAST(@COUNTERVALUE AS VARCHAR(44))  
        END 
        UPDATE AX_GROUPEVENT SET EventNumber=@EVENTNUMBER FROM AX_GROUPEVENT WITH (HOLDLOCK, ROWLOCK) WHERE ID=@ID and EventNumber=@TEMPEVENTNUMBER
    END
END
