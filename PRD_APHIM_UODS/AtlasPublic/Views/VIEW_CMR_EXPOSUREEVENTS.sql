﻿
CREATE VIEW [ATLASPUBLIC].[VIEW_CMR_EXPOSUREEVENTS]
AS
SELECT PHRECORDID,
PHRECORD_INSTANCE_ID,
EXPOSUREEVENTID AS DEE_EXPOSUREEVENTID,
DEE_EXPOSUREDATETIME,
DEE_EXPOSUREENDDATETIME,
DEE_ExposureTypeDR,
DEE_EXPOSURETYPE,
DEE_LOCATIONDR,
DEE_LOCATION_NAME,
DEE_StatusCode,
PR_RecordType AS PHRecord_Type
FROM AtlasInternal.VIEWEXPOSUREEVENTS


