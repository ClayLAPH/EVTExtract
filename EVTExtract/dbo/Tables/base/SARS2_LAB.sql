﻿create table dbo.SARS2_LAB
(
	IncidentID varchar(50) NULL,
  IncidentIDInt as try_cast( IncidentId as int ) persisted,
	PHRECORDID int NOT NULL,
	LabReportID int NOT NULL,
	ACCESSIONNUMBER varchar(300) NULL,
	HL7FILENAME varchar(255) NULL,
	ABNORMALFLAG varchar(255) NULL,
	IMPORTSTATUS varchar(1500) NULL,
	ISFROMHL7 bit NULL,
  LABRESULTSTATUS varchar(255),
	ORDERSTATUS varchar(255) NULL,
	LOCALORGANISMCODE varchar(1270) NULL,
	LOCALORGANISMDESCRIPTION varchar(1550) NULL,
	LOCALTESTCODE varchar(255) NULL,
	LOCALTESTDESCRIPTION varchar(1000) NULL,
	NOTES varchar(max) NULL,
	ORGANISMCODE varchar(255) NULL,
	ORGANISMDESCRIPTION varchar(300) NULL,
	PATIENTNAME varchar(255) NULL,
	PERFORMINGFACILITYID varchar(255) NULL,
	PERSONVERIFIEDRESULT varchar(255) NULL,
	PFGEPATTERN1ST varchar(255) NULL,
	PFGEPATTERN2ND varchar(255) NULL,
	REFERENCERANGE varchar(255) NULL,
	RESULTDATE datetime2(3) NULL,
	RESULTSTATUS varchar(255) NULL,
	RESULTUNIT varchar(255) NULL,
	RESULTVALUE varchar(4000) NULL,
	SEROGROUP varchar(300) NULL,
	SEROLOGY varchar(300) NULL,
	SEROTYPE varchar(300) NULL,
	SPECIES varchar(300) NULL,
	SPECBODYSITE varchar(255) NULL,
	SPECCOLLECTEDDATE datetime2(3) NULL,
	SPECIMENSOURCE varchar(255) NULL,
	SPECRECEIVEDDATE datetime2(3) NULL,
	TESTCODE varchar(255) NULL,
	TESTDESCRIPTION varchar(1000) NULL,
	DILR_StatusCode varchar(50) NULL,
	PROVIDERNAME varchar(255) NULL,
	PROVIDERID varchar(255) NULL,
	PROVIDERADDRESS varchar(255) NULL,
	PROVIDERCITY varchar(255) NULL,
	PROVIDERSTATE varchar(255) NULL,
	PROVIDERCOUNTY varchar(255) NULL,
	PROVIDERZIP varchar(255) NULL,
	PROVIDERPHONE varchar(255) NULL,
	PROVIDEREMAIL varchar(255) NULL,
	PROVIDERFAX varchar(255) NULL,
	FACILITYNAME varchar(255) NULL,
	FACILITYADDRESS varchar(255) NULL,
	FACILITYCITY varchar(255) NULL,
	FACILITYSTATE varchar(255) NULL,
	FACILITYCOUNTY varchar(255) NULL,
	FACILITYZIP varchar(255) NULL,
	FACILITYPHONE varchar(255) NULL,
	PLACERORDERNO varchar(255) NULL,
	FACILITYEMAIL varchar(255) NULL,
	FACILITYID varchar(255) NULL,
	EXTENDEDRESULTVALUE nvarchar(max) NULL,
	TESTCODINGSYSTEM varchar(50) NULL,
	ORGANISMCODINGSYSTEM varchar(50) NULL,
	RESULTEDORGANISM varchar(300) NULL,
	RESULTTEXT varchar(1100) NULL,
  SPECIMENSOURCETEXT varchar(705) NULL,
	LOCALORGANISMDESCRIPTIONTEXT varchar(1550) NULL,
	LOCALORGANISMCODETEXT varchar(1270) NULL,
	RELEVANTCLINICALINFORMATION nvarchar(300) NULL,
	REASONFORSTUDY nvarchar(199) NULL,
  LABNAME varchar(250) null,
  CLIA varchar(50) null,
  LABADDR1 varchar(50) null,
  LABADDR2 varchar(50) null,
  LABADDR3 varchar(50) null,
  HL7TimestampOfMessage datetime null,
  TimestampMessageReceived datetime null
)
go
create clustered index [SARS2_LAB.IncidentIDInt.Fake.PrimaryKey]
on dbo.SARS2_LAB(IncidentIDInt);
go
create index [SARS2_LAB.LabReportID.Index]
on dbo.SARS2_LAB(LabReportID);
