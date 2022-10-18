create view internals.UDFSources as
( select distinct
    adc.ShortName Disease,
    ucd.FORM_NAME,    ucd.FORM_DEF_DR ,
    ucd.SECTION_NAME, ucd.SECTION_DEF_DR,
    ucd.FIELD_NAME,   ucd.FIELD_DEF_DR,
    hashbytes( 'SHA1', 
      isnull( adc.ShortName,        '' ) + ';' +
      isnull( ucd.FORM_NAME,        '' ) + '; '+
      isnull( ucd. FORM_DEF_DR,     '' ) + '; '+
      isnull( ucd.SECTION_NAME,     '' ) + ';' +
      isnull( ucd.SECTION_DEF_DR,   '' ) + ';' +
      isnull( ucd.FIELD_NAME,       '' ) + ';' +   
      isnull( ucd.FIELD_DEF_DR,     '' ) ) RowHash
  from
    dbo.COVID_OUTBREAK_UDF_DATA ucd
    cross join
    dbo.All_Disease_Codes adc
  where
    adc.ShortName = 'NCOV2019'

  union --

  select distinct
    adc.ShortName Disease,
    ucd.FORM_NAME,    ucd.FORM_DEF_DR ,
    ucd.SECTION_NAME, ucd.SECTION_DEF_DR,
    ucd.FIELD_NAME,   ucd.FIELD_DEF_DR,
    hashbytes( 'SHA1', 
      isnull( adc.ShortName,        '' ) + ';' +
      isnull( ucd.FORM_NAME,        '' ) + '; '+
      isnull( ucd. FORM_DEF_DR,     '' ) + '; '+
      isnull( ucd.SECTION_NAME,     '' ) + ';' +
      isnull( ucd.SECTION_DEF_DR,   '' ) + ';' +
      isnull( ucd.FIELD_NAME,       '' ) + ';' +   
      isnull( ucd.FIELD_DEF_DR,     '' ) ) RowHash
  from
    dbo.COVID_OUTBREAK_UDF_DATA ucd
    cross join
    dbo.All_Disease_Codes adc
  where
    adc.ShortName = 'NCOV2019'

  union --

  select distinct
    adc.ShortName Disease,
    ucd.FORM_NAME,    ucd.FORM_DEF_DR ,
    ucd.SECTION_NAME, ucd.SECTION_DEF_DR,
    ucd.FIELD_NAME,   ucd.FIELD_DEF_DR,
    hashbytes( 'SHA1', 
      isnull( adc.ShortName,        '' ) + ';' +
      isnull( ucd.FORM_NAME,        '' ) + '; '+
      isnull( ucd. FORM_DEF_DR,     '' ) + '; '+
      isnull( ucd.SECTION_NAME,     '' ) + ';' +
      isnull( ucd.SECTION_DEF_DR,   '' ) + ';' +
      isnull( ucd.FIELD_NAME,       '' ) + ';' +   
      isnull( ucd.FIELD_DEF_DR,     '' ) ) RowHash
  from
    SARS2_UDF_DATA ucd
    cross join
    All_Disease_Codes adc
  where
    adc.ShortName = 'CoV-2'

  union --

  select distinct
    adc.ShortName Disease,
    ucd.FORM_NAME,    ucd.FORM_DEF_DR ,
    ucd.SECTION_NAME, ucd.SECTION_DEF_DR,
    ucd.FIELD_NAME,   ucd.FIELD_DEF_DR,
    hashbytes( 'SHA1', 
      isnull( adc.ShortName,        '' ) + ';' +
      isnull( ucd.FORM_NAME,        '' ) + '; '+
      isnull( ucd. FORM_DEF_DR,     '' ) + '; '+
      isnull( ucd.SECTION_NAME,     '' ) + ';' +
      isnull( ucd.SECTION_DEF_DR,   '' ) + ';' +
      isnull( ucd.FIELD_NAME,       '' ) + ';' +   
      isnull( ucd.FIELD_DEF_DR,     '' ) ) RowHash
  from
    ALL_UDF_DATA ucd 
    inner join
    All_Disease_Codes adc
    on
      ucd.Disease = adc.ID
)