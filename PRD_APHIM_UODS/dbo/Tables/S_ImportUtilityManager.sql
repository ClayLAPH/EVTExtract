CREATE TABLE [dbo].[S_ImportUtilityManager] (
    [IUM_ID]                      INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IUM_FileName]                VARCHAR (255)   NULL,
    [IUM_DTRule]                  XML             NULL,
    [IUM_DTDDLValueMap]           XML             NULL,
    [IUM_DTFieldList]             XML             NULL,
    [IUM_ImportStartTime]         DATETIME        NULL,
    [IUM_TotalLineNumber]         INT             NULL,
    [IUM_ImportMode]              BIT             NULL,
    [IUM_IsPaused]                BIT             NULL,
    [IUM_isCompleted]             BIT             NULL,
    [IUM_DictionaryImportAction]  VARCHAR (50)    NULL,
    [IUM_ImportingSessionID]      VARCHAR (50)    NULL,
    [IUM_ImportInProgress]        BIT             NULL,
    [IUM_ImportTimeLimit]         INT             NULL,
    [IUM_RecInsertCount1]         INT             NULL,
    [IUM_RecUpdateCount1]         INT             NULL,
    [IUM_RecordDiscardCount1]     INT             NULL,
    [IUM_RecInsertCount2]         INT             NULL,
    [IUM_RecUpdateCount2]         INT             NULL,
    [IUM_RecordDiscardCount2]     INT             NULL,
    [IUM_ErrorLog]                VARCHAR (MAX)   NULL,
    [IUM_IsFromCMR]               BIT             NULL,
    [IUM_FileContent]             VARBINARY (MAX) NULL,
    [IUM_ImportType]              VARCHAR (20)    NULL,
    [IUM_IsFromWSAPI]             BIT             NULL,
    [IUM_TotalParentRecordNumber] INT             NULL,
    [IUM_NextLineNumber]          INT             DEFAULT ((0)) NULL,
    CONSTRAINT [PK_S_ImportUtilityManager] PRIMARY KEY CLUSTERED ([IUM_ID] ASC) WITH (FILLFACTOR = 95)
);


GO
CREATE NONCLUSTERED INDEX [IX_S_ImportUtilityManager_WSAPI]
    ON [dbo].[S_ImportUtilityManager]([IUM_IsFromWSAPI] ASC, [IUM_isCompleted] ASC, [IUM_IsFromCMR] ASC)
    INCLUDE([IUM_ImportMode]) WITH (FILLFACTOR = 80);

