object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 182
  Top = 137
  Height = 465
  Width = 513
  object cdsAdvertising: TClientDataSet
    Aggregates = <>
    Params = <>
    OnCalcFields = cdsAdvertisingCalcFields
    Left = 56
    Top = 40
    object cdsAdvertisingID: TIntegerField
      FieldName = 'ID'
    end
    object cdsAdvertisingDescription: TStringField
      FieldName = 'Description'
      ProviderFlags = [pfInUpdate]
      Size = 255
    end
    object cdsAdvertisingFileName: TStringField
      FieldName = 'FileName'
      ProviderFlags = [pfInUpdate]
      Size = 255
    end
    object cdsAdvertisingStartDate: TDateTimeField
      FieldName = 'StartDate'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = 'ddddd'
    end
    object cdsAdvertisingEndDate: TDateTimeField
      FieldName = 'EndDate'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = 'ddddd'
    end
    object cdsAdvertisingDaysOfWeek: TStringField
      FieldName = 'DaysOfWeek'
      ProviderFlags = [pfInUpdate]
      Size = 15
    end
    object cdsAdvertisingDaysOfWeekString: TStringField
      FieldKind = fkCalculated
      FieldName = 'DaysOfWeekString'
      ProviderFlags = [pfInUpdate]
      Size = 100
      Calculated = True
    end
    object cdsAdvertisingType: TIntegerField
      FieldName = 'Type'
      ProviderFlags = [pfInUpdate]
    end
    object cdsAdvertisingTypeString: TStringField
      FieldKind = fkCalculated
      FieldName = 'TypeString'
      ProviderFlags = [pfInUpdate]
      Size = 50
      Calculated = True
    end
    object cdsAdvertisingDuration: TIntegerField
      FieldName = 'Duration'
      ProviderFlags = [pfInUpdate]
    end
    object cdsAdvertisingVideoControl: TBooleanField
      FieldName = 'VideoControl'
      ProviderFlags = [pfInUpdate]
    end
    object cdsAdvertisingDisplayDescription: TBooleanField
      FieldName = 'DisplayDescription'
      ProviderFlags = [pfInUpdate]
    end
    object cdsAdvertisingHours: TStringField
      FieldName = 'Hours'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
  end
  object IdTCPClient: TIdTCPClient
    MaxLineAction = maException
    ReadTimeout = 0
    Port = 0
    Left = 54
    Top = 105
  end
  object tmrSyncAdv: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = tmrSyncAdvTimer
    Left = 55
    Top = 170
  end
  object cdsSaleSuggestion: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 288
    Top = 176
    object cdsSaleSuggestionFileName: TStringField
      FieldName = 'FileName'
      Size = 255
    end
    object cdsSaleSuggestionFileType: TIntegerField
      FieldName = 'FileType'
    end
    object cdsSaleSuggestionDuration: TIntegerField
      FieldName = 'Duration'
    end
  end
  object cdsCrossSaleItem: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 176
    Top = 63
    object cdsCrossSaleItemID: TIntegerField
      FieldName = 'ID'
    end
    object cdsCrossSaleItemModelNum: TStringField
      FieldName = 'ModelNum'
      Size = 30
    end
    object cdsCrossSaleItemModelCategory: TStringField
      FieldName = 'ModelCategory'
      Size = 30
    end
    object cdsCrossSaleItemModelSubCategory: TStringField
      FieldName = 'ModelSubCategory'
      Size = 30
    end
    object cdsCrossSaleItemModelGroup: TStringField
      FieldName = 'ModelGroup'
      Size = 30
    end
    object cdsCrossSaleItemFileName: TStringField
      FieldName = 'FileName'
      Size = 255
    end
    object cdsCrossSaleItemFileType: TIntegerField
      FieldName = 'FileType'
    end
    object cdsCrossSaleItemDuration: TIntegerField
      FieldName = 'Duration'
    end
    object cdsCrossSaleItemCrossDescription: TStringField
      FieldName = 'CrossDescription'
      Size = 100
    end
    object cdsCrossSaleItemCrossSalePrice: TCurrencyField
      FieldName = 'CrossSalePrice'
      DisplayFormat = '#,##0.00'
    end
  end
end
