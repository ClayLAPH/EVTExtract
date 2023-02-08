﻿create table dbo.SARS2_INCIDENT_ARCHIVE(
	PR_ROWID int NOT NULL,
	PR_PHTYPE varchar(255) NULL,
	PR_LEGACY_ROWID varchar(50) NULL,
	PR_PERSONDR int NULL,
	PR_USERDR int NULL,
	PR_OUTBREAKDRSTEXT varchar(max) NULL,
	PR_INCIDENTID int NOT NULL,
	PR_CMRRECORD varchar(50) NOT NULL,
	PR_NAMESPACE varchar(4) NOT NULL,
	PR_CREATEDATE datetime NOT NULL,
	PR_ONSETDATE datetime NULL,
	PR_CLOSEDDATE datetime NULL,
	PR_EPISODEDATE datetime NULL,
	PR_STANDARDAGE real NULL,
	PR_DATESUBMITTED datetime NULL,
	PR_DATEREPORTEDBY datetime NULL,
	PR_REPORTSOURCEDR int NULL,
	PR_MRN varchar(50) NULL,
	PR_CLUSTERID varchar(8000) NULL,
	PR_ISINDEXCASE bit NULL,
	PR_DISEASE varchar(255) NULL,
	PR_DISEASESHORTNAME varchar(100) NULL,
	PR_OTHERDISEASE varchar(200) NULL,
	PR_DISTRICT varchar(255) NULL,
	PR_PROCESSSTATUS varchar(255) NULL,
	PR_SPA varchar(255) NULL,
	PR_RESOLUTIONSTATUS varchar(255) NULL,
	PR_NURSEINVESTIGATOR varchar(202) NOT NULL,
	PR_REPORTEDBYWEB bit NULL,
	PR_REPORTEDBYLAB bit NULL,
	PR_REPORTEDBYEHR bit NULL,
	PR_TRANSMISSIONSTATUS varchar(255) NULL,
	PR_DISEASECODE_DR int NULL,
	PR_DISTRICTCODE_DR int NULL,
	PR_PROCESSSTATUSCODE_DR int NULL,
	PR_SPACODE_DR int NULL,
	PR_RESOLUTIONSTATUSCODE_DR int NULL,
	PR_NURSEINVESTIGATORDR int NULL,
	PR_SPECIMENTYPE nvarchar(max) NULL,
	PR_SPECIMENDATECOLLECTED nvarchar(max) NULL,
	PR_SPECIMENDATERECEIVED nvarchar(max) NULL,
	PR_SPECIMENRESULT nvarchar(max) NULL,
	PR_SPECIMENNOTE nvarchar(max) NULL,
	PR_DIAGSPECIMENTYPES varchar(8000) NULL,
	PR_EXPEXPOSURETYPES varchar(8000) NULL,
	PR_HEPATITISDRS varchar(8000) NULL,
	PR_DISEASEGROUPS varchar(8000) NULL,
	PR_RESULTVALUE nvarchar(max) NULL,
	PR_LIPTESTORDERED varchar(8000) NULL,
	PR_ISPREGNANT bit NULL,
	PR_EXPECTEDDELIVERYDATE datetime NULL,
	PR_LIPRESULTNOTES nvarchar(max) NULL,
	PR_LIPRESULTNAME varchar(8000) NULL,
	PR_HEALTHCAREPROVIDERLOCATIONDR int NULL,
	PR_NOTES varchar(max) NULL,
	PR_DATEOFDIAGNOSIS datetime NULL,
	PR_DATEOFDEATH datetime NULL,
	PR_DATEOFLABREPORT datetime NULL,
	PR_DATEINVESTIGATORRECEIVED datetime NULL,
	PR_ISSYMPTOMATIC bit NULL,
	PR_ISPATIENTDIEDOFTHEILLNESS bit NULL,
	PR_ISPATIENTHOSPITALIZED bit NULL,
	PR_LABSPECIMENCOLLECTEDDATE datetime NULL,
	PR_LABSPECIMENRESULTDATE datetime NULL,
	PR_DATEADMITTED datetime NULL,
	PR_DATEDISCHARGED datetime NULL,
	PR_LABORATORY varchar(250) NULL,
	PR_HOSPITALDR int NULL,
	PR_HOSPITAL varchar(250) NULL,
	PR_OUTPATIENT bit NULL,
	PR_INPATIENT bit NULL,
	PR_DATESENT datetime NULL,
	PR_LASTCDCUPDATE datetime NULL,
	PR_NAMEOFSUBMITTER varchar(8000) NULL,
	PR_OUTBREAKNUMBERS varchar(max) NULL,
	PR_OUTBREAKTYPES varchar(max) NULL,
	PR_ANIMALREPORTID int NULL,
	PR_FBIDR int NULL,
	PR_FBINumber varchar(50) NULL,
	PR_CENSUSTRACT varchar(100) NULL,
	Additional_Provider varchar(8000) NULL,
	Additional_Laboratory varchar(8000) NULL,
	Age real NULL,
	American_Indian_or_Alaska_Native nvarchar(max) NOT NULL,
	Asian___Specify nvarchar(max) NOT NULL,
	Black_or_African_American___Spec nvarchar(max) NOT NULL,
	CMR_ID varchar(50) NOT NULL,
	Country_of_Birth varchar(255) NOT NULL,
	Created_By varchar(14) NOT NULL,
	Date_Last_Edited datetime NULL,
	Final_Disposition varchar(255) NOT NULL,
	Diagnostic_Specimen_Types nvarchar(max) NOT NULL,
	Health_District_Number varchar(255) NOT NULL,
	ImportedBy varchar(202) NULL,
	Imported_Status varchar(30) NULL,
	Lab_Report varchar(5) NOT NULL,
	Lab_Report_Notes varchar(8000) NOT NULL,
	Lab_Report_Test_Name varchar(255) NOT NULL,
	Marital_Status varchar(255) NOT NULL,
	Medical_Record_Number varchar(50) NOT NULL,
	Most_Recent_Lab_Result varchar(1100) NOT NULL,
	Most_Recent_Lab_Result_Value varchar(8000) NOT NULL,
	Native_Hawaiian_or_Other_Pacific nvarchar(max) NOT NULL,
	Occupation_Setting_Type varchar(255) NOT NULL,
	Other___Specify nvarchar(max) NOT NULL,
	Outbreak_IDs varchar(max) NOT NULL,
	Parent_or_Guardian_Name varchar(50) NOT NULL,
	Priority varchar(255) NOT NULL,
	Provider_Name varchar(255) NOT NULL,
	Report_Source varchar(250) NOT NULL,
	Secondary_District varchar(255) NOT NULL,
	Suspected_Exposure_Types nvarchar(max) NOT NULL,
	Type_of_Contact varchar(255) NOT NULL,
	Unknown___Specify nvarchar(max) NOT NULL,
	White___Specify nvarchar(max) NOT NULL
)