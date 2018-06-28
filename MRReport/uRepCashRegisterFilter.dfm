inherited RepCashRegisterFilter: TRepCashRegisterFilter
  Caption = 'RepCashRegisterFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDCashRegister'
    Properties.ListColumns = <
      item
        FieldName = 'CashRegister'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuCashRegister'
    RemoteServer = DMReport.LuMaintenanceConn
  end
end
