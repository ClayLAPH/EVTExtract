/****** Object:  UserDefinedFunction [dbo].[FN_RMR_GetQueryByRuleIDForColumn]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_GetQueryByRuleIDForColumn](
@ruleDefinitionID int
)
returns nvarchar(max)
Begin
    return dbo.[FN_RMR_CreateQueryByRuleID](@ruleDefinitionID)
End
