
/****** Object:  UserDefinedFunction [Sync].[fn_GetUDFSectionSPNameToExecuteInSSIS]    Script Date: 2/26/2016 5:56:00 PM ******/
CREATE Function [Sync].[fn_GetUDFSectionSPNameToExecuteInSSIS] (@SectionDR INT,@IsSAP  BIT,@IsSAR  BIT )
RETURNS NVARCHAR (500)
AS
BEGIN

    DECLARE @StoredProcedureName as NVARCHAR(500)

    SET @StoredProcedureName = 'UDFExport_'

    IF @IsSAR = 1 
        BEGIN
            SET @StoredProcedureName += 'SAR_' + CAST (@SectionDR as NVARCHAR(500))
        END
    ELSE IF @IsSAP = 1  
        BEGIN
            SET @StoredProcedureName += 'SAP_' + CAST (@SectionDR as NVARCHAR(500))
        END
    ELSE IF (Select SEC_ID FROM VCP_UDSection (nolock)  Where SubjCode_ID =@SectionDR) IN ('-8','-10','-11','-12')
        BEGIN
            SET @StoredProcedureName += 'System_' + CAST (@SectionDR as NVARCHAR(500))
        END 
    ELSE 
        BEGIN
            SET @StoredProcedureName += 'Normal' + '_' + IsNull(CAST (@SectionDR as NVARCHAR(500)),'')
        END
    Return @StoredProcedureName
END
