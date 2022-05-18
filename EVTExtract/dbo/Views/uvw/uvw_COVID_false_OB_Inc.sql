create view dbo.uvw_COVID_false_OB_Inc as
select 
  row_number() over (partition by L.IncidentID order by O.OUTB_OutbreakNumber) Count, 
  L.IncidentID Incident_id, 
  I.PR_RESOLUTIONSTATUS Resolution_Status, 
  O.OUTB_OutbreakNumber Outbreak_Number, 
  O.OUTB_OutbreakType Outbreak_Type, 
  O.OUTB_OutbreakLocation Outbreak_Location, 
  O.OUTB_LOCATIONTYPE Outbreak_Location_Type, 
  case
    when O.OUTB_LOCATIONTYPE in ('Acute Care Hospital','Hospital') then 1
    when O.OUTB_LOCATIONTYPE = 'Assisted Living' then 2
    when O.OUTB_LOCATIONTYPE in ('Congregate Living Facilities (CLHF)') then 3
    when O.OUTB_LOCATIONTYPE in ('Jail', 'Correctional Facility', 'Juvenile Detention Facility') then 4
    when O.OUTB_LOCATIONTYPE in ('Group Home') then 5
    when O.OUTB_LOCATIONTYPE in ('Homeless Shelter','Homeless Encampment') then 6
    when O.OUTB_LOCATIONTYPE in ('Homeless Hygiene Center') then 7
    when O.OUTB_LOCATIONTYPE in ('Intermediate Care Facility/Individuals with Intellectual Disability (ICF-IID)') then 8
    when O.OUTB_LOCATIONTYPE in ('Skilled Nursing Facility (SNF)') then 9
    when O.OUTB_LOCATIONTYPE in ('Health Care Facility') then 10
    when O.OUTB_LOCATIONTYPE in ('Dialysis Center') then 11
    else 12
  end Outbreak_Location_Type2, 
  O.OUTB_LOCATIONADDRESS_PLUS Outbreak_Location_Address, 
  O.OUTB_LOCCOUNTY Outbreak_Location_County, 
  O.OUTB_LOCJURISDICTION Outbreak_Location_District,
  O.OUTB_ProcessStatus Outbreak_Process_Status, 
  O.OUTB_ResolutionStatus Outbreak_Resolution_Status, 
  try_convert(datetime,O.OUTB_DateCreated) Outbreak_Date_of_Onset, 
  try_convert(datetime,O.OUTB_DateClosed) Outbreak_Date_Closed 
from 
  dbo.COVID_OUTBREAK_LINKED_INCIDENT L with (nolock) 
  inner join 
  dbo.COVID_OUTBREAK O with (nolock)
  on 
    L.dvob_rowid = O.OUTB_RowID
  inner join 
  dbo.COVID_INCIDENT AS I with (nolock)
  on 
    L.IncidentID = I.PR_INCIDENTID
where 
  I.PR_RESOLUTIONSTATUS ='False'

