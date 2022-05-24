create procedure dbo.GetBaseTableCounts as
begin
  set nocount on;

  select name = 'COVID_CONTACT',                 size = count(*) from COVID_CONTACT                         union all
  select        'COVID_INCIDENT',                       count(*) from dbo.COVID_INCIDENT                    union all
  select        'COVID_LAB',                            count(*) from dbo.COVID_LAB                         union all
  select        'COVID_OUTBREAK',                       count(*) from COVID_OUTBREAK                        union all
  select        'COVID_OUTBREAK_LINKED_CONTACT',        count(*) from COVID_OUTBREAK_LINKED_CONTACT         union all
  select        'COVID_OUTBREAK_LINKED_INCIDENT',       count(*) from COVID_OUTBREAK_LINKED_INCIDENT        union all
  select        'COVID_OUTBREAK_PROCESS_STATUS_HISTORY',count(*) from COVID_OUTBREAK_PROCESS_STATUS_HISTORY union all
  select        'COVID_OUTBREAK_UDF_DATA',              count(*) from COVID_OUTBREAK_UDF_DATA               union all
  select        'COVID_PERSON',                         count(*) from COVID_PERSON                          union all
  select        'COVID_PROCESS_STATUS_HISTORY',         count(*) from COVID_PROCESS_STATUS_HISTORY          union all
  select        'COVID_OUTBREAK_UDF_DATA',              count(*) from COVID_OUTBREAK_UDF_DATA               union all
  select        'COVID_SPECIMEN',                       count(*) from COVID_SPECIMEN                        union all
  select        'COVID_UDF_DATA',                       count(*) from COVID_UDF_DATA                        union all
  select        'SARS2_CONTACT',                        count(*) from SARS2_CONTACT                         union all
  select        'SARS2_INCIDENT',                       count(*) from dbo.SARS2_INCIDENT                    union all
  select        'SARS2_LAB',                            count(*) from SARS2_LAB                             union all
  select        'SARS2_OUTBREAK',                       count(*) from SARS2_OUTBREAK                        union all
  select        'SARS2_OUTBREAK_PROCESS_STATUS_HISTORY',count(*) from SARS2_OUTBREAK_PROCESS_STATUS_HISTORY union all
  select        'SARS2_PERSON',                         count(*) from SARS2_PERSON                          union all
  select        'SARS2_SPECIMEN',                       count(*) from SARS2_SPECIMEN                        union all
  select        'SARS2_UDF_DATA',                       count(*) from SARS2_UDF_DATA


  return 0;
end
