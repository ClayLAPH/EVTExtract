
/****** Object:  UserDefinedFunction [dbo].[FN_RMR_CreateOperandTableAliasRefExpression]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_CreateOperandTableAliasRefExpression]
(
    @inputStr as nvarchar(max)
    , @operator varchar(100) 
    , @isJSONObject bit=0
)
returns nvarchar(max)
as
BEGIN
if @inputStr is null 
    return null

declare @createIn bit =0
declare @isBetween bit =0

--declare @tv1 nvarchar(max)=''
--declare @tv2 nvarchar(max)=''
declare @tv3 table(seq tinyint , tableAliasRef  nvarchar(max))

declare @tableAliasRef nvarchar(max)=''
if  @operator in ('between','not between') 
begin 
    if  @isJSONObject=1 
    BEGIN
        declare @val1 nvarchar(max)=json_value(@inputStr,'$[0]')
        declare @val2 nvarchar(max)=json_value(@inputStr,'$[1]')
        insert into @tv3
        values (1,  dbo.[FN_RMR_GetTableAliasRefForOperandFields](@val1))
        insert into @tv3
        values (2,  dbo.[FN_RMR_GetTableAliasRefForOperandFields](@val1))
        set @isBetween=1
    END
    
end
else if  @operator in ('in','not in') 
begin 
    if  @isJSONObject=1 
    BEGIN
        insert into @tv3
        select ROW_NUMBER() over(order by (select 1)) seq , dbo.[FN_RMR_GetTableAliasRefForOperandFields](valitem) as tableref
        from openjson(@inputStr)
        with(
        valItem  nvarchar(4000) '$' 
        ) tmp 
        
        set @createIn=1
    END
    
end
if @isJSONObject=0
BEGIN
 
    insert into @tv3
        values (1, dbo.[FN_RMR_GetTableAliasRefForOperandFields](@inputStr))
END

set @tableAliasRef=null
if @createIn = 1
begin           
        select @tableAliasRef= COALESCE(@tableAliasRef + ',' + tableAliasRef, tableAliasRef) 
        from @tv3
end 
else if @isBetween=1
Begin
    select distinct @tableAliasRef= COALESCE(@tableAliasRef + ',' + tableAliasRef, tableAliasRef) 
    from @tv3 where seq in (1,2)
END
else
BEGIN
    set @tableAliasRef=(select tableAliasRef from @tv3 where seq=1)
END
--select @tableAliasRef
return @tableAliasRef
END
