CREATE  FUNCTION [dbo].[FN_Get_ExprEvntDataQueryForCustomExport]
 (@TblExprSection SystemFormFields READONLY)
RETURNS NVARCHAR(max)
AS
BEGIN
    DECLARE @SQLExposureEvent NVARCHAR(max) = ''
    DECLARE @SQLExposureEventExportData NVARCHAR(max) = ''
    IF EXISTS (SELECT * FROM @TblExprSection WHERE LinkedSystemField_Form = 'EXPOSURE')
    BEGIN
        SET @SQLExposureEvent = ' SELECT TMP.Act_ID, EXPOSUREEVENT.ID as EXPOSUREEVENTID '
        IF EXISTS (SELECT * FROM @TblExprSection WHERE LinkedSystemField = 'DEE_ExposureDate')
        BEGIN
            SET @SQLExposureEvent = @SQLExposureEvent + ', Convert(Date, EXPOSUREEVENT.EffectiveTime_Beg) AS DEE_ExposureDate  ' 
            SET @SQLExposureEventExportData = @SQLExposureEventExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Exposure', 'DEE_ExposureDate', 'EXPOSUREEVENTID')
        END
        IF EXISTS (SELECT * FROM @TblExprSection WHERE LinkedSystemField = 'DEE_ExposureTimeBegin')
        BEGIN
            SET @SQLExposureEvent = @SQLExposureEvent + ', (CASE WHEN CONVERT(VARCHAR(8),EXPOSUREEVENT.EffectiveTime_Beg,108) = ''00:00:00'' THEN NULL 
            ELSE (SUBSTRING( CONVERT ( CHAR(26),EXPOSUREEVENT.EffectiveTime_Beg, 109), 13, 5 ) + '' '' + RIGHT(CONVERT(VARCHAR(30), CAST(EXPOSUREEVENT.EffectiveTime_Beg AS TIME), 9), 2)) END) AS DEE_ExposureTimeBegin  ' 
            SET @SQLExposureEventExportData = @SQLExposureEventExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Exposure', 'DEE_ExposureTimeBegin', 'EXPOSUREEVENTID')
        END
        IF EXISTS (SELECT * FROM @TblExprSection WHERE LinkedSystemField = 'DEE_ExposureEndDate')
        BEGIN
            SET @SQLExposureEvent = @SQLExposureEvent + ', Convert(Date, EXPOSUREEVENT.EffectiveTime_End) AS DEE_ExposureEndDate  ' 
            SET @SQLExposureEventExportData = @SQLExposureEventExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Exposure', 'DEE_ExposureEndDate', 'EXPOSUREEVENTID')
        END
        IF EXISTS (SELECT * FROM @TblExprSection WHERE LinkedSystemField = 'DEE_ExposureTimeEnd')
        BEGIN
            SET @SQLExposureEvent = @SQLExposureEvent + ', (CASE WHEN CONVERT(VARCHAR(8),EXPOSUREEVENT.EffectiveTime_End,108) = ''00:00:00'' THEN NULL 
            ELSE (SUBSTRING( CONVERT ( CHAR(26),EXPOSUREEVENT.EffectiveTime_End, 109), 13, 5 ) + '' '' + RIGHT(CONVERT(VARCHAR(30), CAST(EXPOSUREEVENT.EffectiveTime_End AS TIME), 9), 2)) END) AS DEE_ExposureTimeEnd  ' 
            SET @SQLExposureEventExportData = @SQLExposureEventExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Exposure', 'DEE_ExposureTimeEnd', 'EXPOSUREEVENTID')
        END
        IF EXISTS (SELECT * FROM @TblExprSection WHERE LinkedSystemField = 'DEE_ExposureTypeDR')
        BEGIN
            SET @SQLExposureEvent = @SQLExposureEvent + ', EXPOSUREEVENT.CODE_ID AS DEE_ExposureTypeDR  ' 
            SET @SQLExposureEventExportData = @SQLExposureEventExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Exposure', 'DEE_ExposureTypeDR', 'EXPOSUREEVENTID')
        END
        IF EXISTS (SELECT * FROM @TblExprSection WHERE LinkedSystemField = 'DEE_EXPOSURETYPE')
        BEGIN
            SET @SQLExposureEvent = @SQLExposureEvent + ', V_UNIFIEDCODESET.FULLNAME AS DEE_EXPOSURETYPE  ' 
            SET @SQLExposureEventExportData = @SQLExposureEventExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Exposure', 'DEE_EXPOSURETYPE', 'EXPOSUREEVENTID')
        END
        IF EXISTS (SELECT * FROM @TblExprSection WHERE LinkedSystemField = 'DEE_LOCATIONDR')
        BEGIN
            SET @SQLExposureEvent = @SQLExposureEvent + ', R_ROLE.SCOPER_ID AS DEE_LOCATIONDR  ' 
            SET @SQLExposureEventExportData = @SQLExposureEventExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Exposure', 'DEE_LOCATIONDR', 'EXPOSUREEVENTID')
        END
        IF EXISTS (SELECT * FROM @TblExprSection WHERE LinkedSystemField = 'DEE_LOCATION_NAME')
        BEGIN
            SET @SQLExposureEvent = @SQLExposureEvent + ', TNAME.TRIVIALNAME AS DEE_LOCATION_NAME  ' 
            SET @SQLExposureEventExportData = @SQLExposureEventExportData + dbo.[FN_Get_SystemSectionCustomExportData]('Exposure', 'DEE_LOCATION_NAME', 'EXPOSUREEVENTID')
        END
        SET @SQLExposureEvent = @SQLExposureEvent + ' INTO #TMPSystemTable     
        FROM #tmp_DI_UDVals_temp TMP 
        LEFT JOIN A_ACT EXPOSUREEVENT (NOLOCK) ON EXPOSUREEVENT.ACT_PARENT_ID = TMP.Act_ID AND EXPOSUREEVENT.METACODE = ''DEE_ROWID'' 
            and EXPOSUREEVENT.STATUSCODE = ''active'' 
        LEFT JOIN V_UNIFIEDCODESET (NOLOCK) ON EXPOSUREEVENT.CODE_ID = V_UNIFIEDCODESET.ID     
        LEFT JOIN P_PARTICIPATION (NOLOCK) ON EXPOSUREEVENT.ID = P_PARTICIPATION.ACT_ID     
        LEFT JOIN R_ROLE (NOLOCK) ON P_PARTICIPATION.ROLE_ID = R_ROLE.ID AND R_ROLE.CLASSCODE = ''LOCE''   
        LEFT JOIN E_PLACE PLACE (NOLOCK) ON R_ROLE.SCOPER_ID = PLACE.ID     
        LEFT JOIN T_ENTITYNAME TNAME (NOLOCK) ON TNAME.ENTITY_ID = PLACE.ID    '

        SET @SQLExposureEvent = @SQLExposureEvent + @SQLExposureEventExportData
    END
    RETURN @SQLExposureEvent
END
