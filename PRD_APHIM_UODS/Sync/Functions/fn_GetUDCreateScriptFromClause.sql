
CREATE FUNCTION [Sync].[fn_GetUDCreateScriptFromClause](@IsSAP Bit, @IsSAR Bit, @IsContactUDSection Bit)
    RETURNS varchar(1000)
AS
BEGIN
    DECLARE @SQL VARCHAR(1000)
    SET @SQL = ' 
        From UD_Values UDV (NOLOCK) 
        INNER JOIN UD_SectionInstance UDS (NOLOCK) ON UDS.SEC_InstanceID = UDV.SEC_InstanceID'
    IF @IsSAR = 1 
    BEGIN
        SET @SQL = @SQL + ' 
        INNER JOIN UDFExportSession UDSESSION (NOLOCK) ON UDSESSION.DIID = UDS.SEC_ActPointerID '
    END
    ELSE IF @IsSAP = 1 
    BEGIN
        SET @SQL = @SQL + ' 
        INNER JOIN UDFExportSession UDSESSION (NOLOCK) ON UDSESSION.PatientFolderID = UDS.SEC_ActPointerID '
    END
    ELSE IF @IsContactUDSection = 1 
    BEGIN
        SET @SQL = @SQL + ' 
        INNER JOIN UDF_ContactSectionData UDC (NOLOCK) ON UDC.FolderID = UDS.SEC_ActPointerID
        INNER JOIN UDFExportSession UDSESSION (NOLOCK) ON UDSESSION.DIID = UDC.RecordID '
    END
    ELSE
    BEGIN
        SET @SQL = @SQL + ' 
        INNER JOIN UDFExportSession UDSESSION (NOLOCK) ON UDSESSION.FormInstanceID = UDS.SEC_ActPointerID '
    END
    SET @SQL = @SQL + '
        WHERE UDS.SEC_DefinitionID = @SectionDR  AND UDSESSION.SessionID=@SessionID'
    RETURN @SQL
END
