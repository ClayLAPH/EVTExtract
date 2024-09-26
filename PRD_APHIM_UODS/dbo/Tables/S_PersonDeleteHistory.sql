CREATE TABLE [dbo].[S_PersonDeleteHistory] (
    [ID]            INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [RootID]        INT           NOT NULL,
    [History]       VARCHAR (MAX) NULL,
    [StatusCode]    VARCHAR (20)  NOT NULL,
    [DateDeleted]   DATETIME      CONSTRAINT [DF_S_PersonDeleteHistory_DateDeleted] DEFAULT (getdate()) NOT NULL,
    [DateUndeleted] DATETIME      NULL,
    [Comments]      VARCHAR (MAX) NULL,
    CONSTRAINT [PK_S_PersonDeleteHistory] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_S_PersonDeleteHistory_E_Entity] FOREIGN KEY ([RootID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[S_PersonDeleteHistory] NOCHECK CONSTRAINT [FK_S_PersonDeleteHistory_E_Entity];

