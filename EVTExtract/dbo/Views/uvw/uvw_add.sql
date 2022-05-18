create view dbo.uvw_Add as
select
  AddtlNotesAddNotes, 
  RECORD_ID DIID, 
  OUTB_OUTBREAKID INSTANCEID, 
  SECTION_INSTANCE_ID UDSectionActID,  
  RecordType = 'Outbreak',
  OUTB_Disease Disease, 
  OUTB_OutbreakNumber OutbreakNumber, 
  OUTB_District District, 
  FORM_INSTANCE_ID FormInstanceID, 
  FORM_NAME FormName, 
  FORM_DESCRIPTION FormDescription, 
  try_convert(datetime,FORM_CREATEDATE) FormCreateDateTime
from
( select
    UDF.RECORD_ID, 
    UDF.FORM_INSTANCE_ID, 
    UDF.FORM_NAME, 
    UDF.FORM_DESCRIPTION, 
    UDF.FORM_CREATEDATE, 
    UDF.FORM_DEF_DR, 
    UDF.SECTION_INSTANCE_ID , 
    UDF.FIELD_DEF_DR AS FIELD_DEF_DR, 
    UDF.FIELD_VALUE,
    O.OUTB_Disease, O.OUTB_OutbreakNumber, 
    O.OUTB_OUTBREAKID, O.OUTB_District
  from
    dbo.COVID_OUTBREAK_UDF_DATA UDF with (nolock) 
    inner join
    dbo.COVID_OUTBREAK O with (nolock)
    on
      UDF.RECORD_ID = O.OUTB_ROWID
    where   
      UDF.SECTION_DEF_DR = 'Add' and FORM_DEF_DR = 'AddtlNotes'
) PivotData
pivot 
(
  max(FIELD_VALUE)
  for FIELD_DEF_DR in 
  ( AddtlNotesAddNotes
  )
) PivotTable
