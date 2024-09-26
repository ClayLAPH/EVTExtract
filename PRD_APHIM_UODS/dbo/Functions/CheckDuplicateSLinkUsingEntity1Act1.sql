
CREATE FUNCTION [DBO].[CheckDuplicateSLinkUsingEntity1Act1](@Name VARCHAR(50), @Act1_ID int, @Entity1_ID INT)  
RETURNS BIT  
AS  
BEGIN  

DECLARE @IsDuplicate bit=0
DECLARE @COUNT INT

IF @Name='GE_ClientRecordDR'
BEGIN
	SELECT @COUNT = COUNT(*) FROM S_LINK S (NOLOCK) WHERE S.NAME='GE_ClientRecordDR' AND S.ACT1_ID=@Act1_ID AND S.ENTITY1_ID=@Entity1_ID
	IF @COUNT > 1 SET @IsDuplicate = 1
END 
RETURN @IsDuplicate

END
