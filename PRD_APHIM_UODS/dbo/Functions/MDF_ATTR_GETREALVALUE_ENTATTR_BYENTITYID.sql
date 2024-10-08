﻿
CREATE FUNCTION [DBO].[MDF_ATTR_GETREALVALUE_ENTATTR_BYENTITYID]  
(@ENTITYID INT,  @NAME VARCHAR(50))  
RETURNS REAL
AS  
BEGIN  

RETURN (  
SELECT        
T_ATTRIBUTE.VALUEREAL 
FROM      T_ATTRIBUTE (NOLOCK)
WHERE     (T_ATTRIBUTE.ENTITY_ID = @ENTITYID AND T_ATTRIBUTE.[NAME] = @NAME)  
)  
END  
