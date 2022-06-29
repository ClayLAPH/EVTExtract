﻿create procedure dbo.ExtractSARS2Person
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'SARS2_PERSON',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot

  execute dbo.SetProcessingStatus @status, @name, @instance;
  begin try
    
    truncate table dbo.SARS2_PERSON;
    drop index if exists [SARS2_PERSON.PER_ROWID.Fake.PrimaryKey] on SARS2_PERSON;

    insert dbo.SARS2_PERSON
    (
      PER_ROWID, PER_LEGACY_ROWID, PER_COUNTRYOFBIRTHDR, PER_CELLPHONE, PER_DATEOFARRIVAL, PER_OCCUPATIONLOCATION, PER_OCCUPATIONSPECIFY, PER_OCCUPATIONSETTINGTYPEDR,
      PER_OCCUPATIONSETTINGTYPESPECIFY, PER_ROOTID, PER_LASTNAME, PER_FIRSTNAME, PER_MIDDLENAME, PER_SSN, PER_HOMEPHONE, PER_WORKPHONE, PER_STREETADDRESS, PER_APARTMENT,
      PER_CITY, PER_STATE, PER_STATENUMBER, PER_ZIP, PER_ClientID, PER_COUNTYOFRESIDENCE, PER_CENSUSTRACT, PER_LATITUDE, PER_LONGITUDE, PER_ADDRESSSTANDARDIZED, PER_COUNTYFIPS,
      PER_COUNTY, PER_CENSUSBLOCK, PER_ZIPPLUS4, PER_COUNTRY, PER_COUNTRY_NAME, PER_DOB, PER_SEX, PER_RACE, PER_ETHNICITY, PER_OCCUPATION, PER_SEXCODE_DR, PER_RACECODE_DR,
      PER_ETHNICITYCODE_DR, PER_OCCUPATIONCODE_DR, PER_NAMESUFFIX, PER_RECORDCREATEDBY, PER_WORKSCHOOLLOCATION, PER_WORKSCHOOLCONTACT, PER_PRIMARYLANGUAGE_DR, PER_PRIMARYLANGUAGE,
      PER_EMAIL, PER_ELECTRONICCONTACT, PER_CURRENTVERSION, PER_DATEOFDEATH, PER_PERSONSTATUS, PER_STATUSFLAG, PER_PRIMARYNATIONALITY, PER_THIRDNAME, PER_FOURTHNAME, PER_NAMEPREFIX
    )
    select 
      PER_ROWID, PER_LEGACY_ROWID, PER_COUNTRYOFBIRTHDR, PER_CELLPHONE, PER_DATEOFARRIVAL, PER_OCCUPATIONLOCATION, PER_OCCUPATIONSPECIFY, PER_OCCUPATIONSETTINGTYPEDR,
      PER_OCCUPATIONSETTINGTYPESPECIFY, PER_ROOTID, PER_LASTNAME, PER_FIRSTNAME, PER_MIDDLENAME, PER_SSN, PER_HOMEPHONE, PER_WORKPHONE, PER_STREETADDRESS, PER_APARTMENT,
      PER_CITY, PER_STATE, PER_STATENUMBER, PER_ZIP, PER_ClientID, PER_COUNTYOFRESIDENCE, PER_CENSUSTRACT, PER_LATITUDE, PER_LONGITUDE, PER_ADDRESSSTANDARDIZED, PER_COUNTYFIPS,
      PER_COUNTY, PER_CENSUSBLOCK, PER_ZIPPLUS4, PER_COUNTRY, PER_COUNTRY_NAME, PER_DOB, PER_SEX, PER_RACE, PER_ETHNICITY, PER_OCCUPATION, PER_SEXCODE_DR, PER_RACECODE_DR,
      PER_ETHNICITYCODE_DR, PER_OCCUPATIONCODE_DR, PER_NAMESUFFIX, PER_RECORDCREATEDBY, PER_WORKSCHOOLLOCATION, PER_WORKSCHOOLCONTACT, PER_PRIMARYLANGUAGE_DR, PER_PRIMARYLANGUAGE,
      PER_EMAIL, PER_ELECTRONICCONTACT, PER_CURRENTVERSION, PER_DATEOFDEATH, PER_PERSONSTATUS, PER_STATUSFLAG, PER_PRIMARYNATIONALITY, PER_THIRDNAME, PER_FOURTHNAME, PER_NAMEPREFIX
    from internals.Person with (nolock)
    where
      PER_ROWID in ( select distinct pr.DVPR_PersonDR from [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr with (nolock) where DVPR_DiseaseCode_ID = 544041 )
    option
      ( recompile, maxdop 4, use hint( 'enable_parallel_plan_preference' ) );

    select @rows = @@rowcount, @status = 'ends';

    create clustered index [SARS2_PERSON.PER_ROWID.Fake.PrimaryKey] on SARS2_PERSON( PER_ROWID );

    execute dbo.SetProcessingStatus @status, @name, @instance, @rows;
  end try
  begin catch
    select  @status = 'error', @messageText = error_message();
    execute dbo.SetProcessingStatus @status, @name, @instance, null, @messageText;
    select @hasError = 1;
  end catch

  if ( @hasError = 1 and @isRestart = 0 ) 
  begin
    waitfor delay '00:01';
    execute dbo.ExtractSARS2Person @isRestart = 1;
  end

  return 0;

end

