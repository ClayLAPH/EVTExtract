﻿CREATE TABLE [dbo].[S_RoleConstraint] (
    [Scoper_ID] INT          NOT NULL,
    [Player_ID] INT          NOT NULL,
    [ClassCode] VARCHAR (50) NOT NULL,
    [DupCount]  INT          CONSTRAINT [DF_S_RoleConstraint_DupCount] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_S_RoleConstraint] PRIMARY KEY NONCLUSTERED ([Player_ID] ASC, [Scoper_ID] ASC, [ClassCode] ASC) WITH (FILLFACTOR = 70)
);


GO
CREATE TRIGGER DBO.ROLECONSTRAINTINSTEADOFDELETE
ON S_ROLECONSTRAINT
INSTEAD OF DELETE
AS
    SET XACT_ABORT ON
    SET NOCOUNT ON
    UPDATE S_ROLECONSTRAINT
    SET S_ROLECONSTRAINT.DUPCOUNT = D.DUPCOUNT - 1
    FROM DELETED D
    WHERE S_ROLECONSTRAINT.SCOPER_ID = D.SCOPER_ID
    AND S_ROLECONSTRAINT.player_id = D.Player_id
    AND S_ROLECONSTRAINT.classcode = D.classcode
    AND D.DUPCOUNT > 1
    DELETE S_ROLECONSTRAINT
        FROM DELETED D
    WHERE S_ROLECONSTRAINT.SCOPER_ID = D.SCOPER_ID
        AND S_ROLECONSTRAINT.player_id = D.Player_id
        AND S_ROLECONSTRAINT.classcode = D.classcode
        AND D.DUPCOUNT = 1
