﻿create procedure dbo.ExtractSARS2IncidentArchive
  @isRestart tinyint = 0
as
begin

  set nocount on;
  declare 
    @name sysname = 'SARS2_INCIDENT_ARCHIVE',
    @instance int = next value for dbo.InstanceSequence,
    @status sysname = 'starts',
    @rows int = 0,
    @messageText nvarchar(max) = null,
    @hasError bit = 0;

  --set transaction isolation level snapshot
  
  execute dbo.SetProcessingStatus @status, @name, @instance;

  begin try
    truncate table dbo.SARS2_INCIDENT_ARCHIVE2;
    insert dbo.SARS2_INCIDENT_ARCHIVE2(  
      PR_ROWID, PR_PHTYPE, PR_LEGACY_ROWID, PR_PERSONDR, PR_USERDR, PR_OUTBREAKDRSTEXT, PR_INCIDENTID, PR_CMRRECORD, PR_NAMESPACE, PR_CREATEDATE, 
      PR_ONSETDATE, PR_CLOSEDDATE, PR_EPISODEDATE, PR_STANDARDAGE, PR_DATESUBMITTED, PR_DATEREPORTEDBY, PR_REPORTSOURCEDR, PR_MRN, PR_CLUSTERID, 
      PR_ISINDEXCASE, PR_DISEASE, PR_DISEASESHORTNAME, PR_OTHERDISEASE, PR_DISTRICT, PR_PROCESSSTATUS, PR_SPA, PR_RESOLUTIONSTATUS, PR_NURSEINVESTIGATOR, 
      PR_REPORTEDBYWEB, PR_REPORTEDBYLAB, PR_REPORTEDBYEHR, PR_TRANSMISSIONSTATUS, PR_DISEASECODE_DR, PR_DISTRICTCODE_DR, PR_PROCESSSTATUSCODE_DR, 
      PR_SPACODE_DR, PR_RESOLUTIONSTATUSCODE_DR, PR_NURSEINVESTIGATORDR, PR_SPECIMENTYPE, PR_SPECIMENDATECOLLECTED, PR_SPECIMENDATERECEIVED, PR_SPECIMENRESULT, 
      PR_SPECIMENNOTE, PR_DIAGSPECIMENTYPES, PR_EXPEXPOSURETYPES, PR_HEPATITISDRS, PR_DISEASEGROUPS, PR_RESULTVALUE, PR_LIPTESTORDERED, PR_ISPREGNANT, 
      PR_EXPECTEDDELIVERYDATE, PR_LIPRESULTNOTES, PR_LIPRESULTNAME, PR_HEALTHCAREPROVIDERLOCATIONDR, PR_NOTES, PR_DATEOFDIAGNOSIS, PR_DATEOFDEATH, PR_DATEOFLABREPORT, 
      PR_DATEINVESTIGATORRECEIVED, PR_ISSYMPTOMATIC, PR_ISPATIENTDIEDOFTHEILLNESS, PR_ISPATIENTHOSPITALIZED, PR_LABSPECIMENCOLLECTEDDATE, PR_LABSPECIMENRESULTDATE, 
      PR_DATEADMITTED, PR_DATEDISCHARGED, PR_LABORATORY, PR_HOSPITALDR, PR_HOSPITAL, PR_OUTPATIENT, PR_INPATIENT, PR_DATESENT, PR_LASTCDCUPDATE, PR_NAMEOFSUBMITTER, 
      PR_OUTBREAKNUMBERS, PR_OUTBREAKTYPES, PR_ANIMALREPORTID, PR_FBIDR, PR_FBINumber, PR_CENSUSTRACT, Additional_Provider, Additional_Laboratory, 
      Age, American_Indian_or_Alaska_Native, Asian___Specify, Black_or_African_American___Spec, CMR_ID, Country_of_Birth, Created_By, Date_Last_Edited, 
      Final_Disposition, Diagnostic_Specimen_Types, Health_District_Number, ImportedBy, Imported_Status, Lab_Report, Lab_Report_Notes, Lab_Report_Test_Name, 
      Marital_Status, Medical_Record_Number, Most_Recent_Lab_Result, Most_Recent_Lab_Result_Value, Native_Hawaiian_or_Other_Pacific, Occupation_Setting_Type, 
      Other___Specify, Outbreak_IDs, Parent_or_Guardian_Name, Priority, Provider_Name, Report_Source, Secondary_District, Suspected_Exposure_Types, Type_of_Contact, 
      Unknown___Specify, White___Specify ) 
    select 
      PR_ROWID, PR_PHTYPE, PR_LEGACY_ROWID, PR_PERSONDR, PR_USERDR, PR_OUTBREAKDRSTEXT, PR_INCIDENTID, PR_CMRRECORD, PR_NAMESPACE, PR_CREATEDATE, 
      PR_ONSETDATE, PR_CLOSEDDATE, PR_EPISODEDATE, PR_STANDARDAGE, PR_DATESUBMITTED, PR_DATEREPORTEDBY, PR_REPORTSOURCEDR, PR_MRN, PR_CLUSTERID, 
      PR_ISINDEXCASE, PR_DISEASE, PR_DISEASESHORTNAME, PR_OTHERDISEASE, PR_DISTRICT, PR_PROCESSSTATUS, PR_SPA, PR_RESOLUTIONSTATUS, PR_NURSEINVESTIGATOR, 
      PR_REPORTEDBYWEB, PR_REPORTEDBYLAB, PR_REPORTEDBYEHR, PR_TRANSMISSIONSTATUS, PR_DISEASECODE_DR, PR_DISTRICTCODE_DR, PR_PROCESSSTATUSCODE_DR, 
      PR_SPACODE_DR, PR_RESOLUTIONSTATUSCODE_DR, PR_NURSEINVESTIGATORDR, PR_SPECIMENTYPE, PR_SPECIMENDATECOLLECTED, PR_SPECIMENDATERECEIVED, PR_SPECIMENRESULT, 
      PR_SPECIMENNOTE, PR_DIAGSPECIMENTYPES, PR_EXPEXPOSURETYPES, PR_HEPATITISDRS, PR_DISEASEGROUPS, PR_RESULTVALUE, PR_LIPTESTORDERED, PR_ISPREGNANT, 
      PR_EXPECTEDDELIVERYDATE, PR_LIPRESULTNOTES, PR_LIPRESULTNAME, PR_HEALTHCAREPROVIDERLOCATIONDR, PR_NOTES, PR_DATEOFDIAGNOSIS, PR_DATEOFDEATH, PR_DATEOFLABREPORT, 
      PR_DATEINVESTIGATORRECEIVED, PR_ISSYMPTOMATIC, PR_ISPATIENTDIEDOFTHEILLNESS, PR_ISPATIENTHOSPITALIZED, PR_LABSPECIMENCOLLECTEDDATE, PR_LABSPECIMENRESULTDATE, 
      PR_DATEADMITTED, PR_DATEDISCHARGED, PR_LABORATORY, PR_HOSPITALDR, PR_HOSPITAL, PR_OUTPATIENT, PR_INPATIENT, PR_DATESENT, PR_LASTCDCUPDATE, PR_NAMEOFSUBMITTER, 
      PR_OUTBREAKNUMBERS, PR_OUTBREAKTYPES, PR_ANIMALREPORTID, PR_FBIDR, PR_FBINumber, PR_CENSUSTRACT, Additional_Provider, Additional_Laboratory, 
      Age, American_Indian_or_Alaska_Native, Asian___Specify, Black_or_African_American___Spec, CMR_ID, Country_of_Birth, Created_By, Date_Last_Edited, 
      Final_Disposition, Diagnostic_Specimen_Types, Health_District_Number, ImportedBy, Imported_Status, Lab_Report, Lab_Report_Notes, Lab_Report_Test_Name, 
      Marital_Status, Medical_Record_Number, Most_Recent_Lab_Result, Most_Recent_Lab_Result_Value, Native_Hawaiian_or_Other_Pacific, Occupation_Setting_Type, 
      Other___Specify, Outbreak_IDs, Parent_or_Guardian_Name, Priority, Provider_Name, Report_Source, Secondary_District, Suspected_Exposure_Types, Type_of_Contact, 
      Unknown___Specify, White___Specify
    from 
        [$(LACCovid)].covid.SARS2_INCIDENT si
    where 
        si.PR_INCIDENTID in (select sa2.DVPR_IncidentID from internals.Sars2Archive2 sa2)
        and
        si.PR_INCIDENTID not in (select sa.DVPR_IncidentID from internals.Sars2Archive sa)

    select @rows = @@rowcount;
    select @status = 'ends';
    execute dbo.SetProcessingStatus @status, @name, @instance, @rows;
  end try
  begin catch
    select  @status ='error', @messageText = error_message();
    execute dbo.SetProcessingStatus @status, @name, @instance, null, @messageText;
    select @hasError = 1;
  end catch

  if ( @hasError = 1 and @isRestart = 0 ) 
  begin
    waitfor delay '00:01';
    execute dbo.ExtractSARS2IncidentArchive @isRestart = 1;
  end


  return 0;

end


