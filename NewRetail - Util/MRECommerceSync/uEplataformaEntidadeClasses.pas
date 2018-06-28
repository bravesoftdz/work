unit uEplataformaEntidadeClasses;

interface

uses Classes;

type
  TepEntidade = class
  end;

  TepEntidadeLista = class(TList)
  end;

  TepMarca = class(TepEntidade)
    IDMarca: Integer;
    Nome: String;
    Texto: String;
    PalavraChave: String;
    TituloSite: String;
    FlagAtivaHotSite: Boolean;
    FlagAtiva: Boolean;
  end;

  TepMarcaLista = class(TepEntidadeLista)
  end;

  TepCategoria = class(TepEntidade)
    IDCategoria: Integer;
    IDCategoriaPai: Integer;
    IDDepartamento: Integer;
    FlagAtiva: Boolean;
    FlagMenu: Boolean;
    Nome: String;
    Texto: String;
    MargemLucro: Double;
    Ordem: Integer;
    PalavraChave: String;
    TituloSite: String;
    ModoExibicaoProduto: String;
    FlagExisteProduto: Boolean;
    FlagFiltroMarca: Boolean;
    FlagAtivaMenuLink: Boolean;
  end;

  TepCategoriaLista = class(TepEntidadeLista)
  end;

  TepSKULista = class(TepEntidadeLista)
  end;

  TepProduto = class(TepEntidade)
    IDProduto: Integer;
    IDProdutoEdicao: Integer;
    Nome: String;
    PalavraChave: String;
    Texto: String;
    TextoLink: String;
    TituloSite: String;
    IDAdministradorEdicao: Integer;
    IDAdministradorAprovado: Integer;
    IDFornecedor: Integer;
    IDDepartamento: Integer;
    IDCategoria: Integer;
    IDMarca: Integer;
    IDLinha: Integer;
    DataEdicao: TDateTime;
    DataAprovado: TDateTime;
    FlagExibe: Boolean;
    FlagSorteiaSku: Boolean;
    FlagAtiva: Boolean;
    Prioridade: Integer;
    PalavraChaveMarca: String;
    PrecoSkuDe: Double;
    PrecoSkuAte: Double;
    Ordenacao: String;
    TextoMarca: String;
    TextoCategoria: String;
    TextoDepartamento: String;
    CodigoReferencia: String;
    NomeCompleto: String;
    Skus: TepSKULista;
  end;

  TepProdutoLista = class(TepEntidadeLista)
  end;

  TepSKU = class(TepEntidade)
    IDSku: Integer;
    IDSkuEdicao: Integer;
    IDAdministradorEdicao: Integer;
    IDAdministradorAprovado: Integer;
    IDProduto: Integer;
    IDFreteModalTipo: Integer;
    FlagAtiva: Boolean;
    FlagKit: Boolean;
    Nome: String;
    Texto: String;
    PrecoAnterior: Double;
    PrecoVenda: Double;
    PrecoCusto: Double;
    Peso: Double;
    Altura: Double;
    Largura: Double;
    Comprimento: Double;
    PesoCubico: Double;
    DataPrevisaoChegada: TDateTime;
    DataCadastro: TDateTime;
    PesoReal: Double;
    AlturaReal: Double;
    LarguraReal: Double;
    ComprimentoReal: Double;
    CodigoReferencia: String;
    DepartamentoGerencial: String;
    SetorGerencial: String;
    IDSkuCondicaoComercial: Integer;
    FlagAtivaERP: Boolean;
    Produto: TepProduto;
    Ean13: String;
  end;

  TepSaldoSKU = class(TepEntidade)
    IdSku: Integer;
    IdEstoque: Integer;
    QuantidadeReservada: Integer;
    QuantidadeDisponivel: Integer;
    QuantidadeTotal: Integer;
  end;

  TepEstoque = class(TepEntidade)
    IdEstoque: Integer;
    IdEndereco: Integer;
    Nome: String;
    Sinal: Integer;
    FlagAtiva: Boolean;
    PrazoEntrega: Integer;
    Codigo: String;
  end;

  TepEstoqueLista = class(TepEntidadeLista)
  end;

  TepCliente = class(TepEntidade)
    IDCliente: Integer;
    UsuarioGuid: String;
    IDClienteEnderecoEntrega: Integer;
    IDAdministradorTelevenda: Integer;
    Sexo: String;
    Nome: String;
    Apelido: String;
    Email: String;
    TelefoneResidencial: String;
    TelefoneCelular: String;
    TelefoneComercial: String;
    Senha: String;
    CpfCnpj: String;
    Credito: Currency;
    Parceiro: String;
    Midia: String;
    Campanha: String;
    NumeroLogon: Integer;
    DataNascimento: TDateTime;
    DataCriacao: TDateTime;
    DataUltimoLogon: TDateTime;
    DataUltimaAtualizacao: TDateTime;
    FlagPj: Boolean;
    FlagAtiva: Boolean;
    FlagFraude: Boolean;
    FlagNews: Boolean;
    DataUltimaCompraEnviada: TDateTime;
    QuantidadeCompraEnviada: Integer;
    RazaoSocial: String;
    NomeFantasia: String;
    SobreNome: String;
    Site: String;
    InscricaoEstadual: String;
    FlagIsentoInscricaoEstadual: Boolean;
    FlagSMSNews: Boolean;
    Idade: Integer;
    Pais: String;
    Estado: String;
    Municipio: String;
    Identificador: String;
    Rua: String;
    Numero: String;
    Complemento: String;
    Bairro: String;
    Cep: String;
    PontoReferencia: String;
    TipoEndereco: String;
  end;

  TepClienteLista = class(TepEntidadeLista)
  end;

  TepFormaPagamento = class(TepEntidade)
    IDCompraFormaPagamento: Integer;
    IDFormaPagamento: Integer;
    IDCompra: Integer;
    IDVale: Integer;
    IDCompraFormaPagamentoStatus: Integer;
    QuantidadeParcelas: Integer;
    ValorComJuros: Currency;
    ValorJuros: Currency;
    CcNome: String;
    CcUltimos4Numeros: String;
    CcNumero: String;
    CcCodigo: String;
    CcAnoMes: String;
    CcAno: String;
    CcMes: String;
    FlagModoManual: Boolean;
    FlagAtiva: Boolean;
    Data: TDateTime;
    Rua: String;
    Numero: String;
    Complemento: String;
    Bairro: String;
    Municipio: String;
    Estado: String;
    Cep: String;
    Pais: String;
    Url: String;
    PontoReferencia: String;
    TipoEndereco: String;
    CcPrimeiros6Numeros: String;
    NomeFormaPagamento: String;
    TipoFormaPagamento: String;
  end;

  TepFormaPagamentoLista = class(TepEntidadeLista)
  end;

  TepCompraEntregaSku = class(TepEntidade)
    IDCompraEntregaSku: Integer;
    IDCompraEntregaSkuPai: Integer;
    IDDescontoCompreJunto: Integer;
    IDDescontoBrindeCausa: Integer;
    IDCompraEntrega: Integer;
    IDSku: Integer;
    IDEstoqueProvavel: Integer;
    ValorVendaUnidadeSemDesconto: Currency;
    ValorVendaUnidade: Currency;
    ValorCupomNominal: Currency;
    ValorVendaUnidadeMenosCupomNominal: Currency;
    ValorFreteComDesconto: Currency;
    ValorFrete: Currency;
    Servicos: String;
    CodigoReferenciaSku: String;
  end;

  TepCompraEntregaSkuLista = class(TepEntidadeLista)
  end;

  TepFreteTipo = class(TepEntidade)
    IDFreteEntregaTipo: Integer;
    Nome: String;
    Texto: String;
  end;

  TepFrete = class(TepEntidade)
    IDFrete: Integer;
    IDFreteEntregaTipo: Integer;
    IDFreteModalTipo: Integer;
    Nome: String;
    Texto: String;
    FlagAtiva: Boolean;
    PrazoEntrega: Integer;
    FreteTipo: TepFreteTipo;
  end;

  TepEnderecoEntrega = class(TepEntidade)
    IDCompraEnderecoEntrega: Integer;
    IDCompra: Integer;
    NomeDestinatario: String;
    TelefoneResidencial: String;
    TelefoneCelular: String;
    TelefoneComercial: String;
    Rua: String;
    Numero: String;
    Complemento: String;
    Bairro: String;
    Municipio: String;
    Estado: String;
    Cep: String;
    Pais: String;
    PontoReferencia: String;
    Identificacao: String;
    Tipo: String;
  end;

  TepEnderecoEntregaLista = class(TepEntidadeLista)
  end;

  TepEntrega = class(TepEntidadeLista)
    IDCompraEntrega: Integer;
    IDCompra: Integer;
    IDFreteEntregaTipo: Integer;
    IDCompraEntregaStatus: String;
    IDentificadorFrete: String;
    IDAdministradorStatus: Integer;
    DataSaida: TDateTime;
    DataPrevisao: TDateTime;
    DataEntrega: TDateTime;
    DataStatus: TDateTime;
    ObsTransportadora: String;
    PrazoEntregaMaisDisponibilidade: Integer;
    PrazoEstoque: Integer;
    IDFrete: Integer;
    IDFreteModalTipo: Integer;
    Nome: String;
    Texto: String;
    FlagAtiva: Boolean;
    PrazoEntrega: Integer;
    CompraEntregaSkuLista: TepCompraEntregaSkuLista;
    Frete: TepFrete;
  end;

  TepEntregaLista = class(TepEntidadeLista)
  end;

  TepCompra = class(TepEntidade)
    IDCompra: Integer;
    IDCliente: Integer;
    IDAdministradorTelevenda: Integer;
    IDAfiliado: Integer;
    IDListaDeCompra: Integer;
    Midia: String;
    Parceiro: String;
    Campanha: String;
    PalavraChave: String;
    Origem: String;
    Data: TDateTime;
    ValorTotalComDesconto: Currency;
    ValorTotalComDescontoDevido: Currency;
    TesteAB: String;
    FlagAtiva: Boolean;
    IpCliente: String;
    AfiliadoLancamentos: String;
    Descontos: Currency;
    IDCompraEnderecoEntrega: Integer;
    NomeDestinatario: String;
    TelefoneResidencial: String;
    TelefoneCelular: String;
    TelefoneComercial: String;
    Rua: String;
    Numero: String;
    Complemento: String;
    Bairro: String;
    Municipio: String;
    Estado: String;
    Cep: String;
    Pais: String;
    PontoReferencia: String;
    Identificacao: String;
    Tipo: String;
    EnderecoEntregaLista: TepEnderecoEntregaLista;
    EntregaLista: TepEntregaLista;
    FormaPagamentoLista: TepFormaPagamentoLista;
    Cliente: TepCliente;
  end;

  TepCompraLista = class(TepEntidadeLista)
  end;

implementation

end.
