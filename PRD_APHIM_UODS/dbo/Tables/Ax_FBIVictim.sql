CREATE TABLE [dbo].[Ax_FBIVictim] (
    [FBIP_RowID]           INT           NOT NULL,
    [FBIP_EatenDate]       DATETIME      NULL,
    [FBIP_OnsetDate]       DATETIME      NULL,
    [FBIP_CareTypeDR]      INT           NULL,
    [FBIP_AdmissionDate]   DATETIME      NULL,
    [FBIP_DischargeDate]   DATETIME      NULL,
    [FBIP_HospitalDR]      INT           NULL,
    [FBIP_Person]          VARCHAR (250) NULL,
    [FBIP_Age]             REAL          NULL,
    [FBIP_Phone]           VARCHAR (100) NULL,
    [FBIP_ADDR1]           VARCHAR (100) NULL,
    [FBIP_City]            VARCHAR (100) NULL,
    [FBIP_ADDR2]           VARCHAR (100) NULL,
    [FBIP_IsPrimaryPerson] BIT           NULL,
    [FBIP_ZipCode]         VARCHAR (100) NULL,
    [FBIP_Phone2]          VARCHAR (100) NULL,
    [FBIP_Email]           VARCHAR (100) NULL,
    CONSTRAINT [PK_Ax_FBIVictim] PRIMARY KEY CLUSTERED ([FBIP_RowID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [FK_Ax_FBIVictim_A_Act] FOREIGN KEY ([FBIP_RowID]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ax_FBIVictim_E_Entity] FOREIGN KEY ([FBIP_HospitalDR]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION,
    CONSTRAINT [FK_Ax_FBIVictim_V_UnifiedCodeSet] FOREIGN KEY ([FBIP_CareTypeDR]) REFERENCES [dbo].[V_UnifiedCodeSet] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[Ax_FBIVictim] NOCHECK CONSTRAINT [FK_Ax_FBIVictim_A_Act];


GO
ALTER TABLE [dbo].[Ax_FBIVictim] NOCHECK CONSTRAINT [FK_Ax_FBIVictim_E_Entity];


GO
ALTER TABLE [dbo].[Ax_FBIVictim] NOCHECK CONSTRAINT [FK_Ax_FBIVictim_V_UnifiedCodeSet];


GO
CREATE NONCLUSTERED INDEX [IX_Ax_FBIVictim_Person]
    ON [dbo].[Ax_FBIVictim]([FBIP_Person] ASC, [FBIP_IsPrimaryPerson] ASC)
    INCLUDE([FBIP_RowID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_Ax_FBIVictim_EatenDate]
    ON [dbo].[Ax_FBIVictim]([FBIP_EatenDate] ASC, [FBIP_IsPrimaryPerson] ASC)
    INCLUDE([FBIP_RowID]) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
ALTER INDEX [IX_Ax_FBIVictim_EatenDate]
    ON [dbo].[Ax_FBIVictim] DISABLE;

