/****** Object:  UserDefinedFunction [dbo].[FN_RMR_GetFilterExpressionForColumn]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_GetFilterExpressionForColumn]
(
    @ruleFilterRowID as int
)
returns nvarchar(max)
as
BEGIN
    return dbo.[FN_RMR_CreateFilterExpression](@ruleFilterRowID)
END
