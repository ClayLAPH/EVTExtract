create view dbo.COVID_OUTBREAK_UDF_DATA_VIEW as
select 
  * 
from 
  internals.UDFData with (nolock) 
where 
  RECORD_ID IN 
  (
    select 
      OUTB_RowID 
    from
      internals.Outbreak with (nolock) 
    where 
      OUTB_DISEASECODE_DR = 543030
  );