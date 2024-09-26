CREATE TABLE [dbo].[R_Role] (
    [classCode]             VARCHAR (50)  NOT NULL,
    [classCode_OrTx]        VARCHAR (50)  NULL,
    [code_OrTx]             VARCHAR (50)  NULL,
    [negationInd]           BIT           NULL,
    [statusCode]            VARCHAR (50)  CONSTRAINT [DF_R_Role_statusCode] DEFAULT ('active') NULL,
    [statusCode_OrTx]       VARCHAR (50)  NULL,
    [effectiveTime_Beg]     DATETIME      CONSTRAINT [DF_R_Role_effectiveTime_Beg] DEFAULT (getdate()) NULL,
    [effectiveTime_End]     DATETIME      NULL,
    [certificateText]       VARCHAR (MAX) NULL,
    [quantity_Nmr]          INT           NULL,
    [quantity_Dnm]          INT           NULL,
    [positionNumber1]       REAL          NULL,
    [positionNumber2]       REAL          NULL,
    [metaCode]              VARCHAR (50)  NULL,
    [confidentialCode_OrTx] VARCHAR (50)  NULL,
    [localId]               VARCHAR (50)  NULL,
    [code_ID]               INT           NULL,
    [confidentialCode_ID]   INT           NULL,
    [ServerId]              INT           NULL,
    [ID]                    INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [player_ID]             INT           NULL,
    [RoleHx_ID]             INT           NULL,
    [scoper_ID]             INT           NULL,
    CONSTRAINT [R_Role_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [E_Entity_R_Role_FK1] FOREIGN KEY ([player_ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [E_Entity_R_Role_FK2] FOREIGN KEY ([scoper_ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_R_Role_code_ID_V_UNIFIEDCODESET] FOREIGN KEY ([code_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_R_Role_confidentialCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([confidentialCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [R_Role_R_Role_FK1] FOREIGN KEY ([RoleHx_ID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[R_Role] NOCHECK CONSTRAINT [E_Entity_R_Role_FK1];


GO
ALTER TABLE [dbo].[R_Role] NOCHECK CONSTRAINT [E_Entity_R_Role_FK2];


GO
ALTER TABLE [dbo].[R_Role] NOCHECK CONSTRAINT [FK_A_R_Role_code_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[R_Role] NOCHECK CONSTRAINT [FK_A_R_Role_confidentialCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[R_Role] NOCHECK CONSTRAINT [R_Role_R_Role_FK1];


GO
ALTER TABLE [dbo].[R_Role] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_R_Role]
    ON [dbo].[R_Role]([player_ID] ASC, [classCode] ASC, [statusCode] ASC)
    INCLUDE([scoper_ID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_R_Role_1]
    ON [dbo].[R_Role]([scoper_ID] ASC, [classCode] ASC, [statusCode] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_R_Role_2]
    ON [dbo].[R_Role]([classCode] ASC, [metaCode] ASC, [player_ID] ASC, [scoper_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_R_Role_3]
    ON [dbo].[R_Role]([statusCode] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_R_Role_classCode_INC]
    ON [dbo].[R_Role]([classCode] ASC, [statusCode] ASC)
    INCLUDE([player_ID], [scoper_ID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE STATISTICS [IX_R_ROLE_PLAYERID_SCOPERID_CLASSCODE]
    ON [dbo].[R_Role]([player_ID], [scoper_ID], [classCode]);


GO
CREATE STATISTICS [IX_WA_classCode]
    ON [dbo].[R_Role]([classCode]);


GO
CREATE STATISTICS [IX_WA_metaCode]
    ON [dbo].[R_Role]([metaCode]);


GO
CREATE STATISTICS [IX_WA_statusCode]
    ON [dbo].[R_Role]([statusCode]);


GO
CREATE TRIGGER DBO.ROLEAFTERDELETE
ON R_Role
FOR DELETE
AS
    SET XACT_ABORT ON
    SET NOCOUNT ON
    DELETE S_roleconstraint
        FROM deleted D
    WHERE S_roleconstraint.Scoper_ID = ISNULL(D.scoper_ID, 0)
        AND S_roleconstraint.player_id = ISNULL(D.player_ID, 0)
        AND S_roleconstraint.classCode = ISNULL(d.classCode, '')


GO
CREATE TRIGGER DBO.ROLEAFTERUPDATE
ON R_Role
FOR UPDATE
AS
    SET XACT_ABORT ON
    SET NOCOUNT ON
    DELETE S_roleconstraint
        FROM deleted D
    WHERE S_roleconstraint.Scoper_ID = ISNULL(D.scoper_ID, 0)
        AND S_roleconstraint.player_id = ISNULL(D.player_ID, 0)
        AND S_roleconstraint.classCode = ISNULL(d.classCode, '')
        AND d.statusCode IN ('PENDING', 'ACTIVE')

    INSERT INTO S_roleconstraint (Scoper_ID, Player_ID, ClassCode)
        SELECT
            ISNULL(Scoper_ID, 0),
            ISNULL(Player_ID, 0),
            ISNULL(ClassCode, '')
        FROM inserted
        WHERE statusCode IN ('PENDING', 'ACTIVE')



GO
CREATE TRIGGER DBO.ROLEAFTERINSERT
ON R_Role
FOR INSERT
AS
    SET XACT_ABORT ON
    SET NOCOUNT ON
    INSERT INTO S_roleconstraint (Scoper_ID, Player_ID, ClassCode)
        SELECT
            ISNULL(Scoper_ID, 0),
            ISNULL(Player_ID, 0),
            ISNULL(ClassCode, '')
        FROM inserted
        WHERE statusCode IN ('PENDING', 'ACTIVE')
