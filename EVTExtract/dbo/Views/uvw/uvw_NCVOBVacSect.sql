create view dbo.uvw_NCVOBVacSect as
select          
  NCVOBNumVacStaff,
  NCVOBNumPartVacStaff,
  NCVOBNumUnVacStaff,
  NCVOBNumStaffVacUnk,
  NCVOBPercentVacStaff,
  NCVOBNumStaff,
  NCVOBNumVacNonStaff,
  NCVOBNumPartVacNonStaff,
  NVCOBNumNonStaffUnVac,
  NCVOBNumNonStaffVacUnk,
  NCVOBPercentVacNonStaff,
  NCVOBNumNonStaff,
  NCVOBVacRefGiven,
  DIID = RECORD_ID,
  INSTANCEID= OUTB_OUTBREAKID,
  UDSectionActID = SECTION_INSTANCE_ID,
  RecordType= 'Outbreak', 
  Disease = OUTB_Disease,
  OutbreakNumber = OUTB_OutbreakNumber,
  District = OUTB_District,
  FormInstanceID = FORM_INSTANCE_ID,
  FormName= FORM_NAME,
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
      CAST( FIELD_VALUE AS VARCHAR(MAX)) FIELD_VALUE,
      O.OUTB_Disease, 
      O.OUTB_OutbreakNumber,
      O.OUTB_OUTBREAKID,
      O.OUTB_District
    from
      dbo.COVID_OUTBREAK_UDF_DATA UDF with (nolock) 
      inner join
      dbo.COVID_OUTBREAK O with (nolock)
      on 
        UDF.RECORD_ID = O.OUTB_ROWID
    WHERE
      UDF.SECTION_DEF_DR = 'NCVOBVacSect' 
      and 
      FORM_DEF_DR = 'NCVOBTab'
  ) AS PivotData
pivot 
(
  max(FIELD_VALUE)
  for FIELD_DEF_DR in 
  (
    NCVOBNumVacStaff, 
    NCVOBNumPartVacStaff, 
    NCVOBNumUnVacStaff, 
    NCVOBNumStaffVacUnk, 
    NCVOBPercentVacStaff, 
    NCVOBNumStaff, 
    NCVOBNumVacNonStaff, 
    NCVOBNumPartVacNonStaff, 
    NVCOBNumNonStaffUnVac, 
    NCVOBNumNonStaffVacUnk, 
    NCVOBPercentVacNonStaff, 
    NCVOBNumNonStaff, 
    NCVOBVacRefGiven
  ) 
) as PivotTable

