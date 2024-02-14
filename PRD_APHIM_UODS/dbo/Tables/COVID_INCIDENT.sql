﻿CREATE TABLE [dbo].[COVID_INCIDENT] (
    [PR_ROWID]                         INT              NOT NULL,
    [PR_PHTYPE]                        VARCHAR (255)    NULL,
    [PR_LEGACY_ROWID]                  VARCHAR (50)     NULL,
    [PR_PERSONDR]                      INT              NULL,
    [PR_USERDR]                        INT              NULL,
    [PR_OUTBREAKDRSTEXT]               TEXT             NULL,
    [PR_INCIDENTID]                    INT              NOT NULL,
    [PR_CMRRECORD]                     VARCHAR (50)     NOT NULL,
    [PR_NAMESPACE]                     VARCHAR (4)      NOT NULL,
    [PR_CREATEDATE]                    DATETIME2 (3)    NOT NULL,
    [PR_ONSETDATE]                     DATETIME2 (3)    NULL,
    [PR_CLOSEDDATE]                    DATETIME2 (3)    NULL,
    [PR_EPISODEDATE]                   DATETIME2 (3)    NULL,
    [PR_STANDARDAGE]                   REAL             NULL,
    [PR_DATESUBMITTED]                 DATETIME2 (3)    NULL,
    [PR_DATEREPORTEDBY]                DATETIME2 (3)    NULL,
    [PR_REPORTSOURCEDR]                INT              NULL,
    [PR_MRN]                           VARCHAR (50)     NULL,
    [PR_CLUSTERID]                     VARCHAR (8000)   NULL,
    [PR_ISINDEXCASE]                   BIT              NULL,
    [PR_DISEASE]                       VARCHAR (255)    NULL,
    [PR_DISEASESHORTNAME]              VARCHAR (100)    NULL,
    [PR_OTHERDISEASE]                  VARCHAR (200)    NULL,
    [PR_DISTRICT]                      VARCHAR (255)    NULL,
    [PR_PROCESSSTATUS]                 VARCHAR (255)    NULL,
    [PR_SPA]                           VARCHAR (255)    NULL,
    [PR_RESOLUTIONSTATUS]              VARCHAR (255)    NULL,
    [PR_NURSEINVESTIGATOR]             VARCHAR (202)    NULL,
    [PR_REPORTEDBYWEB]                 BIT              NULL,
    [PR_REPORTEDBYLAB]                 BIT              NULL,
    [PR_REPORTEDBYEHR]                 BIT              NULL,
    [PR_TRANSMISSIONSTATUS]            VARCHAR (255)    NULL,
    [PR_DISEASECODE_DR]                INT              NULL,
    [PR_DISTRICTCODE_DR]               INT              NULL,
    [PR_PROCESSSTATUSCODE_DR]          INT              NULL,
    [PR_SPACODE_DR]                    INT              NULL,
    [PR_RESOLUTIONSTATUSCODE_DR]       INT              NULL,
    [PR_NURSEINVESTIGATORDR]           INT              NULL,
    [PR_SPECIMENTYPE]                  NTEXT            NULL,
    [PR_SPECIMENDATECOLLECTED]         NTEXT            NULL,
    [PR_SPECIMENDATERECEIVED]          NTEXT            NULL,
    [PR_SPECIMENRESULT]                NTEXT            NULL,
    [PR_SPECIMENNOTE]                  NTEXT            NULL,
    [PR_DIAGSPECIMENTYPES]             VARCHAR (8000)   NULL,
    [PR_EXPEXPOSURETYPES]              VARCHAR (8000)   NULL,
    [PR_HEPATITISDRS]                  VARCHAR (8000)   NULL,
    [PR_DISEASEGROUPS]                 VARCHAR (8000)   NULL,
    [PR_RESULTVALUE]                   NTEXT            NULL,
    [PR_LIPTESTORDERED]                VARCHAR (8000)   NULL,
    [PR_ISPREGNANT]                    BIT              NULL,
    [PR_EXPECTEDDELIVERYDATE]          DATETIME2 (3)    NULL,
    [PR_LIPRESULTNOTES]                NTEXT            NULL,
    [PR_LIPRESULTNAME]                 VARCHAR (8000)   NULL,
    [PR_HEALTHCAREPROVIDER]            VARCHAR (250)    NULL,
    [PR_HEALTHCAREPROVIDERLOCATIONDR]  INT              NULL,
    [PR_NOTES]                         TEXT             NULL,
    [PR_DATEOFDIAGNOSIS]               DATETIME2 (3)    NULL,
    [PR_DATEOFDEATH]                   DATETIME2 (3)    NULL,
    [PR_DATEOFLABREPORT]               DATETIME2 (3)    NULL,
    [PR_DATEINVESTIGATORRECEIVED]      DATETIME2 (3)    NULL,
    [PR_ISSYMPTOMATIC]                 BIT              NULL,
    [PR_ISPATIENTDIEDOFTHEILLNESS]     BIT              NULL,
    [PR_ISPATIENTHOSPITALIZED]         BIT              NULL,
    [PR_LABSPECIMENCOLLECTEDDATE]      DATETIME2 (3)    NULL,
    [PR_LABSPECIMENRESULTDATE]         DATETIME2 (3)    NULL,
    [PR_DATEADMITTED]                  DATETIME2 (3)    NULL,
    [PR_DATEDISCHARGED]                DATETIME2 (3)    NULL,
    [PR_LABORATORY]                    VARCHAR (250)    NULL,
    [PR_HOSPITALDR]                    INT              NULL,
    [PR_HOSPITAL]                      VARCHAR (250)    NULL,
    [PR_OUTPATIENT]                    BIT              NULL,
    [PR_INPATIENT]                     BIT              NULL,
    [PR_DATESENT]                      DATETIME2 (3)    NULL,
    [PR_LASTCDCUPDATE]                 DATETIME2 (3)    NULL,
    [PR_NAMEOFSUBMITTER]               VARCHAR (8000)   NULL,
    [PR_OUTBREAKNUMBERS]               TEXT             NULL,
    [PR_OUTBREAKTYPES]                 TEXT             NULL,
    [PR_ANIMALREPORTID]                INT              NULL,
    [PR_FBIDR]                         INT              NULL,
    [PR_FBINumber]                     VARCHAR (50)     NULL,
    [PR_CENSUSTRACT]                   VARCHAR (100)    NULL,
    [Additional_Provider]              VARCHAR (8000)   NULL,
    [Additional_Laboratory]            VARCHAR (8000)   NULL,
    [Age]                              REAL             NULL,
    [American_Indian_or_Alaska_Native] NTEXT            NULL,
    [Asian___Specify]                  NTEXT            NULL,
    [Black_or_African_American___Spec] NTEXT            NULL,
    [CMR_ID]                           VARCHAR (50)     NULL,
    [Country_of_Birth]                 VARCHAR (255)    NULL,
    [Created_By]                       VARCHAR (14)     NULL,
    [Date_Last_Edited]                 DATETIME2 (3)    NULL,
    [Final_Disposition]                VARCHAR (255)    NULL,
    [Diagnostic_Specimen_Types]        NTEXT            NULL,
    [Health_District_Number]           VARCHAR (255)    NULL,
    [ImportedBy]                       VARCHAR (202)    NULL,
    [Imported_Status]                  VARCHAR (30)     NULL,
    [Lab_Report]                       VARCHAR (5)      NULL,
    [Lab_Report_Notes]                 VARCHAR (8000)   NULL,
    [Lab_Report_Test_Name]             VARCHAR (255)    NULL,
    [Marital_Status]                   VARCHAR (255)    NULL,
    [Medical_Record_Number]            VARCHAR (50)     NULL,
    [Most_Recent_Lab_Result]           VARCHAR (1100)   NULL,
    [Most_Recent_Lab_Result_Value]     VARCHAR (8000)   NULL,
    [Native_Hawaiian_or_Other_Pacific] NTEXT            NULL,
    [Occupation_Setting_Type]          VARCHAR (255)    NULL,
    [Other___Specify]                  NTEXT            NULL,
    [Outbreak_IDs]                     TEXT             NULL,
    [Parent_or_Guardian_Name]          VARCHAR (50)     NULL,
    [Priority]                         VARCHAR (255)    NULL,
    [Provider_Name]                    VARCHAR (255)    NULL,
    [Report_Source]                    VARCHAR (250)    NULL,
    [Secondary_District]               VARCHAR (255)    NULL,
    [Suspected_Exposure_Types]         NTEXT            NULL,
    [Type_of_Contact]                  VARCHAR (255)    NULL,
    [Unknown___Specify]                NTEXT            NULL,
    [White___Specify]                  NTEXT            NULL,
    [HashCode]                         VARBINARY (8000) NULL,
    [SynchronizationType]              TINYINT          NOT NULL,
    [SynchronizationDateTime]          DATETIME         NOT NULL,
    CONSTRAINT [PK_COVID_INCIDENT] PRIMARY KEY CLUSTERED ([PR_ROWID] ASC) WITH (IGNORE_DUP_KEY = ON) ON [WCExtracted_Data]
) ON [WCExtracted_Data] TEXTIMAGE_ON [WCExtracted_Data];

