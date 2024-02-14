

CREATE   FUNCTION [dbo].[FN_CMR_FieldFilterPARAM_TO_FieldFilterTable] (@FieldFilter NVARCHAR(MAX))  
RETURNS @RETURNVALUES TABLE (FRM_DefinitionID INT, SEC_DefinitionID INT, FLD_DefinitionID VARCHAR(100), FLD_Type VARCHAR(100), FieldFilterOperator VARCHAR(100), FLD_Value VARCHAR(MAX))
AS  
BEGIN   
    DECLARE @STARTPOSITION AS INT
    DECLARE @LASTPOSITION AS INT
    DECLARE @STARTPOSITIONINNER AS INT
    DECLARE @LASTPOSITIONINNER AS INT
    DECLARE @TempData as VARCHAR(MAX)
    DECLARE @TempDataINNER as VARCHAR(MAX)
    DECLARE @COUNTER INT

    DECLARE @FLD_Value VARCHAR(MAX)
    DECLARE @FRM_DefinitionID INT
    DECLARE @SEC_DefinitionID INT
    DECLARE @FLD_DefinitionID VARCHAR(100)
    DECLARE @FLD_Type VARCHAR(100)
    DECLARE @FieldFilterOperator VARCHAR(100)

    
    SET @STARTPOSITION=0
    SET @LASTPOSITION=0
    SET @STARTPOSITIONINNER=0
    SET @LASTPOSITIONINNER=0
    SET @TempData=''
    SET @TempDataINNER=''
    SET @COUNTER=0

    SET @FieldFilter =  @FieldFilter + CHAR(1)+CHAR(2)

    WHILE CHARINDEX(CHAR(1)+CHAR(2),@FieldFilter,@STARTPOSITION)<>0
    BEGIN
        SET @TempData=''
        SET @STARTPOSITIONINNER=0
        SET @LASTPOSITIONINNER=0
        SET @COUNTER=0
        SET @LASTPOSITION=CHARINDEX(CHAR(1)+CHAR(2),@FieldFilter,@STARTPOSITION)
        SET @TempData=SUBSTRING(@FieldFilter,@STARTPOSITION,@LASTPOSITION-@STARTPOSITION) + CHAR(1)+CHAR(1)
        SET @STARTPOSITION=@LASTPOSITION+2
        WHILE CHARINDEX(CHAR(1)+CHAR(1),@TempData,@STARTPOSITIONINNER)<>0
        BEGIN
            SET @TempDataINNER=''
            SET @LASTPOSITIONINNER=CHARINDEX(CHAR(1)+CHAR(1),@TempData,@STARTPOSITIONINNER)
            SET @TempDataINNER=SUBSTRING(@TempData,@STARTPOSITIONINNER,@LASTPOSITIONINNER-@STARTPOSITIONINNER)
            
            IF @TempDataINNER=''
            BEGIN
                SET @TempDataINNER = NULL
            END
            
            SET @STARTPOSITIONINNER=@LASTPOSITIONINNER+2
            
            IF @COUNTER = 0
                SET @FLD_Value = @TempDataINNER 
            ELSE IF @COUNTER=1
                SET @FRM_DefinitionID=@TempDataINNER
            ELSE IF @COUNTER=2
                SET @SEC_DefinitionID=@TempDataINNER
            ELSE IF @COUNTER=3
                SET @FLD_DefinitionID=@TempDataINNER
            ELSE IF @COUNTER=4
                SET @FLD_Type=@TempDataINNER
            ELSE IF @COUNTER=5
                SET @FieldFilterOperator=@TempDataINNER
            
            SET @COUNTER=@COUNTER+1
        END
        INSERT INTO @RETURNVALUES VALUES(@FRM_DefinitionID,@SEC_DefinitionID,@FLD_DefinitionID,@FLD_Type, @FieldFilterOperator, @FLD_Value)
    END
    RETURN
END
