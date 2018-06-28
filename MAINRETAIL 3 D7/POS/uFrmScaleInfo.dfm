inherited FrmScaleInfo: TFrmScaleInfo
  Left = 377
  Top = 268
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Scale info'
  ClientHeight = 171
  ClientWidth = 386
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlButtom: TPanel
    Top = 130
    Width = 386
    inherited lblUserName: TLabel
      Top = 15
      Visible = False
    end
    inherited Label15: TLabel
      Visible = False
    end
    inherited hhh: TPanel
      Left = 170
      Width = 216
      inherited spHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 141
        OnClick = btCloseClick
      end
      object btnOK: TButton
        Left = 70
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
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btnOKClick
      end
    end
  end
  inherited pnlLine: TPanel
    Top = 128
    Width = 386
  end
  object GroupBox2: TGroupBox [2]
    Left = 0
    Top = 0
    Width = 386
    Height = 128
    Align = alClient
    Caption = 'Dados lidos da Balan'#231'a / Indicador'
    TabOrder = 2
    object Label8: TLabel
      Left = 93
      Top = 51
      Width = 72
      Height = 16
      Alignment = taRightJustify
      Caption = 'Peso Bruto :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 138
      Top = 130
      Width = 88
      Height = 13
      Caption = 'C'#243'digo do Produto'
      Visible = False
    end
    object Label10: TLabel
      Left = 267
      Top = 130
      Width = 63
      Height = 13
      Caption = 'Valor Unit'#225'rio'
      Visible = False
    end
    object Label11: TLabel
      Left = 9
      Top = 129
      Width = 22
      Height = 13
      Caption = 'Tara'
      Visible = False
    end
    object Label12: TLabel
      Left = 138
      Top = 178
      Width = 48
      Height = 13
      Caption = 'Contagem'
      Visible = False
    end
    object Label13: TLabel
      Left = 267
      Top = 178
      Width = 51
      Height = 13
      Caption = 'Valor Total'
      Visible = False
    end
    object Label14: TLabel
      Left = 9
      Top = 177
      Width = 36
      Height = 13
      Caption = 'L'#237'quido'
      Visible = False
    end
    object lblStatus: TLabel
      Left = 7
      Top = 110
      Width = 53
      Height = 13
      Caption = 'Parado...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbBruto: TLabel
      Left = 172
      Top = 47
      Width = 71
      Height = 24
      Caption = '----------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbProdutc: TLabel
      Left = 13
      Top = 19
      Width = 364
      Height = 27
      AutoSize = False
      Caption = 'lbProdutc'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label1: TLabel
      Left = 99
      Top = 87
      Width = 66
      Height = 16
      Alignment = taRightJustify
      Caption = 'Valor total :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbValorTotal: TLabel
      Left = 172
      Top = 88
      Width = 51
      Height = 16
      Caption = '----------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pnlCodigo: TPanel
      Left = 138
      Top = 145
      Width = 115
      Height = 28
      Caption = '--------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Visible = False
    end
    object pnlValUnit: TPanel
      Left = 267
      Top = 145
      Width = 115
      Height = 28
      Caption = '--------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      Visible = False
    end
    object pnlTara: TPanel
      Left = 9
      Top = 144
      Width = 115
      Height = 28
      Caption = '--------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      Visible = False
    end
    object pnlCont: TPanel
      Left = 138
      Top = 193
      Width = 115
      Height = 28
      Caption = '--------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      Visible = False
    end
    object pnlValTot: TPanel
      Left = 267
      Top = 193
      Width = 115
      Height = 28
      Caption = '--------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      Visible = False
    end
    object pnlLiquido: TPanel
      Left = 9
      Top = 192
      Width = 115
      Height = 28
      Caption = '--------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      Visible = False
    end
  end
  inherited siLang: TsiLangRT
    Left = 48
    Top = 96
  end
  object tmrScale: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tmrScaleTimer
    Left = 113
    Top = 98
  end
end
