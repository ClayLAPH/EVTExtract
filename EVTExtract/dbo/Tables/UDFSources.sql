create table dbo.UDFSources
(
  RowHash 
    binary(20) not null
    constraint [UDFSources.RowHash.Primay.Key]
      primary key clustered,

  FORM_DEF_DR 
    varchar(50) null
    index [UDFSources.FORM_DEF_DR.Index],

  SECTION_DEF_DR
    varchar(50) null
    index [UDFSources.SECTION_DEF_DR.Index],

  FIELD_DEF_DR
    varchar(50) null
    index [UDFSources.FIELD_DEF_DR.Index],

  FORM_NAME
    varchar(255) null
    index [UDFSources.FORM_Name.Index],

  SECTION_NAME
    varchar(255) null
    index [UDFSources.SECTION_NAME.Index],

  FIELD_NAME
    varchar(255) null
    index [UDFSources.FIELD_NAME.Index],

  DateAdded
    datetime not null
    index [UDFSources.DateAdded.Index],
)
