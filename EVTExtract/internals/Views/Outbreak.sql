create view internals.Outbreak as
select 
  OUTB_RowID                      = outb.DVOB_RowID,
  OUTB_Legacy_RowID               = act.LocalID,
  OUTB_Disease                    = diseaseName.fullname,
  OUTB_OutbreakNumber             = outb.DVOB_OutbreakNumber,
  OUTB_IsHealthFacilityOutbreak   = facilityName.fullName,
  OUTB_OutbreakLocation           = locName.trivialname,
  OUTB_District                   = districtName.FULLNAME,
  OUTB_DateofOnset                = outb.DVOB_OnsetDate,
  OUTB_DateCreated                = outb.DVOB_CreateDate,
  OUTB_DateClosed                 = outb.DVOB_ClosedDate,
  OUTB_ProcessStatus              = procStatusName.FULLNAME,
  OUTB_ResolutionStatus           = resolutionStatus.FullName,
  OUTB_Notes                      = act.text,
  OUTB_OutbreakType               = outbTypeName.FULLNAME,
  OUTB_OUTBREAKID                 = outb.DVOB_OUTBREAKID,
  OUTB_COUNT                      = obCount.VALUEINTEGER,
  OUTB_USERDR                     = outb.DVOB_USERDR,
  OUTB_HEALTHFACILITYCODE_DR      = outb.DVOB_HEALTHFACILITYCODE_ID,
  OUTB_DISEASECODE_DR             = outb.DVOB_DISEASECODE_ID,
  OUTB_DISSHORTNAME               = diseaseName.SHORTNAME,
  OUTB_LOCATIONDR                 = outb.DVOB_LOCATIONDR,
  OUTB_DISTRICTCODE_DR            = outb.DVOB_DISTRICTCODE_ID,
  OUTB_SPACODE_DR                 = region.SPACODE_ID,
  OUTB_OUTBREAKTYPECODE_DR        = outb.DVOB_OUTBREAKTYPECODE_ID,
  OUTB_PROCESSSTATUSCODE_DR       = outb.DVOB_PROCESSSTATUSCODE_ID,
  OUTB_RESOLUTIONSTATUSCODE_DR    = outb.DVOB_RESOLUTIONSTATUSCODE_ID,
  OUTB_DATESUBMITTED              = obSubmitter.AVAILABILITYTIME,
  OUTB_DGRPDR                     = diseaseGroups.names,
  OUTB_USERNAME                   = isnull(eUserName.PARTFAM,'') + ', ' + isnull(eUserName.PARTGIV,''),  
  OUTB_ISHEALTHFACILITY           =
    case 
      when facilityName.FULLNAME='HEALTH FACILITY' 
      then 'TRUE' 
      else 'FALSE' 
    end,
  OUTB_LOCATIONTYPE               = locType.FULLNAME,  
  OUTB_LOCATIONADDRESS            =
    case 
      when isnull(eAddr.PARTSAL,'') = '' 
      then '' 
      else 
        case 
          when isnull(eAddr.PARTAPTNUM,'') = '' 
          then eAddr.PARTSAL 
          else eAddr.PARTSAL + ', ' 
        end 
      end + 
    case 
      when isnull(eAddr.PARTAPTNUM,'')='' 
      then '' 
      else eAddr.PARTAPTNUM 
    end,
  OUTB_LOCATIONPHONE              = ePhone.ADDRESS,
  OUTB_NURSEINVESTIGATOR          = 
    isnull(eNurse.PartFam,'') + 
    case 
      when eNurse.PartGiv IS NULL 
      then '' 
      else ', ' 
    end + 
    isnull(eNurse.PartGiv,''),
  OUTB_NURSEINVESTIGATORDR        = outb.DVOB_NURSEINVESTIGATORDR,
  OUTB_LOCATIONEMAIL              = locEmail.VALUESTRING,
  OUTB_LOCATIONPRIMARYCONTACT     = locContact.VALUESTRING,
  OUTB_LOCCOUNTY                  = countyName.FULLNAME,
  OUTB_LOCJURISDICTION            = jdistrictName.FULLNAME,
  OUTB_LOCATIONTYPEDR             = eLoc.CODE_ID,
  OUTB_PRIORITY                   = priorityName.FullName,
  OUTB_DISTRICTNUMBER             = region.JurisdictionCode,
  OUTB_LOCATIONCENSUSTRACT        = eAddr.partCen,
  OUTB_LOCATIONCENSUSBLOCK        = eAddr.partCenBlock,
  OUTB_LOCATIONCOUNTYFIPS         = eAddr.partCountyFIPS,
  OUTB_LOCATIONLATITUDE           = eAddr.partGeoLat,
  OUTB_LOCATIONLONGITUDE          = eAddr.partGeoLong,
  OUTB_LOCATIONDISTRICTNUMBER     = locDistrict.JurisdictionCode
