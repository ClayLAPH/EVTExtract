CREATE TABLE [dbo].[S_GridColumnConfiguration] (
    [GridConfigID] INT           NOT NULL,
    [ColumnID]     INT           NOT NULL,
    [Width]        NVARCHAR (20) NULL,
    [DisplayOrder] INT           NULL,
    [Visible]      BIT           NULL,
    CONSTRAINT [FK_S_GridColumnConfiguration_S_GridColumn] FOREIGN KEY ([ColumnID]) REFERENCES [dbo].[S_GridColumn] ([ColumnID]),
    CONSTRAINT [FK_S_GridColumnConfiguration_S_GridConfiguration] FOREIGN KEY ([GridConfigID]) REFERENCES [dbo].[S_GridConfiguration] ([GridConfigID])
);

