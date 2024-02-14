--BLK Function created to get the List Section Number for a UDForm
CREATE  FUNCTION [dbo].[GetListSectionNumber] ( @UDFormActID AS INT , @bIndependentSection AS BIT)  
RETURNS @ListSectionNumberTable TABLE  
(  
 SecActID     INT,   
 ListSectionNumber  INT   
)  
AS  
BEGIN --BLK Begin Function  
  If @bIndependentSection = 0
  BEGIN --Check if not independant section
	  INSERT @ListSectionNumberTable  
	  SELECT ID , ROW_NUMBER () OVER (PARTITION BY Code_ID ORDER BY ID)  AS ListSectionNumber FROM   
	  dbo.A_Act NoLock WHERE Code_ID IN (  
	  SELECT SubjCode_ID FROM dbo.VCP_UDSection NoLock WHERE SEC_IsListSection = 1) AND Act_Parent_ID = @UDFormActID  
  END
  ELSE
  BEGIN --Check if independant section
	  INSERT @ListSectionNumberTable  
	  SELECT A_Act.ID , ROW_NUMBER () OVER (PARTITION BY A_Act.Code_ID ORDER BY A_Act.ID)  AS ListSectionNumber FROM   
	  dbo.A_Act (nolock) INNER JOIN A_ActRelationship (nolock) ON target_ID = A_Act.ID
	  WHERE Code_ID IN ( SELECT SubjCode_ID FROM dbo.VCP_UDSection NoLock WHERE SEC_IsListSection = 1) AND source_ID = @UDFormActID    
  END   
 RETURN 
END  

