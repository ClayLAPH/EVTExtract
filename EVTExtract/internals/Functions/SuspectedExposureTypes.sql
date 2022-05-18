create function internals.SuspectedExposureTypes(@pr_RowId int) returns table as return
(
  select 
    list = [$(PRD_APHIM_UODS)].dbo.STRCONCAT(UCS.fullname)
  from     
    [$(PRD_APHIM_UODS)].dbo.A_Act                   ActDocBody with (nolock) 
    inner join
    [$(PRD_APHIM_UODS)].dbo.A_Act                   ActTopic with (nolock) 
    on 
      ActTopic.Act_Parent_ID = ActDocBody.ID and
      ActTopic.classCode = 'TOPIC' 
    inner join
    [$(PRD_APHIM_UODS)].dbo.A_Act                   ActOBS with (nolock) 
    on 
      ActOBS.Act_Parent_ID = ActTopic.ID and
      ActOBS.classCode = 'OBS' and
      ActOBS.metaCode = 'DIET_ROWID' and
      ActOBS.statusCode = 'active'
    inner join
    [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet        UCS with (nolock) 
    on 
      ActOBS.code_ID = UCS.ID 
  where     
    ActDocBody.Act_Parent_ID = @pr_RowId and
    ActDocBody.classCode = 'DOCBODY'  
)