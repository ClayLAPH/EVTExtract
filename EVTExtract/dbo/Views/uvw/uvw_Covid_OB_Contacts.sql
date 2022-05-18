create view dbo.uvw_COVID_OB_Contacts as
select  
  row_number() over (partition by linked.IncidentID order by outbreak.OUTB_OutbreakNumber) [Count],
  linked.LinkedPatientContacts                                                             Contact_Name, 
  linked.IncidentID                                                                        Case_Incident_ID, 
  outbreak.OUTB_OutbreakNumber                                                             Outbreak_Number, 
  outbreak.OUTB_OutbreakType                                                               Outbreak_Type, 
  outbreak.OUTB_OutbreakLocation                                                           Outbreak_Location, 
  outbreak.OUTB_LOCATIONTYPE                                                               Outbreak_Location_Type, 
  case
    when outbreak.OUTB_LOCATIONTYPE in ('Acute Care Hospital','Hospital') then 1
    when outbreak.OUTB_LOCATIONTYPE = 'Assisted Living' then 2
    when outbreak.OUTB_LOCATIONTYPE in ('Congregate Living Facilities (CLHF)') then 3
    when outbreak.OUTB_LOCATIONTYPE in ('Jail', 'Correctional Facility', 'Juvenile Detention Facility') then 4
    when outbreak.OUTB_LOCATIONTYPE in ('Group Home') then 5
    when outbreak.OUTB_LOCATIONTYPE in ('Homeless Shelter','Homeless Encampment') then 6
    when outbreak.OUTB_LOCATIONTYPE in ('Homeless Hygiene Center') then 7
    when outbreak.OUTB_LOCATIONTYPE in ('Intermediate Care Facility/Individuals with Intellectual Disability (ICF-IID)') then 8
    when outbreak.OUTB_LOCATIONTYPE in ('Skilled Nursing Facility (SNF)') then 9
    when outbreak.OUTB_LOCATIONTYPE in ('Health Care Facility') then 10
    when outbreak.OUTB_LOCATIONTYPE in ('Dialysis Center') then 11
    else 12
  end                                                                                      Outbreak_Location_Type2, 
  outbreak.OUTB_LOCATIONADDRESS_PLUS                                                       Outbreak_Location_Address, 
  outbreak.OUTB_LOCCOUNTY                                                                  Outbreak_Location_County, 
  outbreak.OUTB_LOCJURISDICTION                                                            Outbreak_Location_District, 
  outbreak.OUTB_ProcessStatus                                                              Outbreak_Process_Status, 
  outbreak.OUTB_ResolutionStatus                                                           Outbreak_Resolution_Status, 
  try_convert(datetime2,outbreak.OUTB_DateCreated)                                         Outbreak_Date_Created, 
  try_convert(datetime2,outbreak.OUTB_DateofOnset)                                         Outbreak_Date_of_Onset, 
  try_convert(datetime2,outbreak.OUTB_DateClosed)                                          Outbreak_Date_Closed
from    
  dbo.COVID_OUTBREAK_LINKED_CONTACT linked with (nolock)
  inner join
  dbo.COVID_OUTBREAK outbreak with (nolock)
  on 
    linked.[dvob_rowid] = outbreak.[OUTB_RowID]

