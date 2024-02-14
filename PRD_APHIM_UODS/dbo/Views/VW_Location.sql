
CREATE   VIEW VW_Location
AS SELECT [E_Entity].[ID] AS [LOC_RowID], 
          [tname].[trivialName] AS [LOC_Name], 
          ISNULL([attlock].[valueBool], 0) AS [LOC_IsLocked], 
          [attlock].[ID] AS [LOC_IsLockedRecord_AttributeID],
		  [attupdate].updateTime as [LOC_UpdateTime]
   FROM [E_Entity](NOLOCK)
        INNER JOIN [T_EntityName] tname(NOLOCK) ON [tname].[Entity_ID] = E_Entity.ID
		INNER JOIN [T_Attribute] attupdate(NOLOCK) ON [attupdate].[Entity_ID] = E_Entity.ID AND [attupdate].[name] = 'LOC_LastUpdatedDateTime'
        LEFT JOIN [T_Attribute] attlock(NOLOCK) ON ATTLOCK.Entity_ID = [E_Entity].[ID]
                                                   AND attlock.[name] = 'LOC_IsLockedRecord'
   WHERE [E_Entity].[metaCode] = 'LOC_RowID'
        -- AND [E_Entity].[statusCode] = 'active'

