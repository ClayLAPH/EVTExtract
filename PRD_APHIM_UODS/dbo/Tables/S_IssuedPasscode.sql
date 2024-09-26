CREATE TABLE [dbo].[S_IssuedPasscode] (
    [ID]                       INT            IDENTITY (1, 1) NOT NULL,
    [Record_RowID]             INT            NOT NULL,
    [RecordType]               CHAR (2)       NOT NULL,
    [Passcode]                 CHAR (9)       NOT NULL,
    [CreateDate]               DATETIME       NOT NULL,
    [ExpiryDate]               DATETIME       NOT NULL,
    [ScheduledFormID]          VARCHAR (50)   NOT NULL,
    [CommunicationTypeDR]      INT            NOT NULL,
    [CommunicationAddress]     VARCHAR (100)  NOT NULL,
    [SendReminder]             BIT            DEFAULT ((0)) NULL,
    [NotificationDetails]      NVARCHAR (MAX) NULL,
    [NotificationLastSentDate] DATETIME       NOT NULL,
    [ReferenceID]              INT            NULL,
    [IsHousehold]              BIT            DEFAULT ((0)) NULL,
    CONSTRAINT [PK_S_IssuedPasscode] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_S_IssuedPasscode_CommunicationTypeDR_V_UnifiedCodeSet] FOREIGN KEY ([CommunicationTypeDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[S_IssuedPasscode] NOCHECK CONSTRAINT [FK_S_IssuedPasscode_CommunicationTypeDR_V_UnifiedCodeSet];


GO
CREATE NONCLUSTERED INDEX [IX_S_IssuedPasscode_Passcode]
    ON [dbo].[S_IssuedPasscode]([Passcode] ASC)
    INCLUDE([ExpiryDate], [Record_RowID], [CommunicationTypeDR]);


GO
CREATE NONCLUSTERED INDEX [IX_S_IssuedPasscode_Record]
    ON [dbo].[S_IssuedPasscode]([ExpiryDate] ASC, [ReferenceID] ASC, [Record_RowID] ASC)
    INCLUDE([IsHousehold]);

