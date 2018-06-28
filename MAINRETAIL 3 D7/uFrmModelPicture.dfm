inherited FrmModelPicture: TFrmModelPicture
  Left = 70
  Top = 89
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = ''
  ClientHeight = 289
  ClientWidth = 603
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 248
    Width = 603
    inherited EspacamentoInferior: TPanel
      Width = 603
      inherited Panel3: TPanel
        Width = 603
      end
    end
    inherited hhh: TPanel
      Left = 452
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Default = True
        OnClick = btCloseClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 242
    Visible = False
  end
  inherited EspacamentoDireito: TPanel
    Left = 600
    Height = 242
    Visible = False
  end
  inherited EspacamentoSuperior: TPanel
    Width = 603
    Visible = False
  end
  object SubWebModel: TSubListPanel [4]
    Left = 3
    Top = 6
    Width = 597
    Height = 242
    Align = alClient
    BevelOuter = bvNone
    Color = clBtnShadow
    TabOrder = 4
    SubListClassName = 'TSubModelWebInfo'
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmModelPicture.sil'
  end
end
