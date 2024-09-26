
CREATE   FUNCTION [dbo].[FN_CalculateEPIWeek] 
( 
    @InputDate SMALLDATETIME 
) 
RETURNS TINYINT 
AS 
BEGIN 
    DECLARE @EPIWeek TINYINT 

    --First epi week (i.e if 0401 of year falls in first week, then it will give perfect start epiweek)
    SET @EPIWeek = DATEPART(WEEK,@InputDate)+1 - DATEPART(WEEK,RTRIM(YEAR(@InputDate))+'0104') 
    --If 0401 of year falls in second week, then change to epiweek of last year
    IF @EPIWeek = 0 
    BEGIN 
        SET @EPIWeek = dbo.FN_CalculateEPIWeek(RTRIM(YEAR(@InputDate)-1)+'1231')
    END 

    --Last epi week (ie. If any date after 2812 falls below wednesday, then it is first epiweek of next year)
    IF MONTH(@InputDate) = 12 AND DAY(@InputDate)-DATEPART(DW,@InputDate) >= 28 
    BEGIN 
        SET @EPIWeek=1 
    END 

    RETURN(@EPIWeek)
END
