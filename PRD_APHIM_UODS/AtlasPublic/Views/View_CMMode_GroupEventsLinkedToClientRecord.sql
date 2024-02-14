
CREATE VIEW [AtlasPublic].[View_CMMode_GroupEventsLinkedToClientRecord]  
AS
SELECT 
DVPR.DVPER_RowID As GE_PER_RowID,
DVPR.DVPER_NCMID As GE_PER_ClientID,
GE.ID As GE_RowID,
GE.InstanceID As GE_InstanceID,
GE.EventNumber As GE_EventNumber,
ACT.code_ID As GE_TypeDR,
UCSTYPE.FULLNAME As GE_Type,
GE.DateOfEvent As GE_DateOfEvent,
GE.StatusDR As GE_StatusDR,
UCSSTATUS.fullName As GE_Status,
DVPR.DVPER_LastName AS GE_PER_LastName,
DVPR.DVPER_FirstName AS GE_PER_FirstName,
GE.DistrictDR AS GE_JurisdictionDR,
UCSJURI.fullName AS GE_Jurisdiction

FROM Ax_GroupEvent GE (nolock)
INNER JOIN A_Act ACT  (nolock) ON ACT.ID=GE.ID AND ACT.metacode='GE_RowID' and ACT.statusCode NOT IN ('terminated','nullified')
INNER JOIN S_Link LINK  (nolock) ON ACT.ID=LINK.Act1_ID AND LINK.name='GE_ClientRecordDR' 
INNER JOIN E_Entity ENT  (nolock) ON LINK.Entity1_ID=ENT.ID
INNER JOIN DV_Person DVPR  (nolock) ON DVPR.DVPER_RowID=ENT.ID
INNER JOIN V_UnifiedCodeSet UCSTYPE  (nolock) ON ACT.code_ID=UCSTYPE.ID
LEFT JOIN V_UnifiedCodeSet UCSSTATUS  (nolock) ON GE.StatusDR=UCSSTATUS.ID
LEFT JOIN V_UnifiedCodeSet UCSJURI (nolock) ON GE.DistrictDR=UCSJURI.ID
