create procedure dbo.GetAvailableAssets as 
begin

  set nocount on;

  declare @available table ( name sysname, available datetime null )
  insert @available ( name ) select view_name from dbo.QueryViewReadiness;



  return 0;

end
