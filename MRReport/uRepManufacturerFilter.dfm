inherited RepManufacturerFilter: TRepManufacturerFilter
  Caption = 'RepManufacturerFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDManufacturer'
    Properties.ListColumns = <
      item
        FieldName = 'Manufacturer'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuManufacturer'
    RemoteServer = DMReport.LuInventoryConn
  end
end
