﻿create view [covid].[SARS2_CONTACT]
as
SELECT * FROM AtlasPublic.VIEW_UODS_VIEWSYSTEMCONTACTDATA WHERE DIID IN (SELECT PR_ROWID FROM AtlasPublic.VIEW_UODS_PERSONALRECORD WHERE PR_DISEASECODE_DR = 544041)