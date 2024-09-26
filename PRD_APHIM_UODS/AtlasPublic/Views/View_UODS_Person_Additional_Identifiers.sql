
CREATE VIEW [AtlasPublic].[View_UODS_Person_Additional_Identifiers]
AS
SELECT
    ID As AI_ROWID,
    AI_PersonRowID,
    AI_Value,
    AI_IdentifierTypeDR,
    AI_IssuingAuthorityDR,
    AI_IssueDate,
    AI_ExpirationDate,
    AI_InActive
FROM S_AdditionalIdentifier(NOLOCK)

