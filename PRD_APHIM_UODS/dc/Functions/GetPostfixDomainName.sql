
CREATE FUNCTION [dc].[GetPostfixDomainName](@DomainName VARCHAR(100))
RETURNS VARCHAR(100)
AS
BEGIN

    DECLARE @UpdatedDomainName VARCHAR(100)
    DECLARE @Counter INT

    SET @UpdatedDomainName = @DomainName + '_UDVoc' ;
    SET @Counter = 0;
    WHILE ((SELECT count(*) FROM V_DOMAIN (NOLOCK) WHERE domainName =@UpdatedDomainName) > 0)
    BEGIN
        SET @Counter = @Counter + 1
        SET @UpdatedDomainName = @UpdatedDomainName + CONVERT(varchar(10), @Counter)
        CONTINUE;
    END
    
    RETURN (@UpdatedDomainName)
END
