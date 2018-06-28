object RepConfigFrm: TRepConfigFrm
  Left = 307
  Top = 228
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Configuration'
  ClientHeight = 299
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object sbOpenBKP: TSpeedButton
    Left = 410
    Top = 82
    Width = 23
    Height = 21
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF0000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF00FFFF00FF009E9C009E9C009E9C009E9C009E9C00
      9E9C009E9C009E9C009E9C009E9C009E9C009E9C000000000000FF00FFFF00FF
      009E9CFFFFFF9CCFFF9CFFFF9CCFFF9CFFFF9CCFFF9CCFFF9CCFFF9CCFFF63CF
      CE009E9C000000000000FF00FF009E9CFFFFFF9CFFFF9CFFFF9CCFFF9CFFFF9C
      CFFF9CFFFF9CCFFF9CCFFF9CCFFF63CFCE000000009E9C000000FF00FF009E9C
      FFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCFFF9CCFFF009E
      9C000000009E9C000000009E9CFFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9C
      FFFF9CFFFF9CCFFF9CFFFF63CFCE00000063CFCE63CFCE000000009E9CFFFFFF
      9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCFFF63CFCE0000
      0063CFCE63CFCE000000009E9C009E9C009E9C009E9C009E9C009E9C009E9C00
      9E9C009E9C009E9C009E9C009E9C63CFCE9CFFFF63CFCE000000FF00FF009E9C
      FFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFF
      FF9CFFFF63CFCE000000FF00FF009E9CFFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9C
      FFFF9CFFFF9CFFFFFFFFFFFFFFFFFFFFFFFFFFFF63CFCE000000FF00FF009E9C
      FFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFFFFFFFF009E9C009E9C009E9C009E
      9C009E9C009E9CFF00FFFF00FFFF00FF009E9CFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF009E9CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF009E9C009E9C009E9C009E9C009E9CFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    OnClick = sbOpenBKPClick
  end
  object Label2: TLabel
    Left = 32
    Top = 68
    Width = 112
    Height = 13
    Caption = 'Select the Report folder'
  end
  object Label1: TLabel
    Left = 32
    Top = 116
    Width = 140
    Height = 13
    Caption = 'Select the logo path for report'
  end
  object btnLogo: TSpeedButton
    Left = 412
    Top = 132
    Width = 23
    Height = 21
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF0000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF00FFFF00FF009E9C009E9C009E9C009E9C009E9C00
      9E9C009E9C009E9C009E9C009E9C009E9C009E9C000000000000FF00FFFF00FF
      009E9CFFFFFF9CCFFF9CFFFF9CCFFF9CFFFF9CCFFF9CCFFF9CCFFF9CCFFF63CF
      CE009E9C000000000000FF00FF009E9CFFFFFF9CFFFF9CFFFF9CCFFF9CFFFF9C
      CFFF9CFFFF9CCFFF9CCFFF9CCFFF63CFCE000000009E9C000000FF00FF009E9C
      FFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCFFF9CCFFF009E
      9C000000009E9C000000009E9CFFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9C
      FFFF9CFFFF9CCFFF9CFFFF63CFCE00000063CFCE63CFCE000000009E9CFFFFFF
      9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CCFFF9CFFFF9CCFFF63CFCE0000
      0063CFCE63CFCE000000009E9C009E9C009E9C009E9C009E9C009E9C009E9C00
      9E9C009E9C009E9C009E9C009E9C63CFCE9CFFFF63CFCE000000FF00FF009E9C
      FFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFF
      FF9CFFFF63CFCE000000FF00FF009E9CFFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9C
      FFFF9CFFFF9CFFFFFFFFFFFFFFFFFFFFFFFFFFFF63CFCE000000FF00FF009E9C
      FFFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFFFFFFFF009E9C009E9C009E9C009E
      9C009E9C009E9CFF00FFFF00FFFF00FF009E9CFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF009E9CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF009E9C009E9C009E9C009E9C009E9CFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    OnClick = btnLogoClick
  end
  object Label3: TLabel
    Left = 32
    Top = 164
    Width = 120
    Height = 13
    Caption = 'Web file for update report'
    Visible = False
  end
  object Label4: TLabel
    Left = 32
    Top = 16
    Width = 85
    Height = 13
    Caption = 'Default Language'
  end
  object Label5: TLabel
    Left = 32
    Top = 163
    Width = 59
    Height = 13
    Caption = 'Printer name'
  end
  object edtPath: TEdit
    Left = 32
    Top = 84
    Width = 373
    Height = 21
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 269
    Width = 441
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 441
      Height = 4
      Align = alTop
      Shape = bsTopLine
    end
    object Button1: TButton
      Left = 360
      Top = 5
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object Button2: TButton
      Left = 280
      Top = 5
      Width = 75
      Height = 25
      Caption = '&Ok'
      ModalResult = 1
      TabOrder = 0
    end
  end
  object edtLogoPath: TEdit
    Left = 32
    Top = 132
    Width = 373
    Height = 21
    TabOrder = 2
  end
  object cbxWebDownload: TComboBox
    Left = 32
    Top = 180
    Width = 374
    Height = 21
    ItemHeight = 13
    TabOrder = 3
    Visible = False
    Items.Strings = (
      'http://www.mainretail.com/download/reports/versioncontrol.ini'
      'http://www.mainretail.com/download/reports_en/versioncontrol.ini')
  end
  object cbxLanguage: TdxImageComboBox
    Left = 32
    Top = 32
    Width = 377
    Height = 24
    Alignment = taLeftJustify
    ImageAlign = dxliLeft
    ItemHeight = 0
    ImageList = DMReport.imgSmall
    MultiLines = False
    VertAlignment = tvaCenter
    Items.Strings = (
      'English'
      'Portugu'#234's'
      'Espa'#241'ol')
    TabOrder = 0
    OnChange = cbxLanguageChange
    SaveStrings = (
      '55,1'
      '57,'
      '56,'
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      '')
  end
  object cmbPrinter: TComboBox
    Left = 32
    Top = 179
    Width = 373
    Height = 21
    ItemHeight = 13
    TabOrder = 4
    Text = 'cmbPrinter'
  end
  object OD: TOpenDialog
    Filter = 'All Files|*.*'
    Left = 182
    Top = 251
  end
  object siLang: TsiLang
    Version = '6.1.0.1'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 3
    LangDispatcher = DMReport.LanguageDispatcher
    LangDelim = 1
    LangNames.Strings = (
      'English'
      'Portugu'#234's'
      'Espa'#241'ol')
    Language = 'English'
    ExcludedProperties.Strings = (
      'Category'
      'SecondaryShortCuts'
      'HelpKeyword'
      'InitialDir'
      'HelpKeyword'
      'ActivePage'
      'ImeName'
      'DefaultExt'
      'FileName'
      'FieldName'
      'PickList'
      'DisplayFormat'
      'EditMask'
      'KeyList'
      'LookupDisplayFields'
      'DropDownSpecRow'
      'TableName'
      'DatabaseName'
      'IndexName'
      'MasterFields')
    Left = 140
    Top = 252
    TranslationData = {
      737443617074696F6E730D0A54526570436F6E66696746726D01436F6E666967
      75726174696F6E01436F6E666967757261E7E36F2001436F6E66696775726163
      69F36E20010D0A73624F70656E424B50010101010D0A4C6162656C320153656C
      65637420746865205265706F727420666F6C646572014469726574F372696F20
      646F732072656C6174F372696F730153656C656363696F6E6172206C61206361
      72706574612064656C20696E666F726D65010D0A4C6162656C310153656C6563
      7420746865206C6F676F207061746820666F72207265706F72740153656C6563
      696F6E617220756D206C6F676F2070617261206F732072656C6174F372696F73
      0153656C656363696F6E6172206C6120747261796563746F726961206465206C
      6120696E7369676E6961207061726120656C20696E666F726D6520010D0A6274
      6E4C6F676F010101010D0A4C6162656C33015765622066696C6520666F722075
      7064617465207265706F7274014172717569766F207765622070617261206174
      75616C697A6172206F732072656C6174F372696F73014172636869766F206465
      6C20576562207061726120656C20696E666F726D65206465206C612061637475
      616C697A616369F36E20010D0A50616E656C31010101010D0A427574746F6E31
      012643616E63656C012643616E63656C6172012643616E63656C6172010D0A42
      7574746F6E3201264F6B01264F4B01264F4B010D0A4C6162656C340144656661
      756C74204C616E6775616765014964696F6D612070616472E36F014C656E6775
      61010D0A4C6162656C35015072696E746572206E616D6501496D70726573736F
      7261014E6F6D627265206465206C6120696D707265736F7261010D0A73744869
      6E74730D0A54526570436F6E66696746726D01010D0A73624F70656E424B5001
      010D0A4C6162656C3201010D0A4C6162656C3101010D0A62746E4C6F676F0101
      0D0A4C6162656C3301010D0A6564745061746801010D0A50616E656C3101010D
      0A426576656C3101010D0A427574746F6E3101010D0A427574746F6E3201010D
      0A6564744C6F676F5061746801010D0A636278576562446F776E6C6F61640101
      0D0A4C6162656C3401010D0A6362784C616E677561676501010D0A4C6162656C
      35010101010D0A636D625072696E746572010101010D0A7374446973706C6179
      4C6162656C730D0A7374466F6E74730D0A54526570436F6E66696746726D014D
      532053616E732053657269660101010D0A73744D756C74694C696E65730D0A63
      6278576562446F776E6C6F61642E4974656D7301687474703A2F2F7777772E6D
      61696E72657461696C2E636F6D2F646F776E6C6F61642F7265706F7274732F76
      657273696F6E636F6E74726F6C2E696E692C687474703A2F2F7777772E333630
      7065742E636F6D2F646F776E6C6F61642F7265706F7274732F76657273696F6E
      636F6E74726F6C2E696E690101010D0A6362784C616E67756167652E4974656D
      7301456E676C6973682C506F7274756775EA732C45737061F16F6C0101010D0A
      636D625072696E7465722E4974656D73010101010D0A7374446C677343617074
      696F6E730D0A5761726E696E67015761726E696E670101010D0A4572726F7201
      4572726F720101010D0A496E666F726D6174696F6E01496E666F726D6174696F
      6E0101010D0A436F6E6669726D01436F6E6669726D0101010D0A596573012659
      65730101010D0A4E6F01264E6F0101010D0A4F4B014F4B0101010D0A43616E63
      656C0143616E63656C0101010D0A41626F7274012641626F72740101010D0A52
      65747279012652657472790101010D0A49676E6F7265012649676E6F72650101
      010D0A416C6C0126416C6C0101010D0A4E6F20546F20416C6C014E266F20746F
      20416C6C0101010D0A59657320546F20416C6C0159657320746F2026416C6C01
      01010D0A48656C70012648656C700101010D0A7374537472696E67730D0A7374
      4F74686572537472696E67730D0A54526570436F6E66696746726D2E48656C70
      46696C65010101010D0A656474506174682E54657874010101010D0A6564744C
      6F676F506174682E54657874010101010D0A636278576562446F776E6C6F6164
      2E54657874010101010D0A4F442E46696C74657201416C6C2046696C65737C2A
      2E2A0101010D0A4F442E5469746C65010101010D0A636D625072696E7465722E
      5465787401636D625072696E7465720101010D0A73744C6F63616C65730D0A43
      757272656E637920537472696E6701240101010D0A54686F7573616E64205365
      70617261746F72012C0101010D0A446563696D616C20536570617261746F7201
      2E0101010D0A4461746520536570617261746F72012F0101010D0A53686F7274
      204461746520466F726D6174014D2F642F797979790101010D0A4C6F6E672044
      61746520466F726D617401646464642C204D4D4D4D2064642C20797979790101
      010D0A54696D6520536570617261746F72013A0101010D0A54696D6520414D20
      537472696E6701414D0101010D0A54696D6520504D20537472696E6701504D01
      01010D0A53686F72742054696D6520466F726D617401683A6D6D20414D504D01
      01010D0A4C6F6E672054696D6520466F726D617401683A6D6D3A737320414D50
      4D0101010D0A53686F7274204D6F6E7468204E616D6573014A616E2C4665622C
      4D61722C4170722C4D61792C4A756E2C4A756C2C4175672C5365702C4F63742C
      4E6F762C4465630101010D0A4C6F6E67204D6F6E7468204E616D6573014A616E
      756172792C46656272756172792C4D617263682C417072696C2C4D61792C4A75
      6E652C4A756C792C4175677573742C53657074656D6265722C4F63746F626572
      2C4E6F76656D6265722C446563656D6265720101010D0A53686F727420446179
      204E616D65730153756E2C4D6F6E2C5475652C5765642C5468752C4672692C53
      61740101010D0A4C6F6E6720446179204E616D65730153756E6461792C4D6F6E
      6461792C547565736461792C5765646E65736461792C54687572736461792C46
      72696461792C53617475726461790101010D0A7374436F6C6C656374696F6E73
      0D0A737443686172536574730D0A54526570436F6E66696746726D0144454641
      554C545F434841525345540101010D0A}
  end
end
