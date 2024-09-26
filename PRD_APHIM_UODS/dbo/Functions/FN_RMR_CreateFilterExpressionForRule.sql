/*-------------------------------------------------------------------------------------*/

/****** Object:  UserDefinedFunction [dbo].[FN_RMR_CreateFilterExpressionForRule]  *******************/

CREATE     FUNCTION [dbo].[FN_RMR_CreateFilterExpressionForRule]
(
    @ruleRowID int
)
RETURNS nvarchar(max)
AS
BEGIN
    declare @rootGroupRowID as int
    select top (1) @rootGroupRowID = RF_RowID 
    from [RMR_RuleDefinition] (nolock) 
    inner join [RMR_RuleFilter] (nolock) on RF_RuleRowID=RD_RowID
    where RF_ParentRowID is null and RD_RowID=@ruleRowID
  return dbo.[FN_RMR_CombineFilterExpressionForGroup](@rootGroupRowID) 
END
