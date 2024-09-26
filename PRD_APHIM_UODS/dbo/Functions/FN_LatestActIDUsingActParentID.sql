  
CREATE FUNCTION [dbo].[FN_LatestActIDUsingActParentID] (@Act_ID INT,@Metacode varchar(50))  
                RETURNS INT  
AS  
BEGIN       
                DECLARE @ID INT  
                SELECT @ID=MAX(ID)   
                FROM A_Act (nolock)   
                WHERE Act_Parent_ID=@Act_ID  and metaCode=@Metacode
                GROUP BY [Act_Parent_ID]                   
                RETURN @ID  
END  

