﻿CREATE FUNCTION FN_GETUCSTable 
(
    @VocabularyName varchar(250),
    @TermActive BIT=0
)
RETURNS 
@Table_Var TABLE 
(
    -- Add the column definitions for the TABLE variable here
    UCSID int 
    ,UCSFullName varchar(255)
    ,UCSConceptCode varchar(50)
    ,UCSShortName varchar(100)
    ,Unique nonclustered (ucsid)

)
AS
BEGIN
    IF @TermActive=0
    BEGIN
        INSERT INTO @TABLE_VAR 
        SELECT UCS.ID,UCS.FULLNAME, UCS.ConceptCode, UCS.ShortName
        FROM V_UNIFIEDCODESET (NOLOCK) UCS
        INNER JOIN V_DOMAIN (NOLOCK) VD ON VD.ID=UCS.DOMAIN_ID 
        INNER JOIN V_DICTIONARYDEFINITION (NOLOCK) ON V_DICTIONARYDEFINITION.DOMAIN_ID= VD.ID
        WHERE V_DICTIONARYDEFINITION.NAME=@VOCABULARYNAME
    END
    ELSE
    BEGIN
        INSERT INTO @TABLE_VAR 
        SELECT DISTINCT UCS.ID,UCS.FULLNAME, UCS.ConceptCode, UCS.ShortName
        FROM V_UNIFIEDCODESET (NOLOCK) UCS
        INNER JOIN V_DOMAIN (NOLOCK) VD ON VD.ID=UCS.DOMAIN_ID 
        INNER JOIN V_DICTIONARYDEFINITION (NOLOCK) ON V_DICTIONARYDEFINITION.DOMAIN_ID= VD.ID
        INNER JOIN V_TERMDICTIONARY (NOLOCK) ON V_TERMDICTIONARY.Termcode_ID=UCS.ID
        WHERE V_DICTIONARYDEFINITION.NAME=@VOCABULARYNAME AND V_TERMDICTIONARY.Active=1
    END

    RETURN 
END