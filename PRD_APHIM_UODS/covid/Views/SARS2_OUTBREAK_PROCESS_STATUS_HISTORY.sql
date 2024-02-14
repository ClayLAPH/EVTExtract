create view [covid].[SARS2_OUTBREAK_PROCESS_STATUS_HISTORY]
as
SELECT [LPA_A1].[recordid]   AS [OUTB_RowID], 
       [LPA_A2].[id]         AS [AUD_ID], 
       [T1].[ips_status]     AS [AUD_OldValue], 
       [T2].[ips_status]     AS [AUD_NewValue], 
       [LPA_A1].[actiondate] AS [AUD_ActionDate], 
       CASE 
         WHEN [LPA_A1].[userid] IS NULL 
               OR [LPA_A1].[userid] = -2147483648 THEN 'System Process' 
         ELSE [LPA_E4].[partfam] + ', ' + [LPA_E4].[partgiv] 
       END                   AS [AUD_Username] 
FROM   ((((( [s_auditmain] [LPA_A1] (nolock) 
             LEFT JOIN [s_auditdetail] [LPA_A2] (nolock) 
                    ON [LPA_A1].[id] = [LPA_A2].[auditid]) 
           LEFT JOIN [e_entity] [LPA_E3] (nolock) 
                  ON [LPA_E3].[id] = [LPA_A1].[userid]) 
          LEFT JOIN [t_entityname] [LPA_E4] (nolock) 
                 ON [LPA_E3].[id] = [LPA_E4].[entity_id]) 
         LEFT JOIN (SELECT DISTINCT [LPA_U1].[id]       AS [IPS_RowID], 
                                    [LPA_U1].[fullname] AS [IPS_Status] 
                    FROM   ((( [v_unifiedcodeset] [LPA_U1] (nolock) 
                               INNER JOIN [v_termdictionary] [LPA_V2] (nolock) 
                                       ON [LPA_U1].[id] = 
                             [LPA_V2].[termcode_id]) 
                             LEFT JOIN [v_codeproperty] [LPA_V3] (nolock) 
                                    ON [LPA_U1].[id] = [LPA_V3].[subjcode_id] 
                                       AND (( [LPA_V3].[property] = 
                                              'IPS_ExportHistoryOrder' ))) 
                            LEFT JOIN [v_unifiedcodeset] [LPA_U4] (nolock) 
                                   ON [LPA_U4].[id] = [LPA_V3].[valuecode_id]) 
                    WHERE  ( [LPA_U1].[domain_id] IN ( 439 ) 
                             AND [LPA_U1].[statusactive] = 1 
                             AND [LPA_V2].[active] = 1 
                             AND [LPA_V2].[name] = 'INCIDENTPROCESSSTATUS' )) AS 
                   T1 
                ON T1.ips_rowid = LPA_A2.oldvalue) 
        LEFT JOIN (SELECT DISTINCT [LPA_U1].[id]       AS [IPS_RowID], 
                                   [LPA_U1].[fullname] AS [IPS_Status] 
                   FROM   ((( [v_unifiedcodeset] [LPA_U1] (nolock) 
                              INNER JOIN [v_termdictionary] [LPA_V2] (nolock) 
                                      ON [LPA_U1].[id] = [LPA_V2].[termcode_id]) 
                            LEFT JOIN [v_codeproperty] [LPA_V3] (nolock) 
                                   ON [LPA_U1].[id] = [LPA_V3].[subjcode_id] 
                                      AND (( [LPA_V3].[property] = 
                                             'IPS_ExportHistoryOrder' ))) 
                           LEFT JOIN [v_unifiedcodeset] [LPA_U4] (nolock) 
                                  ON [LPA_U4].[id] = [LPA_V3].[valuecode_id]) 
                   WHERE  ( [LPA_U1].[domain_id] IN ( 439 ) 
                            AND [LPA_U1].[statusactive] = 1 
                            AND [LPA_V2].[active] = 1 
                            AND [LPA_V2].[name] = 'INCIDENTPROCESSSTATUS' )) AS 
                  T2 
               ON T2.ips_rowid = LPA_A2.newvalue) 
WHERE  ( [LPA_A2].[columnname] = 'OB_ProcessStatusDR' 
         AND [LPA_A1].[recordid] IN (SELECT Cast( 
             [AtlasPublic].[view_uods_outbreak].[outb_rowid] AS 
             VARCHAR) 
              FROM   [AtlasPublic].[view_uods_outbreak] (nolock) 
              WHERE  ( 
                 [AtlasPublic].[view_uods_outbreak].[outb_diseasecode_dr] = 
                 544041 )) )