create function internals.IncidentSpecimensAggregated
(
  @pr_rowId int
)
returns table as return
(
  select 
    dvis.DVIS_IncidentDR,  
    [$(PRD_APHIM_UODS)].[dbo].STRCONCAT(DVIS_CollectionDate) AS DVIS_COLLECTIONDATES,   
	  [$(PRD_APHIM_UODS)].[dbo].STRCONCAT(DVIS_RECEIVEDDATE) AS DVIS_RECEIVEDDATES,   
	  [$(PRD_APHIM_UODS)].[dbo].STRCONCAT(ISNULL(UCS1.FULLNAME,'')) AS DVIS_SPECIMENTYPES,   
	  [$(PRD_APHIM_UODS)].[dbo].STRCONCAT(DVIS_SPECIMENRESULTS) AS DVIS_SPECIMENRESULTS
  from
    [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr with (nolock)
    inner join
    [$(PRD_APHIM_UODS)].dbo.DV_IncidentSpecimen dvis with (nolock)
    on
      pr.DVPR_RowID = dvis.DVIS_IncidentDR
    left outer join
    [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet ucs1 with (nolock)
    ON  UCS1.ID = DVIS_SPECIMENTYPECODE_ID
  where
    pr.DVPR_RowID = @pr_rowId
  group by
    dvis.DVIS_IncidentDR
)