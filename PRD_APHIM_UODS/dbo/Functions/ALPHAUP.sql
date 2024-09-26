
CREATE FUNCTION dbo.ALPHAUP(@InitialWord VARCHAR(50))
RETURNS VARCHAR(50)
WITH SCHEMABINDING
AS
BEGIN

    DECLARE @FinalWord VARCHAR(50)
    DECLARE @Counter INT
    DECLARE @WordLength INT
    DECLARE @CurrentLetter CHAR

    SET @WordLength = LEN(@InitialWord)
    SET @Counter = 1
    SET @FinalWord = ''

    WHILE (@Counter <= @WordLength)
    BEGIN
        SET @CurrentLetter = SUBSTRING(@InitialWord,@Counter,1)
        IF ((@CurrentLetter >= 'A' AND @CurrentLetter <= 'Z') Or (@CurrentLetter >= '0' AND @CurrentLetter <= '9') Or @CurrentLetter = ',' Or @CurrentLetter = '?')
                SET @FinalWord = @FinalWord + UPPER(@CurrentLetter)
        SET @Counter = @Counter + 1
    END

    RETURN (@FinalWord)
END
