create view dbo.uvw_SOGI as
select 
    OtherGenderSpfy, 
    SexualOrient, 
    SOGIRaceEthnOth, 
    SexatBirthOth, 
    SexualOrientSpcfy, 
    CurGenID, 
    SOGIRaceEthn, 
    SexatBirth, 
    DIID= RECORD_ID, 
    INSTANCEID         = PR_INCIDENTID,
    Person_ID          = PER_ClientID,
    UDSectionActID     = SECTION_INSTANCE_ID,
    RecordType         = PR_PHTYPE,
    Disease            = PR_DISEASE, 
    District           = PR_DISTRICT,
    FormInstanceID     = FORM_INSTANCE_ID,
    FormName           = FORM_NAME,
    FormDescription    = FORM_DESCRIPTION, 
    FormCreateDateTime = try_CONVERT(DATETIME,FORM_CREATEDATE)
from
(   select
        UDF.RECORD_ID,     
        UDF.FORM_INSTANCE_ID, 
        UDF.FORM_NAME, 
        UDF.FORM_DESCRIPTION, 
        UDF.FORM_CREATEDATE, 
        UDF.SECTION_INSTANCE_ID, 
        UDF.FIELD_DEF_DR AS FIELD_DEF_DR, 
        CAST(FIELD_VALUE AS VARCHAR(MAX)) AS FIELD_VALUE, 
        P.PER_ClientID, 
        I.PR_PHTYPE, 
        I.PR_DISEASE, 
        I.PR_INCIDENTID, 
        I.PR_DISTRICT,
        SOGIRaceEthnOth = substring((
          select  distinct ', ' + convert(varchar(max), UDFA.FIELD_VALUE) 
          from    dbo.COVID_OUTBREAK_UDF_DATA AS UDFA
          where   
            UDFA.RECORD_ID      =  UDF.RECORD_ID and 
            UDFA.FIELD_DEF_DR   = 'SOGIRaceEthnOth' and 
            UDFA.SECTION_DEF_DR = 'SOGIV01' 
          order by -- to get 'distinct', the select expressions must be in the  order by clause:
            ', ' + convert(varchar(max), UDFA.FIELD_VALUE)
          for xml path ('') ), 3, 100000 ), 
        SOGIRaceEthn = substring((
          select  distinct ', ' + convert(varchar(max), UDFA.FIELD_VALUE)
          from    dbo.COVID_OUTBREAK_UDF_DATA AS UDFA
          where
            UDFA.RECORD_ID      =  UDF.RECORD_ID and
            UDFA.FIELD_DEF_DR   = 'SOGIRaceEthn' and 
            UDFA.SECTION_DEF_DR = 'SOGIV01' 
          order by -- to get 'distinct', the select expressions must be in the  order by clause:
            ', ' + convert(varchar(max), UDFA.FIELD_VALUE)
          for xml path ('') ), 3, 100000 )

    from    
        dbo.COVID_UDF_DATA AS UDF INNER JOIN 
        dbo.COVID_INCIDENT AS I   ON UDF.RECORD_ID = I.PR_ROWID INNER JOIN 
        dbo.COVID_PERSON   AS P   ON P.PER_ROWID = I.PR_PersonDR
    where   
        UDF.SECTION_DEF_DR = 'SOGIV01' 
) as PivotData
pivot (
    MAX(FIELD_VALUE)
    FOR FIELD_DEF_DR IN (
		OtherGenderSpfy, 
        SexualOrient, 
--        SOGIRaceEthnOth, 
        SexatBirthOth,
        SexualOrientSpcfy,
        CurGenID,
--        SOGIRaceEthn,
        SexatBirth
    )
) AS PivotTable

