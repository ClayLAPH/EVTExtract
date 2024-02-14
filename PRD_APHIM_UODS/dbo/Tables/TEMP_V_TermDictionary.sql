CREATE TABLE [dbo].[TEMP_V_TermDictionary] (
    [name]        VARCHAR (110) NOT NULL,
    [active]      BIT           NULL,
    [termDisplay] VARCHAR (255) NULL,
    [termOrder]   FLOAT (53)    NULL,
    [lastUpdate]  DATETIME      NULL,
    [ID]          INT           NOT NULL,
    [termCode_ID] INT           NULL,
    [ActionType]  VARCHAR (10)  NULL,
    [ActionDate]  DATETIME      NULL
);

