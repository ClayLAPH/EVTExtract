CREATE TABLE [dbo].[ScriptHistory] (
    [ScriptName]   VARCHAR (100)  NOT NULL,
    [IssueNumber]  VARCHAR (50)   NOT NULL,
    [DateExecuted] DATETIME       CONSTRAINT [DF_ScriptHistory_DateExecuted] DEFAULT (getdate()) NOT NULL,
    [Version]      VARCHAR (50)   NULL,
    [Notes]        VARCHAR (4000) NULL
);

