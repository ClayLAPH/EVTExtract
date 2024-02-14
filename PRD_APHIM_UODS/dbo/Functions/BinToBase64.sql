----------------------------------------------------------------------------------------------------
CREATE   FUNCTION BinToBase64(@binData varbinary(max))
RETURNS VARCHAR(MAX)
AS
BEGIN
    if @binData=null or DATALENGTH(@binData)=0
    BEGIN
        Return null
    END
    declare @retData varchar(max) 
    select @retData=dummycol
    from openjson(
    (
        select dummycol
        from (SELECT @binData as dummycol) T
        for json auto
    )
    ) with(dummycol varchar(max))
    return @retData
END
