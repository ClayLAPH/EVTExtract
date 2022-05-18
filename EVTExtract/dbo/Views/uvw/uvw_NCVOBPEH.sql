create view dbo.[uvw_NCVOBPEH] as
select
  NCVDesQuarantPEH,
  NCVFacNoResponseExplainPEH,
  NCVOBDateLastExp,
  NCVOBNotesQuarantine,
  NCVOBPosCaseOrPUISheltering,
  NCVOBQuarEndDate = try_convert(datetime,NCVOBQuarEndDate),
  NCVOBQuarEndDate2 = try_convert(datetime,NCVOBQuarEndDate2),
  NCVOBQuarStartDate = try_convert(datetime,NCVOBQuarStartDate),
  NCVOBQuarStartDate2 = try_convert(datetime,NCVOBQuarStartDate2),
  NCVOBQuarType,
  NCVOBQuarType2,
  NCVOBVulnPop,
  NCVOpenAdmPEH,
  NCVWorkQandNonQAreasPEH,
  NCVOBPEHExtMonEndDate = try_convert(datetime,NCVOBPEHExtMonEndDate),
  NCVOBPEHExtMonNotes,
  NCVOBPEHExtMonStartDate = try_convert(datetime,NCVOBPEHExtMonStartDate),
  NCVOBPEHMedVulnNotApp,
  NCVOBPEHPriority,
  NCVOBPEHProviderDateClose = try_convert(datetime,NCVOBPEHProviderDateClose),
  NCVOBPEHShelterNotApp,
  NCVOBPEHStaffWorkBetweenNotApp,
  NCVOBPEHVacEd,
  NCVOBPEHVacEdDate3,
  NCVOBPEHVacEduType,
  NVCOBPEHOpenNotApp,
  DIID = RECORD_ID,
  INSTANCEID = OUTB_OUTBREAKID,
  UDSectionActID = SECTION_INSTANCE_ID,
  RecordType = 'Outbreak',
  Disease = OUTB_Disease,
  OutbreakNumber = OUTB_OutbreakNumber,
  District = OUTB_District,
  FormInstanceID = FORM_INSTANCE_ID,
  FormName = FORM_NAME,
  FormDescription = FORM_DESCRIPTION,
  FormCreateDateTime = try_convert(datetime,FORM_CREATEDATE)
from    
( select  
    UDF.RECORD_ID,
    UDF.FORM_INSTANCE_ID,
    UDF.FORM_NAME,
    UDF.FORM_DESCRIPTION,
    UDF.FORM_CREATEDATE,
    UDF.FORM_DEF_DR,
    UDF.SECTION_INSTANCE_ID,
    UDF.FIELD_DEF_DR FIELD_DEF_DR,
    FIELD_VALUE,
    O.OUTB_Disease,
    O.OUTB_OutbreakNumber,
    O.OUTB_OUTBREAKID,
    O.OUTB_District
  from    
    dbo.COVID_OUTBREAK_UDF_DATA UDF with (nolock) 
    INNER JOIN 
    dbo.COVID_OUTBREAK O with (nolock)
    ON UDF.RECORD_ID = O.OUTB_ROWID
  where   
    UDF.SECTION_DEF_DR = 'NCVOBPEH' and FORM_DEF_DR = 'NCVFacilityMonitoring'
) PivotData
pivot 
( max(FIELD_VALUE)
  for FIELD_DEF_DR in 
  ( NCVDesQuarantPEH,
    NCVFacNoResponseExplainPEH,
    NCVOBDateLastExp,
    NCVOBNotesQuarantine,
    NCVOBPosCaseOrPUISheltering,
    NCVOBQuarEndDate,
    NCVOBQuarEndDate2,
    NCVOBQuarStartDate,
    NCVOBQuarStartDate2,
    NCVOBQuarType,
    NCVOBQuarType2,
    NCVOBVulnPop,
    NCVOpenAdmPEH,
    NCVWorkQandNonQAreasPEH,
    NCVOBPEHDesQuarantNotApp,
    NCVOBPEHExtMonEndDate,
    NCVOBPEHExtMonNotes,
    NCVOBPEHExtMonStartDate,
    NCVOBPEHMedVulnNotApp,
    NCVOBPEHPriority,
    NCVOBPEHProviderDateClose,
    NCVOBPEHShelterNotApp,
    NCVOBPEHStaffWorkBetweenNotApp,
    NCVOBPEHVacEd,
    NCVOBPEHVacEdDate3,
    NCVOBPEHVacEduType,
    NVCOBPEHOpenNotApp 
  )
) PivotTable
