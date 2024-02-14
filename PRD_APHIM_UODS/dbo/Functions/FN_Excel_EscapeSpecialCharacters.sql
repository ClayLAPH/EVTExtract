

CREATE   FUNCTION [dbo].[FN_Excel_EscapeSpecialCharacters](@Value NVARCHAR(MAX))  
RETURNS NVARCHAR(MAX)  
AS  
BEGIN  
    RETURN RTRIM(LTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@Value,'.','#'),'[','_'),']','_'),'`',''''),'!','_'),'|','_'),'$','_'),',','_'),' ','_'),'''', '_')))  
END 

