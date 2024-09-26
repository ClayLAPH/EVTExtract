CREATE TABLE [dbo].[R_Relations] (
    [ID]     INT IDENTITY (1, 1) NOT NULL,
    [Type]   INT NULL,
    [Ignore] BIT NULL,
    CONSTRAINT [PK_R_Relations] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
ALTER TABLE [dbo].[R_Relations] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_R_Relations_Type]
    ON [dbo].[R_Relations]([Type] ASC)
    ON [RMR_DataIndexGroup];

