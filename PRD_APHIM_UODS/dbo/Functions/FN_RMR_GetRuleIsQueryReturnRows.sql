/****** Object:  UserDefinedFunction [dbo].[FN_RMR_GetRuleIsQueryReturnRows]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_GetRuleIsQueryReturnRows]
(
    @ruleDefinitionID as int
)
returns bit
as
BEGIN
    if exists( select top(1) 1 
    from [dbo].[FN_RMR_GetRuleTableAliasRef] (@ruleDefinitionID) TableAliasRef
    inner join RMR_FieldTableDef FTD on ftd.FTD_TableAlias=TableAliasRef.AliasName and ftd.FTD_IsReturnRows=1)
    Begin
        return 1
    End
    return 0
END
