CREATE TABLE [dbo].[R_LicensedEntity] (
    [recertificationTime] DATETIME NULL,
    [ID]                  INT      NOT NULL,
    CONSTRAINT [R_LicensedEntity_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [R_Role_R_LicensedEntity_FK1] FOREIGN KEY ([ID]) REFERENCES [dbo].[R_Role] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[R_LicensedEntity] NOCHECK CONSTRAINT [R_Role_R_LicensedEntity_FK1];

