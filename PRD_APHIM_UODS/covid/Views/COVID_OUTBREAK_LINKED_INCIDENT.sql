create view [covid].[COVID_OUTBREAK_LINKED_INCIDENT]
as
SELECT 
[dv_outbreak].[dvob_rowid],
[dv_person].[dvper_lastname] + ', ' +
[dv_person].[dvper_firstname] [LinkedIndividuals], 
[dv_phpersonalrecord].[dvpr_incidentid] [IncidentID],
[v_unifiedcodeset].[conceptcode] [RecordType],
[dv_person].[dvper_lastname] + ', ' +
[dv_person].[dvper_firstname] + ' ' +  
CAST([dv_phpersonalrecord].[dvpr_incidentid] AS VARCHAR) + ' ' + 
[v_unifiedcodeset].[conceptcode] [concatendated]
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
       WHERE  ( [dv_outbreak].[dvob_rowid] in (select DVOB_RowID from DV_Outbreak where DVPR_DiseaseCode_ID IN (543030, 544041)) )