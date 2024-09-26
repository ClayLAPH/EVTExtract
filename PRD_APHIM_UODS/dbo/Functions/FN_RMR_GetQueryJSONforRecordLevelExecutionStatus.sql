
CREATE     FUNCTION [dbo].[FN_RMR_GetQueryJSONforRecordLevelExecutionStatus]   
(  
    @recordType as varchar(10), @recordID int, @ruleRecordStatisticsRowID bigint
)  
RETURNS nvarchar(max)  
AS  
BEGIN  
  
    declare @ruleIdentifierRowID int= null 
    declare @isImportFailed bit =0
    declare @errorMessage nvarchar(max) 
    select top (1) @ruleIdentifierRowID=[RRS_RIRowID], @isImportFailed=[RRS_IsImportFailed], @errorMessage=isnull([RRS_ErrorMessage],'') from [dbo].[RMR_RuleRecordStatistics] (nolock)   
    where [RRS_RecordType]=@recordType and [RRS_RecordRowID]= @recordID and [RRS_RowID]= @ruleRecordStatisticsRowID  
    order by [RRS_RowID] desc  
    declare @jString nvarchar(max)= null  
  
    if @ruleIdentifierRowID>0  
    begin  
        set @jString=(  
        select convert(varchar(10),RuleRowID) as 'id', isnull(convert (varchar(10),ParentRuleRowID),'#') as 'parent'
        ,  @isImportFailed as 'IsImportFailed' ,  @errorMessage as 'errorMessage'
        , '' as 'text',RuleName as 'data.ruleName', RuleSelectMostRecent as 'data.selectMostRecent', RuleSkipIfMultipleMatch as 'data.skipIfMultipleMatch'
        ,( SELECT JSON_QUERY(RuleJSON,'$')) 'data.ruleJSON',RuleOrderBy 'data.ruleOrderBy'  
        , ImportOption as 'data.action.ImportOption', DemoImportOption as 'data.action.DemographicOption'  
        , DistrictDR 'data.routing.PR_DistrictDR',   InvestigatorDR     'data.routing.PR_InvestigatorDR'  
        ,AutoCloseIncident 'data.routing.AutoCloseIncident', ProcessStatusDR 'data.routing.PR_ProcessStatusDR',ResolutionStatusDR 'data.routing.PR_ResolutionStatusDR'  
        ,FinalDispositionDR 'data.routing.PR_FinalDispositionDR', ImportedStatusDR 'data.routing.PR_ImportedStatusDR'  , DiseaseDR 'data.routing.PR_DiseaseDR'
        , IsAsymptomatic 'data.routing.PR_IsAsymptomatic', IsPregnant 'data.routing.PR_IsPregnant'
        ,RuleExecuted 'data.ruleExecuted', RuleIsMatchFound 'data.ruleIsMatchFound', RuleImportActionApplied 'data.ruleImportActionApplied', RuleRoutingOptionsApplied 'data.ruleRoutingOptionsApplied'  
        from   
        (select top (9999) RD.[RD_RowID] RuleRowID,RH.[RH_ParentRDRowID] ParentRuleRowID, [RD_RuleName] RuleName, [RH_Sequence] RuleSequence 
            ,RD_SelectMostRecent RuleSelectMostRecent,RD_SkipIfMultipleMatch RuleSkipIfMultipleMatch,isnull( [RD_JSON],'') RuleJSON, isnull([RD_OrderBy],'') RuleOrderBy  
            ,[RD_Action_ImportOption] ImportOption,[RD_Action_DemoImportOption] DemoImportOption,[RD_Route_ProcessStatusDR] ProcessStatusDR  
            ,[RD_Route_ResolutionStatusDR] ResolutionStatusDR,[RD_Route_DistrictDR] DistrictDR,[RD_Route_InvestigatorDR] InvestigatorDR  
            ,[RD_Route_FinalDispositionDR] FinalDispositionDR,[RD_Route_ImportedStatusDR] ImportedStatusDR , [RD_Route_DiseaseDR] DiseaseDR
            ,[RD_Route_IsAsymptomatic] IsAsymptomatic, [RD_Route_IsPregnant] IsPregnant
            ,[RD_Route_AutoCloseIncident] AutoCloseIncident  
            ,cast(isnull(QRRS.[RRSD_RowID] ,0) as bit) RuleExecuted  
            ,cast(isnull(QRRS.[RRSD_IsMatchFound] ,0) as bit) RuleIsMatchFound  
            ,cast((case when isnull(QRRS.[RRSD_IsImportActionApplied] ,0)=0 then 0 else QRRS.[RRSD_IsImportActionApplied] + @isImportFailed end) as tinyint) RuleImportActionApplied  
            ,cast((case when isnull(QRRS.[RRSD_IsRoutingOptionsApplied] ,0)=0 then 0 else QRRS.[RRSD_IsRoutingOptionsApplied] + @isImportFailed end) as tinyint) RuleRoutingOptionsApplied    
            from [dbo].[RMR_RuleIdentifier] RI (nolock)  
            inner join [dbo].[RMR_RuleHierarchy] RH (nolock) on RI.[RI_RowID]=[RH_RIRowID]  
            inner join [dbo].[RMR_RuleDefinition] RD (nolock) on RH.[RH_RDRowID]=RD.[RD_RowID]  
            outer apply(  
            select top (1) [RRSD_RowID], [RRSD_IsMatchFound],[RRSD_IsImportActionApplied],[RRSD_IsRoutingOptionsApplied]  
            from [dbo].[RMR_RuleRecordStatisticsDetails] (nolock) where  RD.[RD_RowID] = RRSD_RDRowID and RRSD_RRSRowID=@ruleRecordStatisticsRowID   
            ) QRRS  
            where RI.[RI_RowID]=@ruleIdentifierRowID  
            order by RH.[RH_Sequence]  
        ) tmp  
        for json path,INCLUDE_NULL_VALUES   
        )  
    end  
    return @jString  
END  


