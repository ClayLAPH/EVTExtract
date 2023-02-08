create view dbo.uvw_NCVDICorrectionsFacilityInfo as
select
  NCVDICORStartDate     = try_cast( NCVDICORStartDate as datetime ),
  NCVDICorFacilityType2 = 
    case NCVDICorFacilityType2
      when 'federal correctional facility (including Immigration and Customs ICE detention centers)'  then 'FCOR'
      when 'county correctional facility (jail)'                                                      then 'JAIL'
      when 'state correctional facility (prison)'                                                     then 'SCOR'
      when 'county juvenile detention facility'                                                       then 'CJDF'
      when 'city correctional facility (jail)'                                                        then 'CCF'
      else null
    end, 
  NCVDIBookID, 
  NCVDIHousedCorrection = 
    case NCVDIHousedCorrection
      when 'yes, detainee (infection likely acquired at facility; in-house or recent release)'                                then 'DETAINEE' 
      when 'yes, staff (worked at facility during infectious period)'                                                         then 'STAFF'
      when 'no, infection likely community acquired (detainee) or did not work at facility during infectious period (staff)'  then 'NO_NOT_CF_ASSOC'
      when 'no, infection not associated with a correctional facility in LA County'                                           then 'NO_OOJ_FACILITY'
      else null 
    end,  
  NCVDICorFacilityType, 
  NCVDICOREndDate     = try_cast( NCVDICOREndDate as datetime ),
  NCVDICorrectFacName, 
  NCVDILastWorkDate   = try_cast( NCVDILastWorkDate as datetime ),
  NCVDICorrectNameOther,
  NCVDICORIsoBlock,
  NCVDIStaffTitle,
  NCVDICORHouseBlock, 
  NCVDIStaffCat,
  NCVDICORCaseNote,	
  DIID                = RECORD_ID,
  INSTANCEID          = PR_INCIDENTID,
  Person_ID           = PER_ClientID,
  UDSectionActID      = SECTION_INSTANCE_ID,
  RecordType          = PR_PHTYPE,
  Disease             = PR_DISEASE,
  District            = PR_DISTRICT,
  FormInstanceID      = FORM_INSTANCE_ID,
  FormName            = FORM_NAME,
  FormDescription     = FORM_DESCRIPTION,
  FormCreateDateTime  = FORM_CREATEDATE
from
(
  select  
    UDF.RECORD_ID, 
    UDF.FORM_INSTANCE_ID, 
    UDF.FORM_NAME, 
    UDF.FORM_DESCRIPTION, 
    UDF.FORM_CREATEDATE, 
    UDF.SECTION_INSTANCE_ID, 
    UDF.FIELD_DEF_DR as FIELD_DEF_DR, 
    UDF.FIELD_VALUE, 
    P.PER_ClientID, 
    I.PR_PHTYPE, 
    I.PR_DISEASE, 
    I.PR_INCIDENTID, 
    I.PR_DISTRICT
  from
    dbo.COVID_UDF_DATA as UDF with (nolock) 
	  inner join 
    dbo.COVID_INCIDENT as I with (nolock)
      on UDF.RECORD_ID = I.PR_ROWID
    inner join 
    dbo.COVID_PERSON as P with (nolock)
      on P.PER_ROWID = I.PR_PersonDR
  where   
    UDF.SECTION_DEF_DR = 'NCVDICorrectionsFacilityInfo'  AND FORM_DEF_DR = 'NCOVPUI'
) PivotData
pivot (
  max(FIELD_VALUE)
  for FIELD_DEF_DR in 
  (
    NCVDICORStartDate,
    NCVDICorFacilityType2,
    NCVDIBookID,
    NCVDIHousedCorrection,
    NCVDICorFacilityType,
    NCVDICOREndDate,
    NCVDICorrectFacName,
    NCVDILastWorkDate,
    NCVDICorrectNameOther,
    NCVDICORIsoBlock,
    NCVDIStaffTitle,
    NCVDICORHouseBlock,
    NCVDIStaffCat,
    NCVDICORCaseNote
  )
) as PivotTable
