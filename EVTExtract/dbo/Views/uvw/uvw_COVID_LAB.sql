create view dbo.uvw_COVID_LAB as
select 
  incident.PR_INCIDENTID IncidentID, 
  lab.LabReportID LabReportID, 
  lab.PHRECORDID PHRECORDID, 
  lab.ACCESSIONNUMBER ACCESSIONNUMBER, 
  lab.HL7FILENAME HL7FILENAME, 
  lab.ABNORMALFLAG ABNORMALFLAG,
  lab.IMPORTSTATUS IMPORTSTATUS, 
  case
    when lab.ISFROMHL7 = 0 then 'False'
    when lab.ISFROMHL7 = 1 then 'True'
    else null 
  end  ISFROMHL7, 
  case
    when lab.ORDERSTATUS = 'A' then 'Some, but not all, results available'
    when lab.ORDERSTATUS = 'C' then 'Correction to results'
    when lab.ORDERSTATUS = 'F' then 'Final results; results stored and verified. Can only be changed with a corrected result'
    when lab.ORDERSTATUS = 'P' then 'Preliminary: A verified early result is available, final results not yet obtained'
    when lab.ORDERSTATUS = 'U' then 'Results status change to Final without re-transmitting results already sent as preliminary.'
    when lab.ORDERSTATUS = 'X' then 'No results available; Order canceled'
    else lab.ORDERSTATUS 
  end ORDERRESULTSTATUS, 
  case
    when lab.LOCALORGANISMCODE = '' then lab.LOCALORGANISMCODETEXT
    when lab.LOCALORGANISMCODE IS null then lab.LOCALORGANISMCODETEXT
    else lab.LOCALORGANISMCODE
  end LOCALORGANISMCODE, 
  case
    when lab.LOCALORGANISMDESCRIPTION = '' then lab.LOCALORGANISMDESCRIPTIONTEXT
    when lab.LOCALORGANISMDESCRIPTION IS null then lab.LOCALORGANISMDESCRIPTIONTEXT
    else lab.LOCALORGANISMDESCRIPTION
  end LOCALORGANISMDESCRIPTION, 
  lab.LOCALTESTCODE LOCALTESTCODE, 
  lab.LOCALTESTDESCRIPTION LOCALTESTDESCRIPTION, 
  lab.NOTES NOTES, 
  lab.ORGANISMCODE ORGANISMCODE, 
  lab.ORGANISMDESCRIPTION ORGANISMDESCRIPTION, 
  lab.PATIENTNAME PATIENTNAME, 
  lab.PERFORMINGFACILITYID PERFORMINGFACILITYID, 
  lab.PERSONVERIFIEDRESULT PERSONVERIFIEDRESULT, 
  lab.PFGEPATTERN1ST PFGEPATTERN1ST, 
  lab.PFGEPATTERN2ND PFGEPATTERN2ND, 
  lab.REFERENCERANGE REFERENCERANGE, 
  lab.RESULTDATE RESULTDATE, 
  case
    when lab.RESULTSTATUS = 'P' then 'Preliminary: A verified early result is available, final results not yet obtained'
    when lab.RESULTSTATUS = 'C' then 'Correction to results'
    when lab.RESULTSTATUS = 'F' then 'Final results; results stored and verified. Can only be changed with a corrected result'
    else lab.RESULTSTATUS 
  end OBSERVATIONRESULTSTATUS, 
  lab.RESULTUNIT UNIT, 
  lab.RESULTVALUE RESULT, 
  lab.SEROGROUP SEROGROUP, 
  lab.SEROLOGY SEROLOGY, 
  lab.SEROTYPE SEROTYPE, 
  lab.SPECIES SPECIES, 
  lab.SPECBODYSITE SPECBODYSITE, 
  lab.SPECCOLLECTEDDATE SPECCOLLECTEDDATE, 
  case
    when lab.SPECIMENSOURCE IS null then lab.SPECIMENSOURCETEXT
    else lab.SPECIMENSOURCE
  end SPECIMENSOURCE, 
  lab.SPECRECEIVEDDATE SPECRECEIVEDDATE, 
  lab.TESTCODE TESTCODE, 
  lab.TESTDESCRIPTION RESULTEDTEXT, 
  lab.DILR_StatusCode DILR_StatusCode, 
  lab.PROVIDERNAME PROVIDERNAME, 
  lab.PROVIDERID PROVIDERID, 
  lab.PROVIDERADDRESS PROVIDERADDRESS, 
  lab.PROVIDERCITY PROVIDERCity, 
  lab.PROVIDERSTATE PROVIDERState, 
  lab.PROVIDERCOUNTY PROVIDERCounty, 
  lab.PROVIDERZIP PROVIDERZip, 
  lab.PROVIDERPHONE PROVIDERPHONE, 
  lab.PROVIDEREMAIL PROVIDEREMAIL, 
  lab.PROVIDERFAX PROVIDERFAX, 
  lab.FACILITYNAME FACILITYNAME, 
  lab.FACILITYADDRESS FACILITYADDRESS, 
  lab.FACILITYCITY FACILITYCity, 
  lab.FACILITYSTATE FACILITYState, 
  lab.FACILITYCOUNTY FACILITYCounty, 
  lab.FACILITYZIP FACILITYZip, 
  lab.FACILITYPHONE FACILITYPHONE, 
  lab.PLACERORDERNO PLACERORDERNO, 
  lab.FACILITYEMAIL FACILITYEMAIL, 
  lab.FACILITYID FACILITYID, 
  lab.EXTENDEDRESULTVALUE EXTENDEDRESULTVALUE, 
  lab.ORGANISMCODINGSYSTEM ORGANISMCODINGSYSTEM, 
  case
    when lab.RESULTEDORGANISM = '193213' then 'Positive (qualifier value)'
    when lab.RESULTEDORGANISM = '315017' then 'Detected (qualifier value)'
    else lab.RESULTEDORGANISM
  end RESULTEDORGANISM, 
  lab.RESULTTEXT RESULTTEXT,
  lab.LABNAME,
  lab.CLIA,
  lab.LABADDR1,
  lab.LABADDR2,
  lab.LABADDR3,
  lab.HL7TimestampOfMessage,
  lab.TimestampMessageReceived,
  lab.RELEVANTCLINICALINFORMATION,
  lab.REASONFORSTUDY
from 
  dbo.COVID_LAB AS lab with (nolock) 
  inner join
  dbo.COVID_INCIDENT AS incident with (nolock)
  on 
    lab.IncidentIDInt = incident.PR_INCIDENTID


