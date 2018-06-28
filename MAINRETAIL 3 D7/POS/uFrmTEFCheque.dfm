object FrmTEFCheque: TFrmTEFCheque
  Left = 129
  Top = 181
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cheque'
  ClientHeight = 142
  ClientWidth = 456
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlLeituraCMC7: TPanel
    Left = 15
    Top = 16
    Width = 433
    Height = 89
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 120
      Top = 40
      Width = 144
      Height = 13
      Caption = 'Leitura autom'#225'tica do cheque!'
    end
    object edtCMC7: TEdit
      Left = 0
      Top = 93
      Width = 401
      Height = 21
      TabOrder = 0
    end
  end
  object btnAbort: TButton
    Left = 9
    Top = 108
    Width = 72
    Height = 27
    Cancel = True
    Caption = '&Abortar'
    TabOrder = 2
    OnClick = btnAbortClick
  end
  object Selecionar: TButton
    Left = 364
    Top = 108
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 3
    OnClick = SelecionarClick
  end
  object pnlManual: TPanel
    Left = 11
    Top = 24
    Width = 435
    Height = 73
    BevelOuter = bvNone
    TabOrder = 0
    object edtCompens: TLabeledEdit
      Left = 8
      Top = 24
      Width = 69
      Height = 21
      EditLabel.Width = 68
      EditLabel.Height = 13
      EditLabel.Caption = 'Compensa'#231#227'o'
      MaxLength = 3
      TabOrder = 0
      OnEnter = edtCompensEnter
      OnKeyUp = edtCompensKeyUp
    end
    object edtBanco: TLabeledEdit
      Left = 83
      Top = 24
      Width = 38
      Height = 21
      EditLabel.Width = 31
      EditLabel.Height = 13
      EditLabel.Caption = 'Banco'
      MaxLength = 3
      TabOrder = 1
      OnEnter = edtCompensEnter
      OnKeyUp = edtCompensKeyUp
    end
    object edtAgencia: TLabeledEdit
      Left = 125
      Top = 24
      Width = 53
      Height = 21
      EditLabel.Width = 39
      EditLabel.Height = 13
      EditLabel.Caption = 'Agencia'
      MaxLength = 4
      TabOrder = 2
      OnEnter = edtCompensEnter
      OnKeyUp = edtCompensKeyUp
    end
    object edtC1: TLabeledEdit
      Left = 179
      Top = 24
      Width = 21
      Height = 21
      EditLabel.Width = 13
      EditLabel.Height = 13
      EditLabel.Caption = 'C1'
      MaxLength = 1
      TabOrder = 3
      OnEnter = edtCompensEnter
      OnKeyUp = edtCompensKeyUp
    end
    object edtContaC: TLabeledEdit
      Left = 202
      Top = 24
      Width = 79
      Height = 21
      EditLabel.Width = 71
      EditLabel.Height = 13
      EditLabel.Caption = 'Conta Corrente'
      MaxLength = 10
      TabOrder = 4
      OnEnter = edtCompensEnter
      OnKeyUp = edtCompensKeyUp
    end
    object edtC2: TLabeledEdit
      Left = 283
      Top = 24
      Width = 21
      Height = 21
      EditLabel.Width = 13
      EditLabel.Height = 13
      EditLabel.Caption = 'C2'
      MaxLength = 1
      TabOrder = 5
      OnEnter = edtCompensEnter
      OnKeyUp = edtCompensKeyUp
    end
    object edtNumCheque: TLabeledEdit
      Left = 306
      Top = 24
      Width = 93
      Height = 21
      EditLabel.Width = 92
      EditLabel.Height = 13
      EditLabel.Caption = 'Numero do Cheque'
      MaxLength = 6
      TabOrder = 6
      OnEnter = edtCompensEnter
      OnKeyUp = edtCompensKeyUp
    end
    object edtC3: TLabeledEdit
      Left = 403
      Top = 24
      Width = 21
      Height = 21
      EditLabel.Width = 13
      EditLabel.Height = 13
      EditLabel.Caption = 'C3'
      MaxLength = 1
      TabOrder = 7
      OnEnter = edtCompensEnter
      OnKeyUp = edtCompensKeyUp
    end
  end
end
