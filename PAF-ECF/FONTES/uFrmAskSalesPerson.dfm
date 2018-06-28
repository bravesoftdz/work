inherited FrmAskSalesPerson: TFrmAskSalesPerson
  Left = 242
  Top = 235
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Ask Sales Person'
  ClientHeight = 180
  ClientWidth = 432
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbPrice: TLabel [0]
    Left = 36
    Top = 65
    Width = 92
    Height = 16
    Alignment = taRightJustify
    Caption = 'Sales Person :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbUserCode: TLabel [1]
    Left = 87
    Top = 26
    Width = 41
    Height = 16
    Alignment = taRightJustify
    Caption = 'Code :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited pnlButtom: TPanel
    Top = 139
    Width = 432
    TabOrder = 3
    inherited lblUserName: TLabel
      Visible = False
    end
    inherited Label15: TLabel
      Visible = False
    end
    inherited hhh: TPanel
      Left = 218
      Width = 214
      inherited spHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 141
        ModalResult = 2
      end
      object btnOK: TButton
        Left = 73
        Top = 6
        Width = 66
        Height = 31
        Caption = 'OK'
        Default = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ModalResult = 1
        ParentFont = False
        TabOrder = 1
        TabStop = False
      end
    end
  end
  inherited pnlLine: TPanel
    Top = 137
    Width = 432
    TabOrder = 4
  end
  object cmbUser: TDBLookupComboBox [4]
    Left = 139
    Top = 60
    Width = 233
    Height = 27
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    KeyField = 'IDUser'
    ListField = 'SystemUser'
    ListSource = DM.dsSystemUser
    ParentFont = False
    TabOrder = 1
    OnCloseUp = cmbUserCloseUp
    OnDropDown = cmbUserDropDown
  end
  object chcApplyAll: TCheckBox [5]
    Left = 140
    Top = 103
    Width = 260
    Height = 18
    Caption = 'Repeat Sales Person for next items'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object edUserCode: TEdit [6]
    Left = 140
    Top = 23
    Width = 229
    Height = 26
    Color = 8454143
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnEnter = edUserCodeEnter
    OnExit = edUserCodeExit
    OnKeyPress = edUserCodeKeyPress
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmAskSalesPerson.sil'
  end
end
