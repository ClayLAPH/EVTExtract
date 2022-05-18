create procedure dbo.ExtractContacts
  @isRestart tinyint = 0
as
begin

  set nocount on;
  --set transaction isolation level snapshot
  declare
    @name sysname = 'COVID_CONTACT',--SARS2_CONTACT
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @covidCompleted bit = 0,
    @hasError bit = 0;
  
  execute dbo.SetProcessingStatus @status, 'COVID_CONTACT', @instance;
  execute dbo.SetProcessingStatus @status, 'SARS2_CONTACT', @instance;


  truncate table internals.AllContacts;
  truncate table internals.AllContactsExpanded;

  begin try

    insert internals.AllContacts
    select 
      DIID                                              = actCase.ID,
      CONTACTID                                         = perEntity.ID,  
      INSTANCEID                                        = convert(int,inst.extension),
      RECORDTYPE                                        =
        case actCase.metaCode 
          when 'PR_ROWID' then 'DI' 
          when 'AI_ROWID' then 'AR' 
          when 'OB_RowID' then 'OB' 
        end,
      RLENT_FIRSTNAME                                   = person.DVPER_FIRSTNAME,
      RLENT_LASTNAME                                    = person.DVPER_LASTNAME,
      RLENT_MIDDLEINITIAL                               = en.PARTMID,  
      RLENT_NAMESUFFIX                                  = en.PARTSFX,  
      RLENT_AGE                                         = age.VALUEINTEGER,  
      RLENT_DOB                                         = person.DVPER_DOB,
      RLENT_SEX                                         = sexName.FULLNAME,
      RLENT_CONTACTTYPE                                 = contactTypeName.FULLNAME,  
      RLENT_DATESOFCONTACT                              = convert(datetime, contactDate.VALUETS, 110),  
      RLENT_STREETADDRESS                               = person.DVPER_STREETADDRESS,  
      RLENT_APARTMENT                                   = person.DVPER_APARTMENT,  
      RLENT_CITY                                        = person.DVPER_CITY,  
      RLENT_ZIP                                         = person.DVPER_ZIP,  
      RLENT_PHONE                                       = person.DVPER_HOMEPHONE,  
      RLENT_DISTRICT                                    = districtName.FULLNAME,  
      RLENT_PROPHYLAXISMEDICATION                       = sbadm.TEXT,  
      RLENT_INVESTIGATORDR                              = investgName.PARTFAM + ', ' +  investgName.PARTGIV,  
      RLENT_PRIORITYDR                                  = priorityName.FULLNAME, 
      RLENT_CLUSTERID                                   = clusterAtt.VALUESTRING,  
      RLENT_STATUSDR                                    = statusName.FULLNAME,  
      FOLDERID                                          = folder.ID,
      RLENT_ELECTRONICCONTACT                           = eContact.VALUESTRING,
      RLENT_EMAIL                                       = eMail.VALUESTRING,
      RLENT_STATE                                       = person.DVPER_STATE,
      RLENT_RACE                                        = ucsRace.fullName,
      MBRID                                             = mbr.ID
    from

      ----------------- key data -------->

      [$(PRD_APHIM_UODS)].dbo.E_ENTITY                  perEntity  with (nolock)
      inner join 
      internals.DV_PERSON                               person with (nolock)  
        on  person.DVPER_ROWID = perEntity.ID  
        and person.DVPER_ISCONTACT = 1  
      inner join 
      [$(PRD_APHIM_UODS)].dbo.R_ROLE                    mbr with (nolock)  
        on  perEntity.ID = mbr.PLAYER_ID  
        and mbr.CLASSCODE = 'mbr'  
        and mbr.STATUSCODE NOT IN ('NULLIFIED', 'TERMINATED')  
      inner join 
      [$(PRD_APHIM_UODS)].dbo.E_ENTITY                  ent with (nolock)  
      on  
        mbr.SCOPER_ID = ent.ID  and 
        ent.CLASSCODE = 'ENT'  
      inner join 
      [$(PRD_APHIM_UODS)].dbo.R_ROLE                    expr with (nolock)  
      on  
        ent.ID = expr.PLAYER_ID  and 
        expr.CLASSCODE = 'expr'  
      inner join 
      [$(PRD_APHIM_UODS)].dbo.P_PARTICIPATION           ind with (nolock)  
      on  
        expr.ID = ind.ROLE_ID  and 
        ind.TYPECODE = 'ind'  
      inner join [$(PRD_APHIM_UODS)].dbo.A_Act          actCase with (nolock)  
      on  
        actCase.ID = ind.ACT_ID and  
        actCase.metaCode IN ('PR_ROWID','AI_ROWID','OB_RowID') and 
        actCase.statusCode IN ('ACTIVE','COMPLETED')
      inner join 
      [$(PRD_APHIM_UODS)].dbo.T_InstanceIdentifier      inst with (nolock)              
      on 
        inst.Act_ID=actCase.ID and 
        (
          inst.[root] LIKE '2.16.840.1.113883.3.33.4.2.2.11.1%' OR 
          inst.[root] LIKE '2.16.840.1.113883.3.33.4.2.2.11.8%' OR 
          inst.[root] LIKE '2.16.840.1.113883.3.33.4.2.2.11.7%'
        )

      ------------ low calorie joins------>
      left outer join
      [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET          ucsRace with (nolock)
      on
        person.DVPER_RaceCode_ID = ucsRace.ID  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.P_PARTICIPATION           part with (nolock)  
      on  
        mbr.ID = part.ROLE_ID and 
        part.TYPECODE = 'SBJ'  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.A_ACT                     folder with (nolock)  
      on  
        part.ACT_ID = folder.ID  and 
        folder.CLASSCODE = 'folder'  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET          folderExpr with (nolock) 
      on  
        folder.CODE_ID=folderExpr.ID and 
        folderExpr.CONCEPTCODE = 'expr'  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.A_ACT                     sbadm with (nolock)  
      on  
        folder.ID = sbadm.ACT_PARENT_ID and 
        sbadm.CLASSCODE = 'sbadm'  and 
        sbadm.METACODE = 'RLENT_PROPHYLAXISMEDICATION'  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.T_ENTITYNAME              en with (nolock)  
      on  
        person.DVPER_ROWID = en.ENTITY_ID  and 
        en.USECODE = 'L'  
      left outer join [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE age with (nolock)  
      on  
        perEntity.ID = age.ENTITY_ID 
        and age.NAME = 'PER_AGE'  and 
        age.TYPE = 'INT'
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               statusAtt with (nolock)  
      on  
        folder.ID = statusAtt.ACT_ID  and 
        statusAtt.NAME = 'RLENT_StatusDR'  and 
        statusAtt.TYPE = 'CV'
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               districtAtt with (nolock)  
      on  
        folder.ID = districtAtt.ACT_ID  and 
        districtAtt.NAME = 'RLENT_DistrictDR'  and 
        districtAtt.TYPE = 'CV'
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               clusterAtt with (nolock)  
      on  
        folder.ID = clusterAtt.ACT_ID  and 
        clusterAtt.NAME = 'RLENT_ClusterID'  and 
        clusterAtt.TYPE = 'ST'
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               priorDR with (nolock) 
      on 
        mbr.ID=priorDR.Role_ID and 
        priorDR.NAME='RLENT_Priority' 
        and priorDR.TYPE='CV'
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET          priorityName with (nolock) 
      on 
        priorDR.ValueCode_ID=priorityName.ID  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET          sexName with (nolock)  
      on  
        person.DVPER_SEXCODE_ID = sexName.ID  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               contactType with (nolock)  
      on  
        mbr.ID = contactType.ROLE_ID  and 
        contactType.NAME = 'RLENT_CONTACTTYPE'  and 
        contactType.TYPE = 'CV'  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET          contactTypeName with (nolock)  
      on  
        contactType.VALUECODE_ID = contactTypeName.ID  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               contactDate with (nolock)  
      on  
        mbr.ID = contactDate.ROLE_ID  and 
        contactDate.NAME = 'RLENT_DATESOFCONTACT'  and 
        contactDate.TYPE = 'TS'  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET          districtName with (nolock) 
      on  
        districtAtt.VALUECODE_ID = districtName.ID  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.R_ROLELINK                roleLink with (nolock)  
      on  
        mbr.ID = roleLink.SOURCEROLE_ID  and 
        roleLink.METACODE = 'RLENT_INVESTIGATORDR'  and 
        roleLink.TypeCode = 'REL'  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.R_ROLE                    investg with (nolock)  
      on  
        roleLink.TARGETROLE_ID = investg.ID  and 
        investg.CLASSCODE = 'AGNT'  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.T_ENTITYNAME              investgName with (nolock)  
      on  
        investg.PLAYER_ID = investgName.ENTITY_ID                
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET          statusName with (nolock)
      on  
        statusAtt.VALUECODE_ID = statusName.ID  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               eMail with (nolock) 
      on 
        eMail.ENTITY_ID=perEntity.ID and 
        eMail.NAME='PSNID_EmailID' and 
        eMail.TYPE='ST'
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               eContact with (nolock) 
      on 
        eContact.ENTITY_ID=perEntity.ID and 
        eContact.NAME='PSNID_ElectronicContact' and 
        eContact.TYPE='ST'
    where  
      perEntity.CLASSCODE = 'PSN'
    order by
      actCase.ID, 
      perEntity.ID

    insert internals.AllContactsExpanded
    select 
      DIID, CONTACTID, INSTANCEID, RECORDTYPE, RLENT_FIRSTNAME, RLENT_LASTNAME, RLENT_MIDDLEINITIAL, RLENT_NAMESUFFIX, RLENT_AGE, RLENT_DOB, RLENT_SEX, RLENT_CONTACTTYPE, 
      RLENT_DATESOFCONTACT, RLENT_STREETADDRESS, RLENT_APARTMENT, RLENT_CITY, RLENT_ZIP, RLENT_PHONE, RLENT_DISTRICT, RLENT_PROPHYLAXISMEDICATION, RLENT_INVESTIGATORDR,
      RLENT_EXPEVENTDR                                  = expact.ID,  
      RLENT_EXPEVENT                                    = locName.TRIVIALNAME,
      RLENT_PRIORITYDR, RLENT_CLUSTERID, RLENT_STATUSDR, FOLDERID, RLENT_ELECTRONICCONTACT, RLENT_EMAIL, RLENT_STATE, RLENT_RACE,
      RLENT_PersonalRecordDR                            = createdPRPart.Act_ID,
      RLENT_PersonalRecordID                            = createdPRInstanceId.extension,
      RLENT_PersonalRecordType                          = createdPRType.shortName,
      RLENT_ContactInvestigationLinkedIncidentDR        = createdPRIncident.source_ID,
      RLENT_ContactInvestigationLinkedIncidentID        = createdPRIncidentInstance.extension
    from 
      internals.AllContacts ac
    --  /* 1
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.A_ACTRELATIONSHIP         pert with (nolock)  
      on  
        ac.folderID = pert.SOURCE_ID  and 
        pert.TYPECODE = 'pert'  
      left outer join [$(PRD_APHIM_UODS)].dbo.A_ACT     inc with (nolock)  
      on  
        pert.TARGET_ID = inc.ACT_PARENT_ID  and 
        inc.CLASSCODE = 'inc'  and 
        inc.METACODE = 'DEE_ROWID'  
    --*/

    --/* 2
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.A_ACTRELATIONSHIP         actRel with (nolock) 
      on 
        actRel.SOURCE_ID= ac.folderID and 
        actRel.TypeCode='pert'
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.A_ACT                     expact with (nolock) 
      on 
        expact.ID=actRel.TARGET_ID and 
        expact.CLASSCODE='inc' and 
        expact.MOODCODE='EVN' and 
        expact.METACODE='DEE_RowID'
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.P_PARTICIPATION           expLocPart with (nolock) 
      on 
        expLocPart.ACT_ID=expact.ID and 
        expLocPart.METACODE='DEE_LaboratoryDR'
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.R_ROLE                    expLocRole with (nolock) 
      on 
        expLocRole.ID=expLocPart.ROLE_ID
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.T_ENTITYNAME              locName with (nolock)  
      on  
        expLocRole.SCOPER_ID = locName.ENTITY_ID  and 
        locName.USECODE = 'SRCH'  and 
        locName.METACODE = 'LOC_NAME'  
    --*/
    --/* 3
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.P_Participation           createdPRPart with (nolock) 
      on  
        ac.MBRID=createdPRPart.Role_ID and 
        createdPRPart.metaCode = 'RLENT_PersonalRecordDR'
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.A_Act                     createdPRDR with (nolock) 
      on  
        createdPRDR.ID=createdPRPart.Act_ID and 
        (createdPRDR.statusCode <> 'nullified')  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.T_InstanceIdentifier      createdPRInstanceId with (nolock)
      on  
        createdPRDR.ID=createdPRInstanceId.Act_ID and 
        createdPRInstanceId.root = '2.16.840.1.113883.3.33.4.2.2.11.1.0.101.1' 
        --hacked out config  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.A_PublicHealthCase        createdPRCase with (nolock) 
      on  
        createdPRDR.ID=createdPRCase.ID  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          createdPRType with (nolock) 
      on  
        createdPRType.ID=createdPRCase.phRecordTypeCode_ID  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.A_ActRelationship         createdPRIncident with (nolock) 
      on  
        createdPRDR.ID=createdPRIncident.target_ID and 
        createdPRIncident.metaCode = 'PR_IncidentDR' and 
        createdPRIncident.typeCode_OrTx = 'create INCIDENT'  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.A_Act                     createdPRIncidentDR with (nolock) 
      on  
        createdPRIncidentDR.ID=createdPRIncident.source_ID and 
        (createdPRIncidentDR.statusCode <> 'nullified')  
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.T_InstanceIdentifier      createdPRIncidentInstance with (nolock) 
      on  
        createdPRIncidentDR.ID=createdPRIncidentInstance.Act_ID and 
        createdPRIncidentInstance.root = '2.16.840.1.113883.3.33.4.2.2.11.1.0.101.1' 
    --*/
    order by
      DIID, CONTACTID;

    truncate table dbo.COVID_CONTACT;
    insert dbo.COVID_CONTACT
    (
      DIID, CONTACTID, INSTANCEID, RECORDTYPE, RLENT_FIRSTNAME, RLENT_LASTNAME, RLENT_MIDDLEINITIAL, RLENT_NAMESUFFIX, RLENT_AGE, RLENT_DOB, RLENT_SEX, RLENT_CONTACTTYPE, 
      RLENT_DATESOFCONTACT, RLENT_STREETADDRESS, RLENT_APARTMENT, RLENT_CITY, RLENT_ZIP, RLENT_PHONE, RLENT_DISTRICT, RLENT_PROPHYLAXISMEDICATION, RLENT_INVESTIGATORDR,
      RLENT_EXPEVENTDR,
      RLENT_EXPEVENT,
      RLENT_PRIORITYDR, RLENT_CLUSTERID, RLENT_STATUSDR, FOLDERID, RLENT_ELECTRONICCONTACT, RLENT_EMAIL, RLENT_STATE, RLENT_RACE,
      RLENT_PersonalRecordDR,
      RLENT_PersonalRecordID,
      RLENT_PersonalRecordType,
      RLENT_ContactInvestigationLinkedIncidentDR,
      RLENT_ContactInvestigationLinkedIncidentID
    )
    select
      DIID, CONTACTID, INSTANCEID, RECORDTYPE, RLENT_FIRSTNAME, RLENT_LASTNAME, RLENT_MIDDLEINITIAL, RLENT_NAMESUFFIX, RLENT_AGE, RLENT_DOB, RLENT_SEX, RLENT_CONTACTTYPE, 
      RLENT_DATESOFCONTACT, RLENT_STREETADDRESS, RLENT_APARTMENT, RLENT_CITY, RLENT_ZIP, RLENT_PHONE, RLENT_DISTRICT, RLENT_PROPHYLAXISMEDICATION, RLENT_INVESTIGATORDR,
      RLENT_EXPEVENTDR,
      RLENT_EXPEVENT,
      RLENT_PRIORITYDR, RLENT_CLUSTERID, RLENT_STATUSDR, FOLDERID, RLENT_ELECTRONICCONTACT, RLENT_EMAIL, RLENT_STATE, RLENT_RACE,
      RLENT_PersonalRecordDR,
      RLENT_PersonalRecordID,
      RLENT_PersonalRecordType,
      RLENT_ContactInvestigationLinkedIncidentDR,
      RLENT_ContactInvestigationLinkedIncidentID
    from 
      internals.AllContactsExpanded ace
    where
      ace.DIID in
      ( select pr.DVPR_RowID 
        from [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr with (nolock)
        where pr.DVPR_DiseaseCode_ID = 543030 )
    order by
      DIID, CONTACTID;

    select @rows = @@rowcount, @status = 'ends', @covidCompleted = 1;
    execute dbo.SetProcessingStatus @status,@name, @instance, @rows;

    select @name = 'SARS2_CONTACT';
    truncate table dbo.SARS2_CONTACT;
    insert dbo.SARS2_CONTACT
    (
      DIID, CONTACTID, INSTANCEID, RECORDTYPE, RLENT_FIRSTNAME, RLENT_LASTNAME, RLENT_MIDDLEINITIAL, RLENT_NAMESUFFIX, RLENT_AGE, RLENT_DOB, RLENT_SEX, RLENT_CONTACTTYPE, 
      RLENT_DATESOFCONTACT, RLENT_STREETADDRESS, RLENT_APARTMENT, RLENT_CITY, RLENT_ZIP, RLENT_PHONE, RLENT_DISTRICT, RLENT_PROPHYLAXISMEDICATION, RLENT_INVESTIGATORDR,
      RLENT_EXPEVENTDR,
      RLENT_EXPEVENT,
      RLENT_PRIORITYDR, RLENT_CLUSTERID, RLENT_STATUSDR, FOLDERID, RLENT_ELECTRONICCONTACT, RLENT_EMAIL, RLENT_STATE, RLENT_RACE,
      RLENT_PersonalRecordDR,
      RLENT_PersonalRecordID,
      RLENT_PersonalRecordType,
      RLENT_ContactInvestigationLinkedIncidentDR,
      RLENT_ContactInvestigationLinkedIncidentID
    )
    select
      DIID, CONTACTID, INSTANCEID, RECORDTYPE, RLENT_FIRSTNAME, RLENT_LASTNAME, RLENT_MIDDLEINITIAL, RLENT_NAMESUFFIX, RLENT_AGE, RLENT_DOB, RLENT_SEX, RLENT_CONTACTTYPE, 
      RLENT_DATESOFCONTACT, RLENT_STREETADDRESS, RLENT_APARTMENT, RLENT_CITY, RLENT_ZIP, RLENT_PHONE, RLENT_DISTRICT, RLENT_PROPHYLAXISMEDICATION, RLENT_INVESTIGATORDR,
      RLENT_EXPEVENTDR,
      RLENT_EXPEVENT,
      RLENT_PRIORITYDR, RLENT_CLUSTERID, RLENT_STATUSDR, FOLDERID, RLENT_ELECTRONICCONTACT, RLENT_EMAIL, RLENT_STATE, RLENT_RACE,
      RLENT_PersonalRecordDR,
      RLENT_PersonalRecordID,
      RLENT_PersonalRecordType,
      RLENT_ContactInvestigationLinkedIncidentDR,
      RLENT_ContactInvestigationLinkedIncidentID
    from 
      internals.AllContactsExpanded ace
    where
      ace.DIID in
      ( select pr.DVPR_RowID 
        from [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr with (nolock)
        where pr.DVPR_DiseaseCode_ID = 544041 )
    order by
      DIID, CONTACTID;

    select @rows = @@rowcount, @status =  N'ends';
    execute dbo.SetProcessingStatus @status, @name, @instance, @rows;
  end try
  begin catch
    select @messageText = error_message(), @status = 'error';
    if ( @covidCompleted = 0 )
    begin
      execute dbo.SetProcessingStatus @status, 'COVID_CONTACT', @instance, null, @messageText;
    end
    execute dbo.SetProcessingStatus @status, 'SARS2_CONTACT', @instance, null, @messageText;    
    select @hasError = 1;
  end catch

  if ( @hasError = 1 and @isRestart = 0 ) 
  begin
    waitfor delay '00:01';
    execute dbo.ExtractContacts @isRestart = 1;
  end

  return 0;

end