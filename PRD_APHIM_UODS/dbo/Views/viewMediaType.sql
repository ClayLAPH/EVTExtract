CREATE VIEW [dbo].[viewMediaType]
AS
SELECT MEDIATYPE.ID FROM V_UNIFIEDCODESET MEDIATYPE (NOLOCK)
	INNER JOIN V_DOMAIN (NOLOCK) ON V_DOMAIN.ID = MEDIATYPE.DOMAIN_ID AND DOMAINOID = '2.16.840.1.113883.5.79' AND DOMAINNAME = 'MEDIATYPE'
	WHERE CONCEPTCODE IN ('image/x-ms-bmp', 'image/bmp','image/png','image/g3fax','image/pjpeg', 'image/gif', 'image/x-icon', 'image/jpeg', 'image/x-png', 'image/tiff')

