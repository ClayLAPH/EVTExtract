create table internals.allincidentpersonalrecordkeys
(
  PR_ROWID int not null
  constraint [internals.allincidentpersonalrecordkeys.PR_ROWID.PrimaryKey]
    primary key clustered,

  PR_PERSONID int not null
)
