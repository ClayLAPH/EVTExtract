﻿
CREATE  FUNCTION [dbo].[FN_GetDiseaseProcessStatusCodeOrderedWorkflow](@RECORDTYPECODES NVARCHAR(100))
RETURNS @DiseaseWorkflowTBL TABLE  
( 
    ProcessStatusCode_ID INT,
    DiseaseCode_ID INT,
    RecordTypeCode NVARCHAR(10),
    RowNumber INT
)
AS  
BEGIN

    INSERT @DiseaseWorkflowTBL
    SELECT  
    VALUECODE_ID AS ProcessStatusCode_ID,
    [VCP_DISEASE].[SUBJCODE_ID] AS DiseaseCode_ID, 
    'DI' as RecordTypeCode
    ,ROW_NUMBER() OVER (PARTITION BY [VCP_DISEASE].[SUBJCODE_ID] ORDER BY [V_CODEPROPERTY].[VALUEINT] DESC) AS [RowNumber]
    FROM [V_UNIFIEDCODESET] (NOLOCK)   
    INNER JOIN [VCP_DISEASE] (NOLOCK) ON  [V_UNIFIEDCODESET].[ID]=[VCP_DISEASE].[WORKFLOWCODE_ID]   
    INNER JOIN [V_CODEPROPERTY] (NOLOCK) ON  [V_UNIFIEDCODESET].[ID]=[V_CODEPROPERTY].[SUBJCODE_ID] AND [V_CODEPROPERTY].[PROPERTY] = 'WSF_ROWID'   
    WHERE CHARINDEX('DI',@RECORDTYPECODES) > 0 
    
    UNION ALL

    SELECT  
    VALUECODE_ID AS ProcessStatusCode_ID,
    [VCP_DISEASE].[SUBJCODE_ID] AS DiseaseCode_ID, 
    'CI' as RecordTypeCode
    ,ROW_NUMBER() OVER (PARTITION BY [VCP_DISEASE].[SUBJCODE_ID] ORDER BY [V_CODEPROPERTY].[VALUEINT] DESC) AS [RowNumber]
    FROM [V_UNIFIEDCODESET] (NOLOCK)   
    INNER JOIN [VCP_DISEASE] (NOLOCK) ON  [V_UNIFIEDCODESET].[ID]=[VCP_DISEASE].[ContactInvestigationWorkFlowCode_ID]   
    INNER JOIN [V_CODEPROPERTY] (NOLOCK) ON  [V_UNIFIEDCODESET].[ID]=[V_CODEPROPERTY].[SUBJCODE_ID] AND [V_CODEPROPERTY].[PROPERTY] = 'WSF_ROWID' 
    WHERE CHARINDEX('CI',@RECORDTYPECODES) > 0 

    UNION ALL

    SELECT  
    VALUECODE_ID AS ProcessStatusCode_ID,
    [VCP_DISEASE].[SUBJCODE_ID] AS DiseaseCode_ID, 
    'OB' as RecordTypeCode
    ,ROW_NUMBER() OVER (PARTITION BY [VCP_DISEASE].[SUBJCODE_ID] ORDER BY [V_CODEPROPERTY].[VALUEINT] DESC) AS [RowNumber]
    FROM [V_UNIFIEDCODESET] (NOLOCK)   
    INNER JOIN [VCP_DISEASE] (NOLOCK) ON  [V_UNIFIEDCODESET].[ID]=[VCP_DISEASE].[OutbreakWorkFlowDR]    
    INNER JOIN [V_CODEPROPERTY] (NOLOCK) ON  [V_UNIFIEDCODESET].[ID]=[V_CODEPROPERTY].[SUBJCODE_ID] AND [V_CODEPROPERTY].[PROPERTY] = 'WSF_ROWID' 
    WHERE CHARINDEX('OB',@RECORDTYPECODES) > 0

    UNION ALL

    SELECT  
    VALUECODE_ID AS ProcessStatusCode_ID,
    [VCP_DISEASE].[SUBJCODE_ID] AS DiseaseCode_ID, 
    'AR' as RecordTypeCode
    ,ROW_NUMBER() OVER (PARTITION BY [VCP_DISEASE].[SUBJCODE_ID] ORDER BY [V_CODEPROPERTY].[VALUEINT] DESC) AS [RowNumber]
    FROM [V_UNIFIEDCODESET] (NOLOCK)   
    INNER JOIN [VCP_DISEASE] (NOLOCK) ON  [V_UNIFIEDCODESET].[ID]=[VCP_DISEASE].[AnimalReportWorkflowDR]    
    INNER JOIN [V_CODEPROPERTY] (NOLOCK) ON  [V_UNIFIEDCODESET].[ID]=[V_CODEPROPERTY].[SUBJCODE_ID] AND [V_CODEPROPERTY].[PROPERTY] = 'WSF_ROWID' 
    WHERE CHARINDEX('AR',@RECORDTYPECODES) > 0

    UNION ALL

    SELECT  
    VALUECODE_ID AS ProcessStatusCode_ID,
    [VCP_GroupEventType].[SUBJCODE_ID] AS DiseaseCode_ID, 
    'GE' as RecordTypeCode
    ,ROW_NUMBER() OVER (PARTITION BY [VCP_GroupEventType].[SUBJCODE_ID] ORDER BY [V_CODEPROPERTY].[VALUEINT] DESC) AS [RowNumber]
    FROM [V_UNIFIEDCODESET] (NOLOCK)   
    INNER JOIN [VCP_GroupEventType] (NOLOCK) ON  [V_UNIFIEDCODESET].[ID]=[VCP_GroupEventType].WorkFlowDR    
    INNER JOIN [V_CODEPROPERTY] (NOLOCK) ON  [V_UNIFIEDCODESET].[ID]=[V_CODEPROPERTY].[SUBJCODE_ID] AND [V_CODEPROPERTY].[PROPERTY] = 'WSF_ROWID' 
    WHERE CHARINDEX('GE',@RECORDTYPECODES) > 0
    
    RETURN
END

