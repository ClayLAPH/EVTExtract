CREATE FUNCTION [dbo].[FN_LatestImportDate] (@Act_ID INT)
                RETURNS DATETIME
AS
BEGIN     
                DECLARE @DT DATETIME
                
                --+ Fetch the latest Imported date for an incident 
                SELECT @DT=MAX([DateProcessed]) 
                FROM [S_ProcessedPRRecord] (nolock) 
                WHERE @Act_ID IN([CurrentLiveRecord_ID],[OriginalLiveRecord_ID]) AND Statuscode='active'
                --- Fetch the latest Imported date for an incident 
                
                RETURN @DT
END
