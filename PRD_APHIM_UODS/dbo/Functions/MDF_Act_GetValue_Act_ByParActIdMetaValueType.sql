﻿
CREATE FUNCTION [dbo].[MDF_Act_GetValue_Act_ByParActIdMetaValueType]  
(@metaCode varchar(50), @Parent_ActId int, @ValueType varchar(100))  
RETURNS sql_variant  
AS  
BEGIN  
  
return (  
  SELECT        
     case @ValueType  
      When 'valueBool'  then cast( valueBool as sql_variant)  
      When 'valueInteger'  then cast( valueInteger as sql_variant)  
      When 'valueReal'  then cast( valueReal as sql_variant)  
      When 'valueTS'   then cast( valueTS as sql_variant)  
      When 'ValueTSEnd'  then cast( ValueTSEnd as sql_variant)  
      When 'valueString'  then cast( valueString as sql_variant)  
      When 'valueString_Txt' then cast( valueString_Txt as sql_variant)  
      When 'effectiveTime_Beg'then cast( effectiveTime_Beg as sql_variant)  
      When 'effectiveTime_End'then cast( effectiveTime_End as sql_variant)  
      When 'title'   then cast( [title] as sql_variant)  
      When 'text'    then cast( [text] as varchar(8000))  
      When 'valueCode_ID'  then cast( valueCode_ID as sql_variant)  
      When 'valueDenominator' then cast( valueDenominator as sql_variant) 
	  When 'EffectiveTime_Txt' then cast( EffectiveTime_Txt AS sql_variant)
	  When 'ValueNumerator' then cast( ValueNumerator AS sql_variant) 
      else  cast('INVALID VALUE TYPE' as sql_variant)  
     end  
  FROM A_Act  (Nolock)
  WHERE (metaCode = @metaCode) AND (Act_Parent_ID = @Parent_ActId)  
  )  
END  
