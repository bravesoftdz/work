object FrmImportInfo: TFrmImportInfo
  Left = 86
  Top = 137
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Import Info'
  ClientHeight = 503
  ClientWidth = 459
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 312
    Width = 459
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object Panel1: TPanel
    Left = 0
    Top = 462
    Width = 459
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      459
      41)
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 459
      Height = 6
      Align = alTop
      Shape = bsTopLine
    end
    object btnClose: TBitBtn
      Left = 378
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
  object sgridInfo: TStringGrid
    Left = 0
    Top = 41
    Width = 459
    Height = 271
    Align = alClient
    ColCount = 4
    DefaultRowHeight = 20
    FixedCols = 0
    ScrollBars = ssVertical
    TabOrder = 1
    OnDrawCell = sgridInfoDrawCell
    OnSelectCell = sgridInfoSelectCell
    ColWidths = (
      26
      137
      119
      149)
  end
  object pnlHistory: TPanel
    Left = 0
    Top = 315
    Width = 459
    Height = 147
    Align = alBottom
    TabOrder = 2
    object lbCashRegister: TLabel
      Left = 1
      Top = 1
      Width = 457
      Height = 13
      Align = alTop
      Alignment = taCenter
    end
    object lboxCashOpen: TListBox
      Left = 1
      Top = 14
      Width = 457
      Height = 132
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 459
    Height = 41
    Align = alTop
    TabOrder = 3
    object shpOK: TShape
      Left = 72
      Top = 10
      Width = 24
      Height = 22
      Brush.Color = clGreen
    end
    object Label1: TLabel
      Left = 101
      Top = 14
      Width = 55
      Height = 13
      Caption = 'OK (3 days)'
    end
    object Shape1: TShape
      Left = 179
      Top = 10
      Width = 24
      Height = 22
      Brush.Color = 4227327
    end
    object Label2: TLabel
      Left = 208
      Top = 14
      Width = 82
      Height = 13
      Caption = 'Warning (5 Days)'
    end
    object Shape2: TShape
      Left = 300
      Top = 10
      Width = 24
      Height = 22
      Brush.Color = clRed
    end
    object Label3: TLabel
      Left = 329
      Top = 14
      Width = 71
      Height = 13
      Caption = 'Critical (7 days)'
    end
  end
  object siLang: TsiLang
    version = '5.2.5'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 3
    LangDispatcher = DMGlobal.LanguageDispatcher
    LangDelim = 1
    LangNames.Strings = (
      'English'
      'Portugu'#234's'
      'Espa'#241'ol')
    Language = 'English'
    ExtendedTranslations = <>
    Left = 404
    Top = 12
    TranslationData = {
      737443617074696F6E730D0A5446726D496D706F7274496E666F01496D706F72
      7420496E666F01496D706F727461E7E36F01010D0A50616E656C31010101010D
      0A62746E436C6F7365012643616E63656C012643616E63656C617201010D0A73
      7448696E74730D0A5446726D496D706F7274496E666F01010D0A50616E656C31
      01010D0A426576656C3101010D0A62746E436C6F736501010D0A736772696449
      6E666F01010D0A7374446973706C61794C6162656C730D0A7374466F6E74730D
      0A5446726D496D706F7274496E666F014D532053616E73205365726966010D0A
      73744D756C74694C696E65730D0A7374446C677343617074696F6E730D0A5761
      726E696E67015761726E696E670101010D0A4572726F72014572726F72010101
      0D0A496E666F726D6174696F6E01496E666F726D6174696F6E0101010D0A436F
      6E6669726D01436F6E6669726D0101010D0A59657301265965730101010D0A4E
      6F01264E6F0101010D0A4F4B014F4B0101010D0A43616E63656C0143616E6365
      6C0101010D0A41626F7274012641626F72740101010D0A526574727901265265
      7472790101010D0A49676E6F7265012649676E6F72650101010D0A416C6C0126
      416C6C0101010D0A4E6F20546F20416C6C014E266F20746F20416C6C0101010D
      0A59657320546F20416C6C0159657320746F2026416C6C0101010D0A48656C70
      012648656C700101010D0A7374537472696E67730D0A73744F74686572537472
      696E67730D0A5446726D496D706F7274496E666F2E48656C7046696C6501010D
      0A5446726D496D706F7274496E666F2E48656C704B6579776F726401010D0A50
      616E656C312E48656C704B6579776F726401010D0A426576656C312E48656C70
      4B6579776F726401010D0A62746E436C6F73652E48656C704B6579776F726401
      010D0A7367726964496E666F2E48656C704B6579776F726401010D0A73744C6F
      63616C65730D0A43757272656E637920537472696E6701240101010D0A54686F
      7573616E6420536570617261746F72012C0101010D0A446563696D616C205365
      70617261746F72012E0101010D0A4461746520536570617261746F72012F0101
      010D0A53686F7274204461746520466F726D6174014D2F642F79797979010101
      0D0A4C6F6E67204461746520466F726D617401646464642C204D4D4D4D206464
      2C20797979790101010D0A54696D6520536570617261746F72013A0101010D0A
      54696D6520414D20537472696E6701414D0101010D0A54696D6520504D205374
      72696E6701504D0101010D0A53686F72742054696D6520466F726D617401683A
      6D6D20414D504D0101010D0A4C6F6E672054696D6520466F726D617401683A6D
      6D3A737320414D504D0101010D0A53686F7274204D6F6E7468204E616D657301
      4A616E2C4665622C4D61722C4170722C4D61792C4A756E2C4A756C2C4175672C
      5365702C4F63742C4E6F762C4465630101010D0A4C6F6E67204D6F6E7468204E
      616D6573014A616E756172792C46656272756172792C4D617263682C41707269
      6C2C4D61792C4A756E652C4A756C792C4175677573742C53657074656D626572
      2C4F63746F6265722C4E6F76656D6265722C446563656D6265720101010D0A53
      686F727420446179204E616D65730153756E2C4D6F6E2C5475652C5765642C54
      68752C4672692C5361740101010D0A4C6F6E6720446179204E616D6573015375
      6E6461792C4D6F6E6461792C547565736461792C5765646E65736461792C5468
      7572736461792C4672696461792C53617475726461790101010D0A7374436F6C
      6C656374696F6E730D0A737443686172536574730D0A5446726D496D706F7274
      496E666F0144454641554C545F43484152534554010D0A}
  end
end