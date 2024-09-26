CREATE TABLE [dbo].[R_RelationsDetails] (
    [ID]          INT     IDENTITY (1, 1) NOT NULL,
    [REL_ID]      INT     NOT NULL,
    [RecordDR]    INT     NULL,
    [RecordType]  TINYINT NULL,
    [SubRelation] INT     NULL,
    [LinkRole]    INT     NULL,
    CONSTRAINT [PK_R_RelationsDetails] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_R_RelationsDetails_R_RelationsDetails] FOREIGN KEY ([REL_ID]) REFERENCES [dbo].[R_Relations] ([ID]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_R_RelationDetails_REL_ID]
    ON [dbo].[R_RelationsDetails]([REL_ID] ASC)
    INCLUDE([RecordDR], [RecordType], [SubRelation]);


GO
CREATE NONCLUSTERED INDEX [IX_R_RelationDetails_RecordDR_RecordType]
    ON [dbo].[R_RelationsDetails]([RecordDR] ASC, [RecordType] ASC)
    INCLUDE([REL_ID]);

