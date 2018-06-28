inherited FchPetSpecies: TFchPetSpecies
  Left = 208
  Top = 153
  Caption = 'FchPetSpecies'
  ClientHeight = 155
  ClientWidth = 414
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 414
    inherited Image1: TImage
      Width = 140
    end
    inherited lblMenu: TLabel
      Left = 153
    end
    inherited EspacamentoSuperior: TPanel
      Width = 414
      inherited EEE: TPanel
        Width = 414
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 367
    end
  end
  inherited Panel1: TPanel
    Top = 114
    Width = 414
    inherited EspacamentoInferior: TPanel
      Width = 414
      inherited Panel3: TPanel
        Width = 414
      end
    end
    inherited hhh: TPanel
      Left = 193
    end
  end
  inherited pnlKey: TPanel
    Width = 414
    Height = 4
    inherited Panel4: TPanel
      Top = 2
      Width = 414
    end
  end
  inherited pnlDetail: TPanel
    Top = 44
    Width = 408
    Height = 70
    object Label1: TLabel
      Left = 35
      Top = 25
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'Species :'
      FocusControl = DBEdit1
    end
    object Label35: TLabel
      Left = 378
      Top = 21
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
      Left = 85
      Top = 20
      Width = 291
      Height = 21
      DataField = 'Species'
      DataSource = dsForm
      TabOrder = 0
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 44
    Height = 70
  end
  inherited EspacamentoDireito: TPanel
    Left = 411
    Top = 44
    Height = 70
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchPetSpecies.sil'
  end
  inherited dsForm: TDataSource
    Left = 91
    Top = 41
  end
  inherited quForm: TPowerADOQuery
    CommandText = 
      'SELECT'#13#10#9'IDSpecies,'#13#10#9'Species,'#13#10#9'System,'#13#10#9'Hidden,'#13#10#9'Desativado'#13 +
      #10'FROM'#13#10#9'Pet_Species'#13#10'WHERE'#13#10#9'IDSpecies = :IDSpecies'
    Parameters = <
      item
        Name = 'IDSpecies'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 91
    Top = 97
    object quFormIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
    end
    object quFormSpecies: TStringField
      FieldName = 'Species'
      Required = True
      Size = 50
    end
    object quFormSystem: TBooleanField
      FieldName = 'System'
    end
    object quFormHidden: TBooleanField
      FieldName = 'Hidden'
    end
    object quFormDesativado: TBooleanField
      FieldName = 'Desativado'
    end
  end
  inherited FormConfig: TFormConfig
    AutoIncField = 'IDSpecies'
    Left = 191
    Top = 9
  end
end
