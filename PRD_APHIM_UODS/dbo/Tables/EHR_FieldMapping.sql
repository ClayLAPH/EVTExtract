CREATE TABLE [dbo].[EHR_FieldMapping] (
    [ID]                    INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Document_IdentifierID] INT            NOT NULL,
    [TargetRecordType]      TINYINT        NOT NULL,
    [TargetForm_ID]         NVARCHAR (100) NOT NULL,
    [TargetSection_ID]      NVARCHAR (100) NULL,
    [TargetField_ID]        NVARCHAR (100) NOT NULL,
    [NoMatch_Action]        TINYINT        NOT NULL,
    [NoMatch_ValueID]       INT            NULL,
    [Empty_Action]          TINYINT        NOT NULL,
    [Empty_ValueID]         INT            NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95)
);

