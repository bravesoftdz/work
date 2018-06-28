inherited DMGlobalNTier: TDMGlobalNTier
  OldCreateOrder = True
  object DCOMConn: TDCOMConnection
    ServerGUID = '{572F6870-260E-4D79-8E86-63F8F0BA0948}'
    ServerName = 'MRAppServer.RDMApplicationHub'
    Left = 88
    Top = 104
  end
  object SocketConn: TSocketConnection
    ServerGUID = '{572F6870-260E-4D79-8E86-63F8F0BA0948}'
    ServerName = 'MRAppServer.RDMApplicationHub'
    Host = 'desenv003'
    Left = 88
    Top = 152
  end
  object WebConn: TWebConnection
    Agent = 'DataSnap'
    URL = 'http://server.company.com/scripts/httpsrvr.dll'
    Left = 88
    Top = 204
  end
end
