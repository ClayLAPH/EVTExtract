create view dbo.uvw_NCOVPUINonNCoV as
select  
  NCOVPUINonNCoVCollDt = try_cast(NCOVPUINonNCoVCollDt as datetime),
  NCOVPUINonNCoVSpcmTypeOth,
  NCOVPUINonNCoVTstPerfOth,
  NCOVPUINonNCoVPathogenOth,
  NCOVPUINonNCoVPathogen,
  NCOVPUINonNCoVRslt,
  NCOVPUINonNCoVSpcmType,
  NCOVPUINonNCoVTstPerf,
  NCOVPUINonNCoVWhere,
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
  FormCreateDateTime = try_convert(datetime,FORM_CREATEDATE)
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
    UDF.SECTION_DEF_DR = 'NCOVPUINonNCoV' and FORM_DEF_DR = 'NCOVPUI'
) PivotData
PIVOT 
( MAX(FIELD_VALUE)
  FOR FIELD_DEF_DR IN 
  ( NCOVPUINonNCoVCollDt,
    NCOVPUINonNCoVSpcmTypeOth,
    NCOVPUINonNCoVTstPerfOth,
    NCOVPUINonNCoVPathogenOth,
    NCOVPUINonNCoVPathogen,
    NCOVPUINonNCoVRslt,
    NCOVPUINonNCoVSpcmType,
    NCOVPUINonNCoVTstPerf,
    NCOVPUINonNCoVWhere
  )
) PivotTable

