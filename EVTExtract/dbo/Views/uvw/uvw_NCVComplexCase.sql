create view dbo.uvw_NCVComplexCase as
select
  NCVIncPosReport, 
  NCVConfReinfect, 
  NCVFalsePosTest, 
  NCVFalseTestDetermd, 
  NCVDConfInfectDetermd, 
  NCVIncPosRepDetermd, 
  RECORD_ID                             DIID, 
  PR_INCIDENTID                         INSTANCEID, 
  PER_ClientID                          Person_ID, 
  SECTION_INSTANCE_ID                   UDSectionActID, 
  PR_PHTYPE                             RecordType, 
  PR_DISEASE                            Disease, 
  PR_DISTRICT                           District, 
  FORM_INSTANCE_ID                      FormInstanceID, 
  FORM_NAME                             FormName, 
  FORM_DESCRIPTION                      FormDescription, 
  try_convert(datetime,FORM_CREATEDATE) FormCreateDateTime
from    
  ( select  
      UDF.RECORD_ID, 
      UDF.FORM_INSTANCE_ID, 
      UDF.FORM_NAME, 
      UDF.FORM_DESCRIPTION, 
      UDF.FORM_CREATEDATE, 
      UDF.SECTION_INSTANCE_ID , 
      UDF.FIELD_DEF_DR FIELD_DEF_DR, 
      cast(FIELD_VALUE AS varchar(max)) FIELD_VALUE, 
      P.PER_ClientID, 
      I.PR_PHTYPE, 
      I.PR_DISEASE, 
      I.PR_INCIDENTID, 
      I.PR_DISTRICT
    from    
      dbo.COVID_UDF_DATA AS UDF with (nolock) 
			INNER JOIN 
      dbo.COVID_INCIDENT AS I with (nolock)
      on 
        UDF.RECORD_ID = I.PR_ROWID
      INNER JOIN 
      dbo.COVID_PERSON AS P with (nolock)
      on 
        P.PER_ROWID = I.PR_PersonDR
    where   
      UDF.SECTION_DEF_DR = 'NCVComplexCase'  
      AND 
      FORM_DEF_DR = 'NCOVPUI'
  ) PivotData
pivot 
  (
    max(FIELD_VALUE)
    for FIELD_DEF_DR IN 
    (
      NCVIncPosReport, 
      NCVConfReinfect, 
      NCVFalsePosTest, 
      NCVFalseTestDetermd, 
      NCVDConfInfectDetermd, 
      NCVIncPosRepDetermd
    )
  ) as PivotTable

