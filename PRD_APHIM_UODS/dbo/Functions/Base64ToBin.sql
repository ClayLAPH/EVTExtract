----------------------------------------------------------------------------------------------------
CREATE   FUNCTION Base64ToBin(@base64String varchar(max))
RETURNS VARBINARY(max)
AS
BEGIN
    if isnull(@base64String,'')=''
    BEGIN
        Return null
    END
    declare @retData varbinary(max) 
    select @retData=dummycol
    from openjson(
        (
            select dummycol
            from (SELECT @base64String as dummycol) T
            for json auto
        )
    ) with(dummycol varbinary(max))
    return @retData
END
