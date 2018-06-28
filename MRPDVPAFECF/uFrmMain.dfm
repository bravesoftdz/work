object FrmMain: TFrmMain
  Left = 365
  Top = 307
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'PAF-ECF'
  ClientHeight = 139
  ClientWidth = 128
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnGerarEstoque: TButton
    Left = 10
    Top = 35
    Width = 111
    Height = 21
    Caption = 'Gerar Estoque'
    TabOrder = 1
    OnClick = btnGerarEstoqueClick
  end
  object btnGerarMercServ: TButton
    Left = 10
    Top = 10
    Width = 111
    Height = 21
    Caption = 'Gerar Merc. e Serv.'
    TabOrder = 0
    OnClick = btnGerarMercServClick
  end
  object btnGerarOperacao: TButton
    Left = 10
    Top = 60
    Width = 111
    Height = 21
    Caption = 'Gerar Operacao'
    TabOrder = 2
    OnClick = btnGerarOperacaoClick
  end
  object deInicial: TdxDateEdit
    Left = 10
    Top = 85
    Width = 111
    TabOrder = 3
    Date = -700000.000000000000000000
  end
  object deFinal: TdxDateEdit
    Left = 10
    Top = 110
    Width = 111
    TabOrder = 4
    Date = -700000.000000000000000000
  end
  object mrPafEcf: TmrPafEcf
    NomePAFECF = 'CASH REGISTER'
    VersaoPAFECF = '1.6'
    VersaoERPAFECF = '01.00'
    CaminhoArquivos = 'C:\Program Files\MainRetail\PDV\'
    ChavePublica = 
      'B146872648A6F5222DC919A85DE1131565875FB7FFEDB72652999161D0D4B585' +
      '274A01B4B160EE2C39B7691563F39BA39BEFC966341F818B1154D71911295751' +
      'B6C5478B023B439EC5EE82060432E7122FF2D9490D2ED5430820FAE2EDCC02D9' +
      'AEAE1875B342A707C42980F6C0769EC42F29BD8B13769FCBA2418983A8FBCA6B'
    ChavePrivada = 
      'E9CE8FB7CF8A3D3CD0DF92A55643C1B5368F9D3A24DEEB790BACEC273C802B71' +
      '13170D9D0D171364DE67C68A0D5DB78910AA12D1065C0490C0DA3F172C76D807' +
      'C21A454393B73CB89A4B2EF7A96A417C1D0D4FF909ED3AAB53FBBD9E2169B4F4' +
      '08FA4F33393E6DA2DE76B6A6D1313E99E5BDB135C14DCE6093ED21CCF21F797D'
    PAFECFDesenvolvedora.RazaoSocial = 'SOFTVAR SOLU'#199#213'ES EM INFORM'#193'TICA LTDA'
    PAFECFDesenvolvedora.CNPJ = '06246012000187'
    PAFECFDesenvolvedora.InscricaoMunicipal = '3828071'
    PAFECFDesenvolvedora.InscricaoEstadual = 'ISENTA'
    Left = 50
    Top = 200
  end
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=fudeu;Persist Security Info=True;Us' +
      'er ID=sa;Initial Catalog=SupplyDB;Data Source=(local)'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 50
    Top = 245
  end
  object cdsEstoque: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspEstoque'
    Left = 160
    Top = 100
    object cdsEstoqueModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsEstoqueDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsEstoqueUnidade: TStringField
      FieldName = 'Unidade'
      ReadOnly = True
      FixedChar = True
      Size = 4
    end
    object cdsEstoqueQuantidade: TBCDField
      FieldName = 'Quantidade'
      Precision = 32
    end
    object cdsEstoqueDataEstoque: TDateTimeField
      FieldName = 'DataEstoque'
      ReadOnly = True
    end
  end
  object qryEstoque: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDStore'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'M.Model,'
      #9'M.[Description],'
      #9'IsNull(U.Sigla, '#39'UN'#39') Unidade,'
      #9'QtyOnHand Quantidade,'
      #9'GetDate() DataEstoque'
      'FROM'
      #9'Model M'
      #9'LEFT JOIN Unidade U ON (M.IDUnidade = U.IDUnidade)'
      #9'LEFT JOIN Inventory I ON (M.IDModel = I.ModelID)'
      'WHERE'
      #9'M.Desativado = 0'
      #9'AND I.StoreID = :IDStore')
    Left = 160
    Top = 10
  end
  object dspEstoque: TDataSetProvider
    DataSet = qryEstoque
    Left = 160
    Top = 55
  end
  object cdsMercadoriaServico: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMercadoriaServico'
    Left = 160
    Top = 245
    object cdsMercadoriaServicoModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsMercadoriaServicoDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsMercadoriaServicoUnidade: TStringField
      FieldName = 'Unidade'
      ReadOnly = True
      FixedChar = True
      Size = 4
    end
    object cdsMercadoriaServicoIAT: TStringField
      FieldName = 'IAT'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object cdsMercadoriaServicoIPPT: TStringField
      FieldName = 'IPPT'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object cdsMercadoriaServicoSituacaoTributaria: TStringField
      FieldName = 'SituacaoTributaria'
      ReadOnly = True
      Size = 1
    end
    object cdsMercadoriaServicoAliquota: TBCDField
      FieldName = 'Aliquota'
      Precision = 19
    end
    object cdsMercadoriaServicoValorUnitario: TBCDField
      FieldName = 'ValorUnitario'
      Precision = 19
    end
  end
  object qryMercadoriaServico: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'M.Model,'
      #9'M.[Description],'
      #9'IsNull(U.Sigla, '#39'UN'#39') Unidade,'
      #9'IsNull(IndicadorAT, '#39'T'#39') IAT,'
      #9'IsNull(M.IndicadorProducao, '#39'T'#39') IPPT,'
      #9'CASE SituacaoTributaria'
      #9#9'WHEN 0 THEN '#39'A'#39' -- Nenhuma'
      #9#9'WHEN 1 THEN '#39'T'#39' -- Tribut'#225'vel (ICMS)'
      #9#9'WHEN 2 THEN '#39'N'#39' -- N'#227'o Tribut'#225'vel'
      #9#9'WHEN 3 THEN '#39'F'#39' -- Substitui'#231#227'o Tribut'#225'ria'
      #9#9'WHEN 4 THEN '#39'I'#39' -- Isento'
      #9#9'WHEN 5 THEN '#39'S'#39' -- ISS (ISSQN)'
      #9'END SituacaoTributaria,'
      #9'TC.Tax Aliquota,'
      #9'M.SellingPrice ValorUnitario'
      'FROM'
      #9'Model M'
      #9'JOIN StoreToTabGroup STG ON (M.GroupID = STG.IDGroup)'
      #9'JOIN TaxCategory TC ON (STG.IDSaleTax = TC.IDTaxCategory)'
      #9'LEFT JOIN Unidade U ON (M.IDUnidade = U.IDUnidade)'
      'WHERE'
      #9'M.Desativado = 0'
      #9'AND STG.IDStore = :IDStore')
    Left = 160
    Top = 155
  end
  object dspMercadoriaServico: TDataSetProvider
    DataSet = qryMercadoriaServico
    Left = 160
    Top = 200
  end
  object cdsReducaoZ: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspReducaoZ'
    Left = 250
    Top = 100
    object cdsReducaoZMFAdicional: TStringField
      FieldName = 'MFAdicional'
      FixedChar = True
      Size = 1
    end
    object cdsReducaoZTipoECF: TStringField
      FieldName = 'TipoECF'
    end
    object cdsReducaoZMarcaECF: TStringField
      FieldName = 'MarcaECF'
    end
    object cdsReducaoZModeloECF: TStringField
      FieldName = 'ModeloECF'
    end
    object cdsReducaoZVersaoSBECF: TStringField
      FieldName = 'VersaoSBECF'
      Size = 10
    end
    object cdsReducaoZDataInstalacaoSBECF: TDateTimeField
      FieldName = 'DataInstalacaoSBECF'
    end
    object cdsReducaoZNumeroECF: TIntegerField
      FieldName = 'NumeroECF'
    end
    object cdsReducaoZContadorReducaoZ: TIntegerField
      FieldName = 'ContadorReducaoZ'
    end
    object cdsReducaoZContadorOrdemOperacao: TIntegerField
      FieldName = 'ContadorOrdemOperacao'
    end
    object cdsReducaoZContadorReinicioOperacao: TIntegerField
      FieldName = 'ContadorReinicioOperacao'
    end
    object cdsReducaoZNumeroUsuarioECF: TIntegerField
      FieldName = 'NumeroUsuarioECF'
    end
    object cdsReducaoZVendaBruta: TBCDField
      FieldName = 'VendaBruta'
      ReadOnly = True
      Precision = 19
    end
    object cdsReducaoZIncideISSQN: TBooleanField
      FieldName = 'IncideISSQN'
    end
    object cdsReducaoZDataInicial: TDateTimeField
      FieldKind = fkCalculated
      FieldName = 'DataInicial'
      Calculated = True
    end
    object cdsReducaoZDataFinal: TDateTimeField
      FieldKind = fkCalculated
      FieldName = 'DataFinal'
      Calculated = True
    end
    object cdsReducaoZMovDate: TDateTimeField
      FieldName = 'MovDate'
    end
    object cdsReducaoZNumeroFabricacao: TStringField
      FieldName = 'NumeroFabricacao'
    end
    object cdsReducaoZDataEmissao: TDateTimeField
      FieldName = 'DataEmissao'
    end
  end
  object qryReducaoZ: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'DataInicial'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFinal'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'RZ.MovDate,'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.TipoECF,'
      #9'RZ.MarcaECF,'
      #9'RZ.ModeloECF,'
      #9'RZ.VersaoSBECF,'
      #9'RZ.DataInstalacaoSBECF,'
      #9'RZ.NumeroECF,'
      #9'RZ.ContadorReducaoZ,'
      #9'RZ.ContadorOrdemOperacao,'
      #9'RZ.ContadorReinicioOperacao,'
      #9'RZ.NumeroUsuarioECF,'
      #9'(RZ.GTFinal - RZ.GTInicial) VendaBruta,'
      #9'RZ.IncideISSQN,'
      #9'RZ.DataEmissao'
      'FROM'
      #9'Sal_ReducaoZ RZ'
      'WHERE'
      #9'RZ.MovDate > :DataInicial'
      #9'AND RZ.MovDate <= :DataFinal')
    Left = 250
    Top = 10
  end
  object dspReducaoZ: TDataSetProvider
    DataSet = qryReducaoZ
    Left = 250
    Top = 55
  end
  object cdsTotalizadorParcial: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspTotalizadorParcial'
    Left = 350
    Top = 100
    object cdsTotalizadorParcialNumeroFabricacao: TStringField
      FieldName = 'NumeroFabricacao'
    end
    object cdsTotalizadorParcialMFAdicional: TStringField
      FieldName = 'MFAdicional'
      FixedChar = True
      Size = 1
    end
    object cdsTotalizadorParcialModeloECF: TStringField
      FieldName = 'ModeloECF'
    end
    object cdsTotalizadorParcialContadorReducaoZ: TIntegerField
      FieldName = 'ContadorReducaoZ'
    end
    object cdsTotalizadorParcialNumeroUsuarioECF: TIntegerField
      FieldName = 'NumeroUsuarioECF'
    end
    object cdsTotalizadorParcialCodigo: TStringField
      FieldName = 'Codigo'
      Size = 10
    end
    object cdsTotalizadorParcialValorAcumulado: TBCDField
      FieldName = 'ValorAcumulado'
      Precision = 19
    end
  end
  object qryTotalizadorParcial: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'DataInicial'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFinal'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.ModeloECF,'
      #9'RZ.ContadorReducaoZ,'
      #9'RZ.NumeroUsuarioECF,'
      #9'TP.Codigo,'
      #9'TP.ValorAcumulado'
      'FROM'
      #9'Sal_TotalizadorParcial TP'
      #9'JOIN Sal_ReducaoZ RZ ON (TP.IDReducaoZ = RZ.IDReducaoZ)'
      'WHERE'
      #9'RZ.MovDate > :DataInicial'
      #9'AND RZ.MovDate <= :DataFinal')
    Left = 350
    Top = 10
  end
  object dspTotalizadorParcial: TDataSetProvider
    DataSet = qryTotalizadorParcial
    Left = 350
    Top = 55
  end
  object cdsVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspVenda'
    Left = 250
    Top = 245
    object cdsVendaNumeroFabricacao: TStringField
      FieldName = 'NumeroFabricacao'
    end
    object cdsVendaMFAdicional: TStringField
      FieldName = 'MFAdicional'
      FixedChar = True
      Size = 1
    end
    object cdsVendaModeloECF: TStringField
      FieldName = 'ModeloECF'
    end
    object cdsVendaNumeroUsuarioECF: TIntegerField
      FieldName = 'NumeroUsuarioECF'
    end
    object cdsVendaContadorDocumento: TIntegerField
      FieldName = 'ContadorDocumento'
      ReadOnly = True
    end
    object cdsVendaContadorOrdemOperacao: TIntegerField
      FieldName = 'ContadorOrdemOperacao'
      ReadOnly = True
    end
    object cdsVendaDataInicioEmissao: TDateTimeField
      FieldName = 'DataInicioEmissao'
      ReadOnly = True
    end
    object cdsVendaValorSubTotal: TBCDField
      FieldName = 'ValorSubTotal'
      Precision = 19
    end
    object cdsVendaValorDesconto: TBCDField
      FieldName = 'ValorDesconto'
      ReadOnly = True
      Precision = 19
    end
    object cdsVendaIndicadorDesconto: TStringField
      FieldName = 'IndicadorDesconto'
      ReadOnly = True
      Size = 1
    end
    object cdsVendaValorAcrescimo: TBCDField
      FieldName = 'ValorAcrescimo'
      ReadOnly = True
      Precision = 2
      Size = 2
    end
    object cdsVendaIndicadorAcrescimo: TStringField
      FieldName = 'IndicadorAcrescimo'
      ReadOnly = True
      Size = 1
    end
    object cdsVendaValorTotalLiquido: TBCDField
      FieldName = 'ValorTotalLiquido'
      ReadOnly = True
      Precision = 19
    end
    object cdsVendaIndicadorCancelamento: TStringField
      FieldName = 'IndicadorCancelamento'
      ReadOnly = True
      Size = 1
    end
    object cdsVendaCancelamentoAcrescimo: TBCDField
      FieldName = 'CancelamentoAcrescimo'
      ReadOnly = True
      Precision = 2
      Size = 2
    end
    object cdsVendaOrdemAplicacaoDA: TStringField
      FieldName = 'OrdemAplicacaoDA'
      ReadOnly = True
      Size = 1
    end
    object cdsVendaNomeCliente: TStringField
      FieldName = 'NomeCliente'
      ReadOnly = True
      Size = 50
    end
    object cdsVendaDocumentoCliente: TStringField
      FieldName = 'DocumentoCliente'
      ReadOnly = True
      Size = 30
    end
  end
  object qryVenda: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDCashRegister1'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'DataInicial1'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'DataFinal1'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'IDCashRegister2'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'DataInicial2'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'DataFinal2'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      '-- VENDAS FINALIZADAS'
      'SELECT'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.ModeloECF,'
      #9'RZ.NumeroUsuarioECF,'
      #9'Cast(I.InvoiceCode as Int) ContadorDocumento,'
      #9'Cast(I.CupomFiscal as Int) ContadorOrdemOperacao,'
      #9'I.PreSaleDate DataInicioEmissao,'
      #9'I.SubTotal ValorSubTotal,'
      
        #9'(IsNull(I.ItemDiscount, 0) + IsNull(I.InvoiceDiscount, 0)) Valo' +
        'rDesconto,'
      #9#39'V'#39' IndicadorDesconto,'
      #9'0.00 ValorAcrescimo,'
      #9#39'V'#39' IndicadorAcrescimo,'
      
        #9'(I.SubTotal - IsNull(I.ItemDiscount, 0) - IsNull(I.InvoiceDisco' +
        'unt, 0)) ValorTotalLiquido,'
      #9#39'N'#39' IndicadorCancelamento,'
      #9'0.00 CancelamentoAcrescimo,'
      #9#39'D'#39' OrdemAplicacaoDA,'
      
        #9'(CASE WHEN P.IDPessoa IS NULL THEN I.CompanyName ELSE P.Pessoa ' +
        'END) NomeCliente,'
      
        #9'IsNull((CASE WHEN P.IDPessoa IS NULL THEN I.CompanyCGC ELSE CAS' +
        'E P.Juridico WHEN 0 THEN P.CPF WHEN 1 THEN P.CGC END END), '#39#39') D' +
        'ocumentoCliente'
      'FROM'
      #9'Invoice I'
      #9'JOIN CashRegMov CRM ON (I.CashRegMovID = CRM.IDCashRegMov)'
      
        #9'JOIN Sal_ReducaoZ RZ ON (CRM.IDCashRegister = RZ.IDCashRegister' +
        ')'
      #9'LEFT JOIN Pessoa P ON (I.IDCustomer = P.IDPessoa)'
      'WHERE'
      #9'RZ.IDCashRegister = :IDCashRegister1'
      #9'AND RZ.MovDate > :DataInicial1'
      #9'AND RZ.MovDate <= :DataFinal1'
      #9'AND I.CupomFiscal IS NOT NULL'
      'UNION'
      '-- VENDAS CANCELADAS'
      'SELECT'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.ModeloECF,'
      #9'RZ.NumeroUsuarioECF,'
      #9'SNC.CCF ContadorDocumento,'
      #9'SNC.COO ContadorOrdemOperacao,'
      #9'SNC.DataNota DataInicioEmissao,'
      #9'SNC.SubTotal ValorSubTotal,'
      #9'IsNull(SNC.Desconto, 0) ValorDesconto,'
      #9'SNC.TipoDesconto IndicadorDesconto,'
      #9'0.00 ValorAcrescimo,'
      #9'SNC.TipoAcrescimo IndicadorAcrescimo,'
      #9'(SNC.SubTotal - IsNull(SNC.Desconto, 0)) ValorTotalLiquido,'
      #9#39'S'#39' IndicadorCancelamento,'
      #9'0.00 CancelamentoAcrescimo,'
      #9#39'D'#39' OrdemAplicacaoDA,'
      
        #9'(CASE WHEN P.IDPessoa IS NULL THEN SNC.Cliente ELSE P.Pessoa EN' +
        'D) NomeCliente,'
      
        #9'IsNull((CASE WHEN P.IDPessoa IS NULL THEN SNC.CPFCGC ELSE CASE ' +
        'P.Juridico WHEN 0 THEN P.CPF WHEN 1 THEN P.CGC END END), '#39#39') Doc' +
        'umentoCliente'
      'FROM'
      #9'Sal_NotasCanceladas SNC'
      #9'JOIN CashRegMov CRM ON (SNC.IDCashRegMov = CRM.IDCashRegMov)'
      
        #9'JOIN Sal_ReducaoZ RZ ON (CRM.IDCashRegister = RZ.IDCashRegister' +
        ')'
      #9'LEFT JOIN Pessoa P ON (SNC.IDPessoa = P.IDPessoa)'
      'WHERE'
      #9'RZ.IDCashRegister = :IDCashRegister2'
      #9'AND RZ.MovDate > :DataInicial2'
      #9'AND RZ.MovDate <= :DataFinal2'
      #9'AND SNC.COO IS NOT NULL')
    Left = 250
    Top = 155
  end
  object dspVenda: TDataSetProvider
    DataSet = qryVenda
    Left = 250
    Top = 200
  end
  object cdsItemVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItemVenda'
    Left = 350
    Top = 245
    object cdsItemVendaNumeroFabricacao: TStringField
      FieldName = 'NumeroFabricacao'
    end
    object cdsItemVendaMFAdicional: TStringField
      FieldName = 'MFAdicional'
      FixedChar = True
      Size = 1
    end
    object cdsItemVendaModeloECF: TStringField
      FieldName = 'ModeloECF'
    end
    object cdsItemVendaNumeroUsuarioECF: TIntegerField
      FieldName = 'NumeroUsuarioECF'
    end
    object cdsItemVendaContadorOrdemOperacao: TIntegerField
      FieldName = 'ContadorOrdemOperacao'
      ReadOnly = True
    end
    object cdsItemVendaContadorDocumento: TIntegerField
      FieldName = 'ContadorDocumento'
      ReadOnly = True
    end
    object cdsItemVendaNumeroItem: TIntegerField
      FieldName = 'NumeroItem'
      ReadOnly = True
    end
    object cdsItemVendaCodigoProduto: TStringField
      FieldName = 'CodigoProduto'
      Size = 30
    end
    object cdsItemVendaDescricaoProduto: TStringField
      FieldName = 'DescricaoProduto'
      Size = 50
    end
    object cdsItemVendaQuantidade: TBCDField
      FieldName = 'Quantidade'
      Precision = 32
    end
    object cdsItemVendaUnidade: TStringField
      FieldName = 'Unidade'
      ReadOnly = True
      FixedChar = True
      Size = 4
    end
    object cdsItemVendaValorUnitario: TBCDField
      FieldName = 'ValorUnitario'
      Precision = 19
    end
    object cdsItemVendaDesconto: TBCDField
      FieldName = 'Desconto'
      ReadOnly = True
      Precision = 19
    end
    object cdsItemVendaAcrescimo: TBCDField
      FieldName = 'Acrescimo'
      ReadOnly = True
      Precision = 19
    end
    object cdsItemVendaValorTotalLiquido: TBCDField
      FieldName = 'ValorTotalLiquido'
      ReadOnly = True
      Precision = 32
      Size = 6
    end
    object cdsItemVendaTotalizadorParcial: TStringField
      FieldName = 'TotalizadorParcial'
      ReadOnly = True
      Size = 10
    end
    object cdsItemVendaIndicadorCancelamento: TStringField
      FieldName = 'IndicadorCancelamento'
      ReadOnly = True
      Size = 1
    end
    object cdsItemVendaQuantidadeCancelada: TBCDField
      FieldName = 'QuantidadeCancelada'
      ReadOnly = True
      Precision = 2
      Size = 2
    end
    object cdsItemVendaValorCancelado: TBCDField
      FieldName = 'ValorCancelado'
      ReadOnly = True
      Precision = 2
      Size = 2
    end
    object cdsItemVendaCancelamentoAcrescimo: TBCDField
      FieldName = 'CancelamentoAcrescimo'
      ReadOnly = True
      Precision = 2
      Size = 2
    end
    object cdsItemVendaIAT: TStringField
      FieldName = 'IAT'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object cdsItemVendaIPPT: TStringField
      FieldName = 'IPPT'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object cdsItemVendaNumCasaDecQtd: TIntegerField
      FieldName = 'NumCasaDecQtd'
      ReadOnly = True
    end
    object cdsItemVendaNumCasaDecVal: TIntegerField
      FieldName = 'NumCasaDecVal'
      ReadOnly = True
    end
  end
  object qryItemVenda: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDCashRegister1'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataInicial1'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFinal1'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'IDCashRegister2'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataInicial2'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFinal2'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'IDCashRegister3'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataInicial3'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFinal3'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      '-- ITENS DE VENDAS FINALIZADAS'
      'SELECT'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.ModeloECF,'
      #9'RZ.NumeroUsuarioECF,'
      #9'Cast(I.CupomFiscal as Int) ContadorOrdemOperacao,'
      #9'Cast(I.InvoiceCode as Int) ContadorDocumento,'
      #9'IsNull(IM.SequencyNum, 1) NumeroItem,'
      #9'M.Model CodigoProduto,'
      #9'M.[Description] DescricaoProduto,'
      #9'IM.Qty Quantidade,'
      #9'IsNull(U.Sigla, '#39'UN'#39') Unidade,'
      #9'IM.SalePrice ValorUnitario,'
      
        #9'(CASE WHEN IM.Discount >= 0 THEN IM.Discount ELSE 0 END) Descon' +
        'to,'
      
        #9'(CASE WHEN IM.Discount < 0 THEN IM.Discount ELSE 0 END) Acresci' +
        'mo,'
      #9'((IM.SalePrice * IM.Qty) - IM.Discount) ValorTotalLiquido,'
      #9'IsNull(IMC.TotalizadorParcial, '#39'01T1800'#39') TotalizadorParcial,'
      #9#39'N'#39' IndicadorCancelamento,'
      #9'0.00 QuantidadeCancelada,'
      #9'0.00 ValorCancelado,'
      #9'0.00 CancelamentoAcrescimo,'
      #9'IsNull(M.IndicadorAT, '#39'T'#39') IAT,'
      #9'IsNull(M.IndicadorProducao, '#39'T'#39') IPPT,'
      #9'2 NumCasaDecQtd,'
      #9'2 NumCasaDecVal'
      'FROM'
      #9'InventoryMov IM'
      #9'JOIN Invoice I ON (IM.DocumentID = I.IDInvoice)'
      #9'JOIN CashRegMov CRM ON (I.CashRegMovID = CRM.IDCashRegMov)'
      
        #9'JOIN Sal_ReducaoZ RZ ON (CRM.IDCashRegister = RZ.IDCashRegister' +
        ')'
      #9'JOIN Model M ON (IM.ModelID = M.IDModel)'
      
        #9'LEFT JOIN Inv_MovComplement IMC ON (IM.IDInventoryMov = IMC.IDI' +
        'nventoryMov)'
      #9'LEFT JOIN Unidade U ON (M.IDUnidade = U.IDUnidade)'
      'WHERE'
      #9'RZ.IDCashRegister = :IDCashRegister1'
      #9'AND RZ.MovDate > :DataInicial1'
      #9'AND RZ.MovDate <= :DataFinal1'
      #9'AND I.CupomFiscal IS NOT NULL'
      'UNION'
      '-- ITENS CANCELADOS DE VENDAS FINALIZADAS'
      'SELECT'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.ModeloECF,'
      #9'RZ.NumeroUsuarioECF,'
      #9'Cast(I.CupomFiscal as Int) ContadorOrdemOperacao,'
      #9'Cast(I.InvoiceCode as Int) ContadorDocumento,'
      #9'IsNull(RI.PosicaoItem, 1) NumeroItem,'
      #9'M.Model CodigoProduto,'
      #9'M.[Description] DescricaoProduto,'
      #9'RI.Qty Quantidade,'
      #9'IsNull(U.Sigla, '#39'UN'#39') Unidade,'
      #9'RI.SalePrice ValorUnitario,'
      
        #9'(CASE WHEN RI.Discount >= 0 THEN RI.Discount ELSE 0 END) Descon' +
        'to,'
      
        #9'(CASE WHEN RI.Discount < 0 THEN RI.Discount ELSE 0 END) Acresci' +
        'mo,'
      #9'((RI.SalePrice * RI.Qty) - RI.Discount) ValorTotalLiquido,'
      #9'IsNull(RI.TotalizadorParcial, '#39'01T1800'#39') TotalizadorParcial,'
      #9#39'N'#39' IndicadorCancelamento,'
      #9'0.00 QuantidadeCancelada,'
      #9'0.00 ValorCancelado,'
      #9'0.00 CancelamentoAcrescimo,'
      #9'IsNull(M.IndicadorAT, '#39'T'#39') IAT,'
      #9'IsNull(M.IndicadorProducao, '#39'T'#39') IPPT,'
      #9'2 NumCasaDecQtd,'
      #9'2 NumCasaDecVal'
      'FROM'
      #9'Sal_RemovedItem RI'
      #9'JOIN Invoice I ON (RI.IDPreSale = I.IDPreSale)'
      #9'JOIN CashRegMov CRM ON (I.CashRegMovID = CRM.IDCashRegMov)'
      
        #9'JOIN Sal_ReducaoZ RZ ON (CRM.IDCashRegister = RZ.IDCashRegister' +
        ')'
      #9'JOIN Model M ON (RI.IDModel = M.IDModel)'
      #9'LEFT JOIN Unidade U ON (M.IDUnidade = U.IDUnidade)'
      'WHERE'
      #9'RZ.IDCashRegister = :IDCashRegister2'
      #9'AND RZ.MovDate > :DataInicial2'
      #9'AND RZ.MovDate <= :DataFinal2'
      #9'AND I.CupomFiscal IS NOT NULL'
      'UNION'
      '-- ITENS CANCELADOS DE VENDAS CANCELADAS'
      'SELECT'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.ModeloECF,'
      #9'RZ.NumeroUsuarioECF,'
      #9'Cast(SNC.COO as Int) ContadorOrdemOperacao,'
      #9'Cast(SNC.CCF as Int) ContadorDocumento,'
      #9'IsNull(RI.PosicaoItem, 1) NumeroItem,'
      #9'M.Model CodigoProduto,'
      #9'M.[Description] DescricaoProduto,'
      #9'RI.Qty Quantidade,'
      #9'IsNull(U.Sigla, '#39'UN'#39') Unidade,'
      #9'RI.SalePrice ValorUnitario,'
      
        #9'(CASE WHEN RI.Discount >= 0 THEN RI.Discount ELSE 0 END) Descon' +
        'to,'
      
        #9'(CASE WHEN RI.Discount < 0 THEN RI.Discount ELSE 0 END) Acresci' +
        'mo,'
      #9'((RI.SalePrice * RI.Qty) - RI.Discount) ValorTotalLiquido,'
      #9'IsNull(RI.TotalizadorParcial, '#39'01T1800'#39') TotalizadorParcial,'
      #9#39'N'#39' IndicadorCancelamento,'
      #9'0.00 QuantidadeCancelada,'
      #9'0.00 ValorCancelado,'
      #9'0.00 CancelamentoAcrescimo,'
      #9'IsNull(M.IndicadorAT, '#39'T'#39') IAT,'
      #9'IsNull(M.IndicadorProducao, '#39'T'#39') IPPT,'
      #9'2 NumCasaDecQtd,'
      #9'2 NumCasaDecVal'
      'FROM'
      #9'Sal_RemovedItem RI'
      
        #9'JOIN Sal_NotasCanceladas SNC ON (RI.IDNotasCanceladas = SNC.IDN' +
        'otasCanceladas)'
      #9'JOIN CashRegMov CRM ON (SNC.IDCashRegMov = CRM.IDCashRegMov)'
      
        #9'JOIN Sal_ReducaoZ RZ ON (CRM.IDCashRegister = RZ.IDCashRegister' +
        ')'
      #9'JOIN Model M ON (RI.IDModel = M.IDModel)'
      #9'LEFT JOIN Unidade U ON (M.IDUnidade = U.IDUnidade)'
      'WHERE'
      #9'RZ.IDCashRegister = :IDCashRegister3'
      #9'AND RZ.MovDate > :DataInicial3'
      #9'AND RZ.MovDate <= :DataFinal3'
      #9'AND SNC.COO IS NOT NULL')
    Left = 350
    Top = 155
  end
  object dspItemVenda: TDataSetProvider
    DataSet = qryItemVenda
    Left = 350
    Top = 200
  end
  object cdsDocumentoGeral: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDocumentoGeral'
    Left = 450
    Top = 245
    object cdsDocumentoGeralNumeroFabricacao: TStringField
      FieldName = 'NumeroFabricacao'
    end
    object cdsDocumentoGeralMFAdicional: TStringField
      FieldName = 'MFAdicional'
      FixedChar = True
      Size = 1
    end
    object cdsDocumentoGeralModeloECF: TStringField
      FieldName = 'ModeloECF'
    end
    object cdsDocumentoGeralNumeroUsuarioECF: TIntegerField
      FieldName = 'NumeroUsuarioECF'
    end
    object cdsDocumentoGeralCOO: TIntegerField
      FieldName = 'COO'
    end
    object cdsDocumentoGeralGNF: TIntegerField
      FieldName = 'GNF'
    end
    object cdsDocumentoGeralGRG: TIntegerField
      FieldName = 'GRG'
      ReadOnly = True
    end
    object cdsDocumentoGeralCDC: TIntegerField
      FieldName = 'CDC'
    end
    object cdsDocumentoGeralDenominacao: TStringField
      FieldName = 'Denominacao'
      ReadOnly = True
      Size = 2
    end
    object cdsDocumentoGeralDataEmissao: TDateTimeField
      FieldName = 'DataEmissao'
    end
  end
  object qryDocumentoGeral: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDCashRegister1'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataInicial1'
        Attributes = [paSigned, paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFinal1'
        Attributes = [paSigned, paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'IDCashRegister2'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataInicial2'
        Attributes = [paSigned, paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFinal2'
        Attributes = [paSigned, paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      '-- DOCUMENTOS DE PAGAMENTOS'
      'SELECT'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.ModeloECF,'
      #9'RZ.NumeroUsuarioECF,'
      #9'LC.COO,'
      #9'LC.GNF,'
      #9'0 GRG,'
      #9'LC.CDC,'
      #9#39'CC'#39' Denominacao,'
      #9'LC.DataEmissao'
      'FROM'
      #9'Fin_LancamentoComplement LC'
      #9'JOIN Fin_Lancamento L ON (LC.IDLancamento = L.IDLancamento)'
      #9'JOIN Invoice I ON (L.IDPreSale = I.IDPreSale)'
      #9'JOIN CashRegMov CRM ON (I.CashRegMovID = CRM.IDCashRegMov)'
      
        #9'JOIN Sal_ReducaoZ RZ ON (CRM.IDCashRegister = RZ.IDCashRegister' +
        ')'
      'WHERE'
      #9'RZ.IDCashRegister = :IDCashRegister1'
      #9'AND RZ.MovDate > :DataInicial1'
      #9'AND RZ.MovDate <= :DataFinal1'
      #9'AND I.CupomFiscal IS NOT NULL'
      'UNION'
      '-- DOCUMENTOS DE SANGRIA E SUPRIMENTO'
      'SELECT'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.ModeloECF,'
      #9'RZ.NumeroUsuarioECF,'
      #9'IsNull(CRLC.COO, 0) COO,'
      #9'IsNull(CRLC.GNF, 0) GNF,'
      #9'0 GRG,'
      #9'0 CDC,'
      #9#39'CN'#39' Denominacao,'
      #9'CRL.LogTime DataEmissao'
      'FROM'
      #9'CashRegLogComplement CRLC'
      #9'JOIN CashRegLog CRL ON (CRLC.IDCashRegLog = CRL.IDCashRegLog)'
      #9'JOIN CashRegMov CRM ON (CRL.IDCashRegMov = CRM.IDCashRegMov)'
      
        #9'JOIN Sal_ReducaoZ RZ ON (CRM.IDCashRegister = RZ.IDCashRegister' +
        ')'
      'WHERE'
      #9'RZ.IDCashRegister = :IDCashRegister2'
      #9'AND RZ.MovDate > :DataInicial2'
      #9'AND RZ.MovDate <= :DataFinal2')
    Left = 450
    Top = 155
  end
  object dspDocumentoGeral: TDataSetProvider
    DataSet = qryDocumentoGeral
    Left = 450
    Top = 200
  end
  object cdsPagamento: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPagamento'
    Left = 450
    Top = 100
    object cdsPagamentoNumeroFabricacao: TStringField
      FieldName = 'NumeroFabricacao'
    end
    object cdsPagamentoMFAdicional: TStringField
      FieldName = 'MFAdicional'
      FixedChar = True
      Size = 1
    end
    object cdsPagamentoModeloECF: TStringField
      FieldName = 'ModeloECF'
    end
    object cdsPagamentoNumeroUsuarioECF: TIntegerField
      FieldName = 'NumeroUsuarioECF'
    end
    object cdsPagamentoCOO: TIntegerField
      FieldName = 'COO'
    end
    object cdsPagamentoCCF: TStringField
      FieldName = 'CCF'
    end
    object cdsPagamentoGNF: TIntegerField
      FieldName = 'GNF'
    end
    object cdsPagamentoMeioPagamento: TStringField
      FieldName = 'MeioPagamento'
      Size = 50
    end
    object cdsPagamentoValorPago: TBCDField
      FieldName = 'ValorPago'
      Precision = 19
    end
    object cdsPagamentoIndicadorEstorno: TStringField
      FieldName = 'IndicadorEstorno'
      ReadOnly = True
      Size = 1
    end
    object cdsPagamentoValorEstorno: TBCDField
      FieldName = 'ValorEstorno'
      ReadOnly = True
      Precision = 2
      Size = 2
    end
  end
  object qryPagamento: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDCashRegister'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataInicial'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFinal'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.ModeloECF,'
      #9'RZ.NumeroUsuarioECF,'
      #9'LC.COO,'
      #9'I.InvoiceCode CCF,'
      #9'LC.GNF,'
      #9'MP.MeioPag MeioPagamento,'
      #9'L.ValorNominal ValorPago,'
      #9#39'N'#39' IndicadorEstorno,'
      #9'0.00 ValorEstorno'
      'FROM'
      #9'Fin_LancamentoComplement LC'
      #9'JOIN Fin_Lancamento L ON (LC.IDLancamento = L.IDLancamento)'
      #9'JOIN Invoice I ON (L.IDPreSale = I.IDPreSale)'
      #9'JOIN CashRegMov CRM ON (I.CashRegMovID = CRM.IDCashRegMov)'
      
        #9'JOIN Sal_ReducaoZ RZ ON (CRM.IDCashRegister = RZ.IDCashRegister' +
        ')'
      #9'JOIN MeioPag MP ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag)'
      'WHERE'
      #9'RZ.IDCashRegister = :IDCashRegister'
      #9'AND RZ.MovDate > :DataInicial'
      #9'AND RZ.MovDate <= :DataFinal'
      #9'AND I.CupomFiscal IS NOT NULL')
    Left = 450
    Top = 10
  end
  object dspPagamento: TDataSetProvider
    DataSet = qryPagamento
    Left = 450
    Top = 55
  end
end
