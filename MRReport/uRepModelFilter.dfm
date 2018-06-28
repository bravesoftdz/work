inherited RepModelFilter: TRepModelFilter
  Caption = 'RepModelFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblFilter: TLabel
    Left = 102
    Width = 35
    Caption = 'Model :'
  end
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDModel'
    Properties.ListColumns = <
      item
        FieldName = 'Description'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuModel'
    RemoteServer = DMReport.LuInventoryConn
  end
end
