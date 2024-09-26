
CREATE FUNCTION [dbo].[FN_Base64ToBinary] ( @input nvarchar(max) )
returns varbinary(max)
BEGIN
 
	RETURN CAST(N'' AS XML).value('xs:base64Binary(sql:variable("@input"))', 'varbinary(max)')
 
END

