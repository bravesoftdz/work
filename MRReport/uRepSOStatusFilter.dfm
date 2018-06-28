inherited RepSOStatusFilter: TRepSOStatusFilter
  Left = 227
  Top = 273
  Caption = 'RepSOStatusFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblFilter: TLabel
    Left = 99
    Width = 38
    Caption = 'Status :'
  end
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDSOStatus'
    Properties.ListColumns = <
      item
        FieldName = 'SOStatus'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuSOStatus'
    RemoteServer = DMReport.LuSOConn
  end
end
