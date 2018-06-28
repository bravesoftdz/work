object Form1: TForm1
  Left = 110
  Top = 6
  BorderStyle = bsSingle
  Caption = 'Main form'
  ClientHeight = 536
  ClientWidth = 590
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 263
    Top = 90
    Width = 34
    Height = 13
    Alignment = taRightJustify
    Caption = 'Name :'
  end
  object Label4: TLabel
    Left = 240
    Top = 119
    Width = 57
    Height = 13
    Alignment = taRightJustify
    Caption = 'Last Name :'
  end
  object Label5: TLabel
    Left = 431
    Top = 118
    Width = 26
    Height = 13
    Alignment = taRightJustify
    Caption = 'Doc :'
  end
  object Label6: TLabel
    Left = 240
    Top = 32
    Width = 57
    Height = 13
    Alignment = taRightJustify
    Caption = 'Apply Filter :'
  end
  object Button1: TButton
    Left = 63
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 0
    OnClick = Button1Click
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 517
    Width = 590
    Height = 19
    Panels = <
      item
        Text = 'Not Connected'
        Width = 150
      end
      item
        Width = 50
      end>
  end
  object TPanel
    Left = 0
    Top = 156
    Width = 590
    Height = 147
    Align = alBottom
    TabOrder = 2
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 588
      Height = 13
      Align = alTop
      Caption = 'Main Customer'
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 14
      Width = 588
      Height = 132
      Align = alClient
      DataSource = dsPessoaO
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object TPanel
    Left = 0
    Top = 348
    Width = 590
    Height = 169
    Align = alBottom
    TabOrder = 3
    object Label2: TLabel
      Left = 1
      Top = 1
      Width = 588
      Height = 13
      Align = alTop
      Caption = 'Secondary Customer'
    end
    object DBGrid2: TDBGrid
      Left = 1
      Top = 14
      Width = 588
      Height = 154
      Align = alClient
      DataSource = dsPessoaD
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 303
    Width = 590
    Height = 45
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object lbClienteSecundario: TLabel
      Left = 83
      Top = 25
      Width = 3
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 11
      Top = 25
      Width = 66
      Height = 13
      Alignment = taRightJustify
      Caption = 'Change from :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 7
      Top = 7
      Width = 71
      Height = 13
      Alignment = taRightJustify
      Caption = 'Change To :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbClientePrincipal: TLabel
      Left = 87
      Top = 7
      Width = 5
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnUpdate: TButton
      Left = 445
      Top = 10
      Width = 126
      Height = 23
      Caption = 'Update Customer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Visible = False
      OnClick = btnUpdateClick
    end
  end
  object edtNome: TEdit
    Left = 303
    Top = 87
    Width = 121
    Height = 21
    TabOrder = 5
  end
  object edtLastName: TEdit
    Left = 303
    Top = 114
    Width = 121
    Height = 21
    TabOrder = 6
  end
  object edtCPF: TEdit
    Left = 463
    Top = 115
    Width = 121
    Height = 21
    TabOrder = 7
  end
  object rdTipo: TRadioGroup
    Left = 303
    Top = 52
    Width = 148
    Height = 30
    Caption = 'Type'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Regular'
      'Company')
    TabOrder = 8
  end
  object Button3: TButton
    Left = 500
    Top = 40
    Width = 75
    Height = 56
    Caption = 'GO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = Button3Click
  end
  object cbxQuery: TComboBox
    Left = 303
    Top = 28
    Width = 121
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    ItemIndex = 2
    TabOrder = 10
    Text = 'All'
    Items.Strings = (
      'Main Customer'
      'Secundary Customer'
      'All')
  end
  object edtPW: TLabeledEdit
    Left = 64
    Top = 88
    Width = 49
    Height = 21
    EditLabel.Width = 21
    EditLabel.Height = 13
    EditLabel.Caption = 'PW:'
    LabelPosition = lpLeft
    PasswordChar = '*'
    TabOrder = 14
    Text = 'mruser2000'
  end
  object edtUser: TLabeledEdit
    Left = 64
    Top = 64
    Width = 49
    Height = 21
    EditLabel.Width = 25
    EditLabel.Height = 13
    EditLabel.Caption = 'User:'
    LabelPosition = lpLeft
    TabOrder = 13
    Text = 'mruser'
  end
  object edtDB: TLabeledEdit
    Left = 64
    Top = 39
    Width = 105
    Height = 21
    EditLabel.Width = 18
    EditLabel.Height = 13
    EditLabel.Caption = 'DB:'
    LabelPosition = lpLeft
    TabOrder = 12
    Text = 'MainRetailDB'
  end
  object edtServer: TLabeledEdit
    Left = 64
    Top = 15
    Width = 105
    Height = 21
    EditLabel.Width = 34
    EditLabel.Height = 13
    EditLabel.Caption = 'Server:'
    LabelPosition = lpLeft
    TabOrder = 11
    Text = '(local)'
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=fudeu;Persist Security Info=True;Us' +
      'er ID=sa;Initial Catalog=PetIpanemaDB;Data Source=(local)'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    AfterConnect = ADOConnection1AfterConnect
    AfterDisconnect = ADOConnection1AfterDisconnect
    Left = 65
    Top = 45
  end
  object quPessoaO: TADODataSet
    Connection = ADOConnection1
    CommandText = 
      'Select'#13#10'    IDPessoa,'#13#10'    PessoaFirstName as Nome,'#13#10'    PessoaL' +
      'astName as Sobrenome,'#13#10'    Pessoa as NomeCompleto,'#13#10'    Endereco' +
      ','#13#10'    Cidade,'#13#10'    CEP,'#13#10'    Telefone,'#13#10'    CPF,'#13#10'    CGC'#13#10'From' +
      #13#10'    Pessoa'#13#10'Where'#13#10'    IDTipoPessoa IN (1,10)'#13#10
    Parameters = <>
    Left = 305
    Top = 210
    object quPessoaOIDPessoa: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'IDPessoa'
    end
    object quPessoaOCPF: TStringField
      DisplayLabel = 'Doc'
      FieldName = 'CPF'
      Size = 30
    end
    object quPessoaONome: TStringField
      DisplayLabel = 'FirstName'
      FieldName = 'Nome'
      Size = 30
    end
    object quPessoaOSobrenome: TStringField
      DisplayLabel = 'LastName'
      FieldName = 'Sobrenome'
      Size = 30
    end
    object quPessoaOCGC: TStringField
      DisplayLabel = 'CustID'
      FieldName = 'CGC'
      Size = 30
    end
    object quPessoaONomeCompleto: TStringField
      DisplayLabel = 'FullName'
      FieldName = 'NomeCompleto'
      Size = 50
    end
    object quPessoaOEndereco: TStringField
      DisplayLabel = 'Address'
      FieldName = 'Endereco'
      Size = 80
    end
    object quPessoaOCidade: TStringField
      DisplayLabel = 'City'
      FieldName = 'Cidade'
      Size = 40
    end
    object quPessoaOCEP: TStringField
      DisplayLabel = 'ZIP'
      FieldName = 'CEP'
      FixedChar = True
      Size = 12
    end
    object quPessoaOTelefone: TStringField
      DisplayLabel = 'Phone'
      FieldName = 'Telefone'
      Size = 40
    end
  end
  object quPessoaD: TADODataSet
    Connection = ADOConnection1
    CommandText = 
      'Select'#13#10'    IDPessoa,'#13#10'    PessoaFirstName as Nome,'#13#10'    PessoaL' +
      'astName as Sobrenome,'#13#10'    Pessoa as NomeCompleto,'#13#10'    Endereco' +
      ','#13#10'    Cidade,'#13#10'    CEP,'#13#10'    Telefone,'#13#10'    CPF,'#13#10'    CGC'#13#10'From' +
      #13#10'    Pessoa'#13#10'Where'#13#10'    IDTipoPessoa IN (1,10)'#13#10
    Parameters = <>
    Left = 295
    Top = 350
    object quPessoaDIDPessoa: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'IDPessoa'
    end
    object quPessoaDCPF: TStringField
      DisplayLabel = 'Doc'
      FieldName = 'CPF'
      Size = 30
    end
    object quPessoaDNome: TStringField
      DisplayLabel = 'FirstName'
      FieldName = 'Nome'
      Size = 30
    end
    object quPessoaDSobrenome: TStringField
      DisplayLabel = 'LastName'
      FieldName = 'Sobrenome'
      Size = 30
    end
    object quPessoaDCGC: TStringField
      DisplayLabel = 'CustID'
      FieldName = 'CGC'
      Size = 30
    end
    object quPessoaDNomeCompleto: TStringField
      DisplayLabel = 'FullName'
      FieldName = 'NomeCompleto'
      Size = 50
    end
    object quPessoaDEndereco: TStringField
      DisplayLabel = 'Address'
      FieldName = 'Endereco'
      Size = 80
    end
    object quPessoaDCidade: TStringField
      DisplayLabel = 'City'
      FieldName = 'Cidade'
      Size = 40
    end
    object quPessoaDCEP: TStringField
      DisplayLabel = 'ZIP'
      FieldName = 'CEP'
      FixedChar = True
      Size = 12
    end
    object quPessoaDTelefone: TStringField
      DisplayLabel = 'Phone'
      FieldName = 'Telefone'
      Size = 40
    end
  end
  object dsPessoaO: TDataSource
    DataSet = quPessoaO
    OnDataChange = dsPessoaODataChange
    Left = 305
    Top = 166
  end
  object dsPessoaD: TDataSource
    DataSet = quPessoaD
    OnDataChange = dsPessoaDDataChange
    Left = 295
    Top = 406
  end
  object spExecute: TADOStoredProc
    Connection = ADOConnection1
    ProcedureName = 'sp_Sys_ConsolidarPessoa;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPessoaEleita'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPessoaDelete'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 510
    Top = 170
  end
end
