
CREATE FUNCTION [dbo].[FN_Get_DynamicQuery_SDFLData]
 (@FORMDEF_ID INT, @RECORDTYPE AS VARCHAR(20))
RETURNS Nvarchar(max)
AS

BEGIN
    DECLARE @TblSystemDefinedFieldLinks SystemFormFields
    INSERT INTO @TblSystemDefinedFieldLinks (LinkedSystemField, LinkedSystemField_Form)
    SELECT DISTINCT SUBSTRING( [LPA_U5].[FIELD_LinkedSystemField], CHARINDEX ('^', [LPA_U5].[FIELD_LinkedSystemField]) + 1, LEN([LPA_U5].[FIELD_LinkedSystemField])),
         (CASE WHEN  [LPA_U5].[FIELD_LinkedSystemField] like 'DiPat%' THEN 'DiPat' 
                        WHEN [LPA_U5].[FIELD_LinkedSystemField] like 'DiCase%' THEN 'DiCase' 
                        WHEN [LPA_U5].[FIELD_LinkedSystemField] like 'DiRVCT%' THEN 'DiRVCT' END) AS [FIELD_LinkedSystemField]
    FROM
        [V_UnifiedCodeSet] [LPA_U1] (nolock) 
        INNER JOIN [V_CodeProperty] [LPA_V2] (NOLOCK) ON  [LPA_U1].[ID]=[LPA_V2].[valueCode_ID] AND [LPA_V2].[property] = 'UD_FormSections'
        INNER JOIN [V_CodeProperty] [LPA_V3] (nolock) ON  [LPA_U1].[ID]=[LPA_V3].[subjCode_ID] AND [LPA_V3].[property] = 'UD_SectionFields' 
        INNER JOIN [VCP_UDField] [LPA_U5] (nolock) ON  [LPA_V3].[valueCode_ID]=[LPA_U5].[SubjCode_ID]
    WHERE ( 
        [LPA_V2].[subjCode_ID] = @FORMDEF_ID
        AND [LPA_V2].[property] = 'UD_FormSections'
        AND ISNULL([LPA_U5].[FIELD_LinkedSystemField],'') <> '') 

    DECLARE @SqlSysDefinedField AS nvarchar(max)

    SET @SqlSysDefinedField = [dbo].[FN_Get_DynamicQuery_ForSystemFormFields](@TblSystemDefinedFieldLinks, @RECORDTYPE,'')
    SET @SqlSysDefinedField = @SqlSysDefinedField + ' SELECT * FROM #TMP_DiPAT; SELECT * FROM #TMP_DiPATRace; SELECT * FROM #TMP_DiCase; SELECT * FROM #TMP_DiRVCT; '   
    RETURN @SqlSysDefinedField
END

