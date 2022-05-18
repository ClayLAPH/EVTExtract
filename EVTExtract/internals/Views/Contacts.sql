create VIEW internals.Contacts as
select 
  DIID                                              = actCase.ID,
  CONTACTID                                         = perEntity.ID,  
  INSTANCEID                                        = inst.extension,
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
  RLENT_DATESOFCONTACT                              = CONVERT(DATETIME, contactDate.VALUETS, 110),  
  RLENT_STREETADDRESS                               = person.DVPER_STREETADDRESS,  
  RLENT_APARTMENT                                   = person.DVPER_APARTMENT,  
  RLENT_CITY                                        = person.DVPER_CITY,  
  RLENT_ZIP                                         = person.DVPER_ZIP,  
  RLENT_PHONE                                       = person.DVPER_HOMEPHONE,  
  RLENT_DISTRICT                                    = districtName.FULLNAME,  
  RLENT_PROPHYLAXISMEDICATION                       = sbadm.TEXT,  
  RLENT_INVESTIGATORDR                              = investgName.PARTFAM + ', ' +  investgName.PARTGIV,  
  RLENT_EXPEVENTDR                                  = expact.ID,  
  RLENT_EXPEVENT                                    = locName.TRIVIALNAME,
  RLENT_PRIORITYDR                                  = priorityName.FULLNAME, 
  RLENT_CLUSTERID                                   = clusterAtt.VALUESTRING,  
  RLENT_STATUSDR                                    = statusName.FULLNAME,  
  FOLDERID = folder.ID,
  RLENT_ELECTRONICCONTACT                           = eContact.VALUESTRING,
  RLENT_EMAIL                                       = eMail.VALUESTRING,
  RLENT_STATE                                       = person.DVPER_STATE,
  RLENT_RACE                                        = ucsRace.fullName,        
  RLENT_PersonalRecordDR                            = createdPRPart.Act_ID,
  RLENT_PersonalRecordID                            = createdPRInstanceId.extension,
  RLENT_PersonalRecordType                          = createdPRType.shortName,
  RLENT_ContactInvestigationLinkedIncidentDR        = createdPRIncident.source_ID,
  RLENT_ContactInvestigationLinkedIncidentID        = createdPRIncidentInstance.extension
FROM   
  [$(PRD_APHIM_UODS)].dbo.E_ENTITY                  perEntity  with (nolock)
  INNER JOIN 
  internals.DV_PERSON                               person with (nolock)  
    on  person.DVPER_ROWID = perEntity.ID  
    and person.DVPER_ISCONTACT = 1  
  INNER JOIN 
  [$(PRD_APHIM_UODS)].dbo.R_ROLE                    mbr with (nolock)  
    on  perEntity.ID = mbr.PLAYER_ID  
    and mbr.CLASSCODE = 'mbr'  
    and mbr.STATUSCODE NOT IN ('NULLIFIED', 'TERMINATED')  
  INNER JOIN 
  [$(PRD_APHIM_UODS)].dbo.E_ENTITY                  ent with (nolock)  
  on  
    mbr.SCOPER_ID = ent.ID  and 
    ent.CLASSCODE = 'ENT'  
  INNER JOIN 
  [$(PRD_APHIM_UODS)].dbo.R_ROLE                    expr with (nolock)  
  on  
    ent.ID = expr.PLAYER_ID  and 
    expr.CLASSCODE = 'expr'  
  INNER JOIN 
  [$(PRD_APHIM_UODS)].dbo.P_PARTICIPATION           ind with (nolock)  
  on  
    expr.ID = ind.ROLE_ID  and 
    ind.TYPECODE = 'ind'  
  INNER JOIN [$(PRD_APHIM_UODS)].dbo.A_Act          actCase with (nolock)  
  on  
    actCase.ID = ind.ACT_ID and  
    actCase.metaCode IN ('PR_ROWID','AI_ROWID','OB_RowID') and 
    actCase.statusCode IN ('ACTIVE','COMPLETED')
  INNER JOIN 
  [$(PRD_APHIM_UODS)].dbo.T_InstanceIdentifier      inst with (nolock)              
  on 
    inst.Act_ID=actCase.ID and 
    (
      inst.[root] LIKE '2.16.840.1.113883.3.33.4.2.2.11.1%' OR 
      inst.[root] LIKE '2.16.840.1.113883.3.33.4.2.2.11.8%' OR 
      inst.[root] LIKE '2.16.840.1.113883.3.33.4.2.2.11.7%'
    )
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
  left outer join [$(PRD_APHIM_UODS)].dbo.A_ACT     sbadm with (nolock)  
  on  
    folder.ID = sbadm.ACT_PARENT_ID and 
    sbadm.CLASSCODE = 'sbadm'  and 
    sbadm.METACODE = 'RLENT_PROPHYLAXISMEDICATION'  
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.A_ACTRELATIONSHIP         pert with (nolock)  
  on  
    folder.ID = pert.SOURCE_ID  and 
    pert.TYPECODE = 'pert'  
  left outer join [$(PRD_APHIM_UODS)].dbo.A_ACT     inc with (nolock)  
  on  
    pert.TARGET_ID = inc.ACT_PARENT_ID  and 
    inc.CLASSCODE = 'inc'  and 
    inc.METACODE = 'DEE_ROWID'  
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.P_PARTICIPATION           dir with (nolock)  
  on  
    inc.ID = dir.ACT_ID and 
    dir.TYPECODE = 'dir'  and 
    dir.METACODE = 'DEE_LABORATORYDR'  
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.R_ROLE                    loce with (nolock)  
  on  
    dir.ROLE_ID = loce.ID and 
    loce.CLASSCODE = 'loce' 
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.A_ACTRELATIONSHIP         actRel with (nolock) 
  on 
    actRel.SOURCE_ID= folder.ID and 
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
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.P_Participation           createdPRPart with (nolock) 
  on  
    mbr.ID=createdPRPart.Role_ID and 
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
    -- hacked out config
where  
  perEntity.CLASSCODE = 'PSN'


