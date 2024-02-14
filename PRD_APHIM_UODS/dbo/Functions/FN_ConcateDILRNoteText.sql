
CREATE FUNCTION [dbo].[FN_ConcateDILRNoteText]  (@PR_RowID AS INT)
	RETURNS NVARCHAR(MAX)
AS
BEGIN 
	IF @PR_RowID IS NULL 
	BEGIN 
		RETURN NULL 
	END 
	

      DECLARE @ReturnText AS NVARCHAR(MAX)
      SELECT @ReturnText = Case when ISNULL(@ReturnText+',', '')<>',' then ISNULL(@ReturnText+',', '') else '' end + cast(ISNULL([DILR_Notes],'') as NVARCHAR(MAX))
        FROM AX_LabReport (nolock) 
       INNER JOIN A_Act (nolock) ON A_Act.ID=AX_LabReport.DILR_ID AND Act_Parent_ID=@PR_RowID 
	RETURN @ReturnText 
END
