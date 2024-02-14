
/****** Object:  UserDefinedFunction [dbo].[FN_RMR_CreateOperandExpression]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_CreateOperandExpression]
(
    @inputStr as nvarchar(max)
    , @dataType varchar(100) 
    , @operator varchar(100) 
    , @isJSONObject bit=0
    , @isValueAutoQuoted bit =0
)
returns nvarchar(max)
as
BEGIN
if @inputStr is null 
    return null

--declare @inputStr nvarchar(max) =''--'S.PR_CMRRECORDID'--'["S.PR_CMRRECORDID + 1","2.4",3]' --'[       "calc.dateadd(yyyy,1,''2020/03/30'')",      "2020/04/08"      ]' 

--declare @dataType varchar(100) = 'decimal'
--declare @operator varchar(100) = 'equal'
--declare @isJSONObject bit=0
declare @createIn bit =0
declare @isBetween bit =0

--declare @tv1 nvarchar(max)=''
--declare @tv2 nvarchar(max)=''
declare @tv3 table(seq tinyint , item nvarchar(max), IsContainFields bit)

declare @val nvarchar(max) =''

if  @operator in ('between','not_between') 
begin 
    if  @isJSONObject=1 
    BEGIN
        declare @val1 nvarchar(max)=json_value(@inputStr,'$[0]')
        declare @val2 nvarchar(max)=json_value(@inputStr,'$[1]')
        insert into @tv3
        values (1, dbo.[FN_RMR_PopulateOperandExpressionWithActualFields](@val1,@dataType),dbo.[FN_RMR_IsOperandContainFields](@val1))
        insert into @tv3
        values (2, dbo.[FN_RMR_PopulateOperandExpressionWithActualFields](@val2,@dataType),dbo.[FN_RMR_IsOperandContainFields](@val2))
        --set @tv1 =dbo.[FN_RMR_PopulateOperandExpressionWithActualFields](json_value(@inputStr,'$[0]'))
        --set @tv2 =dbo.[FN_RMR_PopulateOperandExpressionWithActualFields](json_value(@inputStr,'$[1]'))
        set @isBetween=1
    END
    --else
        --insert into @tv3
        --values (1, dbo.[FN_RMR_PopulateOperandExpressionWithActualFields](@inputStr),dbo.[FN_RMR_IsOperandContainFields](@inputStr))
        --set @tv1 =dbo.[FN_RMR_PopulateOperandExpressionWithActualFields](@inputStr)
    
end
else if  @operator in ('in','not_in') 
begin 
    if  @isJSONObject=1 
    BEGIN
        insert into @tv3
        select ROW_NUMBER() over(order by (select 1)) seq, dbo.[FN_RMR_PopulateOperandExpressionWithActualFields](valitem,@dataType) item, dbo.[FN_RMR_IsOperandContainFields](valitem) IsContainFields 
        from openjson(@inputStr)
        with(
        valItem  nvarchar(4000) '$' 
        ) tmp 
        
        set @createIn=1
    END
    --else
    --  insert into @tv3
    --  values (1, dbo.[FN_RMR_PopulateOperandExpressionWithActualFields](@inputStr),dbo.[FN_RMR_IsOperandContainFields](@inputStr))
        --set @tv1 =dbo.[FN_RMR_PopulateOperandExpressionWithActualFields](@inputStr)
    
end
if @isJSONObject=0
BEGIN
 
    insert into @tv3
        values (1, dbo.[FN_RMR_PopulateOperandExpressionWithActualFields](@inputStr,@dataType),dbo.[FN_RMR_IsOperandContainFields](@inputStr))
END

if @dataType = 'date' and @isValueAutoQuoted=1
begin
    --if isdate(@tv1)=1
    --  set @tv1='''' +@tv1 + ''''
    --if isdate(@tv2)=1
    --  set @tv2='''' +@tv2 + ''''
    update @tv3 set item= '''' +item + '''' where ISDATE(item)=1 and IsContainFields=0 and not (left(item,1)='''' and right(item,1)='''')
end
else if @dataType = 'string' and @isValueAutoQuoted=1
begin
    update @tv3 set item= '''' +item + '''' where  IsContainFields=0 and not (left(item,1)='''' and right(item,1)='''')
END

set @val=null
if @createIn = 1
begin   
        select @val= COALESCE(@val + ',' + item, item) 
        from @tv3
end 
else if @isBetween=1
Begin
    --set @val = @tv1 + ' AND ' + @tv2
    set @val = (select item from @tv3 where seq=1) + ' AND ' + (select item from @tv3 where seq=2)
END
else
BEGIN
    set @val=(select item from @tv3 where seq=1)
END
--select @val
return @val
--return (select  * from (values(@val,@tableAliasRef) ) FilterExpression(FilterOperand,TableAliasRef)
--for JSON PATH, WITHOUT_ARRAY_WRAPPER )
END
