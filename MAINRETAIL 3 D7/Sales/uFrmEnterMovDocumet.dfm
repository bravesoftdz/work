inherited FrmEnterMovDocumet: TFrmEnterMovDocumet
  Left = 392
  Top = 217
  Width = 416
  Height = 238
  BorderIcons = []
  Caption = 'FrmEnterMovDocumet'
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object lblDocNumber: TLabel [0]
    Left = 52
    Top = 76
    Width = 44
    Height = 13
    BiDiMode = bdRightToLeft
    Caption = 'Number :'
    ParentBiDiMode = False
  end
  object lblDocType: TLabel [1]
    Left = 41
    Top = 108
    Width = 55
    Height = 13
    BiDiMode = bdRightToLeft
    Caption = 'Document :'
    ParentBiDiMode = False
  end
  inherited Panel2: TPanel
    Width = 408
    inherited Image1: TImage
      Width = 181
    end
    inherited lblMenu: TLabel
      Left = 192
    end
    inherited EspacamentoSuperior: TPanel
      Width = 408
      inherited EEE: TPanel
        Width = 408
      end
    end
  end
  inherited Panel1: TPanel
    Top = 170
    Width = 408
    inherited EspacamentoInferior: TPanel
      Width = 408
      inherited Panel3: TPanel
        Width = 408
      end
    end
    inherited hhh: TPanel
      Left = 326
      inherited btClose: TButton
        Caption = '&Ok'
        Default = True
        ModalResult = 1
        OnClick = btCloseClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 130
  end
  inherited EspacamentoDireito: TPanel
    Left = 405
    Height = 130
  end
  object edtDocNumber: TEdit [6]
    Left = 104
    Top = 72
    Width = 101
    Height = 21
    TabOrder = 4
  end
  object scDocType: TSuperComboADO [7]
    Left = 104
    Top = 104
    Width = 205
    Height = 21
    TabOrder = 5
    LookUpSource = DM.dsLookUpDocumentType
    MostraDesativado = STD_AMBOSDESATIVADO
    MostraHidden = STD_AMBOSHIDDEN
    IDLanguage = 0
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmEnterMovDocumet.sil'
  end
end
