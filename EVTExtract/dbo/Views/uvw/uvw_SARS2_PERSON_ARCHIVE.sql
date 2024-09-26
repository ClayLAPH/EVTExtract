create view uvw_SARS2_PERSON_ARCHIVE
as
    SELECT
    PER_ClientID                       Person_ID,
    PER_LASTNAME                       Last_Name,
    PER_FIRSTNAME                      First_Name,
    PER_MIDDLENAME                     Middle_Name,
    PER_NAMESUFFIX                     Name_Suffix,
    PER_PRIMARYLANGUAGE                Primary_Language,
    PER_SSN                            SSN,
    PER_DOB                            DOB,
    PER_ETHNICITY                      Ethnicity,
    PER_STREETADDRESS                  Street_Address,
    PER_APARTMENT                      Apartment_Number,
    CASE PER_RACE
         WHEN 'Multiple Races' THEN 'Multiple Race'
         ELSE PER_RACE
    END                                Reported_Race,
    PER_CITY                           City,
    PER_STATE                          State,
    PER_ZIP                            Zip,
    PER_LATITUDE                       Latitude,
    PER_LONGITUDE                      Longitude,
    PER_ADDRESSSTANDARDIZED            Address_Standardized,
    PER_COUNTYFIPS                     County_FIPS,
    PER_COUNTY                         County,
    PER_CENSUSBLOCK                    Census_Block,
    PER_ZIPPLUS4                       Zip_Plus_4,
    PER_COUNTYOFRESIDENCE              County_of_Residence,
    PER_COUNTRY_NAME                   Country_of_Residence,
    PER_DATEOFARRIVAL                  Date_of_Arrival,
    PER_HOMEPHONE                      Home_Telephone,
    PER_CELLPHONE                      Cellular_Phone_Pager,
    PER_WORKPHONE                      Work_or_School_Telephone,
    PER_EMAIL                          E_mail,
    PER_ELECTRONICCONTACT              Other_Electronic_Contact_Information,
    PER_WORKSCHOOLLOCATION             Work_or_School_Location,
    PER_WORKSCHOOLCONTACT              Work_or_School_Contact,
    PER_SEX                            Sex,
    PER_OCCUPATIONSETTINGTYPESPECIFY   Occupation_Setting_Type_Specify,
    PER_OCCUPATION                     Occupation,
    PER_OCCUPATIONSPECIFY              Occupation_Specify,
    PER_OCCUPATIONLOCATION             Occupation_Location,
    PER_ROWID
FROM
    dbo.SARS2_PERSON_ARCHIVE
union all

SELECT
    PER_ClientID                       Person_ID,
    PER_LASTNAME                       Last_Name,
    PER_FIRSTNAME                      First_Name,
    PER_MIDDLENAME                     Middle_Name,
    PER_NAMESUFFIX                     Name_Suffix,
    PER_PRIMARYLANGUAGE                Primary_Language,
    PER_SSN                            SSN,
    PER_DOB                            DOB,
    PER_ETHNICITY                      Ethnicity,
    PER_STREETADDRESS                  Street_Address,
    PER_APARTMENT                      Apartment_Number,
    CASE PER_RACE
         WHEN 'Multiple Races' THEN 'Multiple Race'
         ELSE PER_RACE
    END                                Reported_Race,
    PER_CITY                           City,
    PER_STATE                          State,
    PER_ZIP                            Zip,
    PER_LATITUDE                       Latitude,
    PER_LONGITUDE                      Longitude,
    PER_ADDRESSSTANDARDIZED            Address_Standardized,
    PER_COUNTYFIPS                     County_FIPS,
    PER_COUNTY                         County,
    PER_CENSUSBLOCK                    Census_Block,
    PER_ZIPPLUS4                       Zip_Plus_4,
    PER_COUNTYOFRESIDENCE              County_of_Residence,
    PER_COUNTRY_NAME                   Country_of_Residence,
    PER_DATEOFARRIVAL                  Date_of_Arrival,
    PER_HOMEPHONE                      Home_Telephone,
    PER_CELLPHONE                      Cellular_Phone_Pager,
    PER_WORKPHONE                      Work_or_School_Telephone,
    PER_EMAIL                          E_mail,
    PER_ELECTRONICCONTACT              Other_Electronic_Contact_Information,
    PER_WORKSCHOOLLOCATION             Work_or_School_Location,
    PER_WORKSCHOOLCONTACT              Work_or_School_Contact,
    PER_SEX                            Sex,
    PER_OCCUPATIONSETTINGTYPESPECIFY   Occupation_Setting_Type_Specify,
    PER_OCCUPATION                     Occupation,
    PER_OCCUPATIONSPECIFY              Occupation_Specify,
    PER_OCCUPATIONLOCATION             Occupation_Location,
    PER_ROWID
FROM
    dbo.SARS2_PERSON_ARCHIVE2
