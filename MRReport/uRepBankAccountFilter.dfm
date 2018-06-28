inherited RepBankAccountFilter: TRepBankAccountFilter
  Left = 322
  Top = 209
  Caption = 'RepBankAccountFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDContaCorrente'
    Properties.ListColumns = <
      item
        FieldName = 'Numero'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspBankAccount'
    RemoteServer = DMReport.LuMaintenanceConn
  end
end
