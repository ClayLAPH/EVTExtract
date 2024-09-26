
CREATE   FUNCTION [dbo].[FN_GetTiterValue]
(
  @ResultValue VARCHAR(100)
)
RETURNS VARCHAR(256)
AS
BEGIN
    IF ISNUMERIC(@ResultValue) = 1
        RETURN @ResultValue
    IF PATINDEX('%1:%', @ResultValue)= 1
    BEGIN
        DECLARE @intAlpha INT
        SET @intAlpha = PATINDEX('%1:%', @ResultValue)
        BEGIN
            WHILE @intAlpha > 0
            BEGIN
                SET @ResultValue = STUFF(@ResultValue, @intAlpha, 1, '' )
                SET @intAlpha = PATINDEX('%[^0-9]%', @ResultValue )
            END
        END
        RETURN ISNULL(@ResultValue,0)
    END
    RETURN NULL
END
