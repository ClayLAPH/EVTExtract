create view dbo.uvw_NCVFacSect2 as
select          
  NCVOBDeaths,
  NCVDropPrecautions = substring(NCVDropPrecautions,1,1),
  NCVWorkQandNonQAreas= substring(NCVWorkQandNonQAreas,1,1),
  NCVStaffDailyHealth= substring(NCVStaffDailyHealth,1,1),
  NCVSocialDistRes = substring(NCVSocialDistRes,1,1),
  NCVSociaDistanceStaff = substring(NCVSociaDistanceStaff,1,1),
  NCVTwiceDailyHealht = substring(NCVTwiceDailyHealht,1,1),
  NCVContPlanPPE = substring(NCVContPlanPPE,1,1),
  NCVContigSickStaff = substring(NCVContigSickStaff,1,1),
  NCVInformNotOtherWork = substring(NCVInformNotOtherWork,1,1),
  NCVStaffRetrainiedPPE = substring(NCVStaffRetrainiedPPE,1,1),
  NCVControAudStaff = substring(NCVControAudStaff,1,1),
  NCVDesQuarant= substring(NCVDesQuarant,1,1),
  NCVFacNoResponseExplain,
  NCVOpenAdm = substring(NCVOpenAdm,1,1),
  DIID = RECORD_ID,
  INSTANCEID = OUTB_OUTBREAKID,
  UDSectionActID = SECTION_INSTANCE_ID,
  RecordType= 'Outbreak',
  Disease = OUTB_Disease,
  OutbreakNumber = OUTB_OutbreakNumber,
  District = OUTB_District,
  FormInstanceID = FORM_INSTANCE_ID,
  FormName = FORM_NAME,
  FormDescription= FORM_DESCRIPTION,
  FormCreateDateTime= try_convert(datetime,FORM_CREATEDATE)
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
    inner join
    dbo.COVID_OUTBREAK O with (nolock)
    on 
      UDF.RECORD_ID = O.OUTB_ROWID
  where   
    UDF.SECTION_DEF_DR = 'NCVFacSect2' and FORM_DEF_DR = 'NCVFacilityMonitoring'
) PivotData
pivot 
( max(FIELD_VALUE)
  for FIELD_DEF_DR in 
  ( NCVOBDeaths,
    NCVDropPrecautions,
    NCVWorkQandNonQAreas,
    NCVStaffDailyHealth,
    NCVSocialDistRes,
    NCVSociaDistanceStaff,
    NCVTwiceDailyHealht,
    NCVContPlanPPE,
    NCVContigSickStaff,
    NCVInformNotOtherWork,
    NCVStaffRetrainiedPPE,
    NCVControAudStaff,
    NCVDesQuarant,
    NCVFacNoResponseExplain,
    NCVOpenAdm
  )
) PivotTable

GO

