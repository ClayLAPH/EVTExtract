﻿create view dbo.UDF_CATALOG as
select distinct
FORM_DEF_DR, Form_DEF_ID, FORM_NAME, FORM_SHOW_IN_CMR, FORM_SHOW_IN_NCM, FORM_DESCRIPTION,  FORM_NUMBER, FORM_IsMultipleInstance, SECTION_DEF_DR, SECTION_NAME, SECTION_STATUS, SECTION_TYPE, FIELD_DEF_DR, FIELD_NAME, FIELD_IS_REQUIRED, FIELD_STATUS, FIELD_TYPE
from dbo.SARS2_UDF_DATA_COMBINED
union 
select distinct
FORM_DEF_DR, Form_DEF_ID, FORM_NAME, FORM_SHOW_IN_CMR, FORM_SHOW_IN_NCM, FORM_DESCRIPTION,  FORM_NUMBER, FORM_IsMultipleInstance, SECTION_DEF_DR, SECTION_NAME, SECTION_STATUS, SECTION_TYPE, FIELD_DEF_DR, FIELD_NAME, FIELD_IS_REQUIRED, FIELD_STATUS, FIELD_TYPE
from dbo.COVID_OUTBREAK_UDF_DATA
union 
select distinct
FORM_DEF_DR, Form_DEF_ID, FORM_NAME, FORM_SHOW_IN_CMR, FORM_SHOW_IN_NCM, FORM_DESCRIPTION,  FORM_NUMBER, FORM_IsMultipleInstance, SECTION_DEF_DR, SECTION_NAME, SECTION_STATUS, SECTION_TYPE, FIELD_DEF_DR, FIELD_NAME, FIELD_IS_REQUIRED, FIELD_STATUS, FIELD_TYPE
from dbo.COVID_UDF_DATA
union 
select distinct
FORM_DEF_DR, Form_DEF_ID, FORM_NAME, FORM_SHOW_IN_CMR, FORM_SHOW_IN_NCM, FORM_DESCRIPTION,  FORM_NUMBER, FORM_IsMultipleInstance, SECTION_DEF_DR, SECTION_NAME, SECTION_STATUS, SECTION_TYPE, FIELD_DEF_DR, FIELD_NAME, FIELD_IS_REQUIRED, FIELD_STATUS, FIELD_TYPE
from dbo.All_UDF_Data
