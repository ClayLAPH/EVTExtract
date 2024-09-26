
CREATE   FUNCTION [covid].[GetCOVIDDifferentialDataByTable](
	@KeyName VARCHAR(50)
)
RETURNS @TBL TABLE  
(  
	 RecordID	INT
	 , DiseaseCodeID	INT
	 , IsDeleted	BIT
) 
AS
BEGIN
	DECLARE @AuditID INT

	SELECT @AuditID = [value] FROM SYS_GlobalStatus (NOLOCK)
	where [Key] = 'COVIDSync'+@KeyName and [Type] = 'COVIDSync'

	IF @AuditID IS NULL
	 SELECT @AuditID = MAX(ID) FROM S_AuditMain (NOLOCK)

	DECLARE @TMPAudit TABLE (
		[ID] [int] NOT NULL,
		[RecordID] [varchar](200) NULL,
		[FormName] [varchar](50) NULL,
		[TableName] [varchar](300) NULL,
		[InstanceID] [varchar](100) NULL,
		[sqlAction] [varchar](50) NULL,
		[ActionDate] [datetime] NULL,
		[Notes] [varchar](max) NULL,
		[UserIP] [varchar](50) NULL,
		[reasonCode_ID] [int] NULL,
		[entityID] [int] NULL,
		[USERID] [int] NULL
	 )

	INSERT INTO @TMPAudit
	SELECT * FROM S_AuditMain (NOLOCK)
	WHERE ID>@AuditID AND sqlAction in 
	('Insert', 'Import', 'ReversedImport', 'BatchUpload', 'ImportUtility', 'Merge', 'Update', 'Delete', 'Undelete', 'Unmerge')
	AND FormName = 'Incident'
	
	IF EXISTS (SELECT TOP 1 1 FROM @TMPAudit)
	BEGIN
		INSERT INTO @TBL
		SELECT DISTINCT DVPR_RowID, DVPR_DiseaseCode_ID, 0 FROM DV_PHPersonalRecord DV (NOLOCK)
		INNER JOIN @TMPAudit T ON T.RecordID = DV.DVPR_RowID
		WHERE DV.DVPR_DiseaseCode_ID IN (544041, 543030)
		-- MAKE SURE THE IDs - 509715, 509841 are changed to COVID and SARS2 ID

		INSERT INTO @TBL
		SELECT DISTINCT DVPR_RowID, DVPR_DiseaseCode_ID, 1 FROM DV_PHDeletedPersonalRecord DV (NOLOCK)
		INNER JOIN @TMPAudit T ON T.RecordID = DV.DVPR_RowID
		WHERE DV.DVPR_DiseaseCode_ID IN (544041, 543030)
	END 	

	RETURN
END

