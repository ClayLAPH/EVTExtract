
CREATE FUNCTION [dbo].[FN_GetMultiInstanceNumber] (@Actid as int, @Udformid as int, @UDFormDefID as int)  
  RETURNS INT  
  AS  
BEGIN  

 DECLARE @MultiInstanceNumber INT  
 DECLARE @TBLMultiInstanceNumber TABLE (ID INT, MultiInstanceNumber INT IDENTITY)  
 
BEGIN	--BLK_SelectIntoTempTable
	  INSERT INTO @TBLMultiInstanceNumber  (ID)  
	   SELECT a_act.id 
	   FROM A_Act (nolock)
	   INNER JOIN A_ActRelationship (nolock) on A_Act.ID=A_ActRelationship.target_ID 
	   INNER JOIN VCP_UDForm VCP (nolock) on VCP.subjCode_Id = A_Act.code_ID --MSaha #148467 [Added Join with VCP_UDForm]
	   WHERE   source_ID = @Actid and A_Act.code_ID = @UDFormDefID  AND VCP.FRM_IsMultipleInstance = 1
	   ORDER BY A_Act.ID 	  
END 

SELECT @MultiInstanceNumber = MultiInstanceNumber FROM @TBLMultiInstanceNumber WHERE ID = @Udformid  
RETURN @MultiInstanceNumber  

END 

