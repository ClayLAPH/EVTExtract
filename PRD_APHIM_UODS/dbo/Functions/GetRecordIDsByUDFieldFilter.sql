
CREATE FUNCTION [dbo].[GetRecordIDsByUDFieldFilter]  
(  
 @UDSectionID INT,  
 @UDFieldID INT,  
 @UDFieldValue VARCHAR(MAX),  
 @UDFieldType VARCHAR(2),  
 @RecordActID INT ,  
 @RecordType VARCHAR(MAX),  
 @UserDR INT  
)  
RETURNS @tblPHRecordIDs TABLE   
(  
 RecordID Int  
)  
AS  
BEGIN  
    DECLARE @UDFieldValue_UCSID INT  
    IF @RecordActID = -1   
    SET @RecordActID = -2147483648  
    
    IF @UDFieldType = '10'  
        SET @UDFieldValue_UCSID = -1  
    ELSE  
        SET @UDFieldValue_UCSID = Cast(@UDFieldValue AS INT)  
    
    --BLK START PERSONAL RECORD 
    IF @RecordType = 'Personal Record' OR @RecordType = ''  
    BEGIN  
        BEGIN
            INSERT INTO @tblPHRecordIDs  
            SELECT DVPR_ROWID FROM DV_PHPERSONALRECORD (NOLOCK) 
            INNER JOIN A_ACTRELATIONSHIP ACTREL (NOLOCK) ON DV_PHPERSONALRECORD.DVPR_ROWID = ACTREL.SOURCE_ID AND ACTREL.TYPECODE='COMP' 
            INNER JOIN AX_UDFVALUES (NOLOCK) ON ACTREL.target_ID = AX_UDFVALUES.UDF_InstanceID AND AX_UDFVALUES.METACODE_UCSID = @UDFieldID 
            AND AX_UDFVALUES.SEC_DefinitionID = @UDSectionID AND ACTREL.TYPECODE='COMP'    
            WHERE  
            (  
            (@RecordActID =-2147483648 OR DV_PHPERSONALRECORD.DVPR_ROWID = @RecordActID)  
            AND  
            (  
            (@UDFieldType='10' AND AX_UDFVALUES.VALUESTRING = @UDFieldValue)  
            OR  
            (@UDFieldType <> '10' AND (AX_UDFVALUES.VALUE_UCSID = @UDFieldValue_UCSID))  
            ) )        
            UNION  
            SELECT DVPR_ROWID FROM DV_PHPERSONALRECORD (NOLOCK) WHERE DVPR_USERDR = @UserDR AND (@RecordActID =-2147483648 OR DV_PHPERSONALRECORD.DVPR_ROWID = @RecordActID)  
        END  
    --BLK END PERSONAL RECORD
    END

    --BLK START OUTBREAK    
    IF @RecordType = 'Outbreak' OR @RecordType = ''  
    BEGIN  
        INSERT INTO @tblPHRecordIDs  
        SELECT DVOB_ROWID FROM DV_OUTBREAK (NOLOCK) 
        INNER JOIN A_ACTRELATIONSHIP ACTREL (NOLOCK) ON DV_OUTBREAK.DVOB_ROWID = ACTREL.SOURCE_ID AND ACTREL.TYPECODE='COMP'  
        INNER JOIN AX_UDFVALUES (NOLOCK) ON ACTREL.target_ID = AX_UDFVALUES.UDF_InstanceID AND AX_UDFVALUES.METACODE_UCSID = @UDFieldID 
        AND AX_UDFVALUES.SEC_DefinitionID = @UDSectionID AND ACTREL.TYPECODE='COMP'        
        WHERE    
        (  
        (@RecordActID =-2147483648 OR DV_OUTBREAK.DVOB_ROWID = @RecordActID)  
        AND  
        (  
        (@UDFieldType='10' AND AX_UDFVALUES.VALUESTRING = @UDFieldValue)  
        OR  
        (@UDFieldType <> '10' AND (AX_UDFVALUES.VALUE_UCSID = @UDFieldValue_UCSID))  
        ))  
       
        UNION  
        SELECT DVOB_ROWID FROM DV_OUTBREAK (NOLOCK) WHERE DVOB_USERDR = @UserDR AND (@RecordActID =-2147483648 OR DV_OUTBREAK.DVOB_ROWID = @RecordActID)  
    END
    --BLK END OUTBREAK 
  
    --BLK START Animal Record 
    --SugannyaB CMR 11.0.0.1 Issue#104370  For filtering Animal Report Records
    IF @RecordType = 'Animal Record' OR @RecordType = ''  
    BEGIN  
        INSERT INTO @tblPHRecordIDs  
        SELECT DVAI_RowID FROM DV_ANIMALREPORT (NOLOCK) 
        INNER JOIN A_ACTRELATIONSHIP ACTREL (NOLOCK) ON DV_ANIMALREPORT.DVAI_RowID = ACTREL.SOURCE_ID AND ACTREL.TYPECODE='COMP'  
        INNER JOIN AX_UDFVALUES (NOLOCK) ON ACTREL.target_ID = AX_UDFVALUES.UDF_InstanceID AND AX_UDFVALUES.METACODE_UCSID = @UDFieldID 
        AND AX_UDFVALUES.SEC_DefinitionID = @UDSectionID AND ACTREL.TYPECODE='COMP'    
        WHERE    
        (  
        (@RecordActID =-2147483648 OR DV_ANIMALREPORT.DVAI_RowID = @RecordActID)  
        AND  
        (  
        (@UDFieldType='10' AND AX_UDFVALUES.VALUESTRING = @UDFieldValue)  
        OR  
        (@UDFieldType <> '10' AND (AX_UDFVALUES.VALUE_UCSID = @UDFieldValue_UCSID))  
        )  
        
        )      
        UNION  
        SELECT DVAI_ROWID FROM DV_ANIMALREPORT (NOLOCK) WHERE DVAI_UserDR = @UserDR AND (@RecordActID =-2147483648 OR DV_ANIMALREPORT.DVAI_RowID = @RecordActID) 
    END
    --BLK END Animal Record 
    
    --BLK START Deleted Personal Record 
    -- BadhriNK 6/3/2011 CMR 11.0.0.1 Issue#105901
    IF @RecordType = 'Deleted Personal Record' OR @RecordType = ''  
    BEGIN  
        --Normal Form  
        INSERT INTO @tblPHRecordIDs  
       
        SELECT DVPR_ROWID FROM DV_PHDeletedPersonalRecord (NOLOCK) 
        INNER JOIN A_ACTRELATIONSHIP ACTREL (NOLOCK) ON DV_PHDeletedPersonalRecord.DVPR_ROWID = ACTREL.SOURCE_ID AND ACTREL.TYPECODE='COMP'  
        INNER JOIN AX_UDFVALUES (NOLOCK) ON ACTREL.target_ID = AX_UDFVALUES.UDF_InstanceID AND AX_UDFVALUES.METACODE_UCSID = @UDFieldID 
        AND AX_UDFVALUES.SEC_DefinitionID = @UDSectionID AND ACTREL.TYPECODE='COMP'    
        WHERE  
        (  
        (@RecordActID =-2147483648 OR DV_PHDeletedPersonalRecord.DVPR_ROWID = @RecordActID)  
        AND  
        (  
        (@UDFieldType='10' AND AX_UDFVALUES.VALUESTRING = @UDFieldValue)  
        OR  
        (@UDFieldType <> '10' AND (AX_UDFVALUES.VALUE_UCSID = @UDFieldValue_UCSID))  
        )  
        
        )      
        UNION  
        SELECT DVPR_ROWID FROM DV_PHDeletedPersonalRecord (NOLOCK) WHERE DVPR_USERDR = @UserDR AND 
        (@RecordActID =-2147483648 OR DV_PHDeletedPersonalRecord.DVPR_ROWID = @RecordActID)  
    END
    --BLK END Deleted Personal Record
  
    --BLK START GROUP EVENT     
    IF @RecordType = 'Group Event' OR @RecordType = ''  
    BEGIN   
        INSERT INTO @tblPHRecordIDs  
        SELECT AX_GROUPEVENT.ID FROM AX_GROUPEVENT (NOLOCK)
        INNER JOIN A_ACT GEACT (NOLOCK) ON AX_GROUPEVENT.ID = GEACT.ID AND GEACT.statusCode NOT IN ('nullified','terminated') 
        INNER JOIN A_ACTRELATIONSHIP ACTREL (NOLOCK) ON GEACT.ID = ACTREL.SOURCE_ID AND ACTREL.TYPECODE='COMP'  
        INNER JOIN AX_UDFVALUES (NOLOCK) ON ACTREL.target_ID = AX_UDFVALUES.UDF_InstanceID AND AX_UDFVALUES.METACODE_UCSID = @UDFieldID 
        AND AX_UDFVALUES.SEC_DefinitionID = @UDSectionID AND ACTREL.TYPECODE='COMP'    
        WHERE    
        (  
        (@RecordActID =-2147483648 OR GEACT.ID = @RecordActID)  
        AND  
        (  
        (@UDFieldType='10' AND AX_UDFVALUES.VALUESTRING = @UDFieldValue)  
        OR  
        (@UDFieldType <> '10' AND (AX_UDFVALUES.VALUE_UCSID = @UDFieldValue_UCSID))  
        )  
        
        ) 
        UNION  
        SELECT AX_GROUPEVENT.ID FROM AX_GROUPEVENT (NOLOCK)
        INNER JOIN A_ACT GEACT (NOLOCK) ON AX_GROUPEVENT.ID = GEACT.ID AND GEACT.statusCode NOT IN ('nullified','terminated')   
        WHERE AX_GROUPEVENT.UserDR = @UserDR AND (@RecordActID =-2147483648 OR AX_GROUPEVENT.ID = @RecordActID)  
    END
    --BLK END GROUP EVENT   
    
RETURN  
END 
