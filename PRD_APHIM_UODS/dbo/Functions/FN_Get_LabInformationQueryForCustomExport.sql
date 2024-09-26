
CREATE FUNCTION [dbo].[FN_Get_LabInformationQueryForCustomExport]
 (@TblLabInfoSection SystemFormFields READONLY)
RETURNS NVARCHAR(max)
AS
BEGIN
    DECLARE @SQLLabInfo NVARCHAR(max) = ''
    DECLARE @SQLLabInfoExportData NVARCHAR(max) = ''
    IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField_Form = 'LABINFO')
    BEGIN
        SET @SQLLabInfo = ' SELECT TMP.Act_ID, LABREPORT.ID AS LabReportID '
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_AccessionNumber')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', LABREPORT.title AS DILR_AccessionNumber  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_AccessionNumber', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_HL7FileName')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', LABREPORT.Code_OrTx AS DILR_HL7FileName  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_HL7FileName', 'EXPOSUREEVENTID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_ResultTest')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_ResultTest AS DILR_ResultTest  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_ResultTest', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_AbnormalFlag')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', UCSABNORMALFLAG.fullName AS DILR_AbnormalFlag  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_AbnormalFlag', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_ImportStatus')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_ImportStatus AS DILR_ImportStatus  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_ImportStatus', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_IsFromHL7')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_IsFromHL7 AS DILR_IsFromHL7  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_IsFromHL7', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_LIPTestStatus')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', UCSLABRESULTSTATUS.fullName AS DILR_LIPTestStatus  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_LIPTestStatus', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_LocalOrganismCode')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_LocalOrganismCode AS DILR_LocalOrganismCode  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_LocalOrganismCode', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_LocalOrganismDescription')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_LocalOrganismDescription AS DILR_LocalOrganismDescription  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_LocalOrganismDescription', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_LocalTestCode')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_LocalTestCode AS DILR_LocalTestCode  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_LocalTestCode', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_LocalTestDescription')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_LocalTestDescription AS DILR_LocalTestDescription  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_LocalTestDescription', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_Notes')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_Notes AS DILR_Notes  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_Notes', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_OrganismCode')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_OrganismCode AS DILR_OrganismCode  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_OrganismCode', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_OrganismCodingSystemID')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', UCSORGCODINGSYSTEM.CONCEPTCODE AS DILR_OrganismCodingSystemID  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_OrganismCodingSystemID', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_OrganismDescription')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_OrganismDescription AS DILR_OrganismDescription  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_OrganismDescription', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_PatientName')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_PatientName AS DILR_PatientName  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_PatientName', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_PerformingFacilityID')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_PerformingFacilityID AS DILR_PerformingFacilityID  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_PerformingFacilityID', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_PersonVerifiedResult')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_PersonVerifiedResult AS DILR_PersonVerifiedResult  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_PersonVerifiedResult', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_PFGEPattern1st')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_PFGEPattern1st AS DILR_PFGEPattern1st  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_PFGEPattern1st', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_PFGEPattern2nd')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_PFGEPattern2nd AS DILR_PFGEPattern2nd  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_PFGEPattern2nd', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_ReferenceRange')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_ReferenceRange AS DILR_ReferenceRange  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_ReferenceRange', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_ResultDate')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', Convert(Date,AXLAB.DILR_ResultDate) AS DILR_ResultDate  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_ResultDate', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_ResultStatus')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', UCSResult.fullName AS DILR_ResultStatus  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_ResultStatus', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_ResultUnit')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_ResultUnit AS DILR_ResultUnit  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_ResultUnit', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_ResultValue')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_ResultValue AS DILR_ResultValue  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_ResultValue', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_Serogroup')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_Serogroup AS DILR_Serogroup  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_Serogroup', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_Serology')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_Serology AS DILR_Serology  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_Serology', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_Serotype')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_Serotype AS DILR_Serotype  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_Serotype', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_Species')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_Species AS DILR_Species  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_Species', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_SpecBodySite')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', UCSSPECBODYSITE.fullName AS DILR_SpecBodySite  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_SpecBodySite', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_SpecCollectedDate')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', Convert(Date,AXLAB.DILR_SpecCollectedDate) AS DILR_SpecCollectedDate  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_SpecCollectedDate', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_SpecimenSource')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', UCSSPECIMENSOURCE.fullName AS DILR_SpecimenSource  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_SpecimenSource', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_SpecimenSourceText')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_SpecimenSourceText AS DILR_SpecimenSourceText  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_SpecimenSourceText', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_SpecReceivedDate')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', Convert(Date, AXLAB.DILR_SpecReceivedDate) AS DILR_SpecReceivedDate  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_SpecReceivedDate', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_TestCode')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_TestCode AS DILR_TestCode  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_TestCode', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_TestCodingSystemID')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', UCSTESTCODINGSYSTEM.CONCEPTCODE AS DILR_TestCodingSystemID  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_TestCodingSystemID', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_TestDescription')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', (CASE WHEN ISNULL(AXLAB.DILR_IsFromHL7,0)=0 THEN (CASE WHEN ISNULL(AXLAB.DILR_TestDescription,'''')<>'''' 
            THEN (CASE WHEN ISNUMERIC(AXLAB.DILR_TestDescription) = 1  
                THEN DBO.FN_GetUCSFullName(AXLAB.DILR_TestDescription) 
            ELSE AXLAB.DILR_TestDescription END) ELSE '''' END) ELSE AXLAB.DILR_TestDescription END) AS DILR_TestDescription   ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_TestDescription', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_ProviderName')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_ProviderName AS DILR_ProviderName  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_ProviderName', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_ProviderID')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_ProviderID AS DILR_ProviderID  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_ProviderID', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_ProviderAddress')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_ProviderAddress AS DILR_ProviderAddress  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_ProviderAddress', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_ProviderCity')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_ProviderCity AS DILR_ProviderCity  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_ProviderCity', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_ProviderState')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_ProviderState AS DILR_ProviderState  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_ProviderState', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_ProviderCounty')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_ProviderCounty AS DILR_ProviderCounty  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_ProviderCounty', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_ProviderZip')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_ProviderZip AS DILR_ProviderZip  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_ProviderZip', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_ProviderPhone')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_ProviderPhone AS DILR_ProviderPhone  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_ProviderPhone', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_ProviderEmail')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_ProviderEmail AS DILR_ProviderEmail  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_ProviderEmail', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_ProviderFax')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_ProviderFax AS DILR_ProviderFax  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_ProviderFax', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_FacilityName')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_FacilityName AS DILR_FacilityName  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_FacilityName', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_FacilityAddress')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_FacilityAddress AS DILR_FacilityAddress  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_FacilityAddress', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_FacilityCity')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_FacilityCity AS DILR_FacilityCity  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_FacilityCity', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_FacilityState')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_FacilityState AS DILR_FacilityState  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_FacilityState', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_FacilityCounty')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_FacilityCounty AS DILR_FacilityCounty  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_FacilityCounty', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_FacilityZip')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_FacilityZip AS DILR_FacilityZip  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_FacilityZip', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_FacilityPhone')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_FacilityPhone AS DILR_FacilityPhone  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_FacilityPhone', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_PlacerOrderNo')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_PlacerOrderNo AS DILR_PlacerOrderNo  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_PlacerOrderNo', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_FacilityEmail')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_FacilityEmail AS DILR_FacilityEmail  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_FacilityEmail', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_FacilityID')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_FacilityID AS DILR_FacilityID  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_FacilityID', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_StatusCode')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', LABREPORT.statusCode AS DILR_StatusCode  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_StatusCode', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_RELEVANTCLINICALINFORMATION')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_RELEVANTCLINICALINFORMATION AS DILR_RELEVANTCLINICALINFORMATION  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_RelevantClinicalInformation', 'LabReportID')
        END
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_REASONFORSTUDY')
        BEGIN
            SET @SQLLabInfo = @SQLLabInfo + ', AXLAB.DILR_REASONFORSTUDY AS DILR_REASONFORSTUDY  ' 
            SET @SQLLabInfoExportData = @SQLLabInfoExportData + dbo.[FN_Get_SystemSectionCustomExportData]('LABINFO', 'DILR_ReasonForStudy', 'LabReportID')
        END
        SET @SQLLabInfo = @SQLLabInfo + ' INTO #TMPSystemTable     
        FROM #tmp_DI_UDVals_temp TMP (NOLOCK)
        LEFT JOIN dbo.A_Act AS LABREPORT (NOLOCK) ON LABREPORT.ACT_PARENT_ID=TMP.Act_ID   AND LABREPORT.metaCode = ''DILR_ID'' 
        AND LABREPORT.statusCode=''active''
        LEFT JOIN  dbo.Ax_LabReport AS AXLAB (NOLOCK) on AXLAB.DILR_ID = LABREPORT.ID     '   
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_AbnormalFlag')
        SET @SQLLabInfo = @SQLLabInfo + ' LEFT OUTER JOIN dbo.V_UnifiedCodeSet AS UCSABNORMALFLAG (NOLOCK) ON AXLAB.DILR_AbnormalFlagCode_ID = UCSABNORMALFLAG.ID   '
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_LIPTestStatus')
        SET @SQLLabInfo = @SQLLabInfo + ' LEFT OUTER JOIN dbo.V_UnifiedCodeSet AS UCSLABRESULTSTATUS (NOLOCK) ON AXLAB.DILR_LIPTestStatusCode_ID = UCSLABRESULTSTATUS.ID  '
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_ResultStatus')
        SET @SQLLabInfo = @SQLLabInfo + ' LEFT OUTER JOIN dbo.V_UnifiedCodeSet AS UCSResult (NOLOCK) ON AXLAB.DILR_ResultStatusCode_ID = UCSResult.ID   '
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_SpecBodySite')
        SET @SQLLabInfo = @SQLLabInfo + ' LEFT OUTER JOIN dbo.V_UnifiedCodeSet AS UCSSPECBODYSITE (NOLOCK) ON AXLAB.DILR_SpecBodySiteCode_ID = UCSSPECBODYSITE.ID  '
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_SpecimenSource') 
        SET @SQLLabInfo = @SQLLabInfo + ' LEFT OUTER JOIN dbo.V_UnifiedCodeSet AS UCSSPECIMENSOURCE (NOLOCK) ON AXLAB.DILR_SpecimenSourceCode_ID = UCSSPECIMENSOURCE.ID  '
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_TestCodingSystemID')
        SET @SQLLabInfo = @SQLLabInfo + ' LEFT OUTER JOIN V_UNIFIEDCODESET AS UCSTESTCODINGSYSTEM (NOLOCK) ON AXLAB.DILR_TestCodingSystem_ID=UCSTESTCODINGSYSTEM.ID  '
        IF EXISTS (SELECT * FROM @TblLabInfoSection WHERE LinkedSystemField = 'DILR_OrganismCodingSystemID')
        SET @SQLLabInfo = @SQLLabInfo + ' LEFT OUTER JOIN V_UNIFIEDCODESET AS UCSORGCODINGSYSTEM (NOLOCK) ON AXLAB.DILR_OrganismCodingSystem_ID=UCSORGCODINGSYSTEM.ID  '
         
        SET @SQLLabInfo = @SQLLabInfo + ' LEFT JOIN V_UnifiedCodeSet UCSNameSpace (NOLOCK) ON UCSNameSpace.ID = AXLAB.DILR_SourceCode_ID   
        WHERE  ISNULL(UCSNameSpace.conceptCode, '''') <> ''WEB''     '
        SET @SQLLabInfo = @SQLLabInfo + ' ; CREATE CLUSTERED INDEX IX_LAB ON #TMPSystemTable(Act_ID, LabReportID) '
        SET @SQLLabInfo = @SQLLabInfo + @SQLLabInfoExportData
    END
    RETURN @SQLLabInfo
END
