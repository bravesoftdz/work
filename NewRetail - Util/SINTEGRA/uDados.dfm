object Dados: TDados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 104
  Top = 13
  Height = 526
  Width = 660
  object Registro75: TClientDataSet
    Aggregates = <>
    FileName = 'Registro75.xml'
    Params = <>
    Left = 272
    Top = 432
    object Registro75DtValidadeIni: TDateField
      DisplayLabel = 'Validade Inicial'
      FieldName = 'DtValidadeIni'
      EditMask = '!99/99/0000;1;_'
    end
    object Registro75DtValidadeFim: TDateField
      DisplayLabel = 'Validade Final'
      FieldName = 'DtValidadeFim'
      EditMask = '!99/99/0000;1;_'
    end
    object Registro75CodProduto: TStringField
      DisplayLabel = 'C'#243'd.Produto'
      FieldName = 'CodProduto'
      Size = 14
    end
    object Registro75CodNCM: TStringField
      DisplayLabel = 'C'#243'd.NCM'
      FieldName = 'CodNCM'
      Size = 8
    end
    object Registro75Descricao: TStringField
      DisplayLabel = 'Descri'#231#227'o do Produto'
      FieldName = 'Descricao'
      Size = 35
    end
    object Registro75Unidade: TStringField
      DisplayLabel = 'Unid.'
      FieldName = 'Unidade'
      Size = 4
    end
    object Registro75AliquotaIPI: TCurrencyField
      DisplayLabel = 'Aliquota de IPI'
      FieldName = 'AliquotaIPI'
      DisplayFormat = ',#0.00%'
      EditFormat = ',#0.00%'
    end
    object Registro75AliquotaICMS: TCurrencyField
      DisplayLabel = 'Aliquota de ICMS'
      FieldName = 'AliquotaICMS'
      DisplayFormat = ',#0.00%'
      EditFormat = ',#0.00%'
    end
    object Registro75ReducaoBaseCalc: TCurrencyField
      DisplayLabel = 'Redu'#231#227'o Base Calc.'
      FieldName = 'ReducaoBaseCalc'
      DisplayFormat = ',#0.00%'
      EditFormat = ',#0.00%'
    end
    object Registro75BaseICMSST: TCurrencyField
      DisplayLabel = 'Base ICMSST'
      FieldName = 'BaseICMSST'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
  end
  object Registro60R: TClientDataSet
    Aggregates = <>
    FileName = 'Registro60R.xml'
    Params = <>
    OnNewRecord = Registro60RNewRecord
    Left = 32
    Top = 432
    object Registro60RMes: TIntegerField
      DisplayLabel = 'M'#234's'
      FieldName = 'Mes'
    end
    object Registro60RAno: TIntegerField
      FieldName = 'Ano'
    end
    object Registro60RCodProduto: TStringField
      DisplayLabel = 'C'#243'd.Produto'
      FieldName = 'CodProduto'
      Size = 14
    end
    object Registro60RDescProduto: TStringField
      DisplayLabel = 'Descri'#231#227'o Produto'
      FieldKind = fkLookup
      FieldName = 'DescProduto'
      LookupDataSet = Registro75
      LookupKeyFields = 'CodProduto'
      LookupResultField = 'Descricao'
      KeyFields = 'CodProduto'
      Size = 35
      Lookup = True
    end
    object Registro60RQuantidade: TFloatField
      FieldName = 'Quantidade'
      DisplayFormat = ',#0.000'
      EditFormat = ',#0.000'
    end
    object Registro60RValorAcumulado: TCurrencyField
      DisplayLabel = 'Valor Acumulado'
      FieldName = 'ValorAcumulado'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro60RValorAcumuladoICMS: TCurrencyField
      DisplayLabel = 'Valor Acum. ICMS'
      FieldName = 'ValorAcumuladoICMS'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro60RSitTributaria: TStringField
      DisplayLabel = 'Sit.Tribut'#225'ria'
      FieldName = 'SitTributaria'
      Size = 4
    end
  end
  object Empresa: TClientDataSet
    Aggregates = <>
    FileName = 'Empresa.xml'
    Params = <>
    OnNewRecord = EmpresaNewRecord
    Left = 352
    Top = 16
    object EmpresaRazaoSocial: TStringField
      FieldName = 'RazaoSocial'
      Size = 35
    end
    object EmpresaCNPJ: TStringField
      FieldName = 'CNPJ'
      EditMask = '99.999.999/9999-99;0;_'
      Size = 14
    end
    object EmpresaInscEstadual: TStringField
      FieldName = 'InscEstadual'
      Size = 14
    end
    object EmpresaEndereco: TStringField
      FieldName = 'Endereco'
      Size = 34
    end
    object EmpresaComplemento: TStringField
      FieldName = 'Complemento'
      Size = 22
    end
    object EmpresaNumero: TIntegerField
      FieldName = 'Numero'
    end
    object EmpresaBairro: TStringField
      FieldName = 'Bairro'
      Size = 15
    end
    object EmpresaMunicipio: TStringField
      FieldName = 'Municipio'
      Size = 30
    end
    object EmpresaCEP: TStringField
      FieldName = 'CEP'
      EditMask = '99.999-999;0;_'
      Size = 8
    end
    object EmpresaUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object EmpresaFax: TStringField
      FieldName = 'Fax'
      EditMask = '(99)9999.9999;0;_'
      Size = 10
    end
    object EmpresaFone: TStringField
      FieldName = 'Fone'
      EditMask = '(99)9999.9999;0;_'
      Size = 10
    end
    object EmpresaResponsavel: TStringField
      FieldName = 'Responsavel'
      Size = 28
    end
    object EmpresaSubstitutoTributario: TBooleanField
      FieldName = 'SubstitutoTributario'
    end
    object EmpresaContribuinteIPI: TBooleanField
      FieldName = 'ContribuinteIPI'
    end
  end
  object Registro60M: TClientDataSet
    Aggregates = <>
    FileName = 'Registro60M.xml'
    FieldDefs = <
      item
        Name = 'NumSerieEquipamento'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DataEmissao'
        DataType = ftDate
      end
      item
        Name = 'NumeroECF'
        DataType = ftInteger
      end
      item
        Name = 'COOInicial'
        DataType = ftInteger
      end
      item
        Name = 'COOFinal'
        DataType = ftInteger
      end
      item
        Name = 'ContReducaoZ'
        DataType = ftInteger
      end
      item
        Name = 'VendaBruta'
        DataType = ftCurrency
      end
      item
        Name = 'GTFinal'
        DataType = ftCurrency
      end
      item
        Name = 'ContReinicioOper'
        DataType = ftInteger
      end
      item
        Name = 'ModeloDoc'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 32
    Top = 304
    object Registro60MNumSerieEquipamento: TStringField
      DisplayLabel = 'N'#250'mero S'#233'rie Equipamento'
      FieldName = 'NumSerieEquipamento'
      Required = True
    end
    object Registro60MDataEmissao: TDateField
      DisplayLabel = 'Emiss'#227'o'
      FieldName = 'DataEmissao'
      Required = True
      EditMask = '!99/99/0000;1;_'
    end
    object Registro60MNumeroECF: TIntegerField
      DisplayLabel = 'N'#250'mero Caixa'
      FieldName = 'NumeroECF'
    end
    object Registro60MModeloDoc: TIntegerField
      DisplayLabel = 'Modelo'
      FieldName = 'ModeloDoc'
      LookupDataSet = ModeloDoc
      LookupKeyFields = 'Codigo'
      LookupResultField = 'Descricao'
      KeyFields = 'ModeloDoc'
      Visible = False
    end
    object Registro60MDescModeloDoc: TStringField
      DisplayLabel = 'Modelo Documento'
      FieldKind = fkLookup
      FieldName = 'DescModeloDoc'
      LookupDataSet = ModeloDoc
      LookupKeyFields = 'Codigo'
      LookupResultField = 'Descricao'
      KeyFields = 'ModeloDoc'
      Lookup = True
    end
    object Registro60MCOOInicial: TIntegerField
      DisplayLabel = 'COO Inicial'
      FieldName = 'COOInicial'
    end
    object Registro60MCOOFinal: TIntegerField
      DisplayLabel = 'COO Final'
      FieldName = 'COOFinal'
    end
    object Registro60MContReducaoZ: TIntegerField
      DisplayLabel = 'Contador de Redu'#231#227'o Z'
      FieldName = 'ContReducaoZ'
    end
    object Registro60MContReinicioOper: TIntegerField
      DisplayLabel = 'cont.Reinicio Opera'#231#227'o'
      FieldName = 'ContReinicioOper'
    end
    object Registro60MVendaBruta: TCurrencyField
      DisplayLabel = 'Venda Bruta'
      FieldName = 'VendaBruta'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro60MGTFinal: TCurrencyField
      DisplayLabel = 'Grande Total Final'
      FieldName = 'GTFinal'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
  end
  object Registro60A: TClientDataSet
    Aggregates = <>
    FileName = 'Registro60A.xml'
    FieldDefs = <
      item
        Name = 'NumSerieEquipamento'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'SitTributaria'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'ValorAcumulado'
        DataType = ftCurrency
      end>
    IndexDefs = <
      item
        Name = 'SitTributariaIndex1'
      end>
    IndexFieldNames = 'NumSerieEquipamento'
    MasterFields = 'NumSerieEquipamento'
    MasterSource = dsRegistro60M
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    OnNewRecord = Registro60ANewRecord
    Left = 32
    Top = 360
    object Registro60ANumSerieEquipamento: TStringField
      FieldName = 'NumSerieEquipamento'
      Visible = False
    end
    object Registro60ASitTributaria: TStringField
      DisplayLabel = 'Situa'#231#227'o Tribut'#225'ria'
      FieldName = 'SitTributaria'
      Size = 4
    end
    object Registro60AValorAcumulado: TCurrencyField
      DisplayLabel = 'Valor Acumulado'
      FieldName = 'ValorAcumulado'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
  end
  object Registro60I: TClientDataSet
    Aggregates = <>
    FileName = 'Registro60I.xml'
    IndexFieldNames = 'NumSerieEquipamento'
    MasterFields = 'NumSerieEquipamento'
    MasterSource = dsRegistro60M
    PacketRecords = 0
    Params = <>
    OnNewRecord = Registro60INewRecord
    Left = 120
    Top = 360
    object Registro60INumSerieEquipamento: TStringField
      FieldName = 'NumSerieEquipamento'
      Visible = False
    end
    object Registro60ICOOCupom: TIntegerField
      DisplayLabel = 'COO Cupom'
      FieldName = 'COOCupom'
    end
    object Registro60INumItem: TIntegerField
      DisplayLabel = 'N'#250'm.Item'
      FieldName = 'NumItem'
    end
    object Registro60ICodProduto: TStringField
      DisplayLabel = 'C'#243'd.Produto'
      FieldName = 'CodProduto'
      Size = 14
    end
    object Registro60IDescProduto: TStringField
      DisplayLabel = 'Descri'#231#227'o do Produto'
      FieldKind = fkLookup
      FieldName = 'DescProduto'
      LookupDataSet = Registro75
      LookupKeyFields = 'CodProduto'
      LookupResultField = 'Descricao'
      KeyFields = 'CodProduto'
      Size = 35
      Lookup = True
    end
    object Registro60IQuantidade: TFloatField
      FieldName = 'Quantidade'
      DisplayFormat = ',#0.000'
      EditFormat = ',#0.000'
    end
    object Registro60IValorunitario: TCurrencyField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'Valorunitario'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro60IBaseICMS: TCurrencyField
      DisplayLabel = 'Base do ICMS'
      FieldName = 'BaseICMS'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro60ISitTributaria: TStringField
      DisplayLabel = 'Sit.Tribut'#225'ria'
      FieldName = 'SitTributaria'
      Size = 4
    end
  end
  object Registro60D: TClientDataSet
    Aggregates = <>
    FileName = 'Registro60D.xml'
    FieldDefs = <
      item
        Name = 'NumSerieEquipamento'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'SitTributaria'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'QuantAcumulada'
        DataType = ftFloat
      end
      item
        Name = 'ValorAcumulado'
        DataType = ftCurrency
      end
      item
        Name = 'BaseICMSAcumulada'
        DataType = ftCurrency
      end
      item
        Name = 'CodProduto'
        DataType = ftString
        Size = 14
      end>
    IndexDefs = <>
    IndexFieldNames = 'NumSerieEquipamento'
    MasterFields = 'NumSerieEquipamento'
    MasterSource = dsRegistro60M
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    Left = 208
    Top = 360
    object Registro60DNumSerieEquipamento: TStringField
      FieldName = 'NumSerieEquipamento'
      Visible = False
    end
    object Registro60DSitTributaria: TStringField
      DisplayLabel = 'Sit.Tribut'#225'ria'
      FieldName = 'SitTributaria'
      Size = 4
    end
    object Registro60DQuantAcumulada: TFloatField
      DisplayLabel = 'Quantidade Acumulada'
      FieldName = 'QuantAcumulada'
      DisplayFormat = ',#0.000'
      EditFormat = ',#0.000'
    end
    object Registro60DValorAcumulado: TCurrencyField
      DisplayLabel = 'Valor Acumulado'
      FieldName = 'ValorAcumulado'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro60DBaseICMSAcumulada: TCurrencyField
      DisplayLabel = 'Base ICMS'
      FieldName = 'BaseICMSAcumulada'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro60DCodProduto: TStringField
      FieldName = 'CodProduto'
      Size = 14
    end
    object Registro60DDescProduto: TStringField
      FieldKind = fkLookup
      FieldName = 'DescProduto'
      LookupDataSet = Registro75
      LookupKeyFields = 'CodProduto'
      LookupResultField = 'Descricao'
      KeyFields = 'CodProduto'
      Size = 35
      Lookup = True
    end
  end
  object dsRegistro60M: TDataSource
    DataSet = Registro60M
    Left = 40
    Top = 312
  end
  object dsRegistro60A: TDataSource
    DataSet = Registro60A
    Left = 40
    Top = 368
  end
  object dsRegistro60I: TDataSource
    DataSet = Registro60I
    Left = 128
    Top = 368
  end
  object dsRegistro60D: TDataSource
    DataSet = Registro60D
    Left = 216
    Top = 368
  end
  object ModeloDoc: TClientDataSet
    Aggregates = <>
    FileName = 'ModeloDoc.xml'
    Params = <>
    Left = 472
    Top = 16
    object ModeloDocCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object ModeloDocDescricao: TStringField
      FieldName = 'Descricao'
    end
  end
  object Registro61: TClientDataSet
    Aggregates = <>
    FileName = 'Registro61.xml'
    Params = <>
    Left = 104
    Top = 432
    object Registro61DataEmissao: TDateField
      DisplayLabel = 'Emiss'#227'o'
      FieldName = 'DataEmissao'
      EditMask = '!99/99/0000;1;_'
    end
    object Registro61ModeloDoc: TIntegerField
      DisplayLabel = 'Modelo'
      FieldName = 'ModeloDoc'
    end
    object Registro61TipoDocumento: TStringField
      DisplayLabel = 'Descri'#231#227'o Documento'
      FieldKind = fkLookup
      FieldName = 'TipoDocumento'
      LookupDataSet = TipoDocumento
      LookupKeyFields = 'Codigo'
      LookupResultField = 'Descricao'
      KeyFields = 'ModeloDoc'
      Size = 30
      Lookup = True
    end
    object Registro61Serie: TStringField
      FieldName = 'Serie'
      Size = 3
    end
    object Registro61SubSerie: TStringField
      FieldName = 'SubSerie'
      Size = 2
    end
    object Registro61NumeroIncial: TIntegerField
      DisplayLabel = 'N'#250'm.Inicial'
      FieldName = 'NumeroIncial'
    end
    object Registro61NumeroFinal: TIntegerField
      DisplayLabel = 'N'#250'm.Final'
      FieldName = 'NumeroFinal'
    end
    object Registro61ValorTotal: TCurrencyField
      DisplayLabel = 'Valor Total'
      FieldName = 'ValorTotal'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro61BaseICMS: TCurrencyField
      DisplayLabel = 'Base de ICMS'
      FieldName = 'BaseICMS'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro61IsentasNTributadas: TCurrencyField
      DisplayLabel = 'Isentas / N'#227'o Tributadas'
      FieldName = 'IsentasNTributadas'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro61Outras: TCurrencyField
      FieldName = 'Outras'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro61Aliquota: TCurrencyField
      DisplayLabel = 'Aliquota ICMS'
      FieldName = 'Aliquota'
      DisplayFormat = ',#0.00 %'
      EditFormat = ',#0.00 %'
    end
  end
  object Registro61R: TClientDataSet
    Aggregates = <>
    FileName = 'Registro61R.xml'
    Params = <>
    OnNewRecord = Registro61RNewRecord
    Left = 192
    Top = 432
    object Registro61RMes: TSmallintField
      DisplayLabel = 'M'#234's'
      FieldName = 'Mes'
      DisplayFormat = '00'
    end
    object Registro61RAno: TSmallintField
      FieldName = 'Ano'
    end
    object Registro61RCodProduto: TStringField
      DisplayLabel = 'C'#243'd.Produto'
      FieldName = 'CodProduto'
      Size = 14
    end
    object Registro61RDescProduto: TStringField
      DisplayLabel = 'Descri'#231#227'o do Produto'
      FieldKind = fkLookup
      FieldName = 'DescProduto'
      LookupDataSet = Registro75
      LookupKeyFields = 'CodProduto'
      LookupResultField = 'Descricao'
      KeyFields = 'CodProduto'
      Size = 35
      Lookup = True
    end
    object Registro61RQuantidade: TFloatField
      FieldName = 'Quantidade'
      DisplayFormat = ',#0.000'
      EditFormat = ',#0.000'
    end
    object Registro61RValorBruto: TCurrencyField
      DisplayLabel = 'Valor Bruto'
      FieldName = 'ValorBruto'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro61RBaseCalcICMS: TCurrencyField
      DisplayLabel = 'Base de Calc. ICMS'
      FieldName = 'BaseCalcICMS'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro61RAliquota: TCurrencyField
      FieldName = 'Aliquota'
      DisplayFormat = ',#0.00 %'
      EditFormat = ',#0.00 %'
    end
  end
  object TipoDocumento: TClientDataSet
    Aggregates = <>
    FileName = 'TipoDocumento.xml'
    Params = <>
    Left = 544
    Top = 16
    object TipoDocumentoCodigo: TIntegerField
      DisplayLabel = 'Modelo'
      FieldName = 'Codigo'
    end
    object TipoDocumentoDescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'Descricao'
      Size = 100
    end
  end
  object Registro50: TClientDataSet
    Aggregates = <>
    FileName = 'Registro50.xml'
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    OnNewRecord = Registro50NewRecord
    Left = 32
    Top = 128
    object Registro50NumLancamento: TIntegerField
      FieldName = 'NumLancamento'
      Required = True
    end
    object Registro50CNPJCPF: TStringField
      DisplayLabel = 'CNPJ/CPF'
      FieldName = 'CNPJCPF'
      Size = 14
    end
    object Registro50InscEstadual: TStringField
      DisplayLabel = 'Inscri'#231#227'o Estadual'
      FieldName = 'InscEstadual'
      Size = 14
    end
    object Registro50Data: TDateField
      DisplayLabel = 'Data Emiss'#227'o/Entrada'
      FieldName = 'Data'
      EditMask = '!99/99/0000;1;_'
    end
    object Registro50UF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object Registro50Modelo: TIntegerField
      DisplayLabel = 'Modelo NF'
      FieldName = 'Modelo'
    end
    object Registro50Serie: TStringField
      DisplayLabel = 'S'#233'rie'
      FieldName = 'Serie'
      Size = 3
    end
    object Registro50Numero: TIntegerField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'Numero'
    end
    object Registro50Emitente: TStringField
      FieldName = 'Emitente'
      Visible = False
      Size = 1
    end
    object Registro50DescTipoEmitente: TStringField
      DisplayLabel = 'Tipo Emitente'
      FieldKind = fkLookup
      FieldName = 'DescTipoEmitente'
      LookupDataSet = TipoEmitente
      LookupKeyFields = 'codigo'
      LookupResultField = 'Descricao'
      KeyFields = 'Emitente'
      Lookup = True
    end
    object Registro50Situacao: TStringField
      DisplayLabel = 'Situa'#231#227'o'
      FieldName = 'Situacao'
      Visible = False
      Size = 1
    end
    object Registro50DescSituacao: TStringField
      DisplayLabel = 'Situa'#231#227'o'
      FieldKind = fkLookup
      FieldName = 'DescSituacao'
      LookupDataSet = SitNotaFiscal
      LookupKeyFields = 'Codigo'
      LookupResultField = 'Descricao'
      KeyFields = 'Situacao'
      Lookup = True
    end
    object Registro50Frete: TCurrencyField
      FieldName = 'Frete'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro50Seguro: TCurrencyField
      FieldName = 'Seguro'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro50DespAcessorias: TCurrencyField
      DisplayLabel = 'Desp.Acess'#243'rias'
      FieldName = 'DespAcessorias'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
  end
  object SitNotaFiscal: TClientDataSet
    Aggregates = <>
    FileName = 'SitNotaFiscal.xml'
    Params = <>
    Left = 408
    Top = 16
    object SitNotaFiscalCodigo: TStringField
      FieldName = 'Codigo'
      Size = 1
    end
    object SitNotaFiscalDescricao: TStringField
      FieldName = 'Descricao'
    end
  end
  object TipoEmitente: TClientDataSet
    Aggregates = <>
    FileName = 'TipoEmitente.xml'
    Params = <>
    Left = 344
    Top = 16
    object TipoEmitentecodigo: TStringField
      FieldName = 'codigo'
      Size = 1
    end
    object TipoEmitenteDescricao: TStringField
      FieldName = 'Descricao'
      Size = 10
    end
  end
  object dsRegistro50: TDataSource
    DataSet = Registro50
    Left = 40
    Top = 136
  end
  object Registro50Aliq: TClientDataSet
    Aggregates = <>
    FileName = 'Registro50Aliq.xml'
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'NumLancamento'
    MasterFields = 'NumLancamento'
    MasterSource = dsRegistro50
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    OnNewRecord = Registro50AliqNewRecord
    Left = 32
    Top = 192
    object Registro50AliqNumLancamento: TIntegerField
      FieldName = 'NumLancamento'
      Visible = False
    end
    object Registro50AliqAliquota: TCurrencyField
      FieldName = 'Aliquota'
    end
    object Registro50AliqCFOP: TStringField
      FieldName = 'CFOP'
      Size = 4
    end
    object Registro50AliqValorTotal: TCurrencyField
      FieldName = 'ValorTotal'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro50AliqBaseICMS: TCurrencyField
      FieldName = 'BaseICMS'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro50AliqValorICMS: TCurrencyField
      FieldName = 'ValorICMS'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro50AliqIsenta_NTrib: TCurrencyField
      FieldName = 'Isenta_NTrib'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro50AliqOutras: TCurrencyField
      FieldName = 'Outras'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
  end
  object dsRegistro50Aliq: TDataSource
    DataSet = Registro50Aliq
    Left = 40
    Top = 200
  end
  object Registro50Itens: TClientDataSet
    Aggregates = <>
    FileName = 'Registro50Itens.xml'
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'NumLancamento'
    MasterFields = 'NumLancamento'
    MasterSource = dsRegistro50
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    OnNewRecord = Registro50ItensNewRecord
    Left = 120
    Top = 192
    object Registro50ItensNumLancamento: TIntegerField
      FieldName = 'NumLancamento'
      Visible = False
    end
    object Registro50ItensNumItem: TSmallintField
      DisplayLabel = 'Item'
      FieldName = 'NumItem'
    end
    object Registro50ItensCFOP: TStringField
      FieldName = 'CFOP'
      Size = 4
    end
    object Registro50ItensCST: TStringField
      FieldName = 'CST'
      Size = 3
    end
    object Registro50ItensCodProduto: TStringField
      DisplayLabel = 'C'#243'd.Produto'
      FieldName = 'CodProduto'
      Size = 14
    end
    object Registro50ItensDescProduto: TStringField
      DisplayLabel = 'Descri'#231#227'o do Produto'
      FieldKind = fkLookup
      FieldName = 'DescProduto'
      LookupDataSet = Registro75
      LookupKeyFields = 'CodProduto'
      LookupResultField = 'Descricao'
      KeyFields = 'CodProduto'
      Size = 40
      Lookup = True
    end
    object Registro50ItensQuantidade: TFloatField
      FieldName = 'Quantidade'
      DisplayFormat = ',#0.000'
      EditFormat = ',#0.000'
    end
    object Registro50ItensValorProduto: TCurrencyField
      DisplayLabel = 'Valor R$'
      FieldName = 'ValorProduto'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro50ItensAliquota: TCurrencyField
      DisplayLabel = 'Al'#237'quota'
      FieldName = 'Aliquota'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro50ItensDesconto: TCurrencyField
      FieldName = 'Desconto'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro50ItensBaseICMS: TCurrencyField
      DisplayLabel = 'Base ICMS'
      FieldName = 'BaseICMS'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro50ItensBaseICMSST: TCurrencyField
      DisplayLabel = 'Base ICMS ST'
      FieldName = 'BaseICMSST'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object Registro50ItensValorIPI: TCurrencyField
      DisplayLabel = 'Valor IPI'
      FieldName = 'ValorIPI'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
  end
  object dsRegistro50Itens: TDataSource
    DataSet = Registro50Itens
    Left = 128
    Top = 200
  end
  object Registro74: TClientDataSet
    Aggregates = <>
    FileName = 'Registro74.xml'
    Params = <>
    OnNewRecord = Registro74NewRecord
    Left = 232
    Top = 192
    object Registro74DataInventario: TDateField
      DisplayLabel = 'Data do Invent'#225'rio'
      FieldName = 'DataInventario'
      EditMask = '!99/99/0000;1;_'
    end
    object Registro74CodProduto: TStringField
      DisplayLabel = 'C'#243'd.Produto'
      FieldName = 'CodProduto'
    end
    object Registro74DescProduto: TStringField
      DisplayLabel = 'Descri'#231#227'o do Produto'
      FieldKind = fkLookup
      FieldName = 'DescProduto'
      LookupDataSet = Registro75
      LookupKeyFields = 'CodProduto'
      LookupResultField = 'Descricao'
      KeyFields = 'CodProduto'
      Size = 40
      Lookup = True
    end
    object Registro74Quantidade: TFloatField
      FieldName = 'Quantidade'
      DisplayFormat = ',#0.000'
      EditFormat = ',#0.000'
    end
    object Registro74ValorTotal: TCurrencyField
      DisplayLabel = 'Valor total'
      FieldName = 'ValorTotal'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
  end
  object Sintegra: TSintegra
    OnErro = SintegraErro
    NaturezaOperacao = opeInterestaduais
    Left = 48
    Top = 32
  end
end
