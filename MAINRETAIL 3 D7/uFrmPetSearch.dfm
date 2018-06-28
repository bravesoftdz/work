inherited FrmPetSearch: TFrmPetSearch
  Left = 99
  Top = 174
  Caption = 'Pet Search'
  ClientHeight = 409
  ClientWidth = 675
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbSKU: TLabel [0]
    Left = 41
    Top = 19
    Width = 28
    Height = 13
    Alignment = taRightJustify
    Caption = 'SKU :'
  end
  object lbSubGroup: TLabel [1]
    Left = 273
    Top = 49
    Width = 44
    Height = 13
    Alignment = taRightJustify
    Caption = 'Species :'
  end
  object Label1: TLabel [2]
    Left = 283
    Top = 17
    Width = 34
    Height = 13
    Alignment = taRightJustify
    Caption = 'Breed :'
  end
  inherited Panel1: TPanel
    Top = 370
    Width = 675
    TabOrder = 7
    inherited Bevel1: TBevel
      Width = 675
    end
    inherited Panel2: TPanel
      Left = 525
      inherited Cancelar: TButton
        ModalResult = 2
      end
      inherited Aplicar: TButton
        ModalResult = 1
        OnClick = AplicarClick
      end
    end
  end
  object Panel3: TPanel [4]
    Left = 0
    Top = 79
    Width = 675
    Height = 291
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    object grdBrowseSearch: TcxGrid
      Left = 0
      Top = 0
      Width = 675
      Height = 291
      Align = alClient
      TabOrder = 0
      LookAndFeel.Kind = lfFlat
      object grdBrowseSearchDB: TcxGridDBTableView
        OnDblClick = grdBrowseSearchDBDblClick
        DataController.DataSource = dsPet
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDPet'
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubSellingPrice'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubFinalCost'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubVendorCost'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubFreightCost'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubOtherCost'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubRealMarkUpValue'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubSuggRetail'
          end
          item
            Format = '0'
            Kind = skSum
            Position = spFooter
            FieldName = 'PositiveQty'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubSellingPrice'
          end>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        Filtering.MaxDropDownCount = 50
        OptionsBehavior.IncSearch = True
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OptionsView.GroupFooters = gfVisibleWhenExpanded
        OptionsView.HeaderAutoHeight = True
        OptionsView.HeaderEndEllipsis = True
        Preview.AutoHeight = False
        Preview.MaxLineCount = 2
        object grdBrowseSearchDBSKU: TcxGridDBColumn
          DataBinding.FieldName = 'SKU'
          Options.Filtering = False
          Width = 63
        end
        object grdBrowseSearchDBSex: TcxGridDBColumn
          DataBinding.FieldName = 'Sex'
          Options.Filtering = False
          Width = 38
        end
        object grdBrowseSearchDBColor: TcxGridDBColumn
          DataBinding.FieldName = 'Color'
          Options.Filtering = False
          Width = 83
        end
        object grdBrowseSearchDBSalePrice: TcxGridDBColumn
          DataBinding.FieldName = 'SalePrice'
          Options.Filtering = False
          Width = 63
        end
        object grdBrowseSearchDBPromoPrice: TcxGridDBColumn
          DataBinding.FieldName = 'PromoPrice'
          Options.Filtering = False
          Width = 72
        end
        object grdBrowseSearchDBSpecies: TcxGridDBColumn
          DataBinding.FieldName = 'Species'
          Options.Filtering = False
          Width = 94
        end
        object grdBrowseSearchDBBreed: TcxGridDBColumn
          DataBinding.FieldName = 'Breed'
          Width = 97
        end
        object grdBrowseSearchDBStatus: TcxGridDBColumn
          DataBinding.FieldName = 'Status'
          Width = 81
        end
        object grdBrowseSearchDBPessoa: TcxGridDBColumn
          Caption = 'Breeder'
          DataBinding.FieldName = 'Pessoa'
          Width = 82
        end
      end
      object grdBrowseSearchLevel: TcxGridLevel
        GridView = grdBrowseSearchDB
      end
    end
  end
  object btSearch: TBitBtn [5]
    Left = 567
    Top = 28
    Width = 91
    Height = 27
    Caption = '&Search'
    TabOrder = 5
    OnClick = btSearchClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000130B0000130B00000000000000000000FF00FF7D8497
      747DAEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FF747DAE4985D6767DAC747DAEFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA4B1F75BB9FD
      4589DF707CAF747DAEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFA0A5FA55B5FC4588DE727CAF747DAEFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      A1AFFA57B6FC4689DE747DAE747DAEFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA1A5FB57B1FC468AD59385A6FF
      00FFFF00FFCEA890CEA890CEA890CEA890FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFA5ADFA95BFE4A69E9EC86DA4E0A5A3EDD5ADF0E4C2F2E7C9EBD6
      BDDE8EBECEA890FE02FDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCEADA9E6
      C1A0FBF0C2FFFCD1FFFFD9FFFFE7FFFFF6F8F2EED4B6B5CEA890FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFDEB6ABFFEDBCFFEFBAFFFCD0FFFFDFFFFDF2FFFF
      FFFEFEFCEEE1D0D57FB6FF00FFFF00FFFF00FFFF00FFFF00FFCEA890E9D2B4FF
      EABAFFE4B2FFFCD1FFFFDFFFFEF6FFFDFAFFFCF3FCF6D7CBA693FF00FFFF00FF
      FF00FFFF00FFFF00FFCEA890F2E1BCFFE4B2FFE4B2FFF8C9FFFFDAFFFEE6FFFD
      EAFFFEDFFFFDD3D1B7A5FF00FFFF00FFFF00FFFF00FFFF00FFCEA890F1DFBBFF
      F1C3FFE9B6FFECB9FFF9CBFFFDD4FFFDD5FFFDD3FFF6CAD0A993FF00FFFF00FF
      FF00FFFF00FFFF00FFCEA890E7CAB6FFF9E8FFF2DAFFE2BBFFEBB5FFF0BCFFF1
      BDFFF6C4F7E4BCCDA294FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCEA890F4
      E7E0FEFDFCFFEACBFFE4B3FBDCADFFE8B9FCEEBEDDAA94CEA890FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFCEA890E8D2CAF9EED1FFF4C3FDF2C1F2E0
      B7DFAF9BCEA890FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFCEA890CCA590CEA890D1B09DD5B1A8CEA890FF00FFFF00FF}
  end
  object edSKU: TEdit [6]
    Left = 75
    Top = 14
    Width = 135
    Height = 21
    Color = 15532031
    TabOrder = 0
    OnEnter = edSKUEnter
    OnExit = edSKUExit
  end
  object scPetSpecies: TSuperComboADO [7]
    Left = 322
    Top = 46
    Width = 139
    Height = 21
    TabOrder = 3
    Text = '<-->'
    LookUpSource = DM.dsLookUpPetSpecies
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btnSpeciesClear: TButton [8]
    Left = 465
    Top = 47
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 4
    TabStop = False
    OnClick = btnSpeciesClearClick
  end
  object csBreed: TSuperComboADO [9]
    Left = 322
    Top = 14
    Width = 139
    Height = 21
    TabOrder = 1
    Text = '<-->'
    LookUpSource = DM.dsLookUpPetRace
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btnBreedClear: TButton [10]
    Left = 465
    Top = 15
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 2
    TabStop = False
    OnClick = btnBreedClearClick
  end
  inherited siLang: TsiLangRT
    Top = 100
  end
  object quPet: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'P.IDPet,'#13#10#9'P.IDSpecies,'#13#10#9'P.IDPorte,'#13#10#9'P.IDBreed,'#13#10#9'P.I' +
      'DStatus,'#13#10#9'P.IDBreeder,'#13#10#9'P.Name,'#13#10#9'P.Sex,'#13#10#9'PC.Color,'#13#10#9'P.SKU,'#13 +
      #10#9'P.PenNum,'#13#10#9'P.VendorCost,'#13#10#9'P.MSRP,'#13#10#9'P.SalePrice,'#13#10#9'P.PromoPr' +
      'ice,'#13#10#9'P.USDA,'#13#10#9'P.Collar,'#13#10#9'P.Sire,'#13#10#9'P.Dam,'#13#10#9'P.WhelpDate,'#13#10#9'P' +
      '.PurchaseDate,'#13#10#9'P.Notes,'#13#10#9'P.System,'#13#10#9'P.Hidden,'#13#10#9'P.Desativado' +
      ','#13#10#9'PS.Species,'#13#10#9'PT.Porte,'#13#10#9'PB.Breed,'#13#10#9'PA.StatusCode,'#13#10#9'PA.St' +
      'atus,'#13#10#9'B.Pessoa,'#13#10#9'B.Telefone'#13#10'FROM'#13#10#9'Pet P (NOLOCK) '#13#10#9'LEFT JO' +
      'IN Pet_Species PS (NOLOCK) ON (PS.IDSpecies = P.IDSpecies)'#13#10#9'LEF' +
      'T JOIN Pet_Porte PT (NOLOCK) ON (PT.IDPorte = P.IDPorte)'#13#10#9'LEFT ' +
      'JOIN Pet_Breed PB (NOLOCK) ON (PB.IDBreed = P.IDBreed)'#13#10#9'LEFT JO' +
      'IN Pet_Status PA (NOLOCK) ON (PA.IDStatus = P.IDStatus)'#13#10#9'LEFT J' +
      'OIN Pessoa B (NOLOCK) ON (B.IDPessoa = P.IDBreeder)'#13#10#9'LEFT JOIN ' +
      'Pet_Color PC (NOLOCK) ON (P.IDColor = PC.IDColor)'#13#10'WHERE'#13#10#9'P.Des' +
      'ativado = 0'#13#10#9'AND P.Hidden = 0'#13#10#9'AND P.System = 0'#13#10#13#10
    Parameters = <>
    Left = 315
    Top = 215
    object quPetIDPet: TIntegerField
      FieldName = 'IDPet'
    end
    object quPetIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
    end
    object quPetIDPorte: TIntegerField
      FieldName = 'IDPorte'
    end
    object quPetIDBreed: TIntegerField
      FieldName = 'IDBreed'
    end
    object quPetIDStatus: TIntegerField
      FieldName = 'IDStatus'
    end
    object quPetIDBreeder: TIntegerField
      FieldName = 'IDBreeder'
    end
    object quPetName: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object quPetSex: TStringField
      FieldName = 'Sex'
      Size = 1
    end
    object quPetColor: TStringField
      FieldName = 'Color'
      Size = 50
    end
    object quPetSKU: TStringField
      FieldName = 'SKU'
      Size = 30
    end
    object quPetPenNum: TStringField
      FieldName = 'PenNum'
      Size = 10
    end
    object quPetVendorCost: TBCDField
      FieldName = 'VendorCost'
      Precision = 19
    end
    object quPetMSRP: TBCDField
      FieldName = 'MSRP'
      Precision = 19
    end
    object quPetSalePrice: TBCDField
      FieldName = 'SalePrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quPetPromoPrice: TBCDField
      FieldName = 'PromoPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quPetUSDA: TStringField
      FieldName = 'USDA'
      Size = 50
    end
    object quPetCollar: TStringField
      FieldName = 'Collar'
      Size = 50
    end
    object quPetSire: TStringField
      FieldName = 'Sire'
      Size = 255
    end
    object quPetDam: TStringField
      FieldName = 'Dam'
      Size = 255
    end
    object quPetWhelpDate: TDateTimeField
      FieldName = 'WhelpDate'
    end
    object quPetPurchaseDate: TDateTimeField
      FieldName = 'PurchaseDate'
    end
    object quPetNotes: TStringField
      FieldName = 'Notes'
      Size = 255
    end
    object quPetSystem: TBooleanField
      FieldName = 'System'
    end
    object quPetHidden: TBooleanField
      FieldName = 'Hidden'
    end
    object quPetDesativado: TBooleanField
      FieldName = 'Desativado'
    end
    object quPetSpecies: TStringField
      FieldName = 'Species'
      Size = 50
    end
    object quPetPorte: TStringField
      FieldName = 'Porte'
      Size = 50
    end
    object quPetBreed: TStringField
      FieldName = 'Breed'
      Size = 50
    end
    object quPetStatusCode: TStringField
      FieldName = 'StatusCode'
      Size = 5
    end
    object quPetStatus: TStringField
      FieldName = 'Status'
      Size = 30
    end
    object quPetPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object quPetTelefone: TStringField
      FieldName = 'Telefone'
      Size = 40
    end
  end
  object dsPet: TDataSource
    DataSet = quPet
    Left = 267
    Top = 215
  end
end
