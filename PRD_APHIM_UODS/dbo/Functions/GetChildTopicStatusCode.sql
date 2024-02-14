
CREATE   FUNCTION [dbo].[GetChildTopicStatusCode](@ACT_PARENT_ID INT)
RETURNS @DISTTable TABLE(Code_ID INT, [STATUSCODE] VARCHAR(50))
AS
BEGIN
	INSERT INTO @DISTTable
	SELECT ChildTopic.Code_ID, MAX(ChildTopic.[STATUSCODE]) AS [STATUSCODE]
	FROM [A_Act] Docbody (NOLOCK)
	INNER JOIN [A_Act] Topic (NOLOCK) ON  Topic.[Act_Parent_ID]=Docbody.id AND   Topic.[classCode] = 'TOPIC' 
	INNER JOIN  [A_Act] ChildTopic (NOLOCK) ON  ChildTopic.ACT_PARENT_ID=Topic.id 
	WHERE Docbody.[classCode] = 'DOCBODY' AND ChildTopic.METACODE='DIST_ROWID' AND Docbody.Act_Parent_ID = @ACT_PARENT_ID
	GROUP BY ChildTopic.Code_ID
	RETURN
END
