inherited FchDocumentType: TFchDocumentType
  Left = 354
  Top = 213
  Caption = 'FchDocumentType'
  ClientHeight = 198
  ClientWidth = 411
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 411
    inherited Image1: TImage
      Width = 137
    end
    inherited lblMenu: TLabel
      Left = 150
    end
    inherited EspacamentoSuperior: TPanel
      Width = 411
      inherited EEE: TPanel
        Width = 411
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 364
    end
  end
  inherited Panel1: TPanel
    Top = 157
    Width = 411
    inherited EspacamentoInferior: TPanel
      Width = 411
      inherited Panel3: TPanel
        Width = 411
      end
    end
    inherited hhh: TPanel
      Left = 190
    end
  end
  inherited pnlKey: TPanel
    Width = 411
    Height = 1
    inherited Panel4: TPanel
      Top = -1
      Width = 411
    end
  end
  inherited pnlDetail: TPanel
    Top = 41
    Width = 405
    Height = 116
    object Label5: TLabel
      Left = 320
      Top = 38
      Width = 14
      Height = 23
      Hint = 'Field can not be empty'
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object lblDescription: TLabel
      Left = 32
      Top = 40
      Width = 60
      Height = 13
      Alignment = taRightJustify
      Caption = 'Description :'
    end
    object edtDocument: TDBEdit
      Left = 96
      Top = 36
      Width = 221
      Height = 21
      DataField = 'DocumentType'
      DataSource = dsForm
      TabOrder = 0
    end
    object chkDefault: TDBCheckBox
      Left = 96
      Top = 72
      Width = 221
      Height = 17
      Caption = 'Default type'
      DataField = 'DefaultType'
      DataSource = dsForm
      TabOrder = 1
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 41
    Height = 116
  end
  inherited EspacamentoDireito: TPanel
    Left = 408
    Top = 41
    Height = 116
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchDocumentType.sil'
  end
  inherited dsForm: TDataSource
    Left = 128
    Top = 20
  end
  inherited quForm: TPowerADOQuery
    CursorType = ctStatic
    BeforePost = quFormBeforePost
    CommandText = 
      'SELECT'#13#10#9'IDDocumentType,'#13#10#9'DocumentType,'#13#10#9'DefaultType'#13#10'FROM'#13#10#9'M' +
      'nt_DocumentType'#13#10'WHERE'#13#10#9'IDDocumentType = :IDDocumentType'#13#10
    Parameters = <
      item
        Name = 'IDDocumentType'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 84
    Top = 4
    object quFormIDDocumentType: TIntegerField
      FieldName = 'IDDocumentType'
    end
    object quFormDocumentType: TStringField
      FieldName = 'DocumentType'
      Size = 40
    end
    object quFormDefaultType: TBooleanField
      FieldName = 'DefaultType'
    end
  end
  inherited FormConfig: TFormConfig
    SystemReadOnly = False
    AutoIncField = 'IDDocumentType'
    RequiredFields.Strings = (
      'DocumentType')
    Left = 180
    Top = 4
  end
end
