CREATE   VIEW VW_ReportSource
AS SELECT [E_Entity].[ID] AS [RS_RowID], 
          [tname].[trivialName] AS [RS_Name], 
          ISNULL([attlock].[valueBool], 0) AS [RS_IsLocked], 
          [attlock].[ID] AS [RS_IsLockedRecord_AttributeID],
		  [attupdate].updateTime as [RS_UpdateTime]
   FROM [E_Entity](NOLOCK)
        INNER JOIN [T_EntityName] tname(NOLOCK) ON [tname].[Entity_ID] = E_Entity.ID
		INNER JOIN [T_Attribute] attupdate(NOLOCK) ON [attupdate].[Entity_ID] = E_Entity.ID AND [attupdate].[name] = 'RS_LastUpdatedDateTime'
        LEFT JOIN [T_Attribute] attlock(NOLOCK) ON ATTLOCK.Entity_ID = [E_Entity].[ID]
                                                   AND attlock.[name] = 'RS_IsLockedRecord'
   WHERE [E_Entity].[metaCode] = 'RS_RowID'
        -- AND [E_Entity].[statusCode] = 'active'

