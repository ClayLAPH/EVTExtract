
CREATE FUNCTION [dbo].[FN_GetUserAccessibleReportSource]
(
	@UserID INT
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
DECLARE @ReportSource as NVARCHAR(MAX)

SELECT @ReportSource = COALESCE(@ReportSource + '; ', '') + [T_EntityName].[trivialName] 
FROM [E_Entity] (nolock) 
INNER JOIN [R_Role] (nolock) ON  [E_Entity].[ID]=[R_Role].[scoper_ID]
INNER JOIN [E_Entity] [LPA_U1] (nolock) ON  [LPA_U1].[ID]=[R_Role].[player_ID]
INNER JOIN [T_EntityName] (nolock) ON  [E_Entity].[ID]=[T_EntityName].[Entity_ID]
INNER JOIN [S_Link] (nolock) ON  [E_Entity].[ID]=[S_Link].[Entity1_ID]
WHERE ( 
[E_Entity].[classCode] = 'ORG' AND [E_Entity].[metaCode] = 'RS_RowID' AND [S_Link].[name] = 'RSLocation-Primary' 
AND (( [R_Role].[metaCode] = 'USR_AccessibleReportingSources' AND [R_Role].[classCode] = 'QUAL')) 
AND [T_EntityName].[metaCode] = 'RS_HealthCareProvider' 
AND [LPA_U1].[ID] = @UserID AND [E_Entity].[statusCode] = 'active' AND [E_Entity].[statusCode] <> 'nullified') 
ORDER BY [T_EntityName].[trivialName] ASC 

RETURN @ReportSource

END
