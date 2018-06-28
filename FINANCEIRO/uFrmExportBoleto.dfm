inherited FrmExportBoleto: TFrmExportBoleto
  Left = 319
  Top = 228
  Width = 446
  Height = 183
  Caption = 'Export Boleto'
  PixelsPerInch = 96
  TextHeight = 13
  object lblFile: TLabel [0]
    Left = 68
    Top = 80
    Width = 23
    Height = 13
    Alignment = taRightJustify
    Caption = 'File :'
  end
  object lblLayout: TLabel [1]
    Left = 52
    Top = 52
    Width = 40
    Height = 13
    Alignment = taRightJustify
    Caption = 'Layout :'
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 119
    TabOrder = 4
  end
  inherited EspacamentoDireito: TPanel
    Left = 435
    Height = 119
    TabOrder = 5
  end
  inherited EspacamentoSuperior: TPanel
    Width = 438
    TabOrder = 6
  end
  inherited pnlEspacamentoInferiror: TPanel
    Top = 125
    Width = 438
    Height = 31
    object btnOk: TButton
      Left = 273
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Ok'
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TButton
      Left = 357
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object edtFilePath: TEdit [6]
    Left = 96
    Top = 76
    Width = 261
    Height = 21
    TabOrder = 1
  end
  object cmbLayout: TComboBox [7]
    Left = 96
    Top = 48
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    Items.Strings = (
      'CNAB240'
      'CNAB400'
      'Outro')
  end
  object btnSearchPath: TButton [8]
    Left = 364
    Top = 76
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 2
    OnClick = btnSearchPathClick
  end
  inherited siLang: TsiLangRT
    StorageFile = 'OM_FrmExportBoleto.sil'
    Left = 216
    Top = 8
  end
  object gbTitulo: TgbTitulo
    TipoOcorrencia = toRemessaRegistrar
    LocalPagamento = 'PAGÁVEL EM QUALQUER BANCO ATÉ O VENCIMENTO'
    Cedente.TipoInscricao = tiPessoaFisica
    Sacado.TipoInscricao = tiPessoaJuridica
    AceiteDocumento = adNao
    EspecieDocumento = edDuplicataMercantil
    EmissaoBoleto = ebClienteEmite
    Left = 324
    Top = 8
  end
  object gbCobranca: TgbCobranca
    NumeroArquivo = 0
    LayoutArquivo = laCNAB400
    TipoMovimento = tmRetorno
    Left = 384
    Top = 8
  end
  object OpenDialog: TOpenDialog
    Left = 264
    Top = 8
  end
  object quPagamento: TADODataSet
    Connection = DM.DBADOConnection
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'L.IDLancamento,'#13#10#9'MP.BankBilletInterest,'#13#10#9'L.ValorNomin' +
      'al,'#13#10#9'L.DataVencimento,'#13#10#9'L.DataLancamento,'#13#10#9'CC.NossoNumero,'#13#10#9 +
      'CC.NossoNumeroDigito,'#13#10#9'CC.Numero as NumeroCC,'#13#10#9'CC.Carteira,'#13#10#9 +
      'CC.Gerente,'#13#10#9'BA.CodigoBancoAgencia,'#13#10#9'BA.BancoAgencia,'#13#10#9'B.Banc' +
      'o,'#13#10#9'B.CodigoBanco,'#13#10#9'E.Empresa,'#13#10#9'E.CGC'#13#10'FROM'#13#10#9'Fin_Lancamento ' +
      'L (NOLOCK)'#13#10#9'JOIN Store S (NOLOCK) ON (S.IDEmpresa = L.IDEmpresa' +
      ')'#13#10#9'JOIN Sis_Empresa E (NOLOCK) ON (E.IDEmpresa = S.IDEmpresa)'#13#10 +
      #9'JOIN MeioPag MP (NOLOCK) ON (L.IDQuitacaoMeioPrevisto = MP.IDMe' +
      'ioPag)'#13#10#9'JOIN MeioPag MPB (NOLOCK) ON (MPB.IDMeioPag = MP.IDMeio' +
      'PagBatch)'#13#10#9'JOIN MeioPagToStore MPTS (NOLOCK) ON (MPTS.IDStore =' +
      ' S.IDStore AND MPTS.IDMeioPag = MPB.IDMeioPag)'#13#10#9'JOIN Fin_ContaC' +
      'orrente CC (NOLOCK) ON (CC.IDContaCorrente = MPTS.IDContaCorrent' +
      'e)'#13#10#9'JOIN Fin_Banco B (NOLOCK) ON (B.IDBanco = CC.IDBanco)'#13#10#9'LEF' +
      'T JOIN Fin_BancoAgencia BA (NOLOCK) ON (BA.IDBancoAgencia = CC.I' +
      'DBancoAgencia)'#13#10'WHERE'#13#10#9'L.IDLancamento = :IDLancamento'#13#10
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
    Top = 1
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
    Top = 2
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
end
