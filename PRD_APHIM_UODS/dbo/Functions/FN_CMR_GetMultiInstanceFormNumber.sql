
--BLK Function created to get the List Section Number for a UDForm
CREATE  FUNCTION [dbo].[FN_CMR_GetMultiInstanceFormNumber] ( @RecordActID AS INT , @blnIsMultiInstanceForm AS BIT)  
RETURNS @MutliInstanceFormNumberTable TABLE  
(  
 SecActID     INT,   
 MultiInstanceFormNumber  INT   
)  
AS  
BEGIN --BLK Begin Function  
  If @blnIsMultiInstanceForm = 1
  BEGIN --Check if not independant section
      INSERT @MutliInstanceFormNumberTable  
      SELECT A_Act.ID , ROW_NUMBER () OVER (PARTITION BY Code_ID ORDER BY A_Act.ID)  AS MultiInstanceFormNumber FROM   
      dbo.A_Act (NoLock) 
      INNER JOIN A_ActRelationship (nolock) ON target_ID = A_Act.ID
      INNER JOIN VCP_UDForm VCP (NOLOCK) ON VCP.SubjCode_ID = code_ID
      WHERE source_ID = @RecordActID  
  END
 RETURN 
END  
