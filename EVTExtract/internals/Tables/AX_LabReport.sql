create table internals.AX_LabReport
(
	DILR_PatientName varchar(255) null,
	DILR_ImportStatus varchar(1500) null,
	DILR_SpecCollectedDate datetime null,
	DILR_SpecReceivedDate datetime null,
	DILR_TestCode varchar(255) null,
	DILR_TestDescription varchar(1000) null,
	DILR_TestCodingSystem_ID int null,
	DILR_LocalTestCode varchar(255) null,
	DILR_LocalTestDescription varchar(1000) null,
	DILR_OrganismCode varchar(255) null,
	DILR_OrganismDescription varchar(300) null,
	DILR_OrganismCodingSystem_ID int null,
	DILR_LocalOrganismCode varchar(1270) null,
	DILR_LocalOrganismDescription varchar(1550) null,
	DILR_ResultValue varchar(4000) null,
	DILR_ResultUnit varchar(255) null,
	DILR_ReferenceRange varchar(255) null,
	DILR_ResultDate datetime null,
	DILR_PerformingFacilityID varchar(255) null,
	DILR_PersonVerifiedResult varchar(255) null,
	DILR_Notes varchar(max) null,
	DILR_ProviderName varchar(255) null,
	DILR_ProviderID varchar(255) null,
	DILR_ProviderPhone varchar(255) null,
	DILR_ProviderAddress varchar(255) null,
	DILR_ProviderCity varchar(255) null,
	DILR_ProviderState varchar(255) null,
	DILR_ProviderZip varchar(255) null,
	DILR_ProviderCounty varchar(255) null,
	DILR_ProviderFax varchar(255) null,
	DILR_ProviderEmail varchar(255) null,
	DILR_FacilityName varchar(255) null,
	DILR_FacilityID varchar(255) null,
	DILR_PlacerOrderNo varchar(255) null,
	DILR_FacilityAddress varchar(255) null,
	DILR_FacilityCity varchar(255) null,
	DILR_FacilityState varchar(255) null,
	DILR_FacilityZip varchar(255) null,
	DILR_FacilityCounty varchar(255) null,
	DILR_FacilityPhone varchar(255) null,
	DILR_FacilityEmail varchar(255) null,
	DILR_IsFromHL7 bit null,
	DILR_Serology varchar(300) null,
	DILR_Species varchar(300) null,
	DILR_Serogroup varchar(300) null,
	DILR_Serotype varchar(300) null,
	DILR_PFGEPattern1st varchar(255) null,
	DILR_PFGEPattern2nd varchar(255) null,
	DILR_SpecimenSourceText varchar(705) null,
	DILR_AbnormalFlagCode_ID int null,
	DILR_LIPTestStatusCode_ID int null,
	DILR_ResultStatusCode_ID int null,
	DILR_SourceCode_ID int null,
	DILR_SpecBodySiteCode_ID int null,
	DILR_SpecimenSourceCode_ID int null,
	DILR_StatusCode_ID int null,
	DILR_ID int not null
    constraint [LabReport.DILR_ID.PrimaryKey]
      primary key clustered,
	DILR_LaboratoryDR int null,
	DILR_SpecimenResult_ID int null,
	DILR_SpecimenType_ID int null,
	DILR_ImportStatus_ID int null,
	DILR_ResultTest varchar(1100) null,
	DILR_MessageType varchar(50) null,
	DILR_ProviderPhoneAlphaUp varchar(50) null,
	DILR_FacilityPhoneAlphaUp varchar(50) null,
	DILR_IsAttachedToLive bit null,
	DILR_MessageTypeID int not null,
	DILR_ResultValueEx nvarchar(max) null,
	DILR_RelevantClinicalInformation nvarchar(300) null,
	DILR_ReasonForStudy nvarchar(199) null,
	DILR_StandardResultValue numeric(18, 0) null,
	DILR_StandardResultUnitDR int null
)

go
--create nonclustered index  IX_E_Ax_LabReport_Laboratory on internals.AX_LabReport(DILR_LaboratoryDR) with (fillfactor = 90);
--go
--create nonclustered index  IX_A_Ax_LabReport_AbnormalFlag on internals.AX_LabReport(DILR_AbnormalFlagCode_ID) with (fillfactor = 90);
--go
--create nonclustered index  IX_A_Ax_LabReport_LIPTestStatus on internals.AX_LabReport(DILR_LIPTestStatusCode_ID) with (fillfactor = 90);
--go
--create nonclustered index  IX_A_Ax_LabReport_OrganismCodingSystem on internals.AX_LabReport(DILR_OrganismCodingSystem_ID) with (fillfactor = 90);
--go
--create nonclustered index  IX_A_Ax_LabReport_ResultStatus on internals.AX_LabReport(DILR_ResultStatusCode_ID) with (fillfactor = 90);
--go
--create nonclustered index  IX_A_Ax_LabReport_SourceCode on internals.AX_LabReport(DILR_SourceCode_ID) with (fillfactor = 90);
--go
--create nonclustered index  IX_A_Ax_LabReport_SpecBodySite on internals.AX_LabReport(DILR_SpecBodySiteCode_ID) with (fillfactor = 90);
--go
--create nonclustered index  IX_A_Ax_LabReport_SpecimenResult on internals.AX_LabReport(DILR_SpecimenResult_ID) with (fillfactor = 90);
--go
--create nonclustered index  IX_A_Ax_LabReport_SpecimenSourceCode on internals.AX_LabReport(DILR_SpecimenSourceCode_ID) with (fillfactor = 90);
--go
--create nonclustered index  IX_A_Ax_LabReport_SpecimenType on internals.AX_LabReport(DILR_SpecimenType_ID) with (fillfactor = 90);
--go
--create nonclustered index  IX_A_Ax_LabReport_StandardResultUnit on internals.AX_LabReport(DILR_StandardResultUnitDR) with (fillfactor = 90);
--go
--create nonclustered index  IX_A_Ax_LabReport_StatusCodeT on internals.AX_LabReport(DILR_StatusCode_ID) with (fillfactor = 90);
--go
--create nonclustered index  IX_A_Ax_LabReport_TestCodingSystem on internals.AX_LabReport(DILR_TestCodingSystem_ID) with (fillfactor = 90);
--go
--create nonclustered index  IX_Ax_LabReport_ImportStatus on internals.AX_LabReport(DILR_ImportStatus_ID) with (fillfactor = 90);

