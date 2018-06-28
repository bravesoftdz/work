inherited DMPet: TDMPet
  Left = 326
  Top = 163
  Height = 483
  Width = 592
  object PetCenterConn: TSharedConnection
    ChildName = 'RDMPetCenter'
    Left = 216
    Top = 140
  end
  object MaintenanceConn: TSharedConnection
    ChildName = 'RDMMaintenance'
    Left = 216
    Top = 260
  end
  object LookUpMaintenanceConn: TSharedConnection
    ChildName = 'RDMLookupMaintenance'
    Left = 336
    Top = 258
  end
  object LookUpPetConn: TSharedConnection
    ChildName = 'RDMLookupPet'
    Left = 404
    Top = 138
  end
  object SearchPetConn: TSharedConnection
    ChildName = 'RDMSearchPet'
    Left = 308
    Top = 138
  end
  object cdsPropertyDomain: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPropertDomain'
    RemoteServer = MaintenanceConn
    Left = 88
    Top = 264
    object cdsPropertyDomainProperty: TStringField
      FieldName = 'Property'
      Size = 255
    end
    object cdsPropertyDomainPropertyValue: TStringField
      FieldName = 'PropertyValue'
      Size = 255
    end
  end
  object LookUpInventoryConn: TSharedConnection
    ChildName = 'RDMLookupInventory'
    Left = 336
    Top = 324
  end
  object ReportConn: TSharedConnection
    ChildName = 'RDMReport'
    Left = 212
    Top = 328
  end
  object cdsSysModule: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSysModule'
    RemoteServer = MaintenanceConn
    Left = 88
    Top = 324
    object cdsSysModuleModuleInfo: TStringField
      FieldName = 'ModuleInfo'
      Size = 255
    end
    object cdsSysModuleVersionNo: TIntegerField
      FieldName = 'VersionNo'
    end
    object cdsSysModuleBuildNo: TIntegerField
      FieldName = 'BuildNo'
    end
    object cdsSysModuleSeats: TStringField
      FieldName = 'Seats'
      Size = 50
    end
    object cdsSysModuleVersionType: TStringField
      FieldName = 'VersionType'
      Size = 15
    end
    object cdsSysModuleRestricForms: TMemoField
      FieldName = 'RestricForms'
      BlobType = ftMemo
    end
  end
  object cdsParam: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspParam'
    RemoteServer = MaintenanceConn
    Left = 88
    Top = 380
    object cdsParamIDParam: TIntegerField
      FieldName = 'IDParam'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsParamSrvParameter: TStringField
      FieldName = 'SrvParameter'
      Size = 40
    end
    object cdsParamSrvValue: TStringField
      FieldName = 'SrvValue'
      Size = 30
    end
    object cdsParamSrvType: TStringField
      FieldName = 'SrvType'
      FixedChar = True
      Size = 10
    end
    object cdsParamIDMenu: TIntegerField
      FieldName = 'IDMenu'
    end
  end
end
