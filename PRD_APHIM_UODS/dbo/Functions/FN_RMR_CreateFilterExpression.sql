/****** Object:  UserDefinedFunction [dbo].[FN_RMR_CreateFilterExpression]     ******/
CREATE   FUNCTION [dbo].[FN_RMR_CreateFilterExpression]
(
    @ruleFilterRowID as int
)
returns nvarchar(max)
as
BEGIN
declare @filterExpression as nvarchar(max)
set @filterExpression=(
    select '(' + REPLACE(REplace(FilterExpr,'{{LEXP}}', LeftOP),'{{REXP}}',RightOP) + ')' FilterExpression
    from 
    (
        select 
        FD.FD_rowid,
        case when FD.FD_RowID is null then '@@ERROR : Left Operand is invalid or not active'
            when QC.CO_Expression is null then '@@ERROR : Operator is invalid or not active'
            when FORel.[FOR_CORowID] is null then '@@ERROR : Operator not allowed for the field'
            else QC.CO_Expression end 
        FilterExpr, 
        case when RF_IsGroupType =0 then  dbo.[FN_RMR_CreateOperandExpression](RF_LeftField,'field','',0,0) else null end LeftOP 
        , RF_Operator, 
        ISNULL(case when RF_IsGroupType =0 and RF_RightFieldValue is null  then  dbo.[FN_RMR_CreateOperandExpression](RF_RightFieldObject,RF_DataType,RF_Operator,1,isnull(QC.[CO_IsValueAutoQuoted],0)) 
        when RF_IsGroupType =0 and RF_RightFieldValue is not null then dbo.[FN_RMR_CreateOperandExpression](RF_RightFieldValue,RF_DataType,RF_Operator,0,isnull(QC.[CO_IsValueAutoQuoted],0))
        else null end,'') RightOP 
        --, QC.*, RF.*

        from [RMR_RuleFilter] RF
        left join [dbo].[RMR_ComparisonOperator] QC on RF.RF_Operator=QC.[CO_Name]
        left join [dbo].[RMR_FieldDef] FD on FD.FD_FieldComputedCode = RF.RF_LeftField 
        left join [dbo].[RMR_FieldOperatorRelation] FORel on  FORel.[FOR_FDRowID] = FD.[FD_RowID] and FORel.[FOR_CORowID]=QC.[CO_RowID] and FORel.[FOR_IsActive]=1
        where RF_IsGroupType =0 and RF.RF_RowID=@ruleFilterRowID
    ) TMP
)
return @filterExpression
end
