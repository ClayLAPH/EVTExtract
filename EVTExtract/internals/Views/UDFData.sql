create view internals.UDFData as
select
  DATEFIELDFORMAT ='mm/dd/yyy',
  RECORD_ID = PHCASE.ID,
  FORM_INSTANCE_ID = VFORM.UDFormID,
  FORM_DEF_DR = VCPUDF.FRM_ID,  
  Form_DEF_ID = VCPUDF.SUBJCODE_ID,
  FORM_NAME = VFORM.UDFormName,  
  FORM_SHOW_IN_CMR = VCPUDF.FRM_InCMR,    
  FORM_SHOW_IN_NCM = VCPUDF.FRM_InNCM, 
  FORM_DESCRIPTION = VFORM.UDFormDesc,  
  FORM_CREATEDATE = VFORM.UDFormCreateDate , 
  FORM_NUMBER = (select fn.MultiInstanceFormNumber from internals.GetMultiInstanceFormNumber(PHCASE.ID, VCPUDF.FRM_IsMultipleInstance, VFORM.UDFormID) fn ),
  FORM_IsMultipleInstance = VCPUDF.FRM_IsMultipleInstance,
  SECTION_INSTANCE_ID = VFORM.UDSectionActID,  
  SECTION_DEF_DR = VFORM.Sec_ID,   
  SECTION_NAME = VFORM.UDSecName,    
  SECTION_STATUS = 
    case 
      when (select VTD.ACTIVE from [$(PRD_APHIM_UODS)].dbo.V_TERMDICTIONARY VTD with (nolock) where VFORM.UDSectionDefID = VTD.TERMCODE_ID) > 0 
      then 'ACTIVE' 
      else 'INACTIVE' 
    end, 
  SECTION_TYPE = 
    case 
      when (select VCP.SEC_ISLISTSECTION from [$(PRD_APHIM_UODS)].dbo.VCP_UDSECTION  VCP with (nolock) where VFORM.UDSectionDefID = VCP.SubjCode_ID) > 0 
      then 'LIST' 
      else 'NON-LIST' 
    end,
  SECTION_NUMBER = (select sn.ListSectionNumber from internals.GetDependentListSectionNumber(UDFormID) sn  where sn.SecActID = VFORM.UDSectionActID),
  FIELD_INSTANCE_ID = VFORM.UDFieldActID, 
  FIELD_DEF_DR = VFORM.Field_ID,     
  FIELD_NAME = VFORM.UDFieldName,    
  FIELD_IS_REQUIRED = case when VFORM.UDFieldIsRequired=1 then 'TRUE' else 'FALSE' end,
  FIELD_VALUE = 
    case 
      when VFORM.UDField_valueENTITYID > 1 
      then (select * from internals.GetUdfFieldValue(null, null, VFORM.UDField_valueENTITYID, null, VFORM.UDField_metaCodeUCSID) )
      else (select * from internals.GetUdfFieldValue(VFORM.UDField_valueDateTime, VFORM.UDField_valueString, VFORM.UDField_valueENTITYID, VFORM.UDField_valueUCSID, VFORM.UDField_metaCodeUCSID) )
    end, 
  FIELD_CONCEPT_CODE_VALUE = 
    case 
      when VFORM.UDField_valueENTITYID > 1
      then cast(VFORM.UDField_valueENTITYID AS varchar(100))
      else (select cc.conceptCode from internals.GetUDFFieldUCSValueAsConceptCode( VFORM.UDField_valueUCSID) cc)
    end, 
  FIELD_STATUS = case when VTDField.Active=1 then 'ACTIVE' else 'INACTIVE' end,  
  FIELD_TYPE = UCSFieldType.FullName
from 
  [$(PRD_APHIM_UODS)].dbo.A_ACT                       PHCASE  with (nolock)
  inner join 
  [$(PRD_APHIM_UODS)].ATLASINTERNAL.VIEW_UODS_UDFORM  VFORM with (nolock) 
  on 
    VFORM.Act_ID = PHCASE.ID
  inner join 
  [$(PRD_APHIM_UODS)].dbo.VCP_UDFORM                  VCPUDF with (nolock) 
  on  
    VCPUDF.SUBJCODE_ID = VFORM.UDFormDefID
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_TERMDICTIONARY            VTDFIELD with (nolock) 
  on 
    VTDFIELD.TERMCODE_ID=VFORM.UDFIELDID 
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET            UCSFIELDTYPE with (nolock) 
  on 
    UCSFIELDTYPE.ID=VFORM.FIELD_TYPECODE_ID    
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.AX_UDFVALUES                AFIELD with (nolock) 
  on 
    AFIELD.ID=VFORM.UDFIELDACTID
where  
  PHCASE.classCode in('case','OUTB','TOPIC') and 
  PHCASE.metaCode in('PR_RowID','OB_RowID','AI_ROWID','SVC_ID','GE_RowID')and 
  PHCASE.statusCode not in ('nullified','terminated')
