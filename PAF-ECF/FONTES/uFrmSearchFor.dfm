inherited FrmSearchFor: TFrmSearchFor
  Left = 2
  Top = -1
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Search for'
  ClientHeight = 550
  ClientWidth = 788
  KeyPreview = True
  OldCreateOrder = True
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel [0]
    Left = 0
    Top = 0
    Width = 788
    Height = 68
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object imgSearch: TImage
      Left = 5
      Top = 3
      Width = 37
      Height = 33
      Transparent = True
    end
    object lbSearchOption: TLabel
      Left = 47
      Top = 12
      Width = 125
      Height = 20
      Caption = 'lbSearchOption'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtValue: TEdit
      Left = 47
      Top = 36
      Width = 418
      Height = 28
      Color = 8454143
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnKeyDown = edtValueKeyDown
      OnKeyPress = edtValueKeyPress
    end
    object pnlCustomer: TPanel
      Left = 674
      Top = 0
      Width = 114
      Height = 68
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object lbInfo: TLabel
        Left = 2
        Top = 14
        Width = 90
        Height = 13
        Caption = '(F2) New Customer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lbSearchName: TLabel
        Left = 2
        Top = 27
        Width = 86
        Height = 13
        Caption = '(F3) Search Name'
      end
      object lbSearchPhone: TLabel
        Left = 2
        Top = 40
        Width = 89
        Height = 13
        Caption = '(F4) Search Phone'
      end
      object lblHelp: TLabel
        Left = 2
        Top = 1
        Width = 43
        Height = 13
        Caption = '(F1) Help'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lbF5: TLabel
        Left = 2
        Top = 53
        Width = 84
        Height = 13
        Caption = '(F5) Procurar CPF'
      end
    end
    object pnlIdentification: TPanel
      Left = 472
      Top = 0
      Width = 202
      Height = 68
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
      object lblIdent: TLabel
        Left = 3
        Top = 12
        Width = 106
        Height = 20
        Caption = 'Identification'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtIdentification: TEdit
        Left = 3
        Top = 36
        Width = 190
        Height = 28
        Color = 8454143
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  object pnlModelInfo: TPanel [1]
    Left = 0
    Top = 448
    Width = 788
    Height = 102
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    object lbModel: TLabel
      Left = 43
      Top = 8
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Caption = 'Model :'
    end
    object lbDescrip: TLabel
      Left = 19
      Top = 24
      Width = 59
      Height = 13
      Alignment = taRightJustify
      Caption = 'Description :'
    end
    object lbCateg: TLabel
      Left = 30
      Top = 39
      Width = 48
      Height = 13
      Alignment = taRightJustify
      Caption = 'Category :'
    end
    object lbSalePrice: TLabel
      Left = 601
      Top = 8
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = 'Sale price :'
    end
    object lbPromotion: TLabel
      Left = 603
      Top = 50
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = 'Promotion :'
    end
    object lbHoriz: TLabel
      Left = 322
      Top = 8
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = 'Horizontal :'
    end
    object lbVertic: TLabel
      Left = 334
      Top = 24
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = 'Vertical :'
    end
    object lbManufect: TLabel
      Left = 9
      Top = 56
      Width = 69
      Height = 13
      Alignment = taRightJustify
      Caption = 'Manufacturer :'
    end
    object lbUnidade: TLabel
      Left = 328
      Top = 39
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = 'Measure :'
    end
    object lbIndArr: TLabel
      Left = 306
      Top = 54
      Width = 69
      Height = 13
      Alignment = taRightJustify
      Caption = 'Indicador Arr. :'
    end
    object lbIndProd: TLabel
      Left = 297
      Top = 70
      Width = 78
      Height = 13
      Alignment = taRightJustify
      Caption = 'Indicador Prod. :'
    end
    object Label1: TLabel
      Left = 0
      Top = 73
      Width = 78
      Height = 13
      Alignment = taRightJustify
      Caption = 'Situacao Tribut.:'
    end
    object edtModel: TDBEdit
      Left = 83
      Top = 8
      Width = 229
      Height = 16
      TabStop = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      DataField = 'Model'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object edtDesc: TDBEdit
      Left = 83
      Top = 24
      Width = 229
      Height = 16
      TabStop = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      DataField = 'Description'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtCategory: TDBEdit
      Left = 83
      Top = 39
      Width = 212
      Height = 16
      TabStop = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      DataField = 'TabGroup'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object edtPrice: TDBEdit
      Left = 658
      Top = 7
      Width = 123
      Height = 25
      TabStop = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      DataField = 'SellingPrice'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object edtPromotion: TDBEdit
      Left = 661
      Top = 49
      Width = 121
      Height = 28
      TabStop = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      DataField = 'PromotionPrice'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
    object edtHoriz: TDBEdit
      Left = 433
      Top = 8
      Width = 143
      Height = 16
      TabStop = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      DataField = 'Color'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
    object edtVerti: TDBEdit
      Left = 433
      Top = 24
      Width = 143
      Height = 16
      TabStop = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      DataField = 'SizeName'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
    end
    object edtCodHoriz: TDBEdit
      Left = 380
      Top = 8
      Width = 52
      Height = 16
      TabStop = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      DataField = 'CodColor'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 7
    end
    object edtVertCod: TDBEdit
      Left = 380
      Top = 24
      Width = 52
      Height = 16
      TabStop = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      DataField = 'CodSize'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 8
    end
    object edtManufac: TDBEdit
      Left = 83
      Top = 56
      Width = 207
      Height = 16
      TabStop = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      DataField = 'Fabricante'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 9
    end
    object edtUnidade: TDBEdit
      Left = 380
      Top = 39
      Width = 52
      Height = 16
      TabStop = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      DataField = 'Unidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 10
    end
    object edtIndicadorAT: TDBEdit
      Left = 380
      Top = 54
      Width = 52
      Height = 16
      TabStop = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      DataField = 'IndicadorAT'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 11
    end
    object edtIndicadorProducao: TDBEdit
      Left = 380
      Top = 70
      Width = 52
      Height = 16
      TabStop = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      DataField = 'IndicadorProducao'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 12
    end
    object edtDescSituTribut: TDBEdit
      Left = 82
      Top = 73
      Width = 209
      Height = 16
      TabStop = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      DataField = 'DescSituTribut'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 13
    end
  end
  object pnlListModel: TPanel [2]
    Left = 0
    Top = 68
    Width = 788
    Height = 380
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object SMDBGrid1: TSMDBGrid
      Left = 0
      Top = 0
      Width = 788
      Height = 380
      TabStop = False
      Align = alClient
      DataSource = dsGrid
      Options = [dgTitles, dgIndicator, dgRowLines, dgRowSelect]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Flat = True
      Groupings = <>
      GridStyle.Style = gsCustom
      GridStyle.OddColor = 16119285
      GridStyle.EvenColor = clWindow
      FooterColor = clBtnFace
      ExOptions = [eoAutoWidth]
      RegistryKey = 'Software\Scalabium'
      RegistrySection = 'SMDBGrid'
      WidthOfIndicator = 11
      DefaultRowHeight = 17
      ScrollBars = ssVertical
      ColCount = 2
      RowCount = 2
    end
  end
  object dsGrid: TDataSource [3]
    OnDataChange = dsGridDataChange
    Left = 140
    Top = 157
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmSearchFor.sil'
  end
  object tmrRefresh: TTimer
    Enabled = False
    OnTimer = tmrRefreshTimer
    Left = 210
    Top = 157
  end
  object dsQty: TDataSource
    DataSet = DMPDV.cdsQty
    Left = 667
    Top = 271
  end
end
