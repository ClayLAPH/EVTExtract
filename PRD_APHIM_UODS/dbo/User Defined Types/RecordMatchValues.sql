﻿CREATE TYPE [dbo].[RecordMatchValues] AS TABLE (
    [PER_AccountNo]                 VARCHAR (100)  NULL,
    [PER_Address]                   VARCHAR (1000) NULL,
    [PER_DOB]                       VARCHAR (100)  NULL,
    [PER_FirstName]                 VARCHAR (100)  NULL,
    [PER_HomePhone]                 VARCHAR (100)  NULL,
    [PER_LastName]                  VARCHAR (100)  NULL,
    [PER_MiddleName]                VARCHAR (100)  NULL,
    [PER_MRN]                       VARCHAR (100)  NULL,
    [PER_Sex]                       VARCHAR (100)  NULL,
    [PER_SSN]                       VARCHAR (100)  NULL,
    [PER_WorkSchoolPhone]           VARCHAR (100)  NULL,
    [PR_ACCNO]                      VARCHAR (500)  NULL,
    [PR_DateOfDiagnosis]            VARCHAR (100)  NULL,
    [PR_DiseaseDR]                  INT            NULL,
    [PR_DistrictDR]                 INT            NULL,
    [RS_HealthCareProvider]         VARCHAR (250)  NULL,
    [RS_NationalProviderIdentifier] VARCHAR (100)  NULL,
    [SPEC_SpecimenDateCollected]    VARCHAR (100)  NULL,
    [PR_ReportSourceDR]             INT            NULL);
