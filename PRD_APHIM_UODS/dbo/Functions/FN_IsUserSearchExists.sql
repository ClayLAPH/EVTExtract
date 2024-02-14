
CREATE   FUNCTION [dbo].[FN_IsUserSearchExists] 
( 
	@userId INT, 
	@pageNameCode VARCHAR(255), 
	@searchString NVARCHAR(MAX), 
	@searchType VARCHAR(255)
)  
RETURNS BIT
AS  
BEGIN
    DECLARE @hashValue AS VARCHAR(255)
    DECLARE @PageID AS INT
    SELECT @hashValue=CONVERT(VARCHAR(255),HASHBYTES('SHA2_512',@searchString),2) ;
    SELECT @PageId= ID FROM S_PageDetails(NOLOCK) WHERE ConceptCode=@pageNameCode
    
    IF Exists (SELECT * FROM S_UserSearch (NOLOCK) WHERE (UserID=@userID AND PageNameID=@PageID AND SearchType=@searchType AND HashValue = @hashValue)) RETURN 1
    RETURN 0
END
