﻿create table dbo.All_Lab
(
	Disease int not null,
	IncidentID varchar(50) null,
  IncidentIDInt as try_cast( IncidentId as int ) persisted,
	PHRECORDID int not null,
	LabReportID int not null,
	ACCESSIONNUMBER varchar(300) null,
	HL7FILENAME varchar(255) null,
	ABNORMALFLAG varchar(255) null,
	IMPORTSTATUS varchar(1500) null,
	ISFROMHL7 bit null,
	LABRESULTSTATUS varchar(255) null,
	ORDERSTATUS varchar(255) null,
	LOCALORGANISMCODE varchar(1270) null,
	LOCALORGANISMDESCRIPTION varchar(1550) null,
	LOCALTESTCODE varchar(255) null,
	LOCALTESTDESCRIPTION varchar(1000) null,
	NOTES varchar(max) null,
	ORGANISMCODE varchar(255) null,
	ORGANISMDESCRIPTION varchar(300) null,
	PATIENTNAME varchar(255) null,
	PERFORMINGFACILITYID varchar(255) null,
	PERSONVERIFIEDRESULT varchar(255) null,
	PFGEPATTERN1ST varchar(255) null,
	PFGEPATTERN2ND varchar(255) null,
	REFERENCERANGE varchar(255) null,
	RESULTDATE datetime2(3) null,
	RESULTSTATUS varchar(255) null,
	RESULTUNIT varchar(255) null,
	RESULTVALUE varchar(4000) null,
	SEROGROUP varchar(300) null,
	SEROLOGY varchar(300) null,
	SEROTYPE varchar(300) null,
	SPECIES varchar(300) null,
	SPECBODYSITE varchar(255) null,
	SPECCOLLECTEDDATE datetime2(3) null,
	SPECIMENSOURCE varchar(255) null,
	SPECRECEIVEDDATE datetime2(3) null,
	TESTCODE varchar(255) null,
	TESTDESCRIPTION varchar(1000) null,
	DILR_StatusCode varchar(50) null,
	PROVIDERNAME varchar(255) null,
	PROVIDERID varchar(255) null,
	PROVIDERADDRESS varchar(255) null,
	PROVIDERCITY varchar(255) null,
	PROVIDERSTATE varchar(255) null,
	PROVIDERCOUNTY varchar(255) null,
	PROVIDERZIP varchar(255) null,
	PROVIDERPHONE varchar(255) null,
	PROVIDEREMAIL varchar(255) null,
	PROVIDERFAX varchar(255) null,
	FACILITYNAME varchar(255) null,
	FACILITYADDRESS varchar(255) null,
	FACILITYCITY varchar(255) null,
	FACILITYSTATE varchar(255) null,
	FACILITYCOUNTY varchar(255) null,
	FACILITYZIP varchar(255) null,
	FACILITYPHONE varchar(255) null,
	PLACERORDERNO varchar(255) null,
	FACILITYEMAIL varchar(255) null,
	FACILITYID varchar(255) null,
	EXTENDEDRESULTVALUE nvarchar(max) null,
	TESTCODINGSYSTEM varchar(50) null,
	ORGANISMCODINGSYSTEM varchar(50) null,
	RESULTEDORGANISM varchar(300) null,
	RESULTTEXT varchar(1100) null,
	SPECIMENSOURCETEXT varchar(705) null,
	LOCALORGANISMDESCRIPTIONTEXT varchar(1550) null,
	LOCALORGANISMCODETEXT varchar(1270) null,
	RELEVANTCLINICALINFORMATION nvarchar(300) null,
	REASONFORSTUDY nvarchar(199) null,
  LABNAME varchar(250) null,
  CLIA varchar(50) null,
  LABADDR1 varchar(50) null,
  LABADDR2 varchar(50) null,
  LABADDR3 varchar(50) null,
  HL7TimestampOfMessage datetime null,
  TimestampMessageReceived datetime null
)
go
create clustered index [All_Lab.Fake.PrimaryKey] on dbo.All_Lab ( IncidentIdInt, Disease )
go
create index [All_Lab.LabReportId] on dbo.All_Lab( LabReportID )  
