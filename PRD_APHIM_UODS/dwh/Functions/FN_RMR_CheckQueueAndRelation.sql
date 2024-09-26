/*******************************************************/

/****** Object:  Function [DWH].[FN_RMR_CheckQueueAndRelation]     ******/
CREATE   FUNCTION [DWH].[FN_RMR_CheckQueueAndRelation] (@QAR_RowID int,@QAR_QDRowID int, @QAR_ADRowID int)
RETURNS bit
AS 
BEGIN
  DECLARE  @QD_CIRowID int, @AD_CIRowID int
    select @QD_CIRowID=QD_CIRowID from dwh.[Engine_QueueDef]  QD (nolock) where QD_RowID=@QAR_QDRowID
    select  @AD_CIRowID=AD_CIRowID from dwh.[Engine_APPDef] AD (nolock) where AD_RowID=@QAR_ADRowID  
    if @QD_CIRowID >0 or @AD_CIRowID >0 -- Used for cluster
    BEGIN
        if isnull(@QD_CIRowID,0)=isnull(@AD_CIRowID,0)
            return 1
        ELSE
            return 0
    END
    --Only one app and Queue pair will be available
    if @QD_CIRowID is null and (select count(1) from [dwh].[Engine_QueueAppRelation] (nolock) where  QAR_QDRowID=@QAR_QDRowID)>1
        return 0
    --if @AD_CIRowID is null and (select count(1) from [DWH].[Engine_QueueAppRelation] (nolock) where QAR_ADRowID= @QAR_ADRowID )>1
    --  return 0
    return 1
END;
