
CREATE    FUNCTION [dbo].[FN_RMR_CreateQueryByRuleID](
@ruleDefinitionID int
)
returns nvarchar(max)
Begin

--declare @ruleDefinitionID int =1
declare @tableAlias Table(AliasName nvarchar(100)) 

declare @isSelectMostRecent bit =0
declare @ruleOrderByExpression nvarchar(max) 
DECLARE @ruleOrderBy NVARCHAR(MAX)
DECLARE @isQueryReturnRows bit
select top(1) @isSelectMostRecent= RD_SelectMostRecent ,@ruleOrderBy=RD_OrderBy, @isQueryReturnRows= RD_IsQueryReturnRows
FROM [RMR_RuleDefinition] where RD_RowID=@ruleDefinitionID

IF @isQueryReturnRows=1
BEGIN
    SET @ruleOrderByExpression=dbo.[FN_RMR_CreateRuleOrderByExpression](@ruleOrderBy)
END 

insert into @tableAlias
select * from [dbo].[FN_RMR_GetRuleTableAliasRef] (@ruleDefinitionID) TableAliasRef
UNION
select * FROM [dbo].[FN_RMR_GetRuleOrderByTableAliasRef](@ruleOrderBy) WHERE @isQueryReturnRows=1
--select * from @tableAlias
if exists (select 1 from @tableAlias where AliasName in ('NOMATCH'))
begin 
    delete from @tableAlias where AliasName<>'NOMATCH'
end
else
BEGIN
    if not exists (select 1 from @tableAlias where AliasName in ('SPER'))
    begin 
        insert into @tableAlias 
        values('SPERNULL')
    end
    if not exists (select 1 from @tableAlias where AliasName in ('SPR'))
    begin 
        insert into @tableAlias 
        values('SPRNULL')
    end
    if not exists (select 1 from @tableAlias where AliasName in ('SLI'))
    begin 
        insert into @tableAlias 
        values('SLINULL')
    end
END

declare @selectExpression nvarchar(max) = ''
declare @fromExpression nvarchar(max) =null
declare @whereExpression nvarchar(max) =''
declare @orderbyExpression nvarchar (max)=''
declare @query nvarchar(max) = ''

set @selectExpression=', (SELECT max(PER_RootIDTemp) FROM (VALUES ({{PER_RootID}}),(T.PER_RootIDTemp)) AS TMPPERROOTID(PER_RootIDTemp)) AS PER_RootIDTemp
            ,(SELECT max(PR_RowIDTemp)  FROM (VALUES ({{PR_RowID}}),(T.PR_RowIDTemp)) AS TMPPERROOTID(PR_RowIDTemp)) AS PR_RowIDTemp
            ,{{DILR_RowID}} DILR_RowIDTemp'
--Select clause
if exists (select 1 from @tableAlias where AliasName in ('NOMATCH'))
Begin
    set @selectExpression=replace(@selectExpression , '{{PER_RootID}}', 'NOMATCH.PER_RootID')
    set @selectExpression=replace(@selectExpression , '{{PR_RowID}}', 'NOMATCH.PR_RowID')
    set @selectExpression=replace(@selectExpression , '{{DILR_RowID}}', 'cast (null as int)')
    --set @selectExpression= @selectExpression +', NOMATCH.PER_RootID, NOMATCH.PR_RowID'
END
if exists (select 1 from @tableAlias where AliasName in ('SPER'))
Begin
    set @selectExpression=replace(@selectExpression , '{{PER_RootID}}', 'SPER.PER_RootID')
    --set @selectExpression=@selectExpression +', SPER.PER_RootID'
END
else if exists (select 1 from @tableAlias where AliasName in ('SPERNULL'))
BEGIN
    set @selectExpression=replace(@selectExpression , '{{PER_RootID}}', 'cast (null as int) ')
    --set @selectExpression=@selectExpression +', cast (null as int) PER_RootID'
END

if exists (select 1 from @tableAlias where AliasName in ('SPR'))
BEGIN
    set @selectExpression=replace(@selectExpression , '{{PR_RowID}}', 'SPR.PR_RowID')
    --set @selectExpression=@selectExpression +', SPR.PR_RowID'
END
else if exists (select 1 from @tableAlias where AliasName in ('SPRNULL'))
BEGIN
    set @selectExpression=replace(@selectExpression , '{{PR_RowID}}', 'cast (null as int) ')
    --set @selectExpression=@selectExpression +', cast (null as int) PR_RowID'
END

if exists (select 1 from @tableAlias where AliasName in ('SLI'))
BEGIN
    set @selectExpression=replace(@selectExpression , '{{DILR_RowID}}', 'SLI.DILR_RowID')
    --set @selectExpression=@selectExpression +', SPR.PR_RowID'
END
else if exists (select 1 from @tableAlias where AliasName in ('SLINULL'))
BEGIN
    set @selectExpression=replace(@selectExpression , '{{DILR_RowID}}', 'cast (null as int) ')
    --set @selectExpression=@selectExpression +', cast (null as int) PR_RowID'
END

--Order by clause
set @orderbyExpression = ISNULL(@ruleOrderByExpression,'')

-- Join for TEMP Table which will be replaced dynamically in in [dbo].[USP_RMR_ExecuteRules]. Do not change the below if block.
set @fromExpression =  ' (select * from (values(cast(null as int),cast(null as int),cast(null as int))) tempData(PER_RootIDTemp,PR_RowIDTemp,DILR_RowIDTemp)) T '   

--Table Joins
if exists (select 1 from @tableAlias where AliasName in ('NOMATCH'))
    set @fromExpression = @fromExpression + ' inner join {{NOMATCH}} NOMATCH on 1=1 '
