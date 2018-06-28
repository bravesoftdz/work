inherited FrmAdjustMinMaxAll: TFrmAdjustMinMaxAll
  Left = 257
  Top = 181
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Apply Min/Max All'
  ClientHeight = 148
  ClientWidth = 243
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbMin: TLabel [0]
    Left = 69
    Top = 28
    Width = 23
    Height = 13
    Alignment = taRightJustify
    Caption = 'Min :'
  end
  object lbMax: TLabel [1]
    Left = 67
    Top = 64
    Width = 26
    Height = 13
    Alignment = taRightJustify
    Caption = 'Max :'
  end
  inherited Panel1: TPanel
    Top = 107
    Width = 243
    TabOrder = 2
    inherited EspacamentoInferior: TPanel
      Width = 243
      inherited Panel3: TPanel
        Width = 243
      end
    end
    inherited hhh: TPanel
      Left = 12
      Width = 231
      inherited sbHelp: TSpeedButton
        Left = 24
        Visible = False
      end
      inherited btClose: TButton
        Left = 162
        ModalResult = 2
        OnClick = btCloseClick
      end
      object btnApply: TButton
        Left = 93
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Apply'
        Default = True
        ModalResult = 1
        TabOrder = 1
        TabStop = False
        OnClick = btnApplyClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 101
    TabOrder = 3
  end
  inherited EspacamentoDireito: TPanel
    Left = 240
    Height = 101
    TabOrder = 4
  end
  inherited EspacamentoSuperior: TPanel
    Width = 243
    TabOrder = 5
  end
  object edtMin: TEdit [6]
    Left = 100
    Top = 24
    Width = 89
    Height = 21
    TabOrder = 0
  end
  object edtMax: TEdit [7]
    Left = 101
    Top = 60
    Width = 89
    Height = 21
    TabOrder = 1
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmAdjustMinMaxAll.sil'
  end
end
