inherited FchPet: TFchPet
  Left = 342
  Top = 203
  Caption = 'FchPet'
  ClientHeight = 334
  ClientWidth = 374
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 374
    inherited Image1: TImage
      Width = 100
    end
    inherited lblMenu: TLabel
      Left = 113
    end
    inherited EspacamentoSuperior: TPanel
      Width = 374
      inherited EEE: TPanel
        Width = 374
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 327
    end
  end
  inherited Panel1: TPanel
    Top = 293
    Width = 374
    inherited EspacamentoInferior: TPanel
      Width = 374
      inherited Panel3: TPanel
        Width = 374
      end
    end
    inherited hhh: TPanel
      Left = 153
    end
  end
  inherited pnlKey: TPanel
    Width = 374
    Height = 8
    inherited Panel4: TPanel
      Top = 6
      Width = 374
    end
  end
  inherited pnlDetail: TPanel
    Top = 48
    Width = 368
    Height = 245
    object Label1: TLabel
      Left = 45
      Top = 14
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = 'Pet Name :'
      FocusControl = DBEdit1
    end
    object Label35: TLabel
      Left = 283
      Top = 11
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
      Left = 63
      Top = 124
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Caption = 'Breed :'
    end
    object Label4: TLabel
      Left = 72
      Top = 164
      Width = 26
      Height = 13
      Alignment = taRightJustify
      Caption = 'Size :'
    end
    object Label5: TLabel
      Left = 55
      Top = 86
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'Species :'
    end
    object lbDOB: TLabel
      Left = 72
      Top = 198
      Width = 28
      Height = 13
      Alignment = taRightJustify
      Caption = 'DOB :'
    end
    object DBEdit1: TDBEdit
      Left = 103
      Top = 10
      Width = 179
      Height = 21
      DataField = 'Name'
      DataSource = dsForm
      TabOrder = 0
    end
    object Sex: TDBRadioGroup
      Left = 103
      Top = 37
      Width = 179
      Height = 35
      Caption = 'Sex'
      Columns = 2
      DataField = 'Sex'
      DataSource = dsForm
      Items.Strings = (
        'Male'
        'Female')
      TabOrder = 1
      Values.Strings = (
        'M'
        'F')
    end
    object scRace: TDBSuperComboADO
      Left = 103
      Top = 120
      Width = 181
      Height = 21
      TabOrder = 4
      Text = 'scRace'
      LookUpSource = DM.dsLookUpPetRace
      DropDownRows = 10
      IDLanguage = 0
      DataField = 'IDBreed'
      DataSource = dsForm
    end
    object scSpecies: TDBSuperComboADO
      Left = 103
      Top = 82
      Width = 181
      Height = 21
      TabOrder = 2
      Text = 'scSpecies'
      LookUpSource = DM.dsLookUpPetSpecies
      DropDownRows = 10
      IDLanguage = 0
      DataField = 'IDSpecies'
      DataSource = dsForm
    end
    object scPorte: TDBSuperComboADO
      Left = 103
      Top = 160
      Width = 181
      Height = 21
      TabOrder = 3
      Text = 'scPorte'
      LookUpSource = DM.dsLookUpPorte
      DropDownRows = 10
      IDLanguage = 0
      DataField = 'IDPorte'
      DataSource = dsForm
    end
    object dxDBDateEdit3: TDBDateBox
      Left = 103
      Top = 195
      Width = 181
      Height = 21
      Color = clWhite
      ReadOnly = False
      TabOrder = 5
      DataField = 'WhelpDate'
      DataSource = dsForm
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 48
    Height = 245
  end
  inherited EspacamentoDireito: TPanel
    Left = 371
    Top = 48
    Height = 245
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchPet.sil'
    Left = 60
    Top = 4
  end
  inherited dsForm: TDataSource
    Left = 240
    Top = 4
  end
  inherited quForm: TPowerADOQuery
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDPet,'#13#10#9'Name,'#13#10#9'Sex,'#13#10#9'IDSpecies,'#13#10#9'IDBreed,'#13#10#9'IDPorte' +
      ','#13#10#9'WhelpDate'#13#10'FROM'#13#10#9'Pet'#13#10'WHERE'#13#10#9'IDPet = :IDPet'#13#10
    Parameters = <
      item
        Name = 'IDPet'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 180
    Top = 4
    object quFormIDPet: TIntegerField
      FieldName = 'IDPet'
    end
    object quFormName: TStringField
      FieldName = 'Name'
      Required = True
      Size = 50
    end
    object quFormSex: TStringField
      FieldName = 'Sex'
      Size = 1
    end
    object quFormIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
    end
    object quFormIDBreed: TIntegerField
      FieldName = 'IDBreed'
    end
    object quFormIDPorte: TIntegerField
      FieldName = 'IDPorte'
    end
    object quFormWhelpDate: TDateTimeField
      FieldName = 'WhelpDate'
    end
  end
  inherited FormConfig: TFormConfig
    AutoIncField = 'IDPet'
    Left = 120
    Top = 4
  end
end
