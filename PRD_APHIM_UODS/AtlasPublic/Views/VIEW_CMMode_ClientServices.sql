
CREATE VIEW [AtlasPublic].[VIEW_CMMode_ClientServices]
AS
    SELECT [SVC_ID]
          ,[SVC_InstanceID]
          ,[SVC_PersonDR]
          ,TII.[extension] AS PER_ClientID
          ,[SVC_InitialServiceDR]
          ,[DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](SVC_InitialServiceDR) AS SVC_InitialService
          ,[SVC_InitialDate]
          ,[SVC_CURRENTSERVICEDR]
          ,[DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](SVC_CurrentServiceDR) AS SVC_CurrentService
          ,[SVC_CurrentServiceDate]
          ,[SVC_StatusDR]
          ,[DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](SVC_StatusDR) AS SVC_Status
          ,[SVC_StatusChangeDate]
          ,[SVC_JurisdictionCode_ID]
          ,[DBO].[MDF_UCS_FULLNAME_UCS_BYUCSID](SVC_JurisdictionCode_ID) AS SVC_Jurisdiction
          ,[SVC_CaseManagerDR]
          ,ISNULL(ENTNAME.partFAM, '') + ISNULL(',' + ENTNAME.partGIV, '') AS SVC_CASEMANAGER
          ,[SVC_CaseManagerDateAssigned]
          ,ACTCASE.activityTime_Beg AS [SVC_CreateDate]
    FROM AX_SERVICES SVC (NOLOCK)
    INNER JOIN A_Act ACTCASE (NOLOCK) ON SVC.SVC_ID = ACTCASE.ID AND ACTCASE.metaCode = 'SVC_ID' AND ACTCASE.classCode ='CASE' AND ACTCASE.statusCode NOT IN ('nullified','terminated')
    INNER JOIN A_PublicHealthCase PHCASE (NOLOCK) ON SVC.[SVC_ID] = PHCASE.ID
    INNER JOIN T_InstanceIdentifier TII (NOLOCK) ON SVC.[SVC_PersonDR] = TII.Entity_ID AND TII.[root] = '2.16.840.1.113883.3.33.4.2.4.11.2' + [dbo].[FN_GetSiteID]() + '.1'
    LEFT JOIN T_EntityName ENTNAME (NOLOCK) ON SVC.SVC_CaseManagerDR = ENTNAME.ENTITY_ID 

