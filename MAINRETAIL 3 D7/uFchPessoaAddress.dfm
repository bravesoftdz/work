inherited FchPessoaAddress: TFchPessoaAddress
  Left = 343
  Top = 202
  Caption = ''
  ClientHeight = 403
  ClientWidth = 431
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 431
    DesignSize = (
      431
      40)
    inherited Image1: TImage
      Width = 157
    end
    inherited lblMenu: TLabel
      Left = 170
    end
    inherited EspacamentoSuperior: TPanel
      Width = 431
      inherited EEE: TPanel
        Width = 431
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 384
    end
  end
  inherited Panel1: TPanel
    Top = 362
    Width = 431
    inherited EspacamentoInferior: TPanel
      Width = 431
      inherited Panel3: TPanel
        Width = 431
      end
    end
    inherited hhh: TPanel
      Left = 210
      inherited btClose: TButton
        ModalResult = 1
      end
    end
  end
  inherited pnlKey: TPanel
    Width = 431
    Height = 1
    inherited Panel4: TPanel
      Top = -1
      Width = 431
    end
  end
  inherited pnlDetail: TPanel
    Top = 41
    Width = 425
    Height = 321
    object lbName: TLabel
      Left = 45
      Top = 20
      Width = 34
      Height = 13
      Alignment = taRightJustify
      Caption = 'Name :'
    end
    object lbAddress: TLabel
      Left = 33
      Top = 48
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Address :'
    end
    object lbCity: TLabel
      Left = 53
      Top = 104
      Width = 26
      Height = 13
      Alignment = taRightJustify
      Caption = 'City :'
    end
    object lbZip: TLabel
      Left = 33
      Top = 186
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Zip Code:'
    end
    object lbState: TLabel
      Left = 49
      Top = 158
      Width = 30
      Height = 13
      Alignment = taRightJustify
      Caption = 'State:'
    end
    object lbCountry: TLabel
      Left = 33
      Top = 214
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Country :'
    end
    object lbTax: TLabel
      Left = 54
      Top = 242
      Width = 25
      Height = 13
      Alignment = taRightJustify
      Caption = 'Tax :'
    end
    object Label35: TLabel
      Left = 357
      Top = 17
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
    object Label1: TLabel
      Left = 357
      Top = 45
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
      Left = 357
      Top = 101
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
      Left = 357
      Top = 155
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
    object Label4: TLabel
      Left = 229
      Top = 183
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
    object lblNaighborhood: TLabel
      Left = 5
      Top = 76
      Width = 74
      Height = 13
      Alignment = taRightJustify
      Caption = 'Neighborhood :'
    end
    object lblCompanyReg: TLabel
      Left = 4
      Top = 270
      Width = 75
      Height = 13
      Alignment = taRightJustify
      Caption = 'Company reg. :'
    end
    object lbMunicipio: TLabel
      Left = 25
      Top = 130
      Width = 54
      Height = 13
      Alignment = taRightJustify
      Caption = 'City Code :'
    end
    object edtName: TDBEdit
      Left = 84
      Top = 16
      Width = 268
      Height = 21
      DataField = 'Name'
      DataSource = dsForm
      TabOrder = 0
    end
    object edtAddress: TDBEdit
      Left = 84
      Top = 44
      Width = 269
      Height = 21
      DataField = 'Address'
      DataSource = dsForm
      TabOrder = 1
    end
    object edtCity: TDBEdit
      Left = 84
      Top = 100
      Width = 269
      Height = 21
      DataField = 'City'
      DataSource = dsForm
      TabOrder = 3
    end
    object edtZip: TDBEdit
      Left = 84
      Top = 182
      Width = 141
      Height = 21
      DataField = 'ZIP'
      DataSource = dsForm
      TabOrder = 6
    end
    object scState: TDBSuperComboADO
      Left = 84
      Top = 154
      Width = 269
      Height = 21
      TabOrder = 5
      Text = 'scState'
      LookUpSource = DM.dsLookUpEstado
      IDLanguage = 0
      DataField = 'IDEstado'
      DataSource = dsForm
    end
    object scCountry: TDBSuperComboADO
      Left = 84
      Top = 210
      Width = 269
      Height = 21
      TabOrder = 7
      Text = 'scCountry'
      LookUpSource = DM.dsLookUpPais
      IDLanguage = 0
      DataField = 'IDPais'
      DataSource = dsForm
    end
    object scTax: TDBSuperComboADO
      Left = 84
      Top = 238
      Width = 269
      Height = 21
      TabOrder = 8
      Text = 'scTax'
      SpcWhereClause = 'OperationType = 1 AND SaleTaxType = 2'
      LookUpSource = DM.dsLookUpTaxCategory
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
      DataField = 'IDTaxCategory'
      DataSource = dsForm
    end
    object cbIsBillTo: TDBCheckBox
      Left = 84
      Top = 294
      Width = 97
      Height = 17
      Caption = 'Address to Bill'
      DataField = 'IsBillTo'
      DataSource = dsForm
      TabOrder = 10
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      Visible = False
    end
    object edtNeighborhood: TDBEdit
      Left = 84
      Top = 72
      Width = 269
      Height = 21
      DataField = 'Neighborhood'
      DataSource = dsForm
      TabOrder = 2
    end
    object edtCompanyReg: TDBEdit
      Left = 84
      Top = 266
      Width = 141
      Height = 21
      DataField = 'CompanyReg'
      DataSource = dsForm
      TabOrder = 9
    end
    object scMunicipio: TDBSuperComboADO
      Left = 84
      Top = 126
      Width = 268
      Height = 21
      TabOrder = 4
      CodeLength = 5
      LookUpSource = DM.dsLookupMunicipio
      DropDownRows = 18
      IDLanguage = 0
      DataField = 'IDMunicipio'
      DataSource = dsForm
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 41
    Height = 321
  end
  inherited EspacamentoDireito: TPanel
    Left = 428
    Top = 41
    Height = 321
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchPessoaAddress.sil'
  end
  inherited dsForm: TDataSource
    Left = 400
    Top = 100
  end
  inherited quForm: TPowerADOQuery
    CursorType = ctStatic
    OnNewRecord = quFormNewRecord
    CommandText = 
      'SELECT'#13#10#9'PA.IDPessoaAddress,'#13#10#9'PA.IDPessoa,'#13#10#9'PA.Name,'#13#10#9'PA.Addr' +
      'ess,'#13#10#9'PA.Neighborhood,'#13#10#9'PA.City,'#13#10#9'PA.ZIP,'#13#10#9'PA.IDTaxCategory,' +
      #13#10#9'PA.IDPais,'#13#10#9'PA.IDEstado,'#13#10#9'PA.CompanyReg,'#13#10#9'PA.System,'#13#10#9'PA.' +
      'Hidden,'#13#10#9'PA.Desativado,'#13#10#9'PA.IsBillTo,'#13#10#9'PA.IDMunicipio'#13#10'FROM'#13#10 +
      #9'Mnt_PessoaAddress PA'#13#10'WHERE'#13#10#9'PA.IDPessoaAddress = :IDPessoaAdd' +
      'ress'#13#10
    Parameters = <
      item
        Name = 'IDPessoaAddress'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 400
    Top = 52
    object quFormIDPessoaAddress: TIntegerField
      FieldName = 'IDPessoaAddress'
    end
    object quFormIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quFormName: TStringField
      FieldName = 'Name'
      Size = 60
    end
    object quFormAddress: TStringField
      FieldName = 'Address'
      Size = 80
    end
    object quFormNeighborhood: TStringField
      FieldName = 'Neighborhood'
      Size = 30
    end
    object quFormCity: TStringField
      FieldName = 'City'
      Size = 30
    end
    object quFormZIP: TStringField
      FieldName = 'ZIP'
      Size = 10
    end
    object quFormIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
    end
    object quFormIDPais: TIntegerField
      FieldName = 'IDPais'
    end
    object quFormIDEstado: TStringField
      FieldName = 'IDEstado'
      FixedChar = True
      Size = 3
    end
    object quFormCompanyReg: TStringField
      FieldName = 'CompanyReg'
      Size = 30
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
    object quFormIsBillTo: TBooleanField
      FieldName = 'IsBillTo'
    end
    object quFormIDMunicipio: TIntegerField
      FieldName = 'IDMunicipio'
    end
  end
  inherited FormConfig: TFormConfig
    AutoCodeGen = False
    AutoIncField = 'IDPessoaAddress'
    RequiredFields.Strings = (
      'Name'
      'Address'
      'City'
      'ZIP'
      'IDEstado')
    Left = 400
    Top = 149
  end
end
