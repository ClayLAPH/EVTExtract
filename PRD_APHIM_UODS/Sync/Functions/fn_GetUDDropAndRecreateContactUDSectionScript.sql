
/****** Object:  UserDefinedFunction [Sync].[fn_GetUDDropAndRecreateContactUDSectionScript]    Script Date: 2/26/2016 5:52:44 PM ******/
Create Function [Sync].[fn_GetUDDropAndRecreateContactUDSectionScript](@ContactSystemSectionDR Int, @DiseaseDR Int, @ContactUDSectionDR Int=NULL)
    Returns Varchar(max)
As
Begin

    declare @SAR as bit
    declare @SAP as bit

    select @SAP= ISnull(SEC_ShareAcrossPerson,0), @SAR = ISnull(SEC_ShareAcrossRecord,0) from VCP_UDSection (NOLOCK) where SubjCode_ID = @ContactSystemSectionDR
    
    Declare @StoredProcedureName as Varchar(500)

    set @StoredProcedureName = Sync.fn_GetUDFSectionSPNameToExecuteInSSIS(@ContactSystemSectionDR, @SAP, @SAR)
    
    set @StoredProcedureName = @StoredProcedureName + '_' + CONVERT(varchar(10), @DiseaseDR)    -- Modified after discussing with Shreeram

    Declare @DropRecreateScript as Varchar(max)

    set @DropRecreateScript = Sync.fn_GetUDDropScript(@StoredProcedureName)

    If @ContactUDSectionDR is not null
    BEGIN
        set @DropRecreateScript = @DropRecreateScript + Sync.fn_GetUDCreateScript(@ContactSystemSectionDR, @StoredProcedureName, @ContactUDSectionDR)
    END
    Return @DropRecreateScript
END



