inherited FchMunicipio: TFchMunicipio
  Left = 261
  Top = 212
  Caption = 'FchMunicipio'
  ClientHeight = 209
  ClientWidth = 396
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 396
    inherited Image1: TImage
      Width = 122
    end
    inherited lblMenu: TLabel
      Left = 135
    end
    inherited EspacamentoSuperior: TPanel
      Width = 396
      inherited EEE: TPanel
        Width = 396
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 349
    end
  end
  inherited Panel1: TPanel
    Top = 168
    Width = 396
    inherited EspacamentoInferior: TPanel
      Width = 396
      inherited Panel3: TPanel
        Width = 396
      end
    end
    inherited hhh: TPanel
      Left = 175
      inherited spHelp: TSpeedButton
        Visible = False
      end
    end
  end
  inherited pnlKey: TPanel
    Width = 396
    Height = 3
    inherited Panel4: TPanel
      Top = 1
      Width = 396
    end
  end
  inherited pnlDetail: TPanel
    Top = 43
    Width = 390
    Height = 125
    object lbCode: TLabel
      Left = 39
      Top = 31
      Width = 32
      Height = 13
      Alignment = taRightJustify
      Caption = 'Code :'
      FocusControl = DBEdit3
    end
    object Label2: TLabel
      Left = 11
      Top = 74
      Width = 60
      Height = 13
      Alignment = taRightJustify
      Caption = 'Description :'
      FocusControl = DBEdit2
    end
    object Label1: TLabel
      Left = 340
      Top = 72
      Width = 14
      Height = 23
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 340
      Top = 27
      Width = 14
      Height = 23
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBEdit3: TDBEdit
      Left = 76
      Top = 27
      Width = 261
      Height = 21
      DataField = 'Codigo'
      DataSource = dsForm
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 76
      Top = 70
      Width = 261
      Height = 21
      DataField = 'Descricao'
      DataSource = dsForm
      TabOrder = 1
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 43
    Height = 125
  end
  inherited EspacamentoDireito: TPanel
    Left = 393
    Top = 43
    Height = 125
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchMunicipio.sil'
  end
  inherited dsForm: TDataSource
    Left = 26
  end
  inherited quForm: TPowerADOQuery
    CommandText = 
      'SELECT'#13#10#9'IDMunicipio,'#13#10#9'Codigo,'#13#10#9'Descricao'#13#10'FROM'#13#10#9'Sis_Municipi' +
      'o'#13#10'WHERE'#13#10#9'IDMunicipio = :IDMunicipio'#13#10
    Parameters = <
      item
        Name = 'IDMunicipio'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 26
    object quFormIDMunicipio: TIntegerField
      FieldName = 'IDMunicipio'
    end
    object quFormCodigo: TStringField
      FieldName = 'Codigo'
      Required = True
    end
    object quFormDescricao: TStringField
      FieldName = 'Descricao'
      Required = True
      Size = 100
    end
  end
  inherited FormConfig: TFormConfig
    ConfirmPost = False
    AutoIncField = 'IDMunicipio'
    Left = 281
    Top = 14
  end
end
