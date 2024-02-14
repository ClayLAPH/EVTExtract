CREATE TABLE [covid].[IRISExtractStatus] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [TableName]   VARCHAR (250) NOT NULL,
    [RowCount]    INT           DEFAULT ((0)) NULL,
    [IsCompleted] BIT           DEFAULT ((0)) NULL,
    [StartTime]   DATETIME      NULL,
    [EndTime]     DATETIME      NULL,
    CONSTRAINT [PK_IRISExtractStatus_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

