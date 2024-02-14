CREATE TABLE [dbo].[S_ImportUtilityGE] (
    [S_ID]           INT          NOT NULL,
    [GE_RowID]       INT          NULL,
    [GE_InstanceID]  INT          NULL,
    [GE_EventNumber] VARCHAR (50) NULL,
    [GE_TypeDR]      INT          NULL,
    [GE_LocationDR]  INT          NULL,
    [GE_DateOfEvent] DATETIME     NULL,
    [GE_DateCreated] DATETIME     NULL,
    CONSTRAINT [S_ImportUtilityGE_PK] PRIMARY KEY CLUSTERED ([S_ID] ASC) WITH (FILLFACTOR = 95) ON [PRIMARY_IDX]
) ON [PRIMARY_IDX];

