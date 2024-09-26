
CREATE   FUNCTION [dbo].[FN_HasRecordWriteAccess]    
    (@RecordActID int, @UserId INT, @DistrictGrpDR int, @DiseaseGrpDR int,@HasUserCreatedRecordAccessPermission bit
    , @PHType Varchar(50), @ApplyHistoricalJurisdictionSecurityFilter bit, @HasSecondaryJurisdictionWriteAccess bit=0)  
RETURNS BIT  
AS  
BEGIN  
    DECLARE @recordCount INT  
    SET @recordCount=0  
    DECLARE @DistrictMetaCode AS VARCHAR(200)

    SELECT @DistrictMetaCode = 
    CASE 
        WHEN @PHType = 'OB' THEN  'OB_DistrictDR'
        WHEN @PHType = 'AR' THEN 'AI_DistrictDR'
    ELSE NULL
    END 

    BEGIN --BLK CHECK FOR DISEASE GROUP RESTRICTION
        IF @DiseaseGrpDR>0 AND @PHType<>'GE'
        BEGIN  
            SELECT @recordCount=COUNT(*) FROM A_ACT (NOLOCK) WHERE ID = @RecordActID and CODE_ID IN (SELECT  valueCode_ID FROM V_CODEPROPERTY (NOLOCK)  WHERE V_CODEPROPERTY.PROPERTY='GRPD_DiseaseDR' AND V_CODEPROPERTY.subjCode_ID=@DiseaseGrpDR)  
            IF @DistrictGrpDR<0 and @recordCount>0  
            BEGIN  
                RETURN 1  
            END  
        END  
    END 

    BEGIN  --BLK CHECK FOR JURISDICTION RESTRICTION
        DECLARE @JurisdictionRecordCount BIGINT  
        SET @JurisdictionRecordCount=0  

        IF (@DistrictGrpDR>0)   
        BEGIN
            IF @PHType='GE'
            BEGIN
                SELECT TOP 1 @JurisdictionRecordCount =  AX_GroupEvent.[ID] FROM AX_GroupEvent (NOLOCK)
                INNER JOIN  V_CODEPROPERTY (NOLOCK) on V_CODEPROPERTY.[valueCode_ID] = AX_GroupEvent.DistrictDR 
                    AND V_CODEPROPERTY.PROPERTY='GRPD_DistrictDR' AND V_CODEPROPERTY.subjCode_ID=@DistrictGrpDR  
                WHERE AX_GroupEvent.[ID] = @RecordActID 
            END
            ELSE
            BEGIN
                IF @DistrictMetaCode IS NULL
                BEGIN
                    If @HasSecondaryJurisdictionWriteAccess=1
                    BEGIN
                        SELECT TOP 1 @JurisdictionRecordCount = [T_Attribute].[ID] FROM [T_Attribute] (NOLOCK)  
                        INNER JOIN  V_CODEPROPERTY (NOLOCK) on V_CODEPROPERTY.[valueCode_ID] = [T_Attribute].[valueCode_ID] 
                        AND V_CODEPROPERTY.PROPERTY='GRPD_DistrictDR' AND V_CODEPROPERTY.subjCode_ID=@DistrictGrpDR  
                        WHERE [Act_ID] = @RecordActID AND [T_Attribute].[name] IN('PR_DistrictDR','PR_SecondaryDistrictDR')
                    END                 
                    ELSE
                    BEGIN
                        SELECT TOP 1 @JurisdictionRecordCount = [T_Attribute].[ID] FROM [T_Attribute] (NOLOCK)  
                        INNER JOIN  V_CODEPROPERTY (NOLOCK) on V_CODEPROPERTY.[valueCode_ID] = [T_Attribute].[valueCode_ID] 
                        AND V_CODEPROPERTY.PROPERTY='GRPD_DistrictDR' AND V_CODEPROPERTY.subjCode_ID=@DistrictGrpDR  
                        WHERE [Act_ID] = @RecordActID AND [T_Attribute].[name] IN('PR_DistrictDR')
                    END
                END
                ELSE
                BEGIN
                    SELECT TOP 1 @JurisdictionRecordCount =  [T_Attribute].[ID] FROM [T_Attribute] (NOLOCK)  
                    INNER JOIN  V_CODEPROPERTY (NOLOCK) on V_CODEPROPERTY.[valueCode_ID] = [T_Attribute].[valueCode_ID] 
                    AND V_CODEPROPERTY.PROPERTY='GRPD_DistrictDR' AND V_CODEPROPERTY.subjCode_ID=@DistrictGrpDR  
                    WHERE [Act_ID] = @RecordActID AND [T_Attribute].[name] = @DistrictMetaCode
                END
            END
            IF @JurisdictionRecordCount>0  
            BEGIN  
                IF @DiseaseGrpDR > 0 AND @PHType<>'GE'
                BEGIN  
                    IF @recordCount > 0  
                    BEGIN  
                        RETURN 1  
                    END  
                END  
                ELSE  
                BEGIN  
                    RETURN 1  
                END  
            END  
        END  
    END

    BEGIN  --BLK CHECK FOR CREATED RECORD ACCESS 
        IF @HasUserCreatedRecordAccessPermission=1  
        BEGIN
            IF @PHType='GE'
            BEGIN
                IF EXISTS(SELECT TOP 1 AX_GroupEvent.ID FROM AX_GroupEvent (NOLOCK)  
                WHERE  AX_GroupEvent.ID=@RecordActID AND AX_GroupEvent.UserDR=@UserId)  
                BEGIN  
                    RETURN 1  
                END 
            END
            ELSE
            BEGIN
                IF EXISTS(SELECT TOP 1 [P_Participation].ID FROM [P_Participation] (NOLOCK)  
                INNER JOIN [R_Role] (NOLOCK) ON [R_Role].[ID]=[P_Participation].[Role_ID] AND  [R_Role].[classCode] = 'AGNT'  
                WHERE  [P_Participation].Act_Id=@RecordActID AND [P_Participation].[typeCode] = 'AUT' and [R_Role].Player_Id=@UserId)  
                BEGIN  
                    RETURN 1  
                END  
            END
        END  
    END
    IF @PHType IN('DI','CI')
    BEGIN
        BEGIN  --BLK CHECK AUDIT ACCESS LOG 
            IF EXISTS(SELECT TOP 1 [P_Participation].ID FROM [P_Participation] (NOLOCK)  
            INNER JOIN [R_Role] (NOLOCK) ON [R_Role].[ID]=[P_Participation].[Role_ID] AND  [R_Role].[classCode] = 'AGNT'  
            INNER JOIN S_LINK SLCASE (NOLOCK) ON SLCASE.ACT1_ID=[P_Participation].Act_Id AND SLCASE.NAME='Patient-Case'  
            INNER JOIN S_AUDITMAIN SAUDITACCESSLOG (NOLOCK) ON SAUDITACCESSLOG.FORMNAME='IncidentAccessLog' AND SAUDITACCESSLOG.SQLACTION='Access' AND  SAUDITACCESSLOG.USERID=@UserId  
            WHERE  [P_Participation].Act_Id=@RecordActID AND [P_Participation].[typeCode] = 'AUT' AND SAUDITACCESSLOG.ENTITYID=SLCASE.ENTITY1_ID)  
            BEGIN  
                RETURN 1  
            END  
        END 
        BEGIN --BLK CHECK HISTORICAL INCIDENT READ WRITE ACCESS
            IF @ApplyHistoricalJurisdictionSecurityFilter=1 AND @DistrictGrpDR>0  
            BEGIN  
                IF ISNULL((SELECT TOP 1 HistoricalIncidentWriteAccess FROM A_ACT (NOLOCK) INNER JOIN VCP_DISEASE (NOLOCK) ON VCP_DISEASE.SUBJCODE_ID=A_ACT.[code_ID] WHERE A_ACT.ID=@RecordActID),0)=1  
                BEGIN  
                    IF EXISTS(SELECT TOP 1 [S_AUDITMAIN].ID FROM S_AUDITMAIN  (NOLOCK)   
                    INNER JOIN S_AUDITDETAIL  (NOLOCK) ON S_AUDITMAIN.ID=S_AUDITDETAIL.AUDITID AND S_AUDITDETAIL.COLUMNNAME='PR_DistrictDR'  
                    WHERE S_AUDITMAIN.RECORDID =CAST(@RecordActID AS VARCHAR(20)) 
                    AND CAST(OLDVALUE AS VARCHAR(50)) 
                    IN (SELECT CAST(valueCode_ID AS VARCHAR(20)) FROM V_CODEPROPERTY (NOLOCK)  WHERE [V_CODEPROPERTY].PROPERTY='GRPD_DistrictDR' 
                    AND V_CODEPROPERTY.subjCode_ID=@DistrictGrpDR))  
                    BEGIN  
                        RETURN 1  
                    END  
                END  
            END  
        END
    END
    RETURN 0  
END  
