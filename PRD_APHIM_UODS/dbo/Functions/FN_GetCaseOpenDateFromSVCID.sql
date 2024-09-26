
CREATE FUNCTION [dbo].[FN_GetCaseOpenDateFromSVCID]  (@SVC_ID AS INT, @PATCode_ID AS INT, @ENCCode_ID AS INT)
	RETURNS DATETIME
AS
BEGIN
	DECLARE @SRCHRESU_CaseOpenDate  AS DATETIME

	SELECT @SRCHRESU_CaseOpenDate = [ACT_CaseOpenDate].[effectiveTime_Beg] 
	FROM [A_Act] [ACT_CaseOpenDate] (nolock) 
	LEFT JOIN [A_Act] [ACT_DOCBODY] (nolock) ON  [ACT_DOCBODY].[ID]=[ACT_CaseOpenDate].[Act_Parent_ID] 
	AND [ACT_DOCBODY].[code_ID] =@ENCCode_ID
	LEFT JOIN [A_Act] [ACT_Folder] (nolock) ON  [ACT_Folder].[ID]=[ACT_DOCBODY].[Act_Parent_ID] 
	AND [ACT_Folder].[code_ID] = @PATCode_ID
	LEFT JOIN [A_Act] ACT_CASE (nolock) ON  [ACT_Folder].[ID]=[ACT_CASE].[Act_Parent_ID] 
	AND [ACT_CASE].[ID] = @SVC_ID AND [ACT_CASE].[classCode] = 'CASE'
	WHERE [ACT_CaseOpenDate].[metaCode] = 'MGMTEPISD_ID'
 	
   RETURN @SRCHRESU_CaseOpenDate
END
