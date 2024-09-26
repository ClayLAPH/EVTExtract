
CREATE Function [dbo].[FN_GetStartingNumericCharacters]
 (@string varchar(100))
 Returns Varchar(100)
As
Begin
 
 Declare @return varchar(50)
 SET @return = [dbo].[Split](@string, '||', 1)

if (IsNumeric(@return)=1)
	Return @return
 	
Return NULL
End

