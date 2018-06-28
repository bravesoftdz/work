inherited RepSOCustomerProductFilter: TRepSOCustomerProductFilter
  Left = 208
  Top = 312
  Caption = 'RepSOCustomerProductFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblFilter: TLabel
    Left = 44
    Width = 93
    Caption = 'Customer Product :'
  end
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDSOCustomerProduct'
    Properties.ListColumns = <
      item
        FieldName = 'Description'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuSOCustomerProduct'
    RemoteServer = DMReport.LuSOConn
  end
end
