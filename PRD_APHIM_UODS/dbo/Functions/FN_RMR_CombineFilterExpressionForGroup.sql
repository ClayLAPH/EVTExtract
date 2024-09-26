

/****** Object:  UserDefinedFunction [dbo].[FN_RMR_CombineFilterExpressionForGroup]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_CombineFilterExpressionForGroup]
(
    @groupRowID int
)
RETURNS nvarchar(max)
AS
BEGIN
    declare @expr as nvarchar(max)
    declare @groupCondition as varchar(100)
    declare @groupIsNot as bit
    select @groupCondition=RF_GroupCondition, @groupIsNot=RF_GroupIsNot from [RMR_RuleFilter] (nolock) where RF_RowID=@groupRowID

    select  @expr =   COALESCE(@expr + ' ' + @groupCondition + ' ' + EXPR, EXPR) 
    from
    (
    select case when RF_IsGroupType=1 then  dbo.[FN_RMR_CombineFilterExpressionForGroup](RF_RowID) else RF_FilterExpression end  EXPR
    , RF_Sequence
    from [RMR_RuleFilter] RF (nolock) where RF_ParentRowID=@groupRowID
    ) TMP
    order by RF_Sequence
    set @expr='(' + @expr + ')'
    if @groupIsNot =1
        set @expr=' NOT ' + @expr 
    return @expr
END
