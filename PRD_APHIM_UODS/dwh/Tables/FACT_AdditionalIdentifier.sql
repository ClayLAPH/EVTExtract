CREATE TABLE [dwh].[FACT_AdditionalIdentifier] (
    [AI_RowID]              INT            NOT NULL,
    [AI_PERRowID]           INT            NOT NULL,
    [AI_IdentifierTypeDR]   INT            NOT NULL,
    [AI_IssuingAuthorityDR] INT            NULL,
    [AI_Value]              NVARCHAR (100) NOT NULL,
    [AI_IssueDate]          DATETIME       NULL,
    [AI_ExpirationDate]     DATETIME       NULL,
    [AI_IsActive]           BIT            DEFAULT ((0)) NOT NULL,
    CONSTRAINT [FACT_AdditionalIdentifier_PK] PRIMARY KEY CLUSTERED ([AI_RowID] DESC) ON [DWH_DataGroup],
    CONSTRAINT [FK_FACT_AdditionalIdentifier_FACT_Person] FOREIGN KEY ([AI_PERRowID]) REFERENCES [dwh].[FACT_Person] ([PER_RowID]) ON DELETE CASCADE
) ON [DWH_DataGroup];


GO
CREATE NONCLUSTERED INDEX [FACT_AdditionalIdentifier_AI_PERRowID_NonClusteredIndex]
    ON [dwh].[FACT_AdditionalIdentifier]([AI_PERRowID] ASC) WITH (FILLFACTOR = 80)
    ON [DWH_IndexGroup];


GO
CREATE COLUMNSTORE INDEX [FACT_AdditionalIdentifier_NonClusteredColumnStoreIndex]
    ON [dwh].[FACT_AdditionalIdentifier]([AI_RowID], [AI_PERRowID], [AI_IdentifierTypeDR], [AI_IssuingAuthorityDR], [AI_Value], [AI_IssueDate], [AI_ExpirationDate], [AI_IsActive])
    ON [DWH_IndexGroup];

