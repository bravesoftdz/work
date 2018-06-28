inherited RepCommissiontFilter: TRepCommissiontFilter
  Left = 321
  Top = 164
  Caption = 'RepCommissiontFilter'
  ClientHeight = 30
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDPessoa'
    Properties.ListColumns = <
      item
        FieldName = 'Pessoa'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuCommission'
    RemoteServer = DMReport.LuMaintenanceConn
  end
end
