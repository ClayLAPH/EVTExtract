CREATE FUNCTION [dbo].[TVFN_GET_AUDIT_TRANS_BY_NameAndAction] 
(
    @FormName varchar(50),
    @TableName varchar(50),
    @sqlAction varchar(50)
)
RETURNS 
@Table_Var TABLE 
(
     InstanceID int
    ,ActionDate datetime 
    ,UserID int
    ,Unique nonclustered (InstanceID)
)
AS
BEGIN
    IF @FormName <> '' and @TableName <> ''
    BEGIN
        INSERT INTO @TABLE_VAR 
        SELECT  SAUDITMAIN.InstanceID, SAUDITMAIN.ACTIONDATE, SAUDITMAIN.USERID 
        FROM (SELECT RANK() OVER(PARTITION  BY CAST(SAM.InstanceID AS INT) ORDER BY  SAM.RecordID, SAM.ACTIONDATE DESC) AS [RANK], 
        SAM.ID, CAST(SAM.InstanceID AS INT) AS InstanceID , SAM.ACTIONDATE, SAM.USERID, SAM.sqlAction 
        FROM S_AuditMain SAM (NOLOCK) 
        WHERE SAM.FormName=@FormName AND SAM.TableName=@TableName AND SAM.sqlAction=@sqlAction 
        AND (len( SAM.InstanceID) < 10 AND CONVERT(VARBINARY(10), upper( SAM.InstanceID) ) = 
        CONVERT(VARBINARY(10), lower( SAM.InstanceID)))) SAUDITMAIN 
        WHERE [RANK] = 1 
    END    
    
    else IF @FormName <> '' 
    BEGIN
        INSERT INTO @TABLE_VAR 
        SELECT  SAUDITMAIN.InstanceID, SAUDITMAIN.ACTIONDATE, SAUDITMAIN.USERID 
        FROM (SELECT RANK() OVER(PARTITION  BY CAST(SAM.InstanceID AS INT) ORDER BY  SAM.RecordID, SAM.ACTIONDATE DESC) AS [RANK], 
        SAM.ID, CAST(SAM.InstanceID AS INT) AS InstanceID , SAM.ACTIONDATE, SAM.USERID, SAM.sqlAction 
        FROM S_AuditMain SAM (NOLOCK) 
        WHERE  SAM.FormName=@FormName AND SAM.sqlAction=@sqlAction 
        AND (len( SAM.InstanceID) < 10 AND CONVERT(VARBINARY(10), upper( SAM.InstanceID) ) = 
        CONVERT(VARBINARY(10), lower( SAM.InstanceID)))) SAUDITMAIN 
        WHERE [RANK] = 1 
    END 

    ELSE IF  @TableName <> ''
    BEGIN
        INSERT INTO @TABLE_VAR 
        SELECT  SAUDITMAIN.InstanceID, SAUDITMAIN.ACTIONDATE, SAUDITMAIN.USERID 
        FROM (SELECT RANK() OVER(PARTITION  BY CAST(SAM.InstanceID AS INT) ORDER BY  SAM.RecordID, SAM.ACTIONDATE DESC) AS [RANK], 
        SAM.ID, CAST(SAM.InstanceID AS INT) AS InstanceID , SAM.ACTIONDATE, SAM.USERID, SAM.sqlAction 
        FROM S_AuditMain SAM (NOLOCK) 
        WHERE SAM.TableName=@TableName AND SAM.sqlAction=@sqlAction 
        AND (len( SAM.InstanceID) < 10 AND CONVERT(VARBINARY(10), upper( SAM.InstanceID) ) = 
        CONVERT(VARBINARY(10), lower( SAM.InstanceID)))) SAUDITMAIN 
        WHERE [RANK] = 1 
    END         
    RETURN 
END

