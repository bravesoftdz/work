inherited FchPetRace: TFchPetRace
  Left = 317
  Top = 201
  Caption = 'FchPetRace'
  ClientHeight = 146
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
    Top = 105
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
    Height = 5
    inherited Panel4: TPanel
      Top = 3
      Width = 414
    end
  end
  inherited pnlDetail: TPanel
    Top = 45
    Width = 408
    Height = 60
    object Label1: TLabel
      Left = 30
      Top = 22
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Race :'
      FocusControl = DBEdit1
    end
    object Label35: TLabel
      Left = 363
      Top = 18
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
      Left = 70
      Top = 18
      Width = 290
      Height = 21
      DataField = 'Breed'
      DataSource = dsForm
      TabOrder = 0
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 45
    Height = 60
  end
  inherited EspacamentoDireito: TPanel
    Left = 411
    Top = 45
    Height = 60
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchPetRace.sil'
  end
  inherited dsForm: TDataSource
    Left = 141
    Top = 46
  end
  inherited quForm: TPowerADOQuery
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDBreed,'#13#10#9'Breed,'#13#10#9'System,'#13#10#9'Hidden,'#13#10#9'Desativado'#13#10'FRO' +
      'M'#13#10#9'Pet_Breed'#13#10'WHERE'#13#10#9'IDBreed = :IDBreed'
    Parameters = <
      item
        Name = 'IDBreed'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 141
    Top = 102
    object quFormIDBreed: TIntegerField
      FieldName = 'IDBreed'
    end
    object quFormBreed: TStringField
      FieldName = 'Breed'
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
    ConfirmPost = False
    ConfirmCancel = False
    AutoIncField = 'IDBreed'
    Left = 76
    Top = 24
  end
end
