﻿
CREATE FUNCTION [dbo].[MDF_UCS_FULLNAME_ACTCHILDVALUESTRING_BYPARENTACTID]
(@METACODE VARCHAR(50), @PARENT_ACTID INT, @VALUETYPE VARCHAR(100))
RETURNS VARCHAR(255)
AS
BEGIN
    DECLARE @TEMP AS TABLE(ID INT IDENTITY(1,1), VALUE Varchar(8000))
    INSERT INTO @TEMP
            SELECT VALUE
            FROM ParmsToList(
            DBO.MDF_ACT_GETSTRINGVALUE_ACT_BYPARACTIDMETAVALUETYPE(@METACODE,@PARENT_ACTID,@VALUETYPE))
        RETURN 
        (SELECT dbo.strconcat(dbo.FN_GetUCSFullName(VALUE)) FROM @TEMP)
END

