create view dbo.ALL_PROCESS_STATUS_HISTORY_VIEW
as
SELECT 
  pr.DVPR_DiseaseCode_ID as Disease,
  [LPA_A1].[recordid]   AS [PR_RowID], 
  [LPA_A2].[id]         AS [AUD_ID], 
  [T1].[ips_status]     AS [AUD_OldValue], 
  [T2].[ips_status]     AS [AUD_NewValue], 
  [LPA_A1].[actiondate] AS [AUD_ActionDate], 
  CASE 
    WHEN [LPA_A1].[userid] IS NULL OR [LPA_A1].[userid] = -2147483648 THEN 'System Process' 
    ELSE [LPA_E4].[partfam] + ', ' + [LPA_E4].[partgiv] 
  END                   AS [AUD_Username] 
FROM   ((((([$(PRD_APHIM_UODS)].dbo.[s_auditmain] [LPA_A1] with (nolock)
             LEFT JOIN [$(PRD_APHIM_UODS)].dbo.[s_auditdetail] [LPA_A2] with (nolock)
                    ON [LPA_A1].[id] = [LPA_A2].[auditid]) 
           LEFT JOIN [$(PRD_APHIM_UODS)].dbo.[e_entity] [LPA_E3] with (nolock)
                  ON [LPA_E3].[id] = [LPA_A1].[userid]) 
          LEFT JOIN [$(PRD_APHIM_UODS)].dbo.[t_entityname] [LPA_E4] with (nolock)
                 ON [LPA_E3].[id] = [LPA_E4].[entity_id]) 
         LEFT JOIN (SELECT DISTINCT [LPA_U1].[id]       AS [IPS_RowID], 
                                    [LPA_U1].[fullname] AS [IPS_Status] 
                    FROM   ((( [$(PRD_APHIM_UODS)].dbo.[v_unifiedcodeset] [LPA_U1] with (nolock)
                               INNER JOIN [$(PRD_APHIM_UODS)].dbo.[v_termdictionary] [LPA_V2] with (nolock)
                                       ON [LPA_U1].[id] = 
                             [LPA_V2].[termcode_id]) 
                             LEFT JOIN [$(PRD_APHIM_UODS)].dbo.[v_codeproperty] [LPA_V3] with (nolock)
                                    ON [LPA_U1].[id] = [LPA_V3].[subjcode_id] 
                                       AND (( [LPA_V3].[property] = 
                                              'IPS_ExportHistoryOrder' ))) 
                            LEFT JOIN [$(PRD_APHIM_UODS)].dbo.[v_unifiedcodeset] [LPA_U4] with (nolock)
                                   ON [LPA_U4].[id] = [LPA_V3].[valuecode_id]) 
                    WHERE  ( [LPA_U1].[domain_id] IN ( 439 ) 
                             AND [LPA_U1].[statusactive] = 1 
                             AND [LPA_V2].[active] = 1 
                             AND [LPA_V2].[name] = 'INCIDENTPROCESSSTATUS' )) AS 
                   T1 
                ON T1.ips_rowid = LPA_A2.oldvalue) 
        LEFT JOIN (SELECT DISTINCT [LPA_U1].[id]       AS [IPS_RowID], 
                                   [LPA_U1].[fullname] AS [IPS_Status] 
                   FROM   ((( [$(PRD_APHIM_UODS)].dbo.[v_unifiedcodeset] [LPA_U1] with (nolock)
                              INNER JOIN [$(PRD_APHIM_UODS)].dbo.[v_termdictionary] [LPA_V2] with (nolock)
                                      ON [LPA_U1].[id] = [LPA_V2].[termcode_id]) 
                            LEFT JOIN [$(PRD_APHIM_UODS)].dbo.[v_codeproperty] [LPA_V3] with (nolock)
                                   ON [LPA_U1].[id] = [LPA_V3].[subjcode_id] 
                                      AND (( [LPA_V3].[property] = 
                                             'IPS_ExportHistoryOrder' ))) 
                           LEFT JOIN [$(PRD_APHIM_UODS)].dbo.[v_unifiedcodeset] [LPA_U4] with (nolock)
                                  ON [LPA_U4].[id] = [LPA_V3].[valuecode_id]) 
                   WHERE  ( [LPA_U1].[domain_id] IN ( 439 ) 
                            AND [LPA_U1].[statusactive] = 1 
                            AND [LPA_V2].[active] = 1 
                            AND [LPA_V2].[name] = 'INCIDENTPROCESSSTATUS' )) AS 
                  T2 
               ON T2.ips_rowid = LPA_A2.newvalue 
      inner join
      [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr
      on
        LPA_A1.RecordID = convert(varchar(10),pr.DVPR_RowID)
      )
WHERE  
  [LPA_A2].[columnname] = 'PR_ProcessStatusDR' AND 
  pr.DVPR_DiseaseCode_ID not in (543030, 544041, 509985)