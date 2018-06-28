inherited FrmSelectRebateCalendar: TFrmSelectRebateCalendar
  Left = 330
  Top = 223
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Retail Systems - Main Retail 3'
  ClientHeight = 138
  ClientWidth = 359
  PixelsPerInch = 96
  TextHeight = 13
  object lblCalendar: TLabel [0]
    Left = 61
    Top = 42
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'Calendar :'
  end
  inherited Panel1: TPanel
    Top = 97
    Width = 359
    TabOrder = 1
    inherited EspacamentoInferior: TPanel
      Width = 359
      TabOrder = 1
      inherited Panel3: TPanel
        Width = 359
      end
    end
    inherited hhh: TPanel
      Left = 146
      Width = 213
      TabOrder = 0
      inherited btClose: TButton
        Left = 144
        Cancel = True
        ModalResult = 2
        TabOrder = 1
      end
      object btOk: TButton
        Left = 75
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Ok'
        Default = True
        ModalResult = 1
        TabOrder = 0
        TabStop = False
        OnClick = btOkClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 91
    TabOrder = 2
  end
  inherited EspacamentoDireito: TPanel
    Left = 356
    Height = 91
    TabOrder = 3
  end
  inherited EspacamentoSuperior: TPanel
    Width = 359
    TabOrder = 4
  end
  object scRebateCalendar: TSuperComboADO [5]
    Left = 112
    Top = 39
    Width = 181
    Height = 21
    TabOrder = 0
    LookUpSource = DM.dsLookupRebateCalendar
    DropDownRows = 10
    IDLanguage = 0
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmSelectRebateCalendar.sil'
  end
end
