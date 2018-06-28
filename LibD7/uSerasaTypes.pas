unit uSerasaTypes;

interface

uses uSerasaConsts;

type
  TCriptFunction = function(TP:String;BufEnv:String;BufOut:String):PCHAR;stdcall;

  TEncript       = procedure (bufenv: PChar; bufout: PChar);cdecl;

  TDescript      = procedure (bufenv: PChar; bufout: PChar);stdcall;

  TyBuf          = array[1..80000] of char;

  TReg00 = record
    Nome:                            String[68];
    NascimentoFundacao:              String[8];
    Situacao:                        String[2];
    DataSituacao:                    String[TAM_DATA];
    Mensagem:                        String[65];
    NomeMae:                         String[40]
  end;

  {TReg04 = record
    QuantidadePendencias:            String[5];
    DataOcorrenciaMaisAntiga:        String[6];
    DataOcorrenciaMaisRecente:       String[6];
    ModalidadeOcorrenciaMaisRecente: String[30];
    TipoMoedaOcorrenciaMaisRecente:  String[3];
    Valor:                           String[15];
    OrigemOcorrenciaMaisRecente:     String[30];
    NumeroLojaFilial:                String[4];
  end;}

  TReg04 = record
    DataOcorrencia :                 String[8];
    Modalidade:                      String[30];
    Avalista:                        String[1];
    TipoMoeda:                       String[3];
    Valor:                           String[15];
    Contrato:                        String[16];
    Origem:                          String[30];
    PracaOcorrencia:                 String[4];
  end;


  TReg08 = record
    DataOcorrencia :                 String[8];
    Modalidade:                      String[30];
    Avalista:                        String[1];
    TipoMoeda:                       String[3];
    Valor:                           String[15];
    Contrato:                        String[16];
    Origem:                          String[30];
    PracaOcorrencia:                 String[4];
  end;



  TReg10 = record
    TotalOcorrencias:                String[5];
    DataOcorrenciaMaisAntiga:        String[TAM_MES_ANO];
    DataOcorrenciaMaisRecente:       String[TAM_MES_ANO];
  end;

  TReg14 = record
    QtdChequesSemFundosVarejo:       String[5];
    DataUltimaOcorrencia:            String[TAM_DATA];
    CodCompensacao:                  String[3];
    NomeFantasiaBanco:               String[12];
    NumeroAgencia:                   String[4];
    Origem:                          String[30];
    PracaOcorencia:                  String[4];
    NumeroLojaFilial:                String[4];
  end;

  TReg18 = record
    QtdChequesSemFundos:             String[5];
    DataUltimaOcorrencia:            String[TAM_DATA];
    DataOcorrenciaMaisRecente:       String[TAM_DATA];
    CodCompensacao:                  String[3];
    NumeroAgencia:                   String[4];
    NomeFantasiaBanco:               String[12];
  end;

  TReg22 = record
    CodCompensacao:                  String[3];
    NumeroAgencia:                   String[4];
    NumeroContaCorrente:             String[10];
    NumeroChequeInicial:             String[6];
    NumeroChequeFinal:               String[6];
    Motivo:                          String[12];
    DataCadastramento:               String[TAM_DATA];
    HoraCadastramento:               String[4];
    CodigoFonte:                     String[4];
    DocumentoOriginal:               String[15];
    TipoPessoaDocumento:             String[1];
  end;

  TReg26 = record
    CodCompensacao:                  String[3];
    NumeroAgencia:                   String[4];
    NumeroContaCorrente:             String[10];
    NumeroChequeInicial:             String[6];
    NumeroChequeFinal:               String[6];
    Motivo:                          String[12];
    DataOcorrencia:                  String[TAM_DATA];
    CodigoFonte:                     String[4];
  end;

  TReg30 = record
    DocAssinanteConfere:             String[1];
    NomeAsinante:                    String[70];
    TipoDocAssinante:                String[1];
    ClasseAssinante:                 String[1];
    InstalacaoLinha:                 String[TAM_DATA];
  end;

  TReg32 = record
    LogradouroAssinante:             String[70];
    BairroAsinante:                  String[70];
    CidadeAssinante:                 String[30];
    CEPAssinante:                    String[9];
  end;

  TReg34 = record
    IndicadorPesquisa:               String[1];
    Mensagem:                        String[40];
  end;

  TReg36 = record
    IntEmissPriCHVista:              String[TAM_MES_ANO];
    IntEmissUltCHVista:              String[TAM_MES_ANO];
    IntTotCHVista15:                 String[3];
    IntTotCHPrazo30:                 String[2];
    IntTotCHPrazo3160:               String[2];
    IntTotCHPrazo6190:               String[2];
    IntTotCHPrazo:                   String[3];

    MerEmissPriCHVista:              String[TAM_MES_ANO];
    MerEmissUltCHVista:              String[TAM_MES_ANO];
    MerTotCHVista15:                 String[3];
    MerTotCHPrazo30:                 String[2];
    MerTotCHPrazo3160:               String[2];
    MerTotCHPrazo6190:               String[2];
    MerTotCHPrazo:                   String[3];

    ConsPrazoNomeEmpresa1:           String[25];
    ConsPrazoNomeData1:              String[TAM_MES_ANO];

    ConsPrazoNomeEmpresa2:           String[25];
    ConsPrazoNomeData2:              String[TAM_MES_ANO];

    ConsPrazoNomeEmpresa3:           String[25];
    ConsPrazoNomeData3:              String[TAM_MES_ANO];
  end;

  TReg40 = record
    MaisRecente1:                    String[8];
    MaisRecente2:                    String[8];
    MaisRecente3:                    String[8];
    MaisRecente4:                    String[8];
    MaisRecente5:                    String[8];
  end;


  TReg44 = record
    MensagemSituacao:                String[40];
    AberturaEncerramento:            String[8];
    TipoPessoaRegistrada:            String[1];
    Documentoregistrado:             String[15];
    NomeRazaoSocial:                 String[40];
    TipoDocumento:                   String[1];
    NumeroDocumento:                 String[15];
    OrgaoEmissor:                    String[5];
    UF:                              String[2];
    DataEmissao:                     String[TAM_DATA];
  end;

  TReg46 = record
    CodigoBanco:                     String[3];
    IndicadorRecheque:               String[1];
    Mensagem:                        String[36];
  end;

  TReg48 = record
    EnderecoCEP:                     String[70];
    Bairro:                          String[30];
    Ciadade:                         String[30];
    UF:                              String[2];
    Generico:                        String[1];
  end;

  TReg52 = record
    NomeAgenciaBancaria:             String[70];
    EnderecoAgencia:                 String[70];
    Cidade:                          String[30];
    UF:                              String[2];
    UltimaAtualizacao:               String[TAM_DATA];
    DDDAgencia:                      String[4];
    TelAgencia:                      String[8];
    DDDFaxAgencia:                   String[4];
    FaxAgencia:                      String[8];
  end;

  TReg54 = record
    Mensagem:                        String[32];
    UltimaAtualizacao:               String[TAM_DATA];
  end;

  TReg90 = record
    CodigoMensagem:                  String[3];
    Mensagem:                        String[40];
  end;

  TSerasaHeader = class
  public
    Transacao:                       String[4];
    TransacaoContratada:             String[4];
    CodigoRelease:                   String[12];
    Login:                           String[8];
    Senha:                           String[8];
    CNPJSolicitante:                 String[15];
    CodigoEstacao:                   String[6];
    MeioAcesso:                      String[1];
    FuncaoChamada:                   String[4];
    ReservadoSerasa1:                String[30];
    TipoDocumentoPesquisa:           String[1];
    DocumentoPesquisa:               String[15];
    OpcoesConsulta:                  String[2];
    IdentificacaoDadosCheque:        String[1];
    CodigoBanco:                     String[3];
    NumeroAgencia:                   String[4];
    NumeroContaCorrente:             String[15];
    NumeroChequeInicial:             String[6];
    DigitoChequeInicial:             String[1];
    NumeroChequeFinal:               String[6];
    DigitoChequeFinal:               String[1];
    CMC7Inicial:                     String[30];
    CMC7Final:                       String[30];
    ValorCheque:                     String[15];
    DataVencimento:                  String[8];
    NumeroDDD:                       String[4];
    NumeroTelefone:                  String[8];
    NumeroCEPConsultado:             String[9];
    ReservadoExpansaoSerasa:         String[48];
    function ChaveAcesso: String;
    function ToHeader: String;
  end;


