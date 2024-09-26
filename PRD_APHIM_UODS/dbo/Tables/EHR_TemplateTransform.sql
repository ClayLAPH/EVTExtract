CREATE TABLE [dbo].[EHR_TemplateTransform] (
    [ID]                    INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Document_IdentifierID] INT            NOT NULL,
    [Template_ID]           INT            NOT NULL,
    [TemplateType]          TINYINT        NOT NULL,
    [DiseaseCode_ID]        INT            NULL,
    [XsltContent]           NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 95),
    CONSTRAINT [CK_TemplateTransform] UNIQUE NONCLUSTERED ([Document_IdentifierID] ASC, [Template_ID] ASC, [DiseaseCode_ID] ASC) WITH (FILLFACTOR = 70)
);

