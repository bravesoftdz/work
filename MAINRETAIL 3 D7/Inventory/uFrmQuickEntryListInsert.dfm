inherited FrmQuickEntryListInsert: TFrmQuickEntryListInsert
  Left = 151
  Top = 173
  Caption = 'FrmQuickEntryListInsert'
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel [0]
    Left = 408
    Top = 160
    Width = 50
    Height = 13
    Caption = 'IDBarcode'
  end
  inherited Panel1: TPanel
    inherited hhh: TPanel
      inherited spHelp: TSpeedButton
        Visible = True
        OnClick = spHelpClick
      end
      inherited btnVideo: TSpeedButton
        Visible = True
        OnClick = btnVideoClick
      end
      inherited btSave: TButton
        OnClick = btSaveClick
      end
    end
  end
  inherited grdModelList: TcxGrid
    inherited grdModelListDB: TcxGridDBTableView
      OnKeyDown = grdModelListDBKeyDown
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'ID'
      OptionsData.Appending = True
      inherited grdModelListDBModel: TcxGridDBColumn
        Width = 42
      end
      inherited grdModelListDBDescription: TcxGridDBColumn
        Width = 87
      end
      inherited grdModelListDBIDGroup: TcxGridDBColumn
        Properties.ListOptions.ShowHeader = False
        Width = 57
      end
      inherited grdModelListDBVendorCost: TcxGridDBColumn
        FooterAlignmentHorz = taRightJustify
        Width = 47
      end
      inherited grdModelListDBMarkup: TcxGridDBColumn
        Width = 53
      end
      inherited grdModelListDBSellingPrice: TcxGridDBColumn
        Width = 66
      end
      inherited grdModelListDBIDModelGroup: TcxGridDBColumn
        Properties.ListOptions.ShowHeader = False
        Visible = False
        Width = 118
      end
      inherited grdModelListDBIDModelSubGroup: TcxGridDBColumn
        Width = 38
      end
      inherited grdModelListDBManufacturer: TcxGridDBColumn
        Properties.ListOptions.ShowHeader = False
        Hidden = True
      end
      object grdModelListDBIDBarcode: TcxGridDBColumn
        Caption = 'Barcode'
        DataBinding.FieldName = 'IDBarcode'
        Styles.Content = cxBarcode
        Width = 50
      end
      object grdModelListDBIDManufacturer: TcxGridDBColumn
        Caption = 'Manufacturer'
        DataBinding.FieldName = 'IDManufacturer'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.ClearKey = 46
        Properties.KeyFieldNames = 'IDFabricante'
        Properties.ListColumns = <
          item
            FieldName = 'Pessoa'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = DM.dsLookUpFabricante
        Visible = False
      end
      object grdModelListDBIDVendor: TcxGridDBColumn
        Caption = 'Vendor'
        DataBinding.FieldName = 'IDVendor'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.ClearKey = 46
        Properties.KeyFieldNames = 'IDFornecedor'
        Properties.ListColumns = <
          item
            FieldName = 'Fornecedor'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = DM.dsLookUpFornecedor
        Visible = False
      end
      object grdModelListDBVendorCode: TcxGridDBColumn
        DataBinding.FieldName = 'VendorCode'
        Visible = False
      end
      object grdModelListDBMarginInfo: TcxGridDBColumn
        DataBinding.FieldName = 'MarginInfo'
        Visible = False
      end
      object grdModelListDBMarkupInfo: TcxGridDBColumn
        DataBinding.FieldName = 'MarkupInfo'
        Visible = False
      end
      object grdModelListDBQtyOnHand: TcxGridDBColumn
        DataBinding.FieldName = 'QtyOnHand'
        PropertiesClassName = 'TcxSpinEditProperties'
        Properties.OnValidate = grdModelListDBQtyOnHandPropertiesValidate
        Visible = False
      end
      object grdModelListDBMinQty: TcxGridDBColumn
        DataBinding.FieldName = 'MinQty'
        Visible = False
      end
      object grdModelListDBBarcodeCase: TcxGridDBColumn
        DataBinding.FieldName = 'BarcodeCase'
        Visible = False
        Styles.Content = cxBarcodeCase
      end
    end
  end
  inherited pnlButton: TPanelRights
    inherited btColumn: TSpeedButton
      Top = 122
    end
    inherited btImport: TSpeedButton
      Top = 91
    end
    inherited btExcel: TSpeedButton
      Top = 64
    end
    inherited btnCategory: TSpeedButton
      Top = 154
    end
    object btRemove: TSpeedButton [5]
      Tag = 2
      Left = 1
      Top = 33
      Width = 107
      Height = 25
      Hint = 'Remove'
      Caption = 'Re&move'
      Flat = True
      Margin = 4
      ParentShowHint = False
      ShowHint = True
      Spacing = 6
      OnClick = btRemoveClick
    end
    inherited panel8: TPanel
      Top = 60
    end
    inherited Panel4: TPanel
      Top = 119
    end
    inherited Panel6: TPanel
      Top = 149
    end
  end
  inherited cdsModel: TClientDataSet
    BeforePost = cdsModelBeforePost
    AfterCancel = cdsModelAfterCancel
    OnNewRecord = cdsModelNewRecord
    object cdsModelIDBarcode: TStringField [0]
      FieldName = 'IDBarcode'
      OnValidate = cdsModelIDBarcodeValidate
    end
    object cdsModelIDSize: TIntegerField [1]
      FieldName = 'IDSize'
    end
    object cdsModelIDColor: TIntegerField [2]
      FieldName = 'IDColor'
    end
    object cdsModelIDUnit: TIntegerField [3]
      FieldName = 'IDUnit'
    end
    object cdsModelIDVendor: TIntegerField [4]
      FieldName = 'IDVendor'
    end
    object cdsModelIDVendorModelCode: TIntegerField [5]
      FieldName = 'IDVendorModelCode'
    end
    object cdsModelVendorCode: TStringField [6]
      FieldName = 'VendorCode'
    end
    object cdsModelIDInventory: TIntegerField [7]
      FieldName = 'IDInventory'
    end
    object cdsModelIDStore: TIntegerField [8]
      FieldName = 'IDStore'
    end
    object cdsModelQtyOnHand: TFloatField [9]
      FieldName = 'QtyOnHand'
    end
    object cdsModelModelType: TStringField [10]
      FieldName = 'ModelType'
      Size = 1
    end
    object cdsModelVerify: TBooleanField [11]
      FieldName = 'Verify'
    end
    object cdsModelID: TFloatField [28]
      FieldName = 'ID'
    end
    object cdsModelBarcodeCase: TStringField
      FieldName = 'BarcodeCase'
    end
  end
  inherited strepPredefined: TcxStyleRepository
    object cxBarcodeCase: TcxStyle [2]
      AssignedValues = [svColor]
      Color = 13565951
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmQuickEntryListInsert.sil'
  end
end
