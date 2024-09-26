Create FUNCTION [Sync].[fn_GetUDCreateScript](@SectionDR int, @StoredProcedureName varchar(500), @ContactUDSectionDR int)
       RETURNS nvarchar(max)
AS
BEGIN
        Declare @CreateScript nvarchar(max)
		IF @ContactUDSectionDR IS NULL
		BEGIN
			Declare @PrefixColumnsFinal nvarchar(max)
			Declare @SuffixColumnsFinal nvarchar(max)
			SET @PrefixColumnsFinal = ' select '
			SET @SuffixColumnsFinal = ''			
			Declare @SelectScript nvarchar(max)
			SET @SelectScript = ''
			Declare @JoinScript nvarchar(max)
			set @JoinScript= ''
			Declare @SecID nvarchar(50)
			Declare @SAR BIT
			DECLARE @SAP BIT
			Declare @IsContactUDSection BIT
			DECLARE @COLUMNFULLLIST VARCHAR(max)
			SET @IsContactUDSection = 0
			DECLARE @PIVOTCOLUMNS AS VARCHAR(max)
			set @PIVOTCOLUMNS = '' 
			DECLARE @SDFLQuery as nvarchar(max)=''

			DECLARE @PH10SeriesConfigurableFeatureSetOn BIT
          
			SELECT @PH10SeriesConfigurableFeatureSetOn=CAST(S_ConfigValue.Value AS BIT) 
			FROM S_ConfigDefinition(nolock)
			INNER JOIN S_ConfigValue(nolock) ON S_ConfigValue.configDefinition_ID=S_ConfigDefinition.ID
			WHERE [Key]='PH10SeriesConfigurableFeatureSetOn'

			DECLARE @PublicHealthClientFormCaption VARCHAR(MAX)
			DECLARE @OutbreakInvestigationName VARCHAR(MAX)
			DECLARE @ContactInvestigationFormCaption VARCHAR(MAX)
          
			SELECT @PublicHealthClientFormCaption=CAST(S_ConfigValue.Value AS VARCHAR(MAX)) 
			FROM S_ConfigDefinition(nolock)
			INNER JOIN S_ConfigValue(nolock) ON S_ConfigValue.configDefinition_ID=S_ConfigDefinition.ID
			WHERE [Key]='PublicHealthClientFormCaption'
        
			SELECT @OutbreakInvestigationName=CAST(S_ConfigValue.Value AS VARCHAR(MAX)) 
			FROM S_ConfigDefinition(nolock)
			INNER JOIN S_ConfigValue(nolock) ON S_ConfigValue.configDefinition_ID=S_ConfigDefinition.ID
			WHERE [Key]='OutbreakInvestigationName'
        
			SELECT @ContactInvestigationFormCaption=CAST(S_ConfigValue.Value AS VARCHAR(MAX)) 
			FROM S_ConfigDefinition(nolock)
			INNER JOIN S_ConfigValue(nolock) ON S_ConfigValue.configDefinition_ID=S_ConfigDefinition.ID
			WHERE [Key]='ContactInvestigationFormCaption'
        
			DECLARE @RecordTypeSelect as varchar(max)
			SET @RecordTypeSelect = '(case RecordType when ''Client Record'' then ''' + @PublicHealthClientFormCaption + ' Record'' when ''Outbreak'' then ''' + @OutbreakInvestigationName + ''' when ''Contact Investigation'' then ''' + @ContactInvestigationFormCaption + ''' ELSE RecordType END) as RecordType'

			IF @ContactUDSectionDR IS   NULL
				select @SecID = Sec_ID, @SAR = ISNULL(SEC_ShareAcrossRecord,0), @SAP = ISNULL(SEC_ShareAcrossPerson,0) from VCP_UDSection(NOLOCK) where SubjCode_ID = @SectionDR
			else
				set @SecID = @ContactUDSectionDR

		   IF @SecID = '-8' OR (@ContactUDSectionDR IS NOT NULL)
		   BEGIN
					  set @PIVOTCOLUMNS = 'Testvalue'
					  if @ContactUDSectionDR   is NULL
					  begin
					  SET @PrefixColumnsFinal = @PrefixColumnsFinal + '  DIID, CONTACTID, INSTANCEID, RECORDTYPE, RLENT_FIRSTNAME, RLENT_LASTNAME, RLENT_MIDDLEINITIAL, RLENT_NAMESUFFIX, RLENT_AGE, RLENT_DOB,
							 RLENT_SEX, RLENT_CONTACTTYPE, RLENT_DATESOFCONTACT, RLENT_STREETADDRESS, RLENT_APARTMENT, RLENT_City, RLENT_Zip, RLENT_PHONE,
							 RLENT_District, RLENT_PROPHYLAXISMEDICATION, RLENT_INVESTIGATORDR, RLENT_EXPEVENTDR, RLENT_EXPEVENT, RLENT_PRIORITYDR,
							 RLENT_CLUSTERID, RLENT_STATUSDR, FOLDERID, RLENT_ELECTRONICCONTACT, RLENT_EMAIL, RLENT_State, RLENT_RACE, [AmericanIndianorAlaskaNative_RaceCategory] as [Race Category - American Indian or Alaska Native], [AmericanIndianorAlaskaNative_Specify] as [American Indian or Alaska Native - Specify],
							 [Asian_RaceCategory] as [Race Category - Asian], [Asian_Specify] as [Asian - Specify],
							 [BlackorAfricanAmerican_RaceCategory] as [Race Category - Black or African American],
							 [BlackorAfricanAmerican_Specify] as [Black or African American - Specify], 
							 [NativeHawaiianorOtherPacificIslander_RaceCategory] as [Race Category - Native Hawaiian or Other Pacific Islander],
							 [NativeHawaiianorOtherPacificIslander_Specify] as [Native Hawaiian or Other Pacific Islander - Specify],
							 [Other_RaceCategory] as [Race Category - Other],[Other_Specify] as [Other - Specify], [Unknown_RaceCategory] as [Race Category - Unknown],
							 [Unknown_Specify] as [Unknown - Specify], [White_RaceCategory] as [Race Category - White], [White_Specify] as [White - Specify] '
					  end
					  else
					  begin
							 SET @IsContactUDSection = 1
							 SET @PrefixColumnsFinal = @PrefixColumnsFinal + '  DIID, CONTACTID, INSTANCEID, '
					  end
					  SET @JoinScript = ' FROM UDFExportSession UDFSESSION (NOLOCK) 
					  INNER JOIN UDF_ContactSectionData UDC (NOLOCK) ON UDFSESSION.DIID = UDC.RecordID
							WHERE UDFSESSION.SessionID=@SessionID '
		   END
		   ELSE IF  @SecID = '-10'
		   BEGIN
					  set @PIVOTCOLUMNS = 'Testvalue'
					  SET @PrefixColumnsFinal = @PrefixColumnsFinal +  '  InstanceID as INCIDENTID, RecordID as PHRECORDID, LabReportID, ACCESSIONNUMBER, HL7FILENAME, RESULTTEXT, ABNORMALFLAG, IMPORTSTATUS, ISFROMHL7,
							 (CASE WHEN IsFromHL7 = 1 THEN ''True'' ELSE ''False'' END) as ISFROMHL7TEXT,
							 LABRESULTSTATUS, LOCALORGANISMCODE, LOCALORGANISMDESCRIPTION, LOCALTESTCODE, LOCALTESTDESCRIPTION, NOTES, ORGANISMCODE, ORGANISMCODINGSYSTEM,
							 ORGANISMDESCRIPTION, PATIENTNAME, PERFORMINGFACILITYID, PFGEPATTERN1ST, PFGEPATTERN2ND, REFERENCERANGE, RESULTDATE, RESULTSTATUS, RESULTUNIT,
							 RESULTVALUE, SEROGROUP, SEROLOGY, SEROTYPE, SPECIES, SPECBODYSITE, SPECCOLLECTEDDATE, SPECIMENSOURCE, SPECRECEIVEDDATE, TESTCODE, TESTCODINGSYSTEM,
							 TESTDESCRIPTION, DILR_StatusCode '
					  SET @JoinScript = ' FROM UDFExportSession UDFSESSION (NOLOCK) 
					  INNER JOIN UDF_LabInfoSectionData UDL (NOLOCK) ON UDFSESSION.DIID = UDL.RecordID
							WHERE UDFSESSION.SessionID=@SessionID '
		   END
		   ELSE IF @SecID = '-11'  
		   BEGIN
					  set @PIVOTCOLUMNS = 'Testvalue'
					  SET @PrefixColumnsFinal = @PrefixColumnsFinal +  '  InstanceID as INCIDENTID, RecordID as PHRECORDID, LabReportID, ACCESSIONNUMBER, HL7FILENAME, RESULTTEXT, ABNORMALFLAG, IMPORTSTATUS, ISFROMHL7,
							 LABRESULTSTATUS, LOCALORGANISMCODE, LOCALORGANISMDESCRIPTION, LOCALTESTCODE, LOCALTESTDESCRIPTION, NOTES, ORGANISMCODE, ORGANISMCODINGSYSTEM,
							 ORGANISMDESCRIPTION, PATIENTNAME, PERFORMINGFACILITYID, PFGEPATTERN1ST, PFGEPATTERN2ND, REFERENCERANGE, RESULTDATE, RESULTSTATUS, RESULTUNIT,
							 RESULTVALUE, SEROGROUP, SEROLOGY, SEROTYPE, SPECIES, SPECBODYSITE, SPECCOLLECTEDDATE, SPECIMENSOURCE, SPECRECEIVEDDATE, TESTCODE, TESTCODINGSYSTEM,
							 TESTDESCRIPTION, PROVIDERNAME, PROVIDERID, PROVIDERADDRESS, PROVIDERCITY, PROVIDERSTATE, PROVIDERCOUNTY, PROVIDERZIP, PROVIDERPHONE, PROVIDEREMAIL,
							 PROVIDERFAX, FACILITYNAME, FACILITYADDRESS, FACILITYCITY, FACILITYSTATE, FACILITYCOUNTY, FACILITYZIP, FACILITYPHONE, PLACERORDERNO, FACILITYEMAIL, FACILITYID  '
					  SET @JoinScript = ' FROM UDFExportSession UDFSESSION (NOLOCK) 
					  INNER JOIN UDF_LabInfoSectionData UDL (NOLOCK) ON UDFSESSION.DIID = UDL.RecordID
							WHERE UDFSESSION.SessionID=@SessionID '
		   END
		   ELSE IF @SecID = '-12' 
		   BEGIN
					set @PIVOTCOLUMNS = 'Testvalue'
					SET @PrefixColumnsFinal = @PrefixColumnsFinal +  ' [RecordID] AS PHRECORDID,  EXPOSUREEVENTID,  InstanceID AS PHRECORD_INSTANCE_ID,  DEE_EXPOSUREDATETIME,  DEE_EXPOSUREENDDATETIME, DEE_ExposureTypeDR, DEE_EXPOSURETYPE,
						 DEE_LOCATIONDR,  DEE_LOCATION_NAME,  DEE_StatusCode,  RecordType AS PR_RecordType  '
       
					SET @JoinScript = ' FROM UDFExportSession UDFSESSION (NOLOCK) 
					INNER JOIN UDF_ExposureEventSectionData UDE (NOLOCK) ON UDFSESSION.DIID = UDE.RecordID
							WHERE UDFSESSION.SessionID=@SessionID '                           
		   END
		   ELSE
		   BEGIN
					SET @SuffixColumnsFinal = @SuffixColumnsFinal + ', (case when RecordType = ''Client Record'' Then NULL ELSE DIID END) as DIID, (case when RecordType = ''Client Record'' Then NULL ELSE INSTANCEID END) as INSTANCEID, '
					IF @PH10SeriesConfigurableFeatureSetOn=1
					BEGIN
						SET @SuffixColumnsFinal =  @SuffixColumnsFinal +' ClientID AS ['+ @PublicHealthClientFormCaption + ' ID] , GroupEventType, GroupEventNumber,'
					END
					SET @SuffixColumnsFinal = @SuffixColumnsFinal + '  CASE WHEN SEC_InstanceID IS NULL THEN -2147483648 + ROW_NUMBER() OVER (ORDER BY FormInstanceID ASC) ELSE SEC_InstanceID END   as UDSectionActID, ' + @RecordTypeSelect + ', Disease, OutbreakNumber, District, FormInstanceID, FormName, FormDescription, FormCreateDateTime ' 
		   END

		   SET @CreateScript = ' CREATE PROCEDURE ' + @StoredProcedureName + '
		   @SessionID as uniqueidentifier 
		   AS 
		   '

		   DECLARE @ID INT
		   SELECT @ID = CASE WHEN @ContactUDSectionDR IS NOT NULL THEN @ContactUDSectionDR ELSE @SectionDR END
		   IF @SecID not in ('-12', '-11', '-10', '-8') 
		   BEGIN
					SELECT @COLUMNFULLLIST =   Sync.fn_GetSectionFieldsForSSIS(@ID, 1, 0,1) 
		   END

		   SET @SelectScript = @PrefixColumnsFinal +   @COLUMNFULLLIST +   @SuffixColumnsFinal
		   Declare @PivotSourceQuery as  Varchar(Max)
		   SET @PivotSourceQuery = 'DECLARE @FetchInternalValueForUDFExport as NVARCHAR(10);SELECT @FetchInternalValueForUDFExport=UPPER(Value)  FROM ConfigValues(NOLOCK) WHERE [KEY]=''FetchInternalValueForUDFExport''; '
        
		   IF @SecID not in ('-12', '-11', '-10', '-8') 
		   BEGIN
				  Declare @CheckboxListIDs varchar(1000) 
				  SET @CheckboxListIDs = ''
				  SELECT @CheckboxListIDs = Sync.fn_GetSectionFieldsForSSIS(@ID, 0, 1,1)

				  IF @CheckboxListIDs <> '' 
				  BEGIN
						 SET @PivotSourceQuery = @PivotSourceQuery+ '
							   WITH CTE_CheckboxListsRecords
							   AS
							   (
									  SELECT DISTINCT '
									  IF @SAP = 1
									BEGIN
										SET @PivotSourceQuery =  @PivotSourceQuery +' PatientFolderID AS DIID';
									END
									ELSE
									BEGIN
										SET @PivotSourceQuery =  @PivotSourceQuery +' DIID';
									END
									SET @PivotSourceQuery =    @PivotSourceQuery +' , InstanceID,'
									  IF @PH10SeriesConfigurableFeatureSetOn=1
									  BEGIN
											 SET @PivotSourceQuery =    @PivotSourceQuery +' ClientID , GroupEventType, GroupEventNumber,'
									  END
									  SET @PivotSourceQuery =    @PivotSourceQuery +'  RecordType, Disease, OutbreakNumber, District,'
										IF @SAR = 1 OR @SAP = 1
										BEGIN
											SET @PivotSourceQuery =  @PivotSourceQuery +' DIID AS FormInstanceID,';
										END
										ELSE
										 BEGIN
											SET @PivotSourceQuery =  @PivotSourceQuery +' FormInstanceID,';
										END
						 SET @PivotSourceQuery = @PivotSourceQuery+ ' FormName, 
									  FormDescription, FormCreateDateTime, PatientFolderID, UDS.SEC_InstanceID, FLD_DefinitionID,SEC_ActPointerID ' 
							   if @IsContactUDSection = 1
							   begin
									  SET @PivotSourceQuery = @PivotSourceQuery +     ' ,CONTACTID '
							   end    
                                  
						SET @PivotSourceQuery = @PivotSourceQuery + replace(Sync.fn_GetUDCreateScriptFromClause(@SAP,@SAR,@IsContactUDSection), '@SectionDR', @ID) + ' and FLD_DefinitionID in (' + @CheckboxListIDs +'))
						 , '          
				  END
				  ELSE
				  BEGIN
						 SET @PivotSourceQuery = @PivotSourceQuery+' WITH '
				  END
             
				  SET @PivotSourceQuery = @PivotSourceQuery + ' CTE_PivotSource 
				  AS 
				  (
						SELECT DISTINCT '                      
						if @IsContactUDSection = 1
						begin
							SET @PivotSourceQuery = @PivotSourceQuery +     ' CONTACTID, '
						end                     
                    
						--Santhosh Issue#195559
						IF @SAP = 1
						BEGIN
							SET @PivotSourceQuery =  @PivotSourceQuery +' PatientFolderID AS DIID,';
						END
						ELSE
						BEGIN
							SET @PivotSourceQuery =  @PivotSourceQuery +' DIID,';
						END
						SET @PivotSourceQuery = @PivotSourceQuery +     ' InstanceID,';
						--Santhosh Issue#195559
						IF @PH10SeriesConfigurableFeatureSetOn=1
						BEGIN
								SET @PivotSourceQuery =    @PivotSourceQuery +' ClientID , GroupEventType, GroupEventNumber,'
						END
						SET @PivotSourceQuery =    @PivotSourceQuery +'  RecordType, Disease, OutbreakNumber, District, ';
						--Santhosh Issue#195559
						IF @SAR = 1 OR @SAP = 1
						BEGIN
							SET @PivotSourceQuery =  @PivotSourceQuery +' DIID AS FormInstanceID,';
						END
						ELSE
						BEGIN
							SET @PivotSourceQuery =  @PivotSourceQuery +' FormInstanceID,';
						END
						--Santhosh Issue#195559
						SET @PivotSourceQuery =  @PivotSourceQuery +'FormName, 
						 FormDescription, FormCreateDateTime, PatientFolderID, UDS.SEC_InstanceID, FLD_DefinitionID, SEC_ActPointerID, CASE WHEN @FetchInternalValueForUDFExport=''FALSE'' THEN FLD_Value ELSE CASE WHEN FLD_InternalValue IS NULL THEN FLD_Value ELSE FLD_InternalValue END END as UDFieldValues  '                            
						SET @PivotSourceQuery = @PivotSourceQuery +       replace(Sync.fn_GetUDCreateScriptFromClause(@SAP,@SAR,@IsContactUDSection), '@SectionDR', @ID)
                     
						 IF @CheckboxListIDs <> '' 
						BEGIN
								SET @PivotSourceQuery = @PivotSourceQuery + ' and FLD_DefinitionID not in (' + @CheckboxListIDs +')'       
						END

						IF @SAP=0
						BEGIN
							SELECT @SDFLQuery=CHAR(13)+COALESCE(CASE WHEN @SDFLQuery='' THEN @SDFLQuery ELSE @SDFLQuery+' UNION ALL ' END,'')+CHAR(13)+' SELECT DISTINCT  DIID, InstanceID,'+ CASE WHEN @PH10SeriesConfigurableFeatureSetOn=1 THEN ' ClientID AS ['+ @PublicHealthClientFormCaption + ' ID] , GroupEventType, GroupEventNumber,' END +'  RecordType, Disease, OutbreakNumber, District, '+ CASE WHEN @SAR=1 THEN 'DIID AS FormInstanceID' ELSE ' FormInstanceID' END +',FormName, 
                                      
											 FormDescription, FormCreateDateTime, PatientFolderID, UDS.SEC_InstanceID AS SEC_InstanceID , '+ CAST(VCP_UDFIELD.SUBJCODE_ID AS VARCHAR(20))+' as FLD_DefinitionID, SEC_ActPointerID, cast(View_UDF_SDFL_' + IsNull((REPLACE(Field_LinkedSystemField, '^', '.')),'') +' as nvarchar(max)) as  UDFieldValues
											 From UDFExportSession UDSESSION (NOLOCK)
											 LEFT JOIN [View_UDF_SDFL_' + IsNull((SUBSTRING(Field_LinkedSystemField, 0,CHARINDEX('^',Field_LinkedSystemField))),'') +'] (NOLOCK) ON [View_UDF_SDFL_' + IsNull((SUBSTRING(Field_LinkedSystemField, 0,CHARINDEX('^',Field_LinkedSystemField))),'') +'].PR_RowID = UDSESSION.DIID
											 LEFT JOIN UD_SectionInstance UDS (NOLOCK) ON UDS.SEC_ActPointerID = '+ CASE WHEN @SAR=1 THEN 'UDSESSION.DIID' ELSE 'UDSESSION.FormInstanceID' END +' AND UDS.SEC_DefinitionID = '+CAST(@SectionDR AS VARCHAR(20))+'
											 WHERE SESSIONID=@SessionID '+CHAR(13) FROM V_CODEPROPERTY (NOLOCK)
							INNER JOIN VCP_UDFIELD  (NOLOCK) ON VCP_UDFIELD.SUBJCODE_ID=VAluecode_ID
							INNER JOIN V_UNIFIEDCODESET (NOLOCK) ON V_UNIFIEDCODESET.ID=FIELD_TypeCode_ID
							WHERE V_CODEPROPERTY.SUBJCODE_ID=@SectionDR and fullname='System Defined Field Link'

							IF @SDFLQuery<>''
							BEGIN
								SET @PivotSourceQuery = @PivotSourceQuery +CHAR(13)+' UNION ALL '+CHAR(13)+ @SDFLQuery 
							END
						END
						IF @CheckboxListIDs <> '' 
						BEGIN                  
								SET @PivotSourceQuery = @PivotSourceQuery + CHAR(13)+' UNION ALL '+CHAR(13)+'
								SELECT '                     
								if @IsContactUDSection = 1
								begin
									SET @PivotSourceQuery = @PivotSourceQuery +     ' CONTACTID, '
								end                     
								SET @PivotSourceQuery = @PivotSourceQuery +     'DIID, InstanceID, '
								IF @PH10SeriesConfigurableFeatureSetOn=1
								BEGIN
										SET @PivotSourceQuery =    @PivotSourceQuery +' ClientID , GroupEventType, GroupEventNumber,'
								END
								SET @PivotSourceQuery =  @PivotSourceQuery +'  RecordType, Disease, OutbreakNumber, District, FormInstanceID, FormName, 
								FormDescription, FormCreateDateTime, PatientFolderID, CTE_CHECK.SEC_InstanceID, FLD_DefinitionID,SEC_ActPointerID,
								(LTRIM(STUFF(RTRIM(REPLACE(REPLACE(((Select '', '' + convert(nvarchar(max), CASE WHEN @FetchInternalValueForUDFExport=''FALSE'' THEN FLD_Value ELSE CASE WHEN FLD_InternalValue IS NULL THEN FLD_Value ELSE FLD_InternalValue END END ) from UD_Values ax (nolock)
								where ax.SEC_InstanceID = CTE_CHECK.SEC_InstanceID and ax.FLD_DefinitionID = CTE_CHECK.FLD_DefinitionID for XML Path(''''), root(''MyString''), type ).value(''/MyString[1]'',''nvarchar(max)'')),''</UDFieldValues>'',''''),''<UDFieldValues>'','','')),1,1,''''))) as UDFieldValues   

								FROM CTE_CheckboxListsRecords CTE_CHECK
								'
						END
						SET @PivotSourceQuery = @PivotSourceQuery + ')'+CHAR(13)        
             
						SELECT @PIVOTCOLUMNS =    Sync.fn_GetSectionFieldsForSSIS(@ID, 0,0,1)

						SET @JoinScript = '
								FROM ( 
								Select * from CTE_PivotSource) S  
								PIVOT
								(
									Max(UDFieldValues)
									FOR FLD_DefinitionID in ('+ @PIVOTCOLUMNS +')
								) P
						'
						SELECT @PIVOTCOLUMNS =    Sync.fn_GetSectionFieldsForSSIS(@ID, 0,0,0)
						IF @SecID not in ('-12', '-11', '-10', '-8') 
						BEGIN
							SELECT @COLUMNFULLLIST =   Sync.fn_GetSectionFieldsForSSIS(@ID, 1, 0,0) 
						END
				  --***********SPECIAL CASE: If the section only has Non-EditableField (No SDFL field present)
              
				   IF @PIVOTCOLUMNS = '' And @ColumnFullList = '' and @ContactUDSectionDR IS NULL
				   BEGIN
                    
						DECLARE @temp varchar(max)
						SET @temp = @SelectScript
						SELECT @temp =   REPLACE(REPLACE(REPLACE(ltrim(REPLACE(ltrim(@temp), 'select', '')), 'ClientID AS', ''), 'SEC_InstanceID as', ''),'CASE WHEN SEC_InstanceID IS NULL THEN -2147483648 + ROW_NUMBER() OVER (ORDER BY FormInstanceID ASC) ELSE SEC_InstanceID END   as','')
						SELECT @SelectScript = 'select ' +  SUBSTRING (ltrim(@temp), 2 , len(@temp)-1)

						SET @PivotSourceQuery = ''
						--Add a Dummy Join Script
						SET @JoinScript = ' FROM ( select 
						DIID, INSTANCEID,  ClientID AS ['+ @PublicHealthClientFormCaption + ' ID]  , GroupEventType, GroupEventNumber,  SEC_InstanceID as UDSectionActID, RecordType, Disease, OutbreakNumber, District, FormInstanceID, FormName, FormDescription, FormCreateDateTime    
						From    
						UD_SectionInstance UDS (NOLOCK)    
						INNER JOIN   
						UDFExportSession UDSESSION (NOLOCK)   ON UDSESSION.FormInstanceID = UDS.SEC_ActPointerID  Where 1<>1 ) Dummy '
				   END

					--***********SPECIAL CASE: If the section only has System Defined Link Fields 
				  IF @PIVOTCOLUMNS  = '' and @COLUMNFULLLIST <> ''
				  BEGIN
						SET @SelectScript = CHAR(13)+@PrefixColumnsFinal +   @COLUMNFULLLIST +   @SuffixColumnsFinal
						SET @PivotSourceQuery = ' WITH ' 
						SET @PivotSourceQuery = @PivotSourceQuery + ' CTE_PivotSource 
						AS 
						(
						SELECT DISTINCT ' 
                     
						IF @IsContactUDSection = 1
						BEGIN
							SET @PivotSourceQuery = @PivotSourceQuery +     ' CONTACTID, '
						END
						SET @PivotSourceQuery = @PivotSourceQuery +     'DIID, InstanceID,'
						IF @PH10SeriesConfigurableFeatureSetOn=1
						BEGIN
							SET @PivotSourceQuery =    @PivotSourceQuery +' ClientID , GroupEventType, GroupEventNumber,'
						END
						SET @PivotSourceQuery =    @PivotSourceQuery +'  RecordType, Disease, OutbreakNumber, District, FormInstanceID, FormName, 
						FormDescription, FormCreateDateTime, PatientFolderID, -2147483648 + cast(ROW_NUMBER() OVER (ORDER BY forminstanceid ASC) as nvarchar(100)) as  SEC_InstanceID, -2147483648 as SEC_ActPointerID  
						'                           
						SET @PivotSourceQuery = @PivotSourceQuery +  ' From UDFExportSession UDSESSION (NOLOCK) WHERE   UDSESSION.SessionID=@SessionID)'
                      
						SET @JoinScript = 'FROM ( Select * from CTE_PivotSource ) P '
              
						IF CHARINDEX('View_UDF_SDFL_DiCase', @COLUMNFULLLIST) > 0 
						BEGIN
							SET @JoinScript = @JoinScript + ' 
							LEFT JOIN [View_UDF_SDFL_DiCase] (NOLOCK) ON View_UDF_SDFL_DiCase.PR_RowID = P.DIID '
						END

						IF CHARINDEX('View_UDF_SDFL_DiPat', @COLUMNFULLLIST) > 0 
						BEGIN
							SET @JoinScript = @JoinScript + ' 
							LEFT JOIN [View_UDF_SDFL_DiPat] (NOLOCK) ON View_UDF_SDFL_DiPat.PR_RowID = P.DIID '
						END

						IF CHARINDEX('View_UDF_SDFL_DiRVCT', @COLUMNFULLLIST) > 0 
						BEGIN
							SET @JoinScript = @JoinScript + ' 
							LEFT JOIN [View_UDF_SDFL_DiRVCT] (NOLOCK) ON View_UDF_SDFL_DiRVCT.PR_RowID = P.DIID '
						END
				END
		   END

       
		   Set @CreateScript = @CreateScript + @PivotSourceQuery + @SelectScript + @JoinScript
		END  -- End of ContactUDSectionDR Check           
	   Return @CreateScript
END

