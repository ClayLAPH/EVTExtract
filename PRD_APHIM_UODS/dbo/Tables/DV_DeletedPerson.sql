CREATE TABLE [dbo].[DV_DeletedPerson] (
    [DVPER_RowID]            INT           NOT NULL,
    [DVPER_RootID]           INT           NOT NULL,
    [DVPER_HistoryID]        INT           NOT NULL,
    [DVPER_IsPatient]        BIT           NOT NULL,
    [DVPER_IsContact]        BIT           NOT NULL,
    [DVPER_IsFamilyMember]   BIT           NOT NULL,
    [DVPER_IsGELinked]       BIT           NOT NULL,
    [DVPER_LastName]         VARCHAR (100) NULL,
    [DVPER_FirstName]        VARCHAR (100) NULL,
    [DVPER_LastNameAlphaUp]  VARCHAR (100) NULL,
    [DVPER_FirstNameAlphaUp] VARCHAR (100) NULL,
    [DVPER_SSN]              VARCHAR (50)  NULL,
    [DVPER_Address]          VARCHAR (550) NULL,
    [DVPER_DOB]              DATETIME      NULL,
    CONSTRAINT [PK_DV_DeletedPerson] PRIMARY KEY CLUSTERED ([DVPER_RowID] DESC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_DV_DeletedPerson_E_Entity1] FOREIGN KEY ([DVPER_RowID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DV_DeletedPerson_E_Entity2] FOREIGN KEY ([DVPER_RootID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_DV_DeletedPerson_S_PersonDeleteHistory] FOREIGN KEY ([DVPER_HistoryID]) REFERENCES [dbo].[S_PersonDeleteHistory] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[DV_DeletedPerson] NOCHECK CONSTRAINT [FK_DV_DeletedPerson_E_Entity1];


GO
ALTER TABLE [dbo].[DV_DeletedPerson] NOCHECK CONSTRAINT [FK_DV_DeletedPerson_E_Entity2];


GO
ALTER TABLE [dbo].[DV_DeletedPerson] NOCHECK CONSTRAINT [FK_DV_DeletedPerson_S_PersonDeleteHistory];


GO
CREATE NONCLUSTERED INDEX [IX_DV_DeletedPerson_DVPER_NameAlphaUp]
    ON [dbo].[DV_DeletedPerson]([DVPER_LastNameAlphaUp] ASC, [DVPER_FirstNameAlphaUp] ASC) WITH (FILLFACTOR = 70);

