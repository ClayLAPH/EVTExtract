create view dbo.uvw_NCOVPUISx as
select 
  NCOVPUISx1CongSet=
    case NCOVPUISx1CongSet
      when 'Federal correctional facility (including Immigration and Customs [ICE] detention centers)' then 'FCOR'
      when 'Group Home / Board and Care' then 'GRPH'
      when 'Hospital-based facility, e.g. long-term acute care hospital' then 'HBF'
      when 'Homeless shelter' then 'HMLS'
      when 'County correctional facility (jail)' then 'JAIL'
      when 'Other (specify)' then 'OTH'
      when 'Residential facility, e.g. assisted/senior living facility, memory care facility' then 'RES'
      when 'State correctional facility (prison)' then 'SCOR'
      when 'Skilled nursing facility' then 'SNF'
      when 'Mental health, alcohol, or drug treatment facility' then 'TRTF'
      when 'Homeless  encampment' then 'HMLE'
      else NULL
    end, 
  NCOVPUISx1CongSetName, 
  NCOVPUISx1CongSetType, 
  NCOVPUISx2CongSet =
    case NCOVPUISx2CongSet
      when 'Federal correctional facility (including Immigration and Customs [ICE] detention centers)' then 'FCOR'
      when 'Group Home / Board and Care' then 'GRPH'
      when 'Hospital-based facility, e.g. long-term acute care hospital' then 'HBF'
      when 'Homeless shelter' then 'HMLS'
      when 'County correctional facility (jail)' then 'JAIL'
      when 'Other (specify)' then 'OTH'
      when 'Residential facility, e.g. assisted/senior living facility, memory care facility' then 'RES'
      when 'State correctional facility (prison)' then 'SCOR'
      when 'Skilled nursing facility' then 'SNF'
      when 'Mental health, alcohol, or drug treatment facility' then 'TRTF'
      when 'Homeless  encampment' then 'HMLE'
      else NULL
    end,
  NCOVPUISx2CongSetName, 
  NCOVPUISx2CongSetType, 
  NCOVPUISx3CongSet = 
    case NCOVPUISx3CongSet
      when 'Federal correctional facility (including Immigration and Customs [ICE] detention centers)' then 'FCOR'
      when 'Group Home / Board and Care' then 'GRPH'
      when 'Hospital-based facility, e.g. long-term acute care hospital' then 'HBF'
      when 'Homeless shelter' then 'HMLS'
      when 'County correctional facility (jail)' then 'JAIL'
      when 'Other (specify)' then 'OTH'
      when 'Residential facility, e.g. assisted/senior living facility, memory care facility' then 'RES'
      when 'State correctional facility (prison)' then 'SCOR'
      when 'Skilled nursing facility' then 'SNF'
      when 'Mental health, alcohol, or drug treatment facility' then 'TRTF'
      when 'Homeless  encampment' then 'HMLE'
      else NULL
    end, 
  NCOVPUISX3CONGSETTYPE, 
  NCOVPUISx3CongSetName, 
  NCOVPUISxAnmlExp = 
    case NCOVPUISxAnmlExp
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end,  
  NCOVPUISxARDS = 
    case NCOVPUISxARDS
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end, 
  NCOVPUISxComAcq = 
    case NCOVPUISxComAcq
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end, 
  NCOVPUISxComorbid =
    case
      when len( NCOVPUISxComorbid ) = 0 then null 
      else left( NCOVPUISxComorbid, len( NCOVPUISxComorbid ) -1 )
    end,
  NCOVPUISxComorbidOth, 
  NCOVPUISxCongSet =
    case NCOVPUISxCongSet
      when 'No' then 'N'
      when 'Unknown' then 'U'
      when 'Yes, both' then 'YB'
      when 'Yes, resident' then 'YR'
      when 'Yes, staff' then 'YS'
      else NULL
    end, 
  NCOVPUISxContCase =
    case NCOVPUISxContCase
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end, 
  NCOVPUISxContCaseContType, 
  NCOVPUISxContCaseContTypeHlth, 
  NCOVPUISxContCaseDxCntry,  
  NCOVPUISxContCaseIll= 
    case NCOVPUISxContCaseIll
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end, 
  NCOVPUISxContCaseIntl =
    case NCOVPUISxContCaseIntl
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end, 
  NCOVPUISxContCaseUS = 
    case NCOVPUISxContCaseUS
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end,
  NCOVPUISxContIllTrav = 
    case NCOVPUISxContIllTrav
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end, 
  NCOVPUISxContIllTravSpcfy, 
  NCOVPUISxContTravImpArea =
    case NCOVPUISxContTravImpArea
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end, 
  NCOVPUISxContTravImpAreaSpcfy, 
  NCOVPUISxDie =
    case NCOVPUISxDie
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end, 
  NCVDIDRF = 
    case NCVDIDRF
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end, 
  NCOVPUISxECMO =
    case NCOVPUISxECMO
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end, 
  NCOVPUISxHealthCareFac =
    case NCOVPUISxHealthCareFac
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end, 
  NCOVPUISxHealthCareFacSpcfy, 
  NCOVPUISxHlthCareWorker=
    case NCOVPUISxHlthCareWorker
        when 'No' then 'N' 
        when 'Yes' then 'Y' 
        when 'Unknown' then 'U' 
        else NULL 
    end, 
  NCOVPUISxHlthCareWorkerCarePt, 
  NCOVPUISxHlthCareWorkerLoc, 
  NCOVPUISxHospitalized = 
    case NCOVPUISxHospitalized
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end, 
  NCOVPUISxHospitalizedIso = 
    case NCOVPUISxHospitalizedIso
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end, 
  NCOVPUISxLabTest =
    case NCOVPUISxLabTest
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end, 
  NCOVPUISxOthDx =
    case NCOVPUISxOthDx
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end, 
  NCOVPUISxOthDxSpcfy, 
  NCOVPUISxPneumonia =
    case NCOVPUISxPneumonia
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end, 
  NCOVPUISxPUI, 
  NCOVPUISxPUISpcfy, 
  NCOVPUISxResImpArea =
    case NCOVPUISxResImpArea
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end, 
  NCOVPUISxRespiratoryIllness = 
    case NCOVPUISxRespiratoryIllness
      when 'No' then 'N' 
      when 'Yes' then 'Y' 
      when 'Unknown' then 'U' 
      else NULL 
    end, 
  NCOVPUISxSx =  
    case
      when len( NCOVPUISxSx ) = 0 then null
      else left( NCOVPUISxSx, len( NCOVPUISxSx ) -1 )
    end,
  NCOVPUISxSxCurStat, 
  NCOVPUISxSxOth, 
  NCOVPUISxSxStat, 
  NCOVPUISXPUIEPIXSPCFY, 
  NCOVPUISxSxStatResDt = cast(NCOVPUISxSxStatResDt as datetime), 
  NCOVPUISxTravArrDt = cast(NCOVPUISxTravArrDt as datetime), 
  NCOVPUISxTravFromDt = cast(NCOVPUISxTravFromDt as datetime), 
  NCOVPUISxTravToDt = cast(NCOVPUISxTravToDt as datetime), 
  NCVCongCity1, 
  NCVCongAddrss1, 
  NCVCongNotes1, 
  NCVCongtzip1, 
  NCVCongAddrss2, 
  NCVCongCity2, 
  NCVCongNotes2, 
  NCVCongtzip2, 
  NCVCongAddrss3, 
  NCVCongCity3, 
  NCVCongNotes3, 
  NCVCongtzip3, 
  NCVTeachLoc, 
  NCVTeach , 
  NCVDISx, 
  NCVIDLASTWORKDATEEDU, 
  NCVIDSTAFFEDUCATION, 
  NCVEDULOCATION, 
  NCVIDCoroner, 
  NCVIDCoronerCaseID, 
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
  FormCreateDateTime = convert(datetime,FORM_CREATEDATE)
