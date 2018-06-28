inherited RepVendorFilter: TRepVendorFilter
  Caption = 'RepVendorFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblFilter: TLabel
    Left = 97
    Top = 8
    Caption = 'Vendor :'
  end
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDVendor'
    Properties.ListColumns = <
      item
        FieldName = 'Vendor'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuVendor'
    RemoteServer = DMReport.LuPurchaseConn
  end
end
