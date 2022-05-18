﻿create table dbo.All_Person
(
  Disease int not null,
	PER_ROWID int NOT NULL,
	PER_LEGACY_ROWID varchar(50) NULL,
	PER_COUNTRYOFBIRTHDR varchar(100) NULL,
	PER_CELLPHONE varchar(100) NULL,
	PER_DATEOFARRIVAL datetime NULL,
	PER_OCCUPATIONLOCATION varchar(255) NULL,
	PER_OCCUPATIONSPECIFY varchar(50) NULL,
	PER_OCCUPATIONSETTINGTYPEDR int NULL,
	PER_OCCUPATIONSETTINGTYPESPECIFY varchar(50) NULL,
	PER_ROOTID int NULL,
	PER_LASTNAME varchar(100) NULL,
	PER_FIRSTNAME varchar(100) NULL,
	PER_MIDDLENAME varchar(100) NULL,
	PER_SSN varchar(50) NULL,
	PER_HOMEPHONE varchar(100) NULL,
	PER_WORKPHONE varchar(100) NULL,
	PER_STREETADDRESS varchar(100) NULL,
	PER_APARTMENT varchar(100) NULL,
	PER_CITY varchar(100) NULL,
	PER_STATE varchar(100) NULL,
	PER_STATENUMBER varchar(255) NULL,
	PER_ZIP varchar(100) NULL,
	PER_ClientID int NULL,
	PER_COUNTYOFRESIDENCE varchar(255) NULL,
	PER_CENSUSTRACT varchar(100) NULL,
	PER_LATITUDE varchar(100) NULL,
	PER_LONGITUDE varchar(100) NULL,
	PER_ADDRESSSTANDARDIZED varchar(50) NULL,
	PER_COUNTYFIPS varchar(100) NULL,
	PER_COUNTY varchar(100) NULL,
	PER_CENSUSBLOCK varchar(100) NULL,
	PER_ZIPPLUS4 varchar(100) NULL,
	PER_COUNTRY varchar(100) NULL,
	PER_COUNTRY_NAME varchar(255) NULL,
	PER_DOB datetime NULL,
	PER_SEX varchar(255) NULL,
	PER_RACE varchar(255) NULL,
	PER_ETHNICITY varchar(255) NULL,
	PER_OCCUPATION varchar(255) NULL,
	PER_SEXCODE_DR int NULL,
	PER_RACECODE_DR int NULL,
	PER_ETHNICITYCODE_DR int NULL,
	PER_OCCUPATIONCODE_DR int NULL,
	PER_NAMESUFFIX varchar(50) NULL,
	PER_RECORDCREATEDBY varchar(14) NOT NULL,
	PER_WORKSCHOOLLOCATION varchar(250) NULL,
	PER_WORKSCHOOLCONTACT varchar(max) NULL,
	PER_PRIMARYLANGUAGE_DR int NULL,
	PER_PRIMARYLANGUAGE varchar(255) NULL,
	PER_EMAIL varchar(max) NULL,
	PER_ELECTRONICCONTACT varchar(max) NULL,
	PER_CURRENTVERSION varchar(1) NOT NULL,
	PER_DATEOFDEATH datetime NULL,
	PER_PERSONSTATUS varchar(255) NULL,
	PER_STATUSFLAG varchar(255) NULL,
	PER_PRIMARYNATIONALITY varchar(255) NULL,
	PER_THIRDNAME varchar(100) NULL,
	PER_FOURTHNAME varchar(100) NULL,
	PER_NAMEPREFIX varchar(50) NULL
)
go
create clustered index [All_Person.Fake.PrimaryKey] on dbo.All_Person( PER_ROWID, Disease);
