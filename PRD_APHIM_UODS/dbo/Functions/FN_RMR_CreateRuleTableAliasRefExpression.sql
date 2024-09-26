/****** Object:  UserDefinedFunction [dbo].[FN_RMR_CreateRuleTableAliasRefExpression]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_CreateRuleTableAliasRefExpression](
@ruleDefinitionID int
)
returns nvarchar(max)
Begin
    declare @finalExpr nvarchar(max)        
    select @finalExpr=COALESCE(@finalExpr + ',' + AliasName, AliasName) 
    from [dbo].[FN_RMR_GetRuleTableAliasRef] (@ruleDefinitionID) TableAliasRef
    return @finalExpr
End
