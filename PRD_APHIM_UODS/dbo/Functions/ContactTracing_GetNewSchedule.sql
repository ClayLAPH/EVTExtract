
CREATE FUNCTION [dbo].[ContactTracing_GetNewSchedule](@followupPeriod int, @frequency int, @followUpStartDate datetime)
RETURNS @schedule table([RowNo] int, [StartDate] datetime, [EndDate] datetime)
AS
BEGIN
    SET @followUpStartDate = CAST(@followUpStartDate as date)
    Declare @endDate datetime =  DATEADD(ms, -2, DATEADD(day, @followupPeriod+1, @followUpStartDate))
    SET @frequency = CASE
                     WHEN @frequency <= 1 or @frequency > 4 -- Daily
                     THEN 1
                     WHEN @frequency = 2 -- Alternate Day
                     THEN 2
                     WHEN @frequency = 3 -- Weekly
                     THEN 7
                     WHEN @frequency = 4 -- Monthly
                     THEN 30
                 END;
    ;WITH CE AS(
    select ROW_NUMBER() OVER(ORDER BY [Value]) as [RowNo], DATEADD(day, ROW_NUMBER() OVER(ORDER BY [Value]) - 1, @followUpStartDate) as [DateValue] FROM STRING_SPLIT(SPACE((@followupPeriod - 1)), ' ')
    )
    INSERT INTO @schedule([RowNo], [StartDate], [EndDate])
    select [RowNo],  [DateValue] as [StartDate], DATEADD(ms, -2, DATEADD(day, @frequency, [DateValue])) as [EndDate] FROM CE WHERE @frequency = 1 OR (([RowNo] % @frequency = 1) OR ([RowNo] < @frequency AND [RowNo] = 1))

    RETURN
END

