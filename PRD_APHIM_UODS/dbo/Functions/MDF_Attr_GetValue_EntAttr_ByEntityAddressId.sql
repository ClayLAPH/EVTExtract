
CREATE FUNCTION [dbo].[MDF_Attr_GetValue_EntAttr_ByEntityAddressId]  
(@EntityAddrId int, @ValueType varchar(100), @Name varchar(50))  
RETURNS sql_variant  
AS  
BEGIN  
  
RETURN (  
  SELECT        
     CASE @ValueType  
      WHEN 'valueBool'  THEN CAST( T_Attribute.valueBool AS sql_variant)  
      WHEN 'valueInteger'  THEN CAST( T_Attribute.valueInteger AS sql_variant)  
      WHEN 'valueReal'  THEN CAST( T_Attribute.valueReal AS sql_variant)  
      WHEN 'valueTS'   THEN CAST( T_Attribute.valueTS AS sql_variant)  
      WHEN 'ValueTSEnd'  THEN CAST( T_Attribute.ValueTSEnd AS sql_variant)  
      WHEN 'valueString'  THEN CAST( T_Attribute.valueString AS sql_variant)  
      WHEN 'valueString_Txt' THEN CAST( T_Attribute.valueString_Txt AS sql_variant)  
      WHEN 'valueCode_OrTx' THEN CAST( T_Attribute.valueCode_OrTx AS sql_variant) 
      ELSE  CAST('INVALID VALUE TYPE' AS sql_variant)  
     END  
  FROM      T_Attribute (Nolock)
  WHERE     (T_Attribute.EntityAddress_ID = @EntityAddrId AND T_Attribute.[Name] = @Name)  
  )  
END  
