create view dbo.PersonRaces as
select 
  PER_ROWID                                                = ppp.PersonId, 

  American_Indian_or_Alaska_Native__Specify                = ppp.[American Indian or Alaska Native], 
  Race_Category__American_Indian_or_Alaska_Native          = case when ppp.[American Indian or Alaska Native] is null then 'N' else 'Y' end, 
  
  Asian__Specify                                           = ppp.Asian,   
  Race_Category__Asian                                     = case when ppp.Asian is null then 'N' else 'Y' end, 
  
  Black_or_African_American__Specify                       = ppp.[Black or African American],
  Race_Category__Black_or_African_American                 = case when ppp.[Black or African American] is null then 'N' else 'Y' end, 

  Native_Hawaiian_or_Other_Pacific_Islander__Specify       = ppp.[Native Hawaiian or Other Pacific Islander],
  Race_Category__Native_Hawaiian_or_Other_Pacific_Islander = case when ppp.[Native Hawaiian or Other Pacific Islander] is null then 'N' else 'Y' end, 

  Other__Specify                                           = ppp.Other,
  Race_Category__Other                                     = case when ppp.Other is null then 'N' else 'Y' end, 
  
  Unknown__Specify                                         = ppp.Unknown,
  Race_Category__Unknown                                   = case when ppp.Unknown is null then 'N' else 'Y' end, 
  
  White__Specify                                           = ppp.White,
  Race_Category__White                                     = case when ppp.White is null then 'N' else 'Y' end
from 
  internals.PersonRacesPivoted ppp