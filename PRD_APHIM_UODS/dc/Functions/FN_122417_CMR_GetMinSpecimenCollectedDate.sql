-- [dc].FN_122417_CMR_GetMinSpecimenCollectedDate - Will be used to calculate the minimum specimen collected date
CREATE Function [dc].FN_122417_CMR_GetMinSpecimenCollectedDate(@pr_rowid int)
RETURNS DATETIME
AS

BEGIN
		DECLARE @SpecimenCollectedDate datetime
		
		SELECT @SpecimenCollectedDate=min(Ax_LabReport.DILR_SpecCollectedDate) FROM A_Act DILRACT (nolock)
		INNER JOIN Ax_LabReport  (nolock) ON Ax_LabReport.DILR_ID=DILRACT.ID
		WHERE DILRACT.metaCode='DILR_ID' AND DILRACT.statusCode='ACTIVE' AND DILRACT.Act_Parent_ID=@pr_rowid
		
		return @SpecimenCollectedDate
END

