inherited DMImport: TDMImport
  OldCreateOrder = True
  Left = 207
  Top = 192
  Width = 435
  inherited LanguageDispatcher: TsiLangDispatcher
    Left = 40
    Top = 12
  end
  inherited imgSmall: TImageList
    Left = 40
    Top = 60
  end
  inherited imgLarge: TImageList
    Left = 40
    Top = 108
  end
  inherited imgPayments: TImageList
    Left = 40
    Top = 156
  end
  inherited DCOMConn: TDCOMConnection
    ServerGUID = '{572F6870-260E-4D79-8E86-63F8F0BA0948}'
    ServerName = 'MRAppServer.RDMApplicationHub'
    Left = 128
    Top = 12
  end
  inherited SocketConn: TSocketConnection
    Left = 128
    Top = 60
  end
  inherited WebConn: TWebConnection
    Left = 128
    Top = 108
  end
  object ImportConn: TSharedConnection
    ChildName = 'RDMImporteExport'
    Left = 228
    Top = 24
  end
  object cdsLookupStore: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspLookupStore'
    RemoteServer = ImportConn
    Left = 228
    Top = 72
  end
  object dtsLookupStore: TDataSource
    DataSet = cdsLookupStore
    Left = 228
    Top = 120
  end
  object cdsLookupVendor: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspLookupVendor'
    RemoteServer = ImportConn
    Left = 316
    Top = 76
  end
  object dtsLookupVendor: TDataSource
    DataSet = cdsLookupVendor
    Left = 316
    Top = 124
  end
  object cdsLookupUser: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspLookupUser'
    RemoteServer = ImportConn
    Left = 228
    Top = 172
  end
  object dtsLookupUser: TDataSource
    DataSet = cdsLookupUser
    Left = 228
    Top = 220
  end
end
