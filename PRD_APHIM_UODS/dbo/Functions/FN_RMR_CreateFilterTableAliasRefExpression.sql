
/****** Object:  UserDefinedFunction [dbo].[FN_RMR_CreateFilterTableAliasRefExpression]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_CreateFilterTableAliasRefExpression]
(
    @ruleFilterRowID as int
)
returns nvarchar(max)
as
BEGIN
declare @filterExpression as nvarchar(max)
set @filterExpression=( 
    select isnull( LefTableAliasref,'') + ',' + isnull( RightTableAliasRef,'') + ',' + isnull(OPTableRefAliasRef,'') EXPR
    from 
    (
        select 
        case when RF_IsGroupType =0 then  dbo.[FN_RMR_CreateOperandTableAliasRefExpression](RF_LeftField,'',0) else null end LefTableAliasref 
        ,case when RF_IsGroupType =0 and RF_RightFieldValue is null  then  dbo.[FN_RMR_CreateOperandTableAliasRefExpression](RF_RightFieldObject,RF_Operator,1) 
        when RF_IsGroupType =0 and RF_RightFieldValue is not null then dbo.[FN_RMR_CreateOperandTableAliasRefExpression](RF_RightFieldValue,RF_Operator,0)
        else null end RightTableAliasRef,
		CO.CO_DBTableRefAlias OPTableRefAliasRef
        from [RMR_RuleFilter] RF (nolock) 
		left join [RMR_ComparisonOperator] CO (nolock) on CO.CO_Name=RF.RF_Operator
        where RF_IsGroupType =0 and RF.RF_RowID=@ruleFilterRowID
    ) TMP
)
declare @finalExpr nvarchar(max)
select @finalExpr =   COALESCE(@finalExpr + ',' + [value], [value]) 
    from (select distinct [value] from string_split (@filterExpression,',') t where isnull([value],'')<>'') tmp
return @finalExpr
end
