inherited FrmBonusBucksPercentAll: TFrmBonusBucksPercentAll
  Left = 721
  Top = 586
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Retail Systems - Main Retail 5'
  ClientHeight = 127
  ClientWidth = 250
  PixelsPerInch = 96
  TextHeight = 13
  object lblPercent: TLabel [0]
    Left = 32
    Top = 40
    Width = 60
    Height = 13
    Alignment = taRightJustify
    Caption = 'Percent (%) :'
  end
  inherited Panel1: TPanel
    Top = 86
    Width = 250
    TabOrder = 1
    inherited EspacamentoInferior: TPanel
      Width = 250
      TabOrder = 1
      inherited Panel3: TPanel
        Width = 250
      end
    end
    inherited hhh: TPanel
      Left = 36
      Width = 214
      TabOrder = 0
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 145
        Cancel = True
        ModalResult = 2
        TabOrder = 1
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
    Height = 80
    TabOrder = 2
  end
  inherited EspacamentoDireito: TPanel
    Left = 247
    Height = 80
    TabOrder = 3
  end
  inherited EspacamentoSuperior: TPanel
    Width = 250
    TabOrder = 4
  end
  object edtPercent: TEdit [5]
    Left = 96
    Top = 36
    Width = 81
    Height = 21
    BiDiMode = bdRightToLeft
    ParentBiDiMode = False
    TabOrder = 0
    Text = '0'
    OnKeyPress = edtPercentKeyPress
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmBonusBucksPercentAll.sil'
  end
end
