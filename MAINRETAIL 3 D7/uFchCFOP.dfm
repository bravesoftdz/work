inherited FchCFOP: TFchCFOP
  Left = 493
  Top = 356
  Caption = 'FchCFOP'
  ClientHeight = 212
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
    Top = 171
    Width = 411
    inherited EspacamentoInferior: TPanel
      Width = 411
      inherited Panel3: TPanel
        Width = 411
      end
    end
    inherited hhh: TPanel
      Left = 205
      Width = 206
      inherited spHelp: TSpeedButton
        Left = 1
      end
      inherited btnVideo: TSpeedButton
        Left = 1
      end
      inherited btCancel: TButton
        Left = 137
      end
      inherited btClose: TButton
        Left = 67
      end
    end
  end
  inherited pnlKey: TPanel
    Width = 411
    Height = 0
    inherited Panel4: TPanel
      Top = -2
      Width = 411
    end
  end
  inherited pnlDetail: TPanel
    Top = 40
    Width = 405
    Height = 131
    object lblNumber: TLabel
      Left = 48
      Top = 40
      Width = 44
      Height = 13
      Alignment = taRightJustify
      Caption = 'Number :'
    end
    object lblNumberReq: TLabel
      Left = 216
      Top = 40
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
      Top = 76
      Width = 60
      Height = 13
      Alignment = taRightJustify
      Caption = 'Description :'
    end
    object lblDescriptionReq: TLabel
      Left = 320
      Top = 76
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
    object edtNumber: TDBEdit
      Left = 96
      Top = 36
      Width = 117
      Height = 21
      DataField = 'Number'
      DataSource = dsForm
      TabOrder = 0
    end
    object edtDescription: TDBEdit
      Left = 96
      Top = 72
      Width = 221
      Height = 21
      DataField = 'Description'
      DataSource = dsForm
      TabOrder = 1
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 40
    Height = 131
  end
  inherited EspacamentoDireito: TPanel
    Left = 408
    Top = 40
    Height = 131
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchCFOP.sil'
    Left = 12
    Top = 8
  end
  inherited dsForm: TDataSource
    Left = 104
    Top = 8
  end
  inherited quForm: TPowerADOQuery
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDCFOP,'#13#10#9'Number,'#13#10#9'Description'#13#10'FROM'#13#10#9'Mnt_CFOP'#13#10'WHERE' +
      #13#10#9'IDCFOP = :IDCFOP'#13#10
    Parameters = <
      item
        Name = 'IDCFOP'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 56
    Top = 24
    object quFormIDCFOP: TIntegerField
      FieldName = 'IDCFOP'
    end
    object quFormNumber: TStringField
      FieldName = 'Number'
      Size = 15
    end
    object quFormDescription: TStringField
      FieldName = 'Description'
      Size = 30
    end
  end
  inherited FormConfig: TFormConfig
    SystemReadOnly = False
    AutoIncField = 'IDCFOP'
    Left = 152
    Top = 24
  end
end
