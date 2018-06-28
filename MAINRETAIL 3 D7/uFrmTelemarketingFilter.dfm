inherited FrmTelemarketingFilter: TFrmTelemarketingFilter
  Left = 384
  Top = 94
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'FrmTelemarketingFilter'
  ClientHeight = 470
  ClientWidth = 438
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbFilterName: TLabel [0]
    Left = 40
    Top = 21
    Width = 59
    Height = 13
    Alignment = taRightJustify
    Caption = 'Filter Name :'
  end
  object Label35: TLabel [1]
    Left = 377
    Top = 19
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
  inherited Panel1: TPanel
    Top = 429
    Width = 438
    inherited EspacamentoInferior: TPanel
      Width = 438
      inherited Panel3: TPanel
        Width = 438
      end
    end
    inherited hhh: TPanel
      Left = 215
      Width = 223
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 149
        Cancel = True
        OnClick = btCloseClick
      end
      object Button1: TButton
        Left = 78
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Save'
        Default = True
        TabOrder = 1
        TabStop = False
        OnClick = Button1Click
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 37
  end
  inherited EspacamentoDireito: TPanel
    Left = 435
    Height = 37
  end
  inherited EspacamentoSuperior: TPanel
    Width = 438
  end
  object edtFilterName: TEdit [6]
    Left = 104
    Top = 17
    Width = 269
    Height = 21
    MaxLength = 30
    TabOrder = 4
  end
  object PageControl1: TPageControl [7]
    Left = 0
    Top = 43
    Width = 438
    Height = 386
    ActivePage = tsInvoice
    Align = alBottom
    TabOrder = 5
    object tsInvoice: TTabSheet
      Caption = 'Invoice'
      object lbInvDate: TLabel
        Left = 24
        Top = 17
        Width = 29
        Height = 13
        Alignment = taRightJustify
        Caption = 'From :'
      end
      object Label1: TLabel
        Left = 165
        Top = 18
        Width = 15
        Height = 13
        Alignment = taRightJustify
        Caption = 'to :'
      end
      object Label2: TLabel
        Left = 22
        Top = 48
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = 'Store :'
      end
      object Label3: TLabel
        Left = 18
        Top = 81
        Width = 35
        Height = 13
        Alignment = taRightJustify
        Caption = 'Media :'
      end
      object Label4: TLabel
        Left = 26
        Top = 114
        Width = 27
        Height = 13
        Alignment = taRightJustify
        Caption = 'Sale :'
      end
      object lbCategory: TLabel
        Left = 6
        Top = 144
        Width = 48
        Height = 13
        Alignment = taRightJustify
        Caption = 'Category :'
      end
      object lbModel: TLabel
        Left = 19
        Top = 178
        Width = 35
        Height = 13
        Alignment = taRightJustify
        Caption = 'Model :'
      end
      object InvIniDate: TDateBox
        Left = 59
        Top = 14
        Width = 87
        Height = 21
        TabOrder = 0
        InputTime = False
      end
      object InvEndDate: TDateBox
        Left = 186
        Top = 14
        Width = 87
        Height = 21
        TabOrder = 1
        InputTime = False
      end
      object Button2: TButton
        Left = 275
        Top = 45
        Width = 37
        Height = 21
        Caption = 'All'
        TabOrder = 3
        OnClick = Button2Click
      end
      object scMedia: TSuperComboADO
        Left = 59
        Top = 77
        Width = 213
        Height = 21
        TabOrder = 4
        Text = '<-->'
        CodeLength = 5
        LookUpSource = DM.dsLookUpMedia
        DropDownRows = 18
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        MostraDesativado = STD_AMBOSDESATIVADO
        IDLanguage = 0
      end
      object Button3: TButton
        Left = 275
        Top = 78
        Width = 37
        Height = 21
        Caption = 'All'
        TabOrder = 5
        OnClick = Button3Click
      end
      object cmbStore: TSuperComboADO
        Left = 59
        Top = 45
        Width = 213
        Height = 21
        TabOrder = 2
        Text = '<-->'
        LookUpSource = DM.dsLookUpStore
        DropDownRows = 10
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
      end
      object cbxSaleTotal: TComboBox
        Left = 59
        Top = 110
        Width = 69
        Height = 22
        Style = csOwnerDrawFixed
        ItemHeight = 16
        ItemIndex = 0
        TabOrder = 6
        Items.Strings = (
          ''
          '>='
          '<='
          '>'
          '<')
      end
      object edtSalesTotal: TEdit
        Left = 131
        Top = 111
        Width = 141
        Height = 21
        TabOrder = 7
        OnKeyPress = edtSalesTotalKeyPress
      end
      object scCategory: TSuperComboADO
        Left = 59
        Top = 141
        Width = 212
        Height = 21
        TabOrder = 8
        Text = '<-->'
        LookUpSource = DM.dsLookUpGroup
        DropDownRows = 10
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
      end
      object btnCategClear: TButton
        Left = 274
        Top = 141
        Width = 34
        Height = 20
        Caption = 'All'
        TabOrder = 9
        TabStop = False
        OnClick = btnCategClearClick
      end
      object edtModel: TEdit
        Left = 59
        Top = 174
        Width = 212
        Height = 21
        TabOrder = 10
      end
    end
    object tsCustomer: TTabSheet
      Caption = 'Customer'
      ImageIndex = 1
      object Label5: TLabel
        Left = 34
        Top = 280
        Width = 48
        Height = 13
        Alignment = taRightJustify
        Caption = 'Birthdate :'
      end
      object Label7: TLabel
        Left = 59
        Top = 59
        Width = 23
        Height = 13
        Alignment = taRightJustify
        Caption = 'City :'
      end
      object Label8: TLabel
        Left = 34
        Top = 105
        Width = 48
        Height = 13
        Alignment = taRightJustify
        Caption = 'Zip code :'
      end
      object Label9: TLabel
        Left = 20
        Top = 131
        Width = 62
        Height = 13
        Alignment = taRightJustify
        Caption = 'Phone Area :'
      end
      object Label10: TLabel
        Left = 51
        Top = 83
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = 'State :'
      end
      object lbBairro: TLabel
        Left = 9
        Top = 38
        Width = 73
        Height = 13
        Alignment = taRightJustify
        Caption = 'Neighborhood :'
      end
      object lbCell: TLabel
        Left = 59
        Top = 156
        Width = 23
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cell :'
      end
      object Label22: TLabel
        Left = 51
        Top = 181
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = 'Email :'
      end
      object Label46: TLabel
        Left = 45
        Top = 207
        Width = 37
        Height = 13
        Alignment = taRightJustify
        Caption = 'Beeper:'
      end
      object Label14: TLabel
        Left = 59
        Top = 231
        Width = 23
        Height = 13
        Alignment = taRightJustify
        Caption = 'Fax :'
      end
      object Label23: TLabel
        Left = 23
        Top = 254
        Width = 59
        Height = 13
        Alignment = taRightJustify
        Caption = 'HomePage :'
      end
      object lbCType: TLabel
        Left = 52
        Top = 13
        Width = 30
        Height = 13
        Alignment = taRightJustify
        Caption = 'Type :'
      end
      object lbProfession: TLabel
        Left = 26
        Top = 304
        Width = 55
        Height = 13
        Alignment = taRightJustify
        Caption = 'Profession :'
      end
      object lbSex: TLabel
        Left = 39
        Top = 327
        Width = 41
        Height = 13
        Alignment = taRightJustify
        Caption = 'Gender :'
      end
      object edtCity: TEdit
        Left = 88
        Top = 56
        Width = 207
        Height = 21
        TabOrder = 3
      end
      object edtZipCode: TEdit
        Left = 88
        Top = 102
        Width = 207
        Height = 21
        TabOrder = 6
      end
      object edtArePhone: TEdit
        Left = 88
        Top = 127
        Width = 46
        Height = 21
        TabOrder = 7
      end
      object scState: TSuperComboADO
        Left = 88
        Top = 79
        Width = 208
        Height = 21
        TabOrder = 4
        Text = '<-->'
        LookUpSource = DM.dsLookUpEstado
        DropDownRows = 10
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
      end
      object btnStateClear: TButton
        Left = 300
        Top = 79
        Width = 34
        Height = 21
        Caption = 'All'
        TabOrder = 5
        OnClick = btnStateClearClick
      end
      object edtBairro: TEdit
        Left = 88
        Top = 33
        Width = 207
        Height = 21
        TabOrder = 2
      end
      object edtPhone: TEdit
        Left = 135
        Top = 127
        Width = 160
        Height = 21
        TabOrder = 8
      end
      object edtAreCell: TEdit
        Left = 88
        Top = 152
        Width = 46
        Height = 21
        TabOrder = 9
      end
      object edtCell: TEdit
        Left = 135
        Top = 152
        Width = 160
        Height = 21
        TabOrder = 10
      end
      object edtEmail: TEdit
        Left = 88
        Top = 177
        Width = 207
        Height = 21
        TabOrder = 11
      end
      object edtBeeper: TEdit
        Left = 88
        Top = 203
        Width = 207
        Height = 21
        TabOrder = 12
      end
      object edtFax: TEdit
        Left = 88
        Top = 228
        Width = 207
        Height = 21
        TabOrder = 13
      end
      object edtHomePage: TEdit
        Left = 88
        Top = 251
        Width = 207
        Height = 21
        TabOrder = 14
      end
      object scCusType: TSuperComboADO
        Left = 88
        Top = 10
        Width = 208
        Height = 21
        TabOrder = 0
        Text = '<-->'
        LookUpSource = DM.dsLookUpTipoCliente
        DropDownRows = 10
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
      end
      object btnCType: TButton
        Left = 301
        Top = 10
        Width = 34
        Height = 21
        Caption = 'All'
        TabOrder = 1
        OnClick = btnCTypeClick
      end
      object cbxMonth: TComboBox
        Left = 152
        Top = 276
        Width = 143
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 15
      end
      object edtDay: TEdit
        Left = 88
        Top = 276
        Width = 45
        Height = 21
        TabOrder = 16
        Text = '0'
      end
      object UpDownDay: TUpDown
        Left = 133
        Top = 276
        Width = 15
        Height = 21
        Associate = edtDay
        Max = 31
        TabOrder = 17
      end
      object scProfession: TSuperComboADO
        Left = 87
        Top = 300
        Width = 208
        Height = 21
        TabOrder = 18
        Text = '<-->'
        LookUpSource = DM.dsLookUpRamoAtividade
        DropDownRows = 10
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
      end
      object btnProfessionClear: TButton
        Left = 299
        Top = 300
        Width = 34
        Height = 21
        Caption = 'All'
        TabOrder = 19
        OnClick = btnProfessionClearClick
      end
      object rgGender: TRadioGroup
        Left = 86
        Top = 321
        Width = 209
        Height = 30
        Columns = 2
        Items.Strings = (
          'Male'
          'Female')
        TabOrder = 20
      end
    end
    object tsResult: TTabSheet
      Caption = 'Result Type'
      ImageIndex = 2
      object lbType: TLabel
        Left = 43
        Top = 27
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'Type : '
      end
      object lbResult: TLabel
        Left = 37
        Top = 73
        Width = 39
        Height = 13
        Alignment = taRightJustify
        Caption = 'Result : '
      end
      object scType: TSuperComboADO
        Left = 80
        Top = 24
        Width = 241
        Height = 21
        TabOrder = 0
        LookUpSource = DM.dsLookUpPHistoryType
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
        OnSelectItem = scTypeSelectItem
      end
      object cbxResult: TcxLookupComboBox
        Left = 81
        Top = 68
        Width = 241
        Height = 21
        Properties.KeyFieldNames = 'IDPessoaHistoryResult'
        Properties.ListColumns = <
          item
            FieldName = 'PessoaHistoryResult'
          end>
        Properties.ListOptions.ColumnSorting = False
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dsResultType
        Style.BorderStyle = ebs3D
        Style.ButtonStyle = bts3D
        TabOrder = 1
      end
    end
    object tsSO: TTabSheet
      Caption = 'Service Order'
      ImageIndex = 3
      object lbSOIni: TLabel
        Left = 24
        Top = 17
        Width = 29
        Height = 13
        Alignment = taRightJustify
        Caption = 'From :'
      end
      object lbSOEnd: TLabel
        Left = 165
        Top = 18
        Width = 15
        Height = 13
        Alignment = taRightJustify
        Caption = 'to :'
      end
      object lbSOStore: TLabel
        Left = 22
        Top = 48
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = 'Store :'
      end
      object lbSOProduct: TLabel
        Left = 10
        Top = 81
        Width = 43
        Height = 13
        Alignment = taRightJustify
        Caption = 'Product :'
      end
      object dtSOIni: TDateBox
        Left = 59
        Top = 14
        Width = 87
        Height = 21
        TabOrder = 0
        InputTime = False
      end
      object dtSOEnd: TDateBox
        Left = 186
        Top = 14
        Width = 87
        Height = 21
        TabOrder = 1
        InputTime = False
      end
      object scSOStore: TSuperComboADO
        Left = 59
        Top = 45
        Width = 213
        Height = 21
        TabOrder = 2
        Text = '<-->'
        LookUpSource = DM.dsLookUpStore
        DropDownRows = 10
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
      end
      object Button4: TButton
        Left = 275
        Top = 45
        Width = 37
        Height = 21
        Caption = 'All'
        TabOrder = 3
        OnClick = Button4Click
      end
      object scSOProduct: TSuperComboADO
        Left = 59
        Top = 77
        Width = 213
        Height = 21
        TabOrder = 4
        Text = '<-->'
        CodeLength = 5
        LookUpSource = DMServiceOrder.dsSOCutomerProduct
        DropDownRows = 18
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        MostraDesativado = STD_AMBOSDESATIVADO
        IDLanguage = 0
      end
      object Button5: TButton
        Left = 275
        Top = 78
        Width = 37
        Height = 21
        Caption = 'All'
        TabOrder = 5
        OnClick = Button5Click
      end
    end
  end
  object quFilter: TADODataSet [8]
    Connection = DM.ADODBConnect
    CommandText = 
      'Select'#13#10#9'IDTelemarketingFilter,'#13#10#9'FilterName,'#13#10#9'FilterValues,'#13#10#9 +
      'SQL'#13#10'From '#13#10#9'Sal_TelemarketingFilter'#13#10'Where'#13#10#9'IDTelemarketingFil' +
      'ter = :IDTelemarketingFilter'#13#10
    Parameters = <
      item
        Name = 'IDTelemarketingFilter'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 368
    Top = 124
    object quFilterIDTelemarketingFilter: TIntegerField
      FieldName = 'IDTelemarketingFilter'
    end
    object quFilterFilterName: TStringField
      DisplayLabel = 'Filter Name'
      FieldName = 'FilterName'
      Size = 30
    end
    object quFilterFilterValues: TMemoField
      FieldName = 'FilterValues'
      BlobType = ftMemo
    end
    object quFilterSQL: TMemoField
      FieldName = 'SQL'
      BlobType = ftMemo
    end
  end
  object dsFilter: TDataSource [9]
    DataSet = quFilter
    Left = 368
    Top = 68
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmTelemarketingFilter.sil'
  end
  object dsResultType: TDataSource
    DataSet = cdsResultType
    Left = 388
    Top = 212
  end
  object cdsResultType: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspResultType'
    Left = 376
    Top = 204
  end
  object dspResultType: TDataSetProvider
    DataSet = quTypeResult
    Left = 360
    Top = 188
  end
  object quTypeResult: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'IDPessoaHistoryResult,'#13#10#9'IDPessoaHistoryType,'#13#10#9'PessoaH' +
      'istoryResult,'#13#10#9'ResultColor'#13#10'FROM'#13#10#9'Mnt_PessoaHistoryResult'#13#10
    Parameters = <>
    Left = 347
    Top = 173
    object quTypeResultIDPessoaHistoryResult: TIntegerField
      FieldName = 'IDPessoaHistoryResult'
    end
    object quTypeResultIDPessoaHistoryType: TIntegerField
      FieldName = 'IDPessoaHistoryType'
    end
    object quTypeResultPessoaHistoryResult: TStringField
      DisplayLabel = 'Result'
      FieldName = 'PessoaHistoryResult'
      Size = 30
    end
    object quTypeResultResultColor: TStringField
      DisplayLabel = 'Color'
      FieldName = 'ResultColor'
    end
  end
end
