object FrmGeraArquivo: TFrmGeraArquivo
  Left = 200
  Top = 214
  BorderStyle = bsSingle
  Caption = 'Gerar Arquivo'
  ClientHeight = 400
  ClientWidth = 729
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grdGarantias: TcxGrid
    Left = 0
    Top = 49
    Width = 729
    Height = 304
    Align = alClient
    TabOrder = 0
    LookAndFeel.Kind = lfFlat
    object grdGarantiasTableView: TcxGridDBTableView
      DataController.DataSource = dsForm
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object grdGarantiasTableViewInvoiceCode: TcxGridDBColumn
        Caption = 'N'#186' Pedido'
        DataBinding.FieldName = 'SaleCode'
        Options.Editing = False
        Width = 77
      end
      object grdGarantiasTableViewDescription: TcxGridDBColumn
        Caption = 'Garantia'
        DataBinding.FieldName = 'Description'
        Options.Editing = False
        Width = 115
      end
      object grdGarantiasTableViewDBGarantiaMeses: TcxGridDBColumn
        Caption = 'Meses'
        DataBinding.FieldName = 'GarantiaMeses'
        Options.Editing = False
        Width = 26
      end
      object grdGarantiasTableViewQty: TcxGridDBColumn
        Caption = 'Qtd'
        DataBinding.FieldName = 'Qty'
        Options.Editing = False
        Width = 23
      end
      object grdGarantiasTableViewDBGarantiaFabrica: TcxGridDBColumn
        Caption = 'Gar. F'#225'brica'
        DataBinding.FieldName = 'GarantiaFabrica'
        Options.Editing = False
        Width = 45
      end
      object grdGarantiasTableViewSalePrice: TcxGridDBColumn
        Caption = 'R$ Garan.'
        DataBinding.FieldName = 'SalePrice'
        Options.Editing = False
        Width = 59
      end
      object grdGarantiasTableViewNFProduto: TcxGridDBColumn
        Caption = 'N'#186' fatura prod.'
        DataBinding.FieldName = 'NotaFiscalProduto'
        Width = 77
      end
      object grdGarantiasTableViewDBColumn1: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'DescProduto'
        Options.Editing = False
        Width = 157
      end
      object grdGarantiasTableViewValorProduto: TcxGridDBColumn
        Caption = 'R$ Prod.'
        DataBinding.FieldName = 'ValorProduto'
        Options.Editing = False
        Width = 62
      end
      object grdGarantiasTableViewIDInventoryMov: TcxGridDBColumn
        DataBinding.FieldName = 'IDInventoryMov'
        Visible = False
        Options.Editing = False
      end
      object grdGarantiasTableViewIDInvoice: TcxGridDBColumn
        DataBinding.FieldName = 'IDInvoice'
        Visible = False
        Options.Editing = False
      end
      object grdGarantiasTableViewModel: TcxGridDBColumn
        DataBinding.FieldName = 'Model'
        Visible = False
        Options.Editing = False
      end
      object grdGarantiasTableViewStoreID: TcxGridDBColumn
        DataBinding.FieldName = 'StoreID'
        Visible = False
        Options.Editing = False
      end
      object grdGarantiasTableViewDiscount: TcxGridDBColumn
        DataBinding.FieldName = 'Discount'
        Visible = False
        Options.Editing = False
      end
      object grdGarantiasTableViewMovDate: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'MovDate'
        Visible = False
        Options.Editing = False
        Width = 50
      end
    end
    object grdGarantiasLevel: TcxGridLevel
      GridView = grdGarantiasTableView
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 729
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label3: TLabel
      Left = 20
      Top = 20
      Width = 14
      Height = 13
      Caption = 'De'
    end
    object Label4: TLabel
      Left = 148
      Top = 20
      Width = 15
      Height = 13
      Caption = 'at'#233
    end
    object edtDataInicial: TcxDateEdit
      Left = 40
      Top = 16
      Width = 101
      Height = 21
      TabOrder = 0
    end
    object edtDataFinal: TcxDateEdit
      Left = 168
      Top = 16
      Width = 101
      Height = 21
      TabOrder = 1
    end
    object btnGO: TcxButton
      Left = 664
      Top = 4
      Width = 50
      Height = 37
      Caption = '&GO!'
      TabOrder = 2
      OnClick = btnGOClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 353
    Width = 729
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnFechar: TcxButton
      Left = 648
      Top = 4
      Width = 75
      Height = 21
      Caption = '&Fechar'
      TabOrder = 0
      OnClick = btnFecharClick
    end
    object btnGerarArquivo: TcxButton
      Left = 568
      Top = 4
      Width = 75
      Height = 21
      Caption = '&Gerar arquivo'
      TabOrder = 1
      OnClick = btnGerarArquivoClick
    end
  end
  object sbMain: TStatusBar
    Left = 0
    Top = 381
    Width = 729
    Height = 19
    Panels = <
      item
        Text = 'Total de 0 Garantias'
        Width = 50
      end>
  end
  object cdsForm: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftDateTime
        Name = 'DataInicial'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DataFinal'
        ParamType = ptInput
      end>
    ProviderName = 'dspForm'
    Left = 104
    Top = 96
    object cdsFormMovDate: TDateTimeField
      FieldName = 'MovDate'
      ReadOnly = True
    end
    object cdsFormStoreID: TIntegerField
      FieldName = 'StoreID'
      ReadOnly = True
    end
    object cdsFormSequencyNum: TIntegerField
      FieldName = 'SequencyNum'
      ReadOnly = True
    end
    object cdsFormSalePrice: TBCDField
      FieldName = 'SalePrice'
      ReadOnly = True
      DisplayFormat = 'R$ #,##0.00'
      Precision = 19
    end
    object cdsFormQty: TFloatField
      FieldName = 'Qty'
      ReadOnly = True
    end
    object cdsFormIDPreInvMovExchange: TIntegerField
      FieldName = 'IDPreInvMovExchange'
      ReadOnly = True
    end
    object cdsFormModel: TStringField
      FieldName = 'Model'
      ReadOnly = True
      Size = 30
    end
    object cdsFormDescription: TStringField
      FieldName = 'Description'
      ReadOnly = True
      Size = 50
    end
    object cdsFormFabricante: TStringField
      FieldName = 'Fabricante'
      ReadOnly = True
      Size = 50
    end
    object cdsFormSerialNumber: TStringField
      FieldName = 'SerialNumber'
      ReadOnly = True
      FixedChar = True
      Size = 30
    end
    object cdsFormValorProduto: TBCDField
      FieldName = 'ValorProduto'
      DisplayFormat = 'R$ #,##0.00'
      Precision = 19
    end
    object cdsFormGarantiaTipo: TStringField
      FieldName = 'GarantiaTipo'
      Size = 6
    end
    object cdsFormGarantiaMeses: TIntegerField
      FieldName = 'GarantiaMeses'
    end
    object cdsFormGarantiaFabrica: TIntegerField
      FieldName = 'GarantiaFabrica'
    end
    object cdsFormDescProduto: TStringField
      FieldName = 'DescProduto'
      Size = 50
    end
    object cdsFormDocumento: TStringField
      FieldName = 'Documento'
      ReadOnly = True
      Size = 30
    end
    object cdsFormFormaPagamento: TStringField
      FieldName = 'FormaPagamento'
      ReadOnly = True
      Size = 30
    end
    object cdsFormInicioVigencia: TDateTimeField
      FieldName = 'InicioVigencia'
    end
    object cdsFormTerminoVigencia: TDateTimeField
      FieldName = 'TerminoVigencia'
    end
    object cdsFormLoja: TStringField
      FieldName = 'Loja'
      ReadOnly = True
      Size = 30
    end
    object cdsFormNome: TStringField
      FieldName = 'Nome'
      ReadOnly = True
      Size = 50
    end
    object cdsFormEndereco: TStringField
      FieldName = 'Endereco'
      ReadOnly = True
      Size = 80
    end
    object cdsFormBairro: TStringField
      FieldName = 'Bairro'
      ReadOnly = True
      Size = 50
    end
    object cdsFormCEP: TStringField
      FieldName = 'CEP'
      ReadOnly = True
      FixedChar = True
      Size = 12
    end
    object cdsFormCidade: TStringField
      FieldName = 'Cidade'
      ReadOnly = True
      Size = 40
    end
    object cdsFormUF: TStringField
      FieldName = 'UF'
      ReadOnly = True
      FixedChar = True
      Size = 3
    end
    object cdsFormCidadeUFCEP: TStringField
      FieldName = 'CidadeUFCEP'
      ReadOnly = True
      Size = 61
    end
    object cdsFormDataNascimento: TDateTimeField
      FieldName = 'DataNascimento'
      ReadOnly = True
    end
    object cdsFormCPF: TStringField
      FieldName = 'CPF'
      ReadOnly = True
      Size = 30
    end
    object cdsFormIdentidade: TStringField
      FieldName = 'Identidade'
      ReadOnly = True
      Size = 30
    end
    object cdsFormIdentidadeOrgaoEmissor: TStringField
      FieldName = 'IdentidadeOrgaoEmissor'
      ReadOnly = True
      Size = 50
    end
    object cdsFormIdentidadeDataExpedicao: TDateTimeField
      FieldName = 'IdentidadeDataExpedicao'
      ReadOnly = True
    end
    object cdsFormIdentidadeExpedicaoOrgao: TStringField
      FieldName = 'IdentidadeExpedicaoOrgao'
      ReadOnly = True
      Size = 83
    end
    object cdsFormTelefone: TStringField
      FieldName = 'Telefone'
      ReadOnly = True
      Size = 45
    end
    object cdsFormCelular: TStringField
      FieldName = 'Celular'
      ReadOnly = True
      Size = 23
    end
    object cdsFormSaleCode: TStringField
      FieldName = 'SaleCode'
      ReadOnly = True
    end
    object cdsFormInvoiceCode: TStringField
      FieldName = 'InvoiceCode'
    end
    object cdsFormIDInvoice: TIntegerField
      FieldName = 'IDInvoice'
    end
    object cdsFormIDPreSaleParent: TIntegerField
      FieldName = 'IDPreSaleParent'
    end
    object cdsFormIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsFormNotaFiscalProduto: TStringField
      FieldName = 'NotaFiscalProduto'
      Size = 30
    end
    object cdsFormDataEnvio: TDateTimeField
      FieldName = 'DataEnvio'
    end
  end
  object dsForm: TDataSource
    DataSet = cdsForm
    Left = 104
    Top = 148
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.txt'
    Filter = 'Documentos de texto (*.txt)|*.txt'
    Left = 104
    Top = 36
  end
  object quExchange: TADOQuery
    Connection = FrmPrincipal.Connection
    Parameters = <
      item
        Name = 'IDPreInvMovExchange'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'IM.MovDate'
      'FROM'
      #9'InventoryMov IM'
      'WHERE'
      #9'IM.PreInventoryMovID= :IDPreInvMovExchange')
    Left = 268
    Top = 132
    object quExchangeMovDate: TDateTimeField
      FieldName = 'MovDate'
    end
  end
end
