
CREATE   FUNCTION [dbo].[FN_RMR_GetRuleOrderByTableAliasRef]
(
    @ruleOrderBy as nvarchar(max)
)
returns @tableAlias table(AliasName varchar(100))
as
BEGIN
    --Verify if the field is allowed in order by 
    declare @nonAllowedFields nvarchar(max)
    if isnull(RTRIM(LTRIM(@ruleOrderBy)),'')='' 
        set @ruleOrderBy='S.PER_LastName, S.PER_FirstName, S.PER_RowID desc' --set default order by
    ;with cteTableAlias(TableAlias)
    as
    (            
            SELECT cast([value] as varchar(100)) as TableAliasTemp from string_split(dbo.[FN_RMR_GetTableAliasRefForOperandFields](@ruleOrderBy),',') tmp1 where isnull([value],'')<>''
            union all
            select cast(TableAliasTemp as varchar(100)) AliasName from [dbo].[RMR_FieldTableDef](NOLOCK) t
            inner join cteTableAlias cte on cte.TableAlias=t.FTD_TableAlias
            cross apply(
                select [value] as TableAliasTemp from string_split(t.FTD_DependentTableAlias,',') t where isnull([value],'')<>'' 
            ) tmp1              
    )
    insert into @tableAlias
    select distinct TableAlias from cteTableAlias
    RETURN 
END
