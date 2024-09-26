CREATE TABLE [dbo].[S_DiseaseIncPointOfOcc] (
    [INPO_RowID]          INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [INPO_Name]           VARCHAR (250) NULL,
    [INPO_Type]           VARCHAR (250) NULL,
    [INPO_DOB]            DATETIME      NULL,
    [INPO_SSN]            VARCHAR (250) NULL,
    [INPO_City]           VARCHAR (250) NULL,
    [INPO_State]          VARCHAR (250) NULL,
    [INPO_Address]        VARCHAR (250) NULL,
    [INPO_GPSCoorditanes] VARCHAR (250) NULL,
    [INPO_IncidentDR]     INT           NULL,
    CONSTRAINT [S_DiseaseIncPointOfOcc_PK] PRIMARY KEY NONCLUSTERED ([INPO_RowID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [A_Act_S_DiseaseIncPointOfOcc_FK1] FOREIGN KEY ([INPO_IncidentDR]) REFERENCES [dbo].[A_Act] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[S_DiseaseIncPointOfOcc] NOCHECK CONSTRAINT [A_Act_S_DiseaseIncPointOfOcc_FK1];

