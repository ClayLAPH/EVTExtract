CREATE TABLE [dbo].[S_FollowUpSchedule] (
    [ID]                   INT      IDENTITY (1, 1) NOT NULL,
    [IssuedPasscode_RowID] INT      NOT NULL,
    [StartDate]            DATETIME NOT NULL,
    [DueDate]              DATETIME NOT NULL,
    [SubmissionDate]       DATETIME NULL,
    [ProcessedDate]        DATETIME NULL,
    CONSTRAINT [PK_S_FollowUpSchedule] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_S_FollowUpSchedule_S_IssuedPasscode] FOREIGN KEY ([IssuedPasscode_RowID]) REFERENCES [dbo].[S_IssuedPasscode] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[S_FollowUpSchedule] NOCHECK CONSTRAINT [FK_S_FollowUpSchedule_S_IssuedPasscode];


GO
CREATE NONCLUSTERED INDEX [IX_S_FollowUpSchedule_DateSchedule]
    ON [dbo].[S_FollowUpSchedule]([IssuedPasscode_RowID] ASC)
    INCLUDE([StartDate], [DueDate], [SubmissionDate]);

