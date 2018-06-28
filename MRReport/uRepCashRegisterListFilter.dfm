inherited RepCashRegisterListFilter: TRepCashRegisterListFilter
  Caption = 'RepCashRegisterListFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited btAddAll: TSpeedButton
    Left = 339
  end
  inherited btAdd: TSpeedButton
    Left = 339
  end
  inherited btRemove: TSpeedButton
    Left = 339
  end
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