implementation

uses uSerasaFunctions;

{ TSerasaHeader }

function TSerasaHeader.ChaveAcesso: String;
begin
  Result := ZeroNumberLeft(Login, 8) + SpaceStringRight(Senha, 8);
end;

function TSerasaHeader.ToHeader: String;
begin
  Result :=
    ChaveAcesso+ SpaceStringRight(' ', 8)+

    SpaceStringRight(Transacao, SizeOf(Transacao) - 1 ) +
    SpaceStringRight(TransacaoContratada, SizeOf(TransacaoContratada) - 1 ) +
    SpaceStringRight(CodigoRelease, SizeOf(CodigoRelease) - 1 ) +
    ChaveAcesso +
    ZeroNumberLeft(CNPJSolicitante, SizeOf(CNPJSolicitante) - 1 ) +
    SpaceStringRight(CodigoEstacao, SizeOf(CodigoEstacao) - 1 ) +
    SpaceStringRight(MeioAcesso, SizeOf(MeioAcesso) - 1 ) +
    SpaceStringRight(FuncaoChamada, SizeOf(FuncaoChamada) - 1 ) +
    SpaceStringRight(ReservadoSerasa1, SizeOf(ReservadoSerasa1) - 1 ) +
    SpaceStringRight(TipoDocumentoPesquisa, SizeOf(TipoDocumentoPesquisa) - 1 ) +
    ZeroNumberLeft(DocumentoPesquisa, SizeOf(DocumentoPesquisa) - 1 ) +
    SpaceStringRight(OpcoesConsulta, SizeOf(OpcoesConsulta) - 1 ) +
    ZeroNumberLeft(IdentificacaoDadosCheque, SizeOf(IdentificacaoDadosCheque) - 1 ) +
    ZeroNumberLeft(CodigoBanco, SizeOf(CodigoBanco) - 1 ) +
    ZeroNumberLeft(NumeroAgencia, SizeOf(NumeroAgencia) - 1 ) +
    ZeroNumberLeft(NumeroContaCorrente, SizeOf(NumeroContaCorrente) - 1 ) +
    ZeroNumberLeft(NumeroChequeInicial, SizeOf(NumeroChequeInicial) - 1 ) +
    ZeroNumberLeft(DigitoChequeInicial, SizeOf(DigitoChequeInicial) - 1 ) +
    ZeroNumberLeft(NumeroChequeFinal, SizeOf(NumeroChequeFinal) - 1 ) +
    ZeroNumberLeft(DigitoChequeFinal, SizeOf(DigitoChequeFinal) - 1 ) +
    ZeroNumberLeft(CMC7Inicial, SizeOf(CMC7Inicial) - 1 ) +
    ZeroNumberLeft(CMC7Final, SizeOf(CMC7Final) - 1 ) +
    ZeroNumberLeft(ValorCheque, SizeOf(ValorCheque) - 1 ) +
    ZeroNumberLeft(DataVencimento, SizeOf(DataVencimento) - 1 ) +
    ZeroNumberLeft(NumeroDDD, SizeOf(NumeroDDD) - 1 ) +
    ZeroNumberLeft(NumeroTelefone, SizeOf(NumeroTelefone) - 1 ) +
    ZeroNumberLeft(NumeroCEPConsultado, SizeOf(NumeroCEPConsultado) - 1 ) +
    SpaceStringRight(ReservadoExpansaoSerasa, SizeOf(ReservadoExpansaoSerasa) - 1 ) +
    HEADER_CHR_ENCERRAMENTO;
end;


end.
