create view dbo.uvw_NCVOBSiteVisit as
select
  NCVOBVisitComments,
  NCVOBVisitDate = try_convert(datetime,NCVOBVisitDate),
  NCVOBTeam,
  NCVOBOtherTeam,
  NCVOBTeamCondVisit,
  NCVOBVisitType,
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
    UDF.FIELD_DEF_DR AS FIELD_DEF_DR,
    UDF.FIELD_VALUE,
    O.OUTB_Disease,
    O.OUTB_OutbreakNumber,
    O.OUTB_OUTBREAKID,
    O.OUTB_District
  from    
    dbo.COVID_OUTBREAK_UDF_DATA UDF with (nolock) 
    INNER JOIN 
    dbo.COVID_OUTBREAK O with (nolock)
    on 
      UDF.RECORD_ID = O.OUTB_ROWID
  where   
    UDF.SECTION_DEF_DR = 'NCVOBSiteVisit' and FORM_DEF_DR = 'NCVOBTab'
) PivotData
pivot 
( max(FIELD_VALUE)
  for FIELD_DEF_DR in 
  ( NCVOBVisitComments,
    NCVOBVisitDate,
    NCVOBTeam,
    NCVOBOtherTeam,
    NCVOBTeamCondVisit,
    NCVOBVisitType
  )
) PivotTable
