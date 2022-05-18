create function internals.EntityName( @FIELDDEFID int, @ENTITYID INT )  
returns table as return
(

--IF @LINKTYPE IN ('PERSON','LOCATION','REPORT SOURCE')
--SET @ENTITYID = [dbo].[UDF_GetEntityRoot](@ENTITYID)


  select
    Name = 
      case udfName.shortName
        when 'PERSON'         then ISNULL(PARTFAM,'') + ' ,' + ISNULL(PARTGIV,'')
        when 'LOCATION'       then ISNULL(TRIVIALNAME,'')
        when 'REPORT SOURCE'  then ISNULL(TRIVIALNAME,'')
        when 'LABORATORY'     then ISNULL(TRIVIALNAME,'')
        when 'SYSTEM USER'    then ISNULL(PARTFAM,'') + ' , ' + ISNULL(PARTGIV,'')
        when 'INVESTIGATOR'   then ISNULL(PARTFAM,'') + ' , ' + ISNULL(PARTGIV,'')
        when 'CASE MANAGER'   then ISNULL(PARTFAM,'') + ' , ' + ISNULL(PARTGIV,'') + ' ||' + CAST( @ENTITYID AS VARCHAR(10))
      end
  from 
    [$(PRD_APHIM_UODS)].dbo.T_ENTITYNAME en with (nolock)
    cross join
    ( select SHORTNAME 
      from [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET ucs with (nolock)
      where ID = @FIELDDEFID
    ) udfName
  where
    Entity_ID = @ENTITYID
)