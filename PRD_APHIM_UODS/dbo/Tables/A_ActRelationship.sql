CREATE TABLE [dbo].[A_ActRelationship] (
    [typeCode]                VARCHAR (50) NOT NULL,
    [typeCode_OrTx]           VARCHAR (50) NULL,
    [inversionInd]            BIT          NULL,
    [contextControlCode]      VARCHAR (50) NULL,
    [contextControlCode_OrTx] VARCHAR (50) NULL,
    [contextConductionInd]    BIT          NULL,
    [sequenceNumber]          INT          NULL,
    [priorityNumber]          INT          NULL,
    [pauseQuantity]           REAL         NULL,
    [pauseQuantity_Unit]      VARCHAR (50) NULL,
    [pauseQunatity_UnPr]      VARCHAR (50) NULL,
    [checkPointCode]          VARCHAR (50) NULL,
    [checkPointCode_OrTx]     VARCHAR (50) NULL,
    [splitCode]               VARCHAR (50) NULL,
    [splitCode_OrTx]          VARCHAR (50) NULL,
    [joinCode]                VARCHAR (50) NULL,
    [joinCode_OrTx]           VARCHAR (50) NULL,
    [negationInd]             BIT          NULL,
    [conjunctionCode]         VARCHAR (50) NULL,
    [conjunctionCode_OrTx]    VARCHAR (50) NULL,
    [localVariableName]       VARCHAR (50) NULL,
    [seperatableInd]          BIT          NULL,
    [metaCode]                VARCHAR (50) NULL,
    [subsetCode]              VARCHAR (50) NULL,
    [subsetCode_OrTx]         VARCHAR (50) NULL,
    [undertaintyCode_OrTx]    VARCHAR (50) NULL,
    [localId]                 VARCHAR (50) NULL,
    [uncertaintyCode_ID]      INT          NULL,
    [ServerId]                INT          NULL,
    [ID]                      INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [source_ID]               INT          NULL,
    [target_ID]               INT          NULL,
    CONSTRAINT [A_ActRelationship_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95) ON [ACTREL_DATA],
    CONSTRAINT [A_Act_A_ActRelationship_FK1] FOREIGN KEY ([source_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [A_Act_A_ActRelationship_FK2] FOREIGN KEY ([target_ID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_A_A_ActRelationship_uncertaintyCode_ID_V_UNIFIEDCODESET] FOREIGN KEY ([uncertaintyCode_ID]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
) ON [ACTREL_DATA];


GO
ALTER TABLE [dbo].[A_ActRelationship] NOCHECK CONSTRAINT [A_Act_A_ActRelationship_FK1];


GO
ALTER TABLE [dbo].[A_ActRelationship] NOCHECK CONSTRAINT [A_Act_A_ActRelationship_FK2];


GO
ALTER TABLE [dbo].[A_ActRelationship] NOCHECK CONSTRAINT [FK_A_A_ActRelationship_uncertaintyCode_ID_V_UNIFIEDCODESET];


GO
ALTER TABLE [dbo].[A_ActRelationship] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_A_ActRelationship]
    ON [dbo].[A_ActRelationship]([source_ID] ASC, [typeCode] ASC)
    INCLUDE([metaCode], [target_ID]) WITH (FILLFACTOR = 70)
    ON [ACTREL_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_A_ActRelationship_targetID_typeCode_metaCode]
    ON [dbo].[A_ActRelationship]([target_ID] ASC, [typeCode] ASC, [metaCode] ASC) WITH (FILLFACTOR = 70)
    ON [ACTREL_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_A_ActRelationship_2]
    ON [dbo].[A_ActRelationship]([typeCode] ASC) WITH (FILLFACTOR = 70)
    ON [ACTREL_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_A_ActRelationship_1]
    ON [dbo].[A_ActRelationship]([target_ID] ASC, [typeCode] ASC, [metaCode] ASC)
    INCLUDE([typeCode_OrTx]) WITH (FILLFACTOR = 80)
    ON [ACTREL_IDX];


GO
CREATE TRIGGER DBO.ACTRELAFTERUPDATE
ON A_Actrelationship
FOR UPDATE
AS
    SET XACT_ABORT ON
    SET NOCOUNT ON
    DELETE S_ActRelationShipConstraint
        FROM deleted D
    WHERE S_ActRelationShipConstraint.Source_ID = ISNULL(D.source_ID, 0)
        AND S_ActRelationShipConstraint.Target_ID = ISNULL(D.target_ID, 0)
        AND S_ActRelationShipConstraint.MetaCode = ISNULL(d.metaCode, '')
        AND d.typeCode <> 'RPLC'

    INSERT INTO S_ActRelationShipConstraint (Source_ID, Target_ID, MetaCode)
        SELECT
            ISNULL(source_ID, 0),
            ISNULL(target_ID, 0),
            ISNULL(metaCode, '')
        FROM inserted
        WHERE typeCode <> 'RPLC'

GO
-----------------------------------------------------------
CREATE TRIGGER DBO.ACTRELEAFTERINSERT
ON A_ActRelationship
FOR INSERT
AS
    SET XACT_ABORT ON
    SET NOCOUNT ON
    INSERT INTO S_ActRelationShipConstraint (Source_ID, Target_ID, MetaCode)
        SELECT
            ISNULL(source_ID, 0),
            ISNULL(target_ID, 0),
            ISNULL(metaCode, '')
        FROM inserted
        WHERE typeCode <> 'RPLC'

GO
CREATE TRIGGER DBO.ACTRELAFTERDELETE
ON A_Actrelationship
FOR DELETE
AS
    SET XACT_ABORT ON
    SET NOCOUNT ON
    DELETE S_ActRelationShipConstraint
        FROM deleted D
    WHERE S_ActRelationShipConstraint.Source_ID = ISNULL(D.source_ID, 0)
        AND S_ActRelationShipConstraint.Target_ID = ISNULL(D.target_ID, 0)
        AND S_ActRelationShipConstraint.MetaCode = ISNULL(d.metaCode, '')
