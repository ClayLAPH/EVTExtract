/*----------------------------------------------------------------------*/


/*--------------------------------------------------------------------------*/
/****** Object:  UserDefinedFunction [dbo].[FN_RMR_ValidateAndGetTokensFromExpression]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_ValidateAndGetTokensFromExpression]
(   
    @strEXPR nvarchar(max) 
)
RETURNS @tokenTable
Table(seq int ,val nvarchar(max),tokType smallint)
as
BEGIN

declare @strLen int  = len(@strEXPR)
declare @start int =1
declare @isString bit=0
declare @quteCounter int =0
declare @tok Table(seq int identity,val nvarchar(max), tokType smallint,isValidateToken as (case when val=' ' and datalength(val)>0 then 0 else 1 end),seqCalc int default -1 )--seqCalc is used to skip spaces during token validation
declare @tokSpliter Table(val nvarchar(4000))
---------------------------------------------------------
insert into @tokSpliter 
select * from (values('('),(')'),(' '),('+'),('-'),('*'),('/'),(''''),(','),('=') ) t(col1)
-------------------------------------------------------------------
declare @word nvarchar(max) =''
------------------------------------------------
while @start <=@strLen
begin 
    declare @c nvarchar(1)

    select @c=SUBSTRING(@strEXPR,@start,1)
    if @c in (select val from @tokSpliter )--('(',')',' ','+','-','*','/','''',',') 
    begin
        if RTRIM(LTRIM(@word))<>'' 
            insert into @tok(val,tokType) values(@word,1)
        set @word=''
        
        if @c=''''
        Begin
            set @start=@start+1
            set @word=''''
            set @isString=1
            set @quteCounter=0
            while @start <=@strLen and @isString=1
            begin 
                select @c=SUBSTRING(@strEXPR,@start,1)
                set @word=@word+@c
                
                if @c='''' 
                Begin 
                    set @quteCounter=@quteCounter+1
                    if SUBSTRING(@strEXPR,@start+1,1) <>'''' and ( @quteCounter% 2 )=1
                        set @isString=0
                END 
                if @isString =1
                    set @start=@start+1
            END
            insert into @tok(val,tokType) values(@word,2)
            set @c=''
            set @word=''
        End
        --if trim(@c)<>'' 
        if datalength(@c)>0
            insert into @tok(val,tokType) values(@c,0)
        
    end
    else
        set @word=@word+ @c

    set @start=@start+1
end
if RTRIM(LTRIM(@word))<>''
    insert into @tok(val,tokType) values(@word,1)

-------------------------------------------------------------------
--Update the sequence for validating tokens by eliminating space token
update @tok set seqCalc=x.seqCalcTmp
from (select
row_number() over (order by seq) seqCalcTmp, seq seqTmp
from @tok a where IsValidateToken>0 
) x where x.seqTmp=seq

if exists (Select 1 from @tok a
inner join @tok b on a.IsValidateToken>0  and b.IsValidateToken>0 --Used to skip space character during validation
and a.seqCalc+1=b.seqCalc and a.tokType<>0 and b.tokType<>0 
and (b.val not in ('asc','desc') or a.val in ('asc','desc') )) --Allow asc and desc in expression validation
begin 
    
        insert into @tokenTable
        values (1,char(5)+ char(5) + '@@ERROR : Error validating tokrns',-1)
        return
END 
if exists (Select 1 from @tok a where a.tokType=1  and a.val in ('insert','update','delete'))
begin 
    
        insert into @tokenTable
        values (1,'@@ERROR : Error validating tokrns, DML expressions are not allowed',-1)
        return
END 

insert into @tokenTable
select seq,val,tokType from @tok 
Return

END
