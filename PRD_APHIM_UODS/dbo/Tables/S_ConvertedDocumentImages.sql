CREATE TABLE [dbo].[S_ConvertedDocumentImages] (
    [IMG_RowID]      INT             NOT NULL,
    [PageNumber]     INT             NOT NULL,
    [ImageData]      VARBINARY (MAX) NULL,
    [Extension]      VARCHAR (50)    NULL,
    [CreateDateTime] DATETIME        CONSTRAINT [DF_S_ConvertedDocumentImages_createDateTime] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_S_ConvertedDocumentImages] PRIMARY KEY NONCLUSTERED ([IMG_RowID] ASC, [PageNumber] ASC) WITH (FILLFACTOR = 70) ON [TVALUE_IDX]
) ON [TVALUE_DATA] TEXTIMAGE_ON [TVALUE_DATA];

