create view dbo.DrugSusceptibility as
select 
  DSR_ID, 
  LabReportID, 
  DSR_DrugDR, 
  DSR_Drug, 
  DSR_OtherDrugName, 
  DSR_Concentration, 
  DSR_Method, 
  DSR_ResultDR, 
  DSR_Result 
from 
  [$(PRD_APHIM_UODS)].AtlasInternal.ViewDrugSusceptibilityResults with (nolock)
