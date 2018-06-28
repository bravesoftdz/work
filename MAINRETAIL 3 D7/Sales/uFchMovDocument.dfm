inherited FchMovDocument: TFchMovDocument
  Left = 350
  Top = 179
  Caption = 'FchMovDocument'
  ClientHeight = 354
  ClientWidth = 523
  PixelsPerInch = 96
  TextHeight = 16
  inherited Panel2: TPanel
    Width = 523
    DesignSize = (
      523
      40)
    inherited Image1: TImage
      Width = 249
    end
    inherited lblMenu: TLabel
      Left = 262
    end
    inherited EspacamentoSuperior: TPanel
      Width = 523
      inherited EEE: TPanel
        Width = 523
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 476
    end
  end
  inherited Panel1: TPanel
    Top = 313
    Width = 523
    inherited EspacamentoInferior: TPanel
      Width = 523
      inherited Panel3: TPanel
        Width = 523
      end
    end
    inherited hhh: TPanel
      Left = 302
    end
  end
  inherited pnlKey: TPanel
    Width = 523
    Height = 1
    inherited Panel4: TPanel
      Top = -1
      Width = 523
    end
  end
  inherited pnlDetail: TPanel
    Top = 41
    Width = 517
    Height = 272
    object lblDocumentNumber: TLabel
      Left = 54
      Top = 36
      Width = 54
      Height = 16
      Alignment = taRightJustify
      Caption = 'Number :'
    end
    object lblDocumentDate: TLabel
      Left = 279
      Top = 36
      Width = 35
      Height = 16
      Alignment = taRightJustify
      Caption = 'Date :'
    end
    object lblDocumentStatus: TLabel
      Left = 63
      Top = 68
      Width = 45
      Height = 16
      Alignment = taRightJustify
      Caption = 'Status :'
    end
    object lblDocumentType: TLabel
      Left = 71
      Top = 100
      Width = 37
      Height = 16
      Alignment = taRightJustify
      Caption = 'Type :'
    end
    object lblDocumentOBS: TLabel
      Left = 75
      Top = 128
      Width = 33
      Height = 16
      Alignment = taRightJustify
      Caption = 'OBS :'
    end
    object Label5: TLabel
      Left = 204
      Top = 34
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
    object Label7: TLabel
      Left = 284
      Top = 66
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
    object Label8: TLabel
      Left = 284
      Top = 98
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
    object Label9: TLabel
      Left = 425
      Top = 34
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
    object edtDocumentNumber: TDBEdit
      Left = 112
      Top = 32
      Width = 89
      Height = 24
      DataField = 'DocumentNumber'
      DataSource = dsForm
      TabOrder = 0
    end
    object mmOBS: TDBMemo
      Left = 112
      Top = 128
      Width = 297
      Height = 93
      DataField = 'OBS'
      DataSource = dsForm
      TabOrder = 4
    end
    object scDocumentType: TDBSuperComboADO
      Left = 112
      Top = 96
      Width = 169
      Height = 24
      TabOrder = 3
      Text = 'scDocumentType'
      LookUpSource = DM.dsLookUpDocumentType
      MostraDesativado = STD_AMBOSDESATIVADO
      MostraHidden = STD_AMBOSHIDDEN
      IDLanguage = 0
      DataField = 'IDDocumentType'
      DataSource = dsForm
    end
    object dbxDocumentDate: TDBDateBox
      Left = 320
      Top = 32
      Width = 104
      Height = 24
      ReadOnly = False
      TabOrder = 1
      DataField = 'DocumentDate'
      DataSource = dsForm
    end
    object cbxDocumentStatus: TComboBox
      Left = 112
      Top = 64
      Width = 169
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 2
      OnSelect = cbxDocumentStatusSelect
      Items.Strings = (
        'Created'
        'Signed for the customer'
        'Waiting sending'
        'Sent'
        'Received'
        'Filed')
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 41
    Height = 272
  end
  inherited EspacamentoDireito: TPanel
    Left = 520
    Top = 41
    Height = 272
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchMovDocument.sil'
    Left = 12
    Top = 8
  end
  inherited dsForm: TDataSource
    Left = 92
    Top = 4
  end
  inherited quForm: TPowerADOQuery
    CursorType = ctStatic
    BeforePost = quFormBeforePost
    OnNewRecord = quFormNewRecord
    CommandText = 
      'SELECT'#13#10#9'IDMovDocument,'#13#10#9'DocumentNumber,'#13#10#9'DocumentDate,'#13#10#9'Docu' +
      'mentStatus,'#13#10#9'IDDocumentType,'#13#10#9'IDPreInventoryMov,'#13#10#9'IDInventory' +
      'Mov,'#13#10#9'OBS'#13#10'FROM'#13#10#9'Inv_MovDocument'#13#10'WHERE'#13#10#9'IDMovDocument = :IDM' +
      'ovDocument'
    Parameters = <
      item
        Name = 'IDMovDocument'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 52
    Top = 20
    object quFormIDMovDocument: TIntegerField
      FieldName = 'IDMovDocument'
    end
    object quFormDocumentNumber: TStringField
      FieldName = 'DocumentNumber'
    end
    object quFormDocumentDate: TDateTimeField
      FieldName = 'DocumentDate'
    end
    object quFormDocumentStatus: TIntegerField
      FieldName = 'DocumentStatus'
    end
    object quFormIDDocumentType: TIntegerField
      FieldName = 'IDDocumentType'
    end
    object quFormIDPreInventoryMov: TIntegerField
      FieldName = 'IDPreInventoryMov'
    end
    object quFormIDInventoryMov: TIntegerField
      FieldName = 'IDInventoryMov'
    end
    object quFormOBS: TStringField
      FieldName = 'OBS'
      Size = 255
    end
  end
  inherited FormConfig: TFormConfig
    SystemReadOnly = False
    ConfirmPost = False
    AutoIncField = 'IDMovDocument'
    RequiredFields.Strings = (
      'DocumentNumber'
      'DocumentDate'
      'DocumentStatus'
      'IDDocumentType')
    Left = 136
    Top = 17
  end
end
