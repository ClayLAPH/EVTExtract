CREATE TABLE [dbo].[SYS_GlobalStatus] (
    [Key]            VARCHAR (250)  NOT NULL,
    [Value]          VARCHAR (250)  NULL,
    [TimeStamp]      DATETIME       NULL,
    [Type]           VARCHAR (100)  CONSTRAINT [DF_SYS_GlobalStatus_Type] DEFAULT ('CONFIG') NOT NULL,
    [AdditionalInfo] NVARCHAR (MAX) NULL,
    CONSTRAINT [SYS_GlobalStatus_PK] PRIMARY KEY CLUSTERED ([Key] ASC, [Type] ASC) WITH (FILLFACTOR = 95)
);

