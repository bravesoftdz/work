inherited RepCustomerFilter: TRepCustomerFilter
  Caption = 'RepCustomerFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblFilter: TLabel
    Left = 84
    Width = 53
    Caption = 'Customer :'
  end
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
