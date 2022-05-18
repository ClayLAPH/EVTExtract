create function internals.GetUdfFieldValue
(
  @valueDate datetime ,
  @valueString varchar(MAX),
  @entityId int,
  @ucsId int,
  @fieldDefId int
)
returns table as return
(
select
  case
    when @ucsId is not null then
    ( select top 1 
        case
          when count(ucs.fullName) > 1 or max(isnull(td.termDisplay,'')) = '' 
          then ucs.fullName
          else td.termDisplay 
        end    
      from 
        [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET ucs with (nolock) 
        left outer join
        [$(PRD_APHIM_UODS)].dbo.V_TERMDICTIONARY td with (nolock) 
        on
          ucs.ID=td.TERMCODE_ID 
      where 
        ucs.ID=@ucsId
      group by 
        ucs.FULLNAME,td.NAME,td.TERMDISPLAY
    )
    when @entityId != -1 then
    ( select
        case 
          when linkType.shortName in ('LOCATION','REPORT SOURCE','LABORATORY') then 
          ( select isnull(en.trivialName,'') + '||' + CAST(mei.MappedEntityId AS varchar(25)) 
            from 
              internals.MapEntityId( @entityId ) mei  
              inner join
              [$(PRD_APHIM_UODS)].dbo.T_EntityName en with (nolock)
              on
                mei.MappedEntityId = en.Entity_ID )
          when linkType.shortName in ('PERSON','SYSTEM USER','INVESTIGATOR','CASE MANAGER') then
          ( select ISNULL(PARTFAM,'') + ','  + ISNULL(PARTGIV,'') + '||' + CAST(mei.MappedEntityId AS varchar(MAX)) 
            from 
              internals.MapEntityId( @entityId ) mei  
              inner join
              [$(PRD_APHIM_UODS)].dbo.T_EntityName en with (nolock)
              on
                mei.MappedEntityId = en.Entity_ID )
          when linkType.shortName in ('CENSUS TRACT','LOINC','SNOMED')  then  --> this sub case cannot occur because of first outer case?
          ( select isnull (ucs.fullName,'') + '||' + convert(varchar,@ucsId) 
            from [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET ucs with (nolock) 
            where ID = @ucsId )
        end
      from
        [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET linkType with (nolock) WHERE ID = @fieldDefId
    )
    when @valueString is not null then @valueString
    when @valueDate is not null then convert( varchar(max), try_convert(date,@valueDate))
  end FormValue
)
