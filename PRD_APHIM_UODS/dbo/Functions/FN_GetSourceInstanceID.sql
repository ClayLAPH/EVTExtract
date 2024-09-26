CREATE FUNCTION [dbo].[FN_GetSourceInstanceID] (@PatientEntityID AS INT)
	RETURNS INT
AS
BEGIN
	DECLARE @SourceIncidentID INT
	
	SELECT @SourceIncidentID = DVPR_IncidentId 
	FROM [DV_PHPersonalRecord] DVPH (NOLOCK)
	INNER JOIN S_Link SL (NOLOCK) ON SL.Act1_Id=DVPH.DVPR_RowID AND SL.[Name]='Patient-Case'
	WHERE SL.Entity1_ID=@PatientEntityID

	RETURN 	@SourceIncidentID
END
