﻿
CREATE FUNCTION [DBO].[MDF_ATTR_GETREALVALUE_ENTATTR_BYENTITYADDRESSID]  
(@ENTITYADDRID INT, @NAME VARCHAR(50))  
RETURNS REAL 
AS  
BEGIN  

RETURN (  
SELECT        
T_ATTRIBUTE.VALUEREAL 
FROM      T_ATTRIBUTE (NOLOCK)
WHERE     (T_ATTRIBUTE.ENTITYADDRESS_ID = @ENTITYADDRID AND T_ATTRIBUTE.[NAME] = @NAME)  
)  
END  
