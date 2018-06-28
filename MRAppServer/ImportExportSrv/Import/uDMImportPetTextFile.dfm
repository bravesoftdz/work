inherited DMImportPetTextFile: TDMImportPetTextFile
  OldCreateOrder = True
  Left = 335
  Top = 225
  Height = 165
  Width = 223
  object cdsPetTreatment: TClientDataSet [0]
    Aggregates = <>
    Params = <>
    Left = 36
    Top = 16
    object cdsPetTreatmentSKU: TStringField
      FieldName = 'SKU'
      Size = 30
    end
    object cdsPetTreatmentMicrochip: TStringField
      FieldName = 'Microchip'
      Size = 50
    end
    object cdsPetTreatmentCollar: TStringField
      FieldName = 'Collar'
      Size = 50
    end
    object cdsPetTreatmentTreatment: TStringField
      FieldName = 'Treatment'
      Size = 50
    end
    object cdsPetTreatmentTreatmentType: TIntegerField
      FieldName = 'TreatmentType'
    end
    object cdsPetTreatmentMfg: TStringField
      FieldName = 'Mfg'
      Size = 50
    end
    object cdsPetTreatmentTreatmentLotSize: TIntegerField
      FieldName = 'TreatmentLotSize'
    end
    object cdsPetTreatmentLotNumber: TStringField
      FieldName = 'LotNumber'
      Size = 30
    end
    object cdsPetTreatmentLotExpirationDate: TDateTimeField
      FieldName = 'LotExpirationDate'
    end
    object cdsPetTreatmentIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object cdsPetTreatmentDosesUsed: TIntegerField
      FieldName = 'DosesUsed'
    end
    object cdsPetTreatmentTreatExpirationDate: TDateTimeField
      FieldName = 'TreatExpirationDate'
    end
    object cdsPetTreatmentTreatmentDate: TDateTimeField
      FieldName = 'TreatmentDate'
    end
    object cdsPetTreatmentNotes: TStringField
      FieldName = 'Notes'
      Size = 255
    end
    object cdsPetTreatmentSpecies: TStringField
      FieldName = 'Species'
      Size = 10
    end
  end
  inherited qryInsImportConfig: TADOQuery
    Left = 95
  end
end
