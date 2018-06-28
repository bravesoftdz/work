object DMPetCenter: TDMPetCenter
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 298
  Top = 218
  Height = 357
  Width = 447
  object cxStyleController: TcxEditStyleController
    Style.BorderStyle = ebsFlat
    Left = 36
    Top = 20
  end
  object cdsRepWarranty: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspWarrantyRep'
    RemoteServer = DMPet.PetCenterConn
    Left = 52
    Top = 76
    object cdsRepWarrantyIDWarrantyReport: TIntegerField
      FieldName = 'IDWarrantyReport'
    end
    object cdsRepWarrantyIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
    end
    object cdsRepWarrantyReport: TBlobField
      FieldName = 'Report'
    end
    object cdsRepWarrantyReportDate: TDateTimeField
      FieldName = 'ReportDate'
    end
    object cdsRepWarrantyReportName: TStringField
      FieldName = 'ReportName'
      Size = 30
    end
  end
  object cdsLoadRepWarranty: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspWarrantyRep'
    RemoteServer = DMPet.PetCenterConn
    BeforeGetRecords = cdsLoadRepWarrantyBeforeGetRecords
    Left = 52
    Top = 140
    object cdsLoadRepWarrantyIDWarrantyReport: TIntegerField
      FieldName = 'IDWarrantyReport'
    end
    object cdsLoadRepWarrantyIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
    end
    object cdsLoadRepWarrantyReport: TBlobField
      FieldName = 'Report'
    end
    object cdsLoadRepWarrantyReportDate: TDateTimeField
      FieldName = 'ReportDate'
    end
    object cdsLoadRepWarrantyReportName: TStringField
      FieldName = 'ReportName'
      Size = 30
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
    Left = 154
    Top = 25
  end
  object cdsSpecies: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSpecies'
    RemoteServer = DMPet.PetCenterConn
    Left = 52
    Top = 204
    object cdsSpeciesIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsSpeciesSpecies: TStringField
      FieldName = 'Species'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
  end
end
