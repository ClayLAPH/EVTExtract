CREATE TABLE [dbo].[S_PasscodePool] (
    [ID]       INT      IDENTITY (1, 1) NOT NULL,
    [Passcode] CHAR (9) NOT NULL,
    [Issued]   BIT      DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_S_PasscodePool] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [IX_S_PasscodePool_Passcode] UNIQUE NONCLUSTERED ([Passcode] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_S_PasscodePool_Issued]
    ON [dbo].[S_PasscodePool]([Issued] ASC)
    INCLUDE([Passcode]);

