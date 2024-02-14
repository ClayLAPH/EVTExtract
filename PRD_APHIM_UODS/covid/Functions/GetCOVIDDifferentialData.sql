
CREATE   FUNCTION [covid].[GetCOVIDDifferentialData]()
RETURNS @TBL TABLE  
(  
	 RecordID	INT
	 , IsDeleted	BIT
) 
AS
BEGIN
	DECLARE @AuditID INT

	SELECT @AuditID = [value] FROM SYS_GlobalStatus (NOLOCK)
	where [Key] = 'COVIDSync' and [Type] = 'COVIDSync'

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
		SELECT DISTINCT DVPR_RowID, 0 FROM DV_PHPersonalRecord DV (NOLOCK)
		INNER JOIN @TMPAudit T ON T.RecordID = DV.DVPR_RowID
		WHERE DV.DVPR_DiseaseCode_ID IN (544041)
		-- MAKE SURE THE IDs - 509715, 509841 are changed to COVID and SARS2 ID
	END 	

	DECLARE @TMPAuditDelete TABLE (
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

	INSERT INTO @TMPAuditDelete
	SELECT * FROM S_AuditMain (NOLOCK)
	WHERE ID>@AuditID AND sqlAction in 
	('Delete', 'Merge')
	AND FormName = 'Incident'
	AND TableName = 'PH_PersonalRecord'

	IF EXISTS (SELECT TOP 1 1 FROM @TMPAuditDelete)
	BEGIN
		INSERT INTO @TBL
		SELECT DISTINCT DVPR_RowID, 1 FROM DV_PHDeletedPersonalRecord DV (NOLOCK)
		INNER JOIN @TMPAuditDelete T ON T.RecordID = DV.DVPR_RowID
		WHERE DV.DVPR_DiseaseCode_ID IN (544041)
	END 	

	RETURN
END

