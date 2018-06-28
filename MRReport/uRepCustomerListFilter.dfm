inherited RepCustomerListFilter: TRepCustomerListFilter
  Caption = 'RepCustomerListFilter'
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
    ProviderName = 'dspLuCustomer'
    RemoteServer = DMReport.LuMaintenanceConn
  end
end
