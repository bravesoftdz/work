inherited FrmAskDocument: TFrmAskDocument
  Left = 343
  Top = 262
  Width = 440
  Height = 195
  BorderIcons = []
  Caption = 'Ask Document'
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object lblDocument: TLabel [0]
    Left = 60
    Top = 64
    Width = 74
    Height = 16
    Alignment = taRightJustify
    Caption = 'Document :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblNumber: TLabel [1]
    Left = 76
    Top = 28
    Width = 58
    Height = 16
    Alignment = taRightJustify
    Caption = 'Number :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited pnlButtom: TPanel
    Top = 127
    Width = 432
    inherited hhh: TPanel
      Left = 282
      inherited spHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Caption = '&Ok'
        Default = True
        ModalResult = 1
        OnClick = btCloseClick
      end
    end
  end
  inherited pnlLine: TPanel
    Top = 125
    Width = 432
  end
  object cmbDocument: TDBLookupComboBox [4]
    Left = 140
    Top = 60
    Width = 233
    Height = 27
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    KeyField = 'IDDocumentType'
    ListField = 'DocumentType'
    ListSource = DM.dsDocumentType
    ParentFont = False
    TabOrder = 3
  end
  object edtNumber: TEdit [5]
    Left = 140
    Top = 24
    Width = 229
    Height = 26
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmAskDocument.sil'
    Left = 12
    Top = 8
  end
end
