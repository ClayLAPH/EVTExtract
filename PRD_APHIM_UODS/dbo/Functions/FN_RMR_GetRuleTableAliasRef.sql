
CREATE   FUNCTION [dbo].[FN_RMR_GetRuleTableAliasRef](
@ruleDefinitionID int
)
returns @tableAlias table(AliasName varchar(100))
Begin
    ;with cteTableAlias( TableAlias)
    as
    (
            select distinct cast(TableAliasTemp as varchar(100)) AliasName from 
            (
                select distinct RF_FilterTableAliasRefExpression tableref from [RMR_RuleFilter] (NOLOCK) where RF_RuleRowID=@ruleDefinitionID
            ) tmp
            cross apply(
             select [value] as TableAliasTemp from string_split(tmp.tableref,',') t where isnull([value],'')<>''
            ) tmp1
            union all
            select cast(TableAliasTemp as varchar(100)) AliasName from [dbo].[RMR_FieldTableDef] t
            inner join cteTableAlias cte on cte.TableAlias=t.FTD_TableAlias
            cross apply(
                select [value] as TableAliasTemp from string_split(t.FTD_DependentTableAlias,',') t where isnull([value],'')<>'' 
            ) tmp1              
    )

    insert into @tableAlias
    select distinct TableAlias from cteTableAlias
return
End
