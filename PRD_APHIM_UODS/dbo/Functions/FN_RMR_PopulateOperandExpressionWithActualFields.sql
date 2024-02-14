
/****** Object:  UserDefinedFunction [dbo].[FN_RMR_PopulateOperandExpressionWithActualFields]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_PopulateOperandExpressionWithActualFields]
(
    @strExpr as nvarchar(max),
	@datatype as varchar(100)
)
RETURNS nvarchar(max)
AS
BEGIN
	set @datatype = isnull(@datatype,'')

	declare @allowedNumericDataType as nvarchar(max) = 'int,bigint,smallint,tinyint,money,smallmoney,decimal,numeric,float,real,bit,boolean'
	declare @allowedBitDataType as nvarchar(max) = 'bit,boolean'
	declare @allowedDataTimeDataType nvarchar(max) = 'date,datetime,datetime2,datetimeoffset,smalldatetime,time'
	declare @allowedStringDataType nvarchar(max) = 'string'
	declare @allowedCustomDataType nvarchar(max) = 'field'

	declare @dataTypes table (typeGroup tinyint, datatype nvarchar(100))
	declare @tokens table (token nvarchar(500))
	 -- Insert Tokens
	insert into @tokens
	values('year'), ('yyyy'), ('yy')
			,('quarter'), ('qq'), ('q')
			,('month'), ('mm'), ('m')
			,('dayofyear'), ('dy'), ('y')
			,('day'), ('dd'), ('d')
			,('week'), ('ww'), ('wk') 
			,('weekday'), ('dw'), ('w') 
			,('hour'), ('hh') 
			,('minute'), ('mi'), ('n') 
			,('second'), ('ss'), ('s')
			,('millisecond'), ('ms') 
			,('asc'), ('desc')


	--Insert data types
	insert into @dataTypes
	select * from (
	select  1 typeGroup, [value] datatype from string_split(@allowedNumericDataType ,',')
	union all
	select  2 typeGroup, [value] datatype from string_split(@allowedBitDataType ,',')
	union all
	select  3 typeGroup, [value] datatype from string_split(@allowedDataTimeDataType ,',')
	union all
	select  4 typeGroup, [value] datatype from string_split(@allowedStringDataType ,',')
	union all
	select  5 typeGroup, [value] datatype from string_split(@allowedCustomDataType ,',')
	) TMP
	declare @allowedDataType as nvarchar(max) = @allowedNumericDataType + ',' + @allowedBitDataType + ',' + @allowedStringDataType + ',' + @allowedDataTimeDataType

	declare @finalExpr Nvarchar(max)=''
	if @datatype=''
	Begin
		set @finalExpr='@@ERROR : DataType can not be blank '
	End
	Else if  @datatype not in (select datatype from @dataTypes)
	begin 
		set @finalExpr='@@ERROR : Invalid data type ' + @datatype + ' '
	End

	--Validate numeric and date type data
	if  (@datatype in (select datatype from @dataTypes where typegroup=1 or typegroup=2) and ISNUMERIC(@strExpr) = 1 ) 
	BEGIN
		set @finalExpr= @strExpr
	END
	else if  (@datatype in (select datatype from @dataTypes where typegroup=3) )
	BEGIN
		if ISDATE(case when left(@strExpr,1)='''' and right(@strExpr,1)='''' then SUBSTRING(@strExpr,2,len(@strExpr)-2)  end)=1 
			set @finalExpr= @strExpr
		else if ISDATE(@strExpr) =1
			set @finalExpr='@@ERROR : Date Value without quote : ' + @strExpr + ' '
	END

	-- Validate expression for white listing
	if LEN(@finalExpr)=0
	begin 		
		select @finalExpr =   COALESCE(@finalExpr + '' + val, val) 
		from (
			select 
			--tok.tokType,tok.val,
			(case when fd.FD_DBExpression is not null then fd.FD_DBExpression
				when tok.tokType = 0 then tok.val
				when tok.tokType = 1 then 
					case when ISNUMERIC(tok.val) = 1 or tok.val in (select token from @tokens) then tok.val
					else '@@ERROR : '+ tok.val + ' is invalid' END
				when tok.tokType = 2 then   tok.val  
				else '@@ERROR : '+ tok.val + ' is invalid' 
				end) as val        
			from dbo.[FN_RMR_ValidateAndGetTokensFromExpression](@strExpr) tok
			left join [dbo].[RMR_FieldDef] FD on fd.FD_FieldComputedCode = tok.val and fd.FD_IsActive=1
		) tmp
	end
	--select @finalExpr
    return @finalExpr
END
