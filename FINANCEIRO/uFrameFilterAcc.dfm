object FrameFilterAcc: TFrameFilterAcc
  Left = 0
  Top = 0
  Width = 708
  Height = 141
  Color = clHighlightText
  ParentColor = False
  TabOrder = 0
  object Label1: TLabel
    Left = 95
    Top = 34
    Width = 12
    Height = 13
    Caption = 'to'
    Font.Charset = ANSI_CHARSET
    Font.Color = 16745222
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 204
    Top = 32
    Width = 83
    Height = 13
    Alignment = taRightJustify
    Caption = 'Bank Account :'
    Font.Charset = ANSI_CHARSET
    Font.Color = 16745222
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 253
    Top = 8
    Width = 34
    Height = 13
    Alignment = taRightJustify
    Caption = 'Bank :'
    Font.Charset = ANSI_CHARSET
    Font.Color = 16745222
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 493
    Top = 31
    Width = 39
    Height = 13
    Alignment = taRightJustify
    Caption = 'Entity :'
    Font.Charset = ANSI_CHARSET
    Font.Color = 16745222
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 217
    Top = 58
    Width = 70
    Height = 13
    Alignment = taRightJustify
    Caption = 'Entity Type :'
    Font.Charset = ANSI_CHARSET
    Font.Color = 16745222
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnBank: TSpeedButton
    Left = 413
    Top = 4
    Width = 25
    Height = 19
    Caption = 'All'
    Flat = True
    Transparent = False
    OnClick = btnBankClick
  end
  object btnBKAcc: TSpeedButton
    Left = 413
    Top = 29
    Width = 25
    Height = 19
    Caption = 'All'
    Flat = True
    Transparent = False
    OnClick = btnBKAccClick
  end
  object btnEntType: TSpeedButton
    Left = 413
    Top = 54
    Width = 25
    Height = 19
    Caption = 'All'
    Flat = True
    Transparent = False
    OnClick = btnEntTypeClick
  end
  object btnEntity: TSpeedButton
    Left = 658
    Top = 27
    Width = 25
    Height = 19
    Caption = 'All'
    Flat = True
    Transparent = False
    OnClick = btnEntityClick
  end
  object Label6: TLabel
    Left = 12
    Top = 61
    Width = 86
    Height = 13
    Alignment = taRightJustify
    Caption = 'Record Status :'
    Font.Charset = ANSI_CHARSET
    Font.Color = 16745222
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 455
    Top = 56
    Width = 77
    Height = 13
    Alignment = taRightJustify
    Caption = 'Record Type :'
    Font.Charset = ANSI_CHARSET
    Font.Color = 16745222
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnRecType: TSpeedButton
    Left = 658
    Top = 52
    Width = 25
    Height = 19
    Caption = 'All'
    Flat = True
    Transparent = False
    OnClick = btnRecTypeClick
  end
  object Label8: TLabel
    Left = 471
    Top = 8
    Width = 61
    Height = 13
    Alignment = taRightJustify
    Caption = 'Doc. Type :'
    Font.Charset = ANSI_CHARSET
    Font.Color = 16745222
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SpeedButton1: TSpeedButton
    Left = 658
    Top = 4
    Width = 25
    Height = 19
    Caption = 'All'
    Flat = True
    Transparent = False
    OnClick = SpeedButton1Click
  end
  object dateIni: TdxDateEdit
    Left = 10
    Top = 30
    Width = 83
    TabOrder = 1
    Date = -700000
    SaveTime = False
  end
  object dateFim: TdxDateEdit
    Left = 112
    Top = 30
    Width = 80
    TabOrder = 2
    Date = -700000
    SaveTime = False
  end
  object scBank: TSuperComboADO
    Left = 290
    Top = 4
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '<All>'
    LookUpSource = DM.dsLUBanco
    IsListFiltered = False
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
  end
  object scBKAcc: TSuperComboADO
    Left = 290
    Top = 28
    Width = 121
    Height = 21
    TabOrder = 5
    Text = '<All>'
    LookUpSource = DM.dsLUContaCorrente
    IsListFiltered = False
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
  end
  object scEntity: TSuperComboADO
    Left = 535
    Top = 27
    Width = 121
    Height = 21
    TabOrder = 6
    Text = '<All>'
    LookUpSource = DM.dsLUPessoa
    IsListFiltered = False
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
  end
  object scEntType: TSuperComboADO
    Left = 290
    Top = 54
    Width = 121
    Height = 21
    TabOrder = 8
    Text = '<All>'
    LookUpSource = DM.dsLUPessoaTipo
    IsListFiltered = False
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    OnSelectItem = scEntTypeSelectItem
  end
  object cbxStatus: TComboBox
    Left = 101
    Top = 56
    Width = 90
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
    Items.Strings = (
      'All'
      'Open'
      'Paid'
      'Legal'
      'Canceled'
      'Partially Paid')
  end
  object cbxFilterDate: TComboBox
    Left = 10
    Top = 5
    Width = 182
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    Items.Strings = (
      'Record Date'
      'Issue Date'
      'Payment Date'
      'Due Date'
      'Transaction Date')
  end
  object scRecordType: TSuperComboADO
    Left = 535
    Top = 52
    Width = 121
    Height = 21
    TabOrder = 9
    Text = '<All>'
    LookUpSource = DM.dsLULancamentoTipo
    IsListFiltered = False
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
  end
  object scDocType: TSuperComboADO
    Left = 535
    Top = 4
    Width = 121
    Height = 21
    TabOrder = 7
    Text = '<All>'
    LookUpSource = DM.dsLUDocumentoTipo
    IsListFiltered = False
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
  end
  object quTempTable: TADOCommand
    CommandTimeout = 180
    Connection = DM.DBADOConnection
    Parameters = <>
    Left = 240
    Top = 65
  end
  object siLangFrame: TsiLangRT
    version = '5.2.5'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 3
    LangDispatcher = DMGlobal.LanguageDispatcher
    LangDelim = 1
    LangNames.Strings = (
      'English'
      'Português'
      'Español')
    Language = 'English'
    StorageFile = 'OM_FrameFilterAcc.sil'
    StorageDelimiter = '~!@#'
    ExtendedTranslations = <>
    RTEditorActionsOptions = []
    Left = 30
    Top = 15
    TranslationData = {
      737443617074696F6E730D0A737448696E74730D0A7374446973706C61794C61
      62656C730D0A7374466F6E74730D0A73744D756C74694C696E65730D0A737444
      6C677343617074696F6E730D0A5761726E696E67015761726E696E670101010D
      0A4572726F72014572726F720101010D0A496E666F726D6174696F6E01496E66
      6F726D6174696F6E0101010D0A436F6E6669726D01436F6E6669726D0101010D
      0A59657301265965730101010D0A4E6F01264E6F0101010D0A4F4B014F4B0101
      010D0A43616E63656C0143616E63656C0101010D0A41626F7274012641626F72
      740101010D0A5265747279012652657472790101010D0A49676E6F7265012649
      676E6F72650101010D0A416C6C0126416C6C0101010D0A4E6F20546F20416C6C
      014E266F20746F20416C6C0101010D0A59657320546F20416C6C015965732074
      6F2026416C6C0101010D0A48656C70012648656C700101010D0A737453747269
      6E67730D0A73744F74686572537472696E67730D0A73744C6F63616C65730D0A
      43757272656E637920537472696E6701240101010D0A54686F7573616E642053
      6570617261746F72012C0101010D0A446563696D616C20536570617261746F72
      012E0101010D0A4461746520536570617261746F72012F0101010D0A53686F72
      74204461746520466F726D6174014D2F642F797979790101010D0A4C6F6E6720
      4461746520466F726D617401646464642C204D4D4D4D2064642C207979797901
      01010D0A54696D6520536570617261746F72013A0101010D0A54696D6520414D
      20537472696E6701414D0101010D0A54696D6520504D20537472696E6701504D
      0101010D0A53686F72742054696D6520466F726D617401683A6D6D20414D504D
      0101010D0A4C6F6E672054696D6520466F726D617401683A6D6D3A737320414D
      504D0101010D0A53686F7274204D6F6E7468204E616D6573014A616E2C466562
      2C4D61722C4170722C4D61792C4A756E2C4A756C2C4175672C5365702C4F6374
      2C4E6F762C4465630101010D0A4C6F6E67204D6F6E7468204E616D6573014A61
      6E756172792C46656272756172792C4D617263682C417072696C2C4D61792C4A
      756E652C4A756C792C4175677573742C53657074656D6265722C4F63746F6265
      722C4E6F76656D6265722C446563656D6265720101010D0A53686F7274204461
      79204E616D65730153756E2C4D6F6E2C5475652C5765642C5468752C4672692C
      5361740101010D0A4C6F6E6720446179204E616D65730153756E6461792C4D6F
      6E6461792C547565736461792C5765646E65736461792C54687572736461792C
      4672696461792C53617475726461790101010D0A7374436F6C6C656374696F6E
      730D0A737443686172536574730D0A}
  end
end
