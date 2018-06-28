object AutoBuscaBox: TAutoBuscaBox
  Left = 425
  Top = 352
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Busca Impressora'
  ClientHeight = 68
  ClientWidth = 309
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlue
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 309
    Height = 68
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 4
      Width = 143
      Height = 13
      Caption = 'Procurando Impressora Fiscal :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = 13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Imp: TLabel
      Left = 160
      Top = 4
      Width = 21
      Height = 14
      Caption = 'Imp'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Porta: TLabel
      Left = 10
      Top = 45
      Width = 28
      Height = 14
      Caption = 'Porta:'
    end
    object barra: TProgressBar
      Left = 8
      Top = 24
      Width = 289
      Height = 13
      TabOrder = 0
    end
  end
end
