﻿create view dbo.UNKNOWN_RESPIRATORY_OUTBREAK as 
select 
  OUTB_RowID, 
  OUTB_Legacy_RowID, 
  OUTB_Disease, 
  OUTB_OutbreakNumber, 
  OUTB_IsHealthFacilityOutbreak, 
  OUTB_OutbreakLocation, 
  OUTB_District, 
  OUTB_DateofOnset, 
  OUTB_DateCreated, 
  OUTB_DateClosed, 
  OUTB_ProcessStatus, 
  OUTB_ResolutionStatus, 
  OUTB_Notes, 
  OUTB_OutbreakType, 
  OUTB_OUTBREAKID, 
  OUTB_COUNT, 
  OUTB_USERDR, 
  OUTB_HEALTHFACILITYCODE_DR, 
  OUTB_DISEASECODE_DR, 
  OUTB_DISSHORTNAME, 
  OUTB_LOCATIONDR, 
  OUTB_DISTRICTCODE_DR, 
  OUTB_SPACODE_DR, 
  OUTB_OUTBREAKTYPECODE_DR, 
  OUTB_PROCESSSTATUSCODE_DR, 
  OUTB_RESOLUTIONSTATUSCODE_DR, 
  OUTB_DATESUBMITTED, 
  OUTB_DGRPDR, 
  OUTB_USERNAME, 
  OUTB_ISHEALTHFACILITY, 
  OUTB_LOCATIONTYPE, 
  OUTB_LOCATIONADDRESS, 
  OUTB_LOCATIONPHONE, 
  OUTB_NURSEINVESTIGATOR, 
  'not found in source' [OUTB_NURSEINVESTIGATORDR], 
  [OUTB_LOCATIONEMAIL], 
  [OUTB_LOCATIONPRIMARYCONTACT], 
  [OUTB_LOCCOUNTY], 
  [OUTB_LOCJURISDICTION], 
  [OUTB_LOCATIONTYPEDR], 
  [OUTB_PRIORITY], 
  'not found in source' [OUTB_DISTRICTNUMBER], 
  'not found in source' [OUTB_LOCATIONCENSUSTRACT], 
  'not found in source' [OUTB_LOCATIONCENSUSBLOCK], 
  'not found in source' [OUTB_LOCATIONCOUNTYFIPS], 
  'not found in source' [OUTB_LOCATIONLATITUDE], 
  'not found in source' [OUTB_LOCATIONLONGITUDE], 
  'not found in source' [OUTB_LOCATIONDISTRICTNUMBER], 
  OUTB_LOCATIONADDRESS_PLUS, 
  Patients_Linked_to_Outbreak, 
  All_Contacts_Linked_to_Outbreak, 
  Incident_Contacts_Linked_to_Outbreak, 
  Contact_Investigations_Linked_to_Outbreak 
from 
  [$(PRD_APHIM_UODS)].covid.UNKNOWN_RESPIRATORY_OUTBREAK;
