CREATE TABLE [dbo].[VCP_Dashboard] (
    [ID]                 INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [subjCode_Id]        INT             NULL,
    [DSBD_Url]           NVARCHAR (2000) NULL,
    [DSBD_DisplayType]   NVARCHAR (20)   NULL,
    [DSBD_HeightInUnits] INT             NULL,
    [DSBD_WidthInUnits]  INT             NULL,
    CONSTRAINT [PK_VCP_Dashboard] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_VCP_Dashboard_SubjCode_ID_V_UnifiedCodeSet] FOREIGN KEY ([subjCode_Id]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[VCP_Dashboard] NOCHECK CONSTRAINT [FK_VCP_Dashboard_SubjCode_ID_V_UnifiedCodeSet];

