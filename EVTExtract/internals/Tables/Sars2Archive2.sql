﻿create table internals.Sars2Archive2(
	DVPR_RowID int not null constraint [Sars2Archive2.DVPR_RowID.primaryKey] primary key clustered,
	DVPR_IncidentID int not null index [Sars2Archive2.DVPR_IncidentID.index],
	DVPR_PersonDR int null index [Sars2Archive2.DVPR_PersonDR.index]
)
