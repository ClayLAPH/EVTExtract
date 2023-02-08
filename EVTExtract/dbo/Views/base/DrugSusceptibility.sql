create view dbo.DrugSusceptibility as
select 
  DSRID = max(dsr.DSR_ID), 
  dsr.LabReportId, 
  dsr.DSR_DrugDR, 
  DSR_OtherDrugName = dsr.DSR_Drug, --> per issue 2499
  DSR_Drug = dsr.DSR_OtherDrugName, --> per issue 2499
  dsr.DSR_Concentration, 
  dsr.DSR_Method, 
  dsr.DSR_ResultDR, 
  dsr.DSR_Result
from
  ( select 
      DSR_ID,
      LabReportId     = ax.DSR_LabreportID,
      DSR_DrugDR      = ax.DSR_DrugDR,
      DSR_Drug        = case when ax.DSR_DrugDR < 0 then 'Other' else [$(PRD_APHIM_UODS)].[dbo].[MDF_UCS_FullName_UCS_ByUCSId](ax.DSR_DrugDR) end,
      DSR_OtherDrugName,
      DSR_Concentration,
      DSR_Method,
      DSR_ResultDR,
      DSR_Result      = [$(PRD_APHIM_UODS)].[dbo].[MDF_UCS_FullName_UCS_ByUCSId](DSR_ResultDR)
    from 
      [$(PRD_APHIM_UODS)].dbo.Ax_DrugSusceptibility ax with (nolock)
    where 
      DSR_StatusCode != 'nullified' and
      DSR_LabreportID is not null
  ) dsr
group by 
  LabReportId, 
  DSR_DrugDR, 
  DSR_Drug, 
  DSR_OtherDrugName, 
  DSR_Concentration, 
  DSR_Method, 
  DSR_ResultDR, 
  DSR_Result
