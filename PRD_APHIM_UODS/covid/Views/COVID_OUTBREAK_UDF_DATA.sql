﻿create view [covid].[COVID_OUTBREAK_UDF_DATA]
as
SELECT * FROM AtlasPublic.View_UODS_UDFData WHERE RECORD_ID IN (SELECT OUTB_RowID FROM AtlasPublic.View_UODS_Outbreak WHERE OUTB_DISEASECODE_DR = 543030);