--end -- BLK Normal Sections
--START -- BLK SHARED ACROSS RECORD SECTIONS
union all
(
  select 
  DATEFIELDFORMAT ='mm/dd/yyy',
  RECORD_ID = PHCASE.ID,
  FORM_INSTANCE_ID = VFORM.UDFormID,
  FORM_DEF_DR = VCPUDF.FRM_ID,  
  Form_DEF_ID = VCPUDF.SUBJCODE_ID,
  FORM_NAME = VFORM.UDFormName,  
  FORM_SHOW_IN_CMR = VCPUDF.FRM_InCMR,    
  FORM_SHOW_IN_NCM = VCPUDF.FRM_InNCM, 
  FORM_DESCRIPTION = VFORM.UDFormDesc,  
  FORM_CREATEDATE = VFORM.UDFormCreateDate , 
  FORM_NUMBER = (select fn.MultiInstanceFormNumber from internals.GetMultiInstanceFormNumber(PHCASE.ID, VCPUDF.FRM_IsMultipleInstance, VFORM.UDFormID) fn ),
  FORM_IsMultipleInstance = VCPUDF.FRM_IsMultipleInstance,
  SECTION_INSTANCE_ID = VFORM.UDSectionActID,  
  SECTION_DEF_DR = VFORM.Sec_ID,   
  SECTION_NAME = VFORM.UDSecName,    
  SECTION_STATUS = 
    case 
      when (select VTD.ACTIVE from [$(PRD_APHIM_UODS)].dbo.V_TERMDICTIONARY VTD with (nolock) where VFORM.UDSectionDefID = VTD.TERMCODE_ID) > 0 
      then 'ACTIVE' 
      else 'INACTIVE' 
    end, 
  SECTION_TYPE = 
    case 
      when (select VCP.SEC_ISLISTSECTION from [$(PRD_APHIM_UODS)].dbo.VCP_UDSECTION  VCP with (nolock) where VFORM.UDSectionDefID = VCP.SubjCode_ID) > 0 
      then 'LIST' 
      else 'NON-LIST' 
    end,
  SECTION_NUMBER =  ( select ListSectionNumber from internals.GetIndependentListSectionNumber(PHCASE.ID)  where SecActID = UDSectionActID),    
  FIELD_INSTANCE_ID = VFORM.UDFieldActID, 
  FIELD_DEF_DR = VFORM.Field_ID,     
  FIELD_NAME = VFORM.UDFieldName,    
  FIELD_IS_REQUIRED = case when VFORM.UDFieldIsRequired=1 then 'TRUE' else 'FALSE' end,
  FIELD_VALUE = 
    case 
      when VFORM.UDField_valueENTITYID > 1 
      then (select * from internals.GetUdfFieldValue(null, null, VFORM.UDField_valueENTITYID, null, VFORM.UDField_metaCodeUCSID) )
      else (select * from internals.GetUdfFieldValue(VFORM.UDField_valueDateTime, VFORM.UDField_valueString, VFORM.UDField_valueENTITYID, VFORM.UDField_valueUCSID, VFORM.UDField_metaCodeUCSID) )
    end, 
  FIELD_CONCEPT_CODE_VALUE = 
    case 
      when VFORM.UDField_valueENTITYID > 1
      then cast(VFORM.UDField_valueENTITYID AS varchar(100))
      else (select cc.conceptCode from internals.GetUDFFieldUCSValueAsConceptCode( VFORM.UDField_valueUCSID) cc)
    end, 
  FIELD_STATUS = case when VTDField.Active=1 then 'ACTIVE' else 'INACTIVE' end,  
  FIELD_TYPE = UCSFieldType.FullName
from 
  [$(PRD_APHIM_UODS)].dbo.A_ACT                                       PHCASE  with (nolock)  
  inner join 
  [$(PRD_APHIM_UODS)].[ATLASPUBLIC].[VIEWUDF_SHAREDACROSSCASESECTION] VFORM with (nolock) 
  on 
    VFORM.ACT_ID=PHCASE.ID
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.VCP_UDFORM                                  VCPUDF with (nolock) 
  on  
    VCPUDF.SUBJCODE_ID = UDFORMDEFID
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_TERMDICTIONARY                            VTDFIELD with (nolock) 
  on 
    VTDFIELD.TERMCODE_ID=VFORM.UDFIELDID    
  left outer join   
  [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET                            UCSFIELDTYPE with (nolock) 
    on UCSFIELDTYPE.ID=VFORM.FIELD_TYPECODE_ID    
where  
  PHCASE.Classcode in('case','OUTB','TOPIC') and 
  PHCASE.METACODE in('PR_RowID','OB_RowID','AI_ROWID','SVC_ID','GE_RowID') and 
  PHCASE.Statuscode not in ('nullified','terminated')
)
--end -- BLK SHARED ACROSS RECORD SECTIONS

--START -- BLK SHARED ACROSS PERSON SECTIONS
union all

(
select 
  DATEFIELDFORMAT ='mm/dd/yyy',
  RECORD_ID = PHCASE.ID,
  FORM_INSTANCE_ID = VFORM.UDFormID,
  FORM_DEF_DR = VCPUDF.FRM_ID,  
  Form_DEF_ID = VCPUDF.SUBJCODE_ID,
  FORM_NAME = VFORM.UDFormName,  
  FORM_SHOW_IN_CMR = VCPUDF.FRM_InCMR,    
  FORM_SHOW_IN_NCM = VCPUDF.FRM_InNCM, 
  FORM_DESCRIPTION = VFORM.UDFormDesc,  
  FORM_CREATEDATE = VFORM.UDFormCreateDate , 
  FORM_NUMBER = (select fn.MultiInstanceFormNumber from internals.GetMultiInstanceFormNumber(PHCASE.ID, VCPUDF.FRM_IsMultipleInstance, VFORM.UDFormID) fn ),
  FORM_IsMultipleInstance = VCPUDF.FRM_IsMultipleInstance,
  SECTION_INSTANCE_ID = VFORM.UDSectionActID,  
  SECTION_DEF_DR = VFORM.Sec_ID,   
  SECTION_NAME = VFORM.UDSecName,    
  SECTION_STATUS = 
    case 
      when (select VTD.ACTIVE from [$(PRD_APHIM_UODS)].dbo.V_TERMDICTIONARY VTD with (nolock) where VFORM.UDSectionDefID = VTD.TERMCODE_ID) > 0 
      then 'ACTIVE' 
      else 'INACTIVE' 
    end, 
  SECTION_TYPE = 
    case 
      when (select VCP.SEC_ISLISTSECTION from [$(PRD_APHIM_UODS)].dbo.VCP_UDSECTION  VCP with (nolock) where VFORM.UDSectionDefID = VCP.SubjCode_ID) > 0 
      then 'LIST' 
      else 'NON-LIST' 
    end,
  SECTION_NUMBER = ( select ListSectionNumber from internals.GetIndependentListSectionNumber(PHCASE.Act_Parent_ID)  where SecActID = UDSectionActID),    
  FIELD_INSTANCE_ID = VFORM.UDFieldActID, 
  FIELD_DEF_DR = VFORM.Field_ID,     
  FIELD_NAME = VFORM.UDFieldName,    
  FIELD_IS_REQUIRED = case when VFORM.UDFieldIsRequired=1 then 'TRUE' else 'FALSE' end,
  FIELD_VALUE = 
    case 
      when VFORM.UDField_valueENTITYID > 1 
      then (select * from internals.GetUdfFieldValue(null, null, VFORM.UDField_valueENTITYID, null, VFORM.UDField_metaCodeUCSID) )
      else (select * from internals.GetUdfFieldValue(VFORM.UDField_valueDateTime, VFORM.UDField_valueString, VFORM.UDField_valueENTITYID, VFORM.UDField_valueUCSID, VFORM.UDField_metaCodeUCSID) )
    end, 
  FIELD_CONCEPT_CODE_VALUE = 
    case 
      when VFORM.UDField_valueENTITYID > 1
      then cast(VFORM.UDField_valueENTITYID AS varchar(100))
      else (select cc.conceptCode from internals.GetUDFFieldUCSValueAsConceptCode( VFORM.UDField_valueUCSID) cc)
    end, 
  FIELD_STATUS = case when VTDField.Active=1 then 'ACTIVE' else 'INACTIVE' end,  
  FIELD_TYPE = UCSFieldType.FullName
from 
    [$(PRD_APHIM_UODS)].dbo.A_ACT PHCASE with (nolock)   
    inner join [$(PRD_APHIM_UODS)].[ATLASPUBLIC].[VIEWUDF_SHAREDACROSSPERSONSECTION] VFORM with (nolock) on VFORM.ACT_ID=PHCASE.ID
    left outer join [$(PRD_APHIM_UODS)].dbo.VCP_UDFORM VCPUDF with (nolock) on  VCPUDF.SUBJCODE_ID = UDFORMDEFID  
    left outer join [$(PRD_APHIM_UODS)].dbo.V_TERMDICTIONARY VTDFIELD with (nolock) on VTDFIELD.TERMCODE_ID=VFORM.UDFIELDID    
    left outer join [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET UCSFIELDTYPE with (nolock) on UCSFIELDTYPE.ID=VFORM.FIELD_TYPECODE_ID    
    
where  
      PHCASE.Classcode = 'case' 
      and PHCASE.METACODE in('PR_RowID','SVC_ID')
      and PHCASE.Statuscode not in ('nullified','terminated')
)
--end -- BLK SHARED ACROSS PERSON SECTIONS
