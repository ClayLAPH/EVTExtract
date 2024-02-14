CREATE TABLE [dbo].[VCP_UserDefinedMenu] (
    [UDM_ID]         VARCHAR (50)    NULL,
    [subjCode_Id]    INT             NULL,
    [UDM_SubMenuDR]  INT             NULL,
    [UDM_FunctionDR] INT             NULL,
    [UDM_Url]        NVARCHAR (2100) NULL,
    [UDM_JavaScript] VARCHAR (MAX)   NULL,
    [ID]             INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    CONSTRAINT [PK_VCP_UserDefinedMenu] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_VCP_UserDefinedMenu_FunctionDR_V_UnifiedCodeSet] FOREIGN KEY ([UDM_FunctionDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_VCP_UserDefinedMenu_SubjCode_ID_V_UnifiedCodeSet] FOREIGN KEY ([subjCode_Id]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_VCP_UserDefinedMenu_SubMenuDR_V_UnifiedCodeSet] FOREIGN KEY ([UDM_SubMenuDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[VCP_UserDefinedMenu] NOCHECK CONSTRAINT [FK_VCP_UserDefinedMenu_FunctionDR_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[VCP_UserDefinedMenu] NOCHECK CONSTRAINT [FK_VCP_UserDefinedMenu_SubjCode_ID_V_UnifiedCodeSet];


GO
ALTER TABLE [dbo].[VCP_UserDefinedMenu] NOCHECK CONSTRAINT [FK_VCP_UserDefinedMenu_SubMenuDR_V_UnifiedCodeSet];

