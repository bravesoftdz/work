inherited DMReport: TDMReport
  Left = 207
  Top = 159
  Height = 542
  Width = 728
  inherited SocketConn: TSocketConnection
    Host = 'desenv004'
  end
  object ReportConn: TSharedConnection
    ParentConnection = DCOMConn
    ChildName = 'RDMReport'
    Left = 200
    Top = 104
  end
  object LuInventoryConn: TSharedConnection
    ParentConnection = DCOMConn
    ChildName = 'RDMLookupInventory'
    Left = 200
    Top = 152
  end
  object LuMaintenanceConn: TSharedConnection
    ParentConnection = DCOMConn
    ChildName = 'RDMLookupMaintenance'
    Left = 200
    Top = 204
  end
  object LuPurchaseConn: TSharedConnection
    ParentConnection = DCOMConn
    ChildName = 'RDMLookupPurchase'
    Left = 308
    Top = 104
  end
  object LuPetConn: TSharedConnection
    ParentConnection = DCOMConn
    ChildName = 'RDMLookUpPet'
    Left = 308
    Top = 152
  end
  object LuSOConn: TSharedConnection
    ParentConnection = DCOMConn
    ChildName = 'RDMLookUpSO'
    Left = 308
    Top = 204
  end
end
