﻿
CREATE FUNCTION [dbo].[FN_CMR_GetAccessibleServiceCategoriesByUserGroupDR](@UserGroupDR INT)  
RETURNS 
    @SVCCatIDTABLE TABLE    
    ( SVCCatID Int )    
AS    
BEGIN   
  INSERT INTO @SVCCatIDTABLE  

  SELECT  DISTINCT ATT.valueCode_ID as SVCCatID
  FROM 
    T_Attribute ATT (NOLOCK) 
    INNER JOIN V_UNIFIEDCODESET UCS_SVCCAT (NOLOCK) ON UCS_SVCCAT.ID=ATT.VALUECODE_ID
    INNER JOIN A_ACT ACTPROTOCOL (NOLOCK) ON ACTPROTOCOL.TITLE = CAST(UCS_SVCCAT.OTHERINFO AS VARCHAR(300)) 
               AND ACTPROTOCOL.CLASSCODE = 'ACT' AND ACTPROTOCOL.MOODCODE = 'DEF' AND ACTPROTOCOL.STATUSCODE = 'ACTIVE'
    INNER JOIN T_ATTRIBUTE ATTPROTOCOL (NOLOCK) ON ATTPROTOCOL.ACT_ID = ACTPROTOCOL.ID AND ATTPROTOCOL.NAME = 'PROT_FORMNAME_FK'
    INNER JOIN VCP_UDFORM UDF (NOLOCK) ON UDF.SUBJCODE_ID = ATTPROTOCOL.VALUECODE_ID AND UDF.FRM_INNCM=1 AND UDF.FRM_InProtocol = 1 
    INNER JOIN V_CODEPROPERTY VC (NOLOCK) ON VC.SUBJCODE_ID = ATT.VALUECODE_ID AND VC.VALUEBOOL = 1 AND VC.VALUECODE_ID = ATTPROTOCOL.VALUECODE_ID
  WHERE   
    ATT.[NAME]='FORMACC' AND 
    VC.PROPERTY =CAST(ATT.ID AS VARCHAR(50))  AND 
    ATT.ROLE_ID = @UserGroupDR   
        
  RETURN   
END   

