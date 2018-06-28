inherited FrmPrintDeliveryList: TFrmPrintDeliveryList
  Left = 227
  Top = 200
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Print Delivery List'
  ClientHeight = 174
  ClientWidth = 313
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 85
    Top = 59
    Width = 29
    Height = 13
    Alignment = taRightJustify
    Caption = 'Date :'
  end
  inherited Panel1: TPanel
    Top = 133
    Width = 313
    inherited EspacamentoInferior: TPanel
      Width = 313
      inherited Panel3: TPanel
        Width = 313
      end
    end
    inherited hhh: TPanel
      Left = 99
      Width = 214
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 144
        OnClick = btCloseClick
      end
      object btnPrint: TButton
        Left = 75
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Print'
        TabOrder = 1
        TabStop = False
        OnClick = btnPrintClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 127
  end
  inherited EspacamentoDireito: TPanel
    Left = 310
    Height = 127
  end
  inherited EspacamentoSuperior: TPanel
    Width = 313
  end
  object dtDelivery: TDateBox [5]
    Left = 120
    Top = 55
    Width = 121
    Height = 21
    TabOrder = 4
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmPrintDeliveryList.sil'
  end
end
