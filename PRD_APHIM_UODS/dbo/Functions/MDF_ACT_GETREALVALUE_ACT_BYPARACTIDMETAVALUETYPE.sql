﻿
CREATE FUNCTION [dbo].[MDF_ACT_GETREALVALUE_ACT_BYPARACTIDMETAVALUETYPE]  
(@METACODE VARCHAR(50), @PARENT_ACTID INT, @VALUETYPE VARCHAR(100))  
RETURNS REAL  
AS  
BEGIN  

    DECLARE @RealMinVal AS REAL
    SET @RealMinVal = CAST(-(1 + (POWER(2e0,23)-1)/POWER(2e0,23)) * POWER(2e0,127) AS real)

    RETURN (  
    SELECT        
    CASE @VALUETYPE  
    WHEN 'VALUEREAL'  THEN (CASE WHEN VALUEREAL = @RealMinVal THEN NULL ELSE VALUEREAL END)
    WHEN 'VALUEDENOMINATOR' THEN (CASE WHEN VALUEDENOMINATOR  = @RealMinVal THEN NULL ELSE VALUEDENOMINATOR END)
    WHEN 'VALUENUMERATOR' THEN (CASE WHEN VALUENUMERATOR  = @RealMinVal THEN NULL ELSE VALUENUMERATOR END) 
    END  
    FROM A_ACT  (NOLOCK)
    WHERE (METACODE = @METACODE) AND (ACT_PARENT_ID = @PARENT_ACTID)  
    )  
END  
