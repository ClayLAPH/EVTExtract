
Create function [Sync].[FN_Excel_EscapeSpecialCharacters](@Value nvarchar(MAX))
returns nvarchar(MAX)
AS
BEGIN

return RTRIM(LTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@Value,'.','#'),'[','_'),']','_'),'`',''''),'!','_'),'|','_'),'$','_'),',','_'),' ','_')))

END

