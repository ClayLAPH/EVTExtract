CREATE PROCEDURE AtlasPublic.UnlockIncidentPendingPDFConversion
@LiveIncidentID as INT
AS
BEGIN
	DECLARE @LiveRecordID AS INT=NULL
	DECLARE @WebRecordID AS INT=NULL

	SELECT @LiveRecordID=DVPR_ROWID FROM DV_PHPERSONALRECORD(NOLOCK)
	INNER JOIN DV_PERSON(NOLOCK) ON DVPER_RowID=DVPR_PersonDR 
	WHERE DVPR_IncidentID=@LiveIncidentID AND DVPER_NamespaceCode_ID IS NULL
	IF @LiveRecordID IS NOT NULL
	BEGIN
		UPDATE T_Attribute SET valueBool=0
		WHERE name='PR_IsWebIncidentPDFConversionPending' AND [type]='BL' AND Act_ID=@LiveRecordID

		SELECT @WebRecordID=StageRecord_ID FROM [S_ProcessedPRRecord] (NOLOCK)
		INNER JOIN V_UNIFIEDCODESET (NOLOCK) ON V_UNIFIEDCODESET.ID=NamespaceCode_ID
		WHERE OriginalLiveRecord_ID=@LiveRecordID AND V_UNIFIEDCODESET.conceptCode='WEB'  
		
		IF @WebRecordID IS NOT NULL
		BEGIN
			UPDATE T_Attribute SET valueBool=0
			WHERE name='PR_IsWebIncidentPDFConversionPending' AND [type]='BL' AND Act_ID=@WebRecordID
		END

	END
END
