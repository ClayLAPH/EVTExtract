
CREATE  FUNCTION [dbo].[FN_GetIncidentReportSourceDR](@IncidentID INT)
RETURNS @ReportSourceDRTBL TABLE  
( 
	IsELRRecord Bit,
	ReportSourceDR INT
)
AS  
BEGIN	--BLK_FetchReportSource

	DECLARE @ReportSourceDR AS INT
	DECLARE @IsELRRecord AS BIT
	SET @IsELRRecord = 0

	DECLARE @UCS_ELR_ID AS INT
	SELECT @UCS_ELR_ID=UCS.ID FROM V_UNIFIEDCODESET UCS (nolock) INNER JOIN V_DOMAIN VD (nolock) ON UCS.Domain_ID=VD.ID AND VD.DomainName='NameSpace' WHERE UCS.CONCEPTCODE='ELR' 

	IF ((SELECT DVPER_NamespaceCode_ID FROM DV_Person (nolock) INNER JOIN DV_PHPersonalRecord (nolock) ON DVPER_RowID = DVPR_PersonDR WHERE DVPR_RowID = @IncidentID) = @UCS_ELR_ID)
	BEGIN
		SET @IsELRRecord = 1
		SELECT @ReportSourceDR = R_LAB.player_ID
		FROM 
			A_Act A_DILR (nolock) 
			INNER JOIN Ax_LabReport (nolock) ON Ax_LabReport.DILR_ID=A_DILR.ID AND Ax_LabReport.DILR_IsFromHL7=1
			INNER JOIN R_Role R_LAB (nolock) ON Ax_LabReport.DILR_LaboratoryDR=R_LAB.scoper_ID AND R_LAB.metaCode='LIPL_ReportingSourceDRText'
		WHERE A_DILR.Act_Parent_ID=@IncidentID AND A_DILR.metaCode='DILR_ID'
	END	
	ELSE
	BEGIN
		SELECT @ReportSourceDR = DVPR_ReportSourceDR FROM DV_PHPersonalRecord(nolock) WHERE DVPR_RowID = @IncidentID
	END
	
	INSERT @ReportSourceDRTBL SELECT @IsELRRecord, @ReportSourceDR
	
	RETURN
END

