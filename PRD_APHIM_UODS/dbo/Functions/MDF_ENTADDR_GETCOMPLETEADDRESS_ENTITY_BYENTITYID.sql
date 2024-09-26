CREATE FUNCTION [dbo].[MDF_ENTADDR_GETCOMPLETEADDRESS_ENTITY_BYENTITYID]
(@EntityID INT, @MetaCode VARCHAR(100))
RETURNS VARCHAR(100)
AS
BEGIN

RETURN
       (
       SELECT      
            (CASE WHEN cast(isnull(EAP.[partSal],'') as varchar(400)) = '' THEN '' ELSE cast(EAP.[partSal] as varchar(400)) END + 
                CASE WHEN ISNULL(EAP.[partAptNum],'') = '' THEN '' ELSE 
                CASE WHEN ISNULL(EAP.[partSal],'') <> '' THEN ', ' + char(13) + EAP.[partAptNum] ELSE  EAP.[partAptNum] END END +  
                CASE WHEN ISNULL(EAP.[partCty],'') = '' THEN '' ELSE 
                CASE WHEN ISNULL(EAP.[partSal],'') <> '' OR ISNULL(EAP.[partAptNum],'') <> '' THEN ', '  + char(13) + EAP.[partCty] ELSE  EAP.[partCty] END END +
                CASE WHEN ISNULL(EAP.[partSta],'') = '' THEN '' ELSE 
                CASE WHEN ISNULL(EAP.[partSal],'') <> '' OR ISNULL(EAP.[partAptNum],'') <> '' OR ISNULL(EAP.[partCty],'') <> '' THEN ', ' + char(13) + EAP.[partSta] ELSE  EAP.[partSta] END END +  
                CASE WHEN ISNULL(EAP.[partZip],'') = '' THEN '' ELSE 
                CASE WHEN (ISNULL(EAP.[partSal],'') <> '' OR ISNULL(EAP.[partAptNum],'') <> '' OR ISNULL(EAP.[partCty],'') <> '' OR ISNULL(EAP.[partSta],'') <> '') THEN ', '  + char(13) + EAP.[partZip] ELSE  EAP.[partZip] END END) 
        FROM  dbo.E_Entity E (NOLOCK) 
        INNER JOIN dbo.T_ENTITYADDRESS EAP (NOLOCK) ON E.ID=ENTITY_ID AND E.metaCode=@MetaCode AND E.STATUSCODE<>'NULLIFIED'
        WHERE E.ID = @EntityID
        )
END
