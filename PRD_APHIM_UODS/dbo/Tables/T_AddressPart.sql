CREATE TABLE [dbo].[T_AddressPart] (
    [sequence]      INT           NULL,
    [partType]      VARCHAR (50)  NULL,
    [partType_OrTx] VARCHAR (50)  NULL,
    [address]       VARCHAR (100) NULL,
    [metaCode]      VARCHAR (50)  NULL,
    [ServerId]      INT           NULL,
    [ID]            INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Address_ID]    INT           NULL,
    CONSTRAINT [T_AddressPart_PK] PRIMARY KEY NONCLUSTERED ([ID] ASC) WITH (FILLFACTOR = 70),
    CONSTRAINT [T_EntityAddress_T_AddressPart_FK1] FOREIGN KEY ([Address_ID]) REFERENCES [dbo].[T_EntityAddress] ([ID]) NOT FOR REPLICATION
);


GO
ALTER TABLE [dbo].[T_AddressPart] NOCHECK CONSTRAINT [T_EntityAddress_T_AddressPart_FK1];


GO
CREATE NONCLUSTERED INDEX [IX_T_AddressPart]
    ON [dbo].[T_AddressPart]([Address_ID] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_T_AddressPart_1]
    ON [dbo].[T_AddressPart]([address] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE NONCLUSTERED INDEX [IX_T_AddressPart_2]
    ON [dbo].[T_AddressPart]([Address_ID] ASC, [address] ASC) WITH (FILLFACTOR = 70)
    ON [PRIMARY_IDX];


GO
CREATE STATISTICS [IX_WA_address]
    ON [dbo].[T_AddressPart]([address]);


GO
CREATE STATISTICS [IX_WA_metaCode]
    ON [dbo].[T_AddressPart]([metaCode]);


GO
CREATE STATISTICS [IX_WA_partType]
    ON [dbo].[T_AddressPart]([partType]);

