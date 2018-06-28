inherited RepSubCategoryListFilter: TRepSubCategoryListFilter
  Caption = 'RepSubCategoryListFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcFilter: TcxLookupComboBox
    Properties.DropDownListStyle = lsFixedList
    Properties.KeyFieldNames = 'IDSubCategory'
    Properties.ListColumns = <
      item
        FieldName = 'SubCategory'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuSubCategory'
    RemoteServer = DMReport.LuInventoryConn
  end
end
