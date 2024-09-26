CREATE TABLE [dbo].[TEMP_V_UnifiedCodeSet_BAK] (
    [valueSet]      VARCHAR (100) NULL,
    [conceptId]     INT           NULL,
    [conceptCode]   VARCHAR (50)  NOT NULL,
    [fullName]      VARCHAR (255) NULL,
    [shortName]     VARCHAR (100) NULL,
    [otherInfo]     VARCHAR (MAX) NULL,
    [statusActive]  BIT           NULL,
    [statusCode]    VARCHAR (10)  NULL,
    [systemVersion] VARCHAR (20)  NULL,
    [lastUpdate]    DATETIME      NULL,
    [ID]            INT           NOT NULL,
    [domain_ID]     INT           NULL,
    [equivUCS_ID]   INT           NULL,
    [ActionType]    VARCHAR (10)  NULL,
    [ActionDate]    DATETIME      NULL,
    [IssueNumber]   INT           NULL,
    [externalOid]   VARCHAR (50)  NULL
);

