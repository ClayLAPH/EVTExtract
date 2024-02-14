CREATE TABLE [dbo].[S_GridColumn] (
    [ColumnID]     INT            IDENTITY (1, 1) NOT NULL,
    [GridID]       INT            NOT NULL,
    [InternalName] NVARCHAR (500) NOT NULL,
    [DisplayName]  NVARCHAR (500) NULL,
    [Width]        NVARCHAR (20)  NULL,
    [DisplayOrder] INT            NULL,
    [Visible]      BIT            CONSTRAINT [DF_S_GridColumn_Visibility] DEFAULT ((1)) NOT NULL,
    [Active]       BIT            CONSTRAINT [DF_S_GridColumn_Active] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_S_GridColumn] PRIMARY KEY CLUSTERED ([ColumnID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_S_GridColumn_S_Grid] FOREIGN KEY ([GridID]) REFERENCES [dbo].[S_Grid] ([GridID])
);

