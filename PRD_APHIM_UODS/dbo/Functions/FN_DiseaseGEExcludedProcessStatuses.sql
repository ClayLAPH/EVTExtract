
CREATE FUNCTION [dbo].[FN_DiseaseGEExcludedProcessStatuses]  (@RecordType char(2))  
 RETURNS @DiseaseGEExcludedProcessStatus TABLE (DiseaseORGE Int, ExcludedProcessStatus Int,
 PRIMARY KEY (DiseaseORGE,ExcludedProcessStatus))
AS  
BEGIN   
    Declare @xmlEPS XML 
    IF @RecordType = 'DI'
    BEGIN
        Set @xmlEPS = (
        Select SubjCode_ID as DIS, cast('<PS>' + replace(ExcludeProcessStatusesFromCaseLoadForDI,',','</PS><PS>') + '</PS>' as xml) from VCP_Disease (nolock)  
        Where len(IsNull(ExcludeProcessStatusesFromCaseLoadForDI,'')) > 0
        FOR XML RAW('row'), ROOT, ELEMENTS
        )
    END
    ELSE IF @RecordType = 'CI'
    BEGIN
        Set @xmlEPS = (
        Select SubjCode_ID as DIS, cast('<PS>' + replace(ExcludeProcessStatusesFromCaseLoadForCI,',','</PS><PS>') + '</PS>' as xml) from VCP_Disease (nolock) 
        Where len(IsNull(ExcludeProcessStatusesFromCaseLoadForCI,'')) > 0
        FOR XML RAW('row'), ROOT, ELEMENTS
        )
    END
    ELSE IF @RecordType = 'OB'
    BEGIN
        Set @xmlEPS = (
        Select SubjCode_ID as DIS, cast('<PS>' + replace(ExcludeProcessStatusesFromCaseLoadForOB,',','</PS><PS>') + '</PS>' as xml) from VCP_Disease (nolock) 
        Where len(IsNull(ExcludeProcessStatusesFromCaseLoadForOB,'')) > 0
        FOR XML RAW('row'), ROOT, ELEMENTS
        )
    END
    ELSE IF @RecordType = 'GE'
    BEGIN
        Set @xmlEPS = (
        Select SubjCode_ID as DIS, cast('<PS>' + replace(ExcludeProcessStatusesFromCaseLoadForGE,',','</PS><PS>') + '</PS>' as xml) from VCP_GroupEventType  (nolock)
        Where len(IsNull(ExcludeProcessStatusesFromCaseLoadForGE,'')) > 0
        FOR XML RAW('row'), ROOT, ELEMENTS
        )
    END

    IF @xmlEPS is not null 
    BEGIN
        INSERT INTO @DiseaseGEExcludedProcessStatus
        SELECT t.value('./parent::*/DIS[1]', 'int') as DiseaseORGE, t.value('.','int') as ExcludedProcessStatus
        FROM @xmlEPS.nodes('/root/row/PS') as xmlEPS(t)
    END
    
    Return
END
