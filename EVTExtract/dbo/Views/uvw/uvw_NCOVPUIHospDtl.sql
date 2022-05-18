create view dbo.uvw_NCOVPUIHospDtl as
select  
  try_cast(NCOVPUIHospDtlAdmitDt as datetime) NCOVPUIHospDtlAdmitDt,
  NCOVPUIHospDtlAdmitDiagno,
  NCOVPUIHospDtlCity,
  try_cast(NCOVPUIHospDtlDischDt as datetime) NCOVPUIHospDtlDischDt,
  NCOVPUIHospDtlDischDiagno,
  NCOVPUIHospDtlName,
  try_cast(NCOVPUIHospDtlICUAdmitDt as datetime) NCOVPUIHospDtlICUAdmitDt,
  try_cast(NCVPUIICUAdminDate2 as datetime) NCVPUIICUAdminDate2,
  try_cast(NCVPUIICUAdminDate3 as datetime) NCVPUIICUAdminDate3,
  try_cast(NCVPUIICUAdminDate4 as datetime) NCVPUIICUAdminDate4,
  try_cast(NCVPUIICUAdminDate5 as datetime) NCVPUIICUAdminDate5,
  try_cast(NCVPUIICUAdminDate6 as datetime) NCVPUIICUAdminDate6,
  try_cast(NCOVPUIHospDtlICUDischDt as datetime) NCOVPUIHospDtlICUDischDt,
  try_cast(NCVPUIICUDischDate2 as datetime) NCVPUIICUDischDate2,
  try_cast(NCVPUIICUDischDate3 as datetime) NCVPUIICUDischDate3,
  try_cast(NCVPUIICUDischDate4 as datetime) NCVPUIICUDischDate4,
  try_cast(NCVPUIICUDischDate5 as datetime) NCVPUIICUDischDate5,
  try_cast(NCVPUIICUDischDate6 as datetime) NCVPUIICUDischDate6,
  try_cast(NCOVPUIHospDtlIntub1EndDt as datetime) NCOVPUIHospDtlIntub1EndDt,
  try_cast(NCOVPUIHospDtlIntub2EndDt as datetime) NCOVPUIHospDtlIntub2EndDt,
  try_cast(NCVPUIIntubateEndDate3 as datetime) NCVPUIIntubateEndDate3,
  try_cast(NCVPUIIntubateEndDate4 as datetime) NCVPUIIntubateEndDate4,
  try_cast(NCVPUIIntubateEndDate5 as datetime) NCVPUIIntubateEndDate5,
  try_cast(NCVPUIIntubateEndDate6 as datetime) NCVPUIIntubateEndDate6,
  try_cast(NCOVPUIHospDtlIntub1StartDt as datetime) NCOVPUIHospDtlIntub1StartDt,
  try_cast(NCOVPUIHospDtlIntub2StartDt as datetime) NCOVPUIHospDtlIntub2StartDt,
  try_cast(NCVPUIIntubateStartDate3 as datetime) NCVPUIIntubateStartDate3,
  try_cast(NCVPUIIntubateStartDate4 as datetime) NCVPUIIntubateStartDate4,
  try_cast(NCVPUIIntubateStartDate5 as datetime) NCVPUIIntubateStartDate5,
  try_cast(NCVPUIIntubateStartDate6 as datetime) AS NCVPUIIntubateStartDate6,
  NCOVPUIHospDtlMRN,
  substring(NCOVPUIHospDtlICU,1,1) NCOVPUIHospDtlICU,
  substring(NCOVPUIHospDtlIntub,1,1) NCOVPUIHospDtlIntub,
  NCOVPUIHospDtlState,
  NCOVPUIHospDtlAddr,
  NCOVPUIHospDtlPhone,
  NCOVPUIHospDtlZip,
  DIID = RECORD_ID,
  INSTANCEID = PR_INCIDENTID,
  Person_ID = PER_ClientID,
  UDSectionActID = SECTION_INSTANCE_ID,
  RecordType = PR_PHTYPE,
  Disease = PR_DISEASE,
  District = PR_DISTRICT,
  FormInstanceID = FORM_INSTANCE_ID,
  FormName = FORM_NAME,
  FormDescription = FORM_DESCRIPTION,
  FormCreateDateTime = try_convert(datetime,[FORM_CREATEDATE])
from    
( select  
    UDF.RECORD_ID,
    UDF.FORM_INSTANCE_ID,
    UDF.FORM_NAME,
    UDF.FORM_DESCRIPTION,
    UDF.FORM_CREATEDATE,
    UDF.SECTION_INSTANCE_ID,
    UDF.FIELD_DEF_DR,
    UDF.FIELD_VALUE,
    P.PER_ClientID,
    I.PR_PHTYPE,
    I.PR_DISEASE,
    I.PR_INCIDENTID,
    I.PR_DISTRICT
  from    
    dbo.COVID_UDF_DATA UDF with (nolock) 
    inner join 
    dbo.COVID_INCIDENT I with (nolock)
    on 
      UDF.RECORD_ID = I.PR_ROWID
    inner join 
    dbo.COVID_PERSON P with (nolock)
    on 
      P.PER_ROWID = I.PR_PersonDR
  where   
    UDF.SECTION_DEF_DR = 'NCOVPUIHospDtl'  and FORM_DEF_DR = 'NCOVPUI'
) PivotData
pivot
( max(FIELD_VALUE)
  for FIELD_DEF_DR in 
  ( NCOVPUIHospDtlAdmitDt,
    NCOVPUIHospDtlAdmitDiagno,
    NCOVPUIHospDtlCity,
    NCOVPUIHospDtlDischDt,
    NCOVPUIHospDtlDischDiagno,
    NCOVPUIHospDtlName,
    NCOVPUIHospDtlICUAdmitDt,
    NCOVPUIHospDtlICUDischDt,
    NCOVPUIHospDtlIntub1EndDt,
    NCOVPUIHospDtlIntub2EndDt,
    NCOVPUIHospDtlIntub1StartDt,
    NCOVPUIHospDtlIntub2StartDt,
    NCOVPUIHospDtlMRN,
    NCOVPUIHospDtlICU,
    NCOVPUIHospDtlIntub,
    NCOVPUIHospDtlState,
    NCOVPUIHospDtlAddr,
    NCOVPUIHospDtlPhone,
    NCOVPUIHospDtlZip,
    NCVPUIICUAdminDate2,
    NCVPUIICUAdminDate3,
    NCVPUIICUAdminDate4,
    NCVPUIICUAdminDate5,
    NCVPUIICUAdminDate6,
    NCVPUIICUDischDate2,
    NCVPUIICUDischDate3,
    NCVPUIICUDischDate4,
    NCVPUIICUDischDate5,
    NCVPUIICUDischDate6,
    NCVPUIIntubateEndDate3,
    NCVPUIIntubateEndDate4,
    NCVPUIIntubateEndDate5,
    NCVPUIIntubateEndDate6,
    NCVPUIIntubateStartDate3,
    NCVPUIIntubateStartDate4,
    NCVPUIIntubateStartDate5,
    NCVPUIIntubateStartDate6
  )
) PivotTable
