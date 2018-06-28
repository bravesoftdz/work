inherited RepSOStatusListFilter: TRepSOStatusListFilter
  Left = 267
  Top = 245
  Caption = 'RepSOStatusListFilter'
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
