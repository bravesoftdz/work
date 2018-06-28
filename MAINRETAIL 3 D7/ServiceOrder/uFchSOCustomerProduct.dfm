inherited FchSOCustomerProduct: TFchSOCustomerProduct
  Left = 242
  Top = 183
  Caption = 'SO Customer Product'
  ClientHeight = 212
  ClientWidth = 500
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 500
    inherited Image1: TImage
      Width = 226
    end
    inherited lblMenu: TLabel
      Left = 239
    end
    inherited EspacamentoSuperior: TPanel
      Width = 500
      inherited EEE: TPanel
        Width = 500
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 453
    end
  end
  inherited Panel1: TPanel
    Top = 171
    Width = 500
    inherited EspacamentoInferior: TPanel
      Width = 500
      inherited Panel3: TPanel
        Width = 500
      end
    end
    inherited hhh: TPanel
      Left = 279
    end
  end
  inherited pnlKey: TPanel
    Width = 500
    Height = 3
    inherited Panel4: TPanel
      Top = 1
      Width = 500
    end
  end
  inherited pnlDetail: TPanel
    Top = 43
    Width = 494
    Height = 128
    object Label1: TLabel
      Left = 37
      Top = 39
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Caption = 'Model :'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 11
      Top = 66
      Width = 60
      Height = 13
      Alignment = taRightJustify
      Caption = 'Description :'
      FocusControl = DBEdit2
    end
    object Label21: TLabel
      Left = 227
      Top = 39
      Width = 72
      Height = 13
      Alignment = taRightJustify
      Caption = 'Manufacturer :'
    end
    object Label37: TLabel
      Left = 480
      Top = 64
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
    object Label3: TLabel
      Left = 203
      Top = 36
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
    object DBEdit1: TDBEdit
      Left = 77
      Top = 35
      Width = 124
      Height = 21
      DataField = 'Model'
      DataSource = dsForm
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 77
      Top = 64
      Width = 401
      Height = 21
      DataField = 'Description'
      DataSource = dsForm
      TabOrder = 1
    end
    object scSubManufacture: TDBSuperComboADO
      Tag = 99
      Left = 303
      Top = 36
      Width = 176
      Height = 21
      TabOrder = 2
      Text = 'scSubManufacture'
      FilterSugest = True
      LookUpSource = DM.dsLookUpFabricante
      DropDownRows = 18
      ShowEditCode = True
      IDLanguage = 0
      DataField = 'IDManufacture'
      DataSource = dsForm
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 43
    Height = 128
  end
  inherited EspacamentoDireito: TPanel
    Left = 497
    Top = 43
    Height = 128
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchSOCustomerProduct.sil'
  end
  inherited dsForm: TDataSource
    Left = 276
    Top = 16
  end
  inherited quForm: TPowerADOQuery
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDSOCustomerProduct,'#13#10#9'Model,'#13#10#9'Description,'#13#10#9'IDManufa' +
      'cture'#13#10'FROM'#13#10#9'Ser_SOCustomerProduct'#13#10'WHERE'#13#10#9'IDSOCustomerProduct' +
      ' = :IDSOCustomerProduct'
    Parameters = <
      item
        Name = 'IDSOCustomerProduct'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 226
    Top = 12
    object quFormIDSOCustomerProduct: TIntegerField
      FieldName = 'IDSOCustomerProduct'
    end
    object quFormModel: TStringField
      FieldName = 'Model'
      Required = True
      Size = 50
    end
    object quFormDescription: TStringField
      FieldName = 'Description'
      Required = True
      Size = 100
    end
    object quFormIDManufacture: TIntegerField
      FieldName = 'IDManufacture'
    end
  end
  inherited FormConfig: TFormConfig
    AutoIncField = 'IDSOCustomerProduct'
    Left = 146
    Top = 9
  end
end
