
CREATE VIEW [AtlasInternal].[VIEW_CMN_GetChildTopicAct]
AS
SELECT ChildTopic.statusCode,ChildTopic.code_id,Docbody.[Act_Parent_ID],ChildTopic.[metaCode] 
FROM [A_Act] Docbody (NOLOCK)
INNER JOIN [A_Act] Topic (NOLOCK) ON  Topic.[Act_Parent_ID]=Docbody.id AND   Topic.[classCode] = 'TOPIC' 
INNER JOIN  [A_Act] ChildTopic (NOLOCK) ON  ChildTopic.ACT_PARENT_ID=Topic.id 
WHERE Docbody.[classCode] = 'DOCBODY'

