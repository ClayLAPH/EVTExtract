CREATE TABLE [dbo].[S_ActRelationShipConstraint] (
    [Source_ID] INT          NOT NULL,
    [Target_ID] INT          NOT NULL,
    [MetaCode]  VARCHAR (50) NOT NULL,
    [DupCount]  INT          CONSTRAINT [DF_S_ActRelationShipConstraint_DupCount] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_S_ActRelationShipConstraint] PRIMARY KEY NONCLUSTERED ([Target_ID] ASC, [Source_ID] ASC, [MetaCode] ASC) WITH (FILLFACTOR = 70)
);


GO
CREATE TRIGGER DBO.ACTRELCONSTRAINTINSTEADOFDELETE
ON S_ACTRELATIONSHIPCONSTRAINT
INSTEAD OF DELETE
AS
    SET XACT_ABORT ON
    SET NOCOUNT ON
    UPDATE S_ACTRELATIONSHIPCONSTRAINT
    SET S_ActRelationShipConstraint.DUPCOUNT = D.DUPCOUNT - 1
    FROM DELETED D
    WHERE S_ActRelationShipConstraint.Source_ID = D.Source_ID
    AND S_ActRelationShipConstraint.Target_ID = d.Target_ID
    AND S_ActRelationShipConstraint.MetaCode = ISNULL(d.metacode, '')
    AND D.DUPCOUNT > 1
    DELETE S_ActRelationShipConstraint
        FROM DELETED D
    WHERE S_ActRelationShipConstraint.Source_ID = D.Source_ID
        AND S_ActRelationShipConstraint.Target_ID = d.Target_ID
        AND S_ActRelationShipConstraint.MetaCode = ISNULL(d.metacode, '')
        AND D.DUPCOUNT = 1
