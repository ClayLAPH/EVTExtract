CREATE TABLE [dbo].[V_Domain] (
    [ID]          INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [domainOid]   VARCHAR (50)   NOT NULL,
    [domainName]  VARCHAR (100)  NULL,
    [systemOid]   VARCHAR (50)   NULL,
    [systemName]  VARCHAR (100)  NULL,
    [externalOid] VARCHAR (50)   NULL,
    [internal]    BIT            NULL,
    [external]    BIT            NULL,
    [description] VARCHAR (3000) NULL,
    [active]      BIT            NULL,
    CONSTRAINT [PK_V_Domain] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95)
);


GO
CREATE NONCLUSTERED INDEX [IX_V_Domain_DomainName]
    ON [dbo].[V_Domain]([domainName] ASC) WITH (FILLFACTOR = 70);


GO
CREATE NONCLUSTERED INDEX [IX_V_Domain_externalOid]
    ON [dbo].[V_Domain]([externalOid] ASC) WITH (FILLFACTOR = 70);


GO
CREATE NONCLUSTERED INDEX [IX_V_Domain_external]
    ON [dbo].[V_Domain]([external] ASC) WITH (FILLFACTOR = 70);


GO
CREATE NONCLUSTERED INDEX [IX_V_Domain_External_DomainName]
    ON [dbo].[V_Domain]([external] ASC, [domainName] ASC)
    INCLUDE([ID], [domainOid], [systemOid], [systemName], [externalOid], [description], [active]) WITH (FILLFACTOR = 70);

