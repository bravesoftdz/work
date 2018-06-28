inherited PctPetSearch: TPctPetSearch
  Left = 81
  Top = 190
  Caption = 'PctPetSearch'
  ClientHeight = 351
  ClientWidth = 529
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTop: TPanel
    Width = 529
    Height = 87
    inherited pnlFilter: TPanel
      Width = 529
      Height = 87
      object lbSKU: TLabel [0]
        Left = 25
        Top = 13
        Width = 26
        Height = 13
        Alignment = taRightJustify
        Caption = 'SKU :'
      end
      inherited pnlRefresh: TPanel
        Left = 484
        TabOrder = 4
      end
      object edtSKU: TcxTextEdit
        Left = 57
        Top = 9
        Width = 121
        Height = 21
        Style.StyleController = DMPetCenter.cxStyleController
        TabOrder = 0
      end
      object scBreed: TmrSuperCombo
        Left = 57
        Top = 41
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
        TabOrder = 1
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
        TabOrder = 2
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
      object scSpecies: TmrSuperCombo
        Left = 270
        Top = 40
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
    end
  end
  inherited pnlLeft: TPanel
    Top = 87
    Height = 236
  end
  inherited pnlBottom: TPanel
    Top = 323
    Width = 529
    inherited btnOk: TXiButton
      Left = 375
    end
    inherited btnCancel: TXiButton
      Left = 453
    end
  end
  inherited pnlRight: TPanel
    Left = 488
    Top = 87
    Height = 236
  end
  inherited grdList: TcxGrid
    Top = 87
    Width = 447
    Height = 236
    inherited grdListDBTableView: TcxGridDBTableView
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDPet'
      object grdListDBTableViewIDPet: TcxGridDBColumn
        DataBinding.FieldName = 'IDPet'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewIDSpecies: TcxGridDBColumn
        DataBinding.FieldName = 'IDSpecies'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewIDPorte: TcxGridDBColumn
        DataBinding.FieldName = 'IDPorte'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewIDBreed: TcxGridDBColumn
        DataBinding.FieldName = 'IDBreed'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewIDStatus: TcxGridDBColumn
        DataBinding.FieldName = 'IDStatus'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewIDBreeder: TcxGridDBColumn
        DataBinding.FieldName = 'IDBreeder'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewName: TcxGridDBColumn
        DataBinding.FieldName = 'Name'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewSKU: TcxGridDBColumn
        DataBinding.FieldName = 'SKU'
        Options.Filtering = False
        Width = 82
      end
      object grdListDBTableViewSex: TcxGridDBColumn
        DataBinding.FieldName = 'Sex'
        Options.Filtering = False
        Width = 52
      end
      object grdListDBTableViewColor: TcxGridDBColumn
        DataBinding.FieldName = 'Color'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewPenNum: TcxGridDBColumn
        DataBinding.FieldName = 'PenNum'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewVendorCost: TcxGridDBColumn
        DataBinding.FieldName = 'VendorCost'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewMSRP: TcxGridDBColumn
        DataBinding.FieldName = 'MSRP'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewSalePrice: TcxGridDBColumn
        DataBinding.FieldName = 'SalePrice'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewPromoPrice: TcxGridDBColumn
        DataBinding.FieldName = 'PromoPrice'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewUSDA: TcxGridDBColumn
        DataBinding.FieldName = 'USDA'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewCollar: TcxGridDBColumn
        DataBinding.FieldName = 'Collar'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewSire: TcxGridDBColumn
        DataBinding.FieldName = 'Sire'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewDam: TcxGridDBColumn
        DataBinding.FieldName = 'Dam'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewWhelpDate: TcxGridDBColumn
        DataBinding.FieldName = 'WhelpDate'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewPurchaseDate: TcxGridDBColumn
        DataBinding.FieldName = 'PurchaseDate'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewNotes: TcxGridDBColumn
        DataBinding.FieldName = 'Notes'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewSystem: TcxGridDBColumn
        DataBinding.FieldName = 'System'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewHidden: TcxGridDBColumn
        DataBinding.FieldName = 'Hidden'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewDesativado: TcxGridDBColumn
        DataBinding.FieldName = 'Desativado'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewSpecies: TcxGridDBColumn
        DataBinding.FieldName = 'Species'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewPorte: TcxGridDBColumn
        DataBinding.FieldName = 'Porte'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewBreed: TcxGridDBColumn
        DataBinding.FieldName = 'Breed'
        Options.Filtering = False
        Width = 172
      end
      object grdListDBTableViewStatusCode: TcxGridDBColumn
        DataBinding.FieldName = 'StatusCode'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewStatus: TcxGridDBColumn
        DataBinding.FieldName = 'Status'
        Options.Filtering = False
        Width = 139
      end
      object grdListDBTableViewPessoa: TcxGridDBColumn
        DataBinding.FieldName = 'Pessoa'
        Visible = False
        Options.Filtering = False
      end
      object grdListDBTableViewTelefone: TcxGridDBColumn
        DataBinding.FieldName = 'Telefone'
        Visible = False
        Options.Filtering = False
      end
    end
  end
  inherited cdsSearch: TClientDataSet
    ProviderName = 'dspSearchPet'
    RemoteServer = DMPet.SearchPetConn
    BeforeGetRecords = cdsSearchBeforeGetRecords
    Left = 84
    object cdsSearchIDPet: TIntegerField
      FieldName = 'IDPet'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
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
    object cdsSearchSystem: TBooleanField
      FieldName = 'System'
    end
    object cdsSearchHidden: TBooleanField
      FieldName = 'Hidden'
    end
    object cdsSearchDesativado: TBooleanField
      FieldName = 'Desativado'
    end
    object cdsSearchSpecies: TStringField
      FieldName = 'Species'
      Size = 50
    end
    object cdsSearchPorte: TStringField
      FieldName = 'Porte'
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
    object cdsSearchPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object cdsSearchTelefone: TStringField
      FieldName = 'Telefone'
      Size = 40
    end
  end
end
