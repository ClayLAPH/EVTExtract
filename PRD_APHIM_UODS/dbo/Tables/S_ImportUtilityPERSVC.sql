CREATE TABLE [dbo].[S_ImportUtilityPERSVC] (
    [S_ID]                    INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PAT_ID]                  INT           NULL,
    [SVC_ROWID]               INT           NULL,
    [PAT_NCMid]               VARCHAR (50)  NULL,
    [PAT_FirstName]           VARCHAR (100) NULL,
    [PAT_LastName]            VARCHAR (100) NULL,
    [PAT_FirstInitial]        VARCHAR (1)   NULL,
    [PAT_DOB]                 DATETIME      NULL,
    [PAT_SS]                  VARCHAR (50)  NULL,
    [PAT_Gender_FK]           INT           NULL,
    [PAT_AccountNumber]       VARCHAR (50)  NULL,
    [PAT_SourceIdentifier]    VARCHAR (50)  NULL,
    [REFINFO_Jurisdiction_FK] INT           NULL,
    [SVC_CurrentService_FK]   INT           NULL,
    [PAT_CDCGender]           VARCHAR (255) NULL,
    CONSTRAINT [S_ImportUtilityPERSVC_PK] PRIMARY KEY NONCLUSTERED ([S_ID] ASC) WITH (FILLFACTOR = 70)
);

