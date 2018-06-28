object dmSQL: TdmSQL
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 242
  Top = 173
  Height = 525
  Width = 656
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=mruser2000;Persist Security Info=Tr' +
      'ue;User ID=mruser;Initial Catalog=CeldomDB;Data Source=Desenv006' +
      ';Use Procedure for Prepare=1;Auto Translate=True;Packet Size=409' +
      '6;Workstation ID=RTSCOSTA;Use Encryption for Data=False;Tag with' +
      ' column collation when possible=False'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 35
    Top = 30
  end
  object dsInvoice: TADODataSet
    Connection = ADOConnection
    CursorType = ctStatic
    AfterOpen = dsInvoiceAfterOpen
    CommandText = 
      'SELECT'#13#10#9'--Nota'#13#10#9'I.InvoiceCode as I_InvoiceCode,'#13#10#9'I.InvoiceDat' +
      'e as I_InvoiceDate, '#13#10#9'(I.SubTotal - I.ItemDiscount - I.InvoiceD' +
      'iscount) as I_SubTotal,'#13#10#9'I.IDFormOfPayment as I_IDFormOfPayment' +
      ','#13#10#9'I.IDInvoice,'#13#10#9'I.AditionalExpenses as I_Frete,'#13#10#9'I.Note as I' +
      '_Notes,'#13#10#9'I.PrintNotes as I_PrintNotes,'#13#10#9'I.DeliverConfirmation ' +
      'as I_DeliverConfirmation, '#13#10#9'I.DeliverOBS as I_DeliverOBS, '#13#10#9'I.' +
      'DeliverAddress as I_DeliverAddress,'#13#10#9'IsNull(I.IDFormOfPayment,0' +
      ') as I_IndPayment,'#13#10#13#10#9'--Empresa'#13#10#9'E.CGC as E_CGC,'#13#10#9'E.Inscricao' +
      'Estadual as E_InscricaoEstadual,'#13#10#9'E.Empresa as E_Empresa,'#13#10#9'E.R' +
      'azaoSocial as E_RazaoSocial,'#13#10#9'E.Telefone as E_Telefone,'#13#10#9'E.End' +
      'ereco as E_Endereco,'#13#10#9'E.Coplemento as E_Coplemento,'#13#10#9'E.Numero ' +
      'as E_Numero,'#13#10#9'E.Bairro as E_Bairro,'#13#10#9'E.IDEstado as E_IDEstado,' +
      #13#10#9'E.CEP as E_CEP,'#13#10#9'E.NomeFantasia as E_NomeFantasia,'#13#10#9'UF.Codi' +
      'go as E_UFCodigo,'#13#10#9'MU.Codigo as E_MunicipioCode,'#13#10#9'MU.Descricao' +
      ' as E_Municipio,'#9#13#10#13#10#9'CFOP.Number as CFOP_Number,'#13#10#9'CFOP.Descrip' +
      'tion as CFOP_Description,'#13#10#9'--Cliente'#13#10#9'P.Juridico as P_Juridico' +
      ','#13#10#9'P.NomeJuridico as P_InscEstadual,'#13#10#9'(CASE P.Juridico WHEN 1 ' +
      'THEN P.InscEstadual ELSE P.CPF END) as P_CPF,'#13#10#9'P.CEP as P_CEP,'#13 +
      #10#9'P.Endereco as P_Endereco,'#13#10#9'P.Bairro as P_Bairro ,'#13#10#9'P.IDEstad' +
      'o as P_IDEstado,'#13#10#9'P.PhoneAreaCode as P_PhoneAreaCode,'#13#10#9'P.Telef' +
      'one as P_Telefone,'#13#10#9'P.NomeJuridico as P_NomeJuridico,'#13#10#9'P.Pesso' +
      'a as P_Pessoa,'#13#10#9'P.Complemento as P_Complemento,'#13#10#9'P.Complemento' +
      'Num as P_ComplementoNum,'#13#10#9'UFP.Codigo as P_UFCodigo,'#13#10#9'MUP.Codig' +
      'o as P_MunicipioCode,'#13#10#9'MUP.Descricao as P_Municipio,'#13#10#9'--Transp' +
      'ortadora'#13#10#9'IOB.FreightType T_TipoDeFrete,'#13#10#9'T.Endereco as T_Ende' +
      'reco,'#13#10#9'T.Pessoa as T_Pessoa,'#13#10#9'(CASE T.Juridico WHEN 1 THEN T.I' +
      'nscEstadual ELSE T.CPF END) as T_CPF,'#13#10#9'T.NomeJuridico as T_Insc' +
      'Estadual,'#13#10#9'T.IDEstado as T_IDEstado,'#13#10#9'MUT.Codigo as T_Municipi' +
      'oCode,'#13#10#9'MUT.Descricao as T_Municipio,'#13#10#9'--Empresa Comercial'#13#10#9'I' +
      'MP.Endereco as I_Endereco,'#13#10#9'IMP.IDEstado as I_IDEstado'#13#10'FROM'#13#10#9 +
      'Invoice I (NOLOCK)'#13#10#9'JOIN Store S (NOLOCK) ON (I.IDStore = S.IDS' +
      'tore)'#13#10#9'JOIN Pessoa P (NOLOCK) ON (P.IDPessoa = I.IDCustomer)'#13#10#9 +
      'LEFT JOIN InvoiceOBS IOB (NOLOCK) ON (I.IDPreSale = IOB.IDPresal' +
      'e)'#13#10#9'LEFT JOIN Mnt_CFOP CFOP (NOLOCK) ON (CFOP.IDCFOP = IOB.IDCF' +
      'OP)'#13#10#9'LEFT JOIN Estado UFP (NOLOCK) ON (P.IDEstado = UFP.IDEstad' +
      'o)'#13#10#9'LEFT JOIN Sis_Municipio MUP (NOLOCK) ON (MUP.IDMunicipio = ' +
      'P.IDMunicipio)'#13#10#9'LEFT JOIN Pessoa T (NOLOCK) ON (T.IDPessoa = IO' +
      'B.IDCarrier)'#13#10#9'LEFT JOIN Sis_Municipio MUT (NOLOCK) ON (MUT.IDMu' +
      'nicipio = T.IDMunicipio)'#13#10#9'LEFT JOIN Pessoa IMP (NOLOCK) ON (IMP' +
      '.IDPessoa = IOB.IDPessoaTax)'#13#10#9'LEFT JOIN Sis_Empresa E (NOLOCK) ' +
      'ON (E.IDEmpresa = IsNull(:IDEmpresa, S.IDEmpresa))'#13#10#9'LEFT JOIN E' +
      'stado UF (NOLOCK) ON (E.IDEstado = UF.IDEstado)'#13#10#9'LEFT JOIN Sis_' +
      'Municipio MU (NOLOCK) ON (MU.IDMunicipio = E.IDMunicipio)'#13#10'WHERE' +
      #13#10#9'I.IDInvoice = :IDInvoice'#13#10#9'AND'#13#10#9'I.CupomFiscal IS NULL'
    Parameters = <
      item
        Name = 'IDEmpresa'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDInvoice'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 230
    Top = 30
  end
  object dsInvoiceItem: TADODataSet
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = dsInvoiceItemCalcFields
    CommandText = 
      'SELECT'#13#10#9'IM.IDInventoryMov,'#13#10#9'M.Model as M_Model,'#13#10#9'M.Descriptio' +
      'n as M_Description,'#13#10#9'IM.QTY as IM_QTY,'#13#10#9'ROUND(CASE WHEN I.Adit' +
      'ionalExpenses = 0 THEN 0 ELSE (IsNull((I.AditionalExpenses / (Is' +
      'Null(I.SubTotal,0) - IsNull(I.ItemDiscount,0) - IsNull(I.Invoice' +
      'Discount,0))) * ((IM.SalePrice * IM.Qty)- IM.Discount), 0) ) END' +
      ' ,2) as IM_Frete,'#13#10#9'IM.SalePrice as IM_SalePrice,'#13#10#9'CAST((IM.Dis' +
      'count / IM.QTY) as money) as IM_Discount,'#13#10#9'U.Unidade as U_Unida' +
      'de,'#13#10#9'U.Sigla as U_Sigla,'#13#10#9'(CASE IsNull(TCE.SituacaoTributaria,' +
      ' 0) WHEN 0 THEN IsNull(TC.SituacaoTributaria, 1) ELSE TCE.Situac' +
      'aoTributaria END) as T_SituacaoTributaria,'#13#10#9'TC.Tax as TaxCatego' +
      'riaPer,'#13#10#9'E.TaxPerc as TaxEstadoPerc,'#13#10#9'E.TaxPerc2 as T_Aliquota' +
      'ST,'#13#10#9'TCE.Tax as TaxItemPer,'#13#10#9'E.IDEstado as EstadoCliente,'#13#10#9'S.' +
      'IDEstado as EstadoLoja,'#13#10#9'IsNull(TCE.SituacaoTributaria, 0) as S' +
      'itTribItem,'#13#10#9'IsNull(TC.SituacaoTributaria, 1) as SitTribCategor' +
      'ia,'#13#10#9'I.AditionalExpenses as TotalFrete,'#13#10#9'TG.SerialNumber as M_' +
      'SerialNumber,'#13#10#9'NCM.MVAInterno,'#13#10#9'NCM.MVAInterestadual,'#13#10#9'NCM.Co' +
      'digo as M_NCMCodigo'#13#10'FROM'#13#10#9'Invoice I (NOLOCK)'#13#10#9'JOIN InventoryM' +
      'ov IM (NOLOCK) ON (IM.DocumentID = I.IDInvoice and IM.InventMovT' +
      'ypeID = 1)'#13#10#9'JOIN Model M (NOLOCK) ON (IM.ModelID = M.IDModel)'#13#10 +
      #9'JOIN TabGroup TG (NOLOCK) ON ( M.GroupID = TG.IDGroup )'#13#10#9'JOIN ' +
      'Pessoa C (NOLOCK) ON (C.IDPessoa = I.IDCustomer)'#13#10#9'JOIN Store S ' +
      '(NOLOCK) ON (S.IDStore = I.IDStore)'#13#10#9'LEFT JOIN Estado E (NOLOCK' +
      ') ON (E.IDEstado = C.IDEstado)'#13#10#9'LEFT JOIN Unidade U (NOLOCK) ON' +
      ' (M.IDUnidade = U.IDUnidade)'#13#10#9'LEFT JOIN InvoiceOBS IOBS (NOLOCK' +
      ') ON (I.IDPreSale = IOBS.IDPresale)'#13#10#9'LEFT JOIN Mnt_CFOP CFOP (N' +
      'OLOCK) ON (CFOP.IDCFOP = IOBS.IDCFOP)'#13#10#13#10#9'LEFT JOIN StoreToTabGr' +
      'oup STG (NOLOCK) ON (STG.IDStore = I.IDStore AND STG.IDGroup = M' +
      '.GroupID)'#13#10#9'LEFT JOIN TaxCategory TC (NOLOCK) ON (TC.IDTaxCatego' +
      'ry = STG.IDSaleTax AND TC.OperationType = 1 AND TC.SaleTaxType =' +
      ' 2)'#13#10#13#10#9'LEFT JOIN Inv_ModelStateTax MST (NOLOCK) ON (MST.IDModel' +
      ' = M.IDModel AND MST.IDEstado = C.IDEstado)'#13#10#9'LEFT JOIN TaxCateg' +
      'ory TCE (NOLOCK) ON (TCE.IDTaxCategory = MST.IDTaxCategory AND T' +
      'CE.OperationType = 1 AND TCE.SaleTaxType = 2)'#13#10#13#10#9'LEFT JOIN Inv_' +
      'NCM NCM (NOLOCK) ON (NCM.IDNCM = M.IDNCM)'#13#10#13#10'WHERE'#13#10#9'I.IDInvoice' +
      ' = :IDInvoice'#13#10#13#10
    Parameters = <
      item
        Name = 'IDInvoice'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 230
    Top = 85
    object dsInvoiceItemIDInventoryMov: TIntegerField
      FieldName = 'IDInventoryMov'
    end
    object dsInvoiceItemM_Model: TStringField
      FieldName = 'M_Model'
      Size = 30
    end
    object dsInvoiceItemM_Description: TStringField
      FieldName = 'M_Description'
      Size = 50
    end
    object dsInvoiceItemIM_QTY: TBCDField
      FieldName = 'IM_QTY'
      DisplayFormat = '0.####'
      Precision = 32
    end
    object dsInvoiceItemIM_SalePrice: TBCDField
      FieldName = 'IM_SalePrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00##'
      Precision = 19
    end
    object dsInvoiceItemIM_Frete: TBCDField
      FieldName = 'IM_Frete'
      ReadOnly = True
      DisplayFormat = '#,##0.00##'
      Precision = 32
      Size = 6
    end
    object dsInvoiceItemIM_Discount: TBCDField
      FieldName = 'IM_Discount'
      ReadOnly = True
      DisplayFormat = '#,##0.00##'
      Precision = 19
    end
    object dsInvoiceItemU_Unidade: TStringField
      FieldName = 'U_Unidade'
      Size = 100
    end
    object dsInvoiceItemU_Sigla: TStringField
      FieldName = 'U_Sigla'
      FixedChar = True
      Size = 4
    end
    object dsInvoiceItemT_SituacaoTributaria: TIntegerField
      FieldName = 'T_SituacaoTributaria'
      ReadOnly = True
    end
    object dsInvoiceItemTaxCategoriaPer: TBCDField
      FieldName = 'TaxCategoriaPer'
      Precision = 19
    end
    object dsInvoiceItemTaxEstadoPerc: TBCDField
      FieldName = 'TaxEstadoPerc'
      Precision = 19
    end
    object dsInvoiceItemTaxItemPer: TBCDField
      FieldName = 'TaxItemPer'
      Precision = 19
    end
    object dsInvoiceItemEstadoCliente: TStringField
      FieldName = 'EstadoCliente'
      FixedChar = True
      Size = 3
    end
    object dsInvoiceItemEstadoLoja: TStringField
      FieldName = 'EstadoLoja'
      FixedChar = True
      Size = 3
    end
    object dsInvoiceItemMVAInterno: TBCDField
      FieldName = 'MVAInterno'
      Precision = 32
    end
    object dsInvoiceItemMVAInterestadual: TBCDField
      FieldName = 'MVAInterestadual'
      Precision = 32
    end
    object dsInvoiceItemSitTribItem: TIntegerField
      FieldName = 'SitTribItem'
      ReadOnly = True
    end
    object dsInvoiceItemSitTribCategoria: TIntegerField
      FieldName = 'SitTribCategoria'
      ReadOnly = True
    end
    object dsInvoiceItemCFOP_Number: TStringField
      FieldKind = fkCalculated
      FieldName = 'CFOP_Number'
      Calculated = True
    end
    object dsInvoiceItemT_Aliquota: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'T_Aliquota'
      Calculated = True
    end
    object dsInvoiceItemT_AliquotaST: TBCDField
      FieldName = 'T_AliquotaST'
      Precision = 19
    end
    object dsInvoiceItemTotalFrete: TBCDField
      FieldName = 'TotalFrete'
      DisplayFormat = '#,##0.00##'
      Precision = 19
    end
    object dsInvoiceItemM_SerialNumber: TBooleanField
      FieldName = 'M_SerialNumber'
    end
    object dsInvoiceItemM_NCMCodigo: TStringField
      FieldName = 'M_NCMCodigo'
    end
    object dsInvoiceItemMVAPercent: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'MVAPercent'
      Calculated = True
    end
    object dsInvoiceItemAliquotaDesc: TStringField
      FieldKind = fkCalculated
      FieldName = 'AliquotaDesc'
      Size = 100
      Calculated = True
    end
  end
  object adodsNotaFiscal: TADODataSet
    Connection = ADOConnection
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'Convert(bit, 0) as Selecionado,'#13#10#9'NF.IDNotaFiscal,'#13#10#9'NF' +
      '.Origem,'#13#10#9'NF.Referencia,'#13#10#9'NF.Situacao,'#13#10#9'NF.DataSolicitacao,'#13#10 +
      #9'NF.DataUltimoEnvio,'#13#10#9'NF.DataResultado,'#13#10#9'NF.DataUltimaImpressa' +
      'o,'#13#10#9'NF.XMLEnviado,'#13#10#9'NF.XMLRecebido,'#13#10#9'NF.DetalhamentoErro,'#13#10#9'N' +
      'F.QtdEnvios,'#13#10#9'NF.QtdImpressao,'#13#10#9'NF.Chave,'#13#10#9'I.InvoiceCode,'#13#10#9'I' +
      '.SaleCode,'#13#10#9'(CASE Origem WHEN '#39'Venda'#39' THEN I.InvoiceCode ELSE M' +
      'T.Number END) as NumeroNota'#13#10'FROM'#13#10#9'NFE_NotaFiscal NF (NOLOCK)'#13#10 +
      #9'LEFT JOIN Invoice I (NOLOCK) ON (I.IDInvoice = NF.Referencia )'#13 +
      #10#9'LEFT JOIN ModelTransf MT (NOLOCK) ON (MT.IDModelTransf = NF.Re' +
      'ferencia)'
    CommandTimeout = 180
    FieldDefs = <
      item
        Name = 'Selecionado'
        Attributes = [faReadonly, faFixed]
        DataType = ftBoolean
      end
      item
        Name = 'IDNotaFiscal'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'Origem'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Referencia'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'Situacao'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 15
      end
      item
        Name = 'DataSolicitacao'
        Attributes = [faFixed]
        DataType = ftDateTime
      end
      item
        Name = 'DataUltimoEnvio'
        Attributes = [faFixed]
        DataType = ftDateTime
      end
      item
        Name = 'DataResultado'
        Attributes = [faFixed]
        DataType = ftDateTime
      end
      item
        Name = 'DataUltimaImpressao'
        Attributes = [faFixed]
        DataType = ftDateTime
      end
      item
        Name = 'XMLEnviado'
        DataType = ftMemo
      end
      item
        Name = 'XMLRecebido'
        DataType = ftMemo
      end
      item
        Name = 'DetalhamentoErro'
        DataType = ftString
        Size = 8000
      end
      item
        Name = 'QtdEnvios'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'QtdImpressao'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'Chave'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'InvoiceCode'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'SaleCode'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'NumeroNota'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 20
      end>
    Parameters = <>
    StoreDefs = True
    Left = 130
    Top = 30
  end
  object cdsNotaFiscal: TClientDataSet
    Aggregates = <>
    FetchOnDemand = False
    Params = <>
    ProviderName = 'dspNotaFiscal'
    Left = 130
    Top = 130
  end
  object dspNotaFiscal: TDataSetProvider
    DataSet = adodsNotaFiscal
    Left = 130
    Top = 80
  end
  object dsNotaFiscal: TDataSource
    DataSet = cdsNotaFiscal
    Left = 130
    Top = 185
  end
  object dsImportarVendas: TADODataSet
    Connection = ADOConnection
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'I.IDInvoice'#13#10'FROM'#13#10#9'Invoice I (NOLOCK)'#13#10'WHERE'#13#10#9'I.IDInv' +
      'oice IS NOT NULL'#13#10#9'AND'#13#10#9'I.CupomFiscal IS NULL'#13#10#9'AND'#13#10#9'I.Invoice' +
      'Date >= :DataIni'#13#10#9'AND'#13#10#9'I.InvoiceDate < :DataFim'#13#10#9'AND'#13#10#9'I.IDIn' +
      'voice NOT IN ('#13#10#9#9'SELECT'#13#10#9#9#9'NF.Referencia'#13#10#9#9'FROM'#13#10#9#9#9'NFE_NotaF' +
      'iscal NF'#13#10#13#10#9#9'WHERE'#13#10#9#9#9'NF.Origem = '#39'Venda'#39#13#10#9#9')'#13#10#13#10
    Parameters = <
      item
        Name = 'DataIni'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFim'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end>
    Left = 465
    Top = 30
  end
  object spGetNextID: TADOStoredProc
    Connection = ADOConnection
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
    Left = 34
    Top = 89
  end
  object cmdInsertMovimento: TADOCommand
    CommandText = 
      'INSERT INTO NFE_NotaFiscal (IDNotaFiscal, DataSolicitacao, Situa' +
      'cao, Origem, Referencia, IDUserSolicitacao)'#13#10'VALUES(:IDNotaFisca' +
      'l, :DataSolicitacao, :Situacao, :Origem, :Referencia, :IDUserSol' +
      'icitacao)'#13#10
    Connection = ADOConnection
    Parameters = <
      item
        Name = 'IDNotaFiscal'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataSolicitacao'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'Situacao'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 15
        Value = Null
      end
      item
        Name = 'Origem'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
      item
        Name = 'Referencia'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDUserSolicitacao'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 570
    Top = 30
  end
  object dsTransferencia: TADODataSet
    Connection = ADOConnection
    CursorType = ctStatic
    AfterOpen = dsTransferenciaAfterOpen
    CommandText = 
      'SELECT'#13#10#9'MT.Number as I_InvoiceCode,'#13#10#9'MT.Data as I_InvoiceDate,' +
      ' '#13#10#9'SUM(MTD.CostPrice * MTD.Qty) as I_SubTotal,'#13#10#9'CAST(0 as Int)' +
      ' as I_IDFormOfPayment,'#13#10#9'CAST(0.00 as money) as I_Frete,'#13#10#9'CAST(' +
      #39#39' as varchar(30)) as I_Notes,'#13#10#9'CAST(0 as bit) as I_PrintNotes,' +
      #13#10#9'CAST(0 as bit) as I_DeliverConfirmation,'#13#10#9'CAST('#39#39' as varchar' +
      '(30)) as I_DeliverOBS,'#13#10#9'CAST('#39#39' as varchar(30)) as I_DeliverAdd' +
      'ress,'#13#10#13#10#9'E.CGC as E_CGC,'#13#10#9'E.InscricaoEstadual as E_InscricaoEs' +
      'tadual,'#13#10#9'E.Empresa as E_Empresa,'#13#10#9'E.RazaoSocial as E_RazaoSoci' +
      'al,'#13#10#9'E.Telefone as E_Telefone,'#13#10#9'E.Endereco as E_Endereco,'#13#10#9'E.' +
      'Coplemento as E_Coplemento,'#13#10#9'E.Numero as E_Numero,'#13#10#9'E.Bairro a' +
      's E_Bairro,'#13#10#9'E.IDEstado as E_IDEstado,'#13#10#9'E.CEP as E_CEP,'#13#10#9'E.No' +
      'meFantasia as E_NomeFantasia,'#13#10#9'UF.Codigo as E_UFCodigo,'#13#10#9'MU.Co' +
      'digo as E_MunicipioCode,'#13#10#9'MU.Descricao as E_Municipio,'#9#13#10#13#10#9'CFO' +
      'P.Number as CFOP_Number,'#13#10#9'CFOP.Description as CFOP_Description,' +
      #13#10#13#10#9'CAST(1 as bit) as P_Juridico,'#13#10#9'EP.InscricaoEstadual as P_I' +
      'nscEstadual,'#13#10#9'EP.CGC as P_CPF,'#13#10#9'EP.CEP as P_CEP,'#13#10#9'EP.Endereco' +
      ' as P_Endereco,'#13#10#9'EP.Bairro as P_Bairro ,'#13#10#9'EP.IDEstado as P_IDE' +
      'stado,'#13#10#9'CAST('#39#39' as varchar(5)) as P_PhoneAreaCode,'#13#10#9'EP.Telefon' +
      'e as P_Telefone,'#13#10#9'EP.NomeFantasia as P_NomeJuridico,'#13#10#9'EP.Razao' +
      'Social as P_Pessoa,'#13#10#9'EP.Coplemento as P_Complemento,'#13#10#9'EP.Numer' +
      'o as P_ComplementoNum,'#13#10#9'UFP.Codigo as P_UFCodigo,'#13#10#9'MUP.Codigo ' +
      'as P_MunicipioCode,'#13#10#9'MUP.Descricao as P_Municipio,'#13#10#13#10#9'CAST(1 a' +
      's int) as T_TipoDeFrete,'#13#10#9'CAST('#39#39' as varchar(60)) as T_Endereco' +
      ','#13#10#9'CAST('#39#39' as varchar(50)) as T_Pessoa,'#13#10#9'CAST('#39#39' as varchar(20' +
      ')) as T_CPF,'#13#10#9'CAST('#39#39' as varchar(20)) as T_InscEstadual,'#13#10#9'CAST' +
      '('#39#39' as varchar(3)) as T_IDEstado,'#13#10#9'CAST('#39#39' as varchar(20)) as T' +
      '_MunicipioCode,'#13#10#9'CAST('#39#39' as varchar(30)) as T_Municipio'#13#10#9#13#10'FRO' +
      'M'#13#10#9'ModelTransf MT (NOLOCK)'#13#10#9'JOIN ModelTransfDet MTD (NOLOCK) O' +
      'N (MTD.IDModelTransf = MT.IDModelTransf)'#13#10#9'JOIN Store S (NOLOCK)' +
      ' ON (MT.IDLojaOrigem = S.IDStore)'#13#10#9'JOIN Sis_Empresa E (NOLOCK) ' +
      'ON (S.IDEmpresa = E.IDEmpresa)'#13#10#9'JOIN Store P (NOLOCK) ON (P.IDS' +
      'tore = MT.IDLojaDestino)'#13#10#9'JOIN Sis_Empresa EP (NOLOCK) ON (P.ID' +
      'Empresa = EP.IDEmpresa)'#13#10#9'LEFT JOIN Mnt_CFOP CFOP (NOLOCK) ON (C' +
      'FOP.IDCFOP = MT.IDCFOP)'#13#10#9'LEFT JOIN Estado UF (NOLOCK) ON (E.IDE' +
      'stado = UF.IDEstado)'#13#10#9'LEFT JOIN Sis_Municipio MU (NOLOCK) ON (M' +
      'U.IDMunicipio = E.IDMunicipio)'#13#10#9'LEFT JOIN Estado UFP (NOLOCK) O' +
      'N (EP.IDEstado = UFP.IDEstado)'#13#10#9'LEFT JOIN Sis_Municipio MUP (NO' +
      'LOCK) ON (MUP.IDMunicipio = EP.IDMunicipio)'#13#10'WHERE'#13#10#9'MT.IDModelT' +
      'ransf = :IDModelTransf'#13#10#9'AND'#13#10#9'MT.TransferType = 0'#13#10'GROUP BY'#13#10#9'M' +
      'T.Number,'#13#10#9'MT.Data, '#13#10#9'E.CGC,'#13#10#9'E.InscricaoEstadual,'#13#10#9'E.Empres' +
      'a,'#13#10#9'E.RazaoSocial,'#13#10#9'E.Telefone,'#13#10#9'E.Endereco,'#13#10#9'E.Coplemento,'#13 +
      #10#9'E.Numero,'#13#10#9'E.Bairro,'#13#10#9'E.IDEstado,'#13#10#9'E.CEP,'#13#10#9'E.NomeFantasia,' +
      #13#10#9'UF.Codigo,'#13#10#9'MU.Codigo,'#13#10#9'MU.Descricao,'#13#10#9'CFOP.Number,'#13#10#9'CFOP' +
      '.Description,'#13#10#9'EP.InscricaoEstadual,'#13#10#9'EP.CGC,'#13#10#9'EP.CEP,'#13#10#9'EP.E' +
      'ndereco,'#13#10#9'EP.Bairro,'#13#10#9'EP.IDEstado,'#13#10#9'EP.Telefone,'#13#10#9'EP.NomeFan' +
      'tasia,'#13#10#9'EP.RazaoSocial,'#13#10#9'EP.Coplemento,'#13#10#9'EP.Numero,'#13#10#9'UFP.Cod' +
      'igo,'#13#10#9'MUP.Codigo,'#13#10#9'MUP.Descricao'
    Parameters = <
      item
        Name = 'IDModelTransf'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 0
      end>
    Left = 320
    Top = 30
  end
  object dsTransferenciaItem: TADODataSet
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = dsTransferenciaItemCalcFields
    CommandText = 
      'SELECT'#13#10#9'IDModelTransfDet as IDInventoryMov,'#13#10#9'M.Model as M_Mode' +
      'l,'#13#10#9'M.Description as M_Description,'#13#10#9'MTD.QTY as IM_QTY,'#13#10#9'(MTD' +
      '.CostPrice) as IM_SalePrice,'#13#10#9'CAST(0.00 as money) as IM_Frete,'#13 +
      #10#9'CAST(0.00 as  money) as IM_Discount,'#13#10#9'U.Unidade as U_Unidade,' +
      #13#10#9'U.Sigla as U_Sigla,'#13#10#9'TC.SituacaoTributaria as T_SituacaoTrib' +
      'utaria,'#13#10#9'CAST(0.00 as money) as T_AliquotaST,'#13#10#9'CAST(0.00 as mo' +
      'ney) as TaxCategoriaPer,'#13#10#9'CAST(0.00 as money) as TaxEstadoPerc,' +
      #13#10#9'CAST(0.00 as money) as TaxItemPer,'#13#10#9'CAST('#39#39' as varchar(3)) a' +
      's EstadoCliente,'#13#10#9'CAST('#39#39' as varchar(3)) as EstadoLoja,'#13#10#9'CAST(' +
      '0.00 as money) as MVAInterno,'#13#10#9'CAST(0.00 as money) as MVAIntere' +
      'stadual,'#13#10#9'CAST(0 as int) as SitTribItem,'#13#10#9'CAST(1 as int) as Si' +
      'tTribCategoria,'#13#10#9'CAST(0.00 as money) as TotalFrete,'#13#10#9'CAST(0 as' +
      ' bit) as M_SerialNumber,'#13#10#9'NCM.Codigo as M_NCMCodigo'#13#10'FROM'#13#10#9'Mod' +
      'elTransf MT (NOLOCK)'#13#10#9'JOIN ModelTransfDet MTD (NOLOCK) ON (MT.I' +
      'DModelTransf = MTD.IDModelTransf)'#13#10#9'JOIN Model M (NOLOCK) ON (MT' +
      'D.IDModel = M.IDModel)'#13#10#9'JOIN TabGroup TG (NOLOCK) ON (M.GroupID' +
      ' = TG.IDGroup)'#13#10#9'JOIN StoreToTabGroup STG (NOLOCK) ON (STG.IDGro' +
      'up = TG.IDGroup AND STG.IDStore = MT.IDLojaOrigem)'#13#10#9'JOIN TaxCat' +
      'egory TC (NOLOCK) ON (TC.IDTaxCategory = STG.IDSaleTax)'#13#10#9'LEFT J' +
      'OIN Unidade U (NOLOCK) ON (M.IDUnidade = U.IDUnidade)'#13#10#9'LEFT JOI' +
      'N Mnt_CFOP CFOP (NOLOCK) ON (CFOP.IDCFOP = MT.IDCFOP)'#13#10#9'LEFT JOI' +
      'N Inv_NCM NCM (NOLOCK) ON (NCM.IDNCM = M.IDNCM)'#13#10'WHERE'#13#10#9'MT.IDMo' +
      'delTransf = :IDTransfer'#13#10#13#10
    Parameters = <
      item
        Name = 'IDTransfer'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 320
    Top = 85
    object dsTransferenciaItemIDInventoryMov: TIntegerField
      FieldName = 'IDInventoryMov'
    end
    object dsTransferenciaItemM_Model: TStringField
      FieldName = 'M_Model'
      Size = 30
    end
    object dsTransferenciaItemM_Description: TStringField
      FieldName = 'M_Description'
      Size = 50
    end
    object dsTransferenciaItemIM_QTY: TBCDField
      FieldName = 'IM_QTY'
      DisplayFormat = '0.####'
      Precision = 32
    end
    object dsTransferenciaItemIM_SalePrice: TBCDField
      FieldName = 'IM_SalePrice'
      DisplayFormat = '#,##0.00##'
      Precision = 19
    end
    object dsTransferenciaItemIM_Frete: TBCDField
      FieldName = 'IM_Frete'
      ReadOnly = True
      Precision = 19
      Size = 6
    end
    object dsTransferenciaItemIM_Discount: TBCDField
      FieldName = 'IM_Discount'
      ReadOnly = True
      DisplayFormat = '#,##0.00##'
      Precision = 19
    end
    object dsTransferenciaItemU_Unidade: TStringField
      FieldName = 'U_Unidade'
      Size = 100
    end
    object dsTransferenciaItemU_Sigla: TStringField
      FieldName = 'U_Sigla'
      FixedChar = True
      Size = 4
    end
    object dsTransferenciaItemT_SituacaoTributaria: TIntegerField
      FieldName = 'T_SituacaoTributaria'
    end
    object dsTransferenciaItemTaxCategoriaPer: TBCDField
      FieldName = 'TaxCategoriaPer'
      ReadOnly = True
      Precision = 19
    end
    object dsTransferenciaItemTaxEstadoPerc: TBCDField
      FieldName = 'TaxEstadoPerc'
      ReadOnly = True
      Precision = 19
    end
    object dsTransferenciaItemTaxItemPer: TBCDField
      FieldName = 'TaxItemPer'
      ReadOnly = True
      Precision = 19
    end
    object dsTransferenciaItemEstadoCliente: TStringField
      FieldName = 'EstadoCliente'
      ReadOnly = True
      Size = 3
    end
    object dsTransferenciaItemEstadoLoja: TStringField
      FieldName = 'EstadoLoja'
      ReadOnly = True
      Size = 3
    end
    object dsTransferenciaItemMVAInterno: TBCDField
      FieldName = 'MVAInterno'
      ReadOnly = True
      Precision = 19
    end
    object dsTransferenciaItemMVAInterestadual: TBCDField
      FieldName = 'MVAInterestadual'
      ReadOnly = True
      Precision = 19
    end
    object dsTransferenciaItemSitTribItem: TIntegerField
      FieldName = 'SitTribItem'
      ReadOnly = True
    end
    object dsTransferenciaItemSitTribCategoria: TIntegerField
      FieldName = 'SitTribCategoria'
      ReadOnly = True
    end
    object dsTransferenciaItemCFOP_Number: TStringField
      FieldKind = fkCalculated
      FieldName = 'CFOP_Number'
      Calculated = True
    end
    object dsTransferenciaItemT_Aliquota: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'T_Aliquota'
      Calculated = True
    end
    object dsTransferenciaItemT_AliquotaST: TBCDField
      FieldName = 'T_AliquotaST'
      ReadOnly = True
      Precision = 19
    end
    object dsTransferenciaItemTotalFrete: TBCDField
      FieldName = 'TotalFrete'
      ReadOnly = True
      Precision = 19
    end
    object dsTransferenciaItemM_SerialNumber: TBooleanField
      FieldName = 'M_SerialNumber'
      ReadOnly = True
    end
    object dsTransferenciaItemM_NCMCodigo: TStringField
      FieldName = 'M_NCMCodigo'
    end
    object dsTransferenciaItemMVAPercent: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'MVAPercent'
      Calculated = True
    end
    object dsTransferenciaItemAliquotaDesc: TStringField
      FieldKind = fkCalculated
      FieldName = 'AliquotaDesc'
      Size = 100
      Calculated = True
    end
  end
  object dsImportarTransferencia: TADODataSet
    Connection = ADOConnection
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'MT.IDModelTransf'#13#10'FROM'#13#10#9'ModelTransf MT (NOLOCK)'#13#10'WHERE' +
      #13#10#9'MT.Data >= :DataIni'#13#10#9'AND'#13#10#9'MT.Data < :DataFim'#13#10#9'AND'#13#10#9'MT.IDM' +
      'odelTransf NOT IN ('#13#10#9#9'SELECT'#13#10#9#9#9'NF.Referencia'#13#10#9#9'FROM'#13#10#9#9#9'NFE_' +
      'NotaFiscal NF'#13#10#13#10#9#9'WHERE'#13#10#9#9#9'NF.Origem = '#39'Transferencia'#39#13#10#9#9')'#13#10#13 +
      #10
    Parameters = <
      item
        Name = 'DataIni'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFim'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end>
    Left = 465
    Top = 90
  end
  object dsInvItemSerial: TADODataSet
    Connection = ADOConnection
    CommandText = 
      'SELECT'#13#10#9'SerialNumber'#13#10'FROM'#13#10#9'SerialMov'#13#10'WHERE'#13#10#9'InventoryMovID ' +
      '= :InventoryMovID'#13#10
    Parameters = <
      item
        Name = 'InventoryMovID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 235
    Top = 145
  end
  object quLookUPEmpresa: TLookUpADOQuery
    Connection = ADOConnection
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'select E.IDEmpresa, E.Empresa'#13#10'from sis_Empresa E'#13#10'Order by E.Em' +
      'presa'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Empresa'
    CodeField = 'IDEmpresa'
    LookUpField = 'IDEmpresa'
    Left = 354
    Top = 174
    object quLookUPEmpresaIDEmpresa: TIntegerField
      FieldName = 'IDEmpresa'
      Origin = 'RETAILCOMBO.sis_Empresa.IDEmpresa'
    end
    object quLookUPEmpresaEmpresa: TStringField
      FieldName = 'Empresa'
      Origin = 'RETAILCOMBO.sis_Empresa.Empresa'
      Size = 35
    end
  end
  object dsLookUpEmpresa: TDataSource
    DataSet = quLookUPEmpresa
    Left = 354
    Top = 227
  end
end
