object FrmPrintBoleto: TFrmPrintBoleto
  Left = 383
  Top = 349
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Boleto'
  ClientHeight = 81
  ClientWidth = 224
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object btnClose: TButton
    Left = 76
    Top = 25
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 0
    OnClick = btnCloseClick
  end
  object gbTitulo: TgbTitulo
    TipoOcorrencia = toRemessaRegistrar
    LocalPagamento = 'PAGÁVEL EM QUALQUER BANCO ATÉ O VENCIMENTO'
    Cedente.TipoInscricao = tiPessoaFisica
    Sacado.TipoInscricao = tiPessoaJuridica
    AceiteDocumento = adNao
    EspecieDocumento = edDuplicataMercantil
    EmissaoBoleto = ebClienteEmite
    Left = 100
    Top = 30
  end
  object gbCobranca: TgbCobranca
    NumeroArquivo = 0
    LayoutArquivo = laCNAB400
    TipoMovimento = tmRetorno
    Left = 175
    Top = 30
  end
  object quCustomerInfo: TADODataSet
    Connection = DM.DBADOConnection
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'P.Pessoa as FullName,'#13#10#9'P.Endereco as ClientAddress,'#13#10#9 +
      'P.Cidade as ClientCity,'#13#10#9'P.Bairro as ClientNeighborhood,'#13#10#9'P.CE' +
      'P as ClientZip,'#13#10#9'P.CPF as ClientEmployeeID,'#13#10#9'P.CartTrabalho as' +
      ' ClientSocialSecurity,'#13#10#9'P.InscEstadual as ClientFederalID,'#13#10#9'P.' +
      'InscMunicipal as ClientSalesTax,'#13#10#9'P.NomeJuridico as ClientDBA,'#13 +
      #10#9'P.PhoneAreaCode as ClientPhoneAreaCode,'#13#10#9'P.CellAreaCode as Cl' +
      'ientCellAreaCode,'#13#10#9'P.Fax as ClientFax,'#13#10#9'P.Identidade as Client' +
      'Identidade,'#13#10#9'P.OrgaoEmissor as ClientOrgaoEmissor,'#13#10#9'P.DataExpe' +
      'dicao as ClientDataExpedicao,'#13#10#9'P.Juridico,'#13#10#9'P.Email,'#13#10#9'P.IDEst' +
      'ado'#13#10'FROM'#13#10#9'Fin_Lancamento L (NOLOCK)'#13#10#9'JOIN Pessoa P (NOLOCK) O' +
      'N (L.IDPessoa = P.IDPessoa)'#13#10'WHERE'#13#10#9'L.IDLancamento = :IDLancame' +
      'nto'#13#10
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDLancamento'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 60
    Top = 10
    object quCustomerInfoFullName: TStringField
      FieldName = 'FullName'
      Size = 50
    end
    object quCustomerInfoClientAddress: TStringField
      FieldName = 'ClientAddress'
      Size = 80
    end
    object quCustomerInfoClientCity: TStringField
      FieldName = 'ClientCity'
      Size = 40
    end
    object quCustomerInfoClientNeighborhood: TStringField
      FieldName = 'ClientNeighborhood'
      Size = 50
    end
    object quCustomerInfoClientZip: TStringField
      FieldName = 'ClientZip'
      FixedChar = True
      Size = 12
    end
    object quCustomerInfoClientEmployeeID: TStringField
      FieldName = 'ClientEmployeeID'
      Size = 30
    end
    object quCustomerInfoClientSocialSecurity: TStringField
      FieldName = 'ClientSocialSecurity'
      Size = 30
    end
    object quCustomerInfoClientFederalID: TStringField
      FieldName = 'ClientFederalID'
      Size = 30
    end
    object quCustomerInfoClientSalesTax: TStringField
      FieldName = 'ClientSalesTax'
      Size = 30
    end
    object quCustomerInfoClientDBA: TStringField
      FieldName = 'ClientDBA'
      Size = 50
    end
    object quCustomerInfoClientPhoneAreaCode: TStringField
      FieldName = 'ClientPhoneAreaCode'
      Size = 5
    end
    object quCustomerInfoClientCellAreaCode: TStringField
      FieldName = 'ClientCellAreaCode'
      Size = 5
    end
    object quCustomerInfoClientFax: TStringField
      FieldName = 'ClientFax'
      Size = 40
    end
    object quCustomerInfoClientIdentidade: TStringField
      FieldName = 'ClientIdentidade'
      Size = 30
    end
    object quCustomerInfoClientOrgaoEmissor: TStringField
      FieldName = 'ClientOrgaoEmissor'
      Size = 50
    end
    object quCustomerInfoClientDataExpedicao: TDateTimeField
      FieldName = 'ClientDataExpedicao'
    end
    object quCustomerInfoJuridico: TBooleanField
      FieldName = 'Juridico'
    end
    object quCustomerInfoEmail: TStringField
      FieldName = 'Email'
      Size = 50
    end
    object quCustomerInfoIDEstado: TStringField
      FieldName = 'IDEstado'
      FixedChar = True
      Size = 3
    end
  end
  object quPagamento: TADODataSet
    Connection = DM.DBADOConnection
    CursorType = ctStatic
    OnCalcFields = quPagamentoCalcFields
    CommandText = 
      'SELECT DISTINCT'#13#10#9'L.IDLancamento,'#13#10#9'MP.BankBilletInterest,'#13#10#9'L.V' +
      'alorNominal,'#13#10#9'L.DataVencimento,'#13#10#9'L.DataLancamento,'#13#10#9'CC.NossoN' +
      'umero,'#13#10#9'CC.NossoNumeroDigito,'#13#10#9'CC.Numero as NumeroCC,'#13#10#9'CC.Car' +
      'teira,'#13#10#9'CC.Gerente,'#13#10#9'BA.CodigoBancoAgencia,'#13#10#9'BA.BancoAgencia,' +
      #13#10#9'B.Banco,'#13#10#9'B.CodigoBanco,'#13#10#9'E.Empresa,'#13#10#9'E.CGC,'#13#10#9'INV.SaleCod' +
      'e,'#13#10#9'L.Numdesdobramento'#13#10'FROM'#13#10#9'Fin_Lancamento L (NOLOCK)'#13#10#9'JOIN' +
      ' Store S (NOLOCK) ON (S.IDEmpresa = L.IDEmpresa)'#13#10#9'JOIN Sis_Empr' +
      'esa E (NOLOCK) ON (E.IDEmpresa = S.IDEmpresa)'#13#10#9'JOIN MeioPag MP ' +
      '(NOLOCK) ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag)'#13#10#9'JOIN Mei' +
      'oPag MPB (NOLOCK) ON (MPB.IDMeioPag = MP.IDMeioPagBatch)'#13#10#9'JOIN ' +
      'MeioPagToStore MPTS (NOLOCK) ON (MPTS.IDStore = S.IDStore AND MP' +
      'TS.IDMeioPag = MPB.IDMeioPag)'#13#10#9'JOIN Fin_ContaCorrente CC (NOLOC' +
      'K) ON (CC.IDContaCorrente = MPTS.IDContaCorrente)'#13#10#9'JOIN Fin_Ban' +
      'co B (NOLOCK) ON (B.IDBanco = CC.IDBanco)'#13#10#9'LEFT JOIN Fin_BancoA' +
      'gencia BA (NOLOCK) ON (BA.IDBancoAgencia = CC.IDBancoAgencia)'#13#10#9 +
      'LEFT JOIN Invoice INV (NOLOCK) ON (INV.IDPreSale = L.IDPreSale)'#13 +
      #10'WHERE'#13#10#9'L.IDLancamento = :IDLancamento'#13#10
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDLancamento'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 135
    Top = 5
    object quPagamentoIDLancamento: TIntegerField
      FieldName = 'IDLancamento'
    end
    object quPagamentoBankBilletInterest: TBCDField
      FieldName = 'BankBilletInterest'
      Precision = 19
    end
    object quPagamentoValorNominal: TBCDField
      FieldName = 'ValorNominal'
      Precision = 19
    end
    object quPagamentoDataVencimento: TDateTimeField
      FieldName = 'DataVencimento'
    end
    object quPagamentoDataLancamento: TDateTimeField
      FieldName = 'DataLancamento'
    end
    object quPagamentoNossoNumero: TStringField
      FieldName = 'NossoNumero'
    end
    object quPagamentoNossoNumeroDigito: TStringField
      FieldName = 'NossoNumeroDigito'
      FixedChar = True
      Size = 1
    end
    object quPagamentoBanco: TStringField
      FieldName = 'Banco'
      Size = 35
    end
    object quPagamentoCodigoBanco: TStringField
      FieldName = 'CodigoBanco'
    end
    object quPagamentoNumeroCC: TStringField
      FieldName = 'NumeroCC'
      Size = 35
    end
    object quPagamentoGerente: TStringField
      FieldName = 'Gerente'
      Size = 35
    end
    object quPagamentoCodigoBancoAgencia: TStringField
      FieldName = 'CodigoBancoAgencia'
    end
    object quPagamentoBancoAgencia: TStringField
      FieldName = 'BancoAgencia'
      Size = 35
    end
    object quPagamentoEmpresa: TStringField
      FieldName = 'Empresa'
      Size = 35
    end
    object quPagamentoCGC: TStringField
      FieldName = 'CGC'
    end
    object quPagamentoCarteira: TStringField
      FieldName = 'Carteira'
      Size = 10
    end
    object quPagamentoNumdesdobramento: TStringField
      FieldName = 'Numdesdobramento'
    end
    object quPagamentoNossoNumeroFinal: TStringField
      FieldKind = fkCalculated
      FieldName = 'NossoNumeroFinal'
      Size = 8
      Calculated = True
    end
    object quPagamentoSaleCode: TStringField
      FieldName = 'SaleCode'
    end
  end
end