if exists (select 1 from @tableAlias where AliasName in ('SPER'))
    set @fromExpression = @fromExpression + ' inner join {{SPER}} SPER on 1=1 /*<c_per> and T.PER_RootIDTemp=SPER.PER_RootID </c_per>*/'
    
if exists (select 1 from @tableAlias where AliasName in ('SPERDEMO'))
    set @fromExpression = @fromExpression + ' left join {{SPERDEMO}} SPERDEMO on SPER.PER_RowID=SPERDEMO.PER_ParentRowID '
if exists (select 1 from @tableAlias where AliasName in ('SPERADDR'))
    set @fromExpression = @fromExpression + ' left join {{SPERADDR}} SPERADDR on SPER.PER_RowID=SPERADDR.PER_ParentRowID '
if exists (select 1 from @tableAlias where AliasName in ('SPERMRN'))
    set @fromExpression = @fromExpression + ' left join {{SPERMRN}} SPERMRN on SPER.PER_RootID=SPERMRN.PER_ParentRowID '
if exists (select 1 from @tableAlias where AliasName in ('SPERAI'))
    set @fromExpression = @fromExpression + ' left join {{SPERAI}} SPERAI on SPER.PER_RootID=SPERAI.AI_PERRowID '
if exists (select 1 from @tableAlias where AliasName in ('SPR'))
    set @fromExpression = @fromExpression + ' left join {{SPR}} SPR on SPER.PER_RowID = SPR.PR_PersonDR /*<c_pr> and T.PR_RowIDTemp=SPR.PR_RowID </c_pr>*/ '
if exists (select 1 from @tableAlias where AliasName in ('SPRSTR'))
    set @fromExpression = @fromExpression + ' left join {{SPRSTR}} SPRSTR on SPR.PR_RowID=SPRSTR.PR_RowID '
if exists (select 1 from @tableAlias where AliasName in ('SLI'))
    set @fromExpression = @fromExpression + ' left join {{SLI}} SLI on SPR.PR_RowID=SLI.DILR_PRRowID /*<c_dilr> and T.DILR_RowIDTemp=SLI.DILR_RowID </c_dilr>*/'
if exists (select 1 from @tableAlias where AliasName in ('SLISTR'))
    set @fromExpression = @fromExpression + ' left join {{SLISTR}} SLISTR on SLISTR.DILR_RowID=SLI.DILR_RowID  '
if exists (select 1 from @tableAlias where AliasName in ('SDS'))
    set @fromExpression = @fromExpression + ' left join {{SDS}} SDS on SDS.DSR_DILRRowID=SLI.DILR_RowID  '
-- Joins for incoming record
if exists (select 1 from @tableAlias where AliasName in ('IPER'))
    set @fromExpression = @fromExpression + ' inner join {{IPER}} IPER on 1=1 '
if exists (select 1 from @tableAlias where AliasName in ('IPERAI'))
    set @fromExpression = @fromExpression + ' left join {{IPERAI}} IPERAI on IPER.PER_RootID=IPERAI.AI_PERRowID '
if exists (select 1 from @tableAlias where AliasName in ('IPR'))
    set @fromExpression = @fromExpression + ' left join {{IPR}} IPR on IPER.PER_RowID = IPR.PR_PersonDR '
if exists (select 1 from @tableAlias where AliasName in ('ILI'))
    set @fromExpression = @fromExpression + ' left join {{ILI}} ILI on IPR.PR_RowID=ILI.DILR_PRRowID '
if exists (select 1 from @tableAlias where AliasName in ('IDS'))
    set @fromExpression = @fromExpression + ' left join {{IDS}} IDS on IDS.DSR_DILRRowID=ILI.DILR_RowID '
-- Joins for DUMMY Table
if exists (select 1 from @tableAlias where AliasName in ('DUMMY'))
    set @fromExpression = @fromExpression + ' inner join {{DUMMY}} DUMMY on 1=1 '


set @whereExpression = (select dbo.[FN_RMR_CreateFilterExpressionForRule](@ruleDefinitionID))

---Add top clause
declare @topExpr as nvarchar(100)
set @topExpr = ' TOP (9223372036854775807) '
--set @topExpr = ' TOP (100) PERCENT '
if LEN(RTRIM(LTRIM(@selectExpression)))>0
BEGIN
    if @isSelectMostRecent=1
        set @topExpr=' TOP (1) '
        --set @selectExpression='TOP(1) ' + @selectExpression
    set @selectExpression='Select ' + @topExpr + ' /*<f_rdrowid>,*/ row_number() over(order by (select null)) RowNo ' + @selectExpression    
END
---------------
if LEN(RTRIM(LTRIM(@fromExpression)))>0
    set @fromExpression=' FROM ' + @fromExpression 

set @whereExpression = (case when LEN(RTRIM(LTRIM(@whereExpression)))>0 then ' and ' + @whereExpression else '' end)
if exists (select 1 from @tableAlias where AliasName in ('SLI'))
begin
    set @whereExpression = ' /*<c_dilr> and SLI.DILR_RowID is not null </c_dilr>*/ ' + @whereExpression 
end
set @whereExpression =' where 1=1 /*<c_pr> and SPR.PR_RowID is not null </c_pr>*/  ' + @whereExpression 

if len(RTRIM(LTRIM(@orderbyExpression)))>0
    set @orderbyExpression=' ORDER BY ' + RTRIM(LTRIM(@orderbyExpression))
set @query=  @selectExpression + @fromExpression + @whereExpression + @orderbyExpression
if len(RTRIM(LTRIM(@query)))>0
Begin
    select @query = replace(@query , '{{'+ TD.FTD_TableAlias +'}}', TD.FTD_TableExpression ) 
    from [dbo].[RMR_FieldTableDef] TD (nolock)
End
return @query
--Select @query
end

