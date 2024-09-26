
CREATE FUNCTION [dbo].[FN_IncidentIsReferred]  (@ID INT)  
 RETURNS BIT  
AS  
BEGIN   
 DECLARE @result AS BIT   
 SET @result = (SELECT DISTINCT CASE WHEN ActRefer.[statusCode]='active' THEN 1 ELSE 0 END AS [DI_Referred]  FROM [DV_PHPersonalRecord] (nolock) 
 LEFT JOIN [A_ActRelationship] ActRel (nolock) ON  [DV_PHPersonalRecord].[DVPR_RowID]=ActRel.[target_ID] AND ( ( ActRel.[typeCode] = 'SUBJ'))   
 INNER JOIN [A_Act] ActRefer (nolock) ON  ActRefer.[ID]=ActRel.[source_ID] AND ( ( ActRefer.[metaCode] = 'PR_Referred' AND ActRefer.[classCode] = 'INFO' AND ActRefer.[moodCode] = 'EVN'))   
 WHERE  [DV_PHPersonalRecord].[DVPR_RowID] =@ID)  
  
 RETURN @result  
END 

