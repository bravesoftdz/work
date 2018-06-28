inherited FrmMovNotes: TFrmMovNotes
  Left = 348
  Top = 247
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Movment Notes'
  ClientHeight = 246
  ClientWidth = 402
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 402
    Height = 0
    Visible = False
    inherited lblSubMenu: TLabelEffect [0]
    end
    inherited Image1: TImage
      Width = 175
      Height = 0
    end
    inherited lblMenu: TLabel
      Left = 28
      Width = 281
      Caption = 'Movment Notes'
    end
    inherited imgTopIni: TImage [3]
    end
    inherited EspacamentoSuperior: TPanel
      Top = -6
      Width = 402
      inherited EEE: TPanel
        Width = 402
      end
    end
  end
  inherited Panel1: TPanel
    Top = 205
    Width = 402
    inherited EspacamentoInferior: TPanel
      Width = 402
      inherited Panel3: TPanel
        Width = 402
      end
    end
    inherited hhh: TPanel
      Left = 320
      inherited btClose: TButton
        Cancel = True
        ModalResult = 2
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 0
    Height = 32
  end
  inherited EspacamentoDireito: TPanel
    Left = 399
    Top = 0
    Height = 32
  end
  object mmNotes: TMemo [4]
    Left = 0
    Top = 32
    Width = 402
    Height = 173
    Align = alBottom
    Lines.Strings = (
      'mmNotes')
    ParentColor = True
    ReadOnly = True
    TabOrder = 4
  end
  object edtReason: TEdit [5]
    Left = 2
    Top = 4
    Width = 397
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 5
    Text = 'edtReason'
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmMovNotes.sil'
  end
end
