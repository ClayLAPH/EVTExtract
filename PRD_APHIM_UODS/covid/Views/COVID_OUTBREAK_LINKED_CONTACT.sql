CREATE VIEW covid.COVID_OUTBREAK_LINKED_CONTACT
AS
SELECT        TOP (100) PERCENT OUTB_RowID AS DVOB_RowID, ISNULL(CONT_LastName, '') + ', ' + ISNULL(CONT_FirstName, '') AS LinkedPatientContacts, CONT_RecordInstanceDR AS IncidentID, ISNULL(CONT_LastName, 
                         '') + ', ' + ISNULL(CONT_FirstName, '') + ' ' + CAST(CONT_RecordInstanceDR AS VARCHAR) AS concatenated
FROM            (SELECT        OUTB_RowID, CONT_RecordInstanceDR, CONT_LastName, CONT_FirstName
                          FROM            (SELECT DISTINCT 
                                                                              LPA_A1.source_ID AS OUTB_RowID, dbo.DV_PHPersonalRecord.DVPR_IncidentID AS CONT_RecordInstanceDR, LPA_C5.DVPER_LastName AS CONT_LastName, 
                                                                              LPA_C5.DVPER_FirstName AS CONT_FirstName
                                                    FROM            dbo.A_ActRelationship AS LPA_A1 WITH (nolock) INNER JOIN
                                                                              dbo.DV_PHPersonalRecord WITH (nolock) ON LPA_A1.target_ID = dbo.DV_PHPersonalRecord.DVPR_RowID INNER JOIN
                                                                              dbo.P_Participation AS LPA_P2 WITH (nolock) ON dbo.DV_PHPersonalRecord.DVPR_RowID = LPA_P2.Act_ID AND LPA_P2.typeCode = 'ind' INNER JOIN
                                                                              dbo.R_Role AS LPA_e3 WITH (nolock) ON LPA_e3.ID = LPA_P2.Role_ID AND LPA_e3.classCode = 'expr' INNER JOIN
                                                                              dbo.R_Role AS LPA_m4 WITH (nolock) ON LPA_m4.scoper_ID = LPA_e3.player_ID AND LPA_m4.classCode = 'mbr' AND LPA_m4.statusCode <> 'nullified' AND 
                                                                              LPA_m4.statusCode <> 'terminated' INNER JOIN
                                                                              dbo.DV_Person AS LPA_C5 WITH (nolock) ON LPA_C5.DVPER_RowID = LPA_m4.player_ID LEFT OUTER JOIN
                                                                              dbo.P_Participation AS LPA_P6 WITH (nolock) ON LPA_m4.ID = LPA_P6.Role_ID AND LPA_P6.typeCode = 'sbj' LEFT OUTER JOIN
                                                                              dbo.T_Attribute AS LPA_C7 WITH (nolock) ON LPA_C7.Act_ID = LPA_P6.Act_ID AND LPA_C7.name = 'rlent_clusterid' AND LPA_C7.type = 'st' LEFT OUTER JOIN
                                                                              dbo.T_Attribute AS LPA_C8 WITH (nolock) ON LPA_C8.Role_ID = LPA_m4.ID AND LPA_C8.name = 'rlent_contacttype' LEFT OUTER JOIN
                                                                              dbo.V_UnifiedCodeSet AS LPA_U9 WITH (nolock) ON LPA_U9.ID = LPA_C8.valueCode_ID
                                                    WHERE        (LPA_A1.source_ID IN
                                                                                  (SELECT        DVOB_RowID
                                                                                    FROM            dbo.DV_Outbreak
                                                                                    WHERE        (DVOB_DiseaseCode_ID IN (543030)))) AND (dbo.DV_PHPersonalRecord.DVPR_TypeDR IN (494681))) AS a
                          UNION
                          SELECT DISTINCT DV_Outbreak_2.DVOB_RowID AS OUTB_RowID, '' AS CONT_RecordInstanceDR, LPA_C4.DVPER_LastName AS CONT_LastName, LPA_C4.DVPER_FirstName AS CONT_FirstName
                          FROM            dbo.DV_Outbreak AS DV_Outbreak_2 WITH (nolock) INNER JOIN
                                                   dbo.P_Participation AS LPA_P1 WITH (nolock) ON DV_Outbreak_2.DVOB_RowID = LPA_P1.Act_ID AND LPA_P1.typeCode = 'ind' INNER JOIN
                                                   dbo.R_Role AS LPA_e2 WITH (nolock) ON LPA_e2.ID = LPA_P1.Role_ID AND LPA_e2.classCode = 'expr' INNER JOIN
                                                   dbo.R_Role AS LPA_m3 WITH (nolock) ON LPA_m3.scoper_ID = LPA_e2.player_ID AND LPA_m3.classCode = 'mbr' AND LPA_m3.statusCode <> 'nullified' AND 
                                                   LPA_m3.statusCode <> 'terminated' INNER JOIN
                                                   dbo.DV_Person AS LPA_C4 WITH (nolock) ON LPA_C4.DVPER_RowID = LPA_m3.player_ID LEFT OUTER JOIN
                                                   dbo.P_Participation AS LPA_P5 WITH (nolock) ON LPA_m3.ID = LPA_P5.Role_ID AND LPA_P5.typeCode = 'sbj' LEFT OUTER JOIN
                                                   dbo.T_Attribute AS LPA_C6 WITH (nolock) ON LPA_C6.Act_ID = LPA_P5.Act_ID AND LPA_C6.name = 'rlent_clusterid' AND LPA_C6.type = 'st' LEFT OUTER JOIN
                                                   dbo.T_Attribute AS LPA_C7 WITH (nolock) ON LPA_C7.Role_ID = LPA_m3.ID AND LPA_C7.name = 'rlent_contacttype' LEFT OUTER JOIN
                                                   dbo.V_UnifiedCodeSet AS LPA_U8 WITH (nolock) ON LPA_U8.ID = LPA_C7.valueCode_ID
                          WHERE        (DV_Outbreak_2.DVOB_RowID IN
                                                       (SELECT        DVOB_RowID
                                                         FROM            dbo.DV_Outbreak AS DV_Outbreak_1
                                                         WHERE        (DVOB_DiseaseCode_ID IN (543030))))) AS tmp
ORDER BY concatenated

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tmp"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 261
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'covid', @level1type = N'VIEW', @level1name = N'COVID_OUTBREAK_LINKED_CONTACT';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'covid', @level1type = N'VIEW', @level1name = N'COVID_OUTBREAK_LINKED_CONTACT';

