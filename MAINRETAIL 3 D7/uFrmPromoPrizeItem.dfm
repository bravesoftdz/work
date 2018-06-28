inherited FrmPromoPrizeItem: TFrmPromoPrizeItem
  Left = 227
  Top = 39
  Width = 777
  Height = 515
  BorderIcons = [biHelp]
  Caption = 'FrmPromoPrizeItem'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 761
    inherited Image1: TImage
      Width = 534
    end
    inherited lblMenu: TLabel
      Left = 553
    end
    inherited lblSubMenu: TLabelEffect
      Width = 125
    end
    inherited EspacamentoSuperior: TPanel
      Width = 761
      inherited EEE: TPanel
        Width = 761
      end
    end
  end
  inherited Panel1: TPanel
    Top = 436
    Width = 761
    inherited EspacamentoInferior: TPanel
      Width = 761
      inherited Panel3: TPanel
        Width = 761
      end
    end
    inherited hhh: TPanel
      Left = 616
      Width = 145
      inherited btClose: TButton
        Left = 78
        Caption = '&Cancel'
        OnClick = btCloseClick
      end
      object btSave: TButton
        Left = 8
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Save'
        ModalResult = 1
        TabOrder = 1
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 121
    Height = 315
  end
  inherited EspacamentoDireito: TPanel
    Left = 758
    Top = 121
    Height = 315
  end
  object Panel5: TPanel [4]
    Left = 0
    Top = 40
    Width = 761
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object lblCategory: TLabel
      Left = 372
      Top = 8
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'Category :'
    end
    object lblGroup: TLabel
      Left = 353
      Top = 32
      Width = 71
      Height = 13
      Alignment = taRightJustify
      Caption = 'Sub-Category:'
    end
    object lblSubGroup: TLabel
      Left = 391
      Top = 56
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'Group:'
    end
    object Label11: TLabel
      Left = 42
      Top = 8
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Caption = 'Model :'
    end
    object lblVendor: TLabel
      Left = 36
      Top = 32
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = 'Vendor :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblManufacturer: TLabel
      Left = 5
      Top = 57
      Width = 72
      Height = 13
      Alignment = taRightJustify
      Caption = 'Manufacturer :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnCategClear: TButton
      Left = 642
      Top = 4
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 4
      TabStop = False
      OnClick = btnCategClearClick
    end
    object scGroup: TSuperComboADO
      Left = 426
      Top = 28
      Width = 210
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = '<-->'
      LookUpSource = DM.dsLookUpModelGroup
      DropDownRows = 10
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object btnGroupClear: TButton
      Left = 642
      Top = 28
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 5
      TabStop = False
      OnClick = btnGroupClearClick
    end
    object scSubGroup: TSuperComboADO
      Left = 426
      Top = 52
      Width = 210
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = '<-->'
      LookUpSource = DM.dsLookUpModelSubGroup
      DropDownRows = 10
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object btnSubGroupClear: TButton
      Left = 642
      Top = 52
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 6
      TabStop = False
      OnClick = btnSubGroupClearClick
    end
    object btSearch: TBitBtn
      Left = 690
      Top = 4
      Width = 69
      Height = 27
      Caption = '&Search'
      TabOrder = 7
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
    object scModel: TSuperComboADO
      Left = 79
      Top = 4
      Width = 210
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '<-->'
      LookUpSource = DM.dsLookUpModelKit
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object Button1: TButton
      Left = 295
      Top = 4
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 8
      TabStop = False
      OnClick = Button1Click
    end
    object scVendor: TSuperComboADO
      Left = 79
      Top = 28
      Width = 210
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '<-->'
      LookUpSource = DM.dsLookUpFornecedor
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object btnAllVendor: TButton
      Left = 295
      Top = 28
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 9
      TabStop = False
      OnClick = btnAllVendorClick
    end
    object scCategory: TSuperComboADO
      Left = 426
      Top = 6
      Width = 209
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      Text = '<-->'
      LookUpSource = DM.dsLookUpGroup
      DropDownRows = 10
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object scManufacturer: TSuperComboADO
      Left = 79
      Top = 53
      Width = 210
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      Text = '<-->'
      LookUpSource = DM.dsLookUpFabricante
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object btFabricanteAll: TButton
      Left = 295
      Top = 54
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 12
      OnClick = btFabricanteAllClick
    end
  end
  object pnlButtons: TPanel [5]
    Left = 641
    Top = 121
    Width = 117
    Height = 315
    Align = alRight
    TabOrder = 5
    object btSelectAll: TSpeedButton
      Tag = 7
      Left = 3
      Top = 3
      Width = 111
      Height = 26
      Hint = 'Select All'
      Caption = 'Select all'
      Flat = True
      Glyph.Data = {
        76030000424D7603000000000000360000002800000011000000100000000100
        1800000000004003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF00FF00FFFF00FF808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
        C8D0D4C8D0D4C8D0D4C8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8
        D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4
        FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FF00FF00
        FFFF00FF808080C8D0D4FFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFF
        FFFFFFFFFFC8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8D0D4FFFF
        FF000000000000000000000000000000FFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF
        00FFFF00FF00FF00FFFF00FF808080C8D0D4FFFFFF000000000000FFFFFF0000
        00000000000000FFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF
        808080C8D0D4FFFFFF000000FFFFFFFFFFFFFFFFFF000000000000000000FFFF
        FFC8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8D0D4FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFC8D0D4FF00FFFF00FFFF00
        FF00FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF000000FFFFFFC8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8
        D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4
        FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8D0D4C8D0D4C8D0D4C8D0D4C8
        D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4FF00FFFF00FFFF00FF00FF00
        FFFF00FF80808080808080808080808080808080808080808080808080808080
        8080808080808080FF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00}
      Margin = 4
      ParentShowHint = False
      ShowHint = True
      Spacing = 5
      OnClick = btSelectAllClick
    end
    object btUnSelectAll: TSpeedButton
      Tag = 7
      Left = 3
      Top = 29
      Width = 111
      Height = 26
      Hint = 'Un Select All'
      Caption = 'Unselect all'
      Flat = True
      Glyph.Data = {
        EE030000424DEE03000000000000360000002800000012000000110000000100
        180000000000B803000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0000FF00FFFF00FF808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
        C8D0D4C8D0D4C8D0D4C8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
        808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF
        00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FFFF00FF
        0000FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
        808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF
        00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FFFF00FF
        0000FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
        808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4C8D0
        D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4FF00FFFF
        00FFFF00FFFF00FF0000FF00FFFF00FF80808080808080808080808080808080
        8080808080808080808080808080808080808080FF00FFFF00FFFF00FFFF00FF
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF0000}
      Margin = 4
      ParentShowHint = False
      ShowHint = True
      Spacing = 5
      OnClick = btUnSelectAllClick
    end
    object Panel9: TPanel
      Left = 8
      Top = 59
      Width = 101
      Height = 2
      BevelOuter = bvLowered
      TabOrder = 0
    end
  end
  object grdPromoPrizeItensFilter: TcxGrid [6]
    Left = 3
    Top = 121
    Width = 638
    Height = 315
    Align = alClient
    TabOrder = 6
    LookAndFeel.Kind = lfFlat
    object grdPromoPrizeItensFilterDB: TcxGridDBTableView
      DataController.DataSource = dtsPromoPrizeItem
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDModel'
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
      Filtering.Visible = fvNever
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfVisibleWhenExpanded
      OptionsView.HeaderAutoHeight = True
      OptionsView.HeaderEndEllipsis = True
      Preview.AutoHeight = False
      Preview.MaxLineCount = 2
      object grdPromoPrizeItensFilterDBValidation: TcxGridDBColumn
        DataBinding.FieldName = 'Validation'
        MinWidth = 45
        Options.Sorting = False
      end
      object grdPromoPrizeItensFilterDBIDModel: TcxGridDBColumn
        DataBinding.FieldName = 'IDModel'
        Visible = False
        Options.Editing = False
        Options.Filtering = False
      end
      object grdPromoPrizeItensFilterDBModel: TcxGridDBColumn
        DataBinding.FieldName = 'Model'
        Options.Editing = False
        Options.Filtering = False
        SortOrder = soAscending
      end
      object grdPromoPrizeItensFilterDBDescription: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
        Options.Editing = False
        Options.Filtering = False
      end
    end
    object grdPromoPrizeItensFilterLevel: TcxGridLevel
      GridView = grdPromoPrizeItensFilterDB
    end
  end
  object quModel: TADODataSet [7]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'CAST(0 as Bit)' +
      ' as Validation '#13#10'FROM'#13#10#9'Model M (NOLOCK) '#13#10#9'LEFT JOIN Inv_ModelV' +
      'endor MV (NOLOCK) ON (MV.IDModel = M.IDModel AND MV.VendorOrder ' +
      '= 1)'#13#10#9'LEFT JOIN Sal_PromoPrizeItem PPI (NOLOCK) ON (PPI.IDModel' +
      ' = M.IDModel)'#13#10'WHERE   M.Desativado = 0'#13#10#9'AND PPI.IDModel IS NUL' +
      'L'#13#10#9'AND M.IDModel = IsNull(:IDModel, M.IDModel)'#13#10#9'AND IsNull(M.I' +
      'DModelGroup, -1) = IsNull(:IDModelGroup, IsNull(M.IDModelGroup, ' +
      '-1))'#13#10#9'AND IsNull(M.IDModelSubGroup, -1) = IsNull(:IDModelSubGro' +
      'up, IsNull(M.IDModelSubGroup, -1))'#13#10#9'AND M.GroupID = IsNull(:Gro' +
      'upID, M.GroupID)'#13#10#9'AND IsNull(MV.IDPessoa,-1) = IsNull(:IDPessoa' +
      ', IsNull(MV.IDPessoa,-1))'#13#10'               AND IsNull(M.IDFabrica' +
      'nte, -1) = IsNull(:IDFabricante, Isnull(M.IDFabricante, -1))'#13#10'  ' +
      '             AND M.ModelType IN ('#39'R'#39','#39'S'#39')'#13#10
    CommandTimeout = 380
    Parameters = <
      item
        Name = 'IDModel'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDModelGroup'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDModelSubGroup'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'GroupID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDPessoa'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDFabricante'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 156
    Top = 208
    object quModelIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quModelModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quModelDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quModelValidation: TBooleanField
      FieldName = 'Validation'
    end
  end
  object dspModel: TDataSetProvider [8]
    DataSet = quModel
    Options = [poIncFieldProps]
    Left = 260
    Top = 176
  end
  object cdsPromoPrizeItem: TClientDataSet [9]
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'IDModel'
        DataType = ftInteger
      end
      item
        Name = 'Model'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Description'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Validation'
        Attributes = [faReadonly]
        DataType = ftBoolean
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'dspModel'
    StoreDefs = True
    Left = 324
    Top = 208
    object cdsPromoPrizeItemIDModel: TIntegerField
      FieldName = 'IDModel'
      ReadOnly = True
    end
    object cdsPromoPrizeItemModel: TStringField
      FieldName = 'Model'
      ReadOnly = True
      Size = 30
    end
    object cdsPromoPrizeItemDescription: TStringField
      FieldName = 'Description'
      ReadOnly = True
      Size = 50
    end
    object cdsPromoPrizeItemValidation: TBooleanField
      FieldName = 'Validation'
    end
  end
  object dtsPromoPrizeItem: TDataSource [10]
    DataSet = cdsPromoPrizeItem
    Left = 328
    Top = 260
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmPromoPrizeItem.sil'
    Left = 27
    Top = 179
  end
  object cdsResult: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 575
    Top = 165
    object cdsResultIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsResultModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsResultDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
  end
end
