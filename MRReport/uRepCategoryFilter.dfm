inherited RepCategoryFilter: TRepCategoryFilter
  Caption = 'RepCategoryFilter'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblFilter: TLabel
    Left = 85
    Top = 8
    Width = 52
    Caption = 'Category :'
  end
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDCategory'
    Properties.ListColumns = <
      item
        FieldName = 'Category'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuCategory'
    RemoteServer = DMReport.LuInventoryConn
    Left = 188
  end
  inherited dsFilter: TDataSource
    Left = 240
  end
end
