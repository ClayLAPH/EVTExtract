CREATE TABLE [dbo].[TEMP_V_CodeProperty] (
    [property]      VARCHAR (50)    NOT NULL,
    [counter]       INT             NULL,
    [active]        BIT             NULL,
    [lastUpdate]    DATETIME        NULL,
    [sortOrder]     REAL            NULL,
    [valueBool]     BIT             NULL,
    [valueDate]     DATETIME        NULL,
    [valueImage]    VARBINARY (MAX) NULL,
    [valueInt]      INT             NULL,
    [valueReal]     REAL            NULL,
    [valueString]   VARCHAR (255)   NULL,
    [valueText]     VARCHAR (MAX)   NULL,
    [subjCode_ID]   INT             NULL,
    [valueCode_ID]  INT             NULL,
    [ID]            INT             NOT NULL,
    [parentProp_ID] INT             NULL,
    [Entity_ID]     INT             NULL,
    [ActionType]    VARCHAR (10)    NULL,
    [ActionDate]    DATETIME        NULL
);

