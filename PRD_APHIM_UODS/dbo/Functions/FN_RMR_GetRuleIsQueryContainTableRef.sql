/****** Object:  UserDefinedFunction [dbo].[FN_RMR_GetRuleIsQueryReturnRows]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_GetRuleIsQueryContainTableRef]
(
    @tableAliasExpression as nvarchar(max),
    @tableAliasnames as nvarchar(max),
    @isMatchAll as bit=0
)
returns bit
as
BEGIN
    if @isMatchAll=1
    begin
        if exists(select * from string_split(@tableAliasnames,',') TMPSearch
                    except 
                 select * from string_split(@tableAliasExpression,',') TMPBase
                 )
                return 1
    end
    else
    begin 
        if exists(                   
                 select * from string_split(@tableAliasExpression,',') TMPBase
                 intersect
                 select * from string_split(@tableAliasnames,',') TMPSearch
                 )
                return 1
    end
    return 0
END
