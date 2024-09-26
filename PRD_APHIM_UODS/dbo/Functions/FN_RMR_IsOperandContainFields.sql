/****** Object:  UserDefinedFunction [dbo].[FN_RMR_IsOperandContainFields]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_IsOperandContainFields]
(
    @strExpr as nvarchar(max)
)
RETURNS bit
AS
BEGIN
    if exists(select 1 from dbo.[FN_RMR_ValidateAndGetTokensFromExpression](@strExpr) tok
        inner join [dbo].[RMR_FieldDef] FD on fd.FD_FieldComputedCode = tok.val and fd.FD_IsActive=1)
    begin 
        return 1
    end
    
    return 0
END
