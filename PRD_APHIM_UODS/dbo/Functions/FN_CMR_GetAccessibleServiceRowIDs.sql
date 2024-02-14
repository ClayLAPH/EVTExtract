
CREATE  FUNCTION [dbo].[FN_CMR_GetAccessibleServiceRowIDs](@UserGroupDR INT,@UserDistrictGroupDR  int, @PersonID  VARCHAR(MAX), @UserID int)
RETURNS @SVCIDTABLE TABLE  
( SVCID Int )  
AS  
BEGIN 
	INSERT INTO 
		@SVCIDTABLE  
	SELECT 
		AX.SVC_ID AS SVCID 
	FROM 
		AX_Services AX (NOLOCK)
		LEFT JOIN [V_CODEPROPERTY] VC (NOLOCK) ON  AX.[SVC_JURISDICTIONCODE_ID]=VC.[VALUECODE_ID] 
		AND VC.[PROPERTY] = 'GRPD_DistrictDR' AND VC.[SUBJCODE_ID] = @UserDistrictGroupDR
	WHERE 
		AX.SVC_PersonDR IN(SELECT Value FROM  dbo.[ParmsToList](@PersonID))
		AND AX.SVC_CurrentServiceDR IN (SELECT * FROM DBO.FN_CMR_GetAccessibleServiceCategoriesByUserGroupDR(@USERGROUPDR)) 
		AND (AX.SVC_UserDR = @UserID OR @UserDistrictGroupDR < 0 OR VC.ID IS NOT NULL)	
	
	RETURN 
END 


