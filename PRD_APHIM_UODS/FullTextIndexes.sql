CREATE FULLTEXT INDEX ON [dbo].[Ax_LabReport]
    ([DILR_TestCode] LANGUAGE 1033, [DILR_LocalTestCode] LANGUAGE 1033, [DILR_LocalTestDescription] LANGUAGE 1033, [DILR_OrganismCode] LANGUAGE 1033, [DILR_OrganismDescription] LANGUAGE 1033, [DILR_LocalOrganismCode] LANGUAGE 1033, [DILR_LocalOrganismDescription] LANGUAGE 1033, [DILR_ResultValue] LANGUAGE 1033, [DILR_ResultUnit] LANGUAGE 1033, [DILR_PerformingFacilityID] LANGUAGE 1033, [DILR_ProviderName] LANGUAGE 1033, [DILR_ProviderID] LANGUAGE 1033, [DILR_FacilityName] LANGUAGE 1033, [DILR_FacilityID] LANGUAGE 1033, [DILR_SpecimenSourceText] LANGUAGE 1033, [DILR_ResultTest] LANGUAGE 1033, [DILR_ProviderPhoneAlphaUp] LANGUAGE 1033, [DILR_FacilityPhoneAlphaUp] LANGUAGE 1033, [DILR_RelevantClinicalInformation] LANGUAGE 1033, [DILR_ReasonForStudy] LANGUAGE 1033)
    KEY INDEX [Ax_LabReport_PK]
    ON [AX_LabReport_Text_Cat];


GO
CREATE FULLTEXT INDEX ON [dbo].[Ax_UDFValues]
    ([VALUESTRING] LANGUAGE 1033)
    KEY INDEX [S_UDFValues_PK]
    ON [AX_UdfValues_Text_Cat];

