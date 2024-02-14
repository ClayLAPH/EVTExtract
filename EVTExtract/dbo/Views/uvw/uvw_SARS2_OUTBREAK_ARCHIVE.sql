create view dbo.uvw_SARS2_OUTBREAK_ARCHIVE as
select
  OUTB_RowID                                                 Row_ID,
  OUTB_OUTBREAKID                                          Outbreak_ID,
  OUTB_COUNT                                               Number_of_Cases,
  OUTB_OutbreakNumber                                      Outbreak_Number,
  OUTB_Disease                                             Disease,
  OUTB_DISSHORTNAME                                        Disease_Short_Name,
  OUTB_ISHEALTHFACILITY                                    Is_Health_Facility,
  OUTB_OutbreakLocation                                    Location,
  OUTB_LOCATIONTYPE                                        Location_Type,
  OUTB_LOCATIONADDRESS                                     Location_Address,
  OUTB_LOCATIONPHONE                                       Location_Phone,
  OUTB_LOCATIONEMAIL                                       Location_E_mail,
  OUTB_LOCATIONPRIMARYCONTACT                              Location_Primary_Contact,
  OUTB_LOCCOUNTY                                           Location_County,
  OUTB_LOCJURISDICTION                                     Location_District,
  try_convert(datetime,OUTB_DateofOnset)                   Date_of_Onset,
  try_convert(datetime,OUTB_DateCreated)                   Date_Created,
  left(try_convert(varchar(16),OUTB_DateCreated,14),8)     Time_Created, 
  try_convert(datetime,OUTB_DateClosed)                    Date_Closed,
  OUTB_District                                            District,
  OUTB_NurseInvestigator                                   Investigator,
  OUTB_PRIORITY                                            Priority,
  OUTB_ProcessStatus                                       Process_Status,
  OUTB_ResolutionStatus                                    Resolution_Status,
  OUTB_OutbreakType                                        Outbreak_Type,
  OUTB_Notes                                               Notes,
  OUTB_IsHealthFacilityOutbreak                            OUTB_IsHealthFacilityOutbreak,
  ArchiveVersion                                           = 1
from    
  dbo.SARS2_OUTBREAK_ARCHIVE with (nolock)

