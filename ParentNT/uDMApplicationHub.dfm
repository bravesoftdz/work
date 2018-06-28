object DMApplicationHub: TDMApplicationHub
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 217
  Width = 242
  object conDCOM: TDCOMConnection
    ServerName = 'AppServer.ApplicationHubRData'
    ComputerName = 'rtserver'
    Left = 56
    Top = 32
  end
  object conTeste: TSharedConnection
    ParentConnection = conDCOM
    ChildName = 'TesteRData'
    Left = 152
    Top = 32
  end
  object conSocket: TSocketConnection
    ServerGUID = '{A38E96E1-4588-436D-BEB9-CAC794598A32}'
    ServerName = 'AppServer.ApplicationHubRData'
    Host = 'retail002'
    Left = 56
    Top = 88
  end
  object conWeb: TWebConnection
    ServerGUID = '{A38E96E1-4588-436D-BEB9-CAC794598A32}'
    ServerName = 'AppServer.ApplicationHubRData'
    Agent = 'DataSnap'
    URL = 'http://server.company.com/scripts/httpsrvr.dll'
    Left = 56
    Top = 144
  end
  object conLookup: TSharedConnection
    ParentConnection = conDCOM
    ChildName = 'LookupRData'
    Left = 152
    Top = 88
  end
  object scEdit: TcxEditStyleController
    Left = 152
    Top = 148
  end
end
