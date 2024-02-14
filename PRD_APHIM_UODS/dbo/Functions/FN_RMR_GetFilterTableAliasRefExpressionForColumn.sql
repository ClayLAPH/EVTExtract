/****** Object:  UserDefinedFunction [dbo].[FN_RMR_GetFilterTableAliasRefExpressionForColumn]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_GetFilterTableAliasRefExpressionForColumn]
(
    @ruleFilterRowID as int
)
returns nvarchar(max)
as
BEGIN
    return dbo.[FN_RMR_CreateFilterTableAliasRefExpression](@ruleFilterRowID)
END
