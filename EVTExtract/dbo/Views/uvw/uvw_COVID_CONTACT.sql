create view dbo.uvw_COVID_CONTACT as
select
  DIID DIID, 
  CONTACTID ContactID, 
  INSTANCEID IncidentID, 
  RLENT_FIRSTNAME RLENT_FirstName, 
  RLENT_LASTNAME RLENT_LastName, 
  RLENT_MIDDLEINITIAL RLENT_MiddleInitial, 
  RLENT_NAMESUFFIX RLENT_NameSuffix, 
  RLENT_AGE RLENT_Age,
  RLENT_DOB RLENT_DOB, 
  RLENT_SEX RLENT_Sex, 
  RLENT_CONTACTTYPE RLENT_ContactType, 
  RLENT_DATESOFCONTACT RLENT_DatesOfContact, 
  RLENT_STREETADDRESS RLENT_StreetAddress, 
  RLENT_APARTMENT RLENT_Apartment, 
  RLENT_CITY RLENT_City, 
  RLENT_ZIP RLENT_Zip, 
  RLENT_PHONE RLENT_Phone, 
  RLENT_DISTRICT RLENT_District, 
  RLENT_PROPHYLAXISMEDICATION RLENT_ProphylaxisMedication, 
  RLENT_INVESTIGATORDR RLENT_InvestigatorDR, 
  convert(char,RLENT_EXPEVENTDR) RLENT_ExpEventDR, 
  RLENT_PRIORITYDR RLENT_PriorityDR, 
  RLENT_CLUSTERID RLENT_ClusterID, 
  RLENT_STATUSDR RLENT_StatusDR, 
  RLENT_ELECTRONICCONTACT RLENT_ELECTRONICCONTACT, 
  RLENT_EMAIL RLENT_EMAIL, 
  RLENT_STATE RLENT_State, 
  case when RLENT_RACE = 'Multiple Races' then 'Multiple Race' else RLENT_RACE end RLENT_Race, 
  RLENT_PERSONALRECORDDR RLENT_PersonalRecordID, 
  try_convert(numeric,RLENT_PERSONALRECORDID) RLENT_PersonalRecordIncidentID
from
  dbo.COVID_CONTACT with (nolock)
