CREATE TABLE [dbo].[S_SecurityCodes] (
    [ID]              INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SecurityCode]    VARCHAR (10) COLLATE Latin1_General_CS_AS NOT NULL,
    [UserRole_ID]     INT          NOT NULL,
    [RequestDateTime] DATETIME     DEFAULT (getdate()) NOT NULL,
    [IsActive]        BIT          DEFAULT ((0)) NOT NULL,
    CONSTRAINT [S_SecurityCodes_PK] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95) ON [PRIMARY_IDX],
    CONSTRAINT [FK_S_SecurityCodes_R_Role] FOREIGN KEY ([UserRole_ID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION
) ON [PRIMARY_IDX];


GO
ALTER TABLE [dbo].[S_SecurityCodes] NOCHECK CONSTRAINT [FK_S_SecurityCodes_R_Role];


GO
CREATE NONCLUSTERED INDEX [IX_S_SecurityCodes_UserRole_ID_IsActive]
    ON [dbo].[S_SecurityCodes]([UserRole_ID] ASC, [IsActive] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_S_SecurityCodes_Unique_SecurityCode]
    ON [dbo].[S_SecurityCodes]([SecurityCode] ASC)
    INCLUDE([IsActive], [UserRole_ID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];

