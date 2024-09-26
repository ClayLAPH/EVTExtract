CREATE TYPE [dbo].[S_GridColumnConfigurationType] AS TABLE (
    [ColumnID]     INT           NOT NULL,
    [Width]        NVARCHAR (20) NULL,
    [DisplayOrder] INT           NULL,
    [Visible]      BIT           NULL);

