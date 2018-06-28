inherited FrmAskSalesPerson: TFrmAskSalesPerson
  Left = 260
  Top = 245
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Ask Sales Person'
  ClientHeight = 167
  ClientWidth = 343
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbUserCode: TLabel [0]
    Left = 36
    Top = 40
    Width = 56
    Height = 13
    Alignment = taRightJustify
    Caption = 'User Code :'
  end
  object lbPrice: TLabel [1]
    Left = 60
    Top = 83
    Width = 31
    Height = 13
    Alignment = taRightJustify
    Caption = 'User  :'
  end
  object Label2: TLabel [2]
    Left = 304
    Top = 81
    Width = 14
    Height = 23
    Hint = 'Field can not be empty'
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object btnSearch: TSpeedButton [3]
    Left = 304
    Top = 36
    Width = 23
    Height = 22
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
    OnClick = edtCodeExit
  end
  inherited Panel1: TPanel
    Top = 126
    Width = 343
    TabOrder = 2
    inherited EspacamentoInferior: TPanel
      Width = 343
      inherited Panel3: TPanel
        Width = 343
      end
    end
    inherited hhh: TPanel
      Left = 125
      Width = 218
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 147
        TabOrder = 1
        OnClick = btCloseClick
      end
      object btnOk: TButton
        Left = 76
        Top = 3
        Width = 66
        Height = 31
        Caption = '&OK'
        Default = True
        ModalResult = 1
        TabOrder = 0
        TabStop = False
        OnClick = btnOkClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 120
    TabOrder = 3
  end
  inherited EspacamentoDireito: TPanel
    Left = 340
    Height = 120
    TabOrder = 4
  end
  inherited EspacamentoSuperior: TPanel
    Width = 343
    TabOrder = 5
  end
  object edtCode: TEdit [8]
    Left = 100
    Top = 36
    Width = 200
    Height = 21
    Color = 12910591
    TabOrder = 0
    OnEnter = edtCodeEnter
    OnExit = edtCodeExit
    OnKeyPress = edtCodeKeyPress
  end
  object scUser: TSuperComboADO [9]
    Left = 100
    Top = 78
    Width = 200
    Height = 21
    TabOrder = 1
    LookUpSource = DM.dsLookUpUser
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
    OnSelectItem = scUserSelectItem
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmAskSalesPerson.sil'
  end
end
