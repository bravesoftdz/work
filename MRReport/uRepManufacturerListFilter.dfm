inherited RepManufacturerListFilter: TRepManufacturerListFilter
  Caption = 'RepManufacturerListFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcFilter: TcxLookupComboBox
    Properties.DropDownListStyle = lsFixedList
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
