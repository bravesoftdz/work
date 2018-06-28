object DMSintegra: TDMSintegra
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 314
  Top = 182
  Height = 404
  Width = 554
  object ADOConn: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=fudeu;Persist Security Info=True;Us' +
      'er ID=sa;Initial Catalog=InputBoxDB;Data Source=Desenv001;Use Pr' +
      'ocedure for Prepare=1;Auto Translate=True;Packet Size=4096;Works' +
      'tation ID=DESENV004;Use Encryption for Data=False;Tag with colum' +
      'n collation when possible=False'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 20
    Top = 16
  end
  object quSale: TADOQuery
    Connection = ADOConn
    CursorType = ctStatic
    OnCalcFields = quSaleCalcFields
    Parameters = <
      item
        Name = 'FirstDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'LastDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'C.IDPessoa,'
      #9'C.UserCode CodFornecedor,'
      #9'CFOP.Number CFOP,'
      #9'M.Model CodProduto,'
      #9'IM.Qty Qtd,'
      #9'((IM.SalePrice * IM.Qty) - IM.Discount) as ValorTotal,'
      
        #9'(((IM.SalePrice * IM.Qty) - IM.Discount) * (Tax.Tax/100)) as Va' +
        'lorImposto,'
      #9'Tax.Tax as PercImposto,'
      #9'IM.Freight Frete,'
      #9'IM.OtherCost OutrosCustos,'
      #9'IM.CostPrice NovoCusto,'
      #9'I.InvoiceCode NotaFiscal,'
      #9'I.PreSaleDate DataRegistro,'
      #9'I.InvoiceDate DataFatura,'
      #9'C.CPF,'
      #9'C.NomeJuridico InscEstadual,'
      #9'CAST('#39'01'#39' as varchar(2)) as GrupoFornecido,'
      #9'C.IDEstado UF,'
      #9'C.Pessoa Cliente,'
      #9'M.Description Produto,'
      #9'CAST('#39#39' as varchar(20)) as CF'
      'FROM'
      #9'InventoryMov IM (NOLOCK)'
      #9'JOIN Invoice I (NOLOCK) ON (IM.DocumentID = I.IDInvoice)'
      #9'JOIN Pessoa C (NOLOCK) ON (IM.IDPessoa = C.IDPessoa)'
      #9'JOIN Model M (NOLOCK) ON (IM.ModelID = M.IDModel)'
      
        #9'JOIN StoreToTabGroup STG (NOLOCK) ON (STG.IDStore = I.IDStore A' +
        'ND M.GroupID = STG.IDGroup)'
      
        #9'JOIN TaxCategory Tax (NOLOCK) ON (Tax.IDTaxCategory = STG.IDSal' +
        'eTax)'
      
        #9'LEFT JOIN InvoiceOBS IOBS (NOLOCK) ON (IOBS.IDPreSale = I.IDPre' +
        'Sale)'
      #9'LEFT JOIN Mnt_CFOP CFOP (NOLOCK) ON (IOBS.IDCFOP = CFOP.IDCFOP)'
      'WHERE'
      #9'IM.InventMovTypeID = 1'
      #9'AND I.InvoiceDate >= :FirstDate'
      #9'AND I.InvoiceDate < :LastDate')
    Left = 216
    Top = 16
    object quSaleCodFornecedor: TStringField
      FieldName = 'CodFornecedor'
      Size = 5
    end
    object quSaleCodProduto: TStringField
      FieldName = 'CodProduto'
      Size = 30
    end
    object quSaleQtd: TFloatField
      FieldName = 'Qtd'
    end
    object quSaleValorTotal: TFloatField
      FieldName = 'ValorTotal'
      ReadOnly = True
    end
    object quSaleValorImposto: TBCDField
      FieldName = 'ValorImposto'
      Precision = 19
    end
    object quSalePercImposto: TBCDField
      FieldName = 'PercImposto'
      Precision = 19
    end
    object quSaleFrete: TBCDField
      FieldName = 'Frete'
      Precision = 19
    end
    object quSaleOutrosCustos: TBCDField
      FieldName = 'OutrosCustos'
      Precision = 19
    end
    object quSaleNovoCusto: TBCDField
      FieldName = 'NovoCusto'
      Precision = 19
    end
    object quSaleNotaFiscal: TStringField
      FieldName = 'NotaFiscal'
    end
    object quSaleDataRegistro: TDateTimeField
      FieldName = 'DataRegistro'
    end
    object quSaleDataFatura: TDateTimeField
      FieldName = 'DataFatura'
    end
    object quSaleCPF: TStringField
      FieldName = 'CPF'
      Size = 30
    end
    object quSaleInscEstadual: TStringField
      FieldName = 'InscEstadual'
      Size = 30
    end
    object quSaleUF: TStringField
      FieldName = 'UF'
      FixedChar = True
      Size = 3
    end
    object quSaleCliente: TStringField
      FieldName = 'Cliente'
      Size = 50
    end
    object quSaleProduto: TStringField
      FieldName = 'Produto'
      Size = 50
    end
    object quSaleIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quSaleCFOP: TStringField
      FieldName = 'CFOP'
      Size = 30
    end
    object quSaleEstado_UF: TStringField
      FieldKind = fkCalculated
      FieldName = 'Estado_UF'
      Size = 2
      Calculated = True
    end
    object quSaleGrupoFornecido: TStringField
      FieldName = 'GrupoFornecido'
      ReadOnly = True
      Size = 2
    end
    object quSaleCF: TStringField
      FieldName = 'CF'
      ReadOnly = True
    end
  end
  object quEcfProd: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 208
    Data = {
      D90000009619E0BD010000001800000007000000000003000000D9000D636F64
      69676F70726F6475746F0100490000000100055749445448020002000E000A71
      75616E74696461646508000400000000000A76616C6F72746F74616C08000400
      000000000F616C6971756F7461696D706F73746F010049000000010005574944
      54480200020004000B6E6F6D6570726F6475746F010049000000010005574944
      544802000200350007756E696461646501004900000001000557494454480200
      0200060002636601004900000001000557494454480200020003000000}
    object quEcfProdcodigoproduto: TStringField
      FieldName = 'codigoproduto'
      Size = 14
    end
    object quEcfProdquantidade: TFloatField
      FieldName = 'quantidade'
    end
    object quEcfProdvalortotal: TFloatField
      FieldName = 'valortotal'
    end
    object quEcfProdaliquotaimposto: TStringField
      FieldName = 'aliquotaimposto'
      Size = 4
    end
    object quEcfProdnomeproduto: TStringField
      FieldName = 'nomeproduto'
      Size = 53
    end
    object quEcfProdunidade: TStringField
      FieldName = 'unidade'
      Size = 6
    end
    object quEcfProdcf: TStringField
      FieldName = 'cf'
      Size = 3
    end
  end
  object qu60R: TADOQuery
    Connection = ADOConn
    Parameters = <
      item
        Name = 'FirstDate'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'LastDate'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'M.Model CodigoProduto,'
      #9'M.Description Produto,'
      #9'SUM(IM.Qty) Quantidade,'
      #9'SUM((IM.SalePrice * IM.Qty) - IM.Discount) ValorTotal,'
      #9'18.00 PercImposto,'
      #9#39'UN'#39' Unidade,'
      #9#39'000'#39' CF'
      'FROM'
      #9'InventoryMov IM'
      #9'JOIN Pessoa C ON (IM.IDPessoa = C.IDPessoa)'
      #9'JOIN Model M ON (IM.ModelID = M.IDModel)'
      'WHERE'
      #9'IM.MovDate >= :FirstDate'
      #9'AND IM.MovDate < :LastDate'
      'GROUP BY'
      #9'M.Model,'
      #9'M.Description'
      'ORDER BY'
      #9'M.Model')
    Left = 280
    Top = 16
    object qu60RCodigoProduto: TStringField
      FieldName = 'CodigoProduto'
      Size = 30
    end
    object qu60RProduto: TStringField
      FieldName = 'Produto'
      Size = 50
    end
    object qu60RQuantidade: TFloatField
      FieldName = 'Quantidade'
      ReadOnly = True
    end
    object qu60RValorTotal: TFloatField
      FieldName = 'ValorTotal'
      ReadOnly = True
    end
    object qu60RPercImposto: TBCDField
      FieldName = 'PercImposto'
      ReadOnly = True
      Precision = 2
      Size = 1
    end
    object qu60RUnidade: TStringField
      FieldName = 'Unidade'
      ReadOnly = True
      Size = 2
    end
    object qu60RCF: TStringField
      FieldName = 'CF'
      ReadOnly = True
      Size = 3
    end
  end
  object quReducaoZ: TADOQuery
    Connection = ADOConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'FirstDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'LastDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'Z.IDReducaoZ,'
      #9'Z.MovDate,'
      #9'Z.NumeroSerie,'
      #9'Z.NumeroLoja,'
      #9'Z.NumeroECF,'
      #9'Z.NumReducaoZ,'
      #9'Z.COOInicial,'
      #9'Z.COOFinal,'
      #9'Z.NumCancelamentos,'
      #9'Z.ValCancelamentos,'
      #9'Z.ValDescontos,'
      #9'Z.GTInicial,'
      #9'Z.GTFinal,'
      #9'Z.SubstituicaoTrib,'
      #9'Z.Isencao,'
      #9'Z.NaoTributavel'
      'FROM'
      #9'Sal_ReducaoZ Z'
      'WHERE'
      #9'Z.MovDate >= :FirstDate'
      #9'AND Z.MovDate < :LastDate'
      '')
    Left = 120
    Top = 212
    object quReducaoZIDReducaoZ: TIntegerField
      FieldName = 'IDReducaoZ'
    end
    object quReducaoZMovDate: TDateTimeField
      FieldName = 'MovDate'
    end
    object quReducaoZNumeroSerie: TStringField
      FieldName = 'NumeroSerie'
    end
    object quReducaoZNumeroLoja: TIntegerField
      FieldName = 'NumeroLoja'
    end
    object quReducaoZNumeroECF: TIntegerField
      FieldName = 'NumeroECF'
    end
    object quReducaoZNumReducaoZ: TIntegerField
      FieldName = 'NumReducaoZ'
    end
    object quReducaoZCOOInicial: TIntegerField
      FieldName = 'COOInicial'
    end
    object quReducaoZCOOFinal: TIntegerField
      FieldName = 'COOFinal'
    end
    object quReducaoZNumCancelamentos: TIntegerField
      FieldName = 'NumCancelamentos'
    end
    object quReducaoZValCancelamentos: TBCDField
      FieldName = 'ValCancelamentos'
      Precision = 19
    end
    object quReducaoZValDescontos: TBCDField
      FieldName = 'ValDescontos'
      Precision = 19
    end
    object quReducaoZGTInicial: TBCDField
      FieldName = 'GTInicial'
      Precision = 19
    end
    object quReducaoZGTFinal: TBCDField
      FieldName = 'GTFinal'
      Precision = 19
    end
    object quReducaoZSubstituicaoTrib: TBCDField
      FieldName = 'SubstituicaoTrib'
      Precision = 19
    end
    object quReducaoZIsencao: TBCDField
      FieldName = 'Isencao'
      Precision = 19
    end
    object quReducaoZNaoTributavel: TBCDField
      FieldName = 'NaoTributavel'
      Precision = 19
    end
  end
  object dspReducaoZ: TDataSetProvider
    DataSet = quReducaoZ
    Left = 120
    Top = 264
  end
  object cdsReducaoZ: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspReducaoZ'
    Left = 120
    Top = 316
  end
  object quTributacaoEcf: TADOQuery
    Connection = ADOConn
    Parameters = <
      item
        Name = 'FirstDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'LastDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'TECF.IDReducaoZ,'
      #9'TECF.Aliquota,'
      #9'TECF.BaseCalculo,'
      #9'TECF.ValImposto'
      'FROM'
      #9'Sal_TributacaoECF TECF'
      #9'JOIN Sal_ReducaoZ Z ON (TECF.IDReducaoZ = Z.IDReducaoZ)'
      'WHERE'
      #9'Z.MovDate >= :FirstDate'
      #9'AND Z.MovDate < :LastDate')
    Left = 208
    Top = 208
  end
  object dspTributacaoEcf: TDataSetProvider
    DataSet = quTributacaoEcf
    Left = 208
    Top = 264
  end
  object cdsTributacaoEcf: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspTributacaoEcf'
    Left = 208
    Top = 316
    object cdsTributacaoEcfIDReducaoZ: TIntegerField
      FieldName = 'IDReducaoZ'
    end
    object cdsTributacaoEcfAliquota: TFloatField
      FieldName = 'Aliquota'
    end
    object cdsTributacaoEcfBaseCalculo: TBCDField
      FieldName = 'BaseCalculo'
      Precision = 19
    end
    object cdsTributacaoEcfValImposto: TBCDField
      FieldName = 'ValImposto'
      Precision = 19
    end
  end
  object quStore: TADOQuery
    Connection = ADOConn
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'S.IDStore,'
      #9'S.Name Store'
      'FROM'
      #9'Store S')
    Left = 448
    Top = 208
    object quStoreIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quStoreStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
  end
  object quCashRegister: TADOQuery
    Connection = ADOConn
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'CR.IDCashRegister,'
      #9'CR.Name CashRegister'
      'FROM'
      #9'CashRegister CR')
    Left = 380
    Top = 208
    object quCashRegisterIDCashRegister: TIntegerField
      FieldName = 'IDCashRegister'
    end
    object quCashRegisterCashRegister: TStringField
      FieldName = 'CashRegister'
      Size = 15
    end
  end
  object dsCashRegister: TDataSource
    DataSet = quCashRegister
    Left = 380
    Top = 256
  end
  object dsStore: TDataSource
    DataSet = quStore
    Left = 448
    Top = 256
  end
  object spGetNextCode: TADOStoredProc
    Connection = ADOConn
    ProcedureName = 'sp_Sis_GetNextCode;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@Tabela'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@NovoCodigo'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 32
    Top = 316
  end
  object quECF: TADOQuery
    Connection = ADOConn
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'ECF.IDECF,'
      #9'ECF.NumeroECF,'
      #9'ECF.NumeroSerie,'
      #9'ECF.IDStore'
      'FROM'
      #9'Sal_ECF ECF')
    Left = 496
    Top = 208
    object quECFIDECF: TIntegerField
      FieldName = 'IDECF'
    end
    object quECFNumeroECF: TIntegerField
      FieldName = 'NumeroECF'
    end
    object quECFNumeroSerie: TStringField
      FieldName = 'NumeroSerie'
      Size = 15
    end
    object quECFIDStore: TIntegerField
      FieldName = 'IDStore'
    end
  end
  object dsECF: TDataSource
    DataSet = quECF
    Left = 496
    Top = 256
  end
  object quFreeSQL: TADOQuery
    Connection = ADOConn
    Parameters = <>
    Left = 32
    Top = 264
  end
  object quPurchase: TADOQuery
    Connection = ADOConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'FirstDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'LastDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'V.UserCode CodFornecedor,'
      #9'M.Model CodProduto,'
      #9'PI.Qty Qtd,'
      #9'(IsNull(PI.CostPrice, 0) * IsNull(PI.Qty, 0)) ValorTotal,'
      #9'IsNull(IMT.TaxValue, 0) ValorImposto,'
      #9'IMT.Tax PercImposto,'
      #9'IsNull(PI.FreightCost, 0) Frete,'
      #9'IsNull(PI.OtherCost, 0) OutrosCustos,'
      #9'IsNull(PI.NewCostPrice, 0) NovoCusto,'
      #9'CASE IsNull(PI.CaseQty, 0) WHEN 0 THEN '#39'UN'#39' ELSE '#39'CX'#39' END Tipo,'
      #9'PP.DocumentNumber NotaFiscal,'
      #9'PP.DatePreReceiving DataRegistro,'
      #9'PP.DocumentDate DataFatura,'
      #9'CFOP.Description CFOP,'
      #9'V.CGC CNPJ,'
      #9'V.InscEstadual InscEstadual,'
      #9'CAST('#39'01'#39' as varchar(2)) as GrupoFornecido,'
      #9'V.IDEstado UF,'
      #9'V.Pessoa Fornecedor,'
      #9'M.Description Produto,'
      #9'CAST('#39#39' as varchar(20)) as CF'
      'FROM'
      #9'Pur_PurchaseItem PI (NOLOCK)'
      
        #9'JOIN Pur_Purchase PP (NOLOCK) ON (PI.IDPurchase = PP.IDPurchase' +
        ')'
      #9'JOIN Pessoa V (NOLOCK) ON (PI.IDFornecedor = V.IDPessoa)'
      #9'JOIN Model M (NOLOCK) ON (PI.IDModel = M.IDModel)'
      
        #9'JOIN InventoryMov IM (NOLOCK) ON (PP.IDPurchase = IM.DocumentID' +
        ')'
      #9'LEFT JOIN Mnt_CFOP CFOP (NOLOCK) ON (PP.IDCFOP = CFOP.IDCFOP)'
      
        #9'LEFT OUTER JOIN InventoryMovTax IMT (NOLOCK) ON (IM.IDInventory' +
        'Mov = IMT.IDInventoryMov)'
      'WHERE'
      #9'PP.DatePreReceiving >= :FirstDate'
      #9'AND PP.DatePreReceiving < :LastDate'
      'GROUP BY'
      #9'V.UserCode,'
      #9'M.Model,'
      #9'PI.Qty,'
      #9'(IsNull(PI.CostPrice, 0) * IsNull(PI.Qty, 0)),'
      #9'IsNull(PI.CaseQty, 0),'
      #9'IsNull(IMT.TaxValue, 0),'
      #9'IMT.Tax,'
      #9'IsNull(PI.FreightCost, 0),'
      #9'IsNull(PI.OtherCost, 0),'
      #9'IsNull(PI.NewCostPrice, 0),'
      #9'PP.DocumentNumber,'
      #9'PP.DatePreReceiving,'
      #9'PP.DocumentDate,'
      #9'CFOP.Description,'
      #9'V.CGC,'
      #9'V.InscEstadual,'
      #9'V.IDEstado,'
      #9'V.Pessoa,'
      #9'M.Description')
    Left = 152
    Top = 16
    object quPurchaseCodFornecedor: TStringField
      FieldName = 'CodFornecedor'
      Size = 5
    end
    object quPurchaseCodProduto: TStringField
      FieldName = 'CodProduto'
      Size = 30
    end
    object quPurchaseQtd: TFloatField
      FieldName = 'Qtd'
    end
    object quPurchaseValorTotal: TFloatField
      FieldName = 'ValorTotal'
      ReadOnly = True
    end
    object quPurchaseValorImposto: TBCDField
      FieldName = 'ValorImposto'
      ReadOnly = True
      Precision = 19
    end
    object quPurchasePercImposto: TBCDField
      FieldName = 'PercImposto'
      Precision = 19
    end
    object quPurchaseFrete: TBCDField
      FieldName = 'Frete'
      ReadOnly = True
      Precision = 19
    end
    object quPurchaseOutrosCustos: TBCDField
      FieldName = 'OutrosCustos'
      ReadOnly = True
      Precision = 19
    end
    object quPurchaseNovoCusto: TBCDField
      FieldName = 'NovoCusto'
      ReadOnly = True
      Precision = 19
    end
    object quPurchaseTipo: TStringField
      FieldName = 'Tipo'
      ReadOnly = True
      Size = 2
    end
    object quPurchaseNotaFiscal: TStringField
      FieldName = 'NotaFiscal'
    end
    object quPurchaseDataRegistro: TDateTimeField
      FieldName = 'DataRegistro'
    end
    object quPurchaseDataFatura: TDateTimeField
      FieldName = 'DataFatura'
    end
    object quPurchaseCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 30
    end
    object quPurchaseInscEstadual: TStringField
      FieldName = 'InscEstadual'
      Size = 30
    end
    object quPurchaseUF: TStringField
      FieldName = 'UF'
      FixedChar = True
      Size = 3
    end
    object quPurchaseFornecedor: TStringField
      FieldName = 'Fornecedor'
      Size = 50
    end
    object quPurchaseProduto: TStringField
      FieldName = 'Produto'
      Size = 50
    end
    object quPurchaseCFOP: TStringField
      FieldName = 'CFOP'
      Size = 30
    end
    object quPurchaseGrupoFornecido: TStringField
      FieldName = 'GrupoFornecido'
      ReadOnly = True
      Size = 2
    end
    object quPurchaseCF: TStringField
      FieldName = 'CF'
      ReadOnly = True
    end
  end
  object qryEmpresa: TADOQuery
    Connection = ADOConn
    AfterOpen = qryEmpresaAfterOpen
    Parameters = <
      item
        Name = 'IDEmpresa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'E.IDEmpresa,'
      #9'E.RazaoSocial,'
      #9'E.CGC,'
      #9'E.InscricaoEstadual,'
      #9'E.InscricaoMunicipal,'
      #9'E.Endereco,'
      #9'E.Numero,'
      #9'E.Coplemento,'
      #9'E.Bairro,'
      #9'E.CEP,'
      #9'E.Cidade,'
      #9'E.IDEstado,'
      #9'E.Contato,'
      #9'E.Telefone,'
      #9'E.Fax'
      'FROM'
      #9'Sis_Empresa E'
      'WHERE'
      #9'E.IDEmpresa = :IDEmpresa')
    Left = 84
    Top = 16
    object qryEmpresaIDEmpresa: TIntegerField
      FieldName = 'IDEmpresa'
    end
    object qryEmpresaRazaoSocial: TStringField
      FieldName = 'RazaoSocial'
      Size = 100
    end
    object qryEmpresaCGC: TStringField
      FieldName = 'CGC'
    end
    object qryEmpresaInscricaoEstadual: TStringField
      FieldName = 'InscricaoEstadual'
    end
    object qryEmpresaInscricaoMunicipal: TStringField
      FieldName = 'InscricaoMunicipal'
    end
    object qryEmpresaEndereco: TStringField
      FieldName = 'Endereco'
      Size = 50
    end
    object qryEmpresaNumero: TIntegerField
      FieldName = 'Numero'
    end
    object qryEmpresaCoplemento: TStringField
      FieldName = 'Coplemento'
    end
    object qryEmpresaBairro: TStringField
      FieldName = 'Bairro'
    end
    object qryEmpresaCEP: TStringField
      FieldName = 'CEP'
      Size = 10
    end
    object qryEmpresaCidade: TStringField
      FieldName = 'Cidade'
      Size = 30
    end
    object qryEmpresaIDEstado: TStringField
      FieldName = 'IDEstado'
      FixedChar = True
      Size = 3
    end
    object qryEmpresaContato: TStringField
      FieldName = 'Contato'
      Size = 30
    end
    object qryEmpresaTelefone: TStringField
      FieldName = 'Telefone'
      Size = 40
    end
    object qryEmpresaFax: TStringField
      FieldName = 'Fax'
      Size = 40
    end
  end
  object Virtual_Produtos: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CodigoProduto'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Descricao'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'Aliquota'
        DataType = ftFloat
      end
      item
        Name = 'CF'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'UNIDADE'
        DataType = ftString
        Size = 2
      end>
    IndexDefs = <
      item
        Name = 'Virtual_ProdutosCODIGO'
        Fields = 'CodigoProduto'
      end>
    IndexName = 'Virtual_ProdutosCODIGO'
    Params = <>
    StoreDefs = True
    Left = 360
    Top = 16
    Data = {
      9E0000009619E0BD0100000018000000050000000000030000009E000D436F64
      69676F50726F6475746F01004900000001000557494454480200020014000944
      657363726963616F0100490000000100055749445448020002003C0008416C69
      71756F7461080004000000000002434601004900000001000557494454480200
      0200030007554E49444144450100490000000100055749445448020002000200
      0000}
    object Virtual_ProdutosCodigoProduto: TStringField
      FieldName = 'CodigoProduto'
    end
    object Virtual_ProdutosDescricao: TStringField
      FieldName = 'Descricao'
      Size = 60
    end
    object Virtual_ProdutosAliquota: TFloatField
      FieldName = 'Aliquota'
    end
    object Virtual_ProdutosCF: TStringField
      FieldName = 'CF'
      Size = 3
    end
    object Virtual_ProdutosUNIDADE: TStringField
      FieldName = 'UNIDADE'
      Size = 2
    end
  end
  object cdsSintegra: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Tipo'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'CNPJ'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'IEst'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'DataReg'
        DataType = ftDate
      end
      item
        Name = 'UF'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'RF'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'Serie'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'Doc'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'CFOP'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'P_T'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Contabil'
        DataType = ftFloat
      end
      item
        Name = 'Base'
        DataType = ftFloat
      end
      item
        Name = 'Imposto'
        DataType = ftFloat
      end
      item
        Name = 'Isento'
        DataType = ftFloat
      end
      item
        Name = 'Outras'
        DataType = ftFloat
      end
      item
        Name = 'Aliq'
        DataType = ftFloat
      end
      item
        Name = 'S_N'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'codfornecedor'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'CF'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'UNIDADE'
        DataType = ftString
        Size = 2
      end>
    IndexDefs = <
      item
        Name = 'cdsSintegraIndex1'
        Fields = 'tipo;cnpj;datareg;doc'
      end>
    IndexName = 'cdsSintegraIndex1'
    Params = <>
    StoreDefs = True
    Left = 360
    Top = 64
    Data = {
      CC0100009619E0BD010000001800000014000000000003000000CC0104546970
      6F010049000000010005574944544802000200020004434E504A010049000000
      0100055749445448020002000E00044945737401004900000001000557494454
      48020002000E0007446174615265670400060000000000025546010049000000
      0100055749445448020002000200025246010049000000010005574944544802
      0002000200055365726965010049000000010005574944544802000200030003
      446F6301004900000001000557494454480200020006000443464F5001004900
      0000010005574944544802000200040003505F54010049000000010005574944
      544802000200010008436F6E746162696C080004000000000004426173650800
      04000000000007496D706F73746F0800040000000000064973656E746F080004
      0000000000064F7574726173080004000000000004416C697108000400000000
      0003535F4E01004900000001000557494454480200020001000D636F64666F72
      6E656365646F7201004900000001000557494454480200020006000243460100
      49000000010005574944544802000200030007554E4944414445010049000000
      01000557494454480200020002000000}
    object cdsSintegraTipo: TStringField
      FieldName = 'Tipo'
      Size = 2
    end
    object cdsSintegraCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 14
    end
    object cdsSintegraIEst: TStringField
      FieldName = 'IEst'
      Size = 14
    end
    object cdsSintegraDataReg: TDateField
      FieldName = 'DataReg'
    end
    object cdsSintegraUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object cdsSintegraRF: TStringField
      FieldName = 'RF'
      Size = 2
    end
    object cdsSintegraSerie: TStringField
      FieldName = 'Serie'
      Size = 3
    end
    object cdsSintegraDoc: TStringField
      FieldName = 'Doc'
      Size = 6
    end
    object cdsSintegraCFOP: TStringField
      FieldName = 'CFOP'
      Size = 4
    end
    object cdsSintegraP_T: TStringField
      FieldName = 'P_T'
      Size = 1
    end
    object cdsSintegraContabil: TFloatField
      FieldName = 'Contabil'
      DisplayFormat = '###,##0.00'
    end
    object cdsSintegraBase: TFloatField
      FieldName = 'Base'
      DisplayFormat = '###,##0.00'
    end
    object cdsSintegraImposto: TFloatField
      FieldName = 'Imposto'
      DisplayFormat = '###,##0.00'
    end
    object cdsSintegraIsento: TFloatField
      FieldName = 'Isento'
      DisplayFormat = '###,##0.00'
    end
    object cdsSintegraOutras: TFloatField
      FieldName = 'Outras'
      DisplayFormat = '###,##0.00'
    end
    object cdsSintegraAliq: TFloatField
      FieldName = 'Aliq'
    end
    object cdsSintegraS_N: TStringField
      FieldName = 'S_N'
      Size = 1
    end
    object cdsSintegracodfornecedor: TStringField
      FieldName = 'codfornecedor'
      Size = 6
    end
    object cdsSintegraCF: TStringField
      FieldName = 'CF'
      Size = 3
    end
    object cdsSintegraUNIDADE: TStringField
      FieldName = 'UNIDADE'
      Size = 2
    end
  end
  object Virtual_CFOP: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CFOP'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'VALORCONTABIL'
        DataType = ftFloat
      end
      item
        Name = 'BASECALCULO'
        DataType = ftFloat
      end
      item
        Name = 'VALORICMS'
        DataType = ftFloat
      end
      item
        Name = 'VALORISENTAS'
        DataType = ftFloat
      end
      item
        Name = 'VALOROUTRAS'
        DataType = ftFloat
      end>
    IndexDefs = <
      item
        Name = 'ixCFOP1'
        Fields = 'CFOP'
      end>
    IndexName = 'ixCFOP1'
    Params = <>
    StoreDefs = True
    Left = 360
    Top = 112
    Data = {
      980000009619E0BD01000000180000000600000000000300000098000443464F
      5001004900000001000557494454480200020004000D56414C4F52434F4E5441
      42494C08000400000000000B4241534543414C43554C4F080004000000000009
      56414C4F5249434D5308000400000000000C56414C4F524953454E5441530800
      0400000000000B56414C4F524F555452415308000400000000000000}
    object Virtual_CFOPCFOP: TStringField
      FieldName = 'CFOP'
      Size = 4
    end
    object Virtual_CFOPVALORCONTABIL: TFloatField
      FieldName = 'VALORCONTABIL'
    end
    object Virtual_CFOPBASECALCULO: TFloatField
      FieldName = 'BASECALCULO'
    end
    object Virtual_CFOPVALORICMS: TFloatField
      FieldName = 'VALORICMS'
    end
    object Virtual_CFOPVALORISENTAS: TFloatField
      FieldName = 'VALORISENTAS'
    end
    object Virtual_CFOPVALOROUTRAS: TFloatField
      FieldName = 'VALOROUTRAS'
    end
  end
  object Virtual_UF: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'UF'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'VALORCONTABIL'
        DataType = ftFloat
      end
      item
        Name = 'BASECALCULO'
        DataType = ftFloat
      end
      item
        Name = 'VALORICMS'
        DataType = ftFloat
      end
      item
        Name = 'VALORISENTAS'
        DataType = ftFloat
      end
      item
        Name = 'VALOROUTRAS'
        DataType = ftFloat
      end>
    IndexDefs = <
      item
        Name = 'ixUF1'
        Fields = 'UF'
      end>
    IndexName = 'ixUF1'
    Params = <>
    StoreDefs = True
    Left = 456
    Top = 64
    Data = {
      960000009619E0BD010000001800000006000000000003000000960002554601
      004900000001000557494454480200020002000D56414C4F52434F4E54414249
      4C08000400000000000B4241534543414C43554C4F0800040000000000095641
      4C4F5249434D5308000400000000000C56414C4F524953454E54415308000400
      000000000B56414C4F524F555452415308000400000000000000}
    object Virtual_UFUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object Virtual_UFVALORCONTABIL: TFloatField
      FieldName = 'VALORCONTABIL'
    end
    object Virtual_UFBASECALCULO: TFloatField
      FieldName = 'BASECALCULO'
    end
    object Virtual_UFVALORICMS: TFloatField
      FieldName = 'VALORICMS'
    end
    object Virtual_UFVALORISENTAS: TFloatField
      FieldName = 'VALORISENTAS'
    end
    object Virtual_UFVALOROUTRAS: TFloatField
      FieldName = 'VALOROUTRAS'
    end
  end
  object cdsProdutoCompra: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'nf'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'codfornecedor'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'codproduto'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'cfop'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'ksfi'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'nritem'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'quantidade'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'valortotal'
        DataType = ftString
        Size = 12
      end
      item
        Name = 'aliq'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'cnpj'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'Unidade'
        DataType = ftString
        Size = 2
      end>
    IndexDefs = <
      item
        Name = 'ixNF'
        Fields = 'NF;CODFORNECEDOR'
      end>
    IndexName = 'ixNF'
    Params = <>
    StoreDefs = True
    Left = 456
    Top = 16
    Data = {
      690100009619E0BD01000000180000000C0000000000030000006901026E6601
      004900000001000557494454480200020006000D636F64666F726E656365646F
      7201004900000001000557494454480200020005000A636F6470726F6475746F
      0100490000000100055749445448020002000E000463666F7001004900000001
      00055749445448020002000400046B7366690100490000000100055749445448
      020002000300066E726974656D01004900000001000557494454480200020003
      000A7175616E7469646164650100490000000100055749445448020002000B00
      0A76616C6F72746F74616C0100490000000100055749445448020002000C0004
      616C6971010049000000010005574944544802000200040004636E706A010049
      0000000100055749445448020002000E000964657363726963616F0100490000
      000100055749445448020002003C0007556E6964616465010049000000010005
      57494454480200020002000000}
    object cdsProdutoCompranf: TStringField
      FieldName = 'nf'
      Size = 6
    end
    object cdsProdutoCompracodfornecedor: TStringField
      FieldName = 'codfornecedor'
      Size = 5
    end
    object cdsProdutoCompracodproduto: TStringField
      FieldName = 'codproduto'
      Size = 14
    end
    object cdsProdutoCompracfop: TStringField
      FieldName = 'cfop'
      Size = 4
    end
    object cdsProdutoCompraksfi: TStringField
      FieldName = 'ksfi'
      Size = 3
    end
    object cdsProdutoCompranritem: TStringField
      FieldName = 'nritem'
      Size = 3
    end
    object cdsProdutoCompraquantidade: TStringField
      FieldName = 'quantidade'
      Size = 11
    end
    object cdsProdutoCompravalortotal: TStringField
      FieldName = 'valortotal'
      Size = 12
    end
    object cdsProdutoCompraaliq: TStringField
      FieldName = 'aliq'
      Size = 4
    end
    object cdsProdutoCompracnpj: TStringField
      FieldName = 'cnpj'
      Size = 14
    end
    object cdsProdutoCompradescricao: TStringField
      FieldName = 'descricao'
      Size = 60
    end
    object cdsProdutoCompraUnidade: TStringField
      FieldName = 'Unidade'
      Size = 2
    end
  end
  object qryLuEmpresa: TADOQuery
    Connection = ADOConn
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'E.IDEmpresa,'
      #9'E.Empresa Empresa'
      'FROM'
      #9'Sis_Empresa E')
    Left = 296
    Top = 208
    object qryLuEmpresaIDEmpresa: TIntegerField
      FieldName = 'IDEmpresa'
    end
    object qryLuEmpresaEmpresa: TStringField
      FieldName = 'Empresa'
      Size = 35
    end
  end
  object dsLuEmpresa: TDataSource
    DataSet = qryLuEmpresa
    Left = 296
    Top = 264
  end
end
