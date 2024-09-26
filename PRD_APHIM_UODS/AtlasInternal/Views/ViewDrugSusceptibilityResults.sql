
CREATE VIEW [AtlasInternal].[ViewDrugSusceptibilityResults]
AS
SELECT  DSR_ID AS DSR_ID,
 DSR_LabreportID AS LabReportID,
 DSR_DrugDR AS DSR_DrugDR,
 (CASE WHEN DSR_DrugDR < 0 THEN 'Other' ELSE [dbo].[MDF_UCS_FullName_UCS_ByUCSId](DSR_DrugDR)  END) AS DSR_Drug,
 DSR_OtherDrugName AS DSR_OtherDrugName,
 DSR_Concentration AS DSR_Concentration,
 DSR_Method AS DSR_Method,
 DSR_ResultDR AS DSR_ResultDR,
 [dbo].[MDF_UCS_FullName_UCS_ByUCSId](DSR_ResultDR) AS DSR_Result
FROM Ax_DrugSusceptibility AXDS (NOLOCK)
WHERE DSR_StatusCode<>'nullified'

