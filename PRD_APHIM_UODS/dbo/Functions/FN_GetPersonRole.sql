﻿
CREATE   FUNCTION [dbo].[FN_GetPersonRole]   
(  
    @PER_ROOTID INT,  
    @RoleType VARCHAR(50)   
)  
RETURNS BIT  
AS  
BEGIN  
    DECLARE @HasRole bit = 0  
    IF @RoleType = 'PAT'  
    BEGIN  
        SELECT @HasRole=ISNULL((SELECT TOP 1 1 FROM R_ROLE A (nolock)   
        INNER JOIN S_LINK (nolock) ON S_LINK.ENTITY1_ID=@PER_ROOTID AND S_LINK.[NAME]='Patient-Case'  
        INNER JOIN A_ACT ACASE (nolock) ON ACASE.ID=S_LINK.ACT1_ID AND ACASE.CLASSCODE='CASE'  
        INNER JOIN A_PUBLICHEALTHCASE PHCASE (nolock) ON PHCASE.ID=ACASE.ID  
        LEFT JOIN V_UNIFIEDCODESET UCS (nolock) ON UCS.ID=PHRECORDTYPECODE_ID  
        WHERE A.CLASSCODE='PAT' AND NOT (A.STATUSCODE='NULLIFIED' OR A.STATUSCODE='TERMINATED') AND   
        NOT (ACASE.STATUSCODE='NULLIFIED' OR ACASE.STATUSCODE='TERMINATED') AND   
        A.PLAYER_ID=@PER_ROOTID AND (UCS.CONCEPTCODE='DI' OR UCS.CONCEPTCODE='SVC' OR UCS.CONCEPTCODE IS NULL)), 0)  
    END  
    IF @RoleType = 'MBR'  
    BEGIN  
        SELECT @HasRole= ISNULL((SELECT TOP 1 1 FROM R_ROLE B (NOLOCK)  
        LEFT JOIN S_LINK (nolock) ON S_LINK.ENTITY1_ID=@PER_ROOTID AND S_LINK.[NAME]='Patient-Case'  
        LEFT JOIN A_ACT ACASE (nolock) ON ACASE.ID=S_LINK.ACT1_ID AND ACASE.CLASSCODE='CASE'  
        LEFT JOIN A_PUBLICHEALTHCASE PHCASE (nolock) ON PHCASE.ID=ACASE.ID  
        LEFT JOIN V_UNIFIEDCODESET UCS (nolock) ON UCS.ID=PHRECORDTYPECODE_ID AND UCS.CONCEPTCODE='CI'    
        WHERE B.PLAYER_ID=@PER_ROOTID AND (B.CLASSCODE = 'MBR' OR (B.CLASSCODE='PAT' AND NOT UCS.ID IS NULL AND NOT ACASE.statusCode IN ('NULLIFIED','TERMINATED')))   
        AND NOT (B.STATUSCODE='NULLIFIED' OR B.STATUSCODE='TERMINATED')), 0)    
    END  
    IF @RoleType = 'PRS'    
    BEGIN       
        SELECT @HasRole = ISNULL((SELECT TOP 1 1 FROM R_ROLE C (NOLOCK)   
        WHERE C.CLASSCODE='PRS'   
        AND NOT (C.STATUSCODE='NULLIFIED' OR C.STATUSCODE='TERMINATED')   
        AND C.PLAYER_ID=@PER_ROOTID), 0)  
    END  
    RETURN @HasRole  
END  
