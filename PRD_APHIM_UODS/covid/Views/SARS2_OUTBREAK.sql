create view [covid].[SARS2_OUTBREAK]
as
SELECT v.*, 
       Replace(Replace(Isnull(NULLIF((SELECT dbo.Strconcat( 
                       Isnull([dv_person].[dvper_lastname] + 
                       '*~* ', 
                               '') 
                             + Isnull([dv_person].[dvper_firstname]+' ', 
                                             '') 
                             + Isnull(CONVERT(VARCHAR, 
       [dv_phpersonalrecord].[dvpr_incidentid])+' ', '') 
                     + 
       Isnull([v_unifiedcodeset].[conceptcode], 
              '')) AS 
              [concatenated] 
       FROM   (((((( [a_act] [LPA_O1] (nolock) 
              INNER JOIN [dv_outbreak] (nolock) 
                      ON [LPA_O1].[id] = 
                         [dv_outbreak].[dvob_rowid] 
                         AND ( 
              ( [LPA_O1].[valuestring_txt] <> 
                'STAGE' 
                 OR [LPA_O1].[valuestring_txt] IS 
                    NULL ) 
                             )) 
            LEFT JOIN [a_act] [LPA_O2] (nolock) 
                   ON [LPA_O1].[id] = 
                      [LPA_O2].[act_parent_id] 
                      AND (( [LPA_O2].[classcode] = 'OBS' 
                             AND [LPA_O2].[metacode] = 
                                 'OB_SUBMITTEDBY' 
                           ))) 
           INNER JOIN [a_actrelationship] (nolock) 
                   ON [dv_outbreak].[dvob_rowid] = 
                      [a_actrelationship].[source_id]) 
          INNER JOIN [dv_phpersonalrecord] (nolock) 
                  ON [a_actrelationship].[target_id] = 
                     [dv_phpersonalrecord].[dvpr_rowid]) 
         INNER JOIN [dv_person] (nolock) 
                 ON [dv_person].[dvper_rowid] = 
       [dv_phpersonalrecord].[dvpr_persondr]) 
       INNER JOIN [v_unifiedcodeset] (nolock) 
       ON [v_unifiedcodeset].[id] = 
       [dv_phpersonalrecord].[dvpr_typedr]) 
       WHERE  ( [dv_outbreak].[dvob_rowid] = v.outb_rowid )) 
       + ';', ';'), ''), ',', ';'), '*~*', ',')   Patients_Linked_to_Outbreak, 
       '' + ( Replace(Replace(Isnull(NULLIF((SELECT dbo.Strconcat( 
                                     Isnull([LPA_C7].[dvper_lastname] + 
                                     ', ', '') 
                                                   + 
       Isnull([LPA_C7].[dvper_firstname]+' ', 
       '') 
                     + Isnull(CONVERT(VARCHAR, 
       [dv_phpersonalrecord].[dvpr_incidentid]), 
       '')) AS 
       [concatenated] 
       FROM   (((((((( [a_act] [LPA_O1] (nolock) 
       INNER JOIN [dv_outbreak] (nolock) 
       ON [LPA_O1].[id] = 
       [dv_outbreak].[dvob_rowid] 
       AND ( 
       ( [LPA_O1].[valuestring_txt] <>
       'STAGE' 
       OR [LPA_O1].[valuestring_txt] 
       IS NULL 
       ))) 
       LEFT JOIN [a_act] [LPA_O2] (nolock) 
       ON [LPA_O1].[id] = 
       [LPA_O2].[act_parent_id] 
       AND (( [LPA_O2].[classcode] = 
       'OBS' 
       AND [LPA_O2].[metacode] = 
       'OB_SUBMITTEDBY' ))) 
       INNER JOIN [a_actrelationship] [LPA_A3] ( 
       nolock) 
       ON [LPA_O1].[id] = 
       [LPA_A3].[source_id]) 
       INNER JOIN [dv_phpersonalrecord] (nolock) 
       ON [LPA_A3].[target_id] = 
       [dv_phpersonalrecord].[dvpr_rowid]) 
       INNER JOIN [dv_person] [LPA_D4] (nolock) 
       ON [LPA_D4].[dvper_rowid] = 
       [dv_phpersonalrecord].[dvpr_persondr] 
       AND (( [dv_phpersonalrecord].[dvpr_typedr] 
       IN ( 
       494681 ) 
       ))) 
       INNER JOIN [r_role] [LPA_e5] (nolock) 
       ON [LPA_e5].[scoper_id] = 
       [LPA_D4].[dvper_rowid] 
       AND (( [LPA_e5].[classcode] = 'EXPR' ))) 
       INNER JOIN [r_role] [LPA_m6] (nolock) 
       ON [LPA_m6].[scoper_id] = [LPA_e5].[player_id] 
       AND (( [LPA_m6].[classcode] = 'MBR' 
       AND [LPA_m6].[statuscode] <> 
       'nullified' 
       AND [LPA_m6].[statuscode] <> 
       'terminated' ))) 
       INNER JOIN [dv_person] [LPA_C7] (nolock) 
       ON [LPA_C7].[dvper_rowid] = [LPA_m6].[player_id]) 
       WHERE  ( [dv_outbreak].[dvob_rowid] = v.outb_rowid )) 
       + ';', ';'), ''), ',', ';'), '*~*', ',') ) + ' ' + ( 
       Replace(Replace(Isnull( 
               NULLIF( 
       (SELECT dbo.Strconcat( 
       Isnull([dv_person].[dvper_lastname] 
       + 
       '*~* ', 
       '' 
       ) 
       + Isnull([dv_person].[dvper_firstname]+' ', 
       '') 
       + Isnull(CONVERT(VARCHAR, 
       [dv_phpersonalrecord].[dvpr_incidentid])+' ', '') 
       + Isnull([v_unifiedcodeset].[conceptcode], 
       '')) AS 
       [concatenated] 
       FROM   (((((( [a_act] [LPA_O1] (nolock) 
       INNER JOIN [dv_outbreak] (nolock) 
       ON [LPA_O1].[id] = 
       [dv_outbreak].[dvob_rowid] 
       AND (( [LPA_O1].[valuestring_txt] <>
       'STAGE' 
       OR [LPA_O1].[valuestring_txt] IS 
       NULL ) 
       )) 
       LEFT JOIN [a_act] [LPA_O2] (nolock) 
       ON [LPA_O1].[id] = [LPA_O2].[act_parent_id] 
       AND (( [LPA_O2].[classcode] = 'OBS' 
       AND [LPA_O2].[metacode] = 
       'OB_SUBMITTEDBY' 
       ))) 
       INNER JOIN [a_actrelationship] (nolock) 
       ON [dv_outbreak].[dvob_rowid] = 
       [a_actrelationship].[source_id]) 
       INNER JOIN [dv_phpersonalrecord] (nolock) 
       ON [a_actrelationship].[target_id] = 
       [dv_phpersonalrecord].[dvpr_rowid]) 
       INNER JOIN [dv_person] (nolock) 
       ON [dv_person].[dvper_rowid] = 
       [dv_phpersonalrecord].[dvpr_persondr]) 
       INNER JOIN [v_unifiedcodeset] (nolock) 
       ON [v_unifiedcodeset].[id] = 
       [dv_phpersonalrecord].[dvpr_typedr]) 
       WHERE  ( [dv_outbreak].[dvob_rowid] = v.outb_rowid ) 
       AND dvpr_typedr = 494682) 
       + ';', ';'), ''), ',', ';'), '*~*', ',') ) 
       All_Contacts_Linked_to_Outbreak, 
       Replace(Replace(Isnull(NULLIF((SELECT dbo.Strconcat( 
                       Isnull([LPA_C7].[dvper_lastname] +', ', '' 
                       ) 
                             + Isnull([LPA_C7].[dvper_firstname]+' ', '' 
                       ) 
                             + Isnull(CONVERT(VARCHAR, 
                              [dv_phpersonalrecord].[dvpr_incidentid]), 
                       '')) AS 
                                              [concatenated] 
                       FROM   (((((((( [a_act] [LPA_O1] (nolock) 
                                       INNER JOIN [dv_outbreak] (nolock) 
                                               ON [LPA_O1].[id] = 
       [dv_outbreak].[dvob_rowid] 
       AND ( 
       ( [LPA_O1].[valuestring_txt] <>
       'STAGE' 
       OR [LPA_O1].[valuestring_txt] 
       IS NULL 
       ))) 
       LEFT JOIN [a_act] [LPA_O2] (nolock) 
       ON [LPA_O1].[id] = 
       [LPA_O2].[act_parent_id] 
       AND (( [LPA_O2].[classcode] = 
           'OBS' 
           AND [LPA_O2].[metacode] = 
               'OB_SUBMITTEDBY' ))) 
       INNER JOIN [a_actrelationship] [LPA_A3] ( 
       nolock) 
       ON [LPA_O1].[id] = 
       [LPA_A3].[source_id]) 
       INNER JOIN [dv_phpersonalrecord] (nolock) 
       ON [LPA_A3].[target_id] = 
       [dv_phpersonalrecord].[dvpr_rowid]) 
       INNER JOIN [dv_person] [LPA_D4] (nolock) 
       ON [LPA_D4].[dvper_rowid] = 
       [dv_phpersonalrecord].[dvpr_persondr] 
       AND (( [dv_phpersonalrecord].[dvpr_typedr] 
       IN ( 
       494681 ) 
       ))) 
       INNER JOIN [r_role] [LPA_e5] (nolock) 
       ON [LPA_e5].[scoper_id] = 
       [LPA_D4].[dvper_rowid] 
       AND (( [LPA_e5].[classcode] = 'EXPR' ))) 
       INNER JOIN [r_role] [LPA_m6] (nolock) 
       ON [LPA_m6].[scoper_id] = [LPA_e5].[player_id] 
       AND (( [LPA_m6].[classcode] = 'MBR' 
       AND [LPA_m6].[statuscode] <> 
       'nullified' 
       AND [LPA_m6].[statuscode] <> 
       'terminated' ))) 
       INNER JOIN [dv_person] [LPA_C7] (nolock) 
       ON [LPA_C7].[dvper_rowid] = [LPA_m6].[player_id]) 
       WHERE  ( [dv_outbreak].[dvob_rowid] = v.outb_rowid )) 
       + ';', ';'), ''), ',', ';'), '*~*', ',') 
       Incident_Contacts_Linked_to_Outbreak, 
       Replace(Replace(Isnull(NULLIF((SELECT dbo.Strconcat( 
                       Isnull([dv_person].[dvper_lastname] + 
                       '*~* ', 
                               '') 
                             + Isnull([dv_person].[dvper_firstname]+' ', 
                                             '') 
                             + Isnull(CONVERT(VARCHAR, 
       [dv_phpersonalrecord].[dvpr_incidentid])+' ', '') 
                     + 
       Isnull([v_unifiedcodeset].[conceptcode], 
              '')) AS 
              [concatenated] 
       FROM   (((((( [a_act] [LPA_O1] (nolock) 
              INNER JOIN [dv_outbreak] (nolock) 
                      ON [LPA_O1].[id] = 
                         [dv_outbreak].[dvob_rowid] 
                         AND ( 
              ( [LPA_O1].[valuestring_txt] <> 
                'STAGE' 
                 OR [LPA_O1].[valuestring_txt] IS 
                    NULL ) 
                             )) 
            LEFT JOIN [a_act] [LPA_O2] (nolock) 
                   ON [LPA_O1].[id] = 
                      [LPA_O2].[act_parent_id] 
                      AND (( [LPA_O2].[classcode] = 'OBS' 
                             AND [LPA_O2].[metacode] = 
                                 'OB_SUBMITTEDBY' 
                           ))) 
           INNER JOIN [a_actrelationship] (nolock) 
                   ON [dv_outbreak].[dvob_rowid] = 
                      [a_actrelationship].[source_id]) 
          INNER JOIN [dv_phpersonalrecord] (nolock) 
                  ON [a_actrelationship].[target_id] = 
                     [dv_phpersonalrecord].[dvpr_rowid]) 
         INNER JOIN [dv_person] (nolock) 
                 ON [dv_person].[dvper_rowid] = 
       [dv_phpersonalrecord].[dvpr_persondr]) 
       INNER JOIN [v_unifiedcodeset] (nolock) 
       ON [v_unifiedcodeset].[id] = 
       [dv_phpersonalrecord].[dvpr_typedr]) 
       WHERE  ( [dv_outbreak].[dvob_rowid] = v.outb_rowid ) 
       AND dvpr_typedr = 494682) 
       + ';', ';'), ''), ',', ';'), '*~*', ',') 
       Contact_Investigations_Linked_to_Outbreak 
FROM   atlaspublic.view_uods_outbreak v 
WHERE  outb_diseasecode_dr = 544041;