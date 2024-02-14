﻿CREATE FUNCTION [dbo].[UDF_GetEntityRoot](  
  @ENTITYID INT 
)  
RETURNS INT
AS  
BEGIN   
    IF @ENTITYID < 2 RETURN @ENTITYID
 
    RETURN 
    CASE (SELECT ClassCode from E_ENTITY (NOLOCK) WHERE ID = @ENTITYID)
        WHEN 'PLC' THEN ISNULL([dbo].[UDF_GetRootEntityID](@ENTITYID), @ENTITYID)
        WHEN 'ORG' THEN ISNULL([dbo].[UDF_GetRootEntityID](@ENTITYID), @ENTITYID)
        WHEN 'PSN' THEN ISNULL((SELECT TOP 1 ENTITYHX_ID FROM E_ENTITY (NOLOCK) WHERE ID = @ENTITYID), @ENTITYID)
        ELSE @ENTITYID
    END
END