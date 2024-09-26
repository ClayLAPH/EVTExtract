-- [dc].FN_122417_CMR_GetStagingPerson - Will be used to find the Stage Person RowID against the passed in Incident RowID as parameter		
Create Function [dc].FN_122417_CMR_GetStagingPerson(@PR_RowID int)
returns int
AS
BEGIN
		Declare @entity_id int
		IF NOT @PR_RowID IS NULL
		BEGIN
				SELECT 	@entity_id=ATTRNAMESPAE.Entity_ID FROM	T_AttributeRelationship ATTRREL (nolock) 
				INNER JOIN T_Attribute ATTRNAMESPAE (nolock)  on ATTRNAMESPAE.ID=ATTRREL.ATTRIBUTE_ID and ATTRNAMESPAE.NAME='NAMESPACE_PATIENT'
				WHERE ATTRREL.Act_ID=@PR_RowID
				RETURN @entity_id		
		END
		
		RETURN @entity_id
END			

