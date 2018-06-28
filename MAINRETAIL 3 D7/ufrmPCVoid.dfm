inherited frmPCVoid: TfrmPCVoid
  Left = 246
  Top = 220
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Void Sale'
  ClientHeight = 153
  ClientWidth = 214
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 112
    Width = 214
    TabOrder = 2
    inherited EspacamentoInferior: TPanel
      Width = 214
      inherited Panel3: TPanel
        Width = 214
      end
    end
    inherited hhh: TPanel
      Left = -27
      Width = 241
      inherited sbHelp: TSpeedButton
        Left = 172
        Visible = False
      end
      inherited btClose: TButton
        Left = 171
        TabOrder = 1
        OnClick = btCloseClick
      end
      object Button1: TButton
        Left = 100
        Top = 3
        Width = 66
        Height = 31
        Caption = '&OK'
        TabOrder = 0
        OnClick = Button1Click
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 106
    TabOrder = 3
  end
  inherited EspacamentoDireito: TPanel
    Left = 211
    Height = 106
    TabOrder = 4
  end
  inherited EspacamentoSuperior: TPanel
    Width = 214
    TabOrder = 5
  end
  object pnlVoid: TPanel [4]
    Left = 0
    Top = 7
    Width = 214
    Height = 105
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 8
      Width = 75
      Height = 13
      Alignment = taRightJustify
      Caption = 'TroutD/RefNo :'
    end
    object Label2: TLabel
      Left = 31
      Top = 58
      Width = 55
      Height = 13
      Alignment = taRightJustify
      Caption = 'InvoiceNo :'
    end
    object Label3: TLabel
      Left = 44
      Top = 83
      Width = 42
      Height = 13
      Alignment = taRightJustify
      Caption = 'Amount :'
    end
    object Label4: TLabel
      Left = 27
      Top = 33
      Width = 59
      Height = 13
      Alignment = taRightJustify
      Caption = 'Auth. Code :'
    end
    object edtTroutD: TEdit
      Left = 90
      Top = 4
      Width = 75
      Height = 21
      TabOrder = 0
    end
    object edtInvoiceNum: TEdit
      Left = 90
      Top = 54
      Width = 75
      Height = 21
      TabOrder = 2
    end
    object edtAmount: TEdit
      Left = 90
      Top = 79
      Width = 75
      Height = 21
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object edtAuthcode: TEdit
      Left = 90
      Top = 29
      Width = 75
      Height = 21
      TabOrder = 1
    end
  end
  object pnlLastDigit: TPanel [5]
    Left = 1
    Top = 6
    Width = 208
    Height = 106
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    object lbLastDigit: TLabel
      Left = 21
      Top = 55
      Width = 64
      Height = 13
      Alignment = taRightJustify
      Caption = 'Last 4 Digits :'
    end
    object Label5: TLabel
      Left = 16
      Top = 10
      Width = 189
      Height = 34
      AutoSize = False
      Caption = 'Please, enter the last four Credit Card digits and press ENTER.'
      WordWrap = True
    end
    object edtLastDigit: TEdit
      Left = 89
      Top = 51
      Width = 75
      Height = 21
      TabOrder = 0
      OnKeyDown = edtLastDigitKeyDown
    end
  end
  inherited siLang: TsiLangRT
    Left = 168
  end
end
