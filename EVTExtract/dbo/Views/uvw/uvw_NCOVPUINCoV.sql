create view dbo.uvw_NCOVPUINCoV as
select  
  try_convert(datetime, NCOVPUINCoVCollDt) NCOVPUINCoVCollDt,
  NCOVPUINCoVSpcmTypeOth,
  NCOVPUINCoVRslt =   
    case NCOVPUINCoVRslt
      when 'Equivocal' then 'EQU'
      when 'Negative' then 'NEG' 
      when 'Not done' then 'NOT'
      when 'Pending' then 'PEN'
      when 'Positive' then 'POS'
      when 'Presumptive Positive' then 'PRP'
      else NULL
    end,
  NCOVPUINCoVSentCDC,
  NCOVPUINCoVSpcmType,
  NCOVPUINCoVWhere,
  NCOVPUINonNCoVTstPerf,
  NCVTestType,
  NCVDIDateSeq,
  NCVDILabNameSeq,
  NCVDISeq,
  NCVIDOtherSeq,
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
    UDF.SECTION_DEF_DR = 'NCOVPUINCoV' and FORM_DEF_DR = 'NCOVPUI'
) PivotData
pivot 
( max(FIELD_VALUE)
  for FIELD_DEF_DR in 
  ( NCOVPUINCoVCollDt,
    NCOVPUINCoVSpcmTypeOth,
    NCOVPUINCoVRslt,
    NCOVPUINCoVSentCDC,
    NCOVPUINCoVSpcmType,
    NCOVPUINCoVWhere,
    NCOVPUINonNCoVTstPerf,
    NCVTestType,
    NCVDIDateSeq,
    NCVDILabNameSeq,
    NCVDISeq,
    NCVIDOtherSeq
  )
) PivotTable
