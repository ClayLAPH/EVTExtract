﻿create view [covid].[SARS2_UDF_DATA]
as
SELECT * FROM AtlasPublic.View_UODS_UDFData WHERE RECORD_ID IN (SELECT PR_ROWID FROM AtlasPublic.VIEW_UODS_PERSONALRECORD WHERE PR_DISEASECODE_DR = 544041);