
/****** Object:  UserDefinedFunction [dbo].[FN_RMR_GetTableAliasRefForOperandFields]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_GetTableAliasRefForOperandFields]
(
    @strExpr as nvarchar(max)
)
RETURNS nvarchar(max)
AS
BEGIN
    declare @finalExpr Nvarchar(max)
    select @finalExpr =   COALESCE(@finalExpr + ',' + [value], [value]) 
    from (
        select distinct tmp1.[value] from (
        select distinct fd.FD_DBTableRefAlias val from dbo.[FN_RMR_ValidateAndGetTokensFromExpression](@strEXPR) x
        inner join [dbo].[RMR_FieldDef] FD on fd.FD_FieldComputedCode = x.val and fd.FD_IsActive=1 where toktype=1 and FD_DBTableRefAlias is not null) tmp
        cross apply(
            select [value] from string_split(tmp.val,',') t where isnull([value],'')<>''
        ) tmp1
    ) tmp
    return @finalExpr
END
