
CREATE FUNCTION [dbo].[FN_GeneratePassCode](@passcodeLength int)
RETURNS varchar(max)
AS
BEGIN
    Declare @passcode varchar(max)
    ;with CE AS(select TOP(@passcodeLength) [value] from string_split('2,S,T,U,V,W,X,Y,Z,3,4,A,C,D,E,F,G,H,5,6,Z,K,M,N,7,9,P,Q,R',',') order by (SELECT CHECKSUM(RANDOM_ID) FROM [AtlasInternal].[VIEW_GetNewID]))
    SELECT @passcode = REPLACE([dbo].STRCONCAT([value]),', ','') FROM CE
    return @passcode
END

