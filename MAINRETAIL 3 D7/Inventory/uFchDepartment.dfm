inherited FchDepartment: TFchDepartment
  Left = 369
  Top = 203
  Caption = 'FchDepartment'
  ClientHeight = 184
  ClientWidth = 437
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 437
    inherited Image1: TImage
      Width = 163
    end
    inherited lblMenu: TLabel
      Left = 176
    end
    inherited EspacamentoSuperior: TPanel
      Width = 437
      inherited EEE: TPanel
        Width = 437
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 390
    end
  end
  inherited Panel1: TPanel
    Top = 143
    Width = 437
    inherited EspacamentoInferior: TPanel
      Width = 437
      inherited Panel3: TPanel
        Width = 437
      end
    end
    inherited hhh: TPanel
      Left = 216
    end
  end
  inherited pnlKey: TPanel
    Width = 437
    Height = 0
    inherited Panel4: TPanel
      Top = -2
      Width = 437
    end
  end
  inherited pnlDetail: TPanel
    Top = 40
    Width = 431
    Height = 103
    object lblDepartment: TLabel
      Left = 47
      Top = 44
      Width = 64
      Height = 13
      Alignment = taRightJustify
      Caption = 'Department :'
      FocusControl = edtDepartment
    end
    object lblDepartmentRequired: TLabel
      Left = 353
      Top = 43
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
    object edtDepartment: TDBEdit
      Left = 113
      Top = 41
      Width = 239
      Height = 21
      DataField = 'Department'
      DataSource = dsForm
      TabOrder = 0
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 40
    Height = 103
  end
  inherited EspacamentoDireito: TPanel
    Left = 434
    Top = 40
    Height = 103
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchDepartment.sil'
  end
  inherited dsForm: TDataSource
    Left = 384
    Top = 12
  end
  inherited quForm: TPowerADOQuery
    CommandText = 
      'SELECT '#13#10#9'D.IDDepartment,'#13#10#9'D.Department'#13#10'FROM'#13#10#9'Inv_Department ' +
      'D'#13#10'WHERE'#13#10#9'D.IDDepartment = :IDDepartment'
    Parameters = <
      item
        Name = 'IDDepartment'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 384
    Top = 68
    object quFormIDDepartment: TIntegerField
      FieldName = 'IDDepartment'
    end
    object quFormDepartment: TStringField
      FieldName = 'Department'
      Required = True
      Size = 50
    end
  end
  inherited FormConfig: TFormConfig
    AutoIncField = 'IDDepartment'
    UniqueFields.Strings = (
      'Department')
    Left = 384
    Top = 125
  end
end
