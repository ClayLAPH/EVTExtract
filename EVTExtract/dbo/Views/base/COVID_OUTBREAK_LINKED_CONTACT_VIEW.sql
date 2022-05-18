create view dbo.COVID_OUTBREAK_LINKED_CONTACT_VIEW as
select -- top 100 percent
  DVOB_RowID = OUTB_RowID , 
  LinkedPatientContacts = ISNULL(CONT_LastName, '') + ', ' + ISNULL(CONT_FirstName, ''), 
  IncidentID = CONT_RecordInstanceDR, 
  concatenated = ISNULL(CONT_LastName,'') + ', ' + ISNULL(CONT_FirstName, '') + ' ' + CAST(CONT_RecordInstanceDR  as varchar(20))
from            
  ( select
      rel.source_ID  OUTB_RowID, 
      pr.DVPR_IncidentID  CONT_RecordInstanceDR, 
      per.DVPER_LastName  CONT_LastName, 
      per.DVPER_FirstName  CONT_FirstName
    from 
      (
        [$(PRD_APHIM_UODS)].dbo.DV_PHPersonalRecord pr with (nolock) 
        inner join
        [$(PRD_APHIM_UODS)].dbo.A_ActRelationship   rel with (nolock) 
        on 
          rel.target_ID = pr.DVPR_RowID 
        inner join
        [$(PRD_APHIM_UODS)].dbo.P_Participation     ind with (nolock) 
        on 
          pr.DVPR_RowID = ind.Act_ID and 
          ind.typeCode = 'ind' 
        inner join
        [$(PRD_APHIM_UODS)].dbo.R_Role              expr with (nolock) 
        on 
          expr.ID = ind.Role_ID and 
          expr.classCode = 'expr' 
        inner join
        [$(PRD_APHIM_UODS)].dbo.R_Role              mbr with (nolock) 
        on 
          mbr.scoper_ID = expr.player_ID and 
          mbr.classCode = 'mbr' and 
          mbr.statusCode <> 'nullified' and 
          mbr.statusCode <> 'terminated' 
        inner join
        internals.DV_Person                         per with (nolock) 
        on 
          per.DVPER_RowID = mbr.player_ID 
      )
      left outer join
      [$(PRD_APHIM_UODS)].dbo.P_Participation       sbj with (nolock) 
      on 
        mbr.ID = sbj.Role_ID and 
        sbj.typeCode = 'sbj' 
      left outer join
      [$(PRD_APHIM_UODS)].dbo.T_Attribute           cluster with (nolock) 
      on 
        cluster.Act_ID = sbj.Act_ID and 
        cluster.name = 'rlent_clusterid' and 
        cluster.type = 'st' 
      left outer join
      [$(PRD_APHIM_UODS)].dbo.T_Attribute           contactType with (nolock) 
      on 
        contactType.Role_ID = mbr.ID and 
        contactType.name = 'rlent_contacttype' 
      left outer join
      [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet      contactTypeName with (nolock) 
      on 
        contactTypeName.ID = contactType.valueCode_ID
    where
      rel.source_ID IN
      ( select        
          DVOB_RowID
        from            
          [$(PRD_APHIM_UODS)].dbo.DV_Outbreak       outb with (nolock)
        WHERE        
          outb.DVOB_DiseaseCode_ID = 543030 and
          pr.DVPR_TypeDR = 494681
      )
    union
    select 
      outb.DVOB_RowID, 
      ''  CONT_RecordInstanceDR, 
      per.DVPER_LastName, 
      per.DVPER_FirstName
    from            
      [$(PRD_APHIM_UODS)].dbo.DV_Outbreak           outb with (nolock) 
      inner join
      [$(PRD_APHIM_UODS)].dbo.P_Participation       ind with (nolock) 
      on 
        outb.DVOB_RowID = ind.Act_ID and 
        ind.typeCode = 'ind' 
      inner join
      [$(PRD_APHIM_UODS)].dbo.R_Role                expr with (nolock) 
      on 
        expr.ID = ind.Role_ID and 
        expr.classCode = 'expr' 
      inner join
      [$(PRD_APHIM_UODS)].dbo.R_Role                mbr with (nolock) 
      on 
        mbr.scoper_ID = expr.player_ID and 
        mbr.classCode = 'mbr' and 
        mbr.statusCode <> 'nullified' and 
        mbr.statusCode <> 'terminated' 
      inner join
      internals.DV_Person                           per with (nolock) 
      on 
        per.DVPER_RowID = mbr.player_ID 
      left outer join
      [$(PRD_APHIM_UODS)].dbo.P_Participation       sbj with (nolock) 
      on  
        mbr.ID = sbj.Role_ID and 
        sbj.typeCode = 'sbj' 
      left outer join
      [$(PRD_APHIM_UODS)].dbo.T_Attribute           cluster with (nolock) 
      on 
        cluster.Act_ID = sbj.Act_ID and 
        cluster.name = 'rlent_clusterid' and 
        cluster.type = 'st' 
      left outer join
      [$(PRD_APHIM_UODS)].dbo.T_Attribute           contactType with (nolock) 
      on 
        contactType.Role_ID = mbr.ID and 
        contactType.name = 'rlent_contacttype' 
      left outer join
      [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet      contactTypeName with (nolock) 
      on 
        contactTypeName.ID = contactType.valueCode_ID
    where
      outb.DVOB_RowID in
      ( select 
          DVOB_RowID
        from 
          [$(PRD_APHIM_UODS)].dbo.DV_Outbreak       outb with (nolock)
        where 
          DVOB_DiseaseCode_ID = 543030
      )
  ) u