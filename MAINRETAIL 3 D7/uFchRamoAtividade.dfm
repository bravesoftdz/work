inherited FchRamoAtividade: TFchRamoAtividade
  Left = 224
  Top = 201
  Caption = 'FchRamoAtividade'
  ClientHeight = 164
  ClientWidth = 401
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 401
    TabOrder = 3
    inherited Image1: TImage
      Width = 127
    end
    inherited lblMenu: TLabel
      Left = 140
    end
    inherited EspacamentoSuperior: TPanel
      Width = 401
      inherited EEE: TPanel
        Width = 401
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 354
    end
  end
  inherited Panel1: TPanel
    Top = 123
    Width = 401
    TabOrder = 2
    inherited EspacamentoInferior: TPanel
      Width = 401
      inherited Panel3: TPanel
        Width = 401
      end
    end
    inherited hhh: TPanel
      Left = 180
    end
  end
  inherited pnlKey: TPanel
    Width = 401
    Height = 24
    inherited Panel4: TPanel
      Top = 22
      Width = 401
    end
  end
  inherited pnlDetail: TPanel
    Top = 64
    Width = 395
    Height = 59
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 57
      Height = 13
      Caption = 'Profession :'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 364
      Top = 4
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
    object DBEdit1: TDBEdit
      Left = 68
      Top = 4
      Width = 293
      Height = 21
      DataField = 'RamoAtividade'
      DataSource = dsForm
      TabOrder = 0
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 64
    Height = 59
  end
  inherited EspacamentoDireito: TPanel
    Left = 398
    Top = 64
    Height = 59
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchRamoAtividade.sil'
  end
  inherited dsForm: TDataSource
    Left = 36
    Top = 72
  end
  inherited quForm: TPowerADOQuery
    CursorType = ctStatic
    CommandText = 
      'SELECT '#13#10#9'RA.IDRamoAtividade, '#13#10#9'RA.RamoAtividade'#13#10'FROM '#13#10#9'RamoA' +
      'tividade RA'#13#10'WHERE '#13#10#9'RA.IDRamoAtividade = :IDRamoAtividade'
    Parameters = <
      item
        Name = 'IDRamoAtividade'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 36
    Top = 120
    object quFormIDRamoAtividade: TIntegerField
      FieldName = 'IDRamoAtividade'
    end
    object quFormRamoAtividade: TStringField
      DisplayLabel = 'Profession'
      FieldName = 'RamoAtividade'
      Required = True
      Size = 50
    end
  end
  inherited FormConfig: TFormConfig
    SystemReadOnly = False
    ConfirmPost = False
    AutoIncField = 'IDRamoAtividade'
    Left = 84
    Top = 21
  end
end
