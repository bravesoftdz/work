inherited PctPetSaleSearch: TPctPetSaleSearch
  Left = 9
  Top = 95
  Caption = 'Re-Print Warranty'
  ClientHeight = 474
  ClientWidth = 703
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTop: TPanel
    Width = 703
    Height = 67
    inherited pnlFilter: TPanel
      Width = 703
      Height = 67
      object lbSKU: TLabel [0]
        Left = 25
        Top = 13
        Width = 26
        Height = 13
        Alignment = taRightJustify
        Caption = 'SKU :'
      end
      inherited pnlRefresh: TPanel
        Left = 658
        Top = 16
      end
      object edtSKU: TcxTextEdit
        Left = 57
        Top = 9
        Width = 121
        Height = 21
        Style.StyleController = DMPetCenter.cxStyleController
        TabOrder = 1
      end
      object scBreed: TmrSuperCombo
        Left = 57
        Top = 35
        Width = 122
        Height = 21
        Properties.ListColumns = <>
        Properties.ListOptions.ShowHeader = False
        Properties.ReadOnly = False
        Properties.Buttons = <
          item
            Default = True
          end
          item
            Kind = bkEllipsis
            Visible = False
          end>
        Style.StyleController = DMPetCenter.cxStyleController
        TabOrder = 2
        DisableButtons = False
        ConnectionListName = 'LookUpPetConn'
        ProviderListName = 'dspLuPetBreed'
        EditLabel.Width = 35
        EditLabel.Height = 13
        EditLabel.Caption = 'Breed :'
        LabelPosition = lpLeft
        LabelSpacing = 6
        Required = False
        Locked = False
        DependentLookUps = <>
      end
      object scSpecies: TmrSuperCombo
        Left = 270
        Top = 35
        Width = 122
        Height = 21
        Properties.ListColumns = <>
        Properties.ListOptions.ShowHeader = False
        Properties.ReadOnly = False
        Properties.Buttons = <
          item
            Default = True
          end
          item
            Kind = bkEllipsis
            Visible = False
          end>
        Style.StyleController = DMPetCenter.cxStyleController
        TabOrder = 3
        DisableButtons = False
        ConnectionListName = 'LookUpPetConn'
        ProviderListName = 'dspLuPetSpecies'
        EditLabel.Width = 43
        EditLabel.Height = 13
        EditLabel.Caption = 'Species :'
        LabelPosition = lpLeft
        LabelSpacing = 6
        Required = False
        Locked = False
        DependentLookUps = <>
      end
      object scStatus: TmrSuperCombo
        Left = 270
        Top = 9
        Width = 122
        Height = 21
        Properties.ListColumns = <>
        Properties.ListOptions.ShowHeader = False
        Properties.ReadOnly = False
        Properties.Buttons = <
          item
            Default = True
          end
          item
            Kind = bkEllipsis
            Visible = False
          end>
        Style.StyleController = DMPetCenter.cxStyleController
        TabOrder = 4
        DisableButtons = False
        ConnectionListName = 'LookUpPetConn'
        ProviderListName = 'dspLuPetStatus'
        EditLabel.Width = 38
        EditLabel.Height = 13
        EditLabel.Caption = 'Status :'
        LabelPosition = lpLeft
        LabelSpacing = 6
        Required = False
        Locked = False
        DependentLookUps = <>
      end
    end
  end
  inherited pnlLeft: TPanel
    Top = 67
    Width = 4
    Height = 379
  end
  inherited pnlBottom: TPanel
    Top = 446
    Width = 703
    inherited btnOk: TXiButton
      Left = 500
      Width = 124
      Glyph.Data = {
        76030000424D7603000000000000360000002800000011000000100000000100
        1800000000004003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFC8C6C3806850806050806050
        706050705840705840705040705040604830604830604830A29A92FF00FFFF00
        FF00FF00FFC1C4C3A38D85E0D0C0B0A090B0A090B0A090B0A090B0A090B0A090
        B0A090B0A090B0A090B0A090604830FF00FFFF00FF00FF00FFBCB7B0B29C94FF
        E8E0FFF8F0FFF0E0FFE8E0F0D8D0F0D0B0F0C0A000A00000A00000A000705840
        604830857767FF00FF00FF00FFB29485E0D8D0FFFFFFFFFFFFFFFFFFFFFFFFFF
        F0F0F0E0E0F0D8C000FF1000FFB000A000806850705040604830FF00FF00FF00
        FFB09080F0E8E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0F0E8E000FF1000
        FF1000A000907060706050604830FF00FF00FF00FFB09880D0C0B0D0B8B0C0B0
        A0B0A090B09880A0888090807090706080686080605070585090807080686070
        5840FF00FF00FF00FFC0A090FFF8F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFF8F0FFF0F0F0F0F0F0E8E0A08880907860806050FF00FF00FF00FFCEC9C3
        B6A18CD0B0A0C0A8A0D0B0A0C0A090B09080A080709070608060507060508070
        60B0A090A08870806050FF00FF00FF00FFFF00FFCBC7C2C0B0A0E0C8C0FFFFFF
        FFF8FFFFF8FFFFF0F0F0F0E0F0E0E0C0A8A0806050A09080C0B0A0806050FF00
        FF00FF00FFFF00FFFF00FFDEDFDDC0B0A0FFFFFFF0E8E0D0C8C0D0C8C0D0B8B0
        D0C0B0E0D0D0806860806050B09890B0A090FF00FF00FF00FFFF00FFFF00FFFF
        00FFD8CBBCF0E8E0FFFFFFFFFFFFFFFFFFFFF8FFFFF0F0F0E0D0D0B8B0806050
        BAADA8FF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFE5E5E6D0B8B0FFFFFFF0
        F0F0D0C8C0D0C8C0D0B8B0C0B0B0E0D8D0807060866859FF00FFFF00FF00FF00
        FFFF00FFFF00FFFF00FFFF00FFDED5D3E0D1D1FFFFFFFFFFFFFFFFFFFFFFFFFF
        F8FFF0E8E0D0B8B0806050FF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFDFD6D3D0C0B0D0C0B0D0C0B0D0C0B0D0C0B0D0C0B0D0C0B0D0C0B0FF
        00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00}
      Caption = '&Reprint Warranty'
      ModalResult = 0
      OnClick = btnOkClick
    end
    inherited btnCancel: TXiButton
      Left = 627
      Caption = '&Close'
    end
  end
  inherited pnlRight: TPanel
    Left = 702
    Top = 67
    Width = 1
    Height = 379
  end
  inherited grdList: TcxGrid
    Left = 4
    Top = 67
    Width = 698
    Height = 379
    inherited grdListDBTableView: TcxGridDBTableView
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDPetSale'
      object grdListDBTableViewDBColumn1: TcxGridDBColumn
        Caption = 'Sale#'
        DataBinding.FieldName = 'IDPetSale'
        Options.Filtering = False
        Width = 44
      end
      object grdListDBTableViewPetSaleDate: TcxGridDBColumn
        DataBinding.FieldName = 'PetSaleDate'
        Options.Filtering = False
        SortOrder = soDescending
        Width = 77
      end
      object grdListDBTableViewSKU: TcxGridDBColumn
        DataBinding.FieldName = 'SKU'
        Options.Filtering = False
        Width = 74
      end
      object grdListDBTableViewSex: TcxGridDBColumn
        DataBinding.FieldName = 'Sex'
        Options.Filtering = False
        Width = 29
      end
      object grdListDBTableViewWarrantyCustomerName: TcxGridDBColumn
        DataBinding.FieldName = 'WarrantyCustomerName'
        Options.Filtering = False
        Width = 118
      end
      object grdListDBTableViewSaleCustomerName: TcxGridDBColumn
        DataBinding.FieldName = 'SaleCustomerName'
        Options.Filtering = False
        Width = 114
      end
      object grdListDBTableViewPetSaleSold: TcxGridDBColumn
        DataBinding.FieldName = 'PetSaleSold'
        Options.Filtering = False
        Width = 73
      end
      object grdListDBTableViewPetSaleDiscount: TcxGridDBColumn
        DataBinding.FieldName = 'PetSaleDiscount'
        Options.Filtering = False
        Width = 89
      end
      object grdListDBTableViewPetNetSale: TcxGridDBColumn
        DataBinding.FieldName = 'PetNetSale'
        Options.Filtering = False
      end
      object grdListDBTableViewInvoiceTotal: TcxGridDBColumn
        DataBinding.FieldName = 'InvoiceTotal'
        Options.Filtering = False
        Width = 78
      end
    end
  end
  inherited cdsSearch: TClientDataSet
    ProviderName = 'dspSearchPetSale'
    RemoteServer = DMPet.SearchPetConn
    BeforeGetRecords = cdsSearchBeforeGetRecords
    object cdsSearchIDPetSale: TIntegerField
      FieldName = 'IDPetSale'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsSearchIDPet: TIntegerField
      FieldName = 'IDPet'
    end
    object cdsSearchIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
    end
    object cdsSearchIDPorte: TIntegerField
      FieldName = 'IDPorte'
    end
    object cdsSearchIDBreed: TIntegerField
      FieldName = 'IDBreed'
    end
    object cdsSearchIDStatus: TIntegerField
      FieldName = 'IDStatus'
    end
    object cdsSearchIDBreeder: TIntegerField
      FieldName = 'IDBreeder'
    end
    object cdsSearchIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsSearchIDWarrantyReport: TIntegerField
      FieldName = 'IDWarrantyReport'
    end
    object cdsSearchIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object cdsSearchName: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object cdsSearchSex: TStringField
      FieldName = 'Sex'
      Size = 1
    end
    object cdsSearchColor: TStringField
      FieldName = 'Color'
      Size = 50
    end
    object cdsSearchSKU: TStringField
      FieldName = 'SKU'
      Size = 30
    end
    object cdsSearchPenNum: TStringField
      FieldName = 'PenNum'
      Size = 10
    end
    object cdsSearchVendorCost: TBCDField
      FieldName = 'VendorCost'
      Precision = 19
    end
    object cdsSearchMSRP: TBCDField
      FieldName = 'MSRP'
      Precision = 19
    end
    object cdsSearchSalePrice: TBCDField
      FieldName = 'SalePrice'
      Precision = 19
    end
    object cdsSearchPromoPrice: TBCDField
      FieldName = 'PromoPrice'
      Precision = 19
    end
    object cdsSearchUSDA: TStringField
      FieldName = 'USDA'
      Size = 50
    end
    object cdsSearchCollar: TStringField
      FieldName = 'Collar'
      Size = 50
    end
    object cdsSearchSire: TStringField
      FieldName = 'Sire'
      Size = 255
    end
    object cdsSearchDam: TStringField
      FieldName = 'Dam'
      Size = 255
    end
    object cdsSearchWhelpDate: TDateTimeField
      FieldName = 'WhelpDate'
    end
    object cdsSearchPurchaseDate: TDateTimeField
      FieldName = 'PurchaseDate'
    end
    object cdsSearchNotes: TStringField
      FieldName = 'Notes'
      Size = 255
    end
    object cdsSearchSpecies: TStringField
      FieldName = 'Species'
      Size = 50
    end
    object cdsSearchBreed: TStringField
      FieldName = 'Breed'
      Size = 50
    end
    object cdsSearchStatusCode: TStringField
      FieldName = 'StatusCode'
      Size = 5
    end
    object cdsSearchStatus: TStringField
      FieldName = 'Status'
      Size = 30
    end
    object cdsSearchBreeder: TStringField
      FieldName = 'Breeder'
      Size = 50
    end
    object cdsSearchWarrantyCustomerName: TStringField
      DisplayLabel = 'Warranty Customer'
      FieldName = 'WarrantyCustomerName'
      Size = 50
    end
    object cdsSearchWCustomerFirstName: TStringField
      FieldName = 'WCustomerFirstName'
      Size = 30
    end
    object cdsSearchWCustomerLastName: TStringField
      FieldName = 'WCustomerLastName'
      Size = 30
    end
    object cdsSearchWCustomerAddress: TStringField
      FieldName = 'WCustomerAddress'
      Size = 80
    end
    object cdsSearchWCustomerCity: TStringField
      FieldName = 'WCustomerCity'
      Size = 40
    end
    object cdsSearchWCustomerStateID: TStringField
      FieldName = 'WCustomerStateID'
      FixedChar = True
      Size = 3
    end
    object cdsSearchWCustomerZip: TStringField
      FieldName = 'WCustomerZip'
      FixedChar = True
      Size = 12
    end
    object cdsSearchWCustomerPhone: TStringField
      FieldName = 'WCustomerPhone'
      Size = 40
    end
    object cdsSearchWCustomerEmail: TStringField
      FieldName = 'WCustomerEmail'
      Size = 50
    end
    object cdsSearchPetSaleDate: TDateTimeField
      DisplayLabel = 'Sold Date'
      FieldName = 'PetSaleDate'
    end
    object cdsSearchPetSaleCost: TBCDField
      FieldName = 'PetSaleCost'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsSearchPetSaleSold: TBCDField
      DisplayLabel = 'Price'
      FieldName = 'PetSaleSold'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsSearchPetNetSale: TBCDField
      DisplayLabel = 'Sold Price'
      FieldName = 'PetNetSale'
      DisplayFormat = '#,##0.00'
    end
    object cdsSearchPetSaleDiscount: TBCDField
      DisplayLabel = 'Discount'
      FieldName = 'PetSaleDiscount'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsSearchInvoiceTotal: TBCDField
      FieldName = 'InvoiceTotal'
      DisplayFormat = '#,##0.00'
    end
    object cdsSearchSaleCustomerName: TStringField
      DisplayLabel = 'Customer'
      FieldName = 'SaleCustomerName'
      Size = 50
    end
  end
end
