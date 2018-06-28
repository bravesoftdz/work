inherited RepSubCategoryFilter: TRepSubCategoryFilter
  Left = 358
  Top = 212
  Caption = 'RepSubCategoryFilter'
  ClientHeight = 29
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblFilter: TLabel
    Left = 67
    Top = 8
    Width = 71
    Caption = 'Sub category :'
  end
  inherited lcFilter: TcxLookupComboBox
    Properties.KeyFieldNames = 'IDSubCategory'
    Properties.ListColumns = <
      item
        FieldName = 'SubCategory'
      end>
  end
  inherited cdsFilter: TClientDataSet
    ProviderName = 'dspLuSubCategory'
    RemoteServer = DMReport.LuInventoryConn
    Left = 192
    Top = 65531
  end
  inherited dsFilter: TDataSource
    Left = 244
    Top = 65531
  end
end
