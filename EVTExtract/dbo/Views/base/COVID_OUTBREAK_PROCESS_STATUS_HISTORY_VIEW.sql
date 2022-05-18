create view dbo.COVID_OUTBREAK_PROCESS_STATUS_HISTORY_VIEW as 
select 
  OUTB_RowID      = auditMain.recordid, 
  AUD_ID          = auditDetail.id, 
  AUD_OldValue    = ipsOld.ips_status, 
  AUD_NewValue    = ipsNew.ips_status, 
  AUD_ActionDate  = auditMain.actiondate, 
  AUD_Username    = 
    case 
      when auditMain.userid is null or auditMain.userid = -2147483648 
      then 'System Process' 
      else auditUserName.partfam + ', ' + auditUserName.partgiv 
    end 
from   
  ((((( 
  [$(PRD_APHIM_UODS)].dbo.s_auditmain               auditMain with (nolock) 
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.s_auditdetail             auditDetail with (nolock) 
  on 
    auditMain.id = auditDetail.auditid
  ) 
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.e_entity                  auditUser with (nolock) 
  on 
    auditUser.id = auditMain.userid
  ) 
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.t_entityname              auditUserName with (nolock) 
  on 
    auditUser.id = auditUserName.entity_id
  ) 
  left outer join 
  ( select distinct 
      IPS_RowID = ucsIPS.id, 
      IPS_Status = ucsIPS.fullname 
    from   
      ((( 
      [$(PRD_APHIM_UODS)].dbo.v_unifiedcodeset      ucsIPS with (nolock) 
      inner join
      [$(PRD_APHIM_UODS)].dbo.v_termdictionary      termIPS with (nolock) 
      on 
        ucsIPS.id = termIPS.termcode_id
      ) 
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.v_codeproperty        codeIPS with (nolock) 
      on 
        ucsIPS.id = codeIPS.subjcode_id and 
        codeIPS.property = 'IPS_ExportHistoryOrder' 
      ) 
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.v_unifiedcodeset      ucsExport with (nolock) 
      on 
        ucsExport.id = codeIPS.valuecode_id
      ) 
    where  
      ucsIPS.domain_id = 439 and 
      ucsIPS.statusactive = 1 and 
      termIPS.active = 1 and 
      termIPS.name = 'INCIDENTPROCESSSTATUS'
  ) as ipsOld 
  on 
    ipsOld.ips_rowid = auditDetail.oldvalue
  ) 
  left outer join 
  ( select distinct 
      IPS_RowID = ucsIPS.id, 
      IPS_Status = ucsIPS.fullname 
    from   
      ((( 
      [$(PRD_APHIM_UODS)].dbo.v_unifiedcodeset      ucsIPS with (nolock) 
      inner join
      [$(PRD_APHIM_UODS)].dbo.v_termdictionary      termIPS with (nolock) 
      on 
        ucsIPS.id = termIPS.termcode_id
      ) 
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.v_codeproperty        codeIPS with (nolock) 
      on 
        ucsIPS.id = codeIPS.subjcode_id and 
        codeIPS.property = 'IPS_ExportHistoryOrder' 
      ) 
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.v_unifiedcodeset      ucsExport with (nolock) 
      on 
        ucsExport.id = codeIPS.valuecode_id) 
    where  
      ucsIPS.domain_id = 439 and 
      ucsIPS.statusactive = 1 and 
      termIPS.active = 1 and 
      termIPS.name = 'INCIDENTPROCESSSTATUS' 
  ) as ipsNew 
  on 
    ipsNew.ips_rowid = auditDetail.newvalue
  ) 
where  
( 
  auditDetail.columnname = 'OB_ProcessStatusDR' and 
  auditMain.recordid in 
  ( select 
      cast( ob.outb_rowid as varchar) 
    from 
      internals.Outbreak                            ob with (nolock) 
    where  
      ob.outb_diseasecode_dr = 543030
  ) 
)
