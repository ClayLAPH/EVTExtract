

/*---------------------------------------------------------------------*/
/****** Object:  UserDefinedFunction [dbo].[FN_RMR_GetRuleDefinitionTableFromRulesJSON]     ******/
CREATE    FUNCTION [dbo].[FN_RMR_GetRuleDefinitionTableFromRulesJSON]
(
    @ruleIdentifierID int, @queryJSON nvarchar(max)
)
RETURNS 
@rulesTable TABLE
(
    RuleIdentifierRowID int,
    RuleRowID int not null,
    ParentRuleRowID int,
    RuleSequence int not null,
    RuleName nvarchar(1000), 
    RuleSelectMostRecent bit,
    RuleSkipIfMultipleMatch bit,
    RuleJSON nvarchar(max),
    RuleOrderBy nvarchar(max),
    RuleAction nvarchar(max),
    RuleRouting nvarchar(max)

)
AS
BEGIN
    -- Fill the table variable with the rows for your result set
    insert into @rulesTable (RuleIdentifierRowID,RuleRowID,ParentRuleRowID,RuleSequence,RuleName, RuleSelectMostRecent,RuleSkipIfMultipleMatch,RuleJSON,RuleOrderBy,RuleAction,RuleRouting)
    select @ruleIdentifierID,convert(int,RuleRowID),convert(int,(case when ParentRuleRowID = '#' then null else ParentRuleRowID end)),ROW_NUMBER() over (order by (select 1)) ,RuleName, ISNULL(RuleSelectMostRecent,0) RuleSelectMostRecent,ISNULL(RuleSkipIfMultipleMatch,0) RuleSkipIfMultipleMatch, RuleJSON,RuleOrderBy,RuleAction,RuleRouting  
    from OPENJSON(@queryJSON)
    WITH (   
                  RuleRowID   varchar(200)   '$.id',  
                  ParentRuleRowID varchar(200) '$.parent',              
                  [data]  nvarchar(MAX) '$.data'  AS JSON  
     ) L0
     cross apply openjson(L0.[data]) 
     WITH(
            RuleName nvarchar(1000) '$.ruleName',
            RuleSelectMostRecent  bit '$.selectMostRecent',
            RuleSkipIfMultipleMatch bit '$.skipIfMultipleMatch',
            RuleJSON nvarchar(max) '$.ruleJSON' as JSON,
            RuleOrderBy nvarchar(max) '$.ruleOrderBy',
            RuleAction  nvarchar(max) '$.action' as JSON,
            RuleRouting nvarchar(max) '$.routing' as JSON
     ) L1

    RETURN 
END
