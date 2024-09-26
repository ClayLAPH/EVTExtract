CREATE FUNCTION [dbo].[FN_ConcateDILRResultValueText]  (@PR_RowID AS INT)  
 RETURNS NVARCHAR(MAX)  
AS  
BEGIN   
 IF @PR_RowID IS NULL       
 BEGIN       
  RETURN NULL       
 END       
       
 DECLARE @ReturnText AS NVARCHAR(MAX)      
   
      SELECT @ReturnText = Case when ISNULL(@ReturnText+', ', '')<>', ' then ISNULL(@ReturnText+', ', '') else '' end + ISNULL([DILR_ResultValue],'')       
         
  FROM AX_LabReport (nolock)       
  INNER JOIN A_Act (nolock) ON A_Act.ID=AX_LabReport.DILR_ID AND Act_Parent_ID=@PR_RowID ;       
      
 RETURN @ReturnText 
 END  

