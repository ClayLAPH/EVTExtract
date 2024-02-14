		
CREATE FUNCTION Split(@sInputList VARCHAR(200), @sDelimiter VARCHAR(200), @iIndex Integer)
	  RETURNS Varchar(200)

	BEGIN
	DECLARE @sItem VARCHAR(200)
	DECLARE @List TABLE (Id int identity(1,1),item VARCHAR(200))
	DECLARE @iCounter Integer

	WHILE CHARINDEX(@sDelimiter,@sInputList,0) <> 0
	BEGIN
	SELECT
		@sItem=RTRIM(LTRIM(SUBSTRING(@sInputList,1,CHARINDEX(@sDelimiter,@sInputList,0)-1))),
		@sInputList=RTRIM(LTRIM(SUBSTRING(@sInputList,CHARINDEX(@sDelimiter,@sInputList,0)+LEN(@sDelimiter),LEN(@sInputList))))
 
	IF LEN(@sItem) > 0
		INSERT INTO @List SELECT @sItem
	END

	IF LEN(@sInputList) > 0
		INSERT INTO @List SELECT @sInputList -- Put the last item in
 
	RETURN (SELECT item from @List where Id=@iIndex)
END

