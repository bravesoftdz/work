inherited FchPetPorte: TFchPetPorte
  Left = 218
  Top = 163
  Caption = 'FchPetPorte'
  ClientHeight = 154
  ClientWidth = 429
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 429
    inherited Image1: TImage
      Width = 155
    end
    inherited lblMenu: TLabel
      Left = 168
    end
    inherited EspacamentoSuperior: TPanel
      Width = 429
      inherited EEE: TPanel
        Width = 429
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 382
    end
  end
  inherited Panel1: TPanel
    Top = 113
    Width = 429
    inherited EspacamentoInferior: TPanel
      Width = 429
      inherited Panel3: TPanel
        Width = 429
      end
    end
    inherited hhh: TPanel
      Left = 208
    end
  end
  inherited pnlKey: TPanel
    Width = 429
    Height = 3
    inherited Panel4: TPanel
      Top = 1
      Width = 429
    end
  end
  inherited pnlDetail: TPanel
    Top = 43
    Width = 423
    Height = 70
    object Label1: TLabel
      Left = 39
      Top = 25
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'Porte :'
      FocusControl = DBEdit1
    end
    object Label35: TLabel
      Left = 363
      Top = 22
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
      Left = 79
      Top = 22
      Width = 281
      Height = 21
      DataField = 'Porte'
      DataSource = dsForm
      TabOrder = 0
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 43
    Height = 70
  end
  inherited EspacamentoDireito: TPanel
    Left = 426
    Top = 43
    Height = 70
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchPetPorte.sil'
  end
  inherited dsForm: TDataSource
    Left = 126
    Top = 11
  end
  inherited quForm: TPowerADOQuery
    CommandText = 
      'SELECT'#13#10#9'IDPorte,'#13#10#9'Porte,'#13#10#9'System,'#13#10#9'Hidden,'#13#10#9'Desativado'#13#10'FRO' +
      'M'#13#10#9'Pet_Porte'#13#10'WHERE'#13#10#9'IDPorte = :IDPorte'
    Parameters = <
      item
        Name = 'IDPorte'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 126
    Top = 67
    object quFormIDPorte: TIntegerField
      FieldName = 'IDPorte'
    end
    object quFormPorte: TStringField
      FieldName = 'Porte'
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
    AutoIncField = 'IDPorte'
    Left = 211
    Top = 19
  end
end
