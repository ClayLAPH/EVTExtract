create view [covid].[UNKNOWN_RESPIRATORY_OUTBREAK_LINKED_CONTACT]
as
SELECT 
[DVOB_RowID],
Isnull([LPA_C7].[dvper_lastname], '') + ', '
+ Isnull([LPA_C7].[dvper_firstname], '') [LinkedPatientContacts],
[dv_phpersonalrecord].[dvpr_incidentid] [IncidentID], 
Isnull([LPA_C7].[dvper_lastname], '') + ', '
+ Isnull([LPA_C7].[dvper_firstname], '') + ' ' +
CAST([dv_phpersonalrecord].[dvpr_incidentid] AS VARCHAR) [concatenated] 
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
       WHERE  ( [dv_outbreak].[dvob_rowid] in (select DVOB_RowID from DV_Outbreak where DVPR_DiseaseCode_ID = 509985) )