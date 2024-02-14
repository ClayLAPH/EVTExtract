CREATE TABLE [dbo].[Alert_Queue_20200527] (
    [Q_RowID]           INT            IDENTITY (1, 1) NOT NULL,
    [Q_ContactTypeDR]   INT            NULL,
    [Q_EventInstanceDR] INT            NULL,
    [Q_DateTime]        DATETIME       NULL,
    [Q_Message]         NVARCHAR (MAX) NULL,
    [Q_Subject]         VARCHAR (1000) NULL,
    [Q_EventName]       NVARCHAR (255) NULL,
    [Q_IsAcknowledged]  BIT            NULL,
    [Q_ContactDetail]   NVARCHAR (255) NULL,
    [Q_UserDR]          INT            NULL
);

