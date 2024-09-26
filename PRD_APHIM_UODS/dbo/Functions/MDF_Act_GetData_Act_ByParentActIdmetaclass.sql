
CREATE FUNCTION [dbo].[MDF_Act_GetData_Act_ByParentActIdmetaclass]  
(@ValueType varchar(100), @Parent_ActId int, @classCode varchar(50), @metaCode varchar(50) )  
RETURNS sql_variant  
AS  
BEGIN  
  
return (  
  SELECT        
     case @ValueType  
      When 'valueBool'  then cast( valueBool as sql_variant) 
      When 'text'    then cast( [text] as varchar(8000)) 
      When 'valueInteger'  then cast( valueInteger as sql_variant) 
	  When 'ValueNumerator' then cast( ValueNumerator AS sql_variant) 
	  When 'valueString'  then cast( valueString as sql_variant)
	  When 'effectiveTime_Beg'then cast( effectiveTime_Beg as sql_variant)  
	  When 'valueTS'   then cast( valueTS as sql_variant)  
      else  cast('INVALID VALUE TYPE' as sql_variant)  
     end  
  FROM A_Act  (Nolock)
  WHERE (metaCode = @metaCode) AND (Act_Parent_ID = @Parent_ActId)  and (classcode = @classCode)
  )  
END  

