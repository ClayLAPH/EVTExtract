
CREATE FUNCTION [dbo].[CSVtoTableWithRowNo]
(
    @stringLIST VARCHAR(MAX),
    @delimeter varchar(10)
)
RETURNS @RET_Table TABLE (RowNo int,ColValue VARCHAR(300))
AS
BEGIN
    declare @delmIndex int=1
    declare @startIndex int=1
    declare @strLength int = len(@stringLIST)
    declare @RowNo as int=1
   
    while(@delmIndex<>0)
    Begin
        set @delmIndex=CHARINDEX(@Delimeter,@stringLIST,@startIndex)
        if @delmIndex=0 
            insert into @RET_Table
            select @RowNo,SUBSTRING(@stringLIST,@startIndex,@strLength)
        else
            begin
                insert into @RET_Table
                select @RowNo,SUBSTRING(@stringLIST,@startIndex,@delmIndex-@startIndex)
            end
        set @startIndex=@delmIndex+1
        set @RowNo=@RowNo+1
    End
    RETURN 
END
