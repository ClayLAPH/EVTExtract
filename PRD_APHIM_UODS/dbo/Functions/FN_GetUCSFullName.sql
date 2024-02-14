﻿
CREATE FUNCTION [dbo].[FN_GetUCSFullName] (@ID INT)
	RETURNS VARCHAR(255)
AS
BEGIN
	DECLARE @FullName VARCHAR(255)
	SELECT @FullName = FullName FROM V_UnifiedCodeSet (nolock) WHERE ID = @ID
	RETURN @FullName
END