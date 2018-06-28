inherited FrmSaleConsult: TFrmSaleConsult
  Left = 155
  Top = 104
  Width = 555
  Height = 440
  BorderIcons = [biSystemMenu]
  Caption = 'Sale Consult'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 372
    Width = 547
    inherited EspacamentoInferior: TPanel
      Width = 547
      inherited Panel3: TPanel
        Width = 547
      end
    end
    inherited hhh: TPanel
      Left = 396
      inherited sbHelp: TSpeedButton
        Left = 78
      end
      inherited btClose: TButton
        Caption = '&Cancel'
        OnClick = btCloseClick
      end
      object btOK: TButton
        Left = 4
        Top = 3
        Width = 66
        Height = 31
        Caption = '&OK'
        Default = True
        TabOrder = 1
        TabStop = False
        OnClick = btOKClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 366
    Visible = False
  end
  inherited EspacamentoDireito: TPanel
    Left = 544
    Height = 366
    Visible = False
  end
  inherited EspacamentoSuperior: TPanel
    Width = 547
    Visible = False
  end
  object slSubSaleConsult: TSubListPanel [4]
    Left = 3
    Top = 6
    Width = 541
    Height = 366
    Align = alClient
    BevelOuter = bvNone
    Caption = 'TSubSaleConsult'
    Color = clBtnShadow
    TabOrder = 4
    SubListClassName = 'TSubSaleConsult'
    AfterParamChanged = slSubSaleConsultAfterParamChanged
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmSaleConsult.sil'
  end
end
