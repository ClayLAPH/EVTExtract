
CREATE   FUNCTION [dbo].[FN_LOC_InvestigationTypeUCSIDByEntityID] (@ID INT)  
 RETURNS VARCHAR(2048)  
AS
BEGIN  
 DECLARE @str VARCHAR(2048)  
 DECLARE @UCSID AS VARCHAR(100)
 DECLARE @COUNT AS INT  
 SET @COUNT=0  
   
 DECLARE ATT_cursor CURSOR FOR    
  SELECT DISTINCT [VDOMA].[domainOid] + '||' + [UCS].[conceptCode]  
  FROM  T_Attribute Att (NOLOCK)  
  INNER JOIN [V_UnifiedCodeSet] UCS (nolock) ON  UCS.[ID]=Att.[valueCode_ID] AND Att.[name] = 'LOC_InvestigationTypeDR' AND Att.[type] = 'bl' AND Att.ENTITY_ID=@ID  
INNER JOIN [V_DOMAIN] VDOMA (NOLOCK)  ON VDOMA.ID = UCS.DOMAIN_ID 
LEFT JOIN [V_TermDictionary] [LPA_T3] (nolock) ON  [UCS].[ID]=[LPA_T3].[termCode_ID]

 OPEN ATT_cursor  
  
 FETCH NEXT FROM ATT_cursor   
 INTO @UCSID  
  
  WHILE @@FETCH_STATUS = 0  
  BEGIN  
   IF @UCSID<>''  
   BEGIN  
    IF @COUNT = 0  
    BEGIN  
     SET @str = @UCSID  
     SET @COUNT = 1  
    END  
    ELSE  
    BEGIN  
     SET @str = @str + ',' + @UCSID  
    END  
   END  
   FETCH NEXT FROM ATT_cursor   
   INTO @UCSID  
  END  
 CLOSE ATT_cursor  
    DEALLOCATE ATT_cursor  
   
 RETURN @str  
END

