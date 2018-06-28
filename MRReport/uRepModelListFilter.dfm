inherited RepModelListFilter: TRepModelListFilter
  Left = 296
  Top = 212
  Caption = 'RepModelListFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDModel'
    Properties.ListColumns = <
      item
        FieldName = 'ModelDesc'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuModel'
    RemoteServer = DMReport.LuInventoryConn
  end
end
