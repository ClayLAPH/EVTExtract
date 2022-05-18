create view internals.ProcessStatusHistory as
select
  [OUTB_RowID] = [LPA_A1].[recordid], 
  [AUD_ID] = [LPA_A2].[id], 
  [AUD_OldValue] = [T1].[ips_status], 
  [AUD_NewValue] = [T2].[ips_status], 
  [AUD_ActionDate] = [LPA_A1].[actiondate], 
  [AUD_Username] =
    case
      when [LPA_A1].[userid] is null or [LPA_A1].[userid] = -2147483648 
      then 'System Process' 
      else [LPA_E4].[partfam] + ', ' + [LPA_E4].[partgiv] 
    end 
from   
  ((((( 
  [$(PRD_APHIM_UODS)].dbo.[s_auditmain] [LPA_A1] with (nolock)
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.[s_auditdetail] [LPA_A2] with (nolock)
  on 
    [LPA_A1].[id] = [LPA_A2].[auditid]) 
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.[e_entity] [LPA_E3] with (nolock)
  on 
    [LPA_E3].[id] = [LPA_A1].[userid]) 
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.[t_entityname] [LPA_E4] with (nolock)
  on
    [LPA_E3].[id] = [LPA_E4].[entity_id]) 
  left outer join
  ( select distinct
      [LPA_U1].[id]       [IPS_RowID], 
      [LPA_U1].[fullname] [IPS_Status] 
    from
      ((( 
      [$(PRD_APHIM_UODS)].dbo.[v_unifiedcodeset] [LPA_U1] with (nolock) 
      inner join 
      [$(PRD_APHIM_UODS)].dbo.[v_termdictionary] [LPA_V2] with (nolock) 
      ON 
        [LPA_U1].[id] = [LPA_V2].[termcode_id]
      ) 
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.[v_codeproperty] [LPA_V3] with (nolock)
      ON 
        [LPA_U1].[id] = [LPA_V3].[subjcode_id] 
        and 
        [LPA_V3].[property] = 'IPS_ExportHistoryOrder' 
      ) 
      left outer join 
      [$(PRD_APHIM_UODS)].dbo.[v_unifiedcodeset] [LPA_U4] with (nolock)
      ON 
        [LPA_U4].[id] = [LPA_V3].[valuecode_id]
      ) 
    where  
      [LPA_U1].[domain_id]  = 439  and 
      [LPA_U1].[statusactive] = 1 and 
      [LPA_V2].[active] = 1 and 
      [LPA_V2].[name] = 'INCIDENTPROCESSSTATUS' 
  ) AS T1 
  ON 
    T1.ips_rowid = LPA_A2.oldvalue
  ) 
  left outer join 
  ( SELECT DISTINCT 
      [LPA_U1].[id]       AS [IPS_RowID], 
      [LPA_U1].[fullname] AS [IPS_Status] 
    FROM   
    ((( 
    [$(PRD_APHIM_UODS)].dbo.[v_unifiedcodeset] [LPA_U1] with (nolock) 
    inner join 
    [$(PRD_APHIM_UODS)].dbo.[v_termdictionary] [LPA_V2] with (nolock) 
    ON 
      [LPA_U1].[id] = [LPA_V2].[termcode_id]
    ) 
    left outer join 
    [$(PRD_APHIM_UODS)].dbo.[v_codeproperty] [LPA_V3] with (nolock) 
    ON 
      [LPA_U1].[id] = [LPA_V3].[subjcode_id] and 
      [LPA_V3].[property] = 'IPS_ExportHistoryOrder' 
    ) 
    left outer join 
    [$(PRD_APHIM_UODS)].dbo.[v_unifiedcodeset] [LPA_U4] with (nolock) 
    ON 
      [LPA_U4].[id] = [LPA_V3].[valuecode_id]
    ) 
   WHERE  
    ( 
      [LPA_U1].[domain_id] IN ( 439 ) and 
      [LPA_U1].[statusactive] = 1 and 
      [LPA_V2].[active] = 1 and 
      [LPA_V2].[name] = 'INCIDENTPROCESSSTATUS' 
    )
  ) AS T2 
  ON 
    T2.ips_rowid = LPA_A2.newvalue
  ) 
WHERE  
  [LPA_A2].[columnname] = 'OB_ProcessStatusDR' and 
  [LPA_A1].[recordid] IN 
  (
    SELECT 
      Cast( ob.[outb_rowid] AS VARCHAR) 
    FROM   
      internals.Outbreak ob with (nolock)
    WHERE  
    ( 
      ob.[outb_diseasecode_dr] = 543030 
    )
  ) 
