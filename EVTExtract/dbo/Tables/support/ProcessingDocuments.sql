create table dbo.ProcessingDocuments
(
  Name sysname not null
    constraint [ProcessingDocuments.Name.PrimaryKey]
      primary key clustered
)
