create view dbo.uvw_EbolaSympV05 as
select    
  NCVAbdPain =
    case
      when NCVAbdPain = 'No' then 'N'
      when NCVAbdPain = 'Yes' then 'Y'
      else NULL
    end,
  ADSSAssessmentDate = try_cast(ADSSAssessmentDate as datetime),
  ADSSAMPM2,
  NCVChills =
    case 
      when NCVChills = 'No' then 'N'
      when NCVChills = 'Yes' then 'Y'
      else NULL
    end,
  EbolaSympCmplnt =
    case
      when EbolaSympCmplnt = 'No' then 'N'
      when EbolaSympCmplnt = 'Yes' then 'Y'
      when EbolaSympCmplnt = 'Unknown' then 'U'
      else NULL
    end,
  NCVCaugh =
    case
      when NCVCaugh = 'No' then 'N'
      when NCVCaugh = 'Yes' then 'Y'
      else NULL
    end,
  NCVDiarrhea =
    case
      when NCVDiarrhea = 'No' then 'N'
      when NCVDiarrhea = 'Yes' then 'Y'
      else NULL
    end,
  NCVNSAID =
    case
      when NCVNSAID = 'No' then 'N'
      when NCVNSAID = 'Yes' then 'Y'
      else NULL
    end,
  NCVHeadache =
    case
      when NCVHeadache = 'No' then 'N'
      when NCVHeadache = 'Yes' then 'Y'
      else NULL
    end,
  NCVServiceDet,
  ADSSMeasTempF,
  NCVMuscle =
    case
      when NCVMuscle = 'No' then 'N'
      when NCVMuscle = 'Yes' then 'Y'
      else NULL
    end,
  NCVOther,
  NCVSOB =
    case
      when NCVSOB = 'No' then 'N'
      when NCVSOB = 'Yes' then 'Y'
      else NULL
    end,
  NCVSoreThroat =
    case
      when NCVSoreThroat = 'No' then 'N'
      when NCVSoreThroat = 'Yes' then 'Y'
      else NULL
    end,
  NCVServiceNeeds =
    case
      when NCVServiceNeeds = 'No' then 'N'
      when NCVServiceNeeds = 'Yes' then 'Y'
      else NULL
    end,
  EbolaSympSymptomatic =
    case
      when EbolaSympSymptomatic = 'No' then 'N'
      when EbolaSympSymptomatic = 'Yes' then 'Y'
      when EbolaSympSymptomatic = 'Unknown' then 'U'
      else NULL
    end,
  NCVVomiting =
    case
      when NCVVomiting = 'No' then 'N'
      when NCVVomiting = 'Yes' then 'Y'
      else NULL
    end,
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
  (select  
      UDF.RECORD_ID,
      UDF.FORM_INSTANCE_ID,
      UDF.FORM_NAME,
      UDF.FORM_DESCRIPTION,
      UDF.FORM_CREATEDATE,
      UDF.SECTION_INSTANCE_ID,
      UDF.FIELD_DEF_DR,
      FIELD_VALUE,
      P.PER_ClientID,
      I.PR_PHTYPE,
      I.PR_DISEASE,
      I.PR_INCIDENTID,
      I.PR_DISTRICT
    from    
      dbo.COVID_UDF_DATA as UDF with (nolock)
      inner join 
      dbo.COVID_INCIDENT as I with (nolock)
      ON 
        UDF.RECORD_ID = I.PR_ROWID
      inner join 
      dbo.COVID_PERSON as P with (nolock)
      on 
        P.PER_ROWID = I.PR_PersonDR
    where
      UDF.SECTION_DEF_DR = 'EbolaSympV05' AND 
      UDF.FORM_DEF_DR = 'EbolaV05'
) PivotData
pivot
( max(FIELD_VALUE)
  for FIELD_DEF_DR IN 
  ( NCVAbdPain,
    ADSSAssessmentDate,
    ADSSAMPM2,
    NCVChills,
    EbolaSympCmplnt,
    NCVCaugh,
    NCVDiarrhea,
    NCVNSAID,
    NCVHeadache,
    NCVServiceDet,
    ADSSMeasTempF,
    NCVMuscle,
    NCVOther,
    NCVSOB,
    NCVSoreThroat,
    NCVServiceNeeds,
    EbolaSympSymptomatic,
    NCVVomiting
  )
) PivotTable
