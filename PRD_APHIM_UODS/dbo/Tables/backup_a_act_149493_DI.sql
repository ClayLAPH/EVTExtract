﻿CREATE TABLE [dbo].[backup_a_act_149493_DI] (
    [classCode]                 VARCHAR (50)   NOT NULL,
    [classCode_OrTx]            VARCHAR (50)   NULL,
    [moodCode]                  VARCHAR (50)   NULL,
    [moodCode_OrTx]             VARCHAR (50)   NULL,
    [code_OrTx]                 VARCHAR (255)  NULL,
    [code_CD_ID]                INT            NULL,
    [negationInd]               BIT            NULL,
    [derivationExpr]            VARCHAR (50)   NULL,
    [title]                     VARCHAR (300)  NULL,
    [text]                      VARCHAR (MAX)  NULL,
    [statusCode]                VARCHAR (50)   NULL,
    [statusCode_OrTx]           VARCHAR (50)   NULL,
    [effectiveTime_Beg]         DATETIME       NULL,
    [effectiveTime_End]         DATETIME       NULL,
    [effectiveTime_Dur]         REAL           NULL,
    [effectiveTime_Dur_Unit]    VARCHAR (50)   NULL,
    [effectiveTime_Txt]         VARCHAR (50)   NULL,
    [activityTime_Beg]          DATETIME       NULL,
    [activityTime_End]          DATETIME       NULL,
    [availabilityTime]          DATETIME       NULL,
    [priorityCode_OrTx]         VARCHAR (50)   NULL,
    [confidentialityCode_OrTx]  VARCHAR (50)   NULL,
    [repeatNumber_Min]          INT            NULL,
    [repeatNumber_Max]          INT            NULL,
    [interruptibleInd]          BIT            NULL,
    [independentInd]            BIT            NULL,
    [uncertaintyCode_OrTx]      VARCHAR (50)   NULL,
    [languageCode_OrTx]         VARCHAR (50)   NULL,
    [metaCode]                  VARCHAR (50)   NULL,
    [localId]                   VARCHAR (50)   NULL,
    [Act_Parent_TypeCode]       VARCHAR (50)   NULL,
    [Act_Parent_SequenceNumber] INT            NULL,
    [Act_Parent_PriorityNumber] INT            NULL,
    [valueBool]                 BIT            NULL,
    [valueInteger]              INT            NULL,
    [valueReal]                 REAL           NULL,
    [valueTS]                   DATETIME       NULL,
    [ValueTSEnd]                DATETIME       NULL,
    [valueString]               VARCHAR (8000) NULL,
    [valueString_Txt]           VARCHAR (200)  NULL,
    [valueNumerator]            REAL           NULL,
    [valueNumerator_Unit]       VARCHAR (50)   NULL,
    [valueDenominator]          REAL           NULL,
    [valueDenominator_Unit]     VARCHAR (50)   NULL,
    [isValueNull]               BIT            NULL,
    [code_ID]                   INT            NULL,
    [confidentialityCode_ID]    INT            NULL,
    [effectiveTime_Frq_ID]      INT            NULL,
    [languageCode_ID]           INT            NULL,
    [priorityCode_ID]           INT            NULL,
    [uncertaintyCode_ID]        INT            NULL,
    [valueCode_ID]              INT            NULL,
    [ServerId]                  INT            NULL,
    [ID]                        INT            IDENTITY (1, 1) NOT NULL,
    [Act_CaseCmr_ID]            INT            NULL,
    [Act_CaseNcm_ID]            INT            NULL,
    [Act_Parent_ID]             INT            NULL,
    [ActHx_ID]                  INT            NULL
);

