
Create Function [Sync].[FN_ConvertImpreciseDate](@Value AS varchar(50))
RETURNS nvarchar(50)
AS
BEGIN

DECLARE @Return AS Varchar(100) = ''
SET @Return = @Value

If (@Value <> '' AND LEN(@Value)=8 )
BEGIN
    If (@Value Like '%0000')
    BEGIN
        SET @Return = SUBSTRING(@Value, 1, 4);
    END
    ELSE IF (@Value Like '%00')
    BEGIN
        SET @Return = SUBSTRING(@Value, 5, 2) + '/' + SUBSTRING(@Value, 1, 4)
    END
    ELSE
    BEGIN
        SET @Return =  SUBSTRING(@Value, 5, 2) + '/' + SUBSTRING(@Value, 7, 2) + '/' + SUBSTRING(@Value, 1, 4)
    END
END
RETURN @Return
END
