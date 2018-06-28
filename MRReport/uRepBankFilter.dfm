inherited RepBankFilter: TRepBankFilter
  Caption = 'RepBankFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDBanco'
    Properties.ListColumns = <
      item
        FieldName = 'CodigoBanco'
      end
      item
        FieldName = 'Banco'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuBank'
    RemoteServer = DMReport.LuMaintenanceConn
  end
end
