CREATE TABLE [dbo].[S_ImportUtilityOUTB] (
    [S_ID]                  INT          NOT NULL,
    [OB_RowID]              INT          NULL,
    [OB_OutbreakID]         VARCHAR (50) NULL,
    [OB_OutbreakNumber]     VARCHAR (50) NULL,
    [OB_DiseaseDR]          INT          NULL,
    [OB_OutbreakLocationDR] INT          NULL,
    [OB_DateOfOnset]        DATETIME     NULL,
    [OB_DateCreated]        DATETIME     NULL,
    CONSTRAINT [S_ImportUtilityOUTB_PK] PRIMARY KEY NONCLUSTERED ([S_ID] ASC) WITH (FILLFACTOR = 70) ON [PRIMARY_IDX]
);

