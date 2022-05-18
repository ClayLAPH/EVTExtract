create view dbo.COVID_OUTBREAK_UDF_DATA_VIEW as
select 
  * 
from 
  internals.UDFData 
where 
  RECORD_ID IN 
  (
    select 
      OUTB_RowID 
    from
      internals.Outbreak 
    where 
      OUTB_DISEASECODE_DR = 543030
  );