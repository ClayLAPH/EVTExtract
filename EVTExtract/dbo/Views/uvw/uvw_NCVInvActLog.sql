create view dbo.uvw_NCVInvActLog as
select
  NCVOBDeaths,
  NCVConfDeath,
  NCVdeathStaff,
  NCVDeathConfStaff,
  NCVOBHospCases,
  NCVNumHosStaff,
  NCVNumCases,
  NCVConfStaff,
  NCVNumSypRes,
  NCVNumSyptStaff,
  NCVOBtext,
  NCVDateLastCRes = try_convert(datetime,NCVDateLastCRes),
  NCVDateLastCStaff = try_convert(datetime,NCVDateLastCStaff),
  NCVOBLastCaseFac = try_convert(datetime,NCVOBLastCaseFac),
  NCVdateLastSymptRes = try_convert(datetime,NCVdateLastSymptRes),
  NCVDateLastSympStaff = try_convert(datetime,NCVDateLastSympStaff),
  NCVDeathDet,
  NCVStaffDeathDetails,
  NCV,
  NCVOBInv,
  NCVOBEmpGuidWorksite,
  NCVFieldWkStat,
  NCVnonstafftype,
  HASupAddINVESTIGATOR,
  NCVOtherNonStaffType,
--/*
  NCVOBDateEpiCurveUpLoaded = try_convert(datetime,NCVOBDateEpiCurveUpLoaded),
  NCVOBDateEpiFormUpLoaded = try_convert(datetime,NCVOBDateEpiFormUpLoaded),
  NCVOBDateLineListUpLoad = try_convert(datetime,NCVOBDateLineListUpLoad),
  NCVOBNoEpiCurve = substring(NCVOBNoEpiCurve,1,1),
  NCVOBNoLineList = substring(NCVOBNoLineList,1,1),
  NCVDateLastCNonStaffAtFacility = try_convert(datetime, NCVDateLastCNonStaffAtFacility ),
--*/
  NCVOBTIER,
  NCVOBNUMNONSTAFFTESTED,
  NCVOBNUMSTAFFTESTED,
  NCVOBTEAMRESPONSIBLE,
  DIID=RECORD_ID,
  INSTANCEID=OUTB_OUTBREAKID,
  UDSectionActID=SECTION_INSTANCE_ID,
  RecordType='Outbreak', 
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
    UDF.FIELD_DEF_DR,
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
    UDF.SECTION_DEF_DR = 'NCVInvActLog' and FORM_DEF_DR = 'NCVOBTab'
) PivotData
pivot 
( max(FIELD_VALUE)
  for FIELD_DEF_DR IN 
  ( NCVOBDeaths,
    NCVConfDeath,
    NCVdeathStaff,
    NCVDeathConfStaff,
    NCVOBHospCases,
    NCVNumHosStaff,
    NCVNumCases,
    NCVConfStaff,
    NCVNumSypRes,
    NCVNumSyptStaff,
    NCVOBtext,
    NCVDateLastCRes,
    NCVDateLastCStaff,
    NCVOBLastCaseFac,
    NCVdateLastSymptRes,
    NCVDateLastSympStaff,
    NCVDeathDet,
    NCVStaffDeathDetails,
    NCV,
    NCVFieldWkStat,
    NCVOBEmpGuidWorksite,
    NCVnonstafftype,
    NCVOBInv,
    HASupAddINVESTIGATOR,
    NCVOtherNonStaffType,
--/*
    NCVOBDateEpiCurveUpLoaded,
    NCVOBDateEpiFormUpLoaded,
    NCVOBDateLineListUpLoad,
    NCVOBNoEpiCurve,
    NCVOBNoLineList,
    NCVDateLastCNonStaffAtFacility,
--*/
    NCVOBTIER,
    NCVOBNUMNONSTAFFTESTED,
    NCVOBNUMSTAFFTESTED,
    NCVOBTEAMRESPONSIBLE
  )
) PivotTable


