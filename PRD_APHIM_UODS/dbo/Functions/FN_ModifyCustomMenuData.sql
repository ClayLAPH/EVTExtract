
Create Function [dbo].[FN_ModifyCustomMenuData] (@strCustomMenu nvarchar(max))
	RETURNS  nvarchar(max)
AS
BEGIN
	Set @strCustomMenu = replace(@strCustomMenu,'&','&amp;')
	Set @strCustomMenu = replace(@strCustomMenu,'>','&gt;')
	Set @strCustomMenu = replace(@strCustomMenu,'<','&lt;')
	return @strCustomMenu
end
