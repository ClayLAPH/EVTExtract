﻿create view dbo.SARS2_LAB_COMBINED as
select
  IncidentID, IncidentIDInt, PHRECORDID, LabReportID, ACCESSIONNUMBER, HL7FILENAME, ABNORMALFLAG, IMPORTSTATUS, ISFROMHL7, LABRESULTSTATUS, ORDERSTATUS, LOCALORGANISMCODE, 
  LOCALORGANISMDESCRIPTION, LOCALTESTCODE, LOCALTESTDESCRIPTION, NOTES, ORGANISMCODE, ORGANISMDESCRIPTION, PATIENTNAME, PERFORMINGFACILITYID, PERSONVERIFIEDRESULT, 
  PFGEPATTERN1ST, PFGEPATTERN2ND, REFERENCERANGE, RESULTDATE, RESULTSTATUS, RESULTUNIT, RESULTVALUE, SEROGROUP, SEROLOGY, SEROTYPE, SPECIES, SPECBODYSITE, SPECCOLLECTEDDATE, 
  SPECIMENSOURCE, SPECRECEIVEDDATE, TESTCODE, TESTDESCRIPTION, DILR_StatusCode, PROVIDERNAME, PROVIDERID, PROVIDERADDRESS, PROVIDERCITY, PROVIDERSTATE, PROVIDERCOUNTY, 
  PROVIDERZIP, PROVIDERPHONE, PROVIDEREMAIL, PROVIDERFAX, FACILITYNAME, FACILITYADDRESS, FACILITYCITY, FACILITYSTATE, FACILITYCOUNTY, FACILITYZIP, FACILITYPHONE, PLACERORDERNO, 
  FACILITYEMAIL, FACILITYID, EXTENDEDRESULTVALUE, TESTCODINGSYSTEM, ORGANISMCODINGSYSTEM, RESULTEDORGANISM, RESULTTEXT, SPECIMENSOURCETEXT, LOCALORGANISMDESCRIPTIONTEXT, 
  LOCALORGANISMCODETEXT, RELEVANTCLINICALINFORMATION, REASONFORSTUDY, LABNAME, CLIA, LABADDR1, LABADDR2, LABADDR3, HL7TimestampOfMessage, TimestampMessageReceived
from dbo.SARS2_LAB_ARCHIVE
union all
select
  IncidentID, IncidentIDInt, PHRECORDID, LabReportID, ACCESSIONNUMBER, HL7FILENAME, ABNORMALFLAG, IMPORTSTATUS, ISFROMHL7, LABRESULTSTATUS, ORDERSTATUS, LOCALORGANISMCODE, 
  LOCALORGANISMDESCRIPTION, LOCALTESTCODE, LOCALTESTDESCRIPTION, NOTES, ORGANISMCODE, ORGANISMDESCRIPTION, PATIENTNAME, PERFORMINGFACILITYID, PERSONVERIFIEDRESULT, 
  PFGEPATTERN1ST, PFGEPATTERN2ND, REFERENCERANGE, RESULTDATE, RESULTSTATUS, RESULTUNIT, RESULTVALUE, SEROGROUP, SEROLOGY, SEROTYPE, SPECIES, SPECBODYSITE, SPECCOLLECTEDDATE, 
  SPECIMENSOURCE, SPECRECEIVEDDATE, TESTCODE, TESTDESCRIPTION, DILR_StatusCode, PROVIDERNAME, PROVIDERID, PROVIDERADDRESS, PROVIDERCITY, PROVIDERSTATE, PROVIDERCOUNTY, 
  PROVIDERZIP, PROVIDERPHONE, PROVIDEREMAIL, PROVIDERFAX, FACILITYNAME, FACILITYADDRESS, FACILITYCITY, FACILITYSTATE, FACILITYCOUNTY, FACILITYZIP, FACILITYPHONE, PLACERORDERNO, 
  FACILITYEMAIL, FACILITYID, EXTENDEDRESULTVALUE, TESTCODINGSYSTEM, ORGANISMCODINGSYSTEM, RESULTEDORGANISM, RESULTTEXT, SPECIMENSOURCETEXT, LOCALORGANISMDESCRIPTIONTEXT, 
  LOCALORGANISMCODETEXT, RELEVANTCLINICALINFORMATION, REASONFORSTUDY, LABNAME, CLIA, LABADDR1, LABADDR2, LABADDR3, HL7TimestampOfMessage, TimestampMessageReceived
from dbo.SARS2_LAB