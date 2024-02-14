
CREATE Function [Sync].[fn_GetSectionFieldsForSSIS] (@SectionDR INT,@FullList  BIT,@OnlyCheckboxList  BIT,@IncludeSDFL  BIT )
RETURNS VARCHAR (max)
AS
BEGIN
    DECLARE @Fields AS VARCHAR (max)
    Set @Fields = ''
    DECLARE @listStr AS VARCHAR (MAX)
    DECLARE @FieldTypeSystemDefined AS INT 
    DECLARE @FieldTypeDate AS INT
    SELECT @FieldTypeSystemDefined = V_UnifiedCodeSet.ID   
                        FROM V_UnifiedCodeSet (nolock)
                        Inner join V_Domain (nolock) on V_Domain .ID= V_UnifiedCodeSet.domain_ID 
                        Where FullName ='System Defined Field Link'  AND V_Domain .domainName ='UDFieldTypes' 
    SELECT @FieldTypeDate = V_UnifiedCodeSet.ID   
                        FROM V_UnifiedCodeSet (nolock)
                        Inner join V_Domain (nolock) on V_Domain .ID= V_UnifiedCodeSet.domain_ID 
                        Where FullName ='Date'  AND V_Domain .domainName ='UDFieldTypes' 

    Declare @FetchFieldTypes Table (FieldTypeDR Int)
    IF @FullList = 0  
        BEGIN
                Declare @ColumnOpenBracket as Varchar(1), @ColumnCloseBracket as Varchar(1)
                Set @ColumnOpenBracket = ''
                Set @ColumnCloseBracket = ''

                IF @OnlyCheckboxList = 1        
                BEGIN
                    Insert Into @FetchFieldTypes
                    SELECT V_UnifiedCodeSet.ID
                        FROM V_UnifiedCodeSet (nolock)
                        Inner join V_Domain (nolock) on V_Domain .ID= V_UnifiedCodeSet.domain_ID 
                        Where FullName ='CheckBoxList'  AND V_Domain .domainName ='UDFieldTypes' 
                END
                
                IF @OnlyCheckboxList = 0  
                BEGIN
                    Set @ColumnOpenBracket = '['
                    Set @ColumnCloseBracket = ']'

                    IF @IncludeSDFL=1
                    BEGIN
                        Insert Into @FetchFieldTypes
                        SELECT  V_UnifiedCodeSet.ID
                            FROM V_UnifiedCodeSet (nolock)
                            Inner join V_Domain (nolock)on V_Domain .ID= V_UnifiedCodeSet .domain_ID 
                            Where FullName Not In ('Caption', 'Instructions', 'Spacer', 'Command')  
                            and V_Domain .domainName ='UDFieldTypes'
                    END
                    ELSE
                    BEGIN
                        Insert Into @FetchFieldTypes
                        SELECT  V_UnifiedCodeSet.ID
                            FROM V_UnifiedCodeSet (nolock)
                            Inner join V_Domain (nolock)on V_Domain .ID= V_UnifiedCodeSet .domain_ID 
                            Where FullName Not In ('Caption', 'Instructions', 'Spacer','System Defined Field Link', 'Command')  
                            and V_Domain .domainName ='UDFieldTypes'
                    END
                END

                select @Fields = 
                      @Fields + ','  + @ColumnOpenBracket + Cast(VCP_UDField.SubjCode_ID AS Varchar(20) ) + @ColumnCloseBracket
                    from V_CodeProperty (NOLOCK)
                    Inner Join VCP_UDField  (NOLOCK) On V_CodeProperty.valueCode_ID = VCP_UDField.SubjCode_ID
                    Inner Join V_UnifiedCodeSet VUCS (NOLOCK) On VUCS.ID = FIELD_TypeCode_ID
                    Where V_CodeProperty.SubjCode_ID = @SectionDR 
                    AND FIELD_TypeCode_ID IN (SELECT * FROM @FetchFieldTypes) 
        END
    
    IF @FullList = 1        
        BEGIN
            Insert Into @FetchFieldTypes
            SELECT  COALESCE(@listStr+',' , '') + Cast(V_UnifiedCodeSet.ID AS Varchar )FROM V_UnifiedCodeSet  (nolock)
                    Inner join V_Domain (nolock)on V_Domain .ID= V_UnifiedCodeSet .domain_ID 
                    Where FullName In ('Caption', 'Instructions', 'Spacer','Command')    
                    and V_Domain .domainName ='UDFieldTypes'        

            DECLARE @PHDATETIMEFORMAT AS VARCHAR (12)
            DECLARE @DateStandard AS VARCHAR (4)
            SELECT  @PHDATETIMEFORMAT = CAST(CONF_VAL.Value AS VARCHAR(MAX)) 
                FROM S_ConfigDefinition CONF_DEF (NOLOCK)  
                INNER JOIN S_ConfigValue CONF_VAL (NOLOCK) ON CONF_DEF.ID = CONF_VAL.configDefinition_ID  
                WHERE CONF_DEF.[Key]='PHDateFieldFormat'  
                
            IF @PHDATETIMEFORMAT = 'dd/mm/yyyy'
                BEGIN
                    SET @DateStandard = 103
                END
            ELSE IF @PHDATETIMEFORMAT = 'mm/dd/yyyy'
                BEGIN
                    SET @DateStandard = 101
                END
            
            Select @Fields = @Fields +  ',' +
                    CASE 
                        --SDFL FIELDS
                        WHEN ( FIELD_TypeCode_ID = @FieldTypeSystemDefined) AND @IncludeSDFL=0 THEN 'cast(View_UDF_SDFL_' + IsNull((REPLACE(Field_LinkedSystemField, '^', '.')) + ' as nvarchar(max))','') 
                        --DATETIME FIELDS
                        WHEN (FIELD_TypeCode_ID = @FieldTypeDate) THEN 'CONVERT(NVARCHAR(12),[' + IsNull(CAST(VCP_Field.SubjCode_ID AS VARCHAR),'') + '],'+ @DateStandard +')' 
                        ELSE 
                        --NORMAL FIELDS
                            '[' + 
                                CASE 
                                    WHEN VCP_Field.FIELD_ID Is Not Null  THEN CAST(VCP_Field.SubjCode_ID AS VARCHAR(20))
                                    ELSE '' 
                                END 
                            + ']'                               
                    END 
            
                +    ' as [' + IsNull(CAST(VCP_Field.FIELD_ID AS VARCHAR(50)),'')  + ']'    
            FROM V_CodeProperty VCPSECTION(NOLOCK) 
                Inner Join VCP_UDField VCP_Field (NOLOCK) On VCPSECTION.valueCode_ID = VCP_Field.SubjCode_ID
                Where VCPSECTION.SubjCode_ID = @SectionDR 
                And FIELD_TypeCode_ID Not IN  (SELECT * FROM @FetchFieldTypes)
                ORDER BY VCPSECTION.sortOrder ASC
        END

        SET @Fields = CASE WHEN @Fields LIKE ',%'  THEN RIGHT(@Fields, LEN(@Fields)-1) ELSE @Fields END
        Return @Fields 
END

