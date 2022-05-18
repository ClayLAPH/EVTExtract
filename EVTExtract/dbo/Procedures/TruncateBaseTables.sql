create procedure dbo.TruncateBaseTables as
begin
  set nocount on;

  -- pre-publishing procedure for when we need to make changes to tables

  truncate table COVID_CONTACT
  truncate table COVID_LAB
  truncate table COVID_OUTBREAK
  truncate table COVID_OUTBREAK_LINKED_CONTACT
  truncate table COVID_OUTBREAK_LINKED_INCIDENT
  truncate table COVID_OUTBREAK_PROCESS_STATUS_HISTORY
  truncate table COVID_OUTBREAK_UDF_DATA
  truncate table COVID_PERSON
  truncate table COVID_PROCESS_STATUS_HISTORY
  truncate table COVID_OUTBREAK_UDF_DATA
  truncate table COVID_SPECIMEN
  truncate table COVID_UDF_DATA 

  truncate table SARS2_CONTACT
  truncate table SARS2_LAB
  truncate table SARS2_PERSON
  truncate table SARS2_SPECIMEN
  truncate table SARS2_UDF_DATA

  truncate table [internals].AllContactsExpanded;
  truncate table [internals].AllContacts;
  truncate table [internals].covidacts;
  truncate table [internals].covidperson;
  truncate table [internals].covidpersonalrecord;
  truncate table [internals].covidpersonkeys;
  truncate table [internals].covidpersononalrecordkeys;
  truncate table [internals].covidincidentlab;
  truncate table [internals].PersonExpanded;
  truncate table [internals].LabDataExpanded

  return 0;
end