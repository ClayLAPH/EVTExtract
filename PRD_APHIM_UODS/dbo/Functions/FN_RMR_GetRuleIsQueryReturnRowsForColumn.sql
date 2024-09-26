/****** Object:  UserDefinedFunction [dbo].[FN_RMR_GetRuleIsQueryReturnRowsForColumn]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_GetRuleIsQueryReturnRowsForColumn]
(
    @ruleDefinitionID as int
)
returns bit
as
BEGIN
    return dbo.[FN_RMR_GetRuleIsQueryReturnRows](@ruleDefinitionID)
END
