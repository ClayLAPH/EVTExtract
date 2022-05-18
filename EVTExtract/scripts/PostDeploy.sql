alter database scoped configuration set legacy_cardinality_estimation = on;
alter database evt_extract set allow_snapshot_isolation on;
alter database evt_extract set recovery  simple;
execute dbo.DefineJobs;

--use msdb;
--grant execute on dbo.sp_start_job to [IRISExtract];

