inherited RepCategoryListFilter: TRepCategoryListFilter
  Caption = 'RepCategoryListFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited btAddAll: TSpeedButton
    Left = 340
  end
  inherited btAdd: TSpeedButton
    Left = 340
  end
  inherited btRemove: TSpeedButton
    Left = 340
  end
  inherited lcFilter: TcxLookupComboBox
    Left = 141
    Properties.KeyFieldNames = 'IDCategory'
    Properties.ListColumns = <
      item
        FieldName = 'Category'
      end>
  end
  inherited clbFilter: TcxListBox
    Left = 141
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuCategory'
    RemoteServer = DMReport.LuInventoryConn
  end
end