from    
(
  select  
    UDF.RECORD_ID, 
    UDF.FORM_INSTANCE_ID, 
    UDF.FORM_NAME, 
    UDF.FORM_DESCRIPTION, 
    UDF.FORM_CREATEDATE, 
    UDF.SECTION_INSTANCE_ID, 
    UDF.FIELD_DEF_DR AS FIELD_DEF_DR, 
    cast(FIELD_VALUE AS varchar(max)) AS FIELD_VALUE, 
    P.PER_ClientID, 
    I.PR_PHTYPE, 
    I.PR_DISEASE, 
    I.PR_INCIDENTID, 
    I.PR_DISTRICT, 
    NCOVPUISxSx = (
      select  convert(varchar(max), UDFA.FIELD_CONCEPT_CODE_VALUE) + ', '
      from    dbo.COVID_UDF_DATA AS UDFA with (nolock)
      where   UDFA.RECORD_ID = UDF.RECORD_ID AND UDFA.[FIELD_DEF_DR]='NCOVPUISxSx'
      order by UDFA.RECORD_ID
      for xml path ('') ), 
    NCOVPUISxComorbid = (
      select  convert(varchar(max), UDFA.FIELD_CONCEPT_CODE_VALUE) + ', '
      from    dbo.COVID_UDF_DATA AS UDFA with (nolock)
      where   UDFA.RECORD_ID = UDF.RECORD_ID AND UDFA.FIELD_DEF_DR='NCOVPUISxComorbid'
      order by UDFA.RECORD_ID
      for xml path ('') )
  from    
    dbo.COVID_UDF_DATA AS UDF with (nolock) 
	  inner join 
    dbo.COVID_INCIDENT AS I with (nolock)
      on UDF.RECORD_ID = I.PR_ROWID
    inner join 
    dbo.COVID_PERSON AS P with (nolock)
      on P.PER_ROWID = I.PR_PersonDR
  where   
    UDF.SECTION_DEF_DR = 'NCOVPUISx'  AND FORM_DEF_DR = 'NCOVPUI'
) as PivotData
pivot 
(
  max(FIELD_VALUE)
  for FIELD_DEF_DR in 
  (
    NCOVPUISx1CongSet, 
    NCOVPUISx1CongSetName, 
    NCOVPUISx1CongSetType, 
    NCOVPUISx2CongSet, 
    NCOVPUISx2CongSetName, 
    NCOVPUISx2CongSetType, 
    NCOVPUISx3CongSet, 
    NCOVPUISx3CongSetName, 
    NCOVPUISX3CONGSETTYPE, 
    NCOVPUISxAnmlExp, 
    NCOVPUISxARDS, 
    NCOVPUISxComAcq, 
    NCOVPUISxComorbidOth, 
    NCOVPUISxCongSet, 
    NCOVPUISxContCase, 
    NCOVPUISxContCaseContType, 
    NCOVPUISxContCaseContTypeHlth, 
    NCOVPUISxContCaseDxCntry, 
    NCOVPUISxContCaseIll, 
    NCOVPUISxContCaseIntl, 
    NCOVPUISxContCaseUS, 
    NCOVPUISxContIllTrav, 
    NCOVPUISxContIllTravSpcfy, 
    NCOVPUISxContTravImpArea, 
    NCOVPUISxContTravImpAreaSpcfy, 
    NCOVPUISxDie, 
    NCVDIDRF,
    NCOVPUISxECMO, 
    NCOVPUISxHealthCareFac, 
    NCOVPUISxHealthCareFacSpcfy, 
    NCOVPUISxHlthCareWorker, 
    NCOVPUISxHlthCareWorkerCarePt, 
    NCOVPUISxHlthCareWorkerLoc, 
    NCOVPUISxHospitalized, 
    NCOVPUISxHospitalizedIso, 
    NCOVPUISxLabTest, 
    NCOVPUISxOthDx, 
    NCOVPUISxOthDxSpcfy, 
    NCOVPUISxPneumonia, 
    NCOVPUISxPUI, 
    NCOVPUISxPUISpcfy, 
    NCOVPUISxResImpArea, 
    NCOVPUISxRespiratoryIllness, 
    NCOVPUISxSxCurStat, 
    NCOVPUISxSxOth, 
    NCOVPUISxSxStat, 
    NCOVPUISxSxStatResDt, 
    NCOVPUISxTravArrDt, 
    NCOVPUISxTravFromDt, 
    NCOVPUISxTravToDt, 
    NCOVPUISXPUIEPIXSPCFY, 
    NCVCongCity1, 
    NCVCongAddrss1, 
    NCVCongNotes1, 
    NCVCongtzip1, 
    NCVCongAddrss2, 
    NCVCongCity2, 
    NCVCongNotes2, 
    NCVCongtzip2, 
    NCVCongAddrss3, 
    NCVCongCity3, 
    NCVCongNotes3, 
    NCVCongtzip3, 
    NCVTeachLoc, 
    NCVTeach, 
    NCVDISx, 
    NCVIDLASTWORKDATEEDU, 
    NCVIDSTAFFEDUCATION, 
    NCVEDULOCATION, 
    NCVIDCoroner, 
    NCVIDCoronerCaseID    
  )
) AS PivotTable

