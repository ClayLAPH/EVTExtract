CREATE TABLE [dbo].[S_Template] (
    [IUT_ID]         INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IUT_Name]       VARCHAR (250)   NULL,
    [IUT_Content]    VARBINARY (MAX) NULL,
    [IUT_Type]       VARCHAR (50)    NULL,
    [IUT_XSDContent] VARBINARY (MAX) NULL,
    CONSTRAINT [PK_S_ImportUtilityTemplate] PRIMARY KEY CLUSTERED ([IUT_ID] ASC) WITH (FILLFACTOR = 95)
);

