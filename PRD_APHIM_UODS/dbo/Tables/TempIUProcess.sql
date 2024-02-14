CREATE TABLE [dbo].[TempIUProcess] (
    [Index]               NVARCHAR (50)  NOT NULL,
    [Value]               NVARCHAR (25)  NULL,
    [IsInitialized]       BIT            NULL,
    [IsStopped]           BIT            NULL,
    [SerializedUserInfo]  NVARCHAR (MAX) NULL,
    [ProcessID]           INT            CONSTRAINT [DF_TempIUProcess_ProcessID] DEFAULT ((-1)) NOT NULL,
    [NotificationToStop]  BIT            CONSTRAINT [DF_TempIUProcess_NotifyToStop] DEFAULT ((0)) NOT NULL,
    [TimeStamp]           DATETIME       CONSTRAINT [DF_TempIUProcess_TimeStamp] DEFAULT (getdate()) NOT NULL,
    [ReIndexingTimeStamp] DATETIME       NULL
);

