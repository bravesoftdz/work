inherited RepStoreListFilter: TRepStoreListFilter
  Caption = 'RepStoreListFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcFilter: TcxLookupComboBox
    Properties.DropDownListStyle = lsFixedList
    Properties.KeyFieldNames = 'IDStore'
    Properties.ListColumns = <
      item
        FieldName = 'Store'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuStore'
    RemoteServer = DMReport.LuMaintenanceConn
  end
end
