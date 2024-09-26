CREATE TABLE [dbo].[SYS_InternallyReportedIssue] (
    [ID]               INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Issue]            VARCHAR (255)  NULL,
    [DetailedProblem]  VARCHAR (1000) NULL,
    [DateTimeReported] DATETIME       NULL,
    [UserDR]           INT            NOT NULL,
    [IsResolved]       BIT            NULL,
    CONSTRAINT [SYS_InternallyReportedIssue_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_SYS_InternallyReportedIssue_ID] FOREIGN KEY ([UserDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION
);


GO
CREATE NONCLUSTERED INDEX [IX_SYS_InternallyReportedIssue_1]
    ON [dbo].[SYS_InternallyReportedIssue]([Issue] ASC, [DateTimeReported] ASC) WITH (FILLFACTOR = 70);


GO
ALTER INDEX [IX_SYS_InternallyReportedIssue_1]
    ON [dbo].[SYS_InternallyReportedIssue] DISABLE;

