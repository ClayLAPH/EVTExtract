
CREATE FUNCTION [dbo].[FN_GetChildMenuXML] (@SubMenuID VARCHAR(50))
	RETURNS Nvarchar(max)
AS
BEGIN

--BLK_CreateTemporaryMenuTable
	DECLARE @tmpChildMenu  TABLE
	(
		[MenuXML] nvarchar(max),
		[Order] real
	)
--BLK_End

BEGIN --BLK_PopulateTempMenuTableWithMenuContentForInputSubMenuBasedMenuItems
	INSERT INTO @tmpChildMenu  
	select '<menuItem Category="CustomMenu" ID="' + cast(UDM.UDM_ID as nvarchar(max)) + '"><text>' + cast(UCS_Name.FullName as nvarchar(max)) + '</text><roles></roles><javascriptcommand>' +
case cast(UCS_Function.conceptCode as nvarchar(max)) 
		When 'NewWindow' THEN 'OpenUrlInNewWindow('''+[dbo].[FN_ModifyCustomMenuData](UDM.UDM_Url)+''');'
		When 'NewTab' THEN 'OpenUrlInNewTab('''+[dbo].[FN_ModifyCustomMenuData](UDM.UDM_Url)+''');'
		When 'WithinApplication' THEN 'OpenUrlInCurrentWindow('''+[dbo].[FN_ModifyCustomMenuData](UDM.UDM_Url)+''','''+UCS_Name.FullName+''');' 
		When 'CustomFunction' THEN [dbo].[FN_ModifyCustomMenuData](CAST(UDM.UDM_JavaScript AS nvarchar(max)))
	END + '</javascriptcommand> </menuItem>', TermDictMenu.termorder	
	from VCP_UserDefinedMenu (nolock) UDM 
	inner join v_unifiedcodeset (nolock) UCS_Name on UCS_Name.ID=UDM.subjcode_id
	inner join v_termDictionary (nolock) TermDictMenu on UCS_Name.ID=TermDictMenu.termcode_ID and TermDictMenu.Name = 'UDMenu' and TermDictMenu.active = '1'
	inner join v_unifiedcodeset (nolock) UCS_Function on UCS_Function.ID=UDM.UDM_FunctionDR
	inner join V_TermDictionary (nolock)  TermDictSubMenu on TermDictSubMenu.termCode_ID=UDM.UDM_SubMenuDR and TermDictSubMenu.active = '1'
	where (UDM.UDM_SubMenuDR > 0 or UDM.UDM_SubMenuDR is NOT NULL) and UDM.UDM_SubMenuDR=@SubMenuID
END --BLK_End
	
BEGIN --BLK_ReadTempMenuTableContentIntoAVariable
	declare @xmlcontent as nvarchar(max)
	Set @xmlcontent=''
	select @xmlcontent=@xmlcontent + MenuXML from @tmpChildMenu order by [Order] asc
END --BLK_End

BEGIN --BLK_ReturnThePreparedXML
	Return @xmlcontent 
END --BLK_End	

END
