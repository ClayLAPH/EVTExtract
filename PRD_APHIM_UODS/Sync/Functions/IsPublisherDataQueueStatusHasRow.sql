CREATE   FUNCTION [sync].IsPublisherDataQueueStatusHasRow()
RETURNS bit
AS
BEGIN
    -- Declare the return variable here
    DECLARE @returnVal bit=0
    
        if (select count(1) from [SYNC].[PublisherDataQueueStatus])>1
            set @returnVal=1
        else
            set @returnVal=0
    -- Return the result of the function
    RETURN @returnVal

END
