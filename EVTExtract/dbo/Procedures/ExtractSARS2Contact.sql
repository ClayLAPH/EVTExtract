create procedure dbo.ExtractSARS2Contact as
begin

  set nocount on;
  --set transaction isolation level snapshot

  declare @run nvarchar(max) = 'SARS2_CONTACT-' + convert(nvarchar,next value for dbo.InstanceSequence);
  declare @status nvarchar(max) = @run + N' starts';
  declare @rows int;

  execute dbo.SetProcessingStatus @status;
  begin try

    truncate table dbo.SARS2_CONTACT;

    insert dbo.SARS2_CONTACT 
    (       
      DIID, CONTACTID, INSTANCEID, RECORDTYPE, RLENT_FIRSTNAME, RLENT_LASTNAME, RLENT_MIDDLEINITIAL, RLENT_NAMESUFFIX, RLENT_AGE, RLENT_DOB, RLENT_SEX, RLENT_CONTACTTYPE, RLENT_DATESOFCONTACT, RLENT_STREETADDRESS, RLENT_APARTMENT, RLENT_CITY, RLENT_ZIP, RLENT_PHONE, RLENT_DISTRICT, RLENT_PROPHYLAXISMEDICATION, RLENT_INVESTIGATORDR, RLENT_EXPEVENTDR, RLENT_EXPEVENT, RLENT_PRIORITYDR, RLENT_CLUSTERID, RLENT_STATUSDR, FOLDERID, RLENT_ELECTRONICCONTACT, RLENT_EMAIL, RLENT_STATE, RLENT_RACE, RLENT_PersonalRecordDR, RLENT_PersonalRecordID, RLENT_PersonalRecordType, RLENT_ContactInvestigationLinkedIncidentDR, RLENT_ContactInvestigationLinkedIncidentID
    )
    select 
      DIID, CONTACTID, INSTANCEID, RECORDTYPE, RLENT_FIRSTNAME, RLENT_LASTNAME, RLENT_MIDDLEINITIAL, RLENT_NAMESUFFIX, RLENT_AGE, RLENT_DOB, RLENT_SEX, RLENT_CONTACTTYPE, RLENT_DATESOFCONTACT, RLENT_STREETADDRESS, RLENT_APARTMENT, RLENT_CITY, RLENT_ZIP, RLENT_PHONE, RLENT_DISTRICT, RLENT_PROPHYLAXISMEDICATION, RLENT_INVESTIGATORDR, RLENT_EXPEVENTDR, RLENT_EXPEVENT, RLENT_PRIORITYDR, RLENT_CLUSTERID, RLENT_STATUSDR, FOLDERID, RLENT_ELECTRONICCONTACT, RLENT_EMAIL, RLENT_STATE, RLENT_RACE, RLENT_PersonalRecordDR, RLENT_PersonalRecordID, RLENT_PersonalRecordType, RLENT_ContactInvestigationLinkedIncidentDR, RLENT_ContactInvestigationLinkedIncidentID
    from 
      internals.Contacts c 
    where 
      c.DIID in
      ( select 
          pr.DVPR_RowID 
        from  
          [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr with (nolock)
        where 
          pr.DVPR_DiseaseCode_ID = 544041 )
    option( recompile );


    select @rows = @@rowcount, @status = @run + ' ends';
    execute dbo.SetProcessingStatus @status, @rows;

    --execute dbo.DisableOrRebuildNonclusteredIndexes 'rebuild', 'dbo', 'SARS2_CONTACT';
   
  end try
  begin catch
    select  @status = ' error: ' + error_message();
    execute dbo.SetProcessingStatus @status;
  end catch


  return 0;

end
