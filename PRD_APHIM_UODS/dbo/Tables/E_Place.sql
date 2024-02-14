CREATE TABLE [dbo].[E_Place] (
    [mobileInd]      BIT           NULL,
    [directionsText] VARCHAR (MAX) NULL,
    [positionText]   VARCHAR (100) NULL,
    [gpsText]        VARCHAR (100) NULL,
    [ServerId]       INT           NULL,
    [ID]             INT           NOT NULL,
    CONSTRAINT [E_Place_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [E_Entity_E_Place_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[E_Entity] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[E_Place] NOCHECK CONSTRAINT [E_Entity_E_Place_FK1];

