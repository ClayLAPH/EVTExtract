﻿create view dbo.All_Incident as
select  
  pr.PR_ROWID, 
  pr.PR_DISEASECODE_DR Disease,
  pr.PR_PHTYPE, 
  a.PR_LEGACY_ROWID, 
  pr.PR_PERSONDR, 
  pr.PR_USERDR, 
  pr.PR_OUTBREAKDRSTEXT, 
  pr.PR_INCIDENTID, 
  pr.PR_CMRID PR_CMRRECORD, 
  per.DVPER_Namespace PR_NAMESPACE, 
  pr.PR_CREATEDATE, 
  pr.PR_ONSETDATE, 
  pr.PR_CLOSEDDATE, 
  pr.PR_EPISODEDATE, 
  pr.PR_STANDARDAGE, 
  pr.PR_DATESUBMITTED, 
  pr.PR_DATEREPORTEDBY, 
  pr.PR_REPORTSOURCEDR, 
  pr.PR_MRN, 
  pr.PR_CLUSTERID, 
  pr.PR_ISINDEXCASE, 
  pr.PR_DISEASE, 
  pr.PR_DISEASESHORTNAME, 
  a.PR_OTHERDISEASE, 
  pr.PR_DISTRICT, 
  pr.PR_PROCESSSTATUS, 
  pr.PR_SPA, 
  pr.PR_RESOLUTIONSTATUS,
  pr.PR_NURSEINVESTIGATOR,
  a.PR_REPORTEDBYWEB, 
  a.PR_REPORTEDBYLAB, 
  a.PR_REPORTEDBYEHR, 
  a.PR_TRANSMISSIONSTATUS, 
  pr.PR_DISEASECODE_DR, 
  pr.PR_DISTRICTCODE_DR, 
  pr.PR_PROCESSSTATUSCODE_DR, 
  pr.PR_SPACODE_DR, 
  pr.PR_RESOLUTIONSTATUSCODE_DR, 
  pr.PR_NURSEINVESTIGATORDR, 
  pr.PR_SPECIMENTYPE, 
  pr.PR_SPECIMENDATECOLLECTED, 
  pr.PR_SPECIMENDATERECEIVED, 
  pr.PR_SPECIMENRESULT, 
  pr.PR_SPECIMENNOTE, 
  a.PR_DIAGSPECIMENTYPES, 
  a.PR_EXPEXPOSURETYPES, 
  a.PR_HEPATITISDRS, 
  a.PR_DISEASEGROUPS, 
  a.PR_RESULTVALUE, 
  a.PR_LIPTESTORDERED, 
  a.PR_ISPREGNANT,
  a.PR_EXPECTEDDELIVERYDATE, 
  pr.PR_LIPRESULTNOTES, 
  pr.PR_LIPRESULTNAME, 
  pr.PR_HEALTHCAREPROVIDERLOCATIONDR, 
  a.PR_NOTES, 
  pr.PR_DATEOFDIAGNOSIS, 
  a.PR_DATEOFDEATH, 
  PR_DATEOFLABREPORT = cl.availabilityTime, 
  a.PR_DATEINVESTIGATORRECEIVED, 
  a.PR_ISSYMPTOMATIC, 
  a.PR_ISPATIENTDIEDOFTHEILLNESS, 
  a.PR_ISPATIENTHOSPITALIZED, 
  a.PR_LABSPECIMENCOLLECTEDDATE, 
  a.PR_LABSPECIMENRESULTDATE, 
  a.PR_DATEADMITTED, 
  a.PR_DATEDISCHARGED, 
  pr.PR_LABORATORY, 
  a.PR_HOSPITALDR, 
  a.PR_HOSPITAL, 
  a.PR_OUTPATIENT, 
  a.PR_INPATIENT, 
  pr.PR_DATESENT, 
  pr.PR_LASTCDCUPDATE, 
  a.PR_NAMEOFSUBMITTER, 
  pr.PR_OUTBREAKNUMBERS, 
  pr.PR_OUTBREAKTYPES, 
  a.PR_ANIMALREPORTID, 
  a.PR_FBIDR, 
  a.PR_FBINumber, 
  per.DVPER_CensusTract PR_CENSUSTRACT,
  pr.Additional_Provider, 
  pr.Additional_Laboratory, 
  pr.pr_standardage Age, 
  CMR_ID = pr.pr_cmrid, 
  per.Country_of_Birth, 
  pr.Created_By, 
  pr.pr_datelastedited Date_Last_Edited, 
  pr.Final_Disposition,
  Diagnostic_Specimen_Types = a.PR_DIAGSPECIMENTYPES,
  Health_District_Number = pr.Health_District_Number,
  ImportedBy = pr.ImportedBy,
  Imported_Status = coalesce(cast(pr.pr_importedstatus as varchar), ''),
  Lab_Report= case pr.pr_reportedbylab when 1 then 'True' else 'False' end,
  Lab_Report_Notes = isnull(pr.pr_lipresultnotes, ''),
  pr.Lab_Report_Test_Name,
  Marital_Status = per.DVPER_MaritalStatus,
  Medical_Record_Number = isnull(pr.PR_MRN, ''),
  Most_Recent_Lab_Result = coalesce(cl.Most_Recent_Lab_Result,''),
  Most_Recent_Lab_Result_Value = coalesce(pr.PR_LIPRESULTVALUE,cl.Most_Recent_Lab_Result_Value,''),
  Occupation_Setting_Type = per.DVPER_OccupationSettingTypeSpecify,
  pr.PR_OUTBREAKDRSTEXT Outbreak_IDs,
  Parent_or_Guardian_Name = per.DVPER_GuardianName,
  pr.Priority,
  Provider_Name = pr.PR_PROVIDERNAME,
  pr.Report_Source,
  pr.Secondary_District,
  pr.Suspected_Exposure_Types,
  pr.Type_of_Contact,
  prs.American_Indian_or_Alaska_Native__Specify, 
  prs.Race_Category__American_Indian_or_Alaska_Native, 
  prs.Asian__Specify, 
  prs.Race_Category__Asian, 
  prs.Black_or_African_American__Specify, 
  prs.Race_Category__Black_or_African_American, 
  prs.Native_Hawaiian_or_Other_Pacific_Islander__Specify, 
  prs.Race_Category__Native_Hawaiian_or_Other_Pacific_Islander, 
  prs.Other__Specify, 
  prs.Race_Category__Other, 
  prs.Unknown__Specify, 
  prs.Race_Category__Unknown, 
  prs.White__Specify, 
  prs.Race_Category__White

from   
  internals.allincidentpersonalrecord pr with (nolock)
  inner join 
  internals.allincidentperson per with (nolock)
  on 
    pr.PR_PERSONDR = per.dvper_rowid
  inner join
  internals.allincidentacts a with (nolock)
  on
    a.PR_ROWID = pr.PR_RowID
  left outer join
  internals.allincidentlab cl with (nolock)
  on
    a.PR_ROWID = cl.Id
  left outer join 
  dbo.PersonRaces prs
  on
    per.DVPER_RowID = prs.PER_ROWID

