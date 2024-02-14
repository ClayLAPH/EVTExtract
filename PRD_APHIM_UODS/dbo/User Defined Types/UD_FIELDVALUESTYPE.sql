CREATE TYPE [dbo].[UD_FIELDVALUESTYPE] AS TABLE (
    [UDSEC_SectionValID] INT           NULL,
    [UDVAL_FieldDefID]   INT           NULL,
    [UDVAL_Value]        VARCHAR (MAX) NULL,
    [UDVAL_FieldType]    VARCHAR (20)  NULL);

