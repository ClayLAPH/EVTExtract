CREATE TABLE [dbo].[S_GridConfiguration] (
    [GridConfigID]   INT            IDENTITY (1, 1) NOT NULL,
    [GridID]         INT            NOT NULL,
    [AdditionalInfo] NVARCHAR (100) NULL,
    [UserID]         INT            NULL,
    [Active]         BIT            CONSTRAINT [DF_S_GridConfiguration_Active] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_S_GridConfiguration] PRIMARY KEY CLUSTERED ([GridConfigID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_S_GridConfiguration_S_Grid] FOREIGN KEY ([GridID]) REFERENCES [dbo].[S_Grid] ([GridID])
);

