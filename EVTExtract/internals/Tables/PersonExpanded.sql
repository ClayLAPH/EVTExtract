﻿create table internals.PersonExpanded
(
	PER_ROWID int NOT NULL,
	PER_LEGACY_ROWID varchar(50) NULL,
	PER_CELLPHONE varchar(100) NULL,
	PER_ROOTID int NULL,
	PER_LASTNAME varchar(100) NULL,
	PER_FIRSTNAME varchar(100) NULL,
	PER_SSN varchar(50) NULL,
	PER_HOMEPHONE varchar(100) NULL,
	PER_WORKPHONE varchar(100) NULL,
	PER_STREETADDRESS varchar(100) NULL,
	PER_APARTMENT varchar(100) NULL,
	PER_CITY varchar(100) NULL,
	PER_STATE varchar(100) NULL,
	PER_ZIP varchar(100) NULL,
	PER_ClientID int NULL,
	PER_DOB datetime NULL,
	PER_SEX varchar(255) NULL,
	PER_RACE varchar(255) NULL,
	PER_ETHNICITY varchar(255) NULL,
	PER_OCCUPATION varchar(255) NULL,
	PER_SEXCODE_DR int NULL,
	PER_RACECODE_DR int NULL,
	PER_ETHNICITYCODE_DR int NULL,
	PER_OCCUPATIONCODE_DR int NULL,
	PER_RECORDCREATEDBY varchar(14) NOT NULL,
	PER_CURRENTVERSION varchar(1) NOT NULL,
	PER_DATEOFDEATH datetime NULL,
	PER_PERSONSTATUS varchar(255) NULL,
	PER_STATUSFLAG varchar(255) NULL,
	PER_PRIMARYNATIONALITY varchar(255) NULL,
	LINKID int NOT NULL,
	ADDRID int NULL
)
go
create clustered index [PersonExpanded.PER_ROWID.FakePrimaryKey]
on 
  internals.PersonExpanded(PER_ROWID)