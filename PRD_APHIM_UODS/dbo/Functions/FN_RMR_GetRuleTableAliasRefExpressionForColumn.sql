/****** Object:  UserDefinedFunction [dbo].[FN_RMR_GetRuleTableAliasRefExpressionForColumn]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_GetRuleTableAliasRefExpressionForColumn]
(
    @ruleDefinitionID as int
)
returns nvarchar(max)
as
BEGIN
    return dbo.[FN_RMR_CreateRuleTableAliasRefExpression](@ruleDefinitionID)
END
