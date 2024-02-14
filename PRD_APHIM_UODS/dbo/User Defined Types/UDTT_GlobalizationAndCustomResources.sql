CREATE TYPE [dbo].[UDTT_GlobalizationAndCustomResources] AS TABLE (
    [ID]                     INT            NOT NULL,
    [FIELD_DisplayName]      NVARCHAR (510) NULL,
    [FIELD_Visible]          BIT            NULL,
    [FIELD_DataTableName]    NVARCHAR (510) NULL,
    [FIELD_ExportHeaderName] NVARCHAR (510) NULL);

