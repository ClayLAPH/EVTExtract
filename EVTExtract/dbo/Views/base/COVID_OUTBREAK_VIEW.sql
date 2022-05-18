create view dbo.COVID_OUTBREAK_VIEW
as
select 
  v.OUTB_RowID, 
  v.OUTB_Legacy_RowID, 
  v.OUTB_Disease, 
  v.OUTB_OutbreakNumber, 
  v.OUTB_IsHealthFacilityOutbreak, 
  v.OUTB_OutbreakLocation, 
  v.OUTB_District, 
  v.OUTB_DateofOnset, 
  v.OUTB_DateCreated, 
  v.OUTB_DateClosed, 
  v.OUTB_ProcessStatus, 
  v.OUTB_ResolutionStatus, 
  v.OUTB_Notes, 
  v.OUTB_OutbreakType, 
  v.OUTB_OUTBREAKID, 
  v.OUTB_COUNT, 
  v.OUTB_USERDR, 
  v.OUTB_HEALTHFACILITYCODE_DR, 
  v.OUTB_DISEASECODE_DR, 
  v.OUTB_DISSHORTNAME, 
  v.OUTB_LOCATIONDR, 
  v.OUTB_DISTRICTCODE_DR, 
  v.OUTB_SPACODE_DR, 
  v.OUTB_OUTBREAKTYPECODE_DR, 
  v.OUTB_PROCESSSTATUSCODE_DR, 
  v.OUTB_RESOLUTIONSTATUSCODE_DR, 
  v.OUTB_DATESUBMITTED, 
  v.OUTB_DGRPDR, 
  v.OUTB_USERNAME, 
  v.OUTB_ISHEALTHFACILITY, 
  v.OUTB_LOCATIONTYPE, 
  v.OUTB_LOCATIONADDRESS, 
  v.OUTB_LOCATIONPHONE, 
  v.OUTB_NURSEINVESTIGATOR, 
  v.OUTB_NURSEINVESTIGATORDR, 
  v.OUTB_LOCATIONEMAIL, 
  v.OUTB_LOCATIONPRIMARYCONTACT, 
  v.OUTB_LOCCOUNTY, 
  v.OUTB_LOCJURISDICTION, 
  v.OUTB_LOCATIONTYPEDR, 
  v.OUTB_PRIORITY, 
  v.OUTB_DISTRICTNUMBER, 
  v.OUTB_LOCATIONCENSUSTRACT, 
  v.OUTB_LOCATIONCENSUSBLOCK, 
  v.OUTB_LOCATIONCOUNTYFIPS, 
  v.OUTB_LOCATIONLATITUDE, 
  v.OUTB_LOCATIONLONGITUDE, 
  v.OUTB_LOCATIONDISTRICTNUMBER, 
  
  OUTB_LOCATIONADDRESS_PLUS =  
      v.OUTB_LOCATIONADDRESS + ', '+ 
      ADRS.partCty + ', ' + 
      ADRS.partSta + ' ' + 
      ADRS.partZip , 

  Patients_Linked_to_Outbreak =
    replace(replace(isnull(nullif(
    ( select 
        [$(PRD_APHIM_UODS)].dbo.Strconcat
        ( 
          isnull(dv_person.dvper_lastname + '*~* ', '') + 
          isnull(dv_person.dvper_firstname+' ', '') + 
          isnull(convert(varchar, dv_phpersonalrecord.dvpr_incidentid)+' ', '') + 
          isnull(v_unifiedcodeset.conceptcode, '')
        ) concatenated 
      from   
        (((((( 
        [$(PRD_APHIM_UODS)].dbo.a_act LPA_O1 with (nolock) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.dv_outbreak with (nolock) 
        on 
          LPA_O1.id = dv_outbreak.dvob_rowid and 
          ( 
              LPA_O1.valuestring_txt <> 'STAGE' or 
              LPA_O1.valuestring_txt IS null 
          )
        ) 
        left outer join 
        [$(PRD_APHIM_UODS)].dbo.a_act LPA_O2 with (nolock) 
        on 
          LPA_O1.id = LPA_O2.act_parent_id and 
          LPA_O2.classcode = 'OBS' and 
          LPA_O2.metacode = 'OB_SUBMITTEDBY' 
        ) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.a_actrelationship with (nolock) 
        on 
          dv_outbreak.dvob_rowid = a_actrelationship.source_id
        ) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.dv_phpersonalrecord with (nolock) 
        on 
          a_actrelationship.target_id = dv_phpersonalrecord.dvpr_rowid
        ) 
        inner join 
        internals.dv_person with (nolock) 
        on 
          dv_person.dvper_rowid =dv_phpersonalrecord.dvpr_persondr
        ) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.v_unifiedcodeset with (nolock) 
        on 
          v_unifiedcodeset.id = dv_phpersonalrecord.dvpr_typedr) 
      where  
        dv_outbreak.dvob_rowid = v.outb_rowid
    ) + ';', ';'), ''), ',', ';'), '*~*', ',') , 


  All_Contacts_Linked_to_Outbreak =
    '' + ( replace(replace(isnull(nullif(
    ( select 
        [$(PRD_APHIM_UODS)].dbo.Strconcat
        ( 
          isnull(LPA_C7.dvper_lastname + '*~* ', '') + 
          isnull(LPA_C7.dvper_firstname+' ', '') + 
          isnull(convert(varchar, dv_phpersonalrecord.dvpr_incidentid), '')
        ) concatenated 
      from   
        (((((((( 
        [$(PRD_APHIM_UODS)].dbo.a_act LPA_O1 with (nolock) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.dv_outbreak with (nolock) 
        on 
          LPA_O1.id = dv_outbreak.dvob_rowid and 
          ( 
            LPA_O1.valuestring_txt <> 'STAGE' or 
            LPA_O1.valuestring_txt IS null 
          )
        ) 
        left outer join 
        [$(PRD_APHIM_UODS)].dbo.a_act LPA_O2 with (nolock) 
        on 
          LPA_O1.id = LPA_O2.act_parent_id and 
          LPA_O2.classcode = 'OBS' and 
          LPA_O2.metacode = 'OB_SUBMITTEDBY'
        ) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.a_actrelationship LPA_A3 with (nolock) 
        on 
          LPA_O1.id = LPA_A3.source_id
        ) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.dv_phpersonalrecord with (nolock) 
        on 
          LPA_A3.target_id = dv_phpersonalrecord.dvpr_rowid
        ) 
        inner join 
        internals.dv_person LPA_D4 with (nolock) 
        on 
          LPA_D4.dvper_rowid = dv_phpersonalrecord.dvpr_persondr and 
          dv_phpersonalrecord.dvpr_typedr = 494681 
        ) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.r_role LPA_e5 with (nolock) 
        on 
          LPA_e5.scoper_id = LPA_D4.dvper_rowid and 
          LPA_e5.classcode = 'EXPR'
        ) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.r_role LPA_m6 with (nolock) 
        on 
          LPA_m6.scoper_id = LPA_e5.player_id and 
          LPA_m6.classcode = 'MBR' and 
          LPA_m6.statuscode <> 'nullified' and 
          LPA_m6.statuscode <> 'terminated'
        ) 
        inner join 
        internals.dv_person LPA_C7 with (nolock) 
        on 
          LPA_C7.dvper_rowid = LPA_m6.player_id
        ) 
    where  
      dv_outbreak.dvob_rowid = v.outb_rowid 
    ) + ';', ';'), ''), ',', ';'), '*~*', ',') ) + ' ' + 
    (replace(replace(isnull(nullif( 
    ( select 
        [$(PRD_APHIM_UODS)].dbo.Strconcat
        ( 
         isnull(dv_person.dvper_lastname + '*~* ', '' ) + 
         isnull(dv_person.dvper_firstname+' ', '') + 
         isnull(convert(varchar, dv_phpersonalrecord.dvpr_incidentid)+' ', '') + 
         isnull(v_unifiedcodeset.conceptcode, '')
        ) concatenated 
      from   
        (((((( 
        [$(PRD_APHIM_UODS)].dbo.a_act LPA_O1 with (nolock) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.dv_outbreak with (nolock) 
        on 
          LPA_O1.id = dv_outbreak.dvob_rowid and 
          ( 
            LPA_O1.valuestring_txt <> 'STAGE' or 
            LPA_O1.valuestring_txt IS null 
          )
        ) 
        left join 
        [$(PRD_APHIM_UODS)].dbo.a_act LPA_O2 with (nolock) 
        on 
          LPA_O1.id = LPA_O2.act_parent_id and 
          LPA_O2.classcode = 'OBS' and 
          LPA_O2.metacode = 'OB_SUBMITTEDBY' 
        ) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.a_actrelationship with (nolock) 
        on 
          dv_outbreak.dvob_rowid = a_actrelationship.source_id) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.dv_phpersonalrecord with (nolock) 
        on 
          a_actrelationship.target_id = dv_phpersonalrecord.dvpr_rowid) 
        inner join internals.dv_person with (nolock) 
        on 
        dv_person.dvper_rowid = dv_phpersonalrecord.dvpr_persondr
        ) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.v_unifiedcodeset with (nolock) 
        on 
          v_unifiedcodeset.id = dv_phpersonalrecord.dvpr_typedr) 
      where  
        dv_outbreak.dvob_rowid = v.outb_rowid and dvpr_typedr = 494682
    )+ ';', ';'), ''), ',', ';'), '*~*', ',') ), 

  Incident_Contacts_Linked_to_Outbreak =
    replace(replace(isnull(nullif(
    (
      select [$(PRD_APHIM_UODS)].dbo.Strconcat
        ( 
          isnull(LPA_C7.dvper_lastname +'*~* ', '' ) + 
          isnull(LPA_C7.dvper_firstname+' ', '' ) + 
          isnull(convert(varchar, dv_phpersonalrecord.dvpr_incidentid), '')
        ) concatenated 
      from   
        (((((((( 
        [$(PRD_APHIM_UODS)].dbo.a_act LPA_O1 with (nolock) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.dv_outbreak with (nolock) 
        on 
          LPA_O1.id = dv_outbreak.dvob_rowid and 
          ( 
          LPA_O1.valuestring_txt <> 'STAGE' or 
          LPA_O1.valuestring_txt IS null 
          )
        ) 
        left join 
        [$(PRD_APHIM_UODS)].dbo.a_act LPA_O2 with (nolock) 
        on 
          LPA_O1.id = LPA_O2.act_parent_id and 
          LPA_O2.classcode = 'OBS' and 
          LPA_O2.metacode = 'OB_SUBMITTEDBY' 
        ) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.a_actrelationship LPA_A3 with (nolock) 
        on 
          LPA_O1.id = LPA_A3.source_id
        ) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.dv_phpersonalrecord with (nolock) 
        on 
          LPA_A3.target_id = dv_phpersonalrecord.dvpr_rowid) 
        inner join 
        internals.dv_person LPA_D4 with (nolock) 
        on 
          LPA_D4.dvper_rowid = dv_phpersonalrecord.dvpr_persondr and 
          dv_phpersonalrecord.dvpr_typedr = 494681 
        ) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.r_role LPA_e5 with (nolock) 
        on 
          LPA_e5.scoper_id = LPA_D4.dvper_rowid and 
          LPA_e5.classcode = 'EXPR' 
        )
        inner join 
        [$(PRD_APHIM_UODS)].dbo.r_role LPA_m6 with (nolock) 
        on 
          LPA_m6.scoper_id = LPA_e5.player_id and 
          LPA_m6.classcode = 'MBR' and 
          LPA_m6.statuscode <> 'nullified' and 
          LPA_m6.statuscode <> 'terminated' 
        ) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.dv_person LPA_C7 with (nolock) 
        on 
          LPA_C7.dvper_rowid = LPA_m6.player_id
        ) 
      where  
        dv_outbreak.dvob_rowid = v.outb_rowid 
    ) + ';', ';'), ''), ',', ';'), '*~*', ',') , 

  Contact_Investigations_Linked_to_Outbreak =
    replace(replace(isnull(nullif(
    ( select 
        [$(PRD_APHIM_UODS)].dbo.Strconcat
        ( 
          isnull(dv_person.dvper_lastname + '*~* ', '') + 
          isnull(dv_person.dvper_firstname+' ', '') + 
          isnull(convert(varchar, dv_phpersonalrecord.dvpr_incidentid)+' ', '') + 
          isnull(v_unifiedcodeset.conceptcode, '')
        ) concatenated 
      from   
        (((((( 
        [$(PRD_APHIM_UODS)].dbo.a_act LPA_O1 with (nolock) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.dv_outbreak with (nolock) 
        on 
          LPA_O1.id = dv_outbreak.dvob_rowid and 
          ( 
            LPA_O1.valuestring_txt <> 'STAGE' or 
            LPA_O1.valuestring_txt IS null 
          ) 
        ) 
        left outer join 
        [$(PRD_APHIM_UODS)].dbo.a_act LPA_O2 with (nolock) 
        on 
          LPA_O1.id = LPA_O2.act_parent_id and 
          LPA_O2.classcode = 'OBS' and 
          LPA_O2.metacode = 'OB_SUBMITTEDBY' 
        )
        inner join 
        [$(PRD_APHIM_UODS)].dbo.a_actrelationship with (nolock) 
        on dv_outbreak.dvob_rowid = a_actrelationship.source_id
        ) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.dv_phpersonalrecord with (nolock) 
        on 
          a_actrelationship.target_id = dv_phpersonalrecord.dvpr_rowid) 
        inner join 
        internals.dv_person with (nolock) on 
          dv_person.dvper_rowid = dv_phpersonalrecord.dvpr_persondr
        ) 
        inner join 
        [$(PRD_APHIM_UODS)].dbo.v_unifiedcodeset with (nolock) 
        on 
          v_unifiedcodeset.id = dv_phpersonalrecord.dvpr_typedr
        ) 
      where  
        dv_outbreak.dvob_rowid = v.outb_rowid and 
        dvpr_typedr = 494682
    ) + ';', ';'), ''), ',', ';'), '*~*', ',')

from   
  Internals.outbreak v 
  inner join 
  [$(PRD_APHIM_UODS)].dbo.DV_Outbreak pr with (nolock)
  on 
    v.OUTB_RowID = pr.DVOB_RowID
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.E_Entity ELOC with (nolock) 
  on 
    ELOC.ID = pr.DVOB_LocationDR and 
    ELOC.classCode = 'PLC' and 
    ELOC.determinerCode = 'INSTANCE' and 
    ELOC.metaCode = 'LOC_RowID' 
  left outer join
  [$(PRD_APHIM_UODS)].dbo.T_EntityAddress ADRS with (nolock) 
  on 
    ADRS.Entity_ID = ELOC.ID and 
    ADRS.useCode = 'PHYS'
where  
  outb_diseasecode_dr = 543030;