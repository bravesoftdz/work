object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 261
  Top = 145
  Height = 485
  Width = 610
  object cdsAdvertising: TClientDataSet
    Aggregates = <>
    Params = <>
    OnCalcFields = cdsAdvertisingCalcFields
    OnNewRecord = cdsAdvertisingNewRecord
    Left = 66
    Top = 40
    object cdsAdvertisingID: TIntegerField
      FieldName = 'ID'
    end
    object cdsAdvertisingDescription: TStringField
      FieldName = 'Description'
      Required = True
      Size = 255
    end
    object cdsAdvertisingFileName: TStringField
      FieldName = 'FileName'
      Required = True
      Size = 255
    end
    object cdsAdvertisingStartDate: TDateTimeField
      FieldName = 'StartDate'
      DisplayFormat = 'ddddd'
    end
    object cdsAdvertisingEndDate: TDateTimeField
      FieldName = 'EndDate'
      DisplayFormat = 'ddddd'
    end
    object cdsAdvertisingDaysOfWeek: TStringField
      FieldName = 'DaysOfWeek'
      Size = 15
    end
    object cdsAdvertisingDaysOfWeekString: TStringField
      FieldKind = fkCalculated
      FieldName = 'DaysOfWeekString'
      Size = 100
      Calculated = True
    end
    object cdsAdvertisingType: TIntegerField
      FieldName = 'Type'
      Required = True
    end
    object cdsAdvertisingTypeString: TStringField
      FieldKind = fkCalculated
      FieldName = 'TypeString'
      Size = 50
      Calculated = True
    end
    object cdsAdvertisingDuration: TIntegerField
      FieldName = 'Duration'
      Required = True
    end
    object cdsAdvertisingVideoControl: TBooleanField
      FieldName = 'VideoControl'
    end
    object cdsAdvertisingDisplayDescription: TBooleanField
      FieldName = 'DisplayDescription'
    end
    object cdsAdvertisingHours: TStringField
      FieldName = 'Hours'
      Size = 100
    end
  end
  object cdsPoleDisplayClient: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 476
    Top = 45
    object cdsPoleDisplayClientID: TFloatField
      FieldName = 'ID'
    end
    object cdsPoleDisplayClientDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsPoleDisplayClientIPAddress: TStringField
      FieldName = 'IPAddress'
      Size = 15
    end
    object cdsPoleDisplayClientPort: TIntegerField
      FieldName = 'Port'
    end
  end
  object cdsCrossSaleItem: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 66
    Top = 175
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
  object IdTCPServer: TIdTCPServer
    Bindings = <>
    CommandHandlers = <>
    DefaultPort = 0
    Greeting.NumericCode = 0
    MaxConnectionReply.NumericCode = 0
    OnConnect = IdTCPServerConnect
    OnExecute = IdTCPServerExecute
    OnDisconnect = IdTCPServerDisconnect
    OnException = IdTCPServerException
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    Left = 66
    Top = 93
  end
  object cdsCrossSaleItemHistory: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 65
    Top = 220
    object cdsCrossSaleItemHistoryModel: TStringField
      FieldName = 'Model'
      Size = 40
    end
    object cdsCrossSaleItemHistoryRegister: TStringField
      FieldName = 'Register'
      Size = 50
    end
    object cdsCrossSaleItemHistoryItemDate: TDateTimeField
      FieldName = 'ItemDate'
    end
  end
end
