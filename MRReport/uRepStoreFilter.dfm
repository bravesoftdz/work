inherited RepStoreFilter: TRepStoreFilter
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  BorderStyle = bsSingle
  Caption = 'RepStoreFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblFilter: TLabel
    Left = 99
    Top = 8
    Width = 33
    Caption = 'Store :'
  end
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDStore'
    Properties.ListColumns = <
      item
        FieldName = 'Store'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuStore'
    RemoteServer = DMReport.LuMaintenanceConn
  end
end
