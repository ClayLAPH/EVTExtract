CREATE TABLE [dbo].[S_FileLink] (
    [FL_RowID]              INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FL_Description]        VARCHAR (250) NULL,
    [FL_DateAndTimeCreated] DATETIME      NULL,
    CONSTRAINT [S_FileLink_PK] PRIMARY KEY NONCLUSTERED ([FL_RowID] ASC) WITH (FILLFACTOR = 70)
);

