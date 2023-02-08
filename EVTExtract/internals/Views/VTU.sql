create view internals.VTU as
select 
	v.VIEW_CATALOG,
	v.VIEW_SCHEMA, 
	v.VIEW_NAME, 
	v.TABLE_CATALOG,
	v.TABLE_SCHEMA, 
	case 
		when v.TABLE_NAME like '%COMBINED' 
		then substring( v.TABLE_NAME, 1, len(v.TABLE_NAME)-9 )
		else v.TABLE_NAME 
	end 
	TABLE_NAME 
from 
	INFORMATION_SCHEMA.VIEW_TABLE_USAGE v
