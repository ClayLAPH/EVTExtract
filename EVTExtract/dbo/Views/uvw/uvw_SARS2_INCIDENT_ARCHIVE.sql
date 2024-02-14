create view dbo.uvw_SARS2_INCIDENT_ARCHIVE as
select
  person.PER_ClientID                       Person_ID, 
  person.PER_LASTNAME                       Last_Name, 
  person.PER_FIRSTNAME                      First_Name, 
  person.PER_MIDDLENAME                     Middle_Name, 
  person.PER_NAMESUFFIX                     Name_Suffix, 
  person.PER_PRIMARYLANGUAGE                Primary_Language, 
  person.PER_SSN                            SSN, 
  person.PER_DOB                            DOB, 
  person.PER_ETHNICITY                      Ethnicity, 
  person.PER_STREETADDRESS                  Street_Address, 
  person.PER_APARTMENT                      Apartment_Number, 
  case person.PER_RACE
    when 'Multiple Races' then 'Multiple Race'
    else person.PER_RACE
  end                                       Reported_Race, 
  person.PER_CITY                           City, 
  person.PER_STATE                          State, 
  person.PER_ZIP                            Zip, 
  person.PER_LATITUDE                       Latitude, 
  person.PER_LONGITUDE                      Longitude, 
  person.PER_ADDRESSSTANDARDIZED            Address_Standardized, 
  person.PER_COUNTYFIPS                     County_FIPS, 
  person.PER_COUNTY                         County, 
  person.PER_CENSUSBLOCK                    Census_Block, 
  person.PER_ZIPPLUS4                       Zip_Plus_4, 
  person.PER_COUNTYOFRESIDENCE              County_of_Residence, 
  person.PER_COUNTRY_NAME                   Country_of_Residence, 
  person.PER_DATEOFARRIVAL                Date_of_Arrival, 
  person.PER_HOMEPHONE                      Home_Telephone, 
  person.PER_CELLPHONE                      Cellular_Phone_Pager, 
  person.PER_WORKPHONE                      Work_or_School_Telephone, 
  person.PER_EMAIL                          E_mail, 
  person.PER_ELECTRONICCONTACT              Other_Electronic_Contact_Information, 
  person.PER_WORKSCHOOLLOCATION             Work_or_School_Location, 
  person.PER_WORKSCHOOLCONTACT              Work_or_School_Contact, 
  person.PER_SEX                            Sex, 
  person.PER_OCCUPATIONSETTINGTYPESPECIFY   Occupation_Setting_Type_Specify, 
  person.PER_OCCUPATION                     Occupation, 
  person.PER_OCCUPATIONSPECIFY              Occupation_Specify, 
  person.PER_OCCUPATIONLOCATION             Occupation_Location, 
  incident.PR_PHTYPE                        Record_Type, 
  incident.PR_ROWID                         Row_ID, 
  incident.PR_PERSONDR                      Incident_Person_link, 
  incident.PR_INCIDENTID                    Incident_ID, 
  incident.PR_DISEASE                       Disease, 
  incident.PR_DISEASESHORTNAME              Disease_Short_Name, 
  incident.PR_OTHERDISEASE                  Other_Disease, 
  incident.PR_DISEASEGROUPS                 Disease_Groups, 
  incident.Age                              Age, 
  incident.PR_CENSUSTRACT                   Census_Tract, 
  incident.Country_of_Birth                 Country_of_Birth, 
  case
    when incident.PR_ISPREGNANT = 0 then 'N'
    when incident.PR_ISPREGNANT = 1 then 'Y' 
    when person.PER_SEX is not null and person.PER_SEX <> 'Male' and incident.PR_ISPREGNANT is null then 'U'
    else null
  end                                       Is_Pregnant, 
  incident.PR_EXPECTEDDELIVERYDATE          Expected_Delivery_Date, 
  incident.Marital_Status                   Marital_Status, 
  incident.Parent_or_Guardian_Name          Parent_or_Guardian_Name, 
  incident.Medical_Record_Number            Medical_Record_Number, 
  incident.Occupation_Setting_Type          Occupation_Setting_Type, 
  incident.PR_DISTRICT                      District, 
  incident.Health_District_Number           Health_District_Number, 
  incident.PR_ONSETDATE                     Onset_Date_Date_of_Contact, 
  incident.PR_PROCESSSTATUS                 Process_Status, 
  incident.Secondary_District               Secondary_District, 
  incident.PR_NURSEINVESTIGATOR             Investigator, 
  incident.PR_LABSPECIMENCOLLECTEDDATE      Lab_Specimen_Collection_Date, 
  case incident.PR_REPORTEDBYWEB
    when 0 then 'False'
    when 1 then 'True'
    else null 
  end Web_Report, 
  incident.Lab_Report                       Lab_Report, 
  incident.Type_of_Contact                  Type_of_Contact, 
  incident.PR_DATEREPORTEDBY                Date_Reported_By, 
  incident.PR_DATEOFLABREPORT               Date_of_Lab_Report, 
  incident.Diagnostic_Specimen_Types        Diagnostic_Specimen_Types, 
  incident.Priority                         Priority, 
  incident.PR_LABSPECIMENRESULTDATE         Lab_Specimen_Result_Date, 
  incident.PR_DATEOFDIAGNOSIS               Date_of_Diagnosis, 
  incident.Report_Source                    Report_Source, 
  incident.Provider_Name                    Provider_Name, 
  incident.PR_NAMEOFSUBMITTER               Submitter_Name, 
  incident.PR_DATEOFDEATH                   Date_of_Death, 
  case incident.Imported_Status
    when 819 then 'Indigenous'
    when 820 then 'International'
    when 821 then 'International/Out Of State/Other Jurisdiction (unknown)'
    when 822 then 'Other Jurisdiction'
    when 823 then 'Out Of State'
    when 824 then 'Unknown'
    else null
  end                                       Imported_Status, 
  incident.PR_LABORATORY Laboratory, 
  incident.PR_DATEINVESTIGATORRECEIVED      Date_Received, 
  incident.PR_RESOLUTIONSTATUS              Resolution_Status, 
  incident.Additional_Provider              Additional_Provider, 
  incident.Final_Disposition                Final_Disposition, 
  incident.Additional_Laboratory            Additional_Laboratory, 
  incident.Created_By                       Created_By, 
  convert(datetime,incident.PR_CREATEDATE)                  Date_Created, 
  left(convert(varchar(16),incident.PR_CREATEDATE,14),8)    Time_Created, 
  convert(datetime,incident.PR_DATESUBMITTED)               Date_Submitted, 
  left(convert(varchar(16),incident.PR_DATESUBMITTED,14),8) Time_Submitted, 
  incident.PR_TRANSMISSIONSTATUS            Transmission_Status, 
  incident.PR_EPISODEDATE                   Episode_Date, 
  incident.PR_DATESENT                      Date_Sent, 
  case incident.PR_ISINDEXCASE
    when 0 then 'False'
    when 1 then 'True'
    else null 
  end                                       Index_Case, 
  incident.PR_CLUSTERID                     Cluster_ID, 
  incident.PR_CLOSEDDATE                    Closed_Date, 
  incident.PR_LASTCDCUPDATE                 Last_CDC_Update,
  case incident.PR_ISPATIENTDIEDOFTHEILLNESS
    when 0 then 'False'
    when 1 then 'True'
    else null 
  end                                       Patient_Died_of_this_Illness, 
  incident.PR_DATEADMITTED                  Date_Admitted, 
  case incident.PR_ISPATIENTHOSPITALIZED
    when 0 then 'False'
    when 1 then 'True'
    else null 
  end                                       Patient_Hospitalized, 
  incident.PR_HOSPITAL                      Hospital, 
  incident.PR_HOSPITALDR                    Hospital_DR, 
  case incident.PR_INPATIENT
    when 0 then 'False'
    when 1 then 'True'
    else null 
  end                                       Inpatient,
  case incident.PR_OUTPATIENT
    when 0 then 'False'
    when 1 then 'True'
    else null 
  end                                       Outpatient, 
  incident.PR_DATEDISCHARGED                Date_Discharged, 
  incident.Date_Last_Edited                 Date_Last_Edited, 
  incident.Outbreak_IDs                     Outbreak_rowIDs, 
  incident.PR_NOTES                         Notes_Remarks, 
  incident.Suspected_Exposure_Types         Suspected_Exposure_Types, 
  incident.Most_Recent_Lab_Result           Most_Recent_Lab_Result, 
  incident.Most_Recent_Lab_Result_Value     Most_Recent_Lab_Result_Value, 
  incident.Lab_Report_Test_Name             Lab_Report_Test_Name, 
  incident.Lab_Report_Notes                 Lab_Report_Notes, 
  incident.ImportedBy                       ImportedBy, 
  incident.American_Indian_or_Alaska_Native American_Indian_or_Alaska_Native_Specify, 
  incident.Asian___Specify                  Asian_Specify, 
  incident.Black_or_African_American___Spec Black_or_African_American___Specify, 
  incident.Native_Hawaiian_or_Other_Pacific Native_Hawaiian_or_Other_Pacific_Islander_Specify, 
  incident.Other___Specify                  Other_Specify, 
  incident.Unknown___Specify                Unknown_Specify, 
  incident.White___Specify                  White_Specify,  
  incident.Outbreak_IDs                     Outbreak_IDs,
  ArchiveVersion                          = 1
from
  dbo.SARS2_PERSON_ARCHIVE AS person with (nolock) 
  inner join 
  dbo.SARS2_INCIDENT_ARCHIVE AS incident with (nolock)
  on 
    person.[PER_RowID] = incident.[PR_PersonDR] 
	

