inherited RepMediaListFilter: TRepMediaListFilter
  Left = 216
  Top = 283
  Caption = 'RepMediaListFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDMedia'
    Properties.ListColumns = <
      item
        FieldName = 'Media'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuMedia'
    RemoteServer = DMReport.LuMaintenanceConn
  end
end
