
/****** Object:  UserDefinedFunction [Sync].[fn_GetUDDropAndRecreateScript]    Script Date: 2/26/2016 5:54:47 PM ******/
Create Function [Sync].[fn_GetUDDropAndRecreateScript](@SectionDR Int)
    Returns Varchar(max)
As
Begin

    declare @SAR as bit
    declare @SAP as bit

    select @SAP= ISnull(SEC_ShareAcrossPerson,0), @SAR = ISnull(SEC_ShareAcrossRecord,0) from VCP_UDSection (nolock) where subjcode_id = @SectionDR
    
    Declare @StoredProcedureName as Varchar(500)

    set @StoredProcedureName = Sync.fn_GetUDFSectionSPNameToExecuteInSSIS(@SectionDR, @SAP, @SAR)

    Declare @DropRecreateScript as Varchar(max)

    set @DropRecreateScript = Sync.fn_GetUDDropScript(@StoredProcedureName)


    set @DropRecreateScript = @DropRecreateScript + Sync.fn_GetUDCreateScript(@SectionDR, @StoredProcedureName, NULL)

    Return @DropRecreateScript
END
