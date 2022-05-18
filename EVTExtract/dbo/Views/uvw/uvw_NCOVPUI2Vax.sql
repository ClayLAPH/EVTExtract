create view dbo.uvw_NCOVPUI2Vax as
select
  NCOVPUI2Vax1Date = try_cast(NCOVPUI2Vax1Date AS datetime),
  NCOVPUI2Vax2Date = try_cast(NCOVPUI2Vax2Date AS datetime),
  NCOVPUI2Vax3Date = try_cast(NCOVPUI2Vax3Date AS datetime),
  NCOVPUI2Vax3DateUnk,
  NCOVPUI2Vax2DateUnk,
  NCOVPUI2Vax1DateUnk,
  NCOVPUI2VaxVax,
  NCOVPUI2Vax1TypeOth,
  NCOVPUI2Vax2TypeOth,
  NCOVPUI2Vax3TypeOth,
  NCOVPUI2Vax3Type,
  NCOVPUI2Vax2Type,
  NCOVPUI2Vax1Type,
  NCVDINonCairVax1Dose,
  NCVDINonCairVax2Dose,
  NCVDINonCairVax3Dose,
  NCVDINonCairVax4Dose,
  NCVDIVaxNonCairReportOther1Dose,
  NCVDIVaxNonCairReportOther2Dose,
  NCVDIVaxNonCairReportOther3Dose,
  NCVDIVaxNonCairReportOther4Dose,
  NCVDIVaxCairReportDate1Dose,
  NCVDIVaxCairReportDate2Dose,
  NCVDIVaxCairReportDate3Dose,
  NCVDIVaxCairReportDate4Dose,
  NCVDIVaxCairReportDate1DoseUnk,
  NCVDIVaxCairReportDate2DoseUnk,
  NCVDIVaxCairReportDate3DoseUnk,
  NCVDIVaxCairReportDate4DoseUnk,
  NCVDIPostVaxHospNotes,
  NCVDIPostVaxDeath,
  NCVDIPostVaxHosp,
  NCVDIPostVaxInf,
  NCVDIVaxCairType1Dose,
  NCVDIVaxCairType2Dose,
  NCVDIVaxCairType3Dose,
  NCVDIVaxCairType4Dose,
  NCVDIVaxCairTypeOther1Dose,
  NCVDIVaxCairTypeOther2Dose,
  NCVDIVaxCairTypeOther3Dose,
  NCVDIVaxCairTypeOther4Dose,
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
  FormCreateDateTime = try_cast(FORM_CREATEDATE as datetime)
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
    UDF.SECTION_DEF_DR = 'NCOVPUI2Vax' and FORM_DEF_DR = 'NCOVPUI'
) PivotData
pivot 
(
  max(FIELD_VALUE)
  for FIELD_DEF_DR in 
  (
    NCOVPUI2Vax1Date,
    NCOVPUI2Vax2Date,
    NCOVPUI2Vax3Date,
    NCOVPUI2Vax3DateUnk,
    NCOVPUI2Vax2DateUnk,
    NCOVPUI2Vax1DateUnk,
    NCOVPUI2VaxVax,
    NCOVPUI2Vax1TypeOth,
    NCOVPUI2Vax2TypeOth,
    NCOVPUI2Vax3TypeOth,
    NCOVPUI2Vax3Type,
    NCOVPUI2Vax2Type,
    NCOVPUI2Vax1Type,
    NCVDINonCairVax1Dose,
    NCVDINonCairVax2Dose,
    NCVDINonCairVax3Dose,
    NCVDINonCairVax4Dose,
    NCVDIVaxNonCairReportOther1Dose,
    NCVDIVaxNonCairReportOther2Dose,
    NCVDIVaxNonCairReportOther3Dose,
    NCVDIVaxNonCairReportOther4Dose,
    NCVDIVaxCairReportDate1Dose,
    NCVDIVaxCairReportDate2Dose,
    NCVDIVaxCairReportDate3Dose,
    NCVDIVaxCairReportDate4Dose,
    NCVDIVaxCairReportDate1DoseUnk,
    NCVDIVaxCairReportDate2DoseUnk,
    NCVDIVaxCairReportDate3DoseUnk,
    NCVDIVaxCairReportDate4DoseUnk,
    NCVDIPostVaxHospNotes,
    NCVDIPostVaxDeath,
    NCVDIPostVaxHosp,
    NCVDIPostVaxInf,
    NCVDIVaxCairType1Dose,
    NCVDIVaxCairType2Dose,
    NCVDIVaxCairType3Dose,
    NCVDIVaxCairType4Dose,
    NCVDIVaxCairTypeOther1Dose,
    NCVDIVaxCairTypeOther2Dose,
    NCVDIVaxCairTypeOther3Dose,
    NCVDIVaxCairTypeOther4Dose
  )
) PivotTable
