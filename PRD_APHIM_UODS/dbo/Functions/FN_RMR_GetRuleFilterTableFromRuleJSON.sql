
/****** Object:  UserDefinedFunction [dbo].[FN_RMR_GetRuleFilterTableFromRuleJSON]     ******/
CREATE     FUNCTION [dbo].[FN_RMR_GetRuleFilterTableFromRuleJSON]
(
    @ruleRowID int, @queryJSON nvarchar(max)
)
RETURNS 
@RuleFilterTable TABLE
(
    [RF_RowID] [int] IDENTITY(1,-1) NOT NULL,
    [RF_ParentRowID] [int] NULL,
    [RF_Sequence] [int] NOT NULL,
    [RF_RuleRowID] [int] NOT NULL,
    [RF_GroupCondition] [nvarchar](100) NULL,
    [RF_GroupIsNot] [bit] NULL,
    [RF_IsGroupType] [bit] NOT NULL default 0,
    [RF_LeftField] [nvarchar](500) NOT NULL,
    [RF_Operator] [nvarchar](50) NOT NULL,
    [RF_RightFieldValue] [nvarchar](4000) NULL,
    [RF_RightFieldObject] [nvarchar](max) NULL,
    [RF_DataType] [varchar](10) NULL,
    [RF_IsCached] [bit] NOT NULL default 0
)
AS
BEGIN
    declare @tmpDataSeq as table (
            id int identity,
            parentRuleRowID int null,
            strJson nvarchar(max),
            jType int
    )

--------------------------------------------
    --Jason type  string 1, number 2, boolean 3, array 4, or object 5
    insert into @tmpDataSeq(parentRuleRowID ,   strJson,    jType)
    values(null,@queryJSON,5)

    declare @counter int
    declare @found bit


    declare @ruleSequance int
    declare @parentRuleRowID int
    declare @strJson nvarchar(max)
    declare @jType int

    set @counter=1
    set @found=1
    set @ruleSequance=1

    while @found=1
    begin
        if exists (select 1 from @tmpDataSeq where id=@counter) 
        BEGIN
            set @parentRuleRowID=null
            set @jType=5
            set @strJson=null
            select  @parentRuleRowID=parentRuleRowID,@jType=jType, @strJson=strJson from @tmpDataSeq where id=@counter          
            --select * from openjson(@strJson)
            if @jType=5 
            begin 
                if exists(select 1 from  openjson(@strJson) where [key]='condition' and [type]=1)
                begin -- Add rule group
                    INSERT INTO @RuleFilterTable 
                    ([RF_ParentRowID],[RF_Sequence],[RF_RuleRowID],[RF_GroupCondition],[RF_GroupIsNot],[RF_IsGroupType],[RF_LeftField],[RF_Operator],[RF_RightFieldValue],[RF_RightFieldObject],[RF_DataType])  
                    select @parentRuleRowID,@ruleSequance,@ruleRowID,GroupCondition,isnull(GroupIsNot,0),1,'','','','','' from openjson(@strJson)
                    with(
                        GroupCondition varchar(200) '$.condition',
                        GroupIsNot bit '$.not',
                        jString nvarchar(max) '$.rules' as JSON 
                    ) L0 

                    insert into @tmpDataSeq(parentRuleRowID ,   strJson,    jType)
                    select SCOPE_IDENTITY(), jString,4 from openjson(@strJson)
                    with(
                        GroupCondition varchar(200) '$.condition',
                        GroupIsNot bit '$.not',
                        jString nvarchar(max) '$.rules' as JSON
                    ) L0
                end
                else 
                BEGIN --Add rule
                    INSERT INTO @RuleFilterTable 
                    ([RF_ParentRowID],[RF_Sequence],[RF_RuleRowID],[RF_GroupCondition],[RF_GroupIsNot],[RF_IsGroupType],[RF_LeftField],[RF_Operator],[RF_RightFieldValue],[RF_RightFieldObject],[RF_DataType])  
                    select @parentRuleRowID,@ruleSequance,@ruleRowID,'',0,0,LeftField,operator,RightFieldValue,json_query(RightFieldRaw,'$') RightFieldObject,FD.FD_DataType from openjson(@strJson)
                    with(
                        LeftField nvarchar(400) '$.id',
                        operator nvarchar(100) '$.operator',                    
                        RightFieldValue nvarchar(4000) '$.value',
                        RightFieldRaw nvarchar(max) '$.value' as json
                        --,DataType nvarchar(200) '$.type'
                    ) L0 
                    left join RMR_FieldDef FD (nolock) on FD.FD_FieldComputedCode = L0.LeftField
                    
                END
                set @ruleSequance=@ruleSequance+1
            END
            else if @jType=4 
            begin
                insert into @tmpDataSeq(parentRuleRowID ,   strJson,    jType)
                select @parentRuleRowID, [value],[type] from openjson(@strJson) L0              
            end             
        END
        ELSE
        BEGIN
            set @found=0
        END
        set @counter=@counter+1 
    end
    RETURN
END
