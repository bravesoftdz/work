inherited RepVendorListFilter: TRepVendorListFilter
  Caption = 'RepVendorListFilter'
  PixelsPerInch = 96
  TextHeight = 13
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
