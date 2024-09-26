
CREATE FUNCTION [dbo].[FN_EHR_CanAutoImport]
(
	@RecordID AS INT
)
RETURNS BIT
BEGIN
	DECLARE @CanAutoImport as Bit = 0
	DECLARE @RS_AutoImport BIT, @DIS_AutoImport BIT, @RS_RowID INT, @DiseaseDR INT	

	SELECT @DiseaseDR = DVPR_DiseaseCode_ID, @RS_RowID = DVPR_ReportSourceDR
	FROM DV_PHPersonalRecord (NOLOCK) where DVPR_RowID = @RecordID

	SELECT @RS_AutoImport = valueBool FROM T_Attribute (NOLOCK) where name = 'RS_AutoImport' and [Entity_ID] = @RS_RowID
	SELECT @DIS_AutoImport = IsAutoInserted FROM VCP_Disease (NOLOCK) where SubjCode_ID = @DiseaseDR

	IF @RS_AutoImport = 1 AND @DIS_AutoImport = 1
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM E_Entity E (NOLOCK) 
			INNER JOIN V_CodeProperty VC (NOLOCK) ON VC.Entity_ID = E.ID
			LEFT JOIN T_Attribute TA (NOLOCK) ON TA.Entity_ID = E.ID and TA.name = 'DNID_InActive'
			where E.ID = @RS_RowID and subjCode_ID = @DiseaseDR and property = 'DNID_DiseaseDR' AND ISNULL(TA.valueBool,0) = 0)
		SET @CanAutoImport = 1
	END	
	RETURN @CanAutoImport
END

