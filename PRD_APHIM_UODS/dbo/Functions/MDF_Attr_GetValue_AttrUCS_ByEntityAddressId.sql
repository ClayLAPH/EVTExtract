
CREATE FUNCTION [dbo].[MDF_Attr_GetValue_AttrUCS_ByEntityAddressId]  
(@EntityAddrId int, @Name varchar(50))  
RETURNS sql_variant  
AS  
BEGIN  
  
RETURN (  
  SELECT    V_Unifiedcodeset.fullName 
  FROM      T_Attribute (nolock) 
			INNER JOIN V_Unifiedcodeset (nolock) ON V_Unifiedcodeset.ID = T_Attribute.valueCode_ID
  WHERE     (T_Attribute.EntityAddress_ID = @EntityAddrId AND T_Attribute.[Name] = @Name)  
  )  
END  

