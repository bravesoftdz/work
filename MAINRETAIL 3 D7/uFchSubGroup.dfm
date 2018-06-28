inherited FchSubGroup: TFchSubGroup
  Left = 205
  Top = 122
  Caption = 'FchSubGroup'
  ClientHeight = 180
  ClientWidth = 428
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 428
    inherited Image1: TImage
      Width = 154
    end
    inherited lblMenu: TLabel
      Left = 167
    end
    inherited EspacamentoSuperior: TPanel
      Width = 428
      inherited EEE: TPanel
        Width = 428
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 381
    end
  end
  inherited Panel1: TPanel
    Top = 139
    Width = 428
    inherited EspacamentoInferior: TPanel
      Width = 428
      inherited Panel3: TPanel
        Width = 428
      end
    end
    inherited hhh: TPanel
      Left = 207
    end
  end
  inherited pnlKey: TPanel
    Width = 428
    Height = 6
    inherited Panel4: TPanel
      Top = 4
      Width = 428
    end
  end
  inherited pnlDetail: TPanel
    Top = 46
    Width = 422
    Height = 93
    object Label1: TLabel
      Left = 40
      Top = 56
      Width = 57
      Height = 13
      Caption = 'Sub Group :'
      FocusControl = DBEdit1
    end
    object Label38: TLabel
      Left = 356
      Top = 53
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
    object Label2: TLabel
      Left = 40
      Top = 27
      Width = 32
      Height = 13
      Caption = 'Code :'
      FocusControl = DBEdit2
    end
    object DBEdit1: TDBEdit
      Left = 102
      Top = 52
      Width = 249
      Height = 21
      DataField = 'SubGroup'
      DataSource = dsForm
      TabOrder = 1
    end
    object DBEdit2: TDBEdit
      Left = 102
      Top = 23
      Width = 249
      Height = 21
      DataField = 'UserCode'
      DataSource = dsForm
      TabOrder = 0
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 46
    Height = 93
  end
  inherited EspacamentoDireito: TPanel
    Left = 425
    Top = 46
    Height = 93
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchSubGroup.sil'
  end
  inherited dsForm: TDataSource
    Left = 211
    Top = 51
  end
  inherited quForm: TPowerADOQuery
    CommandText = 
      'SELECT'#13#10#9'IDSubGroup,'#13#10#9'UserCode,'#13#10#9'SubGroup'#13#10'FROM'#13#10#9'SubGroup'#13#10'WH' +
      'ERE'#13#10#9'IDSubGroup = :IDSubGroup'
    Parameters = <
      item
        Name = 'IDSubGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 211
    Top = 107
    object quFormIDSubGroup: TIntegerField
      FieldName = 'IDSubGroup'
    end
    object quFormSubGroup: TStringField
      FieldName = 'SubGroup'
      Required = True
      Size = 50
    end
    object quFormUserCode: TStringField
      FieldName = 'UserCode'
      Size = 5
    end
  end
  inherited FormConfig: TFormConfig
    AutoIncField = 'IDSubGroup'
    Left = 276
    Top = 24
  end
end
