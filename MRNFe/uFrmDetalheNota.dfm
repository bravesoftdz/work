object FrmDetalheNota: TFrmDetalheNota
  Left = 405
  Top = -1
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 674
  ClientWidth = 470
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    470
    674)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 10
    Top = 5
    Width = 446
    Height = 66
    Caption = '  Nota  '
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 15
      Width = 45
      Height = 13
      Alignment = taRightJustify
      Caption = 'N'#186' Nota :'
    end
    object DBText1: TDBText
      Left = 58
      Top = 15
      Width = 141
      Height = 17
      DataField = 'I_InvoiceCode'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 25
      Top = 29
      Width = 30
      Height = 13
      Alignment = taRightJustify
      Caption = 'Data :'
    end
    object DBText2: TDBText
      Left = 58
      Top = 29
      Width = 141
      Height = 17
      DataField = 'I_InvoiceDate'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 250
      Top = 15
      Width = 34
      Height = 13
      Alignment = taRightJustify
      Caption = 'CFOP :'
    end
    object DBText3: TDBText
      Left = 288
      Top = 15
      Width = 141
      Height = 17
      DataField = 'CFOP_Description'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label28: TLabel
      Left = 235
      Top = 30
      Width = 49
      Height = 13
      Alignment = taRightJustify
      Caption = 'Frete R$ :'
    end
    object DBText30: TDBText
      Left = 287
      Top = 30
      Width = 141
      Height = 17
      DataField = 'I_Frete'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label33: TLabel
      Left = 211
      Top = 45
      Width = 73
      Height = 13
      Alignment = taRightJustify
      Caption = 'Total Nota R$ :'
    end
    object DBText35: TDBText
      Left = 287
      Top = 45
      Width = 141
      Height = 17
      DataField = 'I_SubTotal'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object GroupBox2: TGroupBox
    Left = 11
    Top = 75
    Width = 446
    Height = 163
    Caption = '  Empresa  '
    TabOrder = 1
    object Label5: TLabel
      Left = 48
      Top = 14
      Width = 34
      Height = 13
      Alignment = taRightJustify
      Caption = 'Nome :'
    end
    object DBText5: TDBText
      Left = 85
      Top = 14
      Width = 354
      Height = 17
      DataField = 'E_Empresa'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 4
      Top = 30
      Width = 78
      Height = 13
      Alignment = taRightJustify
      Caption = 'Nome Fantasia :'
    end
    object DBText6: TDBText
      Left = 85
      Top = 30
      Width = 351
      Height = 17
      DataField = 'E_NomeFantasia'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 15
      Top = 46
      Width = 67
      Height = 13
      Alignment = taRightJustify
      Caption = 'Razao Social :'
    end
    object DBText4: TDBText
      Left = 85
      Top = 46
      Width = 351
      Height = 17
      DataField = 'E_RazaoSocial'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 54
      Top = 61
      Width = 28
      Height = 13
      Alignment = taRightJustify
      Caption = 'CGC :'
    end
    object DBText7: TDBText
      Left = 85
      Top = 61
      Width = 131
      Height = 17
      DataField = 'E_CGC'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 258
      Top = 61
      Width = 25
      Height = 13
      Alignment = taRightJustify
      Caption = 'I.E. :'
    end
    object DBText8: TDBText
      Left = 286
      Top = 61
      Width = 131
      Height = 17
      DataField = 'E_InscricaoEstadual'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 31
      Top = 76
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'Endereco :'
    end
    object DBText9: TDBText
      Left = 85
      Top = 76
      Width = 355
      Height = 17
      DataField = 'E_Endereco'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 11
      Top = 91
      Width = 72
      Height = 13
      Alignment = taRightJustify
      Caption = 'Complemento :'
    end
    object DBText10: TDBText
      Left = 85
      Top = 91
      Width = 131
      Height = 17
      DataField = 'E_Coplemento'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel
      Left = 264
      Top = 91
      Width = 19
      Height = 13
      Alignment = taRightJustify
      Caption = 'N'#186' :'
    end
    object DBText11: TDBText
      Left = 286
      Top = 91
      Width = 131
      Height = 17
      DataField = 'E_Numero'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 48
      Top = 106
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Caption = 'Bairro :'
    end
    object DBText12: TDBText
      Left = 85
      Top = 106
      Width = 131
      Height = 17
      DataField = 'E_Bairro'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label13: TLabel
      Left = 233
      Top = 106
      Width = 50
      Height = 13
      Alignment = taRightJustify
      Caption = 'Municipio :'
    end
    object DBText13: TDBText
      Left = 286
      Top = 106
      Width = 42
      Height = 17
      DataField = 'E_MunicipioCode'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText14: TDBText
      Left = 331
      Top = 106
      Width = 112
      Height = 17
      DataField = 'E_Municipio'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label14: TLabel
      Left = 43
      Top = 122
      Width = 40
      Height = 13
      Alignment = taRightJustify
      Caption = 'Estado :'
    end
    object DBText15: TDBText
      Left = 85
      Top = 122
      Width = 131
      Height = 17
      DataField = 'E_IDEstado'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel
      Left = 262
      Top = 122
      Width = 21
      Height = 13
      Alignment = taRightJustify
      Caption = 'Tel :'
    end
    object DBText16: TDBText
      Left = 286
      Top = 122
      Width = 131
      Height = 17
      DataField = 'E_Telefone'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label18: TLabel
      Left = 57
      Top = 138
      Width = 26
      Height = 13
      Alignment = taRightJustify
      Caption = 'CEP :'
    end
    object DBText19: TDBText
      Left = 85
      Top = 138
      Width = 131
      Height = 17
      DataField = 'E_CEP'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object GroupBox3: TGroupBox
    Left = 11
    Top = 240
    Width = 446
    Height = 123
    Caption = '  Cliente  '
    TabOrder = 2
    object Label16: TLabel
      Left = 48
      Top = 14
      Width = 34
      Height = 13
      Alignment = taRightJustify
      Caption = 'Nome :'
    end
    object DBText17: TDBText
      Left = 85
      Top = 14
      Width = 354
      Height = 17
      DataField = 'P_Pessoa'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label19: TLabel
      Left = 56
      Top = 29
      Width = 26
      Height = 13
      Alignment = taRightJustify
      Caption = 'CPF :'
    end
    object DBText20: TDBText
      Left = 85
      Top = 29
      Width = 131
      Height = 17
      DataField = 'P_CPF'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label20: TLabel
      Left = 258
      Top = 29
      Width = 25
      Height = 13
      Alignment = taRightJustify
      Caption = 'I.E. :'
    end
    object DBText21: TDBText
      Left = 286
      Top = 29
      Width = 131
      Height = 17
      DataField = 'P_InscEstadual'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label21: TLabel
      Left = 31
      Top = 44
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'Endereco :'
    end
    object DBText22: TDBText
      Left = 85
      Top = 44
      Width = 355
      Height = 17
      DataField = 'P_Endereco'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label22: TLabel
      Left = 11
      Top = 59
      Width = 72
      Height = 13
      Alignment = taRightJustify
      Caption = 'Complemento :'
    end
    object DBText23: TDBText
      Left = 85
      Top = 59
      Width = 131
      Height = 17
      DataField = 'P_Complemento'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label23: TLabel
      Left = 264
      Top = 59
      Width = 19
      Height = 13
      Alignment = taRightJustify
      Caption = 'N'#186' :'
    end
    object DBText24: TDBText
      Left = 286
      Top = 59
      Width = 131
      Height = 17
      DataField = 'P_ComplementoNum'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label24: TLabel
      Left = 48
      Top = 74
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Caption = 'Bairro :'
    end
    object DBText25: TDBText
      Left = 85
      Top = 74
      Width = 131
      Height = 17
      DataField = 'P_Bairro'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label25: TLabel
      Left = 233
      Top = 74
      Width = 50
      Height = 13
      Alignment = taRightJustify
      Caption = 'Municipio :'
    end
    object DBText26: TDBText
      Left = 286
      Top = 74
      Width = 42
      Height = 17
      DataField = 'P_MunicipioCode'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText27: TDBText
      Left = 331
      Top = 74
      Width = 112
      Height = 17
      DataField = 'P_Municipio'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label26: TLabel
      Left = 57
      Top = 104
      Width = 26
      Height = 13
      Alignment = taRightJustify
      Caption = 'CEP :'
    end
    object DBText28: TDBText
      Left = 85
      Top = 104
      Width = 131
      Height = 17
      DataField = 'P_CEP'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label27: TLabel
      Left = 262
      Top = 90
      Width = 21
      Height = 13
      Alignment = taRightJustify
      Caption = 'Tel :'
    end
    object DBText29: TDBText
      Left = 286
      Top = 90
      Width = 131
      Height = 17
      DataField = 'P_Telefone'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label17: TLabel
      Left = 43
      Top = 89
      Width = 40
      Height = 13
      Alignment = taRightJustify
      Caption = 'Estado :'
    end
    object DBText18: TDBText
      Left = 85
      Top = 89
      Width = 106
      Height = 17
      DataField = 'P_IDEstado'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object grdItems: TcxGrid
    Left = 10
    Top = 448
    Width = 446
    Height = 195
    TabOrder = 3
    LookAndFeel.NativeStyle = False
    object grdItemsDBTableView1: TcxGridDBTableView
      DataController.DataSource = dsItens
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDInventoryMov'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsSelection.HideSelection = True
      OptionsSelection.InvertSelect = False
      OptionsView.GridLineColor = clBtnFace
      OptionsView.GroupByBox = False
      Preview.Visible = True
      object grdItemsDBTableView1M_Model: TcxGridDBColumn
        Caption = 'Modelo'
        DataBinding.FieldName = 'M_Model'
        Options.Editing = False
        Width = 58
      end
      object grdItemsDBTableView1M_Description: TcxGridDBColumn
        Caption = 'Descricao'
        DataBinding.FieldName = 'M_Description'
        Options.Editing = False
        Width = 152
      end
      object grdItemsDBTableView1IM_QTY: TcxGridDBColumn
        Caption = 'Qtd'
        DataBinding.FieldName = 'IM_QTY'
        Options.Editing = False
        Width = 54
      end
      object grdItemsDBTableView1IM_Discount: TcxGridDBColumn
        Caption = 'Desconto'
        DataBinding.FieldName = 'IM_Discount'
        Options.Editing = False
        Width = 62
      end
      object grdItemsDBTableView1IM_SalePrice: TcxGridDBColumn
        Caption = 'Preco'
        DataBinding.FieldName = 'IM_SalePrice'
        Options.Editing = False
        Width = 59
      end
      object grdItemsDBTableView1U_Sigla: TcxGridDBColumn
        Caption = 'Sigla'
        DataBinding.FieldName = 'U_Sigla'
        Options.Editing = False
        Width = 36
      end
      object grdItemsDBTableView1U_Unidade: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'U_Unidade'
        Options.Editing = False
        Width = 62
      end
      object grdItemsDBTableView1CFOP_Number: TcxGridDBColumn
        Caption = 'CFOP'
        DataBinding.FieldName = 'CFOP_Number'
        Options.Editing = False
        Width = 73
      end
      object grdItemsDBTableView1AliquotaDesc: TcxGridDBColumn
        Caption = 'Aliquota'
        DataBinding.FieldName = 'AliquotaDesc'
        Options.Editing = False
        Width = 250
      end
    end
    object grdItemsLevel1: TcxGridLevel
      GridView = grdItemsDBTableView1
    end
  end
  object GroupBox4: TGroupBox
    Left = 11
    Top = 366
    Width = 446
    Height = 79
    Caption = '  Transportadora  '
    TabOrder = 4
    object Label29: TLabel
      Left = 48
      Top = 14
      Width = 34
      Height = 13
      Alignment = taRightJustify
      Caption = 'Nome :'
    end
    object DBText31: TDBText
      Left = 85
      Top = 14
      Width = 354
      Height = 17
      DataField = 'T_Pessoa'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label30: TLabel
      Left = 56
      Top = 29
      Width = 26
      Height = 13
      Alignment = taRightJustify
      Caption = 'CPF :'
    end
    object DBText32: TDBText
      Left = 85
      Top = 29
      Width = 131
      Height = 17
      DataField = 'T_CPF'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label31: TLabel
      Left = 258
      Top = 29
      Width = 25
      Height = 13
      Alignment = taRightJustify
      Caption = 'I.E. :'
    end
    object DBText33: TDBText
      Left = 286
      Top = 29
      Width = 131
      Height = 17
      DataField = 'T_InscEstadual'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label32: TLabel
      Left = 31
      Top = 44
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'Endereco :'
    end
    object DBText34: TDBText
      Left = 85
      Top = 44
      Width = 355
      Height = 17
      DataField = 'T_Endereco'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label39: TLabel
      Left = 43
      Top = 60
      Width = 40
      Height = 13
      Alignment = taRightJustify
      Caption = 'Estado :'
    end
    object DBText42: TDBText
      Left = 85
      Top = 60
      Width = 106
      Height = 17
      DataField = 'T_IDEstado'
      DataSource = dsNota
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object btEnviar: TButton
    Left = 305
    Top = 648
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Enviar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 5
    OnClick = btEnviarClick
  end
  object btFechar: TButton
    Left = 385
    Top = 648
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Fechar'
    ModalResult = 2
    TabOrder = 6
    OnClick = btFecharClick
  end
  object cdsNota: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspNota'
    AfterOpen = cdsNotaAfterOpen
    Left = 435
    Top = 65
  end
  object dspNota: TDataSetProvider
    DataSet = dmSQL.dsInvoice
    Left = 435
    Top = 15
  end
  object dsNota: TDataSource
    DataSet = cdsNota
    Left = 435
    Top = 115
  end
  object dspItem: TDataSetProvider
    DataSet = dmSQL.dsInvoiceItem
    Left = 430
    Top = 350
  end
  object cdsItens: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItem'
    Left = 430
    Top = 405
    object cdsItensIDInventoryMov: TIntegerField
      FieldName = 'IDInventoryMov'
    end
    object cdsItensM_Model: TStringField
      FieldName = 'M_Model'
      Size = 30
    end
    object cdsItensM_Description: TStringField
      FieldName = 'M_Description'
      Size = 50
    end
    object cdsItensIM_QTY: TBCDField
      FieldName = 'IM_QTY'
      DisplayFormat = '0.####'
      Precision = 32
    end
    object cdsItensIM_SalePrice: TBCDField
      FieldName = 'IM_SalePrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00##'
      Precision = 19
    end
    object cdsItensIM_Discount: TBCDField
      FieldName = 'IM_Discount'
      ReadOnly = True
      DisplayFormat = '#,##0.00##'
      Precision = 19
    end
    object cdsItensU_Unidade: TStringField
      FieldName = 'U_Unidade'
      Size = 100
    end
    object cdsItensU_Sigla: TStringField
      FieldName = 'U_Sigla'
      FixedChar = True
      Size = 4
    end
    object cdsItensT_SituacaoTributaria: TIntegerField
      FieldName = 'T_SituacaoTributaria'
      ReadOnly = True
    end
    object cdsItensTaxCategoriaPer: TBCDField
      FieldName = 'TaxCategoriaPer'
      Precision = 19
    end
    object cdsItensTaxEstadoPerc: TBCDField
      FieldName = 'TaxEstadoPerc'
      Precision = 19
    end
    object cdsItensTaxItemPer: TBCDField
      FieldName = 'TaxItemPer'
      Precision = 19
    end
    object cdsItensEstadoCliente: TStringField
      FieldName = 'EstadoCliente'
      FixedChar = True
      Size = 3
    end
    object cdsItensEstadoLoja: TStringField
      FieldName = 'EstadoLoja'
      FixedChar = True
      Size = 3
    end
    object cdsItensMVAInterno: TBCDField
      FieldName = 'MVAInterno'
      Precision = 32
    end
    object cdsItensMVAInterestadual: TBCDField
      FieldName = 'MVAInterestadual'
      Precision = 32
    end
    object cdsItensSitTribItem: TIntegerField
      FieldName = 'SitTribItem'
      ReadOnly = True
    end
    object cdsItensSitTribCategoria: TIntegerField
      FieldName = 'SitTribCategoria'
      ReadOnly = True
    end
    object cdsItensCFOP_Number: TStringField
      FieldName = 'CFOP_Number'
      ReadOnly = True
    end
    object cdsItensT_Aliquota: TCurrencyField
      FieldName = 'T_Aliquota'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object cdsItensIM_Frete: TBCDField
      FieldName = 'IM_Frete'
      ReadOnly = True
      Precision = 32
      Size = 6
    end
    object cdsItensT_AliquotaST: TBCDField
      FieldName = 'T_AliquotaST'
      Precision = 19
    end
    object cdsItensTotalFrete: TBCDField
      FieldName = 'TotalFrete'
      Precision = 19
    end
    object cdsItensM_SerialNumber: TBooleanField
      FieldName = 'M_SerialNumber'
    end
    object cdsItensM_NCMCodigo: TStringField
      FieldName = 'M_NCMCodigo'
    end
    object cdsItensMVAPercent: TCurrencyField
      FieldName = 'MVAPercent'
      ReadOnly = True
    end
    object cdsItensAliquotaDesc: TStringField
      FieldName = 'AliquotaDesc'
      ReadOnly = True
      Size = 100
    end
  end
  object dsItens: TDataSource
    DataSet = cdsItens
    Left = 430
    Top = 455
  end
end
