﻿
CREATE VIEW [AtlasInternal].[VIEW_CLIENTRECORD_SERVICES_CMMode]
AS
SELECT [SVC_ID]
      ,[SVC_INSTANCEID]
      ,[SVC_PERSONDR]
      ,[SVC_INITIALSERVICEDR],
      [DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](SVC_InitialServiceDR) AS SVC_INITIALSERVICE
      ,[SVC_INITIALDATE]
      ,[SVC_CURRENTSERVICEDR],[DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](SVC_CURRENTSERVICEDR) AS SVC_CURRENTSERVICE,
      [SVC_CURRENTSERVICEDATE]
      ,[SVC_STATUSDR]
      ,[SVC_STATUSCHANGEDATE]
      ,[SVC_JURISDICTIONCODE_ID], [DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](SVC_JURISDICTIONCODE_ID) AS SVC_JURISDICTION
      ,[SVC_CASEMANAGERDR],
      ISNULL(VIEWCASEMGR.CASEMGR_PARTFAM, '') + ISNULL(',' + VIEWCASEMGR.CASEMGR_PARTGIV, '') AS SVC_CASEMANAGER
      ,[SVC_CASEMANAGERDATEASSIGNED]
      
      FROM 
      AX_SERVICES AX
      
      INNER JOIN A_Act ACT (NOLOCK) ON ACT.ID=AX.SVC_ID 
      LEFT JOIN [ATLASINTERNAL].[VIEW_SUB_CLIENTRECORD_CASEMANAGER_CMMODE] VIEWCASEMGR  (NOLOCK) ON VIEWCASEMGR.CASEMGR_ID = AX.SVC_CASEMANAGERDR 
      LEFT JOIN DBO.P_PARTICIPATION PART (NOLOCK) ON PART.ACT_ID = AX.[SVC_ID] AND PART.TYPECODE = 'PPRF'
      WHERE ACT.metaCode='SVC_ID' AND ACT.statusCode NOT IN ('nullified','terminated')

