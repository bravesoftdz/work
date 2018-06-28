inherited FrmZipSearch: TFrmZipSearch
  Left = 160
  Top = 141
  Caption = 'Search zipcode'
  ClientHeight = 313
  ClientWidth = 473
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbZip: TLabel [0]
    Left = 82
    Top = 14
    Width = 46
    Height = 13
    Alignment = taRightJustify
    Caption = 'ZipCode :'
  end
  object Label1: TLabel [1]
    Left = 105
    Top = 64
    Width = 23
    Height = 13
    Alignment = taRightJustify
    Caption = 'City :'
  end
  object Label2: TLabel [2]
    Left = 97
    Top = 86
    Width = 31
    Height = 13
    Alignment = taRightJustify
    Caption = 'State :'
  end
  object Label3: TLabel [3]
    Left = 55
    Top = 38
    Width = 73
    Height = 13
    Alignment = taRightJustify
    Caption = 'Neighborhood :'
  end
  inherited Panel1: TPanel
    Top = 274
    Width = 473
    TabOrder = 5
    inherited Bevel1: TBevel
      Width = 473
    end
    inherited Panel2: TPanel
      Left = 323
      inherited Cancelar: TButton
        ModalResult = 2
      end
      inherited Aplicar: TButton
        Default = False
        ModalResult = 1
      end
    end
  end
  object edtZip: TEdit [5]
    Left = 134
    Top = 10
    Width = 199
    Height = 21
    Color = 12582911
    TabOrder = 0
    OnChange = edtZipChange
    OnKeyPress = edtZipKeyPress
  end
  object edtBairro: TEdit [6]
    Left = 134
    Top = 35
    Width = 199
    Height = 21
    TabOrder = 1
    OnChange = edtZipChange
  end
  object edtCity: TEdit [7]
    Left = 134
    Top = 59
    Width = 199
    Height = 21
    TabOrder = 2
    OnChange = edtZipChange
  end
  object edtState: TEdit [8]
    Left = 134
    Top = 83
    Width = 50
    Height = 21
    MaxLength = 10
    TabOrder = 3
    OnChange = edtZipChange
  end
  object grdBrowse: TcxGrid [9]
    Left = 0
    Top = 115
    Width = 473
    Height = 159
    Align = alBottom
    TabOrder = 4
    LookAndFeel.Kind = lfFlat
    object grdBrowseDB: TcxGridDBTableView
      DataController.DataModeController.GridMode = True
      DataController.DataSource = dsZipCode
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'Endereco'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ValorNominal'
        end>
      DataController.Summary.SummaryGroups = <>
      Filtering.MaxDropDownCount = 50
      Filtering.Visible = fvNever
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfVisibleWhenExpanded
      OptionsView.HeaderAutoHeight = True
      OptionsView.HeaderEndEllipsis = True
      Preview.AutoHeight = False
      Preview.MaxLineCount = 2
      object grdBrowseDBEndereco: TcxGridDBColumn
        Caption = 'Address'
        DataBinding.FieldName = 'Endereco'
        Width = 224
      end
      object grdBrowseDBBairro: TcxGridDBColumn
        Caption = 'Neighborhood'
        DataBinding.FieldName = 'Bairro'
        Width = 89
      end
      object grdBrowseDBIDEstado: TcxGridDBColumn
        Caption = 'State'
        DataBinding.FieldName = 'IDEstado'
        Width = 79
      end
      object grdBrowseDBCEP: TcxGridDBColumn
        Caption = 'Zip'
        DataBinding.FieldName = 'CEP'
        Width = 79
      end
    end
    object grdBrowseLevel: TcxGridLevel
      GridView = grdBrowseDB
    end
  end
  object sbSearchZip: TBitBtn [10]
    Left = 344
    Top = 8
    Width = 92
    Height = 25
    Caption = '&Search'
    Default = True
    TabOrder = 6
    OnClick = sbSearchZipClick
    Glyph.Data = {
      B6020000424DB60200000000000036000000280000000D000000100000000100
      18000000000080020000130B0000130B00000000000000000000FF00FFA67D7C
      B08A85BC958BBC958BBC928BBC938BBC9388BC9387BC9186BC9086BC9086996B
      67008E58C699869DCCB3B1FEE7D1FEE5CCFEDFC9FEE0C9FEDDBEFEDDBBFED9B9
      FED4B1FED2B3AB7C75005F9EEA577CC1A391A8E5CAC0FCE8D4FEE4CBFEE4CAFE
      E2C7FEDDBBFEDDBBFEDBB6FED4B1AB7C7500FF00FF589AE0557CC2A391A7E4C8
      BFFDE9D4FEE5CCFEE4CAFEE2C6FEDDBDFEDDBBFED7B9AB7C7500FF00FFA4A1AB
      5C9FE85A7BBEAD9FA9F1DDCCE1C0B4DCBAAEE1C3B7F7D6BBFEDDBBFED6BCAB7C
      7700FF00FFD7BCB4E2E8EB80B5E5989CA4D0ADA0ECD2B0F9F1CBF0E5C5DBBBB3
      E3C6B5FCD6BAAD7E7700FF00FFDAC1B8FCF4EBEEE3DCD5B6A7FAE4B7FDF6C9FE
      FEDEFEFCEEFBF9F4D4BCB4ECC9B7B4878000FF00FFDDC5C0FDF7EEEADBD6E9CE
      AFFCECBCFDF8CAFEFEDFFEFCF8FEFBF6EDE0C4DDB5ADB4888100FF00FFE4CDC2
      FDF9F5EBDBD6EDDBB9FDDFB1FDF3C5FEFED3FEFEDEFEFEDEF3EBC7DAB3ACB68B
      8400FF00FFE5CFC4FEFCFCEDDFDCE8D3B6FCEBC8FDE8BAFDF5C8FDF9CEFDF9CE
      ECDBB8DAB3ACBC928B00FF00FFEBD5C7FEFDFEF2EDECE1C7BDF6EFE8FAEED3FC
      E8B8FDE1B3FAE6B7DCB8A2E7C5B5BC908700FF00FFEDD6C7FEFEFEFEFEFEEDDE
      DDDAC5BBE6D1C5EAD3B7EBD0AEDDB8A5E2B9B0F8BFB9BE8A8400FF00FFEFDACA
      FEFEFEFDFEFDFFFEFFF0E6E5E8D5CEE1CEC6EAD4CCD4B1A7CD9D92CC9189BB84
      7A00FF00FFF1DCCCFEFEFEFEFEFEFFFFFEFFFEFEFDFCFCFDFAF9FDF8F3D0AFA6
      DEAB83E5A362D78A9500FF00FFF6DDC6FEF7F1FAF5F0F8F3EEF7F1ECF4EEEBF4
      ECE7EFE7E0CBA89FE0B38EED90A0FF00FF00FF00FFE8BC99E5BB9FE2BA9FE1B8
      9DE0B79CDFB59CDFB59BDCB399C39483DC8F93FF00FFFF00FF00}
  end
  object quZipCode: TADODataSet [11]
    Connection = DM.ADODBConnect
    AfterOpen = quZipCodeAfterOpen
    OnCalcFields = quZipCodeCalcFields
    CommandText = 
      'SELECT'#13#10#9'T.Titulo,'#13#10#9'LG.CEP,'#13#10#9'LC.Localidade,'#13#10#9'B.IDBairro,'#13#10#9'B.' +
      'Bairro,'#13#10#9'LG.Logradouro,'#13#10#9'LG.Complemento,'#13#10#9'LC.IDLocalidade,'#13#10#9 +
      'LC.IDEstado'#13#10'FROM '#13#10#9'siCEPDB..Cep_Logradouro LG'#13#10#9'JOIN siCEPDB..' +
      'Cep_Localidade LC ON ( LG.IDLocalidade = LC.IDLocalidade )'#13#10#9'JOI' +
      'N siCEPDB..Cep_Bairro B ON ( B.idBairro = LG.idBairro  AND LG.ID' +
      'Localidade = B.IDLocalidade )'#13#10#9'JOIN siCEPDB..Cep_Titulo T ON ( ' +
      'T.idTitulo = LG.idTitulo )'
    CommandTimeout = 180
    Parameters = <>
    Left = 19
    Top = 173
    object quZipCodeTitulo: TStringField
      FieldName = 'Titulo'
      Size = 30
    end
    object quZipCodeCEP: TIntegerField
      DisplayLabel = 'Zip'
      FieldName = 'CEP'
    end
    object quZipCodeLocalidade: TStringField
      FieldName = 'Localidade'
      Size = 60
    end
    object quZipCodeIDBairro: TIntegerField
      FieldName = 'IDBairro'
    end
    object quZipCodeBairro: TStringField
      DisplayLabel = 'Neighborhood'
      FieldName = 'Bairro'
      Size = 60
    end
    object quZipCodeLogradouro: TStringField
      FieldName = 'Logradouro'
      Size = 60
    end
    object quZipCodeComplemento: TStringField
      FieldName = 'Complemento'
      Size = 65
    end
    object quZipCodeIDLocalidade: TIntegerField
      FieldName = 'IDLocalidade'
    end
    object quZipCodeIDEstado: TStringField
      DisplayLabel = 'State'
      FieldName = 'IDEstado'
      FixedChar = True
      Size = 2
    end
    object quZipCodeEndereco: TStringField
      DisplayLabel = 'Address'
      FieldKind = fkCalculated
      FieldName = 'Endereco'
      Size = 150
      Calculated = True
    end
  end
  object dsZipCode: TDataSource [12]
    DataSet = quZipCode
    Left = 25
    Top = 225
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmZipSearch.sil'
  end
end
