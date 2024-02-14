﻿CREATE TABLE [covid].[SARS2_LAB_COPY] (
    [IncidentID]                   VARCHAR (50)   NULL,
    [PHRECORDID]                   INT            NOT NULL,
    [LabReportID]                  INT            NOT NULL,
    [ACCESSIONNUMBER]              VARCHAR (300)  NULL,
    [HL7FILENAME]                  VARCHAR (255)  NULL,
    [ABNORMALFLAG]                 VARCHAR (255)  NULL,
    [IMPORTSTATUS]                 VARCHAR (1500) NULL,
    [ISFROMHL7]                    BIT            NULL,
    [ORDERSTATUS]                  VARCHAR (255)  NULL,
    [LOCALORGANISMCODE]            VARCHAR (1270) NULL,
    [LOCALORGANISMDESCRIPTION]     VARCHAR (1550) NULL,
    [LOCALTESTCODE]                VARCHAR (255)  NULL,
    [LOCALTESTDESCRIPTION]         VARCHAR (1000) NULL,
    [NOTES]                        VARCHAR (MAX)  NULL,
    [ORGANISMCODE]                 VARCHAR (255)  NULL,
    [ORGANISMDESCRIPTION]          VARCHAR (300)  NULL,
    [PATIENTNAME]                  VARCHAR (255)  NULL,
    [PERFORMINGFACILITYID]         VARCHAR (255)  NULL,
    [PERSONVERIFIEDRESULT]         VARCHAR (255)  NULL,
    [PFGEPATTERN1ST]               VARCHAR (255)  NULL,
    [PFGEPATTERN2ND]               VARCHAR (255)  NULL,
    [REFERENCERANGE]               VARCHAR (255)  NULL,
    [RESULTDATE]                   DATETIME       NULL,
    [RESULTSTATUS]                 VARCHAR (255)  NULL,
    [RESULTUNIT]                   VARCHAR (255)  NULL,
    [RESULTVALUE]                  VARCHAR (4000) NULL,
    [SEROGROUP]                    VARCHAR (300)  NULL,
    [SEROLOGY]                     VARCHAR (300)  NULL,
    [SEROTYPE]                     VARCHAR (300)  NULL,
    [SPECIES]                      VARCHAR (300)  NULL,
    [SPECBODYSITE]                 VARCHAR (255)  NULL,
    [SPECCOLLECTEDDATE]            DATETIME       NULL,
    [SPECIMENSOURCE]               VARCHAR (255)  NULL,
    [SPECRECEIVEDDATE]             DATETIME       NULL,
    [TESTCODE]                     VARCHAR (255)  NULL,
    [TESTDESCRIPTION]              VARCHAR (1000) NULL,
    [DILR_StatusCode]              VARCHAR (50)   NULL,
    [PROVIDERNAME]                 VARCHAR (255)  NULL,
    [PROVIDERID]                   VARCHAR (255)  NULL,
    [PROVIDERADDRESS]              VARCHAR (255)  NULL,
    [PROVIDERCITY]                 VARCHAR (255)  NULL,
    [PROVIDERSTATE]                VARCHAR (255)  NULL,
    [PROVIDERCOUNTY]               VARCHAR (255)  NULL,
    [PROVIDERZIP]                  VARCHAR (255)  NULL,
    [PROVIDERPHONE]                VARCHAR (255)  NULL,
    [PROVIDEREMAIL]                VARCHAR (255)  NULL,
    [PROVIDERFAX]                  VARCHAR (255)  NULL,
    [FACILITYNAME]                 VARCHAR (255)  NULL,
    [FACILITYADDRESS]              VARCHAR (255)  NULL,
    [FACILITYCITY]                 VARCHAR (255)  NULL,
    [FACILITYSTATE]                VARCHAR (255)  NULL,
    [FACILITYCOUNTY]               VARCHAR (255)  NULL,
    [FACILITYZIP]                  VARCHAR (255)  NULL,
    [FACILITYPHONE]                VARCHAR (255)  NULL,
    [PLACERORDERNO]                VARCHAR (255)  NULL,
    [FACILITYEMAIL]                VARCHAR (255)  NULL,
    [FACILITYID]                   VARCHAR (255)  NULL,
    [EXTENDEDRESULTVALUE]          NVARCHAR (MAX) NULL,
    [RELEVANTCLINICALINFORMATION]  NVARCHAR (300) NULL,
    [REASONFORSTUDY]               NVARCHAR (199) NULL,
    [ORGANISMCODINGSYSTEM]         VARCHAR (50)   NOT NULL,
    [RESULTEDORGANISM]             VARCHAR (300)  NOT NULL,
    [RESULTTEXT]                   VARCHAR (1100) NOT NULL,
    [SPECIMENSOURCETEXT]           VARCHAR (705)  NOT NULL,
    [LOCALORGANISMDESCRIPTIONTEXT] VARCHAR (1550) NULL,
    [LOCALORGANISMCODETEXT]        VARCHAR (1270) NULL
);