from 
  [$(PRD_APHIM_UODS)].dbo.DV_OUTBREAK               outb with (nolock)
  outer apply
  internals.DiseaseGroups(DVOB_DISEASECODE_ID) diseaseGroups
  inner join 
  [$(PRD_APHIM_UODS)].dbo.A_ACT                     act with (nolock)
  on 
    outb.DVOB_ROWID=act.ID
  inner join 
  [$(PRD_APHIM_UODS)].dbo.V_UnifiedCodeSet          diseaseName with (nolock)
  on 
    diseaseName.ID=outb.DVOB_DiseaseCode_ID
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.A_ACT                     obSubmitter with (nolock) 
  on 
    obSubmitter.ACT_PARENT_ID = act.ID and 
    obSubmitter.CLASSCODE = 'OBS' and 
    obSubmitter.METACODE = 'OB_SUBMITTEDBY'
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               obCount with (nolock) 
  on 
    obCount.ACT_ID=act.ID and 
    obCount.NAME='OB_COUNT' and 
    obCount.TYPE='INT'
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.E_ENTITY                  eUser with (nolock) 
  on 
    eUser.ID=outb.DVOB_USERDR  
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_ENTITYNAME              eUserName with (nolock) 
  on 
    eUserName.ENTITY_ID=eUser.ID and 
    eUserName.USECODE='L'   
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET          facilityName with (nolock) 
  on 
    facilityName.ID = outb.DVOB_HEALTHFACILITYCODE_ID  
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.E_ENTITY                  eLoc with (nolock) 
  on 
    eLoc.ID = outb.DVOB_LocationDR and 
    eLoc.ClassCode = 'PLC' and 
    eLoc.DeterminerCode = 'INSTANCE' and 
    eLoc.MetaCode = 'LOC_RowID'
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_ENTITYNAME              locName with (nolock) 
  on 
    locName.ENTITY_ID = eLoc.ID and 
    locName.Metacode='LOC_Name'
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET          locType with (nolock) 
  on 
    locType.ID=eLoc.CODE_ID  
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_ENTITYADDRESS           eAddr with (nolock) 
  on 
    eAddr.ENTITY_ID = eLoc.ID and 
    eAddr.USECODE='PHYS'   
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_ENTITYTELECOM           ePhone with (nolock) 
  on 
    ePhone.ENTITY_ID=eLoc.ID and 
    ePhone.SCHEME='TEL' and 
    ePhone.USECODE='PHYS'  
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET          districtName with (nolock) 
  on 
    districtName.ID = outb.DVOB_DISTRICTCODE_ID   
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET          outbTypeName with (nolock) 
  on 
    outbTypeName.ID = outb.DVOB_OUTBREAKTYPECODE_ID   
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET          procStatusName with (nolock) 
  on 
    procStatusName.ID = outb.DVOB_PROCESSSTATUSCODE_ID
  left outer join  
  [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET          resolutionStatus with (nolock)  
  on 
    resolutionStatus.ID=outb.DVOB_ResolutionStatusCode_ID   
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_ENTITYNAME              eNurse with (nolock) 
  on 
    outb.DVOB_NurseInvestigatorDR=eNurse.ENTITY_ID  
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               locEmail with (nolock) 
  on 
    outb.DVOB_LOCATIONDR=locEmail.ENTITY_ID and 
    locEmail.NAME='LOC_Email' and 
    locEmail.TYPE='ST'  
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               locContact with (nolock) 
  on 
    outb.DVOB_LOCATIONDR=locContact.ENTITY_ID and 
    locContact.NAME='LOC_PrimaryContact' and 
    locContact.TYPE='ST'  
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               locCounty with (nolock) 
  on 
    outb.DVOB_LOCATIONDR=locCounty.ENTITY_ID and 
    locCounty.NAME='LOC_CountyDR' and 
    locCounty.TYPE='CV'  
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET          countyName with (nolock) 
  on 
    locCounty.ValueCode_ID=countyName.ID  
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.T_ATTRIBUTE               aLocDistrict with (nolock) 
  on 
    outb.DVOB_LOCATIONDR=aLocDistrict.ENTITY_ID and 
    aLocDistrict.NAME='LOC_DistrictDR' and 
    aLocDistrict.TYPE='CV'  
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET          jdistrictName with (nolock) 
  on 
    aLocDistrict.ValueCode_ID=jdistrictName.ID  
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.V_UNIFIEDCODESET          priorityName with (nolock) 
  on 
    priorityName.ID = outb.DVOB_PRIORITYDR    
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.VCP_DISTRICT              region with (nolock) 
  on 
    region.SUBJCODE_ID = outb.DVOB_DISTRICTCODE_ID
  left outer join 
  [$(PRD_APHIM_UODS)].dbo.VCP_DISTRICT              locDistrict with (nolock) 
  on 
    locDistrict.SUBJCODE_ID = aLocDistrict.valueCode_ID

