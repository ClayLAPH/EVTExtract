﻿create table dbo.All_Outbreak_UDF_Data
(
  Disease int not null,
	RECORD_ID int NOT NULL,  
	FORM_INSTANCE_ID int NULL,
	FORM_DEF_DR varchar(50) NULL,
	Form_DEF_ID int NULL,
	FORM_NAME varchar(255) NULL,
	FORM_SHOW_IN_CMR bit NULL,
	FORM_SHOW_IN_NCM bit NULL,
	FORM_DESCRIPTION varchar(max) NULL,
	FORM_CREATEDATE datetime NULL,
	FORM_NUMBER int NULL,
	FORM_IsMultipleInstance bit NULL,
	SECTION_INSTANCE_ID int NOT NULL,
	SECTION_DEF_DR varchar(50) NULL,
	SECTION_NAME varchar(255) NULL,
	SECTION_STATUS varchar(8) NOT NULL,
	SECTION_TYPE varchar(8) NOT NULL,
	SECTION_NUMBER int NULL,
	FIELD_INSTANCE_ID int NOT NULL,
	FIELD_DEF_DR varchar(50) NULL,
	FIELD_NAME varchar(255) NULL,
	FIELD_IS_REQUIRED varchar(5) NOT NULL,
	FIELD_VALUE varchar(max) NULL,
	FIELD_CONCEPT_CODE_VALUE varchar(100) NULL,
	FIELD_STATUS varchar(8) NOT NULL,
	FIELD_TYPE varchar(255) NULL
)
go
create clustered index [All_Outbreak_UDF_Data.FIELD_DEF_DR] on dbo.All_Outbreak_UDF_Data( RECORD_ID, FIELD_DEF_DR, Disease )


