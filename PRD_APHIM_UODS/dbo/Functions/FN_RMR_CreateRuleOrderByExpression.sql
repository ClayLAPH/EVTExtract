/****** Object:  UserDefinedFunction [dbo].[[FN_RMR_CreateRuleOrderByExpression]]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_CreateRuleOrderByExpression]
(
    @ruleOrderBy as nvarchar(max)
)
returns nvarchar(max)
as
BEGIN
    --Verify if the field is allowed in orderby 
    declare @nonAllowedFields nvarchar(max)
    if isnull(RTRIM(LTRIM(@ruleOrderBy)),'')='' 
        set @ruleOrderBy='S.PER_LastName, S.PER_FirstName, S.PER_RowID desc' --set default order by
    select @nonAllowedFields = coalesce(@nonAllowedFields +',' + tok.val, tok.val) from dbo.[FN_RMR_ValidateAndGetTokensFromExpression](@ruleOrderBy) tok
        inner join [dbo].[RMR_FieldDef] FD on fd.FD_FieldComputedCode = tok.val and (fd.FD_IsActive=0 or fd.FD_IsOrderByAllowed=0 )
    If len(@nonAllowedFields)>0
        return '@@ERROR : ' + @nonAllowedFields + ' not allowed in order by clause'
    return isnull(dbo.[FN_RMR_CreateOperandExpression](@ruleOrderBy,'field','',0,0),'')
END
