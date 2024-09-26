CREATE TABLE [dbo].[S_AdditionalIdentifier] (
    [ID]                    INT           IDENTITY (1, 1) NOT NULL,
    [AI_PersonRowID]        INT           NOT NULL,
    [AI_IdentifierTypeDR]   INT           NOT NULL,
    [AI_IssuingAuthorityDR] INT           NULL,
    [AI_Value]              VARCHAR (100) NOT NULL,
    [AI_IssueDate]          DATETIME      NULL,
    [AI_ExpirationDate]     DATETIME      NULL,
    [AI_InActive]           BIT           NOT NULL,
    [AI_IntegrityChecksum]  VARCHAR (100) NULL,
    [AI_ModifiedByUserDR]   INT           NULL,
    CONSTRAINT [PK_S_AdditionalIdentifier] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_S_AdditionalIdentifier_AI_IdentifierTypeDR_V_UnifiedCodeSet] FOREIGN KEY ([AI_IdentifierTypeDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]),
    CONSTRAINT [FK_S_AdditionalIdentifier_AI_IssuingAuthorityDR_V_UnifiedCodeSet] FOREIGN KEY ([AI_IssuingAuthorityDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]),
    CONSTRAINT [FK_S_AdditionalIdentifier_AI_ModifiedByUserDR_E_Entity] FOREIGN KEY ([AI_ModifiedByUserDR]) REFERENCES [dbo].[E_Entity] ([ID]),
    CONSTRAINT [FK_S_AdditionalIdentifier_E_Entity] FOREIGN KEY ([AI_PersonRowID]) REFERENCES [dbo].[E_Entity] ([ID])
);


GO
ALTER TABLE [dbo].[S_AdditionalIdentifier] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);


GO
CREATE NONCLUSTERED INDEX [IX_S_AdditionalIdentifier_Value_Type_Authority]
    ON [dbo].[S_AdditionalIdentifier]([AI_Value] ASC, [AI_IdentifierTypeDR] ASC, [AI_InActive] ASC)
    INCLUDE([AI_PersonRowID], [AI_IssuingAuthorityDR]) WITH (FILLFACTOR = 70);


GO
CREATE NONCLUSTERED INDEX [IX_S_AdditionalIdentifier_PersonRowID]
    ON [dbo].[S_AdditionalIdentifier]([AI_PersonRowID] ASC, [AI_InActive] ASC);

