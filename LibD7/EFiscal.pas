unit EFiscal;
{
  By: SERVIEMA Serviços de Informática, tels. (0xx21) 3242-0409/81723856
  Data: 03/02/2004
  Descrição: Componente desenvolvido para Impressoras Ficais ECFs
  Cliente: Igmam Empreendimentos LDTA

  Modelos de ECFs conhecidas até o momento:
      Sweda03, Sweda10, NCR2x, NCR1x, NCR7141,  Urano2EFE, Urano1EFC, Urano2EFC,
      Urano1FIT, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41, ZanthusIZ11,
      ZanthusIZ10, Schalter3D, Schalter2S, Trends10E, Dataregis, BematechMP40,
      BematechMP20, Procomp_2011F
}

interface

uses
   dbiprocs, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, math,
   Dialogs, registry, dbtables, WinTypes, WinProcs, StdCtrls;
const
   { mensagens de erro que sao atribuidas ao parametro MsgError do evento OnError,
     a fim de serem manipuladas pelo usario final. }

   FISCAL_ITEM_COD         = '#COD#=';
   FISCAL_ITEM_DESCRIP     = '#DESC#=';
   FISCAL_ITEM_ALIQ        = '#ALIQ#=';
   FISCAL_ITEM_TIPO_QTY    = '#TQTY#=';
   FISCAL_ITEM_QTY         = '#QTY#=';
   FISCAL_ITEM_CASA_DEC    = '#CDEC#=';
   FISCAL_ITEM_VALOR_UNIT  = '#VUNIT#=';
   FISCAL_ITEM_TIPO_DESC   = '#TDESC#=';
   FISCAL_ITEM_VALOR_DESC  = '#VDESC#=';
   FISCAL_ITEM_VALOR_TOTAL = '#VTOT#=';
   FISCAL_ITEM_POSITION    = '#IPOS#=';
   FISCAL_ITEM_PONTO_DEC   = '#PDEC#=';
   FISCAL_ITEM_TP_ITEM     = '#TPIT#=';


   FISCAL_FECHA_NOTA_ACRES_DESC      = '#ACDESC#=';
   FISCAL_FECHA_NOTA_TIPO_ACRES_DESC = '#TACDESC#=';
   FISCAL_FECHA_NOTA_VALOR_ACRES_DESC= '#VACDESC#=';
   FISCAL_FECHA_NOTA_VALOR_DESCO     = '#VDESCO#=';
   FISCAL_FECHA_NOTA_VALOR_PAGO      = '#VPGTO#=';

   FISCAL_FECHA_NOTA_TIPO_PAGAMENTO = '#TPAG#=';
   FISCAL_FECHA_NOTA_MSG            = '#FMSG#=';

   FISCAL_FECHA_NOTA_IDX_PAGAMENTO = '#IDPGTO#=';

   FISCAL_NUM_ALIQUOTAS_FIXAS       = 6;

   Mensagens: array[1..20] of string= (
               'Erro de Comunicação FISICA com a SERIAL.',
               'Erro no envio dos Parâmetros.',
               'Erro na comunicação com a SERIAL.',
               'Fim de papel!',
               'Pouco Papel!',
               'Erro no RTC',
               'Impressora com problemas!',
               'Comando invalido',
               'Comando inexistente',
               'Cupom fiscal aberto!',
               'Numero de parametros invalido -> Impressora!',
               'Tipo do parametro invalido -> Impressora!',
               'Memoria Fiscal Lotada!',
               'Erro na RAM',
               'Aliquota Nao Programada',
               'Capacidade de aliquotas esgotada',
               'Cancelamento nao permitido',
               'CGC/IE nao programados',
               'Comando nao executado!(NAK)',
               'Erro Desconhecido');

    MsgSchalter: array[1..73] of string= (
                 '01:Erro de checksum',
                 '02:Timeout RX',
                 '03:Memória insuficiente',
                 '04:Impressora fora de linha ou desligada',
                 '10:Erro de sobreposição',
                 '11:Erro de paridade',
                 '12:Erro de sobreposição e paridade',
                 '13:Erro de formato',
                 '14:Erro de sobreposição e formato',
                 '15:Erro de paridade e sobreposição',             //10
                 '16:Erro de sobreposição, paridade e formato',
                 '65:Em venda',
                 '66:Limite de cabeçalho alcançado',
                 '68:Cabeçalho impresso',
                 '69:Não começou venda',
                 '70:Valor inválido',
                 '73:Valor a menor',
                 '74:Valor a maior',
                 '78:Número máximo de Reduções Z alcançado',
                 '79:Erro de comunicação',                         //20
                 '80:Palavra reservada',
                 '81:Papel próximo do fim',
                 '82:Data não localizada',
                 '84:Erro de memória fiscal. Necessita INTERVENÇÃO TÉCNICA',
                 '85:Perda da RAM. Necessita INTERVENÇÃO TÉCNICA',
                 '86:Não houve pagamento',
                 '87:Cupom já totalizado',
                 '88:Não pode cancelar venda',
                 '89:Comando não completo',
                 '90:Cupom Fiscal aberto',                         //30
                 '91:Não há cupom a cancelar',
                 '92:Tabela de taxa não inicializada',
                 '94:Seleção de taxa inválida',
                 '95:Cancelamento inválido',
                 '96:Nada a retificar',
                 '97:Redução não localizada',
                 '98:Cabeçalho não carregado',
                 '99:Impressora em intervenção técnica',
                 '100:Impressora em período de venda',
                 '101:Somente com intervenção técnica',            //40
                 '102:Desconto inválido',
                 '103:Limite de linhas alcançado',
                 '104:Somente após o total',
                 '105:Dados inválidos',
                 '106:Alteração de taxa não disponível',
                 '107:Comando inválido',
                 '108:Não houve o fechamento do dia.Execute REDUÇÃO Z.',
                 '109:Erro irrecuperável',
                 '110:Alteração inválida',
                 '111:Data já alterada',                           //50
                 '112:Alíquota não carregada',
                 '113:Fechamento diário não realizado.Execute REDUÇÃO Z.',
                 '114:Abertura do dia inválida',
                 '115:Fechamento já realizado',
                 '116:Ajuste somente de +/- 1 hora',
                 '117:Acréscimo inválido',
                 '118:Pagamento incompleto',
                 '121:Erro de gravação na memória fiscal.Necessita INTERVENÇÃO TÉCNICA',
                 '126:Comando fora de seqüência',
                 '127:Autenticação sem papel',                     //60
                 '132:Queda de energia',
                 '133:Data inválida',
                 '134:Item fora da faixa',
                 '135:Item não vendido',
                 '136:Parâmetro errado',
                 '137:Limite de valor ultrapassado',
                 '606:Não foi possível setar os parâmetros configuráveis da porta serial',
                 '707:Não foi possível programar os parâmetros setados referentes à porta serial',
                 '808:Não foi possível limpar a fila de transmissão',
                 '809:Não foi possível limpar a fila de recepção', //70
                 '909:Ocorreu um erro na programação interna dos timeouts da porta serial',
                 '1010:A porta serial requisitada está bloqueada por outro aplicativo',
                 '2323:Ocorreu um problema desconhecido na recepção de retorno simples da impressora');

type
  TRegTribReducaoZ = record
    Codigo: String;
    ValorAcumulado: Currency;
  end;

  TRegDadosReducaoZ = record
    AMovDate                  : TDateTime;
    ANumeroSerie              : String;
    ANumeroLoja               : Integer;
    ANumeroECF                : Integer;
    ANumReducaoZ              : Integer;
    ACOOInicial               : Integer;
    ACOOFinal                 : Integer;
    ANumCancelamentos         : Integer;
    AValCancelamentos         : Currency;
    AValDescontos             : Currency;
    AGTInicial                : Currency;
    AGTFinal                  : Currency;
    ASubstituicaoTrib         : Currency;
    AIsencao                  : Currency;
    ANaoTributavel            : Currency;
    AAliquota                 : array of Double;
    ABaseCalculo              : array of Currency;
    AValImposto               : array of Currency;
    ////////////////////////////////////////////////////////////////////////////
    // NOVOS CAMPOS PARA O PAF-ECF
    ATipoECF                  : String;
    AMarcaECF                 : String;
    AModeloECF                : String;
    AVersaoSBECF              : String;
    ADataInstalacaoSBECF      : TDateTime;
    AMFAdicional              : String;
    AContadorReducaoZ         : Integer;
    AContadorOrdemOperacao    : Integer;
    AContadorReinicioOperacao : Integer;
    ANumeroUsuarioECF         : Integer;
    AIncideISSQN              : Boolean;
    ADataEmissao              : TDateTime;
    ATribReducaoZList         : array of TRegTribReducaoZ;
  end;

  TRegTipo60Mestre = record
    dDataEmissao : TDateTime;
    sNumeroSerie,
    sModelo: String;
    nContInicio,
    nContFim,
    nContReducaoZ,
    nContReinicio,
    nNumeroOrdem : Integer;
    nVendaBruta,
    nTotalGeral : Double;
  end;

  TRegTipo60Analitico = record
    dDataEmissao : TDateTime;
    sNumeroSerie,
    sSitTributaria: String;
    nVlrAcumTotPar : Double;
  end;

  TVetTipo60Analitico = Array Of TRegTipo60Analitico;


  { Excecao que acusa uma entrada invalida por parte do usuario.
    Pode ser verificada em tempo de compilacao. }
  EInvalidEntry = Class(Exception);

  { Armazena as aliquotas programadas na impressora fiscal }
  TAliquota = array[0..16] of Single;
  TForma = array[0..20] of String;

  TECFModelo = (None, Sweda03, Sweda10,
      NCR2x, NCR1x, NCR7141,
      Urano2EFE, Urano1EFC, Urano2EFC, Urano1FIT,
      Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41, ZanthusIZ11, ZanthusIZ10,
      Schalter3D, Schalter2S,
      Trends10E,
      Dataregis, BematechMP40, BematechMP20, BematechTermica, Procomp_2011, AFRAC, DarumaMatr, DarumaTerm, Elgin, SCFI);
   { =======================  SWEDA  ================== }
   PSweda_AbrePortaSerial = function : Integer; StdCall;
   PSweda_FechaPortaSerial = function : Integer; StdCall;
   PSweda_MsgLog = function (Conteudo:Pchar):Integer; StdCall;
   PSweda_AberturaDoDia = function ( ValorInicioDia:String ; Pagto:String): Integer; StdCall;
   PSweda_RetornoImpressoraMFD = function (Var ACK: Integer; Var ST1: Integer; Var ST2: Integer; Var ST3: Integer ): Integer; StdCall;
   PSweda_RetornaTipoEcf = function (Tipo:String): Integer; StdCall;
   PSweda_VersaoDll = function (Versao:String): Integer; StdCall;
   PSweda_VersaoFirmware = function (Versao:String): Integer; StdCall;
   PSweda_VersaoFirmwareMFD = function (Versao:String): Integer; StdCall;
   PSweda_NumeroSerie = function (NumeroSerie:String): Integer; StdCall;
   PSweda_NumeroSerieMFD = function (NumeroSerie:String): Integer; StdCall;
   PSweda_NumeroSerieMemoriaMFD = function (NumeroSerie:String): Integer; StdCall;
   PSweda_Registry_AplMensagem1 = function (Valor : String): Integer; StdCall;
   PSweda_Registry_AplMensagem2 = function (Valor : String): Integer; StdCall;
   PSweda_VerificaFormasPagamentoMFD = function (FormasPag: String): Integer; StdCall;
   PSweda_MarcaModeloTipoImpressoraMFD = function (Marca:String; Modelo:String; Tipo:String): Integer; StdCall;
   PSweda_DataHoraGravacaoUsuarioSWBasicoMFAdicional = function (DataUsuario:String; DataSoftware:String; Adicional:String): Integer; StdCall;
   PSweda_CGC_IE = function (CGC:String; IE:String): Integer;StdCall;
   PSweda_CNPJMFD = function (CGC:String): Integer;StdCall;
   PSweda_InscricaoEstadualMFD = function(IE:String): Integer;StdCall;
   PSweda_InscricaoMunicipalMFD = function (IM:String): Integer;StdCall;
   PSweda_NumeroSubstituicoesProprietario = function (Proprietario:String): Integer;StdCall;
   PSweda_SimboloMoeda = function(Moeda:String): Integer;StdCall;
   PSweda_ClicheProprietario = function(Linhas:pchar): Integer;StdCall;
   PSweda_NumeroLoja = function (Loja:String): Integer;StdCall;
   PSweda_NumeroCaixa = function (Caixa:String):integer;StdCall;
   PSweda_DataHoraImpressora = function(Data:String; Hora:String):integer;StdCall;
   PSweda_LerAliquotasComIndice = function (Tribut:Pchar ):integer;StdCall;
   PSweda_VerificaTotalizadoresNaoFiscaisMFD = function(Nome: Pchar ):integer;StdCall;
   PSweda_VerificaModoOperacao = function (Modo:String):integer;StdCall;
   PSweda_VerificaImpressoraLigada = function : Integer; StdCall;
   PSweda_VerificaDescricaoFormasPagamento = function (Pagtos:Pchar ): Integer; StdCall;
   PSweda_VerificaTotalizadoresNaoFiscaisEx = function (Nomes:Pchar ): Integer; StdCall;
   PSweda_VerificaRelatorioGerencialProgMFD = function (Nomes:Pchar ): Integer; StdCall;
   PSweda_CasasDecimaisProgramada = function (Unitario:String; Quantidade:String ): Integer; StdCall;
   PSweda_VerificaTruncamento = function (Status:String ): Integer; StdCall;
   PSweda_VerificaEstadoImpressoraMFD = function (ACK: Integer;  ST1: Integer;  ST2: Integer; ST3: Integer ): Integer;StdCall;
   PSweda_VerificaTotalizadoresParciais = function (Totaliz : String ): Integer; StdCall;
   PSweda_RetornoAliquotas = function (Aliquotas:Pchar ): Integer; StdCall;
   PSweda_ImprimeCopiaCheque = function : Integer; StdCall;
   PSweda_CancelaImpressaoCheque = function : Integer; StdCall;
   PSweda_LeituraX = function : Integer; StdCall;
   PSweda_LeituraMemoriaFiscalData = function ( cDatai: String; cDataf: String ): Integer; StdCall;
   PSweda_LeituraMemoriaFiscalDataMFD = function ( cDatai: String; cDataf: String; tipo:String ): Integer; StdCall;
   PSweda_LeituraMemoriaFiscalReducao = function ( cCRZi: String; cCRZf: String ): Integer; StdCall;
   PSweda_LeituraMemoriaFiscalReducaoMFD = function ( cCRZi: String; cCRZf: String; tipo:String ): Integer; StdCall;
   PSweda_AbreCupom = function ( CGC_CPF: String ): Integer; StdCall;
   PSweda_AbreCupomMFD = function ( CGC_CPF, Nome, Endereco: String ): Integer; StdCall;
   PSweda_IdentificaConsumidor = function ( CGC_CPF, Nome, Endereco: String ): Integer; StdCall;
   PSweda_AumentaDescricaoItem = function ( nome: String ): Integer; StdCall;
   PSweda_UsaUnidadeMedida = function ( unidade: String ):Integer; StdCall;
   PSweda_VendeItem = function ( Codigo: String; Descricao: String; Aliquota: String; TipoQuantidade: String; Quantidade: String; CasasDecimais: Integer; ValorUnitario: String; TipoDesconto: String; Desconto: String): Integer; StdCall;
   PSweda_VendeItemTresDecimais = function ( Codigo: String; Descricao: String; Aliquota: String; Quantidade: String; ValorUnitario: String; TipoDesconto: String; Taxa: String): Integer; StdCall;
   PSweda_VendeItemDepartamento = function ( Codigo: String; Descricao: String; Aliquota: String; Quantidade: String; ValorUnitario: String; Acrescimo: String; Desconto: String; IndiceDepto: String; UM:String): Integer; StdCall;
   PSweda_DescontoSobreItemVendido = function (Item:String; TipoDesc:String; ValorDesc:String ): Integer; StdCall;
   PSweda_AcrescimoDescontoItemMFD = function (Item:String; TipoDescAcres:String; TipoDesc:String; ValorDesc:String ): Integer; StdCall;
   PSweda_CancelaItemAnterior = function : Integer; StdCall;
   PSweda_CancelaItemGenerico = function ( NumeroItem: String ): Integer; StdCall;
   PSweda_CancelaAcrescimoDescontoItemMFD = function ( Tipo: String ; Item:String ): Integer; StdCall;
   PSweda_IniciaFechamentoCupom = function (DescAcres:String ; TipoDescontoACres:String; Valor:String): Integer; StdCall;
   PSweda_IniciaFechamentoCupomMFD = function (DescAcres:String ; TipoDescontoACres:String; ValorAcrescimo:String; ValorDesconto:String): Integer; StdCall;
   PSweda_AcrescimoDescontoSubtotalMFD = function (DescAcres:String ; TipoDescontoACres:String; Valor:String): Integer; StdCall;
   PSweda_TotalizaCupomMFD = function : Integer; StdCall;
   PSweda_EfetuaFormaPagamento = function ( Pagto:String;Valor:String ): Integer; StdCall;
   PSweda_EfetuaFormaPagamentoDescricaoForma = function ( Pagto:String;Valor:String ;Texto:String): Integer; StdCall;
   PSweda_EfetuaFormaPagamentoMFD = function( Pagto:String;Valor:String ;Parcelas:String; Texto:String): Integer; StdCall;
   PSweda_TerminaFechamentoCupom = function (Texto:String): Integer; StdCall;
   PSweda_FechaCupom = function ( FormaPagamento: String; AcrescimoDesconto: String; TipoAcrescimoDesconto: String; ValorAcrescimoDesconto: String; ValorPago: String; Mensagem: String): Integer; StdCall;
   PSweda_FechaCupomResumido = function ( FormaPagamento: String; Mensagem: String): Integer; StdCall;
   PSweda_AtivaDesativaCorteProximoMFD = function (tipocorte:Integer): Integer; StdCall;
   PSweda_CupomAdicionalMFD = function : Integer; StdCall;
   PSweda_ProgramaArredondamento = function : Integer; StdCall;
   PSweda_ProgramaTruncamento = function : Integer; StdCall;
   PSweda_EstornoFormasPagamento = function (Oritem:String; Destino:String; Valor:String): Integer; StdCall;
   PSweda_CancelaCupom = function : Integer; StdCall;
   PSweda_CancelaCupomMFD = function ( CGC_CPF, Nome, Endereco: String ): Integer; StdCall;
   PSweda_CancelaAcrescimoDescontoSubtotalMFD = function ( Tipo: String ): Integer; StdCall;
   PSweda_IniciaModoTEF = function :Integer;StdCall;
   PSweda_FinalizaModoTEF = function :Integer;StdCall;
   PSweda_AbreComprovanteNaoFiscalVinculado = function ( FormaPagamento: String; Valor: String; NumeroCupom: String ): Integer; StdCall;
   PSweda_AbreComprovanteNaoFiscalVinculadoMFD = function ( FormaPagamento: String; Valor: String; NumeroCupom: String ; CPF:String; Nome:String; Endereco: String): Integer; StdCall;
   PSweda_UsaComprovanteNaoFiscalVinculadoTEF = function ( Texto: String ): Integer; StdCall;
   PSweda_UsaComprovanteNaoFiscalVinculado = function ( Texto: String ): Integer; StdCall;
   PSweda_FechaComprovanteNaoFiscalVinculado = function : Integer; StdCall;
   PSweda_SegundaViaNaoFiscalVinculadoMFD = function : Integer; StdCall;
   PSweda_ReimpressaoNaoFiscalVinculadoMFD = function : Integer; StdCall;
   PSweda_EstornoNaoFiscalVinculadoMFD = function (CPF:String ;NomeConsumidor:String ;EnderecoCOnsumidor:String): Integer; StdCall;
   PSweda_TEF_ImprimirRespostaCartao = function (NomeArquivo:String; Pagto:String; Trava:String; Valor:String): Integer; StdCall;
   PSweda_TEF_FechaRelatorio = function : Integer; StdCall;
   PSweda_RelatorioGerencialTEF = function ( Texto: String ): Integer; StdCall;
   PSweda_UsaRelatorioGerencialMFDTEF = function ( Texto: String ): Integer; StdCall;
   PSweda_Suprimento = function ( ValorInicioDia:String ; Pagto:String): Integer; StdCall;
   PSweda_Sangria = function ( ValorInicioDia:String ): Integer; StdCall;
   PSweda_AbreRecebimentoNaoFiscalMFD = function ( CGC_CPF, Nome, Endereco: String ): Integer; StdCall;
   PSweda_AbreRecebimentoNaoFiscal = function (Item:String; TipoDesc:String; AcresDesconto:String; ValorDesc:String ;ValorReceb:String; texto:String): Integer; StdCall;
   PSweda_RecebimentoNaoFiscal = function ( Totalizador:String; Valor:String ; Pagto:String): Integer; StdCall;
   PSweda_EfetuaRecebimentoNaoFiscalMFD = function ( Totalizador:String; Valor:String ): Integer; StdCall;
   PSweda_CancelaItemNaoFiscalMFD = function ( NumeroItem: String ): Integer; StdCall;
   PSweda_AcrescimoItemNaoFiscalMFD = function (Item:String; TipoDescAcres:String; TipoDesc:String; ValorDesc:String ): Integer; StdCall;
   PSweda_AcrescimoDescontoSubtotalRecebimentoMFD = function (DescAcres:String ; TipoDescontoACres:String; Valor:String): Integer; StdCall;
   PSweda_TotalizaRecebimentoMFD = function : Integer; StdCall;
   PSweda_IniciaFechamentoRecebimentoNaoFiscalMFD = function (DescAcres:String ; TipoDescontoACres:String; ValorAcrescimo:String; ValorDesconto:String): Integer; StdCall;
   PSweda_FechaRecebimentoNaoFiscalMFD = function (Texto:String): Integer; StdCall;
   PSweda_CancelaRecebimentoNaoFiscalMFD = function ( CGC_CPF, Nome, Endereco: String ): Integer; StdCall;
   PSweda_EfetuaFormaPagamentoNaoFiscal = function ( Pagto:String;Valor:String; Texto:String ): Integer; StdCall;
   PSweda_AbreRelatorioGerencial = function : Integer; StdCall;
   PSweda_AbreRelatorioGerencialMFD = function (Indice:String): Integer; StdCall;
   PSweda_EnviarTextoCNF = function ( nome: String ): Integer; StdCall;
   PSweda_RelatorioGerencial = function ( nome: String ): Integer; StdCall;
   PSweda_UsaRelatorioGerencialMFD = function ( nome: String ): Integer; StdCall;
   PSweda_FechaRelatorioGerencial = function : Integer; StdCall;
   PSweda_FechamentoDoDia = function : Integer; StdCall;
   PSweda_ReducaoZ = function ( cData: String; cHora: String ): Integer; StdCall;
   PSweda_Autenticacao = function : Integer; StdCall;
   PSweda_AutenticacaoMFD = function (Linha: String; Texto:String): Integer; StdCall;
   PSweda_AutenticacaoStr = function (Texto:String): Integer; StdCall;
   PSweda_VerificaDocAutenticacao = function : Integer; StdCall;
   PSweda_AcionaGaveta = function : Integer; StdCall;
   PSweda_VerificaEstadoGaveta = function (Var Estado:Integer): Integer; StdCall;
   PSweda_VerificaEstadoGavetaStr = function (Var Estado:String): Integer; StdCall;
   PSweda_ProgramaMoedaSingular = function (Nome:String):integer;StdCall;
   PSweda_ProgramaMoedaPlural = function (Nome:String):integer;StdCall;
   PSweda_IncluiCidadeFavorecido = function (Cidade:String; Favorecido:String):integer;StdCall;
   PSweda_VerificaStatusCheque = function (Var Estado:Integer): Integer; StdCall;
   PSweda_VerificaStatusChequeStr = function (Var Estado:String): Integer; StdCall;
   PSweda_ImprimeCheque = function (Banco:String; Valor:String;Favorecido:String;Cidade:String; Data:String; Texto:String):integer;StdCall;
   PSweda_ImprimeChequeMFD = function (Banco:String; Valor:String;Favorecido:String;Cidade:String; Data:String; Texto:String; Verso:String):integer;StdCall;
   PSweda_LeituraChequeMFD = function (CMC7: String): Integer; StdCall;
   PSweda_LeituraLeiautesCheques = function : Integer; StdCall;
   PSweda_TipoUltimoDocumento = function (Tipo:String ): Integer; StdCall;
   PSweda_SubTotal = function (Subt:String ): Integer; StdCall;
   PSweda_SubTotalComprovanteNaoFiscalMFD = function (Subt:String ): Integer; StdCall;
   PSweda_ValorPagoUltimoCupom = function (Valor:String ): Integer; StdCall;
   PSweda_NumeroCupom = function (COO:String ): Integer; StdCall;
   PSweda_VerificaFormasPagamento = function (Texto:Pchar ): Integer; StdCall;
   PSweda_TotaisVenda = function (Texto:Pchar ): Integer; StdCall;
   PSweda_ValorAcrescimosUltimoCupom = function (Valor:String ): Integer; StdCall;
   PSweda_ValorDescontosUltimoCupom = function (Valor:String ): Integer; StdCall;
   PSweda_ValorCancelamentosUltimoCupom = function (Valor:String ): Integer; StdCall;
   PSweda_ValorCancelamentosUltimoCupomISS = function (Valor:String ): Integer; StdCall;
   PSweda_Acrescimos = function (Valor:String ): Integer; StdCall;
   PSweda_Descontos = function (Valor:String ): Integer; StdCall;
   PSweda_VerificaRecebimentoNaoFiscal = function (Texto:String ): Integer; StdCall;
   PSweda_VerificaRecebimentoNaoFiscalMFD = function (Texto:String ): Integer; StdCall;
   PSweda_Cancelamentos = function (Texto:String ): Integer; StdCall;
   PSweda_GrandeTotal = function (Texto:String ): Integer; StdCall;
   PSweda_VendaBruta = function (Texto:String ): Integer; StdCall;
   PSweda_RetornaAcrescimoNF = function (Texto:String ): Integer; StdCall;
   PSweda_RetornaDescontoNF = function (Texto:String ): Integer; StdCall;
   PSweda_RetornaCancelamentoNF = function (Texto:String ): Integer; StdCall;
   PSweda_RetornaTroco = function (Texto:String ): Integer; StdCall;
   PSweda_NumeroIntervencoes = function (Valor:String ): Integer; StdCall;
   PSweda_ContadorCupomFiscalMFD = function (Valor: String ): Integer; StdCall;
   PSweda_NumeroCuponsCancelados = function (Valor: String ): Integer; StdCall;
   PSweda_NumeroOperacoesNaoFiscais = function (Valor: String ): Integer; StdCall;
   PSweda_ContadorComprovantesCreditoMFD = function (Valor:String ): Integer; StdCall;
   PSweda_ComprovantesNaoFiscaisNaoEmitidosMFD = function (Valor:String ): Integer; StdCall;
   PSweda_ContadorOperacoesNaoFiscaisCanceladasMFD = function (Valor:String ): Integer; StdCall;
   PSweda_ContadorFitaDetalheMFD = function (Valor:String ): Integer; StdCall;
   PSweda_ContadorRelatoriosGerenciaisMFD = function (Valor:String ): Integer; StdCall;
   PSweda_NumeroReducoes = function (Valor:String ): Integer; StdCall;
   PSweda_RetornaCOO = function (Valor:String): Integer; StdCall;
   PSweda_COO = function (ValorIni:String;Valor:String ): Integer; StdCall;
   PSweda_FlagsFiscais = function (Var Valor:Integer ): Integer; StdCall;
   PSweda_VerificaEstadoImpressora = function ( var ACK: Integer;  var ST1: Integer;  var ST2: Integer ): Integer;StdCall;
   PSweda_RetornoImpressora = function ( var ACK: Integer;  var ST1: Integer;  var ST2: Integer ): Integer;StdCall;
   PSweda_VerificaTipoImpressora = function ( var Tipo: Integer ): Integer;StdCall;
   PSweda_VerificaIndiceAliquotasIss = function ( IndiceAliq: PChar ): Integer;StdCall;
   PSweda_StatusEstendidoMFD = function ( var Tipo: Integer ): Integer;StdCall;
   PSweda_StatusCupomFiscal = function ( Tipo: String): Integer;StdCall;
   PSweda_StatusRelatorioGerencial = function ( Tipo: String): Integer;StdCall;
   PSweda_StatusComprovanteNaoFiscalVinculado = function ( Tipo: String): Integer;StdCall;
   PSweda_StatusComprovanteNaoFiscalNaoVinculado = function ( Tipo: String): Integer;StdCall;
   PSweda_VerificaModeloEcf = function : Integer;StdCall;
   PSweda_VerificaHorarioVerao = function ( Tipo: String): Integer;StdCall;
   PSweda_VerificaZPendente = function ( Tipo: String ): Integer;StdCall;
   PSweda_VerificaDiaAberto = function ( Tipo: String ): Integer;StdCall;
   PSweda_VerificaFlagCorteMFD = function ( Tipo: String ): Integer;StdCall;
   PSweda_GeraRFD = function ( Texto: Pchar ): Integer;StdCall;
   PSweda_PercentualLivreMFD = function (Livre:String): Integer;StdCall;
   PSweda_TotalLivreMFD = function (Livre:String): Integer;StdCall;
   PSweda_ReducoesRestantesMFD = function (Livre:String): Integer;StdCall;
   PSweda_TamanhoTotalMFD = function (Livre:String): Integer;StdCall;
   PSweda_TempoRestanteComprovanteMFD = function (Livre:String): Integer;StdCall;
   PSweda_DataMovimento = function (Livre:String): Integer;StdCall;
   PSweda_DataHoraUltimoDocumentoMFD = function (DAtaHora:String): Integer;StdCall;
   PSweda_DataHoraReducao = function (Data:String; Hora:String): Integer;StdCall;
   PSweda_DataMovimentoUltimaReducaoMFD = function (Data:String): Integer;StdCall;
   PSweda_InicioFimCOOsMFD = function (Inicial:Pchar; Final:Pchar): Integer;StdCall;
   PSweda_InicioFimGTsMFD = function (Inicial:String; Final:String): Integer;StdCall;
   PSweda_GrandeTotalUltimaReducaoMFD = function (GT:String): Integer;StdCall;
   PSweda_DadosUltimaReducaoMFD = function (Texto:PChar): Integer;StdCall;
   PSweda_MapaResumoMFD = function :Integer;StdCall;
   PSweda_ArquivoSintegra2004MFD = function ( itipo: Integer; cArquivo: String;  cMes: String; cAno: String; cMesf: String; cAnof: String; cRazaoSocial: String; cEndereco: String; cNumero: String; cComplemento: String; cBairro: String; cCidade: String; cUF: String; cCEP: String; cTelefone: String; cFax: String; cContato: String): Integer; StdCall;
   PSweda_RelatorioSintegraMFD = function (TipoRel:Integer; Arquivo:String;MesInic:String;AnoInic:String;Razao:String;Endereco:String; numero:String;Complemento:String;Bairro:String;Cidade:String; Cep:String; telefone:String; fax:String; Contato:string): Integer;StdCall;
   PSweda_RegistrosTipo60 = function : Integer;StdCall;
   PSweda_RelatorioTipo60Mestre = function : Integer;StdCall;
   PSweda_RelatorioTipo60Analitico = function : Integer;StdCall;
   PSweda_RelatorioTipo60AnaliticoMFD = function : Integer;StdCall;
   PSweda_LeituraXSerial = function : Integer;StdCall;
   PSweda_LeituraMemoriaFiscalSerialData = function ( cDatai: String; cDataf: String ): Integer; StdCall;
   PSweda_LeituraMemoriaFiscalSerialDataMFD = function ( cDatai: String; cDataf: String; tipo:String ): Integer; StdCall;
   PSweda_LeituraMemoriaFiscalSerialReducao = function ( cCRZi: String; cCRZf: String ): Integer; StdCall;
   PSweda_LeituraMemoriaFiscalSerialReducaoMFD = function ( cCRZi: String; cCRZf: String; tipo:String ): Integer; StdCall;
   PSweda_DownloadSB = function ( nome: String ): Integer; StdCall;
   PSweda_DownloadMF = function ( nome: String ): Integer; StdCall;
   PSweda_DownloadMFD = function ( nome: String ; tipo: String; inicio: String ; fim: String ; usuario: String  ): Integer; StdCall;
   PSweda_FormatoDadosMFD = function (Origem:String; Destino:String; Formato:String;Tipo:String; Inicio:String; Fim:String; Usuario:String): Integer; StdCall;
   PSweda_CapturaDocumentos = function (Tipo:String; Destino:String; Inicio:String; Fim:String; Exibe:String): Integer; StdCall;
   PSweda_TabelaMercadoriasServicos3404 = function (Arquivo:String; Inicio:String; Fim:String): Integer; StdCall;
   PSweda_ReproduzirMemoriaFiscalMFD = function (Tipo:String; Inicio:String; Fim:String; Binario:String; Arquivo:String ): Integer; StdCall;
   PSweda_GeraRegistrosCAT52MFD = function (Binario:String; Data:String ): Integer; StdCall;
   PSweda_ConfiguraCodigoBarrasMFD = function ( Altura:String; largura:String; posicao:String; fonte:String; Margem:String): Integer; StdCall;
   PSweda_CodigoBarrasCODABARMFD = function ( Codigo :String): Integer; StdCall;
   PSweda_CodigoBarrasCODE39MFD = function ( Codigo :String): Integer; StdCall;
   PSweda_CodigoBarrasEAN13MFD = function ( Codigo :String): Integer; StdCall;
   PSweda_CodigoBarrasEAN8MFD = function ( Codigo :String): Integer; StdCall;
   PSweda_CodigoBarrasITFMFD = function ( Codigo :String): Integer; StdCall;
   PSweda_CodigoBarrasUPCAMFD = function ( Codigo :String): Integer; StdCall;
   PSweda_CodigoBarrasUPCEMFD = function ( Codigo :String): Integer; StdCall;



{**TODO
   }
   { =======================  NCR ================== }
   PNCR_SendCmd = function(cmd: string; rsp: pointer; rsplen: longint): longint; stdcall;
   PNCR_SetComPort = function(porta: integer): longint; stdcall;
   { =======================  Urano2EFE  ================== }
   PUrano2EFE_LeituraMF = function(tipo, dtini, dtfinal, redini, redfinal: string): integer; stdcall;
   PUrano2EFE_IniciaImpressora = function(com: PChar): integer; stdcall;
   PUrano2EFE_FinalizaImpressora = function: integer; stdcall;
   PUrano2EFE_ImprimeCabecalho = function: integer; stdcall;
   PUrano2EFE_VendaItem = function(codigo, descr, qtd, preco, st, un, form: PChar): integer; stdcall;
   PUrano2EFE_CanItem = function(descr, trans: PChar): integer; stdcall;
   PUrano2EFE_DescontoItem = function(c, descr, valor: PChar): integer; stdcall;
   PUrano2EFE_Pagamento = function(descr, valor: PChar): integer; stdcall;
   PUrano2EFE_FinalizaVenda = function(byte, oper: PChar): integer; stdcall;
   PUrano2EFE_ImprimeLinhaNFiscal = function(texto: PChar): integer; stdcall;
   PUrano2EFE_CancelaVenda = function(oper: PChar): integer; stdcall;
   PUrano2EFE_CancelaCupom = function(oper: PChar): integer; stdcall;
   PUrano2EFE_AcrescSubTotal = function(c, descr, valor: PChar): integer; stdcall;
   PUrano2EFE_DescSubTotal = function(c, descr, valor: PChar): integer; stdcall;
   PUrano2EFE_IniciaXZ = function(t: PChar): integer; stdcall;
   PUrano2EFE_FinalizaXZ = function(oper: PChar): integer; stdcall;
   PUrano2EFE_MensagemPromocional = function(atrib, texto: PChar): integer; stdcall;
   PUrano2EFE_ProgramaRelogio = function(tipo: char; data, hora: PChar): integer; stdcall;
   PUrano2EFE_AGaveta = function: integer; stdcall;
   PUrano2EFE_AvancoLinha = function(estacao, linhas: integer): integer; stdcall;
   PUrano2EFE_IniciaCupomNFiscal = function: integer; stdcall;
   PUrano2EFE_LeRegistradores = function(regist, valor: PChar): integer; stdcall;
   PUrano2EFE_AutenticaDocumento = function(linha: PChar): integer; stdcall;
   PUrano2EFE_LeituraSensor = function(sensor: char): integer; stdcall;
   PUrano2EFE_ICheque = function(nomearquivo, valor, favorecido, cidade, datacheque, banco: PChar; espacamento: integer): integer; stdcall;
   PUrano2EFE_NomeMoeda = function(singular, plural: PChar): integer; stdcall;
   PUrano2EFE_EspacamentoLinhas = function(tipo: integer): integer; stdcall;
   { =======================  ZANTHUS  ================== }
   PZanthus_InicializaPortaSerial = function(porta: integer): integer stdcall;
   PZanthus_FechaPortaSerial = function: integer stdcall;
   PZanthus_EnviaComandoComArgumento = function(C: Char; S: PCHAR): integer stdcall;
   PZanthus_EnviaComando = function(C: Char): integer stdcall;
   PZanthus_LeBufferASCII = function(S: PCHAR): integer stdcall;
   PZanthus_LeRetorno = function: integer stdcall;
   PZanthus_LeRetornoASCII = function: Byte stdcall;
   PZanthus_ConfiguraCheque = function(S: PCHAR): integer stdcall;
   PZanthus_ConfiguraMoeda = function(pMoeda, pMoedaPlural: PCHAR): integer stdcall;
   PZanthus_ImprimeCheque = function(pValor, pFavorecido, pLocal, pData: PCHAR): integer stdcall;
   { =======================  BEMATECH ================== }
   PBematech_IniPortaStr = function(Porta: string): integer; stdcall;
   PBematech_FormataTX = function(BUFFER: string): integer; stdcall;
   PBematech_FechaPorta = function: integer; stdcall;
   PBematech_Status_Mp20FI = function(var Ret: integer; var ACK: integer; var ST1: integer; var ST2: Integer): integer; stdcall;
   /////////////////////////////// Parte implementada de novas funcoes Bematech /////////////////////////////////////////////////////////////
   // Funções de Inicialização
   PBematech_AlteraSimboloMoeda=function ( SimboloMoeda: String ): Integer; StdCall;
   PBematech_ProgramaAliquota=function ( Aliquota: String; ICMS_ISS: Integer ): Integer; StdCall;
   PBematech_ProgramaHorarioVerao=function : Integer; StdCall;
   PBematech_NomeiaDepartamento=function ( Indice: Integer; Departamento: String ): Integer; StdCall;
   PBematech_NomeiaTotalizadorNaoSujeitoIcms=function ( Indice: Integer; Totalizador: String ): Integer; StdCall;
   PBematech_ProgramaArredondamento=function : Integer; StdCall;
   PBematech_ProgramaTruncamento=function : Integer; StdCall;
   PBematech_LinhasEntreCupons=function ( Linhas: Integer ): Integer; StdCall;
   PBematech_EspacoEntreLinhas=function ( Dots: Integer ): Integer; StdCall;
   PBematech_ForcaImpactoAgulhas=function ( ForcaImpacto: Integer ): Integer;StdCall;
   // Funções do Cupom Fiscal
   PBematech_AbreCupom=function ( CGC_CPF: String ): Integer; StdCall;
   PBematech_VendeItem=function ( Codigo: String; Descricao: String; Aliquota: String; TipoQuantidade: String; Quantidade: String; CasasDecimais: Integer; ValorUnitario: String; TipoDesconto: String; Desconto: String): Integer; StdCall;
   PBematech_VendeItemDepartamento=function ( Codigo: String; Descricao: String; Aliquota: String; ValorUnitario: String; Quantidade: String; Acrescimo: String; Desconto: String; IndiceDepartamento: String; UnidadeMedida: String): Integer; StdCall;
   PBematech_CancelaItemAnterior=function : Integer; StdCall;
   PBematech_CancelaItemGenerico=function ( NumeroItem: String ): Integer; StdCall;
   PBematech_CancelaCupom=function : Integer; StdCall;
   PBematech_FechaCupomResumido=function ( FormaPagamento: String; Mensagem: String ): Integer; StdCall;
   PBematech_FechaCupom = function( FormaPagamento: String; AcrescimoDesconto: String; TipoAcrescimoDesconto: String; ValorAcrescimoDesconto: String; ValorPago: String; Mensagem: String): Integer; StdCall;
   PBematech_ResetaImpressora=function : Integer; StdCall;
   PBematech_IniciaFechamentoCupom=function ( AcrescimoDesconto: String; TipoAcrescimoDesconto: String; ValorAcrescimoDesconto: String ): Integer; StdCall;
   PBematech_EfetuaFormaPagamento=function ( FormaPagamento: String; ValorFormaPagamento: String ): Integer; StdCall;
   PBematech_EfetuaFormaPagamentoDescricaoForma=function ( FormaPagamento: string; ValorFormaPagamento: string; DescricaoFormaPagto: string ): integer; StdCall;
   PBematech_TerminaFechamentoCupom=function ( Mensagem: String): Integer; StdCall;
   PBematech_EstornoFormasPagamento=function ( FormaOrigem: String; FormaDestino: String; Valor: String ): Integer; StdCall;
   PBematech_UsaUnidadeMedida=function ( UnidadeMedida: String ): Integer; StdCall;
   PBematech_AumentaDescricaoItem=function ( Descricao: String ): Integer; StdCall;
   // Funções dos Relatórios Fiscais
   PBematech_LeituraX=function : Integer; StdCall;
   PBematech_ReducaoZ=function ( Data: String; Hora: String ): Integer; StdCall;
   PBematech_RelatorioGerencial=function ( Texto: String ): Integer; StdCall;
   PBematech_FechaRelatorioGerencial=function : Integer; StdCall;
   PBematech_LeituraMemoriaFiscalData=function ( DataInicial: String; DataFinal: String ): Integer; StdCall;
   PBematech_LeituraMemoriaFiscalReducao=function ( ReducaoInicial: String; ReducaoFinal: String ): Integer; StdCall;
   PBematech_LeituraMemoriaFiscalSerialData=function ( DataInicial: String; DataFinal: String ): Integer; StdCall;
   PBematech_LeituraMemoriaFiscalSerialReducao=function ( ReducaoInicial: String; ReducaoFinal: String ): Integer; StdCall;
   // Funções das Operações Não Fiscais
   PBematech_RecebimentoNaoFiscal=function ( IndiceTotalizador: String; Valor: String; FormaPagamento: String ): Integer; StdCall;
   PBematech_AbreComprovanteNaoFiscalVinculado=function ( FormaPagamento: String; Valor: String; NumeroCupom: String ): Integer; StdCall;
   PBematech_UsaComprovanteNaoFiscalVinculado=function ( Texto: String ): Integer; StdCall;
   PBematech_UsaComprovanteNaoFiscalVinculadoTEF=function (Texto: string): Integer; StdCall;
   PBematech_FechaComprovanteNaoFiscalVinculado=function : Integer; StdCall;
   PBematech_Sangria=function ( Valor: String ): Integer; StdCall;
   PBematech_Suprimento=function ( Valor: String; FormaPagamento: String ): Integer; StdCall;
   // Funções de Informações da Impressora
   PBematech_ProgramaIdAplicativoMFD =function ( cAplicativo: String ): Integer; StdCall;
   PBematech_NumeroSerie=function ( NumeroSerie: String ): Integer; StdCall;
   PBematech_SubTotal=function ( SubTotal: String ): Integer; StdCall;
   PBematech_NumeroCupom=function ( NumeroCupom: String ): Integer; StdCall;
   PBematech_LeituraXSerial=function : Integer; StdCall;
   PBematech_VersaoFirmware=function ( VersaoFirmware: String ): Integer; StdCall;
   PBematech_CGC_IE=function ( CGC: String; IE: String ): Integer; StdCall;
   PBematech_GrandeTotal=function ( GrandeTotal: String ): Integer; StdCall;
   PBematech_Cancelamentos=function ( ValorCancelamentos: String ): Integer; StdCall;
   PBematech_Descontos=function ( ValorDescontos: String ): Integer; StdCall;
   PBematech_NumeroOperacoesNaoFiscais=function ( NumeroOperacoes: String ): Integer; StdCall;
   PBematech_NumeroCuponsCancelados=function ( NumeroCancelamentos: String ): Integer; StdCall;
   PBematech_NumeroIntervencoes=function ( NumeroIntervencoes: String ): Integer; StdCall;
   PBematech_NumeroReducoes=function ( NumeroReducoes: String ): Integer; StdCall;
   PBematech_NumeroSubstituicoesProprietario=function ( NumeroSubstituicoes: String ): Integer; StdCall;
   PBematech_UltimoItemVendido=function ( NumeroItem: String ): Integer; StdCall;
   PBematech_ClicheProprietario=function ( Cliche: String ): Integer; StdCall;
   PBematech_NumeroCaixa=function ( NumeroCaixa: String ): Integer; StdCall;
   PBematech_NumeroLoja=function ( NumeroLoja: String ): Integer; StdCall;
   PBematech_SimboloMoeda=function ( SimboloMoeda: String ): Integer; StdCall;
   PBematech_MinutosLigada=function ( Minutos: String ): Integer; StdCall;
   PBematech_MinutosImprimindo=function ( Minutos: String ): Integer; StdCall;
   PBematech_VerificaModoOperacao=function ( Modo: string ): Integer; StdCall;
   PBematech_VerificaEpromConectada=function ( Flag: String ): Integer; StdCall;
   PBematech_FlagsFiscais=function ( Var Flag: Integer ): Integer; StdCall;
   PBematech_ValorPagoUltimoCupom=function ( ValorCupom: String ): Integer; StdCall;
   PBematech_DataHoraImpressora=function ( Data: String; Hora: String ): Integer; StdCall;
   PBematech_ContadoresTotalizadoresNaoFiscais=function ( Contadores: String ): Integer; StdCall;
   PBematech_VerificaTotalizadoresNaoFiscais=function ( Totalizadores: String ): Integer; StdCall;
   PBematech_DataHoraReducao=function ( Data: String; Hora: String ): Integer; StdCall;
   PBematech_DataMovimento=function ( Data: String ): Integer; StdCall;
   PBematech_VerificaTruncamento=function ( Flag: string ): Integer; StdCall;
   PBematech_Acrescimos=function ( ValorAcrescimos: String ): Integer; StdCall;
   PBematech_ContadorBilhetePassagem=function ( ContadorPassagem: String ): Integer; StdCall;
   PBematech_VerificaAliquotasIss=function ( Flag: String ): Integer; StdCall;
   PBematech_VerificaFormasPagamento=function ( Formas: String ): Integer; StdCall;
   PBematech_VerificaRecebimentoNaoFiscal=function ( Recebimentos: String ): Integer; StdCall;
   PBematech_VerificaDepartamentos=function ( Departamentos: String ): Integer; StdCall;
   PBematech_VerificaTipoImpressora=function ( Var TipoImpressora: Integer ): Integer; StdCall;
   PBematech_VerificaTotalizadoresParciais=function ( Totalizadores: String ): Integer; StdCall;
   PBematech_RetornoAliquotas=function ( Aliquotas: String ): Integer; StdCall;
   PBematech_VerificaEstadoImpressora=function ( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): Integer; StdCall;
   PBematech_DadosUltimaReducao=function ( DadosReducao: String ): Integer; StdCall;
   PBematech_MonitoramentoPapel=function ( Var Linhas: Integer): Integer; StdCall;
   PBematech_VerificaIndiceAliquotasIss=function ( Flag: String ): Integer; StdCall;
   PBematech_ValorFormaPagamento=function ( FormaPagamento: String; Valor: String ): Integer; StdCall;
   PBematech_ValorTotalizadorNaoFiscal=function ( Totalizador: String; Valor: String ): Integer; StdCall;
   PBematech_LeArquivoRetorno=function ( Retorno: String ): Integer;Stdcall;
   PBematech_RegistrosTipo60= function(): Integer; StdCall;
   // Funções de Autenticação e Gaveta de Dinheiro
   PBematech_Autenticacao=function :Integer; StdCall;
   PBematech_ProgramaCaracterAutenticacao=function ( Parametros: String ): Integer; StdCall;
   PBematech_AcionaGaveta=function :Integer; StdCall;
   PBematech_VerificaEstadoGaveta=function ( Var EstadoGaveta: Integer ): Integer; StdCall;
   // Funções de Impressão de Cheques
   PBematech_ProgramaMoedaSingular=function ( MoedaSingular: String ): Integer; StdCall;
   PBematech_ProgramaMoedaPlural=function ( MoedaPlural: String ): Integer; StdCall;
   PBematech_CancelaImpressaoCheque=function : Integer; StdCall;
   PBematech_VerificaStatusCheque=function ( Var StatusCheque: Integer ): Integer; StdCall;
   PBematech_ImprimeCheque=function ( Banco: String; Valor: String; Favorecido: String; Cidade: String; Data: String; Mensagem: String ): Integer; StdCall;
   PBematech_IncluiCidadeFavorecido=function ( Cidade: String; Favorecido: String ): Integer; StdCall;
   PBematech_ImprimeCopiaCheque=function : Integer; StdCall;
   // Outras Funções
   PBematech_AbrePortaSerial=function : Integer; StdCall;
   PBematech_RetornoImpressora=function ( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): Integer; StdCall;
   PBematech_FechaPortaSerial=function : Integer; StdCall;
   PBematech_MapaResumo=function :Integer; StdCall;
   PBematech_AberturaDoDia=function ( ValorCompra: string; FormaPagamento: string ): Integer; StdCall;
   PBematech_FechamentoDoDia=function : Integer; StdCall;
   PBematech_ImprimeConfiguracoesImpressora=function :Integer; StdCall;
   PBematech_ImprimeDepartamentos=function : Integer; StdCall;
   PBematech_RelatorioTipo60Analitico=function : Integer; StdCall;
   PBematech_RelatorioTipo60Mestre=function : Integer; StdCall;
   PBematech_VerificaImpressoraLigada=function : Integer; StdCall;
   // Funções da Impressora Fiscal MFD
   PBematech_AbreCupomMFD=function (CGC: string; Nome: string; Endereco : string): Integer; StdCall;
   PBematech_CancelaCupomMFD=function (CGC, Nome, Endereco: string): Integer; StdCall;
   PBematech_ProgramaFormaPagamentoMFD=function (FormaPagto, OperacaoTef: String) : Integer; StdCall;
   PBematech_EfetuaFormaPagamentoMFD=function (FormaPagamento, ValorFormaPagamento, Parcelas, DescricaoFormaPagto: string): Integer; StdCall;
   PBematech_CupomAdicionalMFD=function : Integer; StdCall;
   PBematech_AcrescimoDescontoItemMFD=function  (Item, AcrescimoDesconto,TipoAcrescimoDesconto, ValorAcrescimoDesconto: string): Integer; StdCall;
   PBematech_NomeiaRelatorioGerencialMFD=function  (Indice, Descricao : string): Integer; StdCall;
   PBematech_AutenticacaoMFD=function (Linhas, Texto : string) : Integer; StdCall;
   PBematech_AbreComprovanteNaoFiscalVinculadoMFD=function (FormaPagamento, Valor, NumeroCupom, CGC, nome, Endereco : string): Integer; StdCall;
   PBematech_ReimpressaoNaoFiscalVinculadoMFD=function : Integer; StdCall;
   PBematech_AbreRecebimentoNaoFiscalMFD=function (CGC, Nome, Endereco : string): Integer; StdCall;
   PBematech_EfetuaRecebimentoNaoFiscalMFD=function (IndiceTotalizador, ValorRecebimento : string): Integer; StdCall;
   PBematech_IniciaFechamentoCupomMFD=function (AcrescimoDesconto,TipoAcrescimoDesconto, ValorAcrescimo, ValorDesconto : string): Integer; StdCall;
   PBematech_IniciaFechamentoRecebimentoNaoFiscalMFD=function (AcrescimoDesconto,TipoAcrescimoDesconto, ValorAcrescimo, ValorDesconto : string): Integer; StdCall;
   PBematech_FechaRecebimentoNaoFiscalMFD=function (Mensagem : string): Integer; StdCall;
   PBematech_CancelaRecebimentoNaoFiscalMFD=function (CGC, Nome, Endereco : string): Integer; StdCall;
   PBematech_AbreRelatorioGerencialMFD=function (Indice : string): Integer; StdCall;
   PBematech_UsaRelatorioGerencialMFD=function (Texto : string): Integer; StdCall;
   PBematech_SegundaViaNaoFiscalVinculadoMFD=function (): Integer; StdCall;
   PBematech_EstornoNaoFiscalVinculadoMFD=function (CGC, Nome, Endereco : string): Integer; StdCall;
   PBematech_NumeroSerieMFD=function (NumeroSerie : string): Integer; StdCall;
   PBematech_VersaoFirmwareMFD=function (VersaoFirmware : string): Integer; StdCall;
   PBematech_CNPJMFD=function (CNPJ : string): Integer; StdCall;
   PBematech_InscricaoEstadualMFD=function (InscricaoEstadual : string): Integer; StdCall;
   PBematech_InscricaoMunicipalMFD=function (InscricaoMunicipal : string): Integer; StdCall;
   PBematech_TempoOperacionalMFD=function (TempoOperacional : string): Integer; StdCall;
   PBematech_MinutosEmitindoDocumentosFiscaisMFD=function (Minutos : string): Integer; StdCall;
   PBematech_ContadoresTotalizadoresNaoFiscaisMFD=function (Contadores : string): Integer; StdCall;
   PBematech_VerificaTotalizadoresNaoFiscaisMFD=function (Totalizadores : string): Integer; StdCall;
   PBematech_VerificaFormasPagamentoMFD=function (FormasPagamento : string): Integer; StdCall;
   PBematech_VerificaRecebimentoNaoFiscalMFD=function (Recebimentos : string): Integer; StdCall;
   PBematech_VerificaRelatorioGerencialMFD=function (Relatorios : string): Integer; StdCall;
   PBematech_ContadorComprovantesCreditoMFD=function (Comprovantes : string): Integer; StdCall;
   PBematech_ContadorOperacoesNaoFiscaisCanceladasMFD=function (OperacoesCanceladas : string): Integer; StdCall;
   PBematech_ContadorRelatoriosGerenciaisMFD=function  (Relatorios : String): Integer; StdCall;
   PBematech_ContadorCupomFiscalMFD=function (CuponsEmitidos : string): Integer; StdCall;
   PBematech_ContadorFitaDetalheMFD=function (ContadorFita : string): Integer; StdCall;
   PBematech_ComprovantesNaoFiscaisNaoEmitidosMFD=function (Comprovantes : string): Integer; StdCall;
   PBematech_NumeroSerieMemoriaMFD=function (NumeroSerieMFD : string): Integer; StdCall;
   PBematech_MarcaModeloTipoImpressoraMFD=function (Marca, Modelo, Tipo : string): Integer; StdCall;
   PBematech_DataHoraGravacaoUsuarioSWBasicoMFAdicional=function (dataUsuario, dataSWBasico: String; var MFAdicional : Char): Integer; StdCall;
   PBematech_ReducoesRestantesMFD=function (Reducoes : string): Integer; StdCall;
   PBematech_VerificaTotalizadoresParciaisMFD=function (Totalizadores : string): Integer; StdCall;
   PBematech_DadosUltimaReducaoMFD=function (DadosReducao : string): Integer; StdCall;
   PBematech_LeituraMemoriaFiscalDataMFD=function (DataInicial, DataFinal, FlagLeitura : string): Integer; StdCall;
   PBematech_LeituraMemoriaFiscalReducaoMFD=function (ReducaoInicial, ReducaoFinal, FlagLeitura : string): Integer; StdCall;
   PBematech_LeituraMemoriaFiscalSerialDataMFD=function (DataInicial, DataFinal, FlagLeitura : string): Integer; StdCall;
   PBematech_LeituraMemoriaFiscalSerialReducaoMFD=function (ReducaoInicial, ReducaoFinal, FlagLeitura : string): Integer; StdCall;
   PBematech_LeituraChequeMFD=function (CodigoCMC7 : string): Integer; StdCall;
   PBematech_ImprimeChequeMFD=function (NumeroBanco, Valor, Favorecido, Cidade, Data, Mensagem, ImpressaoVerso, Linhas : string): Integer; StdCall;
   PBematech_HabilitaDesabilitaRetornoEstendidoMFD=function (FlagRetorno : string): Integer; StdCall;
   PBematech_RetornoImpressoraMFD=function (ACK, ST1, ST2, ST3 : Integer ): Integer; StdCall;
   PBematech_AbreBilhetePassagemMFD=function (Embarque, Destino, Linha, Agencia, Data, Hora, Poltrona, Plataforma, TipoPassagem: string ): Integer; StdCall;
   PBematech_CancelaAcrescimoDescontoItemMFD=function ( cFlag, cItem: string ): integer; StdCall;
   PBematech_SubTotalizaCupomMFD=function : integer; StdCall;
   PBematech_SubTotalizaRecebimentoMFD=function : integer; StdCall;
   PBematech_TotalLivreMFD=function ( cMemoriaLivre: string ): integer; StdCall;
   PBematech_TamanhoTotalMFD=function ( cTamanhoMFD: string ): integer; StdCall;
   PBematech_AcrescimoDescontoSubtotalRecebimentoMFD=function ( cFlag, cTipo, cValor: string ): integer; StdCall;
   PBematech_AcrescimoDescontoSubtotalMFD=function ( cFlag, cTipo, cValor: string): integer; StdCall;
   PBematech_CancelaAcrescimoDescontoSubtotalMFD=function ( cFlag: string): integer; StdCall;
   PBematech_CancelaAcrescimoDescontoSubtotalRecebimentoMFD=function ( cFlag: string ): integer; StdCall;
   PBematech_TotalizaCupomMFD=function : integer; StdCall;
   PBematech_TotalizaRecebimentoMFD=function : integer; StdCall;
   PBematech_PercentualLivreMFD=function ( cMemoriaLivre: string ): integer; StdCall;
   PBematech_DataHoraUltimoDocumentoMFD=function ( cDataHora: string ): integer; StdCall;
   PBematech_MapaResumoMFD=function :Integer; StdCall;
   PBematech_RelatorioTipo60AnaliticoMFD=function : Integer; StdCall;
   PBematech_ValorFormaPagamentoMFD=function ( FormaPagamento: String; Valor: String ): Integer; StdCall;
   PBematech_ValorTotalizadorNaoFiscalMFD=function ( Totalizador: String; Valor: String ): Integer; StdCall;
   PBematech_VerificaEstadoImpressoraMFD=function ( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer; Var ST3: Integer ): Integer; StdCall;
   // Funções para o TEF
   PBematech_TEF_Status=function (Identificacao: string): integer; StdCall;
   PBematech_TEF_VendaCartao=function (Identificacao: string; ValorCompra: string): Integer; StdCall;
   PBematech_TEF_ConfirmaVenda=function (Identificacao: string; ValorCompra: string; Header: string): Integer; StdCall;
   PBematech_TEF_NaoConfirmaVendaImpressao=function (Identificacao: string; ValorCompra: string): Integer; StdCall;
   PBematech_TEF_CancelaVendaCartao=function (Identificacao: string; ValorCompra: string; Nsu: string; NumeroCupom: string; Hora: string; Data: string; Rede: string): Integer; StdCall;
   PBematech_TEF_ImprimeTEF=function (Identificacao: string; FormaPagamento: string; ValorCompra: string): Integer; StdCall;
   PBematech_TEF_ImprimeRelatorio=function : Integer; StdCall;
   PBematech_TEF_ADM=function (Identificacao: string): Integer; StdCall;
   PBematech_TEF_VendaCompleta=function (Identificacao: string; ValorCompra: string; FormaPagamento: string; Texto: string): Integer; StdCall;
   PBematech_TEF_ConfiguraDiretorioTef=function ( Path1: string; Path2: string): Integer; StdCall;
   PBematech_TEF_VendaCheque=function (Identificacao: string; ValorCompra: string): Integer; StdCall;
   PBematech_TEF_ApagaResiduos=function : Integer; StdCall;
   // Funções para a Balança
   PBematech_InfoBalanca=function (port: string ;model: integer; peso,precoKilo,total: string): Integer; StdCall;
   // Funcoes Sintegra
   PBematech_FI_RelatorioSintegraMFD = function (iRelatorios : Integer; cArquivo : String; cMes : String; cAno : String; cRazaoSocial: String; cEndereco : String; cNumero : String; cComplemento: String; cBairro : String; cCidade : String; cCEP : String; cTelefone : String; cFax : String; cContato : String ): Integer; StdCall;
   // PAF
   PBematech_FI_DownloadMFD = function (cArquivo, cTipoDownload, cCOOInicial, cCOOFinal, cUsuario : String): Integer; StdCall;
   PBematech_FI_InicioFimCOOsMFD = function ( cCOOIni, cCOOFim: String ): Integer; StdCall;
   PBematech_FI_InicioFimGTsMFD = function ( cGTIni, cGTFim: String ): Integer; StdCall;
{ Fim da Declaração }

   { =======================  ELGIN ================== } 
   /////////////////////////////// Parte implementada de novas funcoes Elgin /////////////////////////////////////////////////////////////
   // Funções de Inicialização
   PElgin_AlteraSimboloMoeda=function ( SimboloMoeda: String ): Integer; StdCall;
   PElgin_ProgramaAliquota=function ( Aliquota: String; ICMS_ISS: Integer ): Integer; StdCall;
   PElgin_ProgramaHorarioVerao=function : Integer; StdCall;
   PElgin_NomeiaDepartamento=function ( Indice: Integer; Departamento: String ): Integer; StdCall;
   PElgin_NomeiaTotalizadorNaoSujeitoIcms=function ( Indice: Integer; Totalizador: String ): Integer; StdCall;
   PElgin_ProgramaArredondamento=function : Integer; StdCall;
   PElgin_ProgramaTruncamento=function : Integer; StdCall;
   PElgin_LinhasEntreCupons=function ( Linhas: Integer ): Integer; StdCall;
   PElgin_EspacoEntreLinhas=function ( Dots: Integer ): Integer; StdCall;
   PElgin_ForcaImpactoAgulhas=function ( ForcaImpacto: Integer ): Integer;StdCall;
   // Funções do Cupom Fiscal
   PElgin_AbreCupom=function ( CGC_CPF: String ): Integer; StdCall;
   PElgin_VendeItem=function ( Codigo: String; Descricao: String; Aliquota: String; TipoQuantidade: String; Quantidade: String; CasasDecimais: Integer; ValorUnitario: String; TipoDesconto: String; Desconto: String): Integer; StdCall;
   PElgin_VendeItemDepartamento=function ( Codigo: String; Descricao: String; Aliquota: String; ValorUnitario: String; Quantidade: String; Acrescimo: String; Desconto: String; IndiceDepartamento: String; UnidadeMedida: String): Integer; StdCall;
   PElgin_CancelaItemAnterior=function : Integer; StdCall;
   PElgin_CancelaItemGenerico=function ( NumeroItem: String ): Integer; StdCall;
   PElgin_CancelaCupom=function : Integer; StdCall;
   PElgin_FechaCupomResumido=function ( FormaPagamento: String; Mensagem: String ): Integer; StdCall;
   PElgin_FechaCupom = function( FormaPagamento: String; AcrescimoDesconto: String; TipoAcrescimoDesconto: String; ValorAcrescimoDesconto: String; ValorPago: String; Mensagem: String): Integer; StdCall;
   PElgin_ResetaImpressora=function : Integer; StdCall;
   PElgin_IniciaFechamentoCupom=function ( AcrescimoDesconto: String; TipoAcrescimoDesconto: String; ValorAcrescimoDesconto: String ): Integer; StdCall;
   PElgin_EfetuaFormaPagamento=function ( FormaPagamento: String; ValorFormaPagamento: String ): Integer; StdCall;
   PElgin_EfetuaFormaPagamentoDescricaoForma=function ( FormaPagamento: string; ValorFormaPagamento: string; DescricaoFormaPagto: string ): integer; StdCall;
   PElgin_TerminaFechamentoCupom=function ( Mensagem: String): Integer; StdCall;
   PElgin_EstornoFormasPagamento=function ( FormaOrigem: String; FormaDestino: String; Valor: String ): Integer; StdCall;
   PElgin_UsaUnidadeMedida=function ( UnidadeMedida: String ): Integer; StdCall;
   PElgin_AumentaDescricaoItem=function ( Descricao: String ): Integer; StdCall;
   // Funções dos Relatórios Fiscais
   PElgin_LeituraX=function : Integer; StdCall;
   PElgin_ReducaoZ=function ( Data: String; Hora: String ): Integer; StdCall;
   PElgin_RelatorioGerencial=function ( Texto: String ): Integer; StdCall;
   PElgin_AbreRelatorioGerencial=function : Integer; StdCall;
   PElgin_FechaRelatorioGerencial=function : Integer; StdCall;
   PElgin_LeIndicadores=function(var Indicador: Integer): Integer; StdCall;
   PElgin_LeituraMemoriaFiscalData=function ( DataInicial: String; DataFinal: String ): Integer; StdCall;
   PElgin_LeituraMemoriaFiscalReducao=function ( ReducaoInicial: String; ReducaoFinal: String ): Integer; StdCall;
   PElgin_LeituraMemoriaFiscalSerialData=function ( DataInicial: String; DataFinal: String ): Integer; StdCall;
   PElgin_LeituraMemoriaFiscalSerialReducao=function ( ReducaoInicial: String; ReducaoFinal: String ): Integer; StdCall;
   // Funções das Operações Não Fiscais
   PElgin_RecebimentoNaoFiscal=function ( IndiceTotalizador: String; Valor: String; FormaPagamento: String ): Integer; StdCall;
   PElgin_AbreComprovanteNaoFiscalVinculado=function ( FormaPagamento: String; Valor: String; NumeroCupom: String ): Integer; StdCall;
   PElgin_UsaComprovanteNaoFiscalVinculado=function ( Texto: String ): Integer; StdCall;
   PElgin_FechaComprovanteNaoFiscalVinculado=function : Integer; StdCall;
   PElgin_Sangria=function ( Valor: String ): Integer; StdCall;
   PElgin_Suprimento=function ( Valor: String; FormaPagamento: String ): Integer; StdCall;
   // Funções de Informações da Impressora
   PElgin_NumeroSerie=function ( NumeroSerie: String ): Integer; StdCall;
   PElgin_SubTotal=function ( SubTotal: String ): Integer; StdCall;
   PElgin_NumeroCupom=function ( NumeroCupom: String ): Integer; StdCall;
   PElgin_LeituraXSerial=function : Integer; StdCall;
   PElgin_VersaoFirmware=function ( VersaoFirmware: String ): Integer; StdCall;
   PElgin_CGC_IE=function ( CGC: String; IE: String ): Integer; StdCall;
   PElgin_GrandeTotal=function ( GrandeTotal: String ): Integer; StdCall;
   PElgin_Cancelamentos=function ( ValorCancelamentos: String ): Integer; StdCall;
   PElgin_Descontos=function ( ValorDescontos: String ): Integer; StdCall;
   PElgin_NumeroOperacoesNaoFiscais=function ( NumeroOperacoes: String ): Integer; StdCall;
   PElgin_NumeroCuponsCancelados=function ( NumeroCancelamentos: String ): Integer; StdCall;
   PElgin_NumeroIntervencoes=function ( NumeroIntervencoes: String ): Integer; StdCall;
   PElgin_NumeroReducoes=function ( NumeroReducoes: String ): Integer; StdCall;
   PElgin_NumeroSubstituicoesProprietario=function ( NumeroSubstituicoes: String ): Integer; StdCall;
   PElgin_UltimoItemVendido=function ( NumeroItem: String ): Integer; StdCall;
   PElgin_ClicheProprietario=function ( Cliche: String ): Integer; StdCall;
   PElgin_NumeroCaixa=function ( NumeroCaixa: String ): Integer; StdCall;
   PElgin_NumeroLoja=function ( NumeroLoja: String ): Integer; StdCall;
   PElgin_SimboloMoeda=function ( SimboloMoeda: String ): Integer; StdCall;
   PElgin_MinutosLigada=function ( Minutos: String ): Integer; StdCall;
   PElgin_MinutosImprimindo=function ( Minutos: String ): Integer; StdCall;
   PElgin_VerificaModoOperacao=function ( Modo: string ): Integer; StdCall;
   PElgin_VerificaEpromConectada=function ( Flag: String ): Integer; StdCall;
   PElgin_FlagsFiscais=function ( Var Flag: Integer ): Integer; StdCall;
   PElgin_ValorPagoUltimoCupom=function ( ValorCupom: String ): Integer; StdCall;
   PElgin_DataHoraImpressora=function ( Data: String; Hora: String ): Integer; StdCall;
   PElgin_ContadoresTotalizadoresNaoFiscais=function ( Contadores: String ): Integer; StdCall;
   PElgin_VerificaTotalizadoresNaoFiscais=function ( Totalizadores: String ): Integer; StdCall;
   PElgin_DataHoraReducao=function ( Data: String; Hora: String ): Integer; StdCall;
   PElgin_DataMovimento=function ( Data: String ): Integer; StdCall;
   PElgin_VerificaTruncamento=function ( Flag: string ): Integer; StdCall;
   PElgin_Acrescimos=function ( ValorAcrescimos: String ): Integer; StdCall;
   PElgin_ContadorBilhetePassagem=function ( ContadorPassagem: String ): Integer; StdCall;
   PElgin_VerificaAliquotasIss=function ( Flag: String ): Integer; StdCall;
   PElgin_VerificaFormasPagamento=function ( Formas: String ): Integer; StdCall;
   PElgin_VerificaRecebimentoNaoFiscal=function ( Recebimentos: String ): Integer; StdCall;
   PElgin_VerificaDepartamentos=function ( Departamentos: String ): Integer; StdCall;
   PElgin_VerificaTipoImpressora=function ( Var TipoImpressora: Integer ): Integer; StdCall;
   PElgin_VerificaTotalizadoresParciais=function ( Totalizadores: String ): Integer; StdCall;
   PElgin_RetornoAliquotas=function ( Aliquotas: String ): Integer; StdCall;
   PElgin_VerificaEstadoImpressora=function ( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): Integer; StdCall;
   PElgin_DadosUltimaReducao=function ( DadosReducao: String ): Integer; StdCall;
   PElgin_MonitoramentoPapel=function ( Var Linhas: Integer): Integer; StdCall;
   PElgin_VerificaIndiceAliquotasIss=function ( Flag: String ): Integer; StdCall;
   PElgin_ValorFormaPagamento=function ( FormaPagamento: String; Valor: String ): Integer; StdCall;
   PElgin_ValorTotalizadorNaoFiscal=function ( Totalizador: String; Valor: String ): Integer; StdCall;
   PElgin_LeArquivoRetorno=function ( Retorno: String ): Integer;Stdcall;
   PElgin_RegistrosTipo60= function(): Integer; StdCall;
   // Funções de Autenticação e Gaveta de Dinheiro
   PElgin_Autenticacao=function :Integer; StdCall;
   PElgin_ProgramaCaracterAutenticacao=function ( Parametros: String ): Integer; StdCall;
   PElgin_AcionaGaveta=function :Integer; StdCall;
   PElgin_VerificaEstadoGaveta=function ( Var EstadoGaveta: Integer ): Integer; StdCall;
   // Funções de Impressão de Cheques
   PElgin_ProgramaMoedaSingular=function ( MoedaSingular: String ): Integer; StdCall;
   PElgin_ProgramaMoedaPlural=function ( MoedaPlural: String ): Integer; StdCall;
   PElgin_CancelaImpressaoCheque=function : Integer; StdCall;
   PElgin_VerificaStatusCheque=function ( Var StatusCheque: Integer ): Integer; StdCall;
   PElgin_ImprimeCheque=function ( Banco: String; Valor: String; Favorecido: String; Cidade: String; Data: String; Mensagem: String ): Integer; StdCall;
   PElgin_IncluiCidadeFavorecido=function ( Cidade: String; Favorecido: String ): Integer; StdCall;
   PElgin_ImprimeCopiaCheque=function : Integer; StdCall;
   // Outras Funções
   PElgin_AbrePortaSerial=function : Integer; StdCall;
   //PElgin_RetornoImpressora=function ( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): Integer; StdCall;
   PElgin_RetornoImpressora=function ( var i : integer; ErrorMsg : string ): Integer; StdCall;
   PElgin_FechaPortaSerial=function : Integer; StdCall;
   PElgin_MapaResumo=function :Integer; StdCall;
   PElgin_AberturaDoDia=function ( ValorCompra: string; FormaPagamento: string ): Integer; StdCall;
   PElgin_FechamentoDoDia=function : Integer; StdCall;
   PElgin_ImprimeConfiguracoesImpressora=function :Integer; StdCall;
   PElgin_ImprimeDepartamentos=function : Integer; StdCall;
   PElgin_RelatorioTipo60Analitico=function : Integer; StdCall;
   PElgin_RelatorioTipo60Mestre=function : Integer; StdCall;
   PElgin_VerificaImpressoraLigada=function : Integer; StdCall;
   // Funções da Impressora Fiscal MFD
   PElgin_AbreCupomMFD=function (CGC: string; Nome: string; Endereco : string): Integer; StdCall;
   PElgin_CancelaCupomMFD=function (CGC, Nome, Endereco: string): Integer; StdCall;
   PElgin_ProgramaFormaPagamentoMFD=function (FormaPagto, OperacaoTef: String) : Integer; StdCall;
   PElgin_EfetuaFormaPagamentoMFD=function (FormaPagamento, ValorFormaPagamento, Parcelas, DescricaoFormaPagto: string): Integer; StdCall;
   PElgin_CupomAdicionalMFD=function : Integer; StdCall;
   PElgin_AcrescimoDescontoItemMFD=function  (Item, AcrescimoDesconto,TipoAcrescimoDesconto, ValorAcrescimoDesconto: string): Integer; StdCall;
   PElgin_NomeiaRelatorioGerencialMFD=function  (Indice, Descricao : string): Integer; StdCall;
   PElgin_AutenticacaoMFD=function (Linhas, Texto : string) : Integer; StdCall;
   PElgin_AbreComprovanteNaoFiscalVinculadoMFD=function (FormaPagamento, Valor, NumeroCupom, CGC, nome, Endereco : string): Integer; StdCall;
   PElgin_ReimpressaoNaoFiscalVinculadoMFD=function : Integer; StdCall;
   PElgin_AbreRecebimentoNaoFiscalMFD=function (CGC, Nome, Endereco : string): Integer; StdCall;
   PElgin_EfetuaRecebimentoNaoFiscalMFD=function (IndiceTotalizador, ValorRecebimento : string): Integer; StdCall;
   PElgin_IniciaFechamentoCupomMFD=function (AcrescimoDesconto,TipoAcrescimoDesconto, ValorAcrescimo, ValorDesconto : string): Integer; StdCall;
   PElgin_IniciaFechamentoRecebimentoNaoFiscalMFD=function (AcrescimoDesconto,TipoAcrescimoDesconto, ValorAcrescimo, ValorDesconto : string): Integer; StdCall;
   PElgin_FechaRecebimentoNaoFiscalMFD=function (Mensagem : string): Integer; StdCall;
   PElgin_CancelaRecebimentoNaoFiscalMFD=function (CGC, Nome, Endereco : string): Integer; StdCall;
   PElgin_AbreRelatorioGerencialMFD=function (Indice : string): Integer; StdCall;
   PElgin_UsaRelatorioGerencialMFD=function (Texto : string): Integer; StdCall;
   PElgin_SegundaViaNaoFiscalVinculadoMFD=function (): Integer; StdCall;
   PElgin_EstornoNaoFiscalVinculadoMFD=function (CGC, Nome, Endereco : string): Integer; StdCall;
   PElgin_NumeroSerieMFD=function (NumeroSerie : string): Integer; StdCall;
   PElgin_VersaoFirmwareMFD=function (VersaoFirmware : string): Integer; StdCall;
   PElgin_CNPJMFD=function (CNPJ : string): Integer; StdCall;
   PElgin_InscricaoEstadualMFD=function (InscricaoEstadual : string): Integer; StdCall;
   PElgin_InscricaoMunicipalMFD=function (InscricaoMunicipal : string): Integer; StdCall;
   PElgin_TempoOperacionalMFD=function (TempoOperacional : string): Integer; StdCall;
   PElgin_MinutosEmitindoDocumentosFiscaisMFD=function (Minutos : string): Integer; StdCall;
   PElgin_ContadoresTotalizadoresNaoFiscaisMFD=function (Contadores : string): Integer; StdCall;
   PElgin_VerificaTotalizadoresNaoFiscaisMFD=function (Totalizadores : string): Integer; StdCall;
   PElgin_VerificaFormasPagamentoMFD=function (FormasPagamento : string): Integer; StdCall;
   PElgin_VerificaRecebimentoNaoFiscalMFD=function (Recebimentos : string): Integer; StdCall;
   PElgin_VerificaRelatorioGerencialMFD=function (Relatorios : string): Integer; StdCall;
   PElgin_ContadorComprovantesCreditoMFD=function (Comprovantes : string): Integer; StdCall;
   PElgin_ContadorOperacoesNaoFiscaisCanceladasMFD=function (OperacoesCanceladas : string): Integer; StdCall;
   PElgin_ContadorRelatoriosGerenciaisMFD=function  (Relatorios : String): Integer; StdCall;
   PElgin_ContadorCupomFiscalMFD=function (CuponsEmitidos : string): Integer; StdCall;
   PElgin_ContadorFitaDetalheMFD=function (ContadorFita : string): Integer; StdCall;
   PElgin_ComprovantesNaoFiscaisNaoEmitidosMFD=function (Comprovantes : string): Integer; StdCall;
   PElgin_NumeroSerieMemoriaMFD=function (NumeroSerieMFD : string): Integer; StdCall;
   PElgin_MarcaModeloTipoImpressoraMFD=function (Marca, Modelo, Tipo : string): Integer; StdCall;
   PElgin_DataHoraSoftwareBasico=function(DataSW, HoraSW : String): Integer; StdCall;
   PElgin_ReducoesRestantesMFD=function (Reducoes : string): Integer; StdCall;
   PElgin_VerificaTotalizadoresParciaisMFD=function (Totalizadores : string): Integer; StdCall;
   PElgin_DadosUltimaReducaoMFD=function (DadosReducao : string): Integer; StdCall;
   PElgin_LeituraMemoriaFiscalDataMFD=function (DataInicial, DataFinal, FlagLeitura : string): Integer; StdCall;
   PElgin_LeituraMemoriaFiscalReducaoMFD=function (ReducaoInicial, ReducaoFinal, FlagLeitura : string): Integer; StdCall;
   PElgin_LeituraMemoriaFiscalSerialDataMFD=function (DataInicial, DataFinal, FlagLeitura : string): Integer; StdCall;
   PElgin_LeituraMemoriaFiscalSerialReducaoMFD=function (ReducaoInicial, ReducaoFinal, FlagLeitura : string): Integer; StdCall;
   PElgin_LeituraChequeMFD=function (CodigoCMC7 : string): Integer; StdCall;
   PElgin_ImprimeChequeMFD=function (NumeroBanco, Valor, Favorecido, Cidade, Data, Mensagem, ImpressaoVerso, Linhas : string): Integer; StdCall;
   PElgin_HabilitaDesabilitaRetornoEstendidoMFD=function (FlagRetorno : string): Integer; StdCall;
   PElgin_RetornoImpressoraMFD=function (ACK, ST1, ST2, ST3 : Integer ): Integer; StdCall;
   PElgin_AbreBilhetePassagemMFD=function (Embarque, Destino, Linha, Agencia, Data, Hora, Poltrona, Plataforma, TipoPassagem: string ): Integer; StdCall;
   PElgin_CancelaAcrescimoDescontoItemMFD=function ( cFlag, cItem: string ): integer; StdCall;
   PElgin_SubTotalizaCupomMFD=function : integer; StdCall;
   PElgin_SubTotalizaRecebimentoMFD=function : integer; StdCall;
   PElgin_TotalLivreMFD=function ( cMemoriaLivre: string ): integer; StdCall;
   PElgin_TamanhoTotalMFD=function ( cTamanhoMFD: string ): integer; StdCall;
   PElgin_AcrescimoDescontoSubtotalRecebimentoMFD=function ( cFlag, cTipo, cValor: string ): integer; StdCall;
   PElgin_AcrescimoDescontoSubtotalMFD=function ( cFlag, cTipo, cValor: string): integer; StdCall;
   PElgin_CancelaAcrescimoDescontoSubtotalMFD=function ( cFlag: string): integer; StdCall;
   PElgin_CancelaAcrescimoDescontoSubtotalRecebimentoMFD=function ( cFlag: string ): integer; StdCall;
   PElgin_TotalizaCupomMFD=function : integer; StdCall;
   PElgin_TotalizaRecebimentoMFD=function : integer; StdCall;
   PElgin_PercentualLivreMFD=function ( cMemoriaLivre: string ): integer; StdCall;
   PElgin_DataHoraUltimoDocumentoMFD=function ( cDataHora: string ): integer; StdCall;
   PElgin_MapaResumoMFD=function :Integer; StdCall;
   PElgin_RelatorioTipo60AnaliticoMFD=function : Integer; StdCall;
   PElgin_ValorFormaPagamentoMFD=function ( FormaPagamento: String; Valor: String ): Integer; StdCall;
   PElgin_ValorTotalizadorNaoFiscalMFD=function ( Totalizador: String; Valor: String ): Integer; StdCall;
   PElgin_VerificaEstadoImpressoraMFD=function ( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer; Var ST3: Integer ): Integer; StdCall;
   PElgin_ProgramaIdAplicativoMFD=function ( NomeAplicativo: String): Integer; StdCall;
   // Funções para o TEF
   PElgin_TEF_Status=function (Identificacao: string): integer; StdCall;
   PElgin_TEF_VendaCartao=function (Identificacao: string; ValorCompra: string): Integer; StdCall;
   PElgin_TEF_ConfirmaVenda=function (Identificacao: string; ValorCompra: string; Header: string): Integer; StdCall;
   PElgin_TEF_NaoConfirmaVendaImpressao=function (Identificacao: string; ValorCompra: string): Integer; StdCall;
   PElgin_TEF_CancelaVendaCartao=function (Identificacao: string; ValorCompra: string; Nsu: string; NumeroCupom: string; Hora: string; Data: string; Rede: string): Integer; StdCall;
   PElgin_TEF_ImprimeTEF=function (Identificacao: string; FormaPagamento: string; ValorCompra: string): Integer; StdCall;
   PElgin_TEF_ImprimeRelatorio=function : Integer; StdCall;
   PElgin_TEF_ADM=function (Identificacao: string): Integer; StdCall;
   PElgin_TEF_VendaCompleta=function (Identificacao: string; ValorCompra: string; FormaPagamento: string; Texto: string): Integer; StdCall;
   PElgin_TEF_ConfiguraDiretorioTef=function ( Path1: string; Path2: string): Integer; StdCall;
   PElgin_TEF_VendaCheque=function (Identificacao: string; ValorCompra: string): Integer; StdCall;
   PElgin_TEF_ApagaResiduos=function : Integer; StdCall;
   // Funções para a Balança
   PElgin_InfoBalanca = function (port: string ;model: integer; peso,precoKilo,total: string): Integer; StdCall;
   //PAF
   PElgin_DownloadMFD = function (cArquivo, cTipoDownload, cCOOInicial, cCOOFinal, cUsuario : String): Integer; StdCall;

   { Fim da Declaração }

   { =======================  SCFI   ================== }
   PSCFI_ecfLeitMemFisc = function(byTipo: integer; szDi: LPSTR; szDf: LPSTR; wRi: integer; wRf: integer; archive: LPSTR): Integer; stdcall;
   PSCFI_ChangePort = function(choose: integer): integer; stdcall;
   PSCFI_ecfStatusCupom = function(var general_flag: integer): PChar; stdcall;
   PSCFI_ecfLeituraXSerial = function: PChar; stdcall;
   PSCFI_ecfStatusImp = function: PChar; stdcall;
   PSCFI_ecfAbreGaveta = function: integer; stdcall;
   PSCFI_dllActiveDebug = function( iActive:integer ): integer; stdcall;
   PSCFI_ecfReducaoZ = function(operador: LPSTR): integer; stdcall;
   PSCFI_ecfLineFeed = function(byEst: integer; wLin: integer): integer; stdcall;
   PSCFI_ecfLeituraX = function(operador: LPSTR): integer; stdcall;
   PSCFI_ecfCancDoc = function(operador: LPSTR): integer; stdcall;
   PSCFI_ecfInicCupomNFiscal = function(byEst: integer): integer; stdcall;
   PSCFI_ecfImpLinha = function(szLinha: LPSTR): integer; stdcall;
   PSCFI_ecfFimTrans = function(operador: LPSTR): integer; stdcall;
   PSCFI_ecfImpCab = function(byEst: integer): integer; stdcall;
   PSCFI_ecfCargaAliqSelect = function(byPosTab:LPSTR; szTipo:LPSTR; szAliquota:LPSTR ): integer; stdcall;
   PSCFI_ecfVenda_Item = function(szCodigo: LPSTR; szDescricao: LPSTR; szQInteira: LPSTR; szQFracionada: LPSTR; szValor: LPSTR; byTaxa: integer): integer; stdcall;
   PSCFI_ecfVendaItem = function(szDescr: LPSTR; szValor: LPSTR; byTaxa: integer): integer; stdcall;
   PSCFI_ecfVendaItem78 = function(szDescr: LPSTR; szValor:LPSTR; byTaxa: integer): integer;stdcall;
   PSCFI_ecfVendaItem3d = function(szCodigo: LPSTR; szDescricao:LPSTR; szQuantidade:LPSTR; szValor:LPSTR; byTaxa:integer; szUnidade:LPSTR; szDigito:LPSTR): integer;stdcall;
   PSCFI_ecfDescItem = function(byTipo: integer; szDescr: LPSTR; szValor: LPSTR): integer; stdcall;
   PSCFI_ecfPagCancPag = function(byTipo: integer; szDescr: LPSTR; szValor: LPSTR; byMens: integer; byLmens: integer): integer; stdcall;
   PSCFI_ecfCancItem = function(szDescr: LPSTR): integer; stdcall;
   PSCFI_ecfAcertaData = function(dia: integer; mes: integer; ano: integer; hor: integer; min: integer; seg: integer): integer; stdcall;
   PSCFI_ecfCancVenda = function(operador: LPSTR): integer; stdcall;
   PSCFI_ecfCancItemDef = function(szItem: LPSTR; szDescr: LPSTR): integer; stdcall;
   PSCFI_ecfSubTotal = function: integer; stdcall;
   PSCFI_ecfCancAcresDescSubTotal = function(byAcres: integer; byTipo: integer; szDescr: LPSTR; szValor: LPSTR): integer; stdcall;
   PSCFI_ecfAutentica = function(operador: LPSTR): integer; stdcall;
   PSCFI_ecfImpCheque = function( nbanco:integer; szValor:LPSTR; szNominal:LPSTR; szCidade:LPSTR;szData:LPSTR;szCamEsp:LPSTR): integer;stdcall;
   PSCFI_ecfImpChequeTPrint = function( nbanco:integer; szValor:LPSTR; szNominal:LPSTR; szCidade:LPSTR;szData:LPSTR;szCamEsp:LPSTR): integer;stdcall;
   PSCFI_ecfChequeDPrint300 = function( nbanco:integer; szValor:LPSTR; szNominal:LPSTR; szCidade:LPSTR;szData:LPSTR;szCamEsp:LPSTR;szMoedaSing:LPSTR;szMoedaPlural:LPSTR): integer; stdcall;
   PSCFI_ecfFimTransVinc = function(operador: LPSTR; vincvias: LPSTR): integer;stdcall;
   PSCFI_ecfRZGerencial = function(operador: LPSTR): integer;stdcall;
   PSCFI_ecfLXGerencial = function(operador: LPSTR): integer;stdcall;
   PSCFI_ecfProgNFComprov = function( szPosTab:LPSTR; szTitulo:LPSTR;szDesconto:LPSTR;szAcres:LPSTR;szCancel:LPSTR;szComPag:LPSTR;szVinculado:LPSTR;szVinculo:LPSTR): integer;stdcall;
   PSCFI_ecfInicCNFVinculado = function(order: LPSTR; postab:LPSTR; valor:LPSTR): integer;stdcall;
   PSCFI_ecfPrazoCancPrazo = function(byTipo: integer; szDescr:LPSTR; szValor:LPSTR; byMens:integer;byLmens:integer): integer;stdcall;
   PSCFI_ecfPagamento = function(byTipo: integer; szPos:LPSTR; szValor:LPSTR; byLmens:integer): integer;stdcall;
   PSCFI_ecfPayPatterns = function(szPosTab:LPSTR; szValor:LPSTR): integer;stdcall;
   PSCFI_ecfStatusDocsNFs = function(postab:integer): PChar;stdcall;
   PSCFI_ecfStatusEquipo = function : PChar;stdcall;


   { =======================  SCHALTER3D  ================== }
   PSchalter3D_FimTransVinc = function(Operador: LPSTR; NRVinculados: LPSTR): integer; stdcall;
   PSchalter3D_FimTrans = function(operador: LPSTR): integer; stdcall;
   PSchalter3D_ProgNFComprov = function(szPosTab, szTitulo, szDesconto, szAcres, szCancel, szComPag, szVinculado, szVinculo: LPSTR): integer; stdcall;
   PSchalter3D_StatusDocsNFs = function(item: Integer): LPSTR; stdcall;
   PSchalter3D_InicCNFVinculado = function(order: LPSTR; postab: LPSTR; valor: LPSTR): integer; stdcall;
   PSchalter3D_PayPatterns = function(szPosTab: LPSTR; szValor: LPSTR): integer; stdcall;
   PSchalter3D_ChangePort = function(chose: integer): integer; stdcall;
   PSchalter3D_StatusEquipo = function: PChar; stdcall;
   PSchalter3D_AbreGaveta = function: integer; stdcall;
   PSchalter3D_LeituraX = function(operador: LPSTR): integer; stdcall;
   PSchalter3D_ReducaoZ = function(operador: LPSTR): integer; stdcall;
   PSchalter3D_CancDoc = function(operador: LPSTR): integer; stdcall;
   PSchalter3D_CancVenda = function(operador: LPSTR): integer; stdcall;
   PSchalter3D_LineFeed = function(byEst: integer; wLin: integer): integer; stdcall;
   PSchalter3D_ImpLinha = function(szLinha: LPSTR): integer; stdcall;
   PSchalter3D_Autentica = function(operador: LPSTR): integer; stdcall;
   PSchalter3D_StatusImp = function: PChar; stdcall;
   PSchalter3D_StatusCupom = function(general_flag: integer): PChar; stdcall;
   PSchalter3D_ImpCab = function(byEst: integer): integer; stdcall;
   PSchalter3D_InicCupomNFiscal = function(byEst: integer): integer; stdcall;
   PSchalter3D_Venda_Item =  function(szCodigo: LPSTR; szDescricao:LPSTR; szQuantidade:LPSTR; szValor:LPSTR; byTaxa:integer; szUnidade:LPSTR; szDigito:LPSTR): Integer;stdcall;
   PSchalter3D_DescItem = function(byTipo: integer; szDescr: LPSTR; szValor: LPSTR): integer; stdcall;
   PSchalter3D_CancItem = function(szDescr: LPSTR): integer; stdcall;
   PSchalter3D_PagCancPag = function(byTipo: integer; szDescr: LPSTR; szValor: LPSTR; byMens: integer; byLmens: integer): integer; stdcall;
   PSchalter3D_PrazoCancPrazo = function(byTipo: integer; szDescr: LPSTR; szValor: LPSTR; byMens: integer; byLmens: integer): integer; stdcall;
   PSchalter3D_SubTotal = function: integer; stdcall;
   PSchalter3D_CancAcresDescSubTotal = function(byAcres: integer; byTipo: integer; szDescr: LPSTR; szValor: LPSTR): integer; stdcall;
   PSchalter3D_LeitMemFisc = function(byTipo: integer; szDi: LPSTR; szDf: LPSTR; wRi: integer; wRf: integer; archive: LPSTR): integer; stdcall;
   PSchalter3D_LeitXSer = function(szDados: pointer): integer; stdcall;
   PSchalter3D_LeituraXSerial = function: PChar; stdcall;
   PSchalter3D_AcertaData = function(dia: integer; mes: integer; ano: integer; hor: integer; min: integer; seg: integer): integer; stdcall;
   PSchalter3D_CancItemDef = function(szItem: LPSTR; szDescr: LPSTR): integer; stdcall;
   PSchalter3D_ImpCheque = function(nbanco: integer; szValor: LPSTR; szNominal: LPSTR; szCidade: LPSTR; szData: LPSTR; szCamEsp: LPSTR): integer; stdcall;
   PSchalter3D_ImpChequeTPrint = function(nbanco: integer; szValor: LPSTR; szNominal: LPSTR; szCidade: LPSTR; szData: LPSTR; szCamEsp: LPSTR): integer; stdcall;
   PSchalter3D_ChequeDPrint300 = function(nbanco: integer; szValor: LPSTR; szNominal: LPSTR; szCidade: LPSTR; szData: LPSTR; szCamEsp: LPSTR; szMoedaSing: LPSTR; szMoedaPlural: LPSTR): integer; stdcall;
   PSchalter3D_LXGerencial = function(operador: LPSTR): integer; stdcall;
   PSchalter3D_Pagamento = function(byTipo: integer; szPos: LPSTR; szValor: LPSTR; byLmens: integer): integer; stdcall;
   PSchalter3D_ParamStatusEquipo = function( Marca, Modelo, Versao, NSerie: PChar): Integer;

   { =======================  URANO1FIT  ================== }
   PUrano1FIT_LeituraMF = function(tipo, inicio, fim, proprietario, arquivo: string): integer; stdcall;
   PUrano1FIT_LogSerial = function(ligdes: string): integer; stdcall;
   PUrano1FIT_LeSensor = function(sensor: string): integer; stdcall;
   PUrano1FIT_InicializaDLL = function(Porta: string): integer; stdcall;
   PUrano1FIT_FinalizaDLL = function: integer; stdcall;
   PUrano1FIT_AvancaLinhas = function(linhas: string): Integer; stdcall;
   PUrano1FIT_EstadoImpressora = function: integer; stdcall;
   PUrano1FIT_AbreGaveta = function: integer; stdcall;
   PUrano1FIT_LeRegistradores = function(regist, valor: PChar): integer; stdcall;
   PUrano1FIT_VendaItem = function(Cod, Descr, Quant, Preco, SitTrib, Unid, Tipo: string): integer; stdcall;
   PUrano1FIT_CancelaVenda = function(operador: string): integer; stdcall;
   PUrano1FIT_CancelaCupom = function(Operador: string): integer; stdcall;
   PUrano1FIT_Relatorio_XZ = function(tipo: string): integer; stdcall;
   PUrano1FIT_FechaCupom = function(Operador: string): integer; stdcall;
   PUrano1FIT_Pagamento = function(Format, Descr, Valor: string): integer; stdcall;
   PUrano1FIT_ImprimeCabecalho = function: integer; stdcall;
   PUrano1FIT_Propaganda = function(linhas: string): integer; stdcall;
   PUrano1FIT_CargaCliche = function(attr, linha1, linha2, linha3, loja, seq: string): integer; stdcall;
   PUrano1FIT_IdComprador = function(linha1, tipodoc, doc, linha2, linha3: string): integer; stdcall;
   PUrano1FIT_CargaAliquota = function(aliquota, valor: string): integer; stdcall;
   PUrano1FIT_LeECF = function(tipo, inicio, fim, proprietario, arquivo: string): integer; stdcall;
   PUrano1FIT_CancelaItem = function(Transacao: string): integer; stdcall;
   PUrano1FIT_AcrescimoSubtotal = function(descr, valor: string): integer; stdcall;
   PUrano1FIT_DescontoSubtotal = function(descr, valor: string): integer; stdcall;
   PUrano1FIT_DescontoItem = function(oper, descr, valor: string): integer; stdcall;
   PUrano1FIT_ProgramaRelogio = function(tipo, data, hora: string): integer; stdcall;
   PUrano1FIT_FormaPagamento = function(Forma, descr: string): integer; stdcall;
   PUrano1FIT_CargaNaoVinculado = function(codigo, descr, entrada: string): integer; stdcall;
   PUrano1FIT_EspacamentoLinhas = function(espacamento: Integer): integer; stdcall;
   PUrano1FIT_VinculadoTEF = function(seq, cartao, autoriz, texto, espacamento, tempo: string): integer; stdcall;
   PUrano1FIT_Autentica = function(texto: string): integer; stdcall;
   PUrano1FIT_CupomStub = function(operador: string): integer; stdcall;
   PUrano1FIT_ImprimeCheque = function(valor, favorecido, cidade, mensagem, datacheque, moeda, plural, banc, nomearq: string): integer; stdcall;
   PUrano1FIT_NovoEstabelecimento = function(cgc, ie, im: string): integer; stdcall;
   PUrano1FIT_VinculadoCartao = function(seq, cartao, validade, autoriz, texto, espacamento, tempo: string): integer; stdcall;
   PUrano1FIT_Mecanismo = function(tipo: string): integer; stdcall;
   PUrano1FIT_EmiteNaoVinculado = function(codigo, descr, valor: string): integer; stdcall;
   PUrano1FIT_FinalizaRelatorio = function: integer; stdcall;
   PUrano1FIT_CortaPapel = function: integer; stdcall;
   PUrano1FIT_LinhasLivres = function(tamanho, texto: string): integer; stdcall;
   PUrano1FIT_Vinculado = function(seq, doc, autoriz, nome, duas_vias, texto, espacamento, tempo: string): integer; stdcall;
   PUrano1FIT_Rascunho = function(texto: string): integer; stdcall;
   PUrano1FIT_ContrasteTermico = function(operacao: string): integer; stdcall;
   PUrano1FIT_VinculadoNSeq = function(COO, SequenciaFinalizadora, NomeVinculado: string): integer; stdcall;
   { =======================  URANOEFC  ================== }
   PUranoEFC_InicializaDLL = function(com: PChar): integer; stdcall;
   PUranoEFC_LeituraMF = function(tipo, dtini, dtfinal, redini, redfinal: string): integer; stdcall;
   PUranoEFC_FinalizaDLL = function: integer; stdcall;
   PUranoEFC_DescontoItem = function(oper, descr, valor: string): integer; stdcall;
   PUranoEFC_EstadoImpressora = function: integer; stdcall;
   PUranoEFC_FormaPagamento = function(forma, descr: string): integer; stdcall;
   PUranoEFC_ImprimeCabecalho = function: integer; stdcall;
   PUranoEFC_VendaItem = function(codigo, descr, qtd, preco, st, un, tipo: string): integer; stdcall;
   PUranoEFC_CancelaItem = function(descr, trans: PChar): integer; stdcall;
   PUranoEFC_Pagamento = function(Forma, Descr, Valor, Acumular: string): integer; stdcall;
   PUranoEFC_EmiteVinculado = function(COO, seq: string): integer; stdcall;
   PUranoEFC_EmiteNaoVinculado = function(codigo, descr, valor: string): integer; stdcall;
   PUranoEFC_FechaCupom = function(operador: string): integer; stdcall;
   PUranoEFC_LinhasLivres = function(texto: string): integer; stdcall;
   PUranoEFC_CancelaVenda = function(oper: string): integer; stdcall;
   PUranoEFC_CancelaCupom = function(tipo, oper: string): integer; stdcall;
   PUranoEFC_DescontoSubtotal = function(oper, descr, valor: string): integer; stdcall;
   PUranoEFC_AcrescimoSubtotal = function(oper, descr, valor: string): integer; stdcall;
   PUranoEFC_Relatorio_XZ = function(tipo: string): integer; stdcall;
   PUranoEFC_FinalizaRelatorio = function(operador: string): integer; stdcall;
   PUranoEFC_propaganda = function(atrib, texto: PChar): integer; stdcall;
   PUranoEFC_ProgramaRelogio = function(tipo, data, hora: string): integer; stdcall;
   PUranoEFC_AbreGaveta = function: integer; stdcall;
   PUranoEFC_AvancaLinhas = function(linhas: string): integer; stdcall;
   PUranoEFC_LeRegistradores = function(regist, valor: PChar): integer; stdcall;
   PUranoEFC_Autentica = function: integer; stdcall;
   PUranoEFC_LeSensor = function(sensor: string): integer; stdcall;
   PUranoEFC_IdComprador = function(nome, tipo, cpfcgc, linha1, linha2: string): integer; stdcall;
   PUranoEFC_CupomStub = function(oper: PChar): integer; stdcall;
   PUranoEFC_SimboloMoeda = function(simbmoeda: PChar): integer; stdcall;
   PUranoEFC_ConfiguraCabRodape = function(flag: char): integer; stdcall;
   PUranoEFC_VersaoBiblioteca = function(versao: PChar): integer; stdcall;
   PUranoEFC_ImprimeCheque = function(nomearq, banco, valor, favorecido, cidade, mensagem, datacheque: string): integer; stdcall;
   PUranoEFC_EspacamentoLinhas = function(tipo: string): integer; stdcall;
   PUranoEFC_ConfiguraDocFiscal = function(tipo: integer): integer;
   PUranoEFC_NomeMoeda = function(singular, plural: string): integer; stdcall;
   PUranoEFC_HabVinculadoNSeq = function(flag: string): integer; stdcall;
   PUranoEFC_CargaNaoVinculado = function(codigo, descr: string): integer; stdcall;
   UranoECF_NomeMoeda = function(singular, plural: PChar): integer; stdcall;
   { =======================  SCHALTER2S  ================== }
   PSchalter2S_ecfLeitMemFisc = function(byTipo: integer; szDi: LPSTR; szDf: LPSTR; wRi: integer; wRf: integer; archive: LPSTR): Integer; cdecl;
   PSchalter2S_ChangePort = function(choose: integer): integer; cdecl;
   PSchalter2S_ecfStatusCupom = function(var general_flag: integer): PChar; cdecl;
   PSchalter2S_ecfLeituraXSerial = function: PChar; cdecl;
   PSchalter2S_ecfStatusImp = function: PChar; cdecl;
   PSchalter2S_ecfAbreGaveta = function: integer; cdecl;
   PSchalter2S_ecfReducaoZ = function(operador: LPSTR): integer; cdecl;
   PSchalter2S_ecfLineFeed = function(byEst: integer; wLin: integer): integer; cdecl;
   PSchalter2S_ecfLeituraX = function(operador: LPSTR): integer; cdecl;
   PSchalter2S_ecfCancDoc = function(operador: LPSTR): integer; cdecl;
   PSchalter2S_ecfInicCupomNFiscal = function(byEst: integer): integer; cdecl;
   PSchalter2S_ecfImpLinha = function(szLinha: LPSTR): integer; cdecl;
   PSchalter2S_ecfFimTrans = function(operador: LPSTR): integer; cdecl;
   PSchalter2S_ecfImpCab = function(byEst: integer): integer; cdecl;
   PSchalter2S_ecfVenda_Item = function(szCodigo: LPSTR; szDescricao: LPSTR; szQInteira: LPSTR; szQFracionada: LPSTR; szValor: LPSTR; byTaxa: integer): integer; cdecl;
   PSchalter2S_ecfVendaItem = function(szDescr: LPSTR; szValor: LPSTR; byTaxa: integer): integer; cdecl;
   PSchalter2S_ecfDescItem = function(byTipo: integer; szDescr: LPSTR; szValor: LPSTR): integer; cdecl;
   PSchalter2S_ecfPagCancPag = function(byTipo: integer; szDescr: LPSTR; szValor: LPSTR; byMens: integer; byLmens: integer): integer; cdecl;
   PSchalter2S_ecfCancItem = function(szDescr: LPSTR): integer; cdecl;
   PSchalter2S_ecfAcertaData = function(dia: integer; mes: integer; ano: integer; hor: integer; min: integer; seg: integer): integer; cdecl;
   PSchalter2S_ecfCancVenda = function(operador: LPSTR): integer; cdecl;
   PSchalter2S_ecfCancItemDef = function(szItem: LPSTR; szDescr: LPSTR): integer; cdecl;
   PSchalter2S_ecfSubTotal = function: integer; cdecl;
   PSchalter2S_ecfCancAcresDescSubTotal = function(byAcres: integer; byTipo: integer; szDescr: LPSTR; szValor: LPSTR): integer; cdecl;
   PSchalter2S_ecfAutentica = function(operador: LPSTR): integer; cdecl;
   { =======================  DATAREGIS  ================== }
   PDataregis_AbrePorta = function(Porta: integer): Integer;
   PDataregis_FechaPorta = function: Integer;
   PDataregis_EnviaComando = function(data: string): Pchar;
   { =======================  PROCOMP  ================== }
   PProcomp_DescontoItem = function(toper, valor, legop: string): integer; stdcall;
   PProcomp_OpenCIF = function: integer; stdcall;
   PProcomp_CloseCIF = function: integer; stdcall;
   PProcomp_AbreCupomFiscal = function: integer; stdcall;
   PProcomp_AbreCupomVinculado = function: integer; stdcall;
   PProcomp_VendaItem = function(pFormat, pQtde, pPrcUnit, pTrib, pDesc, pVlrDesc, pUnidade, pCodigo, pTamDescr, pDescr, pLegenda: string): integer; stdcall;
   PProcomp_CancelamentoItem = function(pNumItem: string): Integer; stdcall;
   PProcomp_ObtemRetorno = function(pBuf_Ret: Pointer): Integer; stdcall;
   PProcomp_TotalizarCupom = function(pOper: PChar; pTOper, pValor, pLegenda: string): Integer; stdcall;
   PProcomp_Pagamento = function(pReg, pVPgto, pSubtr: string): Integer; stdcall;
   PProcomp_FechaCupomFiscal = function(pTamMsg, pMsg: string): Integer; stdcall;
   PProcomp_CancelaCupomFiscal = function: Integer; stdcall;
   PProcomp_LeituraX = function(pRelGer: string): Integer; stdcall;
   PProcomp_ReducaoZ = function(pRelGer: string): Integer; stdcall;
   PProcomp_LeMemFiscalData = function(pDataI, pDataF, pRes: string): Integer; stdcall;
   PProcomp_LeMemFiscalReducao = function(pRedI, pRedF, pRes: string): Integer; stdcall;
   PProcomp_AbreCupomNaoVinculado = function: Integer; stdcall;
   PProcomp_EncerrarCupom = function: Integer; stdcall;
   PProcomp_ImprimeLinhaNaoFiscal = function(pAtrib, pString: string): Integer; stdcall;
   PProcomp_TransStatus = function(iBitTeste: Byte; pBuffer: Pointer): Integer; stdcall;
   PProcomp_ECFPar = function: Integer; stdcall;
   PProcomp_ECFParEsp = function(pPar: string): Integer; stdcall;
   PProcomp_ECFID = function: Integer; stdcall;
   PProcomp_TransTabAliquotas = function: integer; stdcall;
   PProcomp_AbrirGaveta = function(Tipo, Ton, Toff: string): integer; stdcall;
   PProcomp_ProgramaHorarioVerao = function(LigaDesliga: string): integer; stdcall;
   PProcomp_AvancaLinha = function: Integer; stdcall;
   PProcomp_ProgLinhaAdicional = function(Texto: string): Integer; stdcall;
   PProcomp_ModoChequeValidacao = function(Tipo, Load: string): integer; stdcall;
   PProcomp_ImprimeValidacao = function(Leg, LinhaOP: string): integer; stdcall;
   PProcomp_TransDataHora = function: integer; stdcall;
   { =======================  TRENDS  ================== }
   PTrends_ModoChequeValidacao = function(Tipo: string; Load: string; Retorno: string): Integer; stdcall;
   PTrends_ImprimeCheque = function(Retorno: string): Integer; stdcall;
   PTrends_ImprimeValidacao = function(Leg: string; LinhaOp: string; Retorno: string): Integer; stdcall;
   PTrends_CancelaChequeValidacao = function(Retorno: string): Integer; stdcall;
   PTrends_TotalizarCupomParcial = function(Retorno: string): Integer; stdcall;
   PTrends_TotalizarCupom = function(Oper: string; Toper: string; Valor: string; LegendaOp: string; Retorno: string): Integer; stdcall;
   PTrends_Pagamento = function(Reg: string; Valor: string; Subt: string; Retorno: string): Integer; stdcall;
   PTrends_FechaCupomFiscal = function(Msg: string; Retorno: string): Integer; stdcall;
   PTrends_DescontoItem = function(Desc: string; Valor: string; LegendaOp: string; Retorno: string): Integer; stdcall;
   PTrends_AbreCupomFiscal = function(Retorno: string): Integer; stdcall;
   PTrends_VendaItem = function(Fmt: string; Qtde: string; ValUnit: string; Trib: string; Desc: string; Valor: string; Unid: string; Cod: string; Ex: string; Descricao: string; LegendaOp: string; Retorno: string): Integer; stdcall;
   PTrends_CancelamentoItem = function(Item: string; Retorno: string): Integer; stdcall;
   PTrends_CancelaCupomFiscal = function(Retorno: string): Integer; stdcall;
   PTrends_LeituraX = function(RelGer: string; Retorno: string): Integer; stdcall;
   PTrends_ReducaoZ = function(RelGer: string; Retorno: string): Integer; stdcall;
   PTrends_LeMemFiscalData = function(DataI: string; DataF: string; Res: string; Retorno: string): Integer; stdcall;
   PTrends_LeMemFiscalReducao = function(RedI: string; RedF: string; Res: string; Retorno: string): Integer; stdcall;
   PTrends_AbreCupomVinculado = function(Retorno: string): Integer; stdcall;
   PTrends_EncerraCupomNaoFiscal = function(Retorno: string): Integer; stdcall;
   PTrends_AbreCupomNaoVinculado = function(Retorno: string): Integer; stdcall;
   PTrends_OperRegNaoVinculado = function(Reg: string; Valor: string; Oper: string; Toper: string; ValorOp: string; LegendaOp: string; Retorno: string): Integer; stdcall;
   PTrends_CancelaCupomNaoFiscal = function(Retorno: string): Integer; stdcall;
   PTrends_ImprimeLinhaNaoFiscal = function(Atrib: string; Linha: string; Retorno: string): Integer; stdcall;
   PTrends_ProgramaLegenda = function(Reg: string; Leg: string; Retorno: string): Integer; stdcall;
   PTrends_AbrirGaveta = function(Tipo: string; Ton: string; Toff: string; Retorno: string): Integer; stdcall;
   PTrends_ProgramaHorarioVerao = function(Hv: string; Retorno: string): Integer; stdcall;
   PTrends_ImprimeTotalizadores = function(Reg: string; Retorno: string): Integer; stdcall;
   PTrends_TransTabAliquotas = function(Retorno: string): Integer; stdcall;
   PTrends_TransTotCont = function(Retorno: string): Integer; stdcall;
   PTrends_TransStatusDecod = function(Retorno: string): Integer; stdcall;
   PTrends_TransDataHora = function(Retorno: string): Integer; stdcall;
   PTrends_EcfPar = function(Par: string; Retorno: string): Integer; stdcall;
   PTrends_ProgLinhaAdicional = function(Leg: string; Retorno: string): Integer; stdcall;
   PTrends_AjusteHora = function(Dir: string; Hora: string; Retorno: string): Integer; stdcall;
   PTrends_EcfID = function(Retorno: string): Integer; stdcall;
   PTrends_ProgRelogio = function(Hora: string; Data: string; Retorno: string): Integer; stdcall;
   PTrends_GravaDados = function(CGC: string; IE: string; CCM: string; Retorno: string): Integer; stdcall;
   PTrends_RecompoeDadosNOVRAM = function(Retorno: string): Integer; stdcall;
   PTrends_ProgNumSerie = function(NumSerie: string; Modelo: string; Retorno: string): Integer; stdcall;
   PTrends_ProgAliquotas = function(Trib: string; Valor: string; Retorno: string): Integer; stdcall;
   PTrends_ProgSimbolo = function(B1: string; B2: string; B3: string; B4: string; B5: string; B6: string; B7: string; B8: string; B9: string; B10: string; Hab: string; Retorno: string): Integer; stdcall;
   PTrends_ProgRazaoSocial = function(Razao: string; Nseq: string; Retorno: string): Integer; stdcall;
   PTrends_ProgMoeda = function(Retorno: string; Sing: string; Plural: string): Integer; stdcall;
   PTrends_ProgArredondamento = function(Par: string; Retorno: string): Integer; stdcall;
   { ==================================================================================================== }


  (* Tipos Utilizados pela interface AFRAC *)

  TPontoFlutuante  = array[0..16] of char;
  TBooleano        = array[0..1] of char;
  TInteiro         = array[0..6] of char;
  TAcreDesc        = array[0..1] of char;
  TData            = array[0..8] of char;
  THora            = array[0..6] of char;
  TTexto           = PChar;
  TFormato         = array[0..4] of char;
  TTributacaoAFRAC = array[0..5] of char;
  TTextoFormatado  = PChar;
  TPercValor       = array[0..1] of char;
  Inteiro          = Integer;


  (* Funções de Venda AFRAC *)

  TAFRAC_AbrirCupom                         = function(): Integer;stdcall;
  {TAFRAC_VenderItem                         = function(Codigo: TTexto; Descricao: TTexto;
                                                       Trunca: TBooleano; Quantidade: TPontoFlutuante;
                                                       Valor_Unitario: TPontoFlutuante;
                                                       Acre_Desc: TAcreDesc; Perc_valor: TPercValor;
                                                       Valor_Acredesc: TPontoFlutuante;
                                                       Valor_Total: TPontoFlutuante; Aliquota: TTributacaoAFRAC;
                                                       Unidade: TTexto; Linha_Simples: TBooleano): Integer;StdCall;}
  TAFRAC_VenderItem                         = function(Codigo,
                                                       Descricao,
                                                       {Trunca,}
                                                       Quantidade,
                                                       Valor_Unitario,
                                                       Acre_Desc,
                                                       Perc_valor,
                                                       Valor_Acredesc,
                                                       Valor_Total,
                                                       Aliquota,
                                                       Unidade,
                                                       Linha_Simples: PChar): Integer;stdCall;
  TAFRAC_AcrescimoDescontoItem              = function(Acre_Desc: TAcreDesc; Perc_valor: TPercValor;
                                                       Valor_Acredesc: TPontoFlutuante;
                                                       Descricao: TTexto) : Integer;stdCall;
  TAFRAC_CancelarItem                       = function(NumeroItem: PChar) : Integer;stdCall;
  TAFRAC_AcrescimoDescontoCupom             = function(Acre_Desc, Perc_Valor, Valor_Acredesc, Descricao: PChar) : Integer;stdCall;
  TAFRAC_FecharAcrescimoDesconto            = function(Padrao_Acre, Padrao_Desc, Valor_Acredesc: PChar): Integer;stdCall;
  TAFRAC_FormaPagamento                     = function(Descricao, Indice, Valor, Texto_Comp: PChar) : Integer;stdcall;
  TAFRAC_InformarCNPJ                       = function(CNPJ: PChar): Integer;stdcall;
  TAFRAC_InformarRazaoSocial                = function(Razao_Social: TTexto): Integer;stdcall;
  TAFRAC_InformarInscricao                  = function(Incricao: TTexto): Integer;stdcall;
  TAFRAC_InformarEndereco                   = function(Endereco: TTexto): Integer;stdcall;
  TAFRAC_InformarGerente                    = function(Gerente: TTexto): Integer;stdcall;
  TAFRAC_InformarOperador                   = function(Operador: TTexto): Integer;stdcall;
  TAFRAC_InformarVendedor                   = function(Vendedor: TTexto): Integer;stdcall;
  TAFRAC_InformarMensagemCupom              = function(Mensagem: TTexto): Integer;stdcall;
  TAFRAC_FecharCupom                        = function(Vinculado: PChar): Integer;stdcall;
  //TAFRAC_CancelarCupom                      = function(COO: PChar): Integer; stdcall;
  TAFRAC_CancelarCupom                      = function: Integer; stdcall;

  (* Funcoes de Configuração e Relatórios AFRAC *)

  TAFRAC_AbrirVinculado                      = function(COO, Forma_Pagamento, Valor: PChar): Integer;stdcall;
  TAFRAC_ImprimirVinculado                   = function(Linha1, Linha2: PChar): Integer;stdcall;
  TAFRAC_FecharVinculado                     = function(): Integer;stdcall;
  TAFRAC_CancelarVinculado                   = function(): Integer;stdcall;
  TAFRAC_AbrirNaoFiscalNaoVinculado          = function(): Integer;stdcall;
  TAFRAC_RegistrarNaoFiscal                  = function(Indice: TTexto; Valor: TPontoFlutuante;
                                                        Descricao: TTexto): Integer;stdcall;
  TAFRAC_CancelarNaoVinculado                = function(): Integer;stdcall;
  TAFRAC_AbrirRelatorioGerencial             = function(Indice: TTexto): Integer;stdcall;
  TAFRAC_ImprimirRelatorioGerencial          = function(Texto: PChar): Integer;stdcall;
  TAFRAC_FecharRelatorioGerencial            = function(): Integer;stdcall;
  TAFRAC_LeituraX                            = function(): Integer;stdcall;
  TAFRAC_ReducaoZ                            = function(Data: PChar): Integer;stdcall;
  TAFRAC_EmitirLeituraMemoriaFiscal          = function(Tipo, Inicial, Final: TTexto): Integer;stdcall;
  TAFRAC_GravarLeituraX                      = function(Arquivo: TTexto): Integer;stdcall;
  TAFRAC_GravarLeituraMemoriaFiscal          = function(Tipo, Inicial, Final, Arquivo: TTexto): Integer;stdcall;


  (* Funcoes de Status e Informações AFRAC *)

  TAFRAC_LerInformacaoImpressora             = function(InfoID, Retorno: PChar): Integer;stdcall;
  TAFRAC_LerAliquotas                        = function(Retorno: TTexto): Integer;stdcall;
  TAFRAC_LerValorTotalAliquotas              = function(Retorno: TTexto): Integer;stdcall;
  TAFRAC_LerTotalizadoresNSICMS              = function(Retorno: TTexto): Integer;stdcall;
  TAFRAC_LerTodasFormasPagamento             = function(Retorno: TTexto): Integer;stdcall;
  TAFRAC_AbrirPorta                          = function(Porta: TTexto): Integer;stdcall;
  TAFRAC_FecharPorta                         = function(): Integer;stdcall;
  TAFRAC_VerificarEstado                     = function(Estado: PChar): Integer;stdcall;
  TAFRAC_Retornar_Features                   = function(Features: TTexto): Integer;stdcall;
  TAFRAC_PegarCodigoErro                     = function(CodigoErro, Mensagem, Acao: PChar): Integer;stdcall;
  TAFRAC_ConfigurarFonte                     = function(CodigoFonte: TTexto): Integer;stdcall;
  TAFRAC_InformarFonte                       = function(): Integer;stdcall;
  TAFRAC_Configura                           = function(): Integer;stdcall;
  TAFRAC_Indice                              = function(NumFuncion, Parametros, Retorno: TTexto): Integer;stdcall;
  TAFRAC_Fabricante                          = function(Entrada, Saida: TTexto): Integer;stdcall;


  (* Funcoes Auxiliares AFRAC *)

  TAFRAC_Autenticar                          = function(Linha, Mensagem: TTexto): Integer;stdcall;
  TAFRAC_RepetirAutenticacao                 = function(): Integer;stdcall;
  TAFRAC_AbrirGaveta                         = function(): Integer;stdcall;
  TAFRAC_VerificarGaveta                     = function(Estado: TTexto): Integer;stdcall;
  TAFRAC_ChequeProgramarMoeda                = function(Moeda_Singular, MoedaPlural: TTexto): Integer;stdcall;
  TAFRAC_ChequeImprimir                      = function(Banco, Valor, Favorecido, Cidade, Data, BomPara: PChar): Integer;stdcall;
  TAFRAC_ChequeConfigurarFormatacao          = function(FormatoValor, FormatoExtenso, FormatoFavorecido, FormatoCidade,
                                                        FormatoData, FormatoBomPara: TFormato;
                                                        CruzarCheque: TBooleano): Integer;stdcall;

  TAFRAC_ChequeImprimirVerso                 = function(PrimeiraLinha, SegundaLinha: TTexto): Integer;stdcall;
  TAFRAC_ChequeLerCMC7                       = function(CMC7Lido: TTexto): Integer;stdcall;
  TAFRAC_ChequeExpulsar                      = function(): Integer;stdcall;
  TAFRAC_ProgramarTributacao                 = function(Tributacao: TTributacaoAFRAC): Integer;stdcall;
  TAFRAC_EntrarHorarioVerao                  = function(): Integer;stdcall;
  TAFRAC_SairHorarioVerao                    = function(): Integer;stdcall;
  TAFRAC_AjustarRelogio                      = function(Horario: THora): Integer;stdcall;
  TAFRAC_ArredondarTruncar                   = function(Comportamento: TInteiro): Integer;stdcall;
  TAFRAC_ForcarImpactoAgulhas                = function(Forca: TBooleano): Integer;stdcall;
  TAFRAC_ConfigurarLinhasEntreCupons         = function(QuantasLinhas: TInteiro): Integer;stdcall;
  TAFRAC_ProgramarTotalizadorNaoSujeitoICMS  = function(Indice, Nome, TipoOperacao, Grupo: TTexto;
                                                       Vinculado, AceitaPagamento: TBooleano;
                                                       IndicedoPagamento: TTexto): Integer;stdcall;

  TAFRAC_ProgramarRelatorioGerencial         = function(Indice, Nome: TTexto): Integer;stdcall;
  TAFRAC_LerIndiceRelatorioGerencial         = function(Indice, Nome: TTexto): Integer;stdcall;
  TAFRAC_ProgramarFormasDePagamento          = function(Indice, Nome, Vinculado: PChar): Integer;stdcall;
  TAFRAC_LerFormasDePagamento                 = function(Indice, Nome: PChar): Integer;stdcall;
  TAFRAC_SetaPadrao                          = function(Versao: TTexto): Integer;stdcall;
  TAFRAC_AbrirDia                            = function(Data: PChar): Integer;stdcall;

  TDaruma_FI_AbreCupom = function( CPF_ou_CNPJ: String ): Integer; StdCall;
  TDaruma_FI_VendeItem = function( Codigo: String; Descricao: String; Aliquota: String; Tipo_de_Quantidade: String; Quantidade: String; Casas_Decimais: Integer; Valor_Unitario: String; Tipo_de_Desconto: String; Valor_do_Desconto: String ): Integer; StdCall;
  TDaruma_FI_VendeItemDepartamento = function( Codigo: String; Descricao: String; Aliquota: String; Valor_Unitario: String; Quantidade: String; Valor_do_Desconto: String; Valor_do_Acrescimo: String; Indice_Departamento: String; Unidade_Medida: String ): Integer; StdCall;
  TDaruma_FI_VendeItemTresDecimais = function( Codigo: String; Descricao: String; Aliquota: String; Quantidade: String; Valor_Unitario: String; Acrescimo_ou_Desconto: String; Percentual_Acrescimo_ou_Desconto : String ): Integer; StdCall;
  TDaruma_FI_FechaCupomResumido = function( Descricao_da_Forma_de_Pagamento: String; Mensagem_Promocional: String ): Integer; StdCall;
  TDaruma_FI_IniciaFechamentoCupom = function( Acrescimo_ou_Desconto: String; Tipo_do_Acrescimo_ou_Desconto: String; Valor_do_Acrescimo_ou_Desconto: String ): Integer; StdCall;
  TDaruma_FI_EfetuaFormaPagamento = function( Descricao_da_Forma_Pagamento: String; Valor_da_Forma_Pagamento: String ): Integer; StdCall;
  TDaruma_FI_EfetuaFormaPagamentoDescricaoForma = function( Descricao_da_Forma_Pagamento: string; Valor_da_Forma_Pagamento: string; Texto_Livre: string ): integer; StdCall;
  TDaruma_FI_IdentificaConsumidor = function( Nome_do_Consumidor: String; Endereco: String; CPF_ou_CNPJ: String ): Integer; StdCall;
  TDaruma_FI_TerminaFechamentoCupom = function( Mensagem_Promocional: String ): Integer; StdCall;
  TDaruma_FI_FechaCupom = function( Forma_de_Pagamento: String; Acrescimo_ou_Desconto: String; Tipo_Acrescimo_ou_Desconto: String; Valor_Acrescimo_ou_Desconto: String; Valor_Pago: String; Mensagem_Promocional: String ): Integer; StdCall;
  TDaruma_FI_CancelaItemAnterior = function: Integer; StdCall;
  TDaruma_FI_CancelaItemGenerico = function( Numero_Item: String ): Integer; StdCall;
  TDaruma_FI_CancelaCupom = function: Integer; StdCall;
  TDaruma_FI_AumentaDescricaoItem = function( Descricao_Extendida: String ): Integer; StdCall;
  TDaruma_FI_UsaUnidadeMedida = function( Unidade_Medida: String ): Integer; StdCall;
  TDaruma_FI_EmitirCupomAdicional = function: Integer; StdCall;
  TDaruma_FI_EstornoFormasPagamento = function( Forma_de_Origem: String; Nova_Forma: String; Valor_Total_Pago: String ): Integer; StdCall;
  TDaruma_FI_AbreComprovanteNaoFiscalVinculado = function( Forma_de_Pagamento: String; Valor_Pago: String; Numero_do_Cupom: String ): Integer; StdCall;
  TDaruma_FI_UsaComprovanteNaoFiscalVinculado = function( Texto_Livre: String ): Integer; StdCall;
  TDaruma_FI_FechaComprovanteNaoFiscalVinculado = function: Integer; StdCall;
  TDaruma_FI_RelatorioGerencial = function( Texto_Livre: String ): Integer; StdCall;
  TDaruma_FI_AbreRelatorioGerencial = function: Integer; StdCall;
  TDaruma_FI_EnviarTextoCNF = function( Texto_Livre: String ): Integer; StdCall;
  TDaruma_FI_FechaRelatorioGerencial = function: Integer; StdCall;
  TDaruma_FI_RecebimentoNaoFiscal = function( Indice_do_Totalizador: String; Valor_do_Recebimento: String; Forma_de_Pagamento: String ): Integer; StdCall;
  TDaruma_FI_AbreRecebimentoNaoFiscal = function( Indice_do_Totalizador: String; Acrescimo_ou_Desconto: String; Tipo_Acrescimo_ou_Desconto: String; Valor_Acrescimo_ou_Desconto: String; Valor_do_Recebimento: String; Texto_Livre: String ): Integer; StdCall;
  TDaruma_FI_EfetuaFormaPagamentoNaoFiscal = function( Forma_de_Pagamento: String; Valor_da_Forma_Pagamento: String; Texto_Livre: String ): Integer; StdCall;
  TDaruma_FI_Sangria = function( Valor_da_Sangria: String ): Integer; StdCall;
  TDaruma_FI_Suprimento = function( Valor_do_Suprimento: String; Forma_de_Pagamento: String ): Integer; StdCall;
  TDaruma_FI_FundoCaixa = function( Valor_do_Fundo_Caixa: String; Forma_de_Pagamento: String ): Integer; StdCall;
  TDaruma_FI_LeituraX = function: Integer; StdCall;
  TDaruma_FI_ReducaoZ = function: Integer; StdCall;
  TDaruma_FI_ReducaoZAjustaDataHora = function( Data: String; Hora: String ): Integer; StdCall;
  TDaruma_FI_LeituraMemoriaFiscalData = function( Data_Inicial: String; Data_Final: String ): Integer; StdCall;
  TDaruma_FI_LeituraMemoriaFiscalReducao = function( Reducao_Inicial: String; Reducao_Final: String ): Integer; StdCall;
  TDaruma_FI_LeituraMemoriaFiscalSerialData = function( Data_Inicial: String; Data_Final: String ): Integer; StdCall;
  TDaruma_FI_LeituraMemoriaFiscalSerialReducao = function( Reducao_Inicial: String; Reducao_Final: String ): Integer; StdCall;
  TDaruma_FI_VerificaDocAutenticacao = function: Integer; StdCall;
  TDaruma_FI_Autenticacao = function: Integer; StdCall;
  TDaruma_FI_AutenticacaoStr = function( Autenticacao_Str :string ): Integer; StdCall;
  TDaruma_FI_VerificaEstadoGaveta = function( Var Estado_Gaveta: Integer ): Integer; StdCall;
  TDaruma_FI_VerificaEstadoGavetaStr = function( Estado_Gaveta: String ): Integer; StdCall;
  TDaruma_FI_AcionaGaveta = function: Integer; StdCall;
  TDaruma_FI_AbrePortaSerial = function: Integer; StdCall;
  TDaruma_FI_FechaPortaSerial = function: Integer; StdCall;
  TDaruma_FI_AberturaDoDia = function( Valor_do_Suprimento: string; Forma_de_Pagamento: string ): Integer; StdCall;
  TDaruma_FI_FechamentoDoDia = function: Integer; StdCall;
  TDaruma_FI_ImprimeConfiguracoesImpressora = function: Integer; StdCall;
  TDaruma_FI_ProgramaAliquota = function( Valor_Aliquota: String; Tipo_Aliquota: Integer ): Integer; StdCall;
  TDaruma_FI_NomeiaTotalizadorNaoSujeitoIcms = function( Indice_do_Totalizador: Integer; Nome_do_Totalizador: String ): Integer; StdCall;
  TDaruma_FI_ProgramaFormasPagamento = function( Descricao_das_Formas_Pagamento: String ): Integer; StdCall;
  TDaruma_FI_ProgramaOperador = function( Nome_do_Operador: String ): Integer; StdCall;
  TDaruma_FI_ProgramaArredondamento = function: Integer; StdCall;
  TDaruma_FI_ProgramaTruncamento = function: Integer; StdCall;
  TDaruma_FI_LinhasEntreCupons = function( Linhas_Entre_Cupons: Integer ): Integer; StdCall;
  TDaruma_FI_EspacoEntreLinhas = function( Espaco_Entre_Linhas: Integer ): Integer; StdCall;
  TDaruma_FI_ProgramaHorarioVerao = function: Integer; StdCall;
  TDaruma_FI_EqualizaFormasPgto = function: Integer; StdCall;
  TDaruma_FI_ProgramaVinculados = function( Vinculado: String ): Integer; StdCall;
  TDaruma_FI_ProgFormasPagtoSemVincular = function( Descricao_da_Forma_Pagamento: String ): Integer; StdCall;
  TDaruma_FI_CfgFechaAutomaticoCupom = function( Flag: String ): Integer; StdCall;
  TDaruma_FI_CfgRedZAutomatico = function( Flag: String ): Integer; StdCall;
  TDaruma_FI_CfgImpEstGavVendas = function( Flag: String ): Integer; StdCall;
  TDaruma_FI_CfgLeituraXAuto = function( Flag: String ): Integer; StdCall;
  TDaruma_FI_CfgCalcArredondamento = function( Flag: String ): Integer; StdCall;
  TDaruma_FI_CfgHorarioVerao = function( Flag: String ): Integer; StdCall;
  TDaruma_FI_CfgSensorAut = function( Flag: String ): Integer; StdCall;
  TDaruma_FI_CfgCupomAdicional = function( Flag: String ): Integer; StdCall;
  TDaruma_FI_CfgPermMensPromCNF = function( Flag: String ): Integer; StdCall;
  TDaruma_FI_CfgEspacamentoCupons = function( DistanciaCupons: String ): Integer; StdCall;
  TDaruma_FI_CfgHoraMinReducaoZ = function( Hora_Min_para_ReducaoZ: String ): Integer; StdCall;
  TDaruma_FI_CfgLimiarNearEnd = function( NumeroLinhas: String ): Integer; StdCall;
  TDaruma_Registry_AlteraRegistry = function( Chave: String; ValorChave: String ): Integer; StdCall;
  TDaruma_Registry_Porta = function( Porta: String ): Integer; StdCall;
  TDaruma_Registry_Path = function( Path: String ): Integer; StdCall;
  TDaruma_Registry_Status = function( Status: String ): Integer; StdCall;
  TDaruma_Registry_StatusFuncao = function( StatusFuncao: String ): Integer; StdCall;
  TDaruma_Registry_Retorno = function( Retorno: String ): Integer; StdCall;
  TDaruma_Registry_ControlePorta = function( ControlePorta: String ): Integer; StdCall;
  TDaruma_Registry_ModoGaveta = function( ModoGaveta: String ): Integer; StdCall;
  TDaruma_Registry_Log = function( Log: String ): Integer; StdCall;
  TDaruma_Registry_NomeLog = function( NomeLog: String ): Integer; StdCall;
  TDaruma_Registry_Separador = function( Separador: String ): Integer; StdCall;
  TDaruma_Registry_SeparaMsgPromo = function( SeparaMsgPromo: String ): Integer; StdCall;
  TDaruma_Registry_ZAutomatica = function( ZAutomatica: String ): Integer; StdCall;
  TDaruma_Registry_XAutomatica = function( XAutomatica: String ): Integer; StdCall;
  TDaruma_Registry_VendeItemUmaLinha = function( VendeItemUmaLinha: String ): Integer; StdCall;
  TDaruma_Registry_Default = function: Integer; StdCall;
  TDaruma_Registry_RetornaValor = function( Produto: String; Chave: String; Valor: String ): Integer; StdCall;
  TDaruma_Registry_TerminalServer = function( TerminalServer: String ): Integer; StdCall;
  TDaruma_Registry_ErroExtendidoOk = function( ValorErro: String ): Integer; StdCall;
  TDaruma_Registry_AbrirDiaFiscal = function( AbrirDiaFiscal: String ): Integer; StdCall;
  TDaruma_Registry_VendaAutomatica = function( VendaAutomatica: String ): Integer; StdCall;
  TDaruma_Registry_IgnorarPoucoPapel = function( IgnorarPoucoPapel: String ): Integer; StdCall;
  TDaruma_Registry_ImprimeRegistry = function( Produto: String ): Integer; StdCall;
  TDaruma_Registry_AplMensagem1 = function( Str_AplMensagem_1: String ): Integer; StdCall;
  TDaruma_Registry_AplMensagem2 = function( Str_AplMensagem_2: String ): Integer; StdCall;
  TDaruma_Registry_MFD_LeituraMFCompleta = function( Str_Indece: String ): Integer; StdCall;
  TDaruma_FIMFD_DownloadDaMFD = function( Str_Inicial, Str_Final: String ): Integer; StdCall;
  TDaruma_FI_StatusCupomFiscal = function( StatusCupomFiscal: String ): Integer; StdCall;
  TDaruma_FI_StatusRelatorioGerencial = function( StatusRelGerencial: String ): Integer; StdCall;
  TDaruma_FI_StatusComprovanteNaoFiscalVinculado = function( StatusCNFV: String ): Integer; StdCall;
  TDaruma_FI_VerificaImpressoraLigada = function: Integer; StdCall;
  TDaruma_FI_VerificaTotalizadoresParciais = function( Totalizadores: String ): Integer; StdCall;
  TDaruma_FI_VerificaModoOperacao = function( Modo: string ): Integer; StdCall;
  TDaruma_FI_VerificaTotalizadoresNaoFiscais = function( Totalizadores: String ): Integer; StdCall;
  TDaruma_FI_VerificaTotalizadoresNaoFiscaisEx = function( Totalizadores: String ): Integer; StdCall;
  TDaruma_FI_VerificaTruncamento = function( Flag: String ): Integer; StdCall;
  TDaruma_FI_VerificaAliquotasIss = function( Flag: String ): Integer; StdCall;
  TDaruma_FI_VerificaIndiceAliquotasIss = function( Flag: String ): Integer; StdCall;
  TDaruma_FI_VerificaRecebimentoNaoFiscal = function( Recebimentos: String ): Integer; StdCall;
  TDaruma_FI_VerificaTipoImpressora = function( Var TipoImpressora: Integer ): Integer; StdCall;
  TDaruma_FI_VerificaStatusCheque = function( StatusCheque: Integer ): Integer; StdCall;
  TDaruma_FI_VerificaModeloECF = function: Integer; StdCall;
  TDaruma_FI_VerificaDescricaoFormasPagamento = function( Descricao: String ): Integer; StdCall;
  TDaruma_FI_VerificaXPendente = function( XPendente: String ): Integer; StdCall;
  TDaruma_FI_VerificaZPendente = function( ZPendente: String ): Integer; StdCall;
  TDaruma_FI_VerificaDiaAberto = function( DiaAberto: String ): Integer; StdCall;
  TDaruma_FI_VerificaHorarioVerao = function( HoraioVerao: String ): Integer; StdCall;
  TDaruma_FI_VerificaFormasPagamento = function( Formas: String ): Integer; StdCall;
  TDaruma_FI_VerificaFormasPagamentoEx = function( FormasEx: String ): Integer; StdCall;
  TDaruma_FI_VerificaEpromConectada = function( Flag: String ): Integer; StdCall;
  TDaruma_FI_VerificaEstadoImpressora = function( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): Integer; StdCall;
  TDaruma_FI_ClicheProprietario = function( Cliche: String ): Integer; StdCall;
  TDaruma_FI_ClicheProprietarioEx = function( ClicheEx: String ): Integer; StdCall;
  TDaruma_FI_NumeroCaixa = function( NumeroCaixa: String ): Integer; StdCall;
  TDaruma_FI_NumeroLoja = function( NumeroLoja: String ): Integer; StdCall;
  TDaruma_FI_NumeroSerie = function( NumeroSerie: String ): Integer; StdCall;
  TDaruma_FI_VersaoFirmware = function( VersaoFirmware: String ): Integer; StdCall;
  TDaruma_FI_CGC_IE = function( CGC: String; IE: String ): Integer; StdCall;
  TDaruma_FI_LerAliquotasComIndice = function(AliquotasComIndice: String ): Integer; StdCall;
  TDaruma_FI_NumeroCupom = function( NumeroCupom: String ): Integer; StdCall;
  TDaruma_FI_COO = function(Inicial: String; Final: String ): Integer; StdCall;
  TDaruma_FI_MinutosImprimindo = function( Minutos: String ): Integer; StdCall;
  TDaruma_FI_MinutosLigada = function( Minutos: String ): Integer; StdCall;
  TDaruma_FI_NumeroSubstituicoesProprietario = function( NumeroSubstituicoes: String ): Integer; StdCall;
  TDaruma_FI_NumeroIntervencoes = function( NumeroIntervencoes: String ): Integer; StdCall;
  TDaruma_FI_NumeroReducoes = function( NumeroReducoes: String ): Integer; StdCall;
  TDaruma_FI_NumeroCuponsCancelados = function( NumeroCancelamentos: String ): Integer; StdCall;
  TDaruma_FI_NumeroOperacoesNaoFiscais = function( NumeroOperacoes: String ): Integer; StdCall;
  TDaruma_FI_DataHoraImpressora = function( Data: String; Hora: String ): Integer; StdCall;
  TDaruma_FI_DataHoraReducao = function( Data: String; Hora: String ): Integer; StdCall;
  TDaruma_FI_DataMovimento = function( Data: String ): Integer; StdCall;
  TDaruma_FI_ContadoresTotalizadoresNaoFiscais = function( Contadores: String ): Integer; StdCall;
  TDaruma_FI_GrandeTotal = function( GrandeTotal: String ): Integer; StdCall;
  TDaruma_FI_Descontos = function( ValorDescontos: String ): Integer; StdCall;
  TDaruma_FI_Acrescimos = function( ValorAcrescimos: String ): Integer; StdCall;
  TDaruma_FI_Cancelamentos = function( ValorCancelamentos: String ): Integer; StdCall;
  TDaruma_FI_DadosUltimaReducao = function( DadosReducao: String ): Integer; StdCall;
  TDaruma_FI_SubTotal = function( SubTotal: String ): Integer; StdCall;
  TDaruma_FI_RetornoAliquotas = function( Aliquotas: String ): Integer; StdCall;
  TDaruma_FI_ValorPagoUltimoCupom = function( ValorCupom: String ): Integer; StdCall;
  TDaruma_FI_ValorFormaPagamento = function( FormaPagamento: String; Valor: String ): Integer; StdCall;
  TDaruma_FI_ValorTotalizadorNaoFiscal = function( Totalizador: String; Valor: String ): Integer; StdCall;
  TDaruma_FI_UltimoItemVendido = function( NumeroItem: String ): Integer; StdCall;
  TDaruma_FI_UltimaFormaPagamento = function( Descricao_da_Forma: String; Valor_da_Forma: String ): Integer; StdCall;
  TDaruma_FI_TipoUltimoDocumento = function(TipoUltimoDoc: String ): Integer; StdCall;
  TDaruma_FI_MapaResumo = function: Integer; StdCall;
  TDaruma_FI_RelatorioTipo60Analitico = function: Integer; StdCall;
  TDaruma_FI_RelatorioTipo60Mestre = function: Integer; StdCall;
  TDaruma_FI_FlagsFiscais = function( Var Flag: Integer ): Integer; StdCall;
  TDaruma_FI_PalavraStatus = function( PalavraStatus: String ): Integer; StdCall;
  TDaruma_FI_PalavraStatusBinario = function( PalavraStatusBinario: String ): Integer; StdCall;
  TDaruma_FI_SimboloMoeda = function( SimboloMoeda: String ): Integer; StdCall;
  TDaruma_FI_RetornoImpressora = function( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): Integer; StdCall;
  TDaruma_FI_RetornaErroExtendido = function( ErroExtendido: String ): Integer; StdCall;
  TDaruma_FI_RetornaAcrescimoNF = function( AcrescimoNF: String ): Integer; StdCall;
  TDaruma_FI_RetornaCFCancelados = function( CFCancelados: String ): Integer; StdCall;
  TDaruma_FI_RetornaCNFCancelados = function( CNFCancelados: String ): Integer; StdCall;
  TDaruma_FI_RetornaCLX = function(CLX: String ): Integer; StdCall;
  TDaruma_FI_RetornaCNFNV = function(CNFNV: String ): Integer; StdCall;
  TDaruma_FI_RetornaCNFV = function(CNFV: String ): Integer; StdCall;
  TDaruma_FI_RetornaCRO = function(CRO: String ): Integer; StdCall;
  TDaruma_FI_RetornaCRZ = function(CRZ: String ): Integer; StdCall;
  TDaruma_FI_RetornaCRZRestante = function( CRZRestante: String ): Integer; StdCall;
  TDaruma_FI_RetornaCancelamentoNF = function( CancelamentoNF: String ): Integer; StdCall;
  TDaruma_FI_RetornaDescontoNF = function( DescontoNF: String ): Integer; StdCall;
  TDaruma_FI_RetornaGNF = function( GNF: String ): Integer; StdCall;
  TDaruma_FI_RetornaTempoImprimindo = function( TempoImprimindo: String ): Integer; StdCall;
  TDaruma_FI_RetornaTempoLigado = function( TempoLigado: String ): Integer; StdCall;
  TDaruma_FI_RetornaTotalPagamentos = function( TotalPagamentos: String ): Integer; StdCall;
  TDaruma_FI_RetornaTroco = function( Troco: String ): Integer; StdCall;
  TDaruma_FI_RetornaZeros = function( Zeros: String ): Integer; StdCall;
  TDaruma_FI_RetornaValorComprovanteNaoFiscal = function( Indice_CNF: String; Informacao: String ): Integer; StdCall;
  TDaruma_FI_RetornaIndiceComprovanteNaoFiscal = function( DescricaoRegistrCNF: String; RefIndice: String ): Integer; StdCall;
  TDaruma_FI_RetornaRegistradoresNaoFiscais = function( RegistrNaoFiscais: String ): Integer; StdCall;
  TDaruma_FI_RetornaRegistradoresFiscais = function( RegistrFiscais: String ): Integer; StdCall;
  TDaruma_TEF_EsperarArquivo = function( Path_Resp_TEF: String; Tempo_Espera: String; Travar: String ): Integer; StdCall;
  TDaruma_TEF_ImprimirResposta = function( Path_Arquivo_Resp_TEF: string; Forma_de_Pagamento: string; Travar_Teclado: string ): Integer; StdCall;
  TDaruma_TEF_ImprimirRespostaCartao = function( Path_Arquivo_Resp_TEF: string; Forma_de_Pagamento: string; Travar_Teclado: string; Valor_da_Forma_Pagamento: String ): Integer; StdCall;
  TDaruma_TEF_FechaRelatorio = function: Integer; StdCall;
  TDaruma_TEF_SetFocus = function( TituloJanela: String ): Integer; StdCall;
  TDaruma_TEF_TravarTeclado = function( Travar: String ): Integer; StdCall;
  TDaruma_Registry_FS2000_CupomAdicional = function( CupomAdicional: String ): Integer; StdCall;
  TDaruma_Registry_FS2000_TempoEsperaCheque = function( TempodeEspera: String ): Integer; StdCall;
  TDaruma_FI2000_DescontoSobreItemVendido = function( NumeroItem: String; TipoDesconto: String; ValorDesconto: String ): Integer; StdCall;
  TDaruma_FI2000_AcrescimosICMSISS = function( AcrescICMS: String; AcrescISS: String ): Integer; StdCall;
  TDaruma_FI2000_CancelamentosICMSISS = function( CancelICMS: String; CancelISS: String ): Integer; StdCall;
  TDaruma_FI2000_DescontosICMSISS = function( DescICMS: String; DescISS: String ): Integer; StdCall;
  TDaruma_FI2000_LeituraInformacaoUltimosCNF = function( UltimosCNF: String ): Integer; StdCall;
  TDaruma_FI2000_LeituraInformacaoUltimoDoc = function( TipoUltimoDoc: String; ValorUltimoDoc: String ): Integer; StdCall;
  TDaruma_FI2000_VerificaRelatorioGerencial = function( Gerencial: String ): Integer; StdCall;
  TDaruma_FI2000_CriaRelatorioGerencial = function( NomeGerencial: String ): Integer; StdCall;
  TDaruma_FI2000_AbreRelatorioGerencial = function( Indice: String ): Integer; StdCall;
  TDaruma_FI2000_CancelamentoCNFV = function( COO_CNFV: String ): Integer; StdCall;
  TDaruma_FI2000_SegundaViaCNFVinculado = function: Integer; StdCall;
  TDaruma_FI2000_StatusCheque = function( StatusCheque: String ): Integer; StdCall;
  TDaruma_FI2000_ImprimirCheque = function( Banco: String; Cidade: String; Data: String; Favorecido: String; Valor: String; PosicaoCheque: String ): Integer; StdCall;
  TDaruma_FI2000_ImprimirVersoCheque = function( VersoCheque: String ): Integer; StdCall;
  TDaruma_FI2000_LiberarCheque = function: Integer; StdCall;
  TDaruma_FI2000_LeituraCodigoMICR = function( CodigoMICR: String ): Integer; StdCall;
  TDaruma_FI2000_CancelarCheque = function: Integer; StdCall;
  TDaruma_FI2000_LeituraTabelaCheque = function( TabelaCheque: String ): Integer; StdCall;
  TDaruma_FI2000_CarregarCheque = function( NumeroBanco: String ): Integer; StdCall;
  TDaruma_FI2000_CorrigirGeometriaCheque = function( NumeroBanco: String; GeometriaCheque: String ): Integer; StdCall;
  ///////////////////////////////////////////////////////////////Metodos para o Sintegra//////////////////////////////////////////////////////////////////
  //Metodo de Alto Nivel
  TDaruma_Sintegra_GerarRegistrosArq = function ( DataInicio: String; DataFim: String; Municipio: String; Fax: String; CodIdConvenio: String; CodIdNatureza: String; CodIdFinalidade: String; Logradouro: String; Numero: String; Complemento: String; Bairro: String; CEP: String; NomeContato: String; Telefone: String): Integer; StdCall;
  //Metodo de Médio Nível
  TDaruma_Sintegra_GerarRegistro10 = function ( DataInicio: String; DataFim: String; Municipio: String; Fax: String; CodIdConvenio: String; CodIdNatureza: String; CodIdFinalidade: String; Retorno: String): Integer; StdCall;
  TDaruma_Sintegra_GerarRegistro11 = function ( Logradouro: String; Numero: String; Complemento: String; Bairro: String; CEP: String; NomeContato: String; Telefone: String; Retorno: String): Integer; StdCall;
  TDaruma_Sintegra_GerarRegistro60M = function ( DataInicio: String; DataFim: String; Retorno: String): Integer; StdCall;
  TDaruma_Sintegra_GerarRegistro60A = function ( DataInicio: String; DataFim: String; Retorno: String): Integer; StdCall;
  TDaruma_Sintegra_GerarRegistro60D = function ( DataInicio: String; DataFim: String; Retorno: String): Integer; StdCall;
  TDaruma_Sintegra_GerarRegistro60I = function ( DataInicio: String; DataFim: String; Retorno: String): Integer; StdCall;
  TDaruma_Sintegra_GerarRegistro60R = function ( DataInicio: String; DataFim: String; Retorno: String): Integer; StdCall;
  TDaruma_Sintegra_GerarRegistro90 = function ( Retorno: String): Integer; StdCall;
  TDaruma_Registry_SintegraSeparador = function ( Separador: String): Integer; StdCall;
  TDaruma_Registry_SintegraPath = function ( Path: String): Integer; StdCall;
  //PAF_ECF
  TDaruma_FIMFD_RetornaInformacao = function(Str_Indice :String; Str_Valor: String): Integer; StdCall;


   TUserEvent = procedure(comando: string; MsgError: string) of object;

   TReducaoZEvent = procedure(Sender: TObject) of object;
   TAbrirCupomEvent = procedure(Sender: TObject) of object;
   TSuprimentoEvent = procedure(Sender: TObject) of object;
   TSangriaEvent = procedure(Sender: TObject) of object;
   TAbreCupomVinculado = procedure(Sender: TObject) of object;
   TAbreRelatorioGerencial = procedure(Sender: TObject) of object;
   TCancelaCupomAtual = procedure(Sender: TObject) of object;
   TAbreDia = procedure(Sender: TObject) of object;
   TValidaAbrirCupomEvent = procedure(Sender: TObject; var CanOpen: Boolean) of object;

   TTotalCupom = procedure(ValorCupom: string) of object;

   TDefFPrinter = class;

   {Para uso na funcao de venda de item}
   TItem = Record
      Codigo       : String[13];
      Descricao    : String[30];
      Tributo      : String[2];
      Quantidade   : Currency;
      ValorUnit    : Currency;
      Desconto     : Currency;
   end;

   TPrinterDados = class(TPersistent)
   private
      FOwner: TDefFPrinter;
      FMensagem: string;
      FDataImp: string;
      FHoraImp: string;
      FLoja: string;
      FCaixa: string;
      FSerial: string;
      FOperador: string;
      Freducoes: string;
      FSeqIni: string;
      FSeqFinal: string;
      FNumCanc: string;
      FGTInicial: string;
      FGTFinal: string;
      FVlrCanc: string;
      FVlrDesc: string;
      FVlrAcre: string;
      FExecuted  : Boolean;
      TestaTx: integer;

   public
      constructor Create(Owner: TDefFPrinter);
   published
      property Mensagem: string read FMensagem write FMensagem;
      property DataImp: string read FDataImp write FDataImp;
      property HoraImp: string read FHoraImp write FHoraImp;
      property Loja: string read FLoja write FLoja;
      property Caixa: string read FCaixa write FCaixa;
      property Serial: string read Fserial write FSerial;
      property Operador: string read FOperador write FOperador;
      property Reducoes: string read Freducoes write Freducoes;
      property SeqIni: string read FSeqIni write FSeqIni;
      property SeqFinal: string read FSeqFinal write FSeqFinal;
      property NumCanc: string read FNumCanc write FNumCanc;
      property GTInicial: string read FGTInicial write FGTInicial;
      property GTFinal: string read FGTFinal write FGTFinal;
      property ValorCanc: string read FVlrCanc write FVlrCanc;
      property ValorDesc: string read FVlrDesc write FVlrDesc;
      property ValorAcres: string read FVlrAcre write FVlrAcre;
   end;
   { ===================================================== }
   TTributacao = class(TPersistent)
   private
      FOwner: TDefFPrinter;
      FIsento: string;
      FNTributado: string;
      FSubst: string;
      FAliquota0: string;
      FAliquota1: string;
      FAliquota2: string;
      FAliquota3: string;
      FAliquota4: string;
      FAliquota5: string;
      FAliquota6: string;
      FAliquota7: string;
      FAliquota8: string;
      FAliquota9: string;
      FAliquota10: string;
      FAliquota11: string;
      FAliquota12: string;
      FAliquota13: string;
      FAliquota14: string;
      FAliquota15: string;
   public
      constructor Create(Owner: TDefFPrinter);
   published
      property Isento: string read FIsento write FIsento;
      property NaoTributado: string read FNTributado write FNTributado;
      property Substituicao: string read FSubst write FSubst;
      property Aliquota00: string read FAliquota0 write FAliquota0;
      property Aliquota01: string read FAliquota1 write FAliquota1;
      property Aliquota02: string read FAliquota2 write FAliquota2;
      property Aliquota03: string read FAliquota3 write FAliquota3;
      property Aliquota04: string read FAliquota4 write FAliquota4;
      property Aliquota05: string read FAliquota5 write FAliquota5;
      property Aliquota06: string read FAliquota6 write FAliquota6;
      property Aliquota07: string read FAliquota7 write FAliquota7;
      property Aliquota08: string read FAliquota8 write FAliquota8;
      property Aliquota09: string read FAliquota9 write FAliquota9;
      property Aliquota10: string read FAliquota10 write FAliquota10;
      property Aliquota11: string read FAliquota11 write FAliquota11;
      property Aliquota12: string read FAliquota12 write FAliquota12;
      property Aliquota13: string read FAliquota13 write FAliquota13;
      property Aliquota14: string read FAliquota14 write FAliquota14;
      property Aliquota15: string read FAliquota15 write FAliquota15;
   end;
   { ===================================================== }
   TRodape = class(TPersistent)
   private
      FOwner: TDefFPrinter;
      FLinha1: string;
      FLinha2: string;
      FLinha3: string;
      FLinha4: string;
      FLinha5: string;
   public
      constructor Create(Owner: TDefFPrinter);
   published
      property Linha1: string read FLinha1 write FLinha1;
      property Linha2: string read FLinha2 write FLinha2;
      property Linha3: string read FLinha3 write FLinha3;
      property Linha4: string read FLinha4 write FLinha4;
      property Linha5: string read FLinha5 write FLinha5;
   end;
   { ===================================================== }
   TStatus = class(TPersistent)
   private
      FOwner: TDefFPrinter;
      FGavetaAberta: Boolean;
      FFimDePapel: Boolean;
      FCupomAberto: Boolean;
      FDiaAberto: Boolean;
   public
      constructor Create(Owner: TDefFPrinter);
   published
      property GavetaAberta: boolean read FGavetaAberta write FGavetaAberta;
      property FimDePapel: boolean read FFimDePapel write FFimDePapel;
      property CupomAberto: boolean read FCupomAberto write FCupomAberto;
      property DiaAberto: boolean read FDiaAberto write FDiaAberto;
   end;
   { ===================================================== }
   TDefFPrinter = class(TComponent)
   private
      Buffer    :  String; { recebe o string a ser enviado ao comando FormataTx }
      MsgError  :  String;
      NroRet    : Integer; {nro do retorno da impressora schalter}
      StrRet    : string;  {string do retorno da impressora schalter e sweda}
      Comando   : array [0..512] of char; // comando para impressora sweda

      { TestaTX e um flag que armazena o retorno da funcao FormataTX, seus valores de
      retorno sao:
      0  - sucesso
      1  - erro de comunicacao fisica
      -2 - parametro invalido }     {65534}
      TestaTX    : Integer;

      HandleDLL: THandle;
      NomeDll: string;
      { ---- Declaracao das funcoes das DLLs --- }
      // Funções de Comunicação  ---------------------------------------------------------------------------------------------------------------
      Sweda_AbrePortaSerial : PSweda_AbrePortaSerial;
      Sweda_FechaPortaSerial : PSweda_FechaPortaSerial;
      Sweda_MsgLog : PSweda_MsgLog;
      //Funções de Início de Dia
      Sweda_AberturaDoDia : PSweda_AberturaDoDia;
      //Funções de Status ---------------------------------------------------------------------------------------------------------------
      Sweda_RetornoImpressoraMFD : PSweda_RetornoImpressoraMFD;
      Sweda_RetornaTipoEcf : PSweda_RetornaTipoEcf;
      Sweda_VersaoDll : PSweda_VersaoDll;
      Sweda_VersaoFirmware : PSweda_VersaoFirmware;
      Sweda_VersaoFirmwareMFD : PSweda_VersaoFirmwareMFD;
      Sweda_NumeroSerie : PSweda_NumeroSerie;
      Sweda_NumeroSerieMFD : PSweda_NumeroSerieMFD;
      Sweda_NumeroSerieMemoriaMFD : PSweda_NumeroSerieMemoriaMFD;
      Sweda_Registry_AplMensagem1 : PSweda_Registry_AplMensagem1;
      Sweda_Registry_AplMensagem2 : PSweda_Registry_AplMensagem2;
      Sweda_VerificaFormasPagamentoMFD : PSweda_VerificaFormasPagamentoMFD;
      Sweda_MarcaModeloTipoImpressoraMFD : PSweda_MarcaModeloTipoImpressoraMFD;
      Sweda_DataHoraGravacaoUsuarioSWBasicoMFAdicional : PSweda_DataHoraGravacaoUsuarioSWBasicoMFAdicional;
      Sweda_CGC_IE : PSweda_CGC_IE;
      Sweda_CNPJMFD : PSweda_CNPJMFD;
      Sweda_InscricaoEstadualMFD : PSweda_InscricaoEstadualMFD;
      Sweda_InscricaoMunicipalMFD : PSweda_InscricaoMunicipalMFD;
      Sweda_NumeroSubstituicoesProprietario : PSweda_NumeroSubstituicoesProprietario;
      Sweda_SimboloMoeda : PSweda_SimboloMoeda;
      Sweda_ClicheProprietario : PSweda_ClicheProprietario;
      Sweda_NumeroLoja : PSweda_NumeroLoja;
      Sweda_NumeroCaixa : PSweda_NumeroCaixa;
      Sweda_DataHoraImpressora : PSweda_DataHoraImpressora;
      Sweda_LerAliquotasComIndice : PSweda_LerAliquotasComIndice;
      Sweda_VerificaTotalizadoresNaoFiscaisMFD : PSweda_VerificaTotalizadoresNaoFiscaisMFD;
      Sweda_VerificaModoOperacao : PSweda_VerificaModoOperacao;
      Sweda_VerificaImpressoraLigada : PSweda_VerificaImpressoraLigada;
      Sweda_VerificaDescricaoFormasPagamento : PSweda_VerificaDescricaoFormasPagamento;
      Sweda_VerificaTotalizadoresNaoFiscaisEx : PSweda_VerificaTotalizadoresNaoFiscaisEx;
      Sweda_VerificaRelatorioGerencialProgMFD : PSweda_VerificaRelatorioGerencialProgMFD;
      Sweda_CasasDecimaisProgramada : PSweda_CasasDecimaisProgramada;
      Sweda_VerificaTruncamento : PSweda_VerificaTruncamento;
      Sweda_VerificaEstadoImpressoraMFD : PSweda_VerificaEstadoImpressoraMFD;
      Sweda_VerificaTotalizadoresParciais : PSweda_VerificaTotalizadoresParciais;
      Sweda_RetornoAliquotas : PSweda_RetornoAliquotas;
      Sweda_ImprimeCopiaCheque : PSweda_ImprimeCopiaCheque;
      Sweda_CancelaImpressaoCheque : PSweda_CancelaImpressaoCheque;
      // Funções de Leituras Fiscais  ---------------------------------------------------------------------------------------------------------------
      Sweda_LeituraX : PSweda_LeituraX;
      Sweda_LeituraMemoriaFiscalData : PSweda_LeituraMemoriaFiscalData;
      Sweda_LeituraMemoriaFiscalDataMFD : PSweda_LeituraMemoriaFiscalDataMFD;
      Sweda_LeituraMemoriaFiscalReducao : PSweda_LeituraMemoriaFiscalReducao;
      Sweda_LeituraMemoriaFiscalReducaoMFD : PSweda_LeituraMemoriaFiscalReducaoMFD;
      // Funções do Cupom Fiscal  ---------------------------------------------------------------------------------------------------------------
      Sweda_AbreCupom : PSweda_AbreCupom;
      Sweda_AbreCupomMFD : PSweda_AbreCupomMFD;
      Sweda_IdentificaConsumidor : PSweda_IdentificaConsumidor;
      Sweda_AumentaDescricaoItem : PSweda_AumentaDescricaoItem;
      Sweda_UsaUnidadeMedida : PSweda_UsaUnidadeMedida;
      Sweda_VendeItem : PSweda_VendeItem;
      Sweda_VendeItemTresDecimais : PSweda_VendeItemTresDecimais;
      Sweda_VendeItemDepartamento : PSweda_VendeItemDepartamento;
      Sweda_DescontoSobreItemVendido : PSweda_DescontoSobreItemVendido;
      Sweda_AcrescimoDescontoItemMFD : PSweda_AcrescimoDescontoItemMFD;
      Sweda_CancelaItemAnterior : PSweda_CancelaItemAnterior;
      Sweda_CancelaItemGenerico : PSweda_CancelaItemGenerico;
      Sweda_CancelaAcrescimoDescontoItemMFD : PSweda_CancelaAcrescimoDescontoItemMFD;
      Sweda_IniciaFechamentoCupom : PSweda_IniciaFechamentoCupom;
      Sweda_IniciaFechamentoCupomMFD : PSweda_IniciaFechamentoCupomMFD;
      Sweda_AcrescimoDescontoSubtotalMFD : PSweda_AcrescimoDescontoSubtotalMFD;
      Sweda_TotalizaCupomMFD : PSweda_TotalizaCupomMFD;
      Sweda_EfetuaFormaPagamento : PSweda_EfetuaFormaPagamento;
      Sweda_EfetuaFormaPagamentoDescricaoForma : PSweda_EfetuaFormaPagamentoDescricaoForma;
      Sweda_EfetuaFormaPagamentoMFD : PSweda_EfetuaFormaPagamentoMFD;
      Sweda_TerminaFechamentoCupom : PSweda_TerminaFechamentoCupom;
      Sweda_FechaCupom : PSweda_FechaCupom;
      Sweda_FechaCupomResumido : PSweda_FechaCupomResumido;
      Sweda_AtivaDesativaCorteProximoMFD : PSweda_AtivaDesativaCorteProximoMFD;
      Sweda_CupomAdicionalMFD : PSweda_CupomAdicionalMFD;
      Sweda_ProgramaArredondamento : PSweda_ProgramaArredondamento;
      Sweda_ProgramaTruncamento : PSweda_ProgramaTruncamento;
      Sweda_EstornoFormasPagamento : PSweda_EstornoFormasPagamento;
      // Funções de Cancelamento  ---------------------------------------------------------------------------------------------------------------
      Sweda_CancelaCupom : PSweda_CancelaCupom;
      Sweda_CancelaCupomMFD : PSweda_CancelaCupomMFD;
      Sweda_CancelaAcrescimoDescontoSubtotalMFD : PSweda_CancelaAcrescimoDescontoSubtotalMFD;
      // Funções de COmprovante Crédito e Débito (TEF) ---------------------------------------------------------------------------------------------------------------
      Sweda_IniciaModoTEF : PSweda_IniciaModoTEF;
      Sweda_FinalizaModoTEF : PSweda_FinalizaModoTEF;
      Sweda_AbreComprovanteNaoFiscalVinculado: PSweda_AbreComprovanteNaoFiscalVinculado;
      Sweda_AbreComprovanteNaoFiscalVinculadoMFD : PSweda_AbreComprovanteNaoFiscalVinculadoMFD;
      Sweda_UsaComprovanteNaoFiscalVinculadoTEF : PSweda_UsaComprovanteNaoFiscalVinculadoTEF;
      Sweda_UsaComprovanteNaoFiscalVinculado : PSweda_UsaComprovanteNaoFiscalVinculado;
      Sweda_FechaComprovanteNaoFiscalVinculado : PSweda_FechaComprovanteNaoFiscalVinculado;
      Sweda_SegundaViaNaoFiscalVinculadoMFD : PSweda_SegundaViaNaoFiscalVinculadoMFD;
      Sweda_ReimpressaoNaoFiscalVinculadoMFD : PSweda_ReimpressaoNaoFiscalVinculadoMFD;
      Sweda_EstornoNaoFiscalVinculadoMFD : PSweda_EstornoNaoFiscalVinculadoMFD;
      Sweda_TEF_ImprimirRespostaCartao : PSweda_TEF_ImprimirRespostaCartao;
      Sweda_TEF_FechaRelatorio : PSweda_TEF_FechaRelatorio;
      Sweda_RelatorioGerencialTEF : PSweda_RelatorioGerencialTEF;
      Sweda_UsaRelatorioGerencialMFDTEF : PSweda_UsaRelatorioGerencialMFDTEF;
      // Funções de Comprovantes  ---------------------------------------------------------------------------------------------------------------
      Sweda_Suprimento : PSweda_Suprimento;
      Sweda_Sangria : PSweda_Sangria;
      Sweda_AbreRecebimentoNaoFiscalMFD : PSweda_AbreRecebimentoNaoFiscalMFD;
      Sweda_AbreRecebimentoNaoFiscal : PSweda_AbreRecebimentoNaoFiscal;
      Sweda_RecebimentoNaoFiscal : PSweda_RecebimentoNaoFiscal;
      Sweda_EfetuaRecebimentoNaoFiscalMFD : PSweda_EfetuaRecebimentoNaoFiscalMFD;
      Sweda_CancelaItemNaoFiscalMFD : PSweda_CancelaItemNaoFiscalMFD;
      Sweda_AcrescimoItemNaoFiscalMFD : PSweda_AcrescimoItemNaoFiscalMFD;
      Sweda_AcrescimoDescontoSubtotalRecebimentoMFD : PSweda_AcrescimoDescontoSubtotalRecebimentoMFD;
      Sweda_TotalizaRecebimentoMFD : PSweda_TotalizaRecebimentoMFD;
      Sweda_IniciaFechamentoRecebimentoNaoFiscalMFD : PSweda_IniciaFechamentoRecebimentoNaoFiscalMFD;
      Sweda_FechaRecebimentoNaoFiscalMFD : PSweda_FechaRecebimentoNaoFiscalMFD;
      Sweda_CancelaRecebimentoNaoFiscalMFD : PSweda_CancelaRecebimentoNaoFiscalMFD;
      Sweda_EfetuaFormaPagamentoNaoFiscal : PSweda_EfetuaFormaPagamentoNaoFiscal;
      // Funções de Relatório Gerencial  ---------------------------------------------------------------------------------------------------------------
      Sweda_AbreRelatorioGerencial : PSweda_AbreRelatorioGerencial ;
      Sweda_AbreRelatorioGerencialMFD : PSweda_AbreRelatorioGerencialMFD;
      Sweda_EnviarTextoCNF : PSweda_EnviarTextoCNF;
      Sweda_RelatorioGerencial : PSweda_RelatorioGerencial;
      Sweda_UsaRelatorioGerencialMFD : PSweda_UsaRelatorioGerencialMFD;
      Sweda_FechaRelatorioGerencial : PSweda_FechaRelatorioGerencial;
      // Funções de Fechamento do dia ---------------------------------------------------------------------------------------------------------------
      Sweda_FechamentoDoDia : PSweda_FechamentoDoDia;
      Sweda_ReducaoZ : PSweda_ReducaoZ;
      // Funções de Autenticações ---------------------------------------------------------------------------------------------------------------
      Sweda_Autenticacao : PSweda_Autenticacao;
      Sweda_AutenticacaoMFD : PSweda_AutenticacaoMFD;
      Sweda_AutenticacaoStr : PSweda_AutenticacaoStr;
      Sweda_VerificaDocAutenticacao : PSweda_VerificaDocAutenticacao;
      // Funções de Gaveta ---------------------------------------------------------------------------------------------------------------
      Sweda_AcionaGaveta : PSweda_AcionaGaveta;
      Sweda_VerificaEstadoGaveta : PSweda_VerificaEstadoGaveta;
      Sweda_VerificaEstadoGavetaStr : PSweda_VerificaEstadoGavetaStr;
      //Funções de Cheque ---------------------------------------------------------------------------------------------------------------
      Sweda_ProgramaMoedaSingular : PSweda_ProgramaMoedaSingular;
      Sweda_ProgramaMoedaPlural : PSweda_ProgramaMoedaPlural;
      Sweda_IncluiCidadeFavorecido : PSweda_IncluiCidadeFavorecido;
      Sweda_VerificaStatusCheque : PSweda_VerificaStatusCheque;
      Sweda_VerificaStatusChequeStr : PSweda_VerificaStatusChequeStr;
      Sweda_ImprimeCheque : PSweda_ImprimeCheque;
      Sweda_ImprimeChequeMFD : PSweda_ImprimeChequeMFD;
      Sweda_LeituraChequeMFD : PSweda_LeituraChequeMFD;
      Sweda_LeituraLeiautesCheques : PSweda_LeituraLeiautesCheques;
      //Funções de Status Ultima Transacao ---------------------------------------------------------------------------------------------------------------
      Sweda_TipoUltimoDocumento : PSweda_TipoUltimoDocumento;
      Sweda_SubTotal : PSweda_SubTotal;
      Sweda_SubTotalComprovanteNaoFiscalMFD : PSweda_SubTotalComprovanteNaoFiscalMFD;
      Sweda_ValorPagoUltimoCupom : PSweda_ValorPagoUltimoCupom;
      Sweda_NumeroCupom : PSweda_NumeroCupom;
      Sweda_VerificaFormasPagamento : PSweda_VerificaFormasPagamento;
      Sweda_TotaisVenda : PSweda_TotaisVenda;
      Sweda_ValorAcrescimosUltimoCupom : PSweda_ValorAcrescimosUltimoCupom;
      Sweda_ValorDescontosUltimoCupom : PSweda_ValorDescontosUltimoCupom;
      Sweda_ValorCancelamentosUltimoCupom : PSweda_ValorCancelamentosUltimoCupom;
      Sweda_ValorCancelamentosUltimoCupomISS : PSweda_ValorCancelamentosUltimoCupomISS;
      //Funções de Status Acumuladores Diários ---------------------------------------------------------------------------------------------------------------
      Sweda_Acrescimos : PSweda_Acrescimos;
      Sweda_Descontos : PSweda_Descontos;
      Sweda_VerificaRecebimentoNaoFiscal : PSweda_VerificaRecebimentoNaoFiscal;
      Sweda_VerificaRecebimentoNaoFiscalMFD : PSweda_VerificaRecebimentoNaoFiscalMFD;
      Sweda_Cancelamentos : PSweda_Cancelamentos;
      Sweda_GrandeTotal : PSweda_GrandeTotal;
      Sweda_VendaBruta : PSweda_VendaBruta;
      Sweda_RetornaAcrescimoNF : PSweda_RetornaAcrescimoNF;
      Sweda_RetornaDescontoNF : PSweda_RetornaDescontoNF;
      Sweda_RetornaCancelamentoNF : PSweda_RetornaCancelamentoNF;
      Sweda_RetornaTroco : PSweda_RetornaTroco;
      //Funções de Status Contadores  ---------------------------------------------------------------------------------------------------------------
      Sweda_NumeroIntervencoes : PSweda_NumeroIntervencoes;
      Sweda_ContadorCupomFiscalMFD : PSweda_ContadorCupomFiscalMFD;
      Sweda_NumeroCuponsCancelados : PSweda_NumeroCuponsCancelados;
      Sweda_NumeroOperacoesNaoFiscais : PSweda_NumeroOperacoesNaoFiscais;
      Sweda_ContadorComprovantesCreditoMFD : PSweda_ContadorComprovantesCreditoMFD;
      Sweda_ComprovantesNaoFiscaisNaoEmitidosMFD : PSweda_ComprovantesNaoFiscaisNaoEmitidosMFD;
      Sweda_ContadorOperacoesNaoFiscaisCanceladasMFD : PSweda_ContadorOperacoesNaoFiscaisCanceladasMFD;
      Sweda_ContadorFitaDetalheMFD : PSweda_ContadorFitaDetalheMFD;
      Sweda_ContadorRelatoriosGerenciaisMFD : PSweda_ContadorRelatoriosGerenciaisMFD;
      Sweda_NumeroReducoes : PSweda_NumeroReducoes;
      Sweda_RetornaCOO : PSweda_RetornaCOO;
      Sweda_COO : PSweda_COO;
      //Funções de Status do ECF  ---------------------------------------------------------------------------------------------------------------
      Sweda_FlagsFiscais : PSweda_FlagsFiscais;
      Sweda_VerificaEstadoImpressora : PSweda_VerificaEstadoImpressora;
      Sweda_RetornoImpressora : PSweda_RetornoImpressora;
      Sweda_VerificaTipoImpressora : PSweda_VerificaTipoImpressora;
      Sweda_VerificaIndiceAliquotasIss : PSweda_VerificaIndiceAliquotasIss;
      Sweda_StatusEstendidoMFD : PSweda_StatusEstendidoMFD;
      Sweda_StatusCupomFiscal : PSweda_StatusCupomFiscal;
      Sweda_StatusRelatorioGerencial : PSweda_StatusRelatorioGerencial;
      Sweda_StatusComprovanteNaoFiscalVinculado : PSweda_StatusComprovanteNaoFiscalVinculado;
      Sweda_StatusComprovanteNaoFiscalNaoVinculado : PSweda_StatusComprovanteNaoFiscalNaoVinculado;
      Sweda_VerificaModeloEcf : PSweda_VerificaModeloEcf;
      Sweda_VerificaHorarioVerao : PSweda_VerificaHorarioVerao;
      Sweda_VerificaZPendente : PSweda_VerificaZPendente;
      Sweda_VerificaDiaAberto : PSweda_VerificaDiaAberto;
      Sweda_VerificaFlagCorteMFD : PSweda_VerificaFlagCorteMFD;
      Sweda_GeraRFD : PSweda_GeraRFD;
      // Funções Status Diversos---------------------------------------------------------------------
      Sweda_PercentualLivreMFD : PSweda_PercentualLivreMFD;
      Sweda_TotalLivreMFD : PSweda_TotalLivreMFD;
      Sweda_ReducoesRestantesMFD : PSweda_ReducoesRestantesMFD;
      Sweda_TamanhoTotalMFD : PSweda_TamanhoTotalMFD;
      Sweda_TempoRestanteComprovanteMFD : PSweda_TempoRestanteComprovanteMFD;
      Sweda_DataMovimento : PSweda_DataMovimento;
      // Status de Valores após a Redução Z ---------------------------------------------------------------
      Sweda_DataHoraUltimoDocumentoMFD : PSweda_DataHoraUltimoDocumentoMFD;
      Sweda_DataHoraReducao : PSweda_DataHoraReducao;
      Sweda_DataMovimentoUltimaReducaoMFD : PSweda_DataMovimentoUltimaReducaoMFD;
      Sweda_InicioFimCOOsMFD : PSweda_InicioFimCOOsMFD;
      Sweda_InicioFimGTsMFD : PSweda_InicioFimGTsMFD;
      Sweda_GrandeTotalUltimaReducaoMFD : PSweda_GrandeTotalUltimaReducaoMFD;
      Sweda_DadosUltimaReducaoMFD : PSweda_DadosUltimaReducaoMFD;
      Sweda_MapaResumoMFD : PSweda_MapaResumoMFD;
      // Funções SINTEGRA ---------------------------------------------------------------------
      Sweda_ArquivoSintegra2004MFD : PSweda_ArquivoSintegra2004MFD;
      Sweda_RelatorioSintegraMFD : PSweda_RelatorioSintegraMFD;
      Sweda_RegistrosTipo60 : PSweda_RegistrosTipo60;
      Sweda_RelatorioTipo60Mestre : PSweda_RelatorioTipo60Mestre;
      Sweda_RelatorioTipo60Analitico : PSweda_RelatorioTipo60Analitico;
      Sweda_RelatorioTipo60AnaliticoMFD : PSweda_RelatorioTipo60AnaliticoMFD;
      // Funções CAptura Movimento Gravado ECF ---------------------------------------------------------------------
      Sweda_LeituraXSerial : PSweda_LeituraXSerial;
      Sweda_LeituraMemoriaFiscalSerialData : PSweda_LeituraMemoriaFiscalSerialData;
      Sweda_LeituraMemoriaFiscalSerialDataMFD : PSweda_LeituraMemoriaFiscalSerialDataMFD;
      Sweda_LeituraMemoriaFiscalSerialReducao : PSweda_LeituraMemoriaFiscalSerialReducao;
      Sweda_LeituraMemoriaFiscalSerialReducaoMFD : PSweda_LeituraMemoriaFiscalSerialReducaoMFD;
      Sweda_DownloadSB : PSweda_DownloadSB;
      Sweda_DownloadMF : PSweda_DownloadMF;
      Sweda_DownloadMFD : PSweda_DownloadMFD;
      Sweda_FormatoDadosMFD : PSweda_FormatoDadosMFD;
      Sweda_CapturaDocumentos : PSweda_CapturaDocumentos;
      // Funções COTEPE --------------------------------------------------------------------------------------------------------------
      Sweda_TabelaMercadoriasServicos3404 : PSweda_TabelaMercadoriasServicos3404;
      Sweda_ReproduzirMemoriaFiscalMFD : PSweda_ReproduzirMemoriaFiscalMFD;
      Sweda_GeraRegistrosCAT52MFD : PSweda_GeraRegistrosCAT52MFD;
      Sweda_ConfiguraCodigoBarrasMFD : PSweda_ConfiguraCodigoBarrasMFD;
      Sweda_CodigoBarrasCODABARMFD : PSweda_CodigoBarrasCODABARMFD;
      Sweda_CodigoBarrasCODE39MFD : PSweda_CodigoBarrasCODE39MFD;
      Sweda_CodigoBarrasEAN13MFD : PSweda_CodigoBarrasEAN13MFD;
      Sweda_CodigoBarrasEAN8MFD : PSweda_CodigoBarrasEAN8MFD;
      Sweda_CodigoBarrasITFMFD : PSweda_CodigoBarrasITFMFD;
      Sweda_CodigoBarrasUPCAMFD : PSweda_CodigoBarrasUPCAMFD;
      Sweda_CodigoBarrasUPCEMFD : PSweda_CodigoBarrasUPCEMFD;




      {**TODO}

      //
      NCR_SendCMD: PNCR_SendCmd;
      NCR_SetComPort: PNCR_SetComPort;
      //
      Urano2EFE_LeituraMF: PUrano2EFE_LeituraMF;
      Urano2EFE_IniciaImpressora: PUrano2EFE_IniciaImpressora;
      Urano2EFE_FinalizaImpressora: PUrano2EFE_FinalizaImpressora;
      Urano2EFE_ImprimeCabecalho: PUrano2EFE_ImprimeCabecalho;
      Urano2EFE_VendaItem: PUrano2EFE_VendaItem;
      Urano2EFE_CanItem: PUrano2EFE_CanItem;
      Urano2EFE_DescontoItem: PUrano2EFE_DescontoItem;
      Urano2EFE_Pagamento: PUrano2EFE_Pagamento;
      Urano2EFE_FinalizaVenda: PUrano2EFE_FinalizaVenda;
      Urano2EFE_ImprimeLinhaNFiscal: PUrano2EFE_ImprimeLinhaNFiscal;
      Urano2EFE_CancelaVenda: PUrano2EFE_CancelaVenda;
      Urano2EFE_CancelaCupom: PUrano2EFE_CancelaCupom;
      Urano2EFE_AcrescSubTotal: PUrano2EFE_AcrescSubTotal;
      Urano2EFE_DescSubTotal: PUrano2EFE_DescSubTotal;
      Urano2EFE_IniciaXZ: PUrano2EFE_IniciaXZ;
      Urano2EFE_FinalizaXZ: PUrano2EFE_FinalizaXZ;
      Urano2EFE_MensagemPromocional: PUrano2EFE_MensagemPromocional;
      Urano2EFE_ProgramaRelogio: PUrano2EFE_ProgramaRelogio;
      Urano2EFE_AGaveta: PUrano2EFE_AGaveta;
      Urano2EFE_AvancoLinha: PUrano2EFE_AvancoLinha;
      Urano2EFE_IniciaCupomNFiscal: PUrano2EFE_IniciaCupomNFiscal;
      Urano2EFE_LeRegistradores: PUrano2EFE_LeRegistradores;
      Urano2EFE_AutenticaDocumento: PUrano2EFE_AutenticaDocumento;
      Urano2EFE_LeituraSensor: PUrano2EFE_LeituraSensor;
      Urano2EFE_ICheque: PUrano2EFE_ICheque;
      Urano2EFE_NomeMoeda: PUrano2EFE_NomeMoeda;
      Urano2EFE_EspacamentoLinhas: PUrano2EFE_EspacamentoLinhas;
      //
      Zanthus_InicializaPortaSerial: PZanthus_InicializaPortaSerial;
      Zanthus_FechaPortaSerial: PZanthus_FechaPortaSerial;
      Zanthus_EnviaComandoComArgumento: PZanthus_EnviaComandoComArgumento;
      Zanthus_EnviaComando: PZanthus_EnviaComando;
      Zanthus_LeBufferASCII: PZanthus_LeBufferASCII;
      Zanthus_LeRetorno: PZanthus_LeRetorno;
      Zanthus_LeRetornoASCII: PZanthus_LeRetornoASCII;
      Zanthus_ConfiguraCheque: PZanthus_ConfiguraCheque;
      Zanthus_ConfiguraMoeda: PZanthus_ConfiguraMoeda;
      Zanthus_ImprimeCheque: PZanthus_ImprimeCheque;
      //
      Bematech_IniPortaStr: PBematech_IniPortaStr;
      Bematech_FormataTX: PBematech_FormataTX;
      Bematech_FechaPorta: PBematech_FechaPorta;
      Bematech_Status_Mp20FI: PBematech_Status_Mp20FI;

            /////////////////////////////// Parte implementada de novas funcoes Bematech /////////////////////////////////////////////////////////////
      // Funções de Inicialização
      Bematech_AlteraSimboloMoeda:PBematech_AlteraSimboloMoeda;
      Bematech_ProgramaAliquota:PBematech_ProgramaAliquota;
      Bematech_ProgramaHorarioVerao:PBematech_ProgramaHorarioVerao;
      Bematech_NomeiaDepartamento:PBematech_NomeiaDepartamento;
      Bematech_NomeiaTotalizadorNaoSujeitoIcms:PBematech_NomeiaTotalizadorNaoSujeitoIcms;
      Bematech_ProgramaArredondamento:PBematech_ProgramaArredondamento;
      Bematech_ProgramaTruncamento:PBematech_ProgramaTruncamento;
      Bematech_LinhasEntreCupons:PBematech_LinhasEntreCupons;
      Bematech_EspacoEntreLinhas:PBematech_EspacoEntreLinhas;
      Bematech_ForcaImpactoAgulhas:PBematech_ForcaImpactoAgulhas;
      // Funções do Cupom Fiscal
      Bematech_AbreCupom:PBematech_AbreCupom;
      Bematech_VendeItem:PBematech_VendeItem;
      Bematech_VendeItemDepartamento:PBematech_VendeItemDepartamento;
      Bematech_CancelaItemAnterior:PBematech_CancelaItemAnterior;
      Bematech_CancelaItemGenerico:PBematech_CancelaItemGenerico;
      Bematech_CancelaCupom:PBematech_CancelaCupom;
      Bematech_FechaCupomResumido:PBematech_FechaCupomResumido;
      Bematech_FechaCupom:PBematech_FechaCupom;
      Bematech_ResetaImpressora:PBematech_ResetaImpressora;
      Bematech_IniciaFechamentoCupom:PBematech_IniciaFechamentoCupom;
      Bematech_EfetuaFormaPagamento:PBematech_EfetuaFormaPagamento;
      Bematech_EfetuaFormaPagamentoDescricaoForma:PBematech_EfetuaFormaPagamentoDescricaoForma;
      Bematech_TerminaFechamentoCupom:PBematech_TerminaFechamentoCupom;
      Bematech_EstornoFormasPagamento:PBematech_EstornoFormasPagamento;
      Bematech_UsaUnidadeMedida:PBematech_UsaUnidadeMedida;
      Bematech_AumentaDescricaoItem:PBematech_AumentaDescricaoItem;
      // Funções dos Relatórios Fiscais
      Bematech_LeituraX:PBematech_LeituraX;
      Bematech_ReducaoZ:PBematech_ReducaoZ;
      Bematech_RelatorioGerencial:PBematech_RelatorioGerencial;
      Bematech_FechaRelatorioGerencial:PBematech_FechaRelatorioGerencial;
      Bematech_LeituraMemoriaFiscalData:PBematech_LeituraMemoriaFiscalData;
      Bematech_LeituraMemoriaFiscalReducao:PBematech_LeituraMemoriaFiscalReducao;
      Bematech_LeituraMemoriaFiscalSerialData:PBematech_LeituraMemoriaFiscalSerialData;
      Bematech_LeituraMemoriaFiscalSerialReducao:PBematech_LeituraMemoriaFiscalSerialReducao;
      // Funções das Operações Não Fiscais
      Bematech_RecebimentoNaoFiscal:PBematech_RecebimentoNaoFiscal;
      Bematech_AbreComprovanteNaoFiscalVinculado:PBematech_AbreComprovanteNaoFiscalVinculado;
      Bematech_UsaComprovanteNaoFiscalVinculado:PBematech_UsaComprovanteNaoFiscalVinculado;
      Bematech_UsaComprovanteNaoFiscalVinculadoTEF:PBematech_UsaComprovanteNaoFiscalVinculadoTEF;
      Bematech_FechaComprovanteNaoFiscalVinculado:PBematech_FechaComprovanteNaoFiscalVinculado;
      Bematech_Sangria:PBematech_Sangria;
      Bematech_Suprimento:PBematech_Suprimento;
      // Funções de Informações da Impressora
      Bematech_NumeroSerie:PBematech_NumeroSerie;
      Bematech_ProgramaIdAplicativoMFD:PBematech_ProgramaIdAplicativoMFD;
      Bematech_SubTotal:PBematech_SubTotal;
      Bematech_NumeroCupom:PBematech_NumeroCupom;
      Bematech_LeituraXSerial:PBematech_LeituraXSerial;
      Bematech_VersaoFirmware:PBematech_VersaoFirmware;
      Bematech_CGC_IE:PBematech_CGC_IE;
      Bematech_GrandeTotal:PBematech_GrandeTotal;
      Bematech_Cancelamentos:PBematech_Cancelamentos;
      Bematech_Descontos:PBematech_Descontos;
      Bematech_NumeroOperacoesNaoFiscais:PBematech_NumeroOperacoesNaoFiscais;
      Bematech_NumeroCuponsCancelados:PBematech_NumeroCuponsCancelados;
      Bematech_NumeroIntervencoes:PBematech_NumeroIntervencoes;
      Bematech_NumeroReducoes:PBematech_NumeroReducoes;
      Bematech_NumeroSubstituicoesProprietario:PBematech_NumeroSubstituicoesProprietario;
      Bematech_UltimoItemVendido:PBematech_UltimoItemVendido;
      Bematech_ClicheProprietario:PBematech_ClicheProprietario;
      Bematech_NumeroCaixa:PBematech_NumeroCaixa;
      Bematech_NumeroLoja:PBematech_NumeroLoja;
      Bematech_SimboloMoeda:PBematech_SimboloMoeda;
      Bematech_MinutosLigada:PBematech_MinutosLigada;
      Bematech_MinutosImprimindo:PBematech_MinutosImprimindo;
      Bematech_VerificaModoOperacao:PBematech_VerificaModoOperacao;
      Bematech_VerificaEpromConectada:PBematech_VerificaEpromConectada;
      Bematech_FlagsFiscais:PBematech_FlagsFiscais;
      Bematech_ValorPagoUltimoCupom:PBematech_ValorPagoUltimoCupom;
      Bematech_DataHoraImpressora:PBematech_DataHoraImpressora;
      Bematech_ContadoresTotalizadoresNaoFiscais:PBematech_ContadoresTotalizadoresNaoFiscais;
      Bematech_VerificaTotalizadoresNaoFiscais:PBematech_VerificaTotalizadoresNaoFiscais;
      Bematech_DataHoraReducao:PBematech_DataHoraReducao;
      Bematech_DataMovimento:PBematech_DataMovimento;
      Bematech_VerificaTruncamento:PBematech_VerificaTruncamento;
      Bematech_Acrescimos:PBematech_Acrescimos;
      Bematech_ContadorBilhetePassagem:PBematech_ContadorBilhetePassagem;
      Bematech_VerificaAliquotasIss:PBematech_VerificaAliquotasIss;
      Bematech_VerificaFormasPagamento:PBematech_VerificaFormasPagamento;
      Bematech_VerificaRecebimentoNaoFiscal:PBematech_VerificaRecebimentoNaoFiscal;
      Bematech_VerificaDepartamentos:PBematech_VerificaDepartamentos;
      Bematech_VerificaTipoImpressora:PBematech_VerificaTipoImpressora;
      Bematech_VerificaTotalizadoresParciais:PBematech_VerificaTotalizadoresParciais;
      Bematech_RetornoAliquotas:PBematech_RetornoAliquotas;
      Bematech_VerificaEstadoImpressora:PBematech_VerificaEstadoImpressora;
      Bematech_DadosUltimaReducao:PBematech_DadosUltimaReducao;
      Bematech_MonitoramentoPapel:PBematech_MonitoramentoPapel;
      Bematech_VerificaIndiceAliquotasIss:PBematech_VerificaIndiceAliquotasIss;
      Bematech_ValorFormaPagamento:PBematech_ValorFormaPagamento;
      Bematech_ValorTotalizadorNaoFiscal:PBematech_ValorTotalizadorNaoFiscal;
      // Funções de Autenticação e Gaveta de Dinheiro
      Bematech_Autenticacao:PBematech_Autenticacao;
      Bematech_ProgramaCaracterAutenticacao:PBematech_ProgramaCaracterAutenticacao;
      Bematech_AcionaGaveta:PBematech_AcionaGaveta;
      Bematech_VerificaEstadoGaveta:PBematech_VerificaEstadoGaveta;
      // Funções de Impressão de Cheques
      Bematech_ProgramaMoedaSingular:PBematech_ProgramaMoedaSingular;
      Bematech_ProgramaMoedaPlural:PBematech_ProgramaMoedaPlural;
      Bematech_CancelaImpressaoCheque:PBematech_CancelaImpressaoCheque;
      Bematech_VerificaStatusCheque:PBematech_VerificaStatusCheque;
      Bematech_ImprimeCheque:PBematech_ImprimeCheque;
      Bematech_IncluiCidadeFavorecido:PBematech_IncluiCidadeFavorecido;
      Bematech_ImprimeCopiaCheque:PBematech_ImprimeCopiaCheque;
      // Outras Funções
      Bematech_AbrePortaSerial:PBematech_AbrePortaSerial;
      Bematech_RetornoImpressora:PBematech_RetornoImpressora;
      Bematech_FechaPortaSerial:PBematech_FechaPortaSerial;
      Bematech_MapaResumo:PBematech_MapaResumo;
      Bematech_AberturaDoDia:PBematech_AberturaDoDia;
      Bematech_FechamentoDoDia:PBematech_FechamentoDoDia;
      Bematech_ImprimeConfiguracoesImpressora:PBematech_ImprimeConfiguracoesImpressora;
      Bematech_ImprimeDepartamentos:PBematech_ImprimeDepartamentos;
      Bematech_RelatorioTipo60Analitico:PBematech_RelatorioTipo60Analitico;
      Bematech_RelatorioTipo60Mestre:PBematech_RelatorioTipo60Mestre;
      Bematech_LeArquivoRetorno:PBematech_LeArquivoRetorno;
      Bematech_RegistrosTipo60:PBematech_RegistrosTipo60;
      Bematech_VerificaImpressoraLigada:PBematech_VerificaImpressoraLigada;
      // Funções da Impressora Fiscal MFD
      Bematech_AbreCupomMFD:PBematech_AbreCupomMFD;
      Bematech_CancelaCupomMFD:PBematech_CancelaCupomMFD;
      Bematech_ProgramaFormaPagamentoMFD:PBematech_ProgramaFormaPagamentoMFD;
      Bematech_EfetuaFormaPagamentoMFD:PBematech_EfetuaFormaPagamentoMFD;
      Bematech_CupomAdicionalMFD:PBematech_CupomAdicionalMFD;
      Bematech_AcrescimoDescontoItemMFD:PBematech_AcrescimoDescontoItemMFD;
      Bematech_NomeiaRelatorioGerencialMFD:PBematech_NomeiaRelatorioGerencialMFD;
      Bematech_AutenticacaoMFD:PBematech_AutenticacaoMFD;
      Bematech_AbreComprovanteNaoFiscalVinculadoMFD:PBematech_AbreComprovanteNaoFiscalVinculadoMFD;
      Bematech_ReimpressaoNaoFiscalVinculadoMFD:PBematech_ReimpressaoNaoFiscalVinculadoMFD;
      Bematech_AbreRecebimentoNaoFiscalMFD:PBematech_AbreRecebimentoNaoFiscalMFD;
      Bematech_EfetuaRecebimentoNaoFiscalMFD:PBematech_EfetuaRecebimentoNaoFiscalMFD;
      Bematech_IniciaFechamentoCupomMFD:PBematech_IniciaFechamentoCupomMFD;
      Bematech_IniciaFechamentoRecebimentoNaoFiscalMFD:PBematech_IniciaFechamentoRecebimentoNaoFiscalMFD;
      Bematech_FechaRecebimentoNaoFiscalMFD:PBematech_FechaRecebimentoNaoFiscalMFD;
      Bematech_CancelaRecebimentoNaoFiscalMFD:PBematech_CancelaRecebimentoNaoFiscalMFD;
      Bematech_AbreRelatorioGerencialMFD:PBematech_AbreRelatorioGerencialMFD;
      Bematech_UsaRelatorioGerencialMFD:PBematech_UsaRelatorioGerencialMFD;
      Bematech_SegundaViaNaoFiscalVinculadoMFD:PBematech_SegundaViaNaoFiscalVinculadoMFD;
      Bematech_EstornoNaoFiscalVinculadoMFD:PBematech_EstornoNaoFiscalVinculadoMFD;
      Bematech_NumeroSerieMFD:PBematech_NumeroSerieMFD;
      Bematech_VersaoFirmwareMFD:PBematech_VersaoFirmwareMFD;
      Bematech_CNPJMFD:PBematech_CNPJMFD;
      Bematech_InscricaoEstadualMFD:PBematech_InscricaoEstadualMFD;
      Bematech_InscricaoMunicipalMFD:PBematech_InscricaoMunicipalMFD;
      Bematech_TempoOperacionalMFD:PBematech_TempoOperacionalMFD;
      Bematech_MinutosEmitindoDocumentosFiscaisMFD:PBematech_MinutosEmitindoDocumentosFiscaisMFD;
      Bematech_ContadoresTotalizadoresNaoFiscaisMFD:PBematech_ContadoresTotalizadoresNaoFiscaisMFD;
      Bematech_VerificaTotalizadoresNaoFiscaisMFD:PBematech_VerificaTotalizadoresNaoFiscaisMFD;
      Bematech_VerificaFormasPagamentoMFD:PBematech_VerificaFormasPagamentoMFD;
      Bematech_VerificaRecebimentoNaoFiscalMFD:PBematech_VerificaRecebimentoNaoFiscalMFD;
      Bematech_VerificaRelatorioGerencialMFD:PBematech_VerificaRelatorioGerencialMFD;
      Bematech_ContadorComprovantesCreditoMFD:PBematech_ContadorComprovantesCreditoMFD;
      Bematech_ContadorOperacoesNaoFiscaisCanceladasMFD:PBematech_ContadorOperacoesNaoFiscaisCanceladasMFD;
      Bematech_ContadorRelatoriosGerenciaisMFD:PBematech_ContadorRelatoriosGerenciaisMFD;
      Bematech_ContadorCupomFiscalMFD:PBematech_ContadorCupomFiscalMFD;
      Bematech_ContadorFitaDetalheMFD:PBematech_ContadorFitaDetalheMFD;
      Bematech_ComprovantesNaoFiscaisNaoEmitidosMFD:PBematech_ComprovantesNaoFiscaisNaoEmitidosMFD;
      Bematech_NumeroSerieMemoriaMFD:PBematech_NumeroSerieMemoriaMFD;
      Bematech_MarcaModeloTipoImpressoraMFD:PBematech_MarcaModeloTipoImpressoraMFD;
      Bematech_DataHoraGravacaoUsuarioSWBasicoMFAdicional:PBematech_DataHoraGravacaoUsuarioSWBasicoMFAdicional;
      Bematech_ReducoesRestantesMFD:PBematech_ReducoesRestantesMFD;
      Bematech_VerificaTotalizadoresParciaisMFD:PBematech_VerificaTotalizadoresParciaisMFD;
      Bematech_DadosUltimaReducaoMFD:PBematech_DadosUltimaReducaoMFD;
      Bematech_LeituraMemoriaFiscalDataMFD:PBematech_LeituraMemoriaFiscalDataMFD;
      Bematech_LeituraMemoriaFiscalReducaoMFD:PBematech_LeituraMemoriaFiscalReducaoMFD;
      Bematech_LeituraMemoriaFiscalSerialDataMFD:PBematech_LeituraMemoriaFiscalSerialDataMFD;
      Bematech_LeituraMemoriaFiscalSerialReducaoMFD:PBematech_LeituraMemoriaFiscalSerialReducaoMFD;
      Bematech_LeituraChequeMFD:PBematech_LeituraChequeMFD;
      Bematech_ImprimeChequeMFD:PBematech_ImprimeChequeMFD;
      Bematech_HabilitaDesabilitaRetornoEstendidoMFD:PBematech_HabilitaDesabilitaRetornoEstendidoMFD;
      Bematech_RetornoImpressoraMFD:PBematech_RetornoImpressoraMFD;
      Bematech_AbreBilhetePassagemMFD:PBematech_AbreBilhetePassagemMFD;
      Bematech_CancelaAcrescimoDescontoItemMFD:PBematech_CancelaAcrescimoDescontoItemMFD;
      Bematech_SubTotalizaCupomMFD:PBematech_SubTotalizaCupomMFD;
      Bematech_SubTotalizaRecebimentoMFD:PBematech_SubTotalizaRecebimentoMFD;
      Bematech_TotalLivreMFD:PBematech_TotalLivreMFD;
      Bematech_TamanhoTotalMFD:PBematech_TamanhoTotalMFD;
      Bematech_AcrescimoDescontoSubtotalRecebimentoMFD:PBematech_AcrescimoDescontoSubtotalRecebimentoMFD;
      Bematech_AcrescimoDescontoSubtotalMFD:PBematech_AcrescimoDescontoSubtotalMFD;
      Bematech_CancelaAcrescimoDescontoSubtotalMFD:PBematech_CancelaAcrescimoDescontoSubtotalMFD;
      Bematech_CancelaAcrescimoDescontoSubtotalRecebimentoMFD:PBematech_CancelaAcrescimoDescontoSubtotalRecebimentoMFD;
      Bematech_TotalizaCupomMFD:PBematech_TotalizaCupomMFD;
      Bematech_TotalizaRecebimentoMFD:PBematech_TotalizaRecebimentoMFD;
      Bematech_PercentualLivreMFD:PBematech_PercentualLivreMFD;
      Bematech_DataHoraUltimoDocumentoMFD:PBematech_DataHoraUltimoDocumentoMFD;
      Bematech_MapaResumoMFD:PBematech_MapaResumoMFD;
      Bematech_RelatorioTipo60AnaliticoMFD:PBematech_RelatorioTipo60AnaliticoMFD;
      Bematech_ValorFormaPagamentoMFD:PBematech_ValorFormaPagamentoMFD;
      Bematech_ValorTotalizadorNaoFiscalMFD:PBematech_ValorTotalizadorNaoFiscalMFD;
      Bematech_VerificaEstadoImpressoraMFD:PBematech_VerificaEstadoImpressoraMFD;
      // Funções para o TEF
      Bematech_TEF_Status:PBematech_TEF_Status;
      Bematech_TEF_VendaCartao:PBematech_TEF_VendaCartao;
      Bematech_TEF_ConfirmaVenda:PBematech_TEF_ConfirmaVenda;
      Bematech_TEF_NaoConfirmaVendaImpressao:PBematech_TEF_NaoConfirmaVendaImpressao;
      Bematech_TEF_CancelaVendaCartao:PBematech_TEF_CancelaVendaCartao;
      Bematech_TEF_ImprimeTEF:PBematech_TEF_ImprimeTEF;
      Bematech_TEF_ImprimeRelatorio:PBematech_TEF_ImprimeRelatorio;
      Bematech_TEF_ADM:PBematech_TEF_ADM;
      Bematech_TEF_VendaCompleta:PBematech_TEF_VendaCompleta;
      Bematech_TEF_ConfiguraDiretorioTef:PBematech_TEF_ConfiguraDiretorioTef;
      Bematech_TEF_VendaCheque:PBematech_TEF_VendaCheque;
      Bematech_TEF_ApagaResiduos:PBematech_TEF_ApagaResiduos;
      // Funções para a balança
      Bematech_InfoBalanca:PBematech_InfoBalanca;
      // Funcoes Sintegra
      Bematech_FI_RelatorioSintegraMFD:PBematech_FI_RelatorioSintegraMFD;
      //PAF
      Bematech_FI_DownloadMFD: PBematech_FI_DownloadMFD;
      Bematech_FI_InicioFimCOOsMFD: PBematech_FI_InicioFimCOOsMFD;
      Bematech_FI_InicioFimGTsMFD: PBematech_FI_InicioFimGTsMFD;
      { Fim da Declaração }


      /////////////////////////////// Parte implementada de novas funcoes Elgin /////////////////////////////////////////////////////////////
      // Funções de Inicialização
      Elgin_AlteraSimboloMoeda:PElgin_AlteraSimboloMoeda;
      Elgin_ProgramaAliquota:PElgin_ProgramaAliquota;
      Elgin_ProgramaHorarioVerao:PElgin_ProgramaHorarioVerao;
      Elgin_NomeiaDepartamento:PElgin_NomeiaDepartamento;
      Elgin_NomeiaTotalizadorNaoSujeitoIcms:PElgin_NomeiaTotalizadorNaoSujeitoIcms;
      Elgin_ProgramaArredondamento:PElgin_ProgramaArredondamento;
      Elgin_ProgramaTruncamento:PElgin_ProgramaTruncamento;
      Elgin_LinhasEntreCupons:PElgin_LinhasEntreCupons;
      Elgin_EspacoEntreLinhas:PElgin_EspacoEntreLinhas;
      Elgin_ForcaImpactoAgulhas:PElgin_ForcaImpactoAgulhas;
      // Funções do Cupom Fiscal
      Elgin_AbreCupom:PElgin_AbreCupom;
      Elgin_VendeItem:PElgin_VendeItem;
      Elgin_VendeItemDepartamento:PElgin_VendeItemDepartamento;
      Elgin_CancelaItemAnterior:PElgin_CancelaItemAnterior;
      Elgin_CancelaItemGenerico:PElgin_CancelaItemGenerico;
      Elgin_CancelaCupom:PElgin_CancelaCupom;
      Elgin_FechaCupomResumido:PElgin_FechaCupomResumido;
      Elgin_FechaCupom:PElgin_FechaCupom;
      Elgin_ResetaImpressora:PElgin_ResetaImpressora;
      Elgin_IniciaFechamentoCupom:PElgin_IniciaFechamentoCupom;
      Elgin_EfetuaFormaPagamento:PElgin_EfetuaFormaPagamento;
      Elgin_EfetuaFormaPagamentoDescricaoForma:PElgin_EfetuaFormaPagamentoDescricaoForma;
      Elgin_TerminaFechamentoCupom:PElgin_TerminaFechamentoCupom;
      Elgin_EstornoFormasPagamento:PElgin_EstornoFormasPagamento;
      Elgin_UsaUnidadeMedida:PElgin_UsaUnidadeMedida;
      Elgin_AumentaDescricaoItem:PElgin_AumentaDescricaoItem;
      // Funções dos Relatórios Fiscais
      Elgin_LeituraX:PElgin_LeituraX;
      Elgin_ReducaoZ:PElgin_ReducaoZ;
      Elgin_RelatorioGerencial:PElgin_RelatorioGerencial;
      Elgin_AbreRelatorioGerencial:PElgin_AbreRelatorioGerencial;
      Elgin_FechaRelatorioGerencial:PElgin_FechaRelatorioGerencial;
      Elgin_LeIndicadores:PElgin_LeIndicadores;
      Elgin_LeituraMemoriaFiscalData:PElgin_LeituraMemoriaFiscalData;
      Elgin_LeituraMemoriaFiscalReducao:PElgin_LeituraMemoriaFiscalReducao;
      Elgin_LeituraMemoriaFiscalSerialData:PElgin_LeituraMemoriaFiscalSerialData;
      Elgin_LeituraMemoriaFiscalSerialReducao:PElgin_LeituraMemoriaFiscalSerialReducao;
      // Funções das Operações Não Fiscais
      Elgin_RecebimentoNaoFiscal:PElgin_RecebimentoNaoFiscal;
      Elgin_AbreComprovanteNaoFiscalVinculado:PElgin_AbreComprovanteNaoFiscalVinculado;
      Elgin_UsaComprovanteNaoFiscalVinculado:PElgin_UsaComprovanteNaoFiscalVinculado;
      Elgin_FechaComprovanteNaoFiscalVinculado:PElgin_FechaComprovanteNaoFiscalVinculado;
      Elgin_Sangria:PElgin_Sangria;
      Elgin_Suprimento:PElgin_Suprimento;
      // Funções de Informações da Impressora
      Elgin_NumeroSerie:PElgin_NumeroSerie;
      Elgin_SubTotal:PElgin_SubTotal;
      Elgin_NumeroCupom:PElgin_NumeroCupom;
      Elgin_LeituraXSerial:PElgin_LeituraXSerial;
      Elgin_VersaoFirmware:PElgin_VersaoFirmware;
      Elgin_CGC_IE:PElgin_CGC_IE;
      Elgin_GrandeTotal:PElgin_GrandeTotal;
      Elgin_Cancelamentos:PElgin_Cancelamentos;
      Elgin_Descontos:PElgin_Descontos;
      Elgin_NumeroOperacoesNaoFiscais:PElgin_NumeroOperacoesNaoFiscais;
      Elgin_NumeroCuponsCancelados:PElgin_NumeroCuponsCancelados;
      Elgin_NumeroIntervencoes:PElgin_NumeroIntervencoes;
      Elgin_NumeroReducoes:PElgin_NumeroReducoes;
      Elgin_NumeroSubstituicoesProprietario:PElgin_NumeroSubstituicoesProprietario;
      Elgin_UltimoItemVendido:PElgin_UltimoItemVendido;
      Elgin_ClicheProprietario:PElgin_ClicheProprietario;
      Elgin_NumeroCaixa:PElgin_NumeroCaixa;
      Elgin_NumeroLoja:PElgin_NumeroLoja;
      Elgin_SimboloMoeda:PElgin_SimboloMoeda;
      Elgin_MinutosLigada:PElgin_MinutosLigada;
      Elgin_MinutosImprimindo:PElgin_MinutosImprimindo;
      Elgin_VerificaModoOperacao:PElgin_VerificaModoOperacao;
      Elgin_VerificaEpromConectada:PElgin_VerificaEpromConectada;
      Elgin_FlagsFiscais:PElgin_FlagsFiscais;
      Elgin_ValorPagoUltimoCupom:PElgin_ValorPagoUltimoCupom;
      Elgin_DataHoraImpressora:PElgin_DataHoraImpressora;
      Elgin_ContadoresTotalizadoresNaoFiscais:PElgin_ContadoresTotalizadoresNaoFiscais;
      Elgin_VerificaTotalizadoresNaoFiscais:PElgin_VerificaTotalizadoresNaoFiscais;
      Elgin_DataHoraReducao:PElgin_DataHoraReducao;
      Elgin_DataMovimento:PElgin_DataMovimento;
      Elgin_VerificaTruncamento:PElgin_VerificaTruncamento;
      Elgin_Acrescimos:PElgin_Acrescimos;
      Elgin_ContadorBilhetePassagem:PElgin_ContadorBilhetePassagem;
      Elgin_VerificaAliquotasIss:PElgin_VerificaAliquotasIss;
      Elgin_VerificaFormasPagamento:PElgin_VerificaFormasPagamento;
      Elgin_VerificaRecebimentoNaoFiscal:PElgin_VerificaRecebimentoNaoFiscal;
      Elgin_VerificaDepartamentos:PElgin_VerificaDepartamentos;
      Elgin_VerificaTipoImpressora:PElgin_VerificaTipoImpressora;
      Elgin_VerificaTotalizadoresParciais:PElgin_VerificaTotalizadoresParciais;
      Elgin_RetornoAliquotas:PElgin_RetornoAliquotas;
      Elgin_VerificaEstadoImpressora:PElgin_VerificaEstadoImpressora;
      Elgin_DadosUltimaReducao:PElgin_DadosUltimaReducao;
      Elgin_MonitoramentoPapel:PElgin_MonitoramentoPapel;
      Elgin_VerificaIndiceAliquotasIss:PElgin_VerificaIndiceAliquotasIss;
      Elgin_ValorFormaPagamento:PElgin_ValorFormaPagamento;
      Elgin_ValorTotalizadorNaoFiscal:PElgin_ValorTotalizadorNaoFiscal;
      // Funções de Autenticação e Gaveta de Dinheiro
      Elgin_Autenticacao:PElgin_Autenticacao;
      Elgin_ProgramaCaracterAutenticacao:PElgin_ProgramaCaracterAutenticacao;
      Elgin_AcionaGaveta:PElgin_AcionaGaveta;
      Elgin_VerificaEstadoGaveta:PElgin_VerificaEstadoGaveta;
      // Funções de Impressão de Cheques
      Elgin_ProgramaMoedaSingular:PElgin_ProgramaMoedaSingular;
      Elgin_ProgramaMoedaPlural:PElgin_ProgramaMoedaPlural;
      Elgin_CancelaImpressaoCheque:PElgin_CancelaImpressaoCheque;
      Elgin_VerificaStatusCheque:PElgin_VerificaStatusCheque;
      Elgin_ImprimeCheque:PElgin_ImprimeCheque;
      Elgin_IncluiCidadeFavorecido:PElgin_IncluiCidadeFavorecido;
      Elgin_ImprimeCopiaCheque:PElgin_ImprimeCopiaCheque;
      // Outras Funções
      Elgin_AbrePortaSerial:PElgin_AbrePortaSerial;
      Elgin_RetornoImpressora:PElgin_RetornoImpressora;
      Elgin_FechaPortaSerial:PElgin_FechaPortaSerial;
      Elgin_MapaResumo:PElgin_MapaResumo;
      Elgin_AberturaDoDia:PElgin_AberturaDoDia;
      Elgin_FechamentoDoDia:PElgin_FechamentoDoDia;
      Elgin_ImprimeConfiguracoesImpressora:PElgin_ImprimeConfiguracoesImpressora;
      Elgin_ImprimeDepartamentos:PElgin_ImprimeDepartamentos;
      Elgin_RelatorioTipo60Analitico:PElgin_RelatorioTipo60Analitico;
      Elgin_RelatorioTipo60Mestre:PElgin_RelatorioTipo60Mestre;
      Elgin_LeArquivoRetorno:PElgin_LeArquivoRetorno;
      Elgin_RegistrosTipo60:PElgin_RegistrosTipo60;
      Elgin_VerificaImpressoraLigada:PElgin_VerificaImpressoraLigada;
      // Funções da Impressora Fiscal MFD
      Elgin_AbreCupomMFD:PElgin_AbreCupomMFD;
      Elgin_CancelaCupomMFD:PElgin_CancelaCupomMFD;
      Elgin_ProgramaFormaPagamentoMFD:PElgin_ProgramaFormaPagamentoMFD;
      Elgin_EfetuaFormaPagamentoMFD:PElgin_EfetuaFormaPagamentoMFD;
      Elgin_CupomAdicionalMFD:PElgin_CupomAdicionalMFD;
      Elgin_AcrescimoDescontoItemMFD:PElgin_AcrescimoDescontoItemMFD;
      Elgin_NomeiaRelatorioGerencialMFD:PElgin_NomeiaRelatorioGerencialMFD;
      Elgin_AutenticacaoMFD:PElgin_AutenticacaoMFD;
      Elgin_AbreComprovanteNaoFiscalVinculadoMFD:PElgin_AbreComprovanteNaoFiscalVinculadoMFD;
      Elgin_ReimpressaoNaoFiscalVinculadoMFD:PElgin_ReimpressaoNaoFiscalVinculadoMFD;
      Elgin_AbreRecebimentoNaoFiscalMFD:PElgin_AbreRecebimentoNaoFiscalMFD;
      Elgin_EfetuaRecebimentoNaoFiscalMFD:PElgin_EfetuaRecebimentoNaoFiscalMFD;
      Elgin_IniciaFechamentoCupomMFD:PElgin_IniciaFechamentoCupomMFD;
      Elgin_IniciaFechamentoRecebimentoNaoFiscalMFD:PElgin_IniciaFechamentoRecebimentoNaoFiscalMFD;
      Elgin_FechaRecebimentoNaoFiscalMFD:PElgin_FechaRecebimentoNaoFiscalMFD;
      Elgin_CancelaRecebimentoNaoFiscalMFD:PElgin_CancelaRecebimentoNaoFiscalMFD;
      Elgin_AbreRelatorioGerencialMFD:PElgin_AbreRelatorioGerencialMFD;
      Elgin_UsaRelatorioGerencialMFD:PElgin_UsaRelatorioGerencialMFD;
      Elgin_SegundaViaNaoFiscalVinculadoMFD:PElgin_SegundaViaNaoFiscalVinculadoMFD;
      Elgin_EstornoNaoFiscalVinculadoMFD:PElgin_EstornoNaoFiscalVinculadoMFD;
      Elgin_NumeroSerieMFD:PElgin_NumeroSerieMFD;
      Elgin_VersaoFirmwareMFD:PElgin_VersaoFirmwareMFD;
      Elgin_CNPJMFD:PElgin_CNPJMFD;
      Elgin_InscricaoEstadualMFD:PElgin_InscricaoEstadualMFD;
      Elgin_InscricaoMunicipalMFD:PElgin_InscricaoMunicipalMFD;
      Elgin_TempoOperacionalMFD:PElgin_TempoOperacionalMFD;
      Elgin_MinutosEmitindoDocumentosFiscaisMFD:PElgin_MinutosEmitindoDocumentosFiscaisMFD;
      Elgin_ContadoresTotalizadoresNaoFiscaisMFD:PElgin_ContadoresTotalizadoresNaoFiscaisMFD;
      Elgin_VerificaTotalizadoresNaoFiscaisMFD:PElgin_VerificaTotalizadoresNaoFiscaisMFD;
      Elgin_VerificaFormasPagamentoMFD:PElgin_VerificaFormasPagamentoMFD;
      Elgin_VerificaRecebimentoNaoFiscalMFD:PElgin_VerificaRecebimentoNaoFiscalMFD;
      Elgin_VerificaRelatorioGerencialMFD:PElgin_VerificaRelatorioGerencialMFD;
      Elgin_ContadorComprovantesCreditoMFD:PElgin_ContadorComprovantesCreditoMFD;
      Elgin_ContadorOperacoesNaoFiscaisCanceladasMFD:PElgin_ContadorOperacoesNaoFiscaisCanceladasMFD;
      Elgin_ContadorRelatoriosGerenciaisMFD:PElgin_ContadorRelatoriosGerenciaisMFD;
      Elgin_ContadorCupomFiscalMFD:PElgin_ContadorCupomFiscalMFD;
      Elgin_ContadorFitaDetalheMFD:PElgin_ContadorFitaDetalheMFD;
      Elgin_ComprovantesNaoFiscaisNaoEmitidosMFD:PElgin_ComprovantesNaoFiscaisNaoEmitidosMFD;
      Elgin_NumeroSerieMemoriaMFD:PElgin_NumeroSerieMemoriaMFD;
      Elgin_MarcaModeloTipoImpressoraMFD:PElgin_MarcaModeloTipoImpressoraMFD;
      Elgin_DataHoraSoftwareBasico:PElgin_DataHoraSoftwareBasico;
      Elgin_ReducoesRestantesMFD:PElgin_ReducoesRestantesMFD;
      Elgin_VerificaTotalizadoresParciaisMFD:PElgin_VerificaTotalizadoresParciaisMFD;
      Elgin_DadosUltimaReducaoMFD:PElgin_DadosUltimaReducaoMFD;
      Elgin_LeituraMemoriaFiscalDataMFD:PElgin_LeituraMemoriaFiscalDataMFD;
      Elgin_LeituraMemoriaFiscalReducaoMFD:PElgin_LeituraMemoriaFiscalReducaoMFD;
      Elgin_LeituraMemoriaFiscalSerialDataMFD:PElgin_LeituraMemoriaFiscalSerialDataMFD;
      Elgin_LeituraMemoriaFiscalSerialReducaoMFD:PElgin_LeituraMemoriaFiscalSerialReducaoMFD;
      Elgin_LeituraChequeMFD:PElgin_LeituraChequeMFD;
      Elgin_ImprimeChequeMFD:PElgin_ImprimeChequeMFD;
      Elgin_HabilitaDesabilitaRetornoEstendidoMFD:PElgin_HabilitaDesabilitaRetornoEstendidoMFD;
      Elgin_RetornoImpressoraMFD:PElgin_RetornoImpressoraMFD;
      Elgin_AbreBilhetePassagemMFD:PElgin_AbreBilhetePassagemMFD;
      Elgin_CancelaAcrescimoDescontoItemMFD:PElgin_CancelaAcrescimoDescontoItemMFD;
      Elgin_SubTotalizaCupomMFD:PElgin_SubTotalizaCupomMFD;
      Elgin_SubTotalizaRecebimentoMFD:PElgin_SubTotalizaRecebimentoMFD;
      Elgin_TotalLivreMFD:PElgin_TotalLivreMFD;
      Elgin_TamanhoTotalMFD:PElgin_TamanhoTotalMFD;
      Elgin_AcrescimoDescontoSubtotalRecebimentoMFD:PElgin_AcrescimoDescontoSubtotalRecebimentoMFD;
      Elgin_AcrescimoDescontoSubtotalMFD:PElgin_AcrescimoDescontoSubtotalMFD;
      Elgin_CancelaAcrescimoDescontoSubtotalMFD:PElgin_CancelaAcrescimoDescontoSubtotalMFD;
      Elgin_CancelaAcrescimoDescontoSubtotalRecebimentoMFD:PElgin_CancelaAcrescimoDescontoSubtotalRecebimentoMFD;
      Elgin_TotalizaCupomMFD:PElgin_TotalizaCupomMFD;
      Elgin_TotalizaRecebimentoMFD:PElgin_TotalizaRecebimentoMFD;
      Elgin_PercentualLivreMFD:PElgin_PercentualLivreMFD;
      Elgin_DataHoraUltimoDocumentoMFD:PElgin_DataHoraUltimoDocumentoMFD;
      Elgin_MapaResumoMFD:PElgin_MapaResumoMFD;
      Elgin_RelatorioTipo60AnaliticoMFD:PElgin_RelatorioTipo60AnaliticoMFD;
      Elgin_ValorFormaPagamentoMFD:PElgin_ValorFormaPagamentoMFD;
      Elgin_ValorTotalizadorNaoFiscalMFD:PElgin_ValorTotalizadorNaoFiscalMFD;
      Elgin_VerificaEstadoImpressoraMFD:PElgin_VerificaEstadoImpressoraMFD;
      Elgin_ProgramaIdAplicativoMFD:PElgin_ProgramaIdAplicativoMFD;

      // Funções para o TEF
      Elgin_TEF_Status:PElgin_TEF_Status;
      Elgin_TEF_VendaCartao:PElgin_TEF_VendaCartao;
      Elgin_TEF_ConfirmaVenda:PElgin_TEF_ConfirmaVenda;
      Elgin_TEF_NaoConfirmaVendaImpressao:PElgin_TEF_NaoConfirmaVendaImpressao;
      Elgin_TEF_CancelaVendaCartao:PElgin_TEF_CancelaVendaCartao;
      Elgin_TEF_ImprimeTEF:PElgin_TEF_ImprimeTEF;
      Elgin_TEF_ImprimeRelatorio:PElgin_TEF_ImprimeRelatorio;
      Elgin_TEF_ADM:PElgin_TEF_ADM;
      Elgin_TEF_VendaCompleta:PElgin_TEF_VendaCompleta;
      Elgin_TEF_ConfiguraDiretorioTef:PElgin_TEF_ConfiguraDiretorioTef;
      Elgin_TEF_VendaCheque:PElgin_TEF_VendaCheque;
      Elgin_TEF_ApagaResiduos:PElgin_TEF_ApagaResiduos;
      // Funções para a balança
      Elgin_InfoBalanca:PElgin_InfoBalanca;
      //PAF
      Elgin_DownloadMFD:PElgin_DownloadMFD;
      { Fim da Declaração }

      { =======================  SCFI   ================== }
      SCFI_ecfLeitMemFisc:PSCFI_ecfLeitMemFisc;
      SCFI_ChangePort:PSCFI_ChangePort;
      SCFI_ecfStatusCupom:PSCFI_ecfStatusCupom;
      SCFI_ecfLeituraXSerial:PSCFI_ecfLeituraXSerial;
      SCFI_ecfStatusImp:PSCFI_ecfStatusImp;
      SCFI_ecfAbreGaveta:PSCFI_ecfAbreGaveta;
      SCFI_dllActiveDebug:PSCFI_dllActiveDebug;
      SCFI_ecfReducaoZ:PSCFI_ecfReducaoZ;
      SCFI_ecfLineFeed:PSCFI_ecfLineFeed;
      SCFI_ecfLeituraX:PSCFI_ecfLeituraX;
      SCFI_ecfCancDoc:PSCFI_ecfCancDoc;
      SCFI_ecfInicCupomNFiscal:PSCFI_ecfInicCupomNFiscal;
      SCFI_ecfImpLinha:PSCFI_ecfImpLinha;
      SCFI_ecfFimTrans:PSCFI_ecfFimTrans;
      SCFI_ecfImpCab:PSCFI_ecfImpCab;
      SCFI_ecfCargaAliqSelect:PSCFI_ecfCargaAliqSelect;
      SCFI_ecfVenda_Item:PSCFI_ecfVenda_Item;
      SCFI_ecfVendaItem:PSCFI_ecfVendaItem;
      SCFI_ecfVendaItem78:PSCFI_ecfVendaItem78;
      SCFI_ecfVendaItem3d:PSCFI_ecfVendaItem3d;
      SCFI_ecfDescItem:PSCFI_ecfDescItem;
      SCFI_ecfPagCancPag:PSCFI_ecfPagCancPag;
      SCFI_ecfCancItem:PSCFI_ecfCancItem;
      SCFI_ecfAcertaData:PSCFI_ecfAcertaData;
      SCFI_ecfCancVenda:PSCFI_ecfCancVenda;
      SCFI_ecfCancItemDef:PSCFI_ecfCancItemDef;
      SCFI_ecfSubTotal:PSCFI_ecfSubTotal;
      SCFI_ecfCancAcresDescSubTotal:PSCFI_ecfCancAcresDescSubTotal;
      SCFI_ecfAutentica:PSCFI_ecfAutentica;
      SCFI_ecfImpCheque:PSCFI_ecfImpCheque;
      SCFI_ecfImpChequeTPrint:PSCFI_ecfImpChequeTPrint;
      SCFI_ecfChequeDPrint300:PSCFI_ecfChequeDPrint300;
      SCFI_ecfFimTransVinc:PSCFI_ecfFimTransVinc;
      SCFI_ecfRZGerencial:PSCFI_ecfRZGerencial;
      SCFI_ecfLXGerencial:PSCFI_ecfLXGerencial;
      SCFI_ecfProgNFComprov:PSCFI_ecfProgNFComprov;
      SCFI_ecfInicCNFVinculado:PSCFI_ecfInicCNFVinculado;
      SCFI_ecfPrazoCancPrazo:PSCFI_ecfPrazoCancPrazo;
      SCFI_ecfPagamento:PSCFI_ecfPagamento;
      SCFI_ecfPayPatterns:PSCFI_ecfPayPatterns;
      SCFI_ecfStatusDocsNFs:PSCFI_ecfStatusDocsNFs;
      SCFI_ecfStatusEquipo:PSCFI_ecfStatusEquipo;

      //
      Schalter3D_FimTransVinc: PSchalter3D_FimTransVinc;
      Schalter3D_FimTrans: PSchalter3D_FimTrans;
      Schalter3D_ProgNFComprov: PSchalter3D_ProgNFComprov;
      Schalter3D_StatusDocsNFs: PSchalter3D_StatusDocsNFs;
      Schalter3D_InicCNFVinculado: PSchalter3D_InicCNFVinculado;
      Schalter3D_PayPatterns: PSchalter3D_PayPatterns;
      Schalter3D_ChangePort: PSchalter3D_ChangePort;
      Schalter3D_StatusEquipo: PSchalter3D_StatusEquipo;
      Schalter3D_AbreGaveta: PSchalter3D_AbreGaveta;
      Schalter3D_LeituraX: PSchalter3D_LeituraX;
      Schalter3D_ReducaoZ: PSchalter3D_ReducaoZ;
      Schalter3D_CancDoc: PSchalter3D_CancDoc;
      Schalter3D_CancVenda: PSchalter3D_CancVenda;
      Schalter3D_LineFeed: PSchalter3D_LineFeed;
      Schalter3D_ImpLinha: PSchalter3D_ImpLinha;
      Schalter3D_Autentica: PSchalter3D_Autentica;
      Schalter3D_StatusImp: PSchalter3D_StatusImp;
      Schalter3D_StatusCupom: PSchalter3D_StatusCupom;
      Schalter3D_ImpCab: PSchalter3D_ImpCab;
      Schalter3D_InicCupomNFiscal: PSchalter3D_InicCupomNFiscal;
      Schalter3D_Venda_Item: PSchalter3D_Venda_Item;
      Schalter3D_DescItem: PSchalter3D_DescItem;
      Schalter3D_CancItem: PSchalter3D_CancItem;
      Schalter3D_PagCancPag: PSchalter3D_PagCancPag;
      Schalter3D_PrazoCancPrazo: PSchalter3D_PrazoCancPrazo;
      Schalter3D_SubTotal: PSchalter3D_SubTotal;
      Schalter3D_CancAcresDescSubTotal: PSchalter3D_CancAcresDescSubTotal;
      Schalter3D_LeitMemFisc: PSchalter3D_LeitMemFisc;
      Schalter3D_LeitXSer: PSchalter3D_LeitXSer;
      Schalter3D_LeituraXSerial: PSchalter3D_LeituraXSerial;
      Schalter3D_AcertaData: PSchalter3D_AcertaData;
      Schalter3D_CancItemDef: PSchalter3D_CancItemDef;
      Schalter3D_ImpCheque: PSchalter3D_ImpCheque;
      Schalter3D_ImpChequeTPrint: PSchalter3D_ImpChequeTPrint;
      Schalter3D_ChequeDPrint300: PSchalter3D_ChequeDPrint300;
      Schalter3D_LXGerencial: PSchalter3D_LXGerencial;
      Schalter3D_Pagamento: PSchalter3D_Pagamento;
      Schalter3D_ParamStatusEquipo: PSchalter3D_ParamStatusEquipo;
      //
      Urano1FIT_LeituraMF: PUrano1FIT_LeituraMF;
      Urano1FIT_LogSerial: PUrano1FIT_LogSerial;
      Urano1FIT_LeSensor: PUrano1FIT_LeSensor;
      Urano1FIT_InicializaDLL: PUrano1FIT_InicializaDLL;
      Urano1FIT_FinalizaDLL: PUrano1FIT_FinalizaDLL;
      Urano1FIT_AvancaLinhas: PUrano1FIT_AvancaLinhas;
      Urano1FIT_EstadoImpressora: PUrano1FIT_EstadoImpressora;
      Urano1FIT_AbreGaveta: PUrano1FIT_AbreGaveta;
      Urano1FIT_LeRegistradores: PUrano1FIT_LeRegistradores;
      Urano1FIT_VendaItem: PUrano1FIT_VendaItem;
      Urano1FIT_CancelaVenda: PUrano1FIT_CancelaVenda;
      Urano1FIT_CancelaCupom: PUrano1FIT_CancelaCupom;
      Urano1FIT_Relatorio_XZ: PUrano1FIT_Relatorio_XZ;
      Urano1FIT_FechaCupom: PUrano1FIT_FechaCupom;
      Urano1FIT_Pagamento: PUrano1FIT_Pagamento;
      Urano1FIT_ImprimeCabecalho: PUrano1FIT_ImprimeCabecalho;
      Urano1FIT_Propaganda: PUrano1FIT_Propaganda;
      Urano1FIT_CargaCliche: PUrano1FIT_CargaCliche;
      Urano1FIT_IdComprador: PUrano1FIT_IdComprador;
      Urano1FIT_CargaAliquota: PUrano1FIT_CargaAliquota;
      Urano1FIT_LeECF: PUrano1FIT_LeECF;
      Urano1FIT_CancelaItem: PUrano1FIT_CancelaItem;
      Urano1FIT_AcrescimoSubtotal: PUrano1FIT_AcrescimoSubtotal;
      Urano1FIT_DescontoSubtotal: PUrano1FIT_DescontoSubtotal;
      Urano1FIT_DescontoItem: PUrano1FIT_DescontoItem;
      Urano1FIT_ProgramaRelogio: PUrano1FIT_ProgramaRelogio;
      Urano1FIT_FormaPagamento: PUrano1FIT_FormaPagamento;
      Urano1FIT_CargaNaoVinculado: PUrano1FIT_CargaNaoVinculado;
      Urano1FIT_EspacamentoLinhas: PUrano1FIT_EspacamentoLinhas;
      Urano1FIT_VinculadoTEF: PUrano1FIT_VinculadoTEF;
      Urano1FIT_Autentica: PUrano1FIT_Autentica;
      Urano1FIT_CupomStub: PUrano1FIT_CupomStub;
      Urano1FIT_ImprimeCheque: PUrano1FIT_ImprimeCheque;
      Urano1FIT_NovoEstabelecimento: PUrano1FIT_NovoEstabelecimento;
      Urano1FIT_VinculadoCartao: PUrano1FIT_VinculadoCartao;
      Urano1FIT_Mecanismo: PUrano1FIT_Mecanismo;
      Urano1FIT_EmiteNaoVinculado: PUrano1FIT_EmiteNaoVinculado;
      Urano1FIT_FinalizaRelatorio: PUrano1FIT_FinalizaRelatorio;
      Urano1FIT_CortaPapel: PUrano1FIT_CortaPapel;
      Urano1FIT_LinhasLivres: PUrano1FIT_LinhasLivres;
      Urano1FIT_Vinculado: PUrano1FIT_Vinculado;
      Urano1FIT_Rascunho: PUrano1FIT_Rascunho;
      Urano1FIT_ContrasteTermico: PUrano1FIT_ContrasteTermico;
      Urano1FIT_VinculadoNSeq: PUrano1FIT_VinculadoNSeq;
      //
      UranoEFC_InicializaDLL: PUranoEFC_InicializaDLL;
      UranoEFC_LeituraMF: PUranoEFC_LeituraMF;
      UranoEFC_FinalizaDLL: PUranoEFC_FinalizaDLL;
      UranoEFC_DescontoItem: PUranoEFC_DescontoItem;
      UranoEFC_EstadoImpressora: PUranoEFC_EstadoImpressora;
      UranoEFC_FormaPagamento: PUranoEFC_FormaPagamento;
      UranoEFC_ImprimeCabecalho: PUranoEFC_ImprimeCabecalho;
      UranoEFC_VendaItem: PUranoEFC_VendaItem;
      UranoEFC_CancelaItem: PUranoEFC_CancelaItem;
      UranoEFC_Pagamento: PUranoEFC_Pagamento;
      UranoEFC_EmiteVinculado: PUranoEFC_EmiteVinculado;
      UranoEFC_EmiteNaoVinculado: PUranoEFC_EmiteNaoVinculado;
      UranoEFC_FechaCupom: PUranoEFC_FechaCupom;
      UranoEFC_LinhasLivres: PUranoEFC_LinhasLivres;
      UranoEFC_CancelaVenda: PUranoEFC_CancelaVenda;
      UranoEFC_CancelaCupom: PUranoEFC_CancelaCupom;
      UranoEFC_DescontoSubtotal: PUranoEFC_DescontoSubtotal;
      UranoEFC_AcrescimoSubtotal: PUranoEFC_AcrescimoSubtotal;
      UranoEFC_Relatorio_XZ: PUranoEFC_Relatorio_XZ;
      UranoEFC_FinalizaRelatorio: PUranoEFC_FinalizaRelatorio;
      UranoEFC_propaganda: PUranoEFC_propaganda;
      UranoEFC_ProgramaRelogio: PUranoEFC_ProgramaRelogio;
      UranoEFC_AbreGaveta: PUranoEFC_AbreGaveta;
      UranoEFC_AvancaLinhas: PUranoEFC_AvancaLinhas;
      UranoEFC_LeRegistradores: PUranoEFC_LeRegistradores;
      UranoEFC_Autentica: PUranoEFC_Autentica;
      UranoEFC_LeSensor: PUranoEFC_LeSensor;
      UranoEFC_IdComprador: PUranoEFC_IdComprador;
      UranoEFC_CupomStub: PUranoEFC_CupomStub;
      UranoEFC_SimboloMoeda: PUranoEFC_SimboloMoeda;
      UranoEFC_ConfiguraCabRodape: PUranoEFC_ConfiguraCabRodape;
      UranoEFC_VersaoBiblioteca: PUranoEFC_VersaoBiblioteca;
      UranoEFC_ImprimeCheque: PUranoEFC_ImprimeCheque;
      UranoEFC_EspacamentoLinhas: PUranoEFC_EspacamentoLinhas;
      UranoEFC_ConfiguraDocFiscal: PUranoEFC_ConfiguraDocFiscal;
      UranoEFC_NomeMoeda: PUranoEFC_NomeMoeda;
      UranoEFC_HabVinculadoNSeq: PUranoEFC_HabVinculadoNSeq;
      UranoEFC_CargaNaoVinculado: PUranoEFC_CargaNaoVinculado;
      //
      Schalter2S_ecfLeitMemFisc: PSchalter2S_ecfLeitMemFisc;
      Schalter2S_ChangePort: PSchalter2S_ChangePort;
      Schalter2S_ecfStatusCupom: PSchalter2S_ecfStatusCupom;
      Schalter2S_ecfLeituraXSerial: PSchalter2S_ecfLeituraXSerial;
      Schalter2S_ecfStatusImp: PSchalter2S_ecfStatusImp;
      Schalter2S_ecfAbreGaveta: PSchalter2S_ecfAbreGaveta;
      Schalter2S_ecfReducaoZ: PSchalter2S_ecfReducaoZ;
      Schalter2S_ecfLineFeed: PSchalter2S_ecfLineFeed;
      Schalter2S_ecfLeituraX: PSchalter2S_ecfLeituraX;
      Schalter2S_ecfCancDoc: PSchalter2S_ecfCancDoc;
      Schalter2S_ecfInicCupomNFiscal: PSchalter2S_ecfInicCupomNFiscal;
      Schalter2S_ecfImpLinha: PSchalter2S_ecfImpLinha;
      Schalter2S_ecfFimTrans: PSchalter2S_ecfFimTrans;
      Schalter2S_ecfImpCab: PSchalter2S_ecfImpCab;
      Schalter2S_ecfVenda_Item: PSchalter2S_ecfVenda_Item;
      Schalter2S_ecfVendaItem: PSchalter2S_ecfVendaItem;
      Schalter2S_ecfDescItem: PSchalter2S_ecfDescItem;
      Schalter2S_ecfPagCancPag: PSchalter2S_ecfPagCancPag;
      Schalter2S_ecfCancItem: PSchalter2S_ecfCancItem;
      Schalter2S_ecfAcertaData: PSchalter2S_ecfAcertaData;
      Schalter2S_ecfCancVenda: PSchalter2S_ecfCancVenda;
      Schalter2S_ecfCancItemDef: PSchalter2S_ecfCancItemDef;
      Schalter2S_ecfSubTotal: PSchalter2S_ecfSubTotal;
      Schalter2S_ecfCancAcresDescSubTotal: PSchalter2S_ecfCancAcresDescSubTotal;
      Schalter2S_ecfAutentica: PSchalter2S_ecfAutentica;
      //
      Dataregis_AbrePorta: PDataregis_AbrePorta;
      Dataregis_FechaPorta: PDataregis_FechaPorta;
      Dataregis_EnviaComando: PDataregis_EnviaComando;
      //
      Procomp_DescontoItem: PProcomp_DescontoItem;
      Procomp_OpenCIF: PProcomp_OpenCIF;
      Procomp_CloseCIF: PProcomp_CloseCIF;
      Procomp_AbreCupomFiscal: PProcomp_AbreCupomFiscal;
      Procomp_AbreCupomVinculado: PProcomp_AbreCupomVinculado;
      Procomp_VendaItem: PProcomp_VendaItem;
      Procomp_CancelamentoItem: PProcomp_CancelamentoItem;
      Procomp_ObtemRetorno: PProcomp_ObtemRetorno;
      Procomp_TotalizarCupom: PProcomp_TotalizarCupom;
      Procomp_Pagamento: PProcomp_Pagamento;
      Procomp_FechaCupomFiscal: PProcomp_FechaCupomFiscal;
      Procomp_CancelaCupomFiscal: PProcomp_CancelaCupomFiscal;
      Procomp_LeituraX: PProcomp_LeituraX;
      Procomp_ReducaoZ: PProcomp_ReducaoZ;
      Procomp_LeMemFiscalData: PProcomp_LeMemFiscalData;
      Procomp_LeMemFiscalReducao: PProcomp_LeMemFiscalReducao;
      Procomp_AbreCupomNaoVinculado: PProcomp_AbreCupomNaoVinculado;
      Procomp_EncerrarCupom: PProcomp_EncerrarCupom;
      Procomp_ImprimeLinhaNaoFiscal: PProcomp_ImprimeLinhaNaoFiscal;
      Procomp_TransStatus: PProcomp_TransStatus;
      Procomp_ECFPar: PProcomp_ECFPar;
      Procomp_ECFParEsp: PProcomp_ECFParEsp;
      Procomp_ECFID: PProcomp_ECFID;
      Procomp_TransTabAliquotas: PProcomp_TransTabAliquotas;
      Procomp_AbrirGaveta: PProcomp_AbrirGaveta;
      Procomp_ProgramaHorarioVerao: PProcomp_ProgramaHorarioVerao;
      Procomp_AvancaLinha: PProcomp_AvancaLinha;
      Procomp_ProgLinhaAdicional: PProcomp_ProgLinhaAdicional;
      Procomp_ModoChequeValidacao: PProcomp_ModoChequeValidacao;
      Procomp_ImprimeValidacao: PProcomp_ImprimeValidacao;
      Procomp_TransDataHora: PProcomp_TransDataHora;
      //
      Trends_ModoChequeValidacao: PTrends_ModoChequeValidacao;
      Trends_ImprimeCheque: PTrends_ImprimeCheque;
      Trends_ImprimeValidacao: PTrends_ImprimeValidacao;
      Trends_CancelaChequeValidacao: PTrends_CancelaChequeValidacao;
      Trends_TotalizarCupomParcial: PTrends_TotalizarCupomParcial;
      Trends_TotalizarCupom: PTrends_TotalizarCupom;
      Trends_Pagamento: PTrends_Pagamento;
      Trends_FechaCupomFiscal: PTrends_FechaCupomFiscal;
      Trends_DescontoItem: PTrends_DescontoItem;
      Trends_AbreCupomFiscal: PTrends_AbreCupomFiscal;
      Trends_VendaItem: PTrends_VendaItem;
      Trends_CancelamentoItem: PTrends_CancelamentoItem;
      Trends_CancelaCupomFiscal: PTrends_CancelaCupomFiscal;
      Trends_LeituraX: PTrends_LeituraX;
      Trends_ReducaoZ: PTrends_ReducaoZ;
      Trends_LeMemFiscalData: PTrends_LeMemFiscalData;
      Trends_LeMemFiscalReducao: PTrends_LeMemFiscalReducao;
      Trends_AbreCupomVinculado: PTrends_AbreCupomVinculado;
      Trends_EncerraCupomNaoFiscal: PTrends_EncerraCupomNaoFiscal;
      Trends_AbreCupomNaoVinculado: PTrends_AbreCupomNaoVinculado;
      Trends_OperRegNaoVinculado: PTrends_OperRegNaoVinculado;
      Trends_CancelaCupomNaoFiscal: PTrends_CancelaCupomNaoFiscal;
      Trends_ImprimeLinhaNaoFiscal: PTrends_ImprimeLinhaNaoFiscal;
      Trends_ProgramaLegenda: PTrends_ProgramaLegenda;
      Trends_AbrirGaveta: PTrends_AbrirGaveta;
      Trends_ProgramaHorarioVerao: PTrends_ProgramaHorarioVerao;
      Trends_ImprimeTotalizadores: PTrends_ImprimeTotalizadores;
      Trends_TransTabAliquotas: PTrends_TransTabAliquotas;
      Trends_TransTotCont: PTrends_TransTotCont;
      Trends_TransStatusDecod: PTrends_TransStatusDecod;
      Trends_TransDataHora: PTrends_TransDataHora;
      Trends_EcfPar: PTrends_EcfPar;
      Trends_ProgLinhaAdicional: PTrends_ProgLinhaAdicional;
      Trends_AjusteHora: PTrends_AjusteHora;
      Trends_EcfID: PTrends_EcfID;
      Trends_ProgRelogio: PTrends_ProgRelogio;
      Trends_GravaDados: PTrends_GravaDados;
      Trends_RecompoeDadosNOVRAM: PTrends_RecompoeDadosNOVRAM;
      Trends_ProgNumSerie: PTrends_ProgNumSerie;
      Trends_ProgAliquotas: PTrends_ProgAliquotas;
      Trends_ProgSimbolo: PTrends_ProgSimbolo;
      Trends_ProgRazaoSocial: PTrends_ProgRazaoSocial;
      Trends_ProgMoeda: PTrends_ProgMoeda;
      Trends_ProgArredondamento: PTrends_ProgArredondamento;
      { ---------------------------------------------------------- }


      (* Funções de Venda AFRAC *)

      AFRAC_AbrirCupom:                         TAFRAC_AbrirCupom;
      AFRAC_VenderItem:                         TAFRAC_VenderItem;
      AFRAC_AcrescimoDescontoItem:              TAFRAC_AcrescimoDescontoItem;
      AFRAC_CancelarItem:                       TAFRAC_CancelarItem;
      AFRAC_AcrescimoDescontoCupom:             TAFRAC_AcrescimoDescontoCupom;
      AFRAC_FecharAcrescimoDesconto:            TAFRAC_FecharAcrescimoDesconto;
      AFRAC_FormaPagamento:                     TAFRAC_FormaPagamento;
      AFRAC_InformarCNPJ:                       TAFRAC_InformarCNPJ;
      AFRAC_InformarRazaoSocial:                TAFRAC_InformarRazaoSocial;
      AFRAC_InformarInscricao:                  TAFRAC_InformarInscricao;
      AFRAC_InformarEndereco:                   TAFRAC_InformarEndereco;
      AFRAC_InformarGerente:                    TAFRAC_InformarGerente;
      AFRAC_InformarOperador:                   TAFRAC_InformarOperador;
      AFRAC_InformarVendedor:                   TAFRAC_InformarVendedor;
      AFRAC_InformarMensagemCupom:              TAFRAC_InformarMensagemCupom;
      AFRAC_FecharCupom:                        TAFRAC_FecharCupom;
      AFRAC_CancelarCupom:                      TAFRAC_CancelarCupom;


      (* Funcoes de Configuração e Relatórios AFRAC *)

      AFRAC_AbrirVinculado:                     TAFRAC_AbrirVinculado;
      AFRAC_ImprimirVinculado:                  TAFRAC_ImprimirVinculado;
      AFRAC_FecharVinculado:                    TAFRAC_FecharVinculado;
      AFRAC_CancelarVinculado:                  TAFRAC_CancelarVinculado;
      AFRAC_AbrirNaoFiscalNaoVinculado:         TAFRAC_AbrirNaoFiscalNaoVinculado;
      AFRAC_RegistrarNaoFiscal:                 TAFRAC_RegistrarNaoFiscal;
      AFRAC_CancelarNaoVinculado:               TAFRAC_CancelarNaoVinculado;
      AFRAC_AbrirRelatorioGerencial:            TAFRAC_AbrirRelatorioGerencial;
      AFRAC_ImprimirRelatorioGerencial:         TAFRAC_ImprimirRelatorioGerencial;
      AFRAC_FecharRelatorioGerencial:           TAFRAC_FecharRelatorioGerencial;
      AFRAC_LeituraX:                           TAFRAC_LeituraX;
      AFRAC_ReducaoZ:                           TAFRAC_ReducaoZ;
      AFRAC_EmitirLeituraMemoriaFiscal:         TAFRAC_EmitirLeituraMemoriaFiscal;
      AFRAC_GravarLeituraX:                     TAFRAC_GravarLeituraX;
      AFRAC_GravarLeituraMemoriaFiscal:         TAFRAC_GravarLeituraMemoriaFiscal;


      (* Funcoes de Status e Informações AFRAC *)

      AFRAC_LerInformacaoImpressora:            TAFRAC_LerInformacaoImpressora;
      AFRAC_LerAliquotas:                       TAFRAC_LerAliquotas;
      AFRAC_LerValorTotalAliquotas:             TAFRAC_LerValorTotalAliquotas;
      AFRAC_LerTotalizadoresNSICMS:             TAFRAC_LerTotalizadoresNSICMS;
      AFRAC_LerTodasFormasPagamento:            TAFRAC_LerTodasFormasPagamento;
      AFRAC_AbrirPorta:                         TAFRAC_AbrirPorta;
      AFRAC_FecharPorta:                        TAFRAC_FecharPorta;
      AFRAC_VerificarEstado:                    TAFRAC_VerificarEstado;
      AFRAC_Retornar_Features:                  TAFRAC_Retornar_Features;
      AFRAC_PegarCodigoErro:                    TAFRAC_PegarCodigoErro;
      AFRAC_ConfigurarFonte:                    TAFRAC_ConfigurarFonte;
      AFRAC_InformarFonte:                      TAFRAC_InformarFonte;
      AFRAC_Configura:                          TAFRAC_Configura;
      AFRAC_Indice:                             TAFRAC_Indice;
      AFRAC_Fabricante:                         TAFRAC_Fabricante;


      (* Funcoes Auxiliares AFRAC *)

      AFRAC_Autenticar:                         TAFRAC_Autenticar;
      AFRAC_RepetirAutenticacao:                TAFRAC_RepetirAutenticacao;
      AFRAC_AbrirGaveta:                        TAFRAC_AbrirGaveta;
      AFRAC_VerificarGaveta:                    TAFRAC_VerificarGaveta;
      AFRAC_ChequeProgramarMoeda:               TAFRAC_ChequeProgramarMoeda;
      AFRAC_ChequeImprimir:                     TAFRAC_ChequeImprimir;
      AFRAC_ChequeConfigurarFormatacao:         TAFRAC_ChequeConfigurarFormatacao;
      AFRAC_ChequeImprimirVerso:                TAFRAC_ChequeImprimirVerso;
      AFRAC_ChequeLerCMC7:                      TAFRAC_ChequeLerCMC7;
      AFRAC_ChequeExpulsar:                     TAFRAC_ChequeExpulsar;
      AFRAC_ProgramarTributacao:                TAFRAC_ProgramarTributacao;
      AFRAC_EntrarHorarioVerao:                 TAFRAC_EntrarHorarioVerao;
      AFRAC_SairHorarioVerao:                   TAFRAC_SairHorarioVerao;
      AFRAC_AjustarRelogio:                     TAFRAC_AjustarRelogio;
      AFRAC_ArredondarTruncar:                  TAFRAC_ArredondarTruncar;
      AFRAC_ForcarImpactoAgulhas:               TAFRAC_ForcarImpactoAgulhas;
      AFRAC_ConfigurarLinhasEntreCupons:        TAFRAC_ConfigurarLinhasEntreCupons;
      AFRAC_ProgramarTotalizadorNaoSujeitoICMS: TAFRAC_ProgramarTotalizadorNaoSujeitoICMS;
      AFRAC_ProgramarRelatorioGerencial:        TAFRAC_ProgramarRelatorioGerencial;
      AFRAC_LerIndiceRelatorioGerencial:        TAFRAC_LerIndiceRelatorioGerencial;
      AFRAC_ProgramarFormasDePagamento:         TAFRAC_ProgramarFormasDePagamento;
      AFRAC_LerFormasDePagamento:               TAFRAC_LerFormasDePagamento;
      AFRAC_SetaPadrao:                         TAFRAC_SetaPadrao;
      AFRAC_AbrirDia:                           TAFRAC_AbrirDia;


      Daruma_FI_AbreCupom: TDaruma_FI_AbreCupom;
      Daruma_FI_VendeItem: TDaruma_FI_VendeItem;
      Daruma_FI_VendeItemDepartamento: TDaruma_FI_VendeItemDepartamento;
      Daruma_FI_VendeItemTresDecimais: TDaruma_FI_VendeItemTresDecimais;
      Daruma_FI_FechaCupomResumido: TDaruma_FI_FechaCupomResumido;
      Daruma_FI_IniciaFechamentoCupom: TDaruma_FI_IniciaFechamentoCupom;
      Daruma_FI_EfetuaFormaPagamento: TDaruma_FI_EfetuaFormaPagamento;
      Daruma_FI_EfetuaFormaPagamentoDescricaoForma: TDaruma_FI_EfetuaFormaPagamentoDescricaoForma;
      Daruma_FI_IdentificaConsumidor: TDaruma_FI_IdentificaConsumidor;
      Daruma_FI_TerminaFechamentoCupom: TDaruma_FI_TerminaFechamentoCupom;
      Daruma_FI_FechaCupom: TDaruma_FI_FechaCupom;
      Daruma_FI_CancelaItemAnterior: TDaruma_FI_CancelaItemAnterior;
      Daruma_FI_CancelaItemGenerico: TDaruma_FI_CancelaItemGenerico;
      Daruma_FI_CancelaCupom: TDaruma_FI_CancelaCupom;
      Daruma_FI_AumentaDescricaoItem: TDaruma_FI_AumentaDescricaoItem;
      Daruma_FI_UsaUnidadeMedida: TDaruma_FI_UsaUnidadeMedida;
      Daruma_FI_EmitirCupomAdicional: TDaruma_FI_EmitirCupomAdicional;
      Daruma_FI_EstornoFormasPagamento: TDaruma_FI_EstornoFormasPagamento;
      Daruma_FI_AbreComprovanteNaoFiscalVinculado: TDaruma_FI_AbreComprovanteNaoFiscalVinculado;
      Daruma_FI_UsaComprovanteNaoFiscalVinculado: TDaruma_FI_UsaComprovanteNaoFiscalVinculado;
      Daruma_FI_FechaComprovanteNaoFiscalVinculado: TDaruma_FI_FechaComprovanteNaoFiscalVinculado;
      Daruma_FI_RelatorioGerencial: TDaruma_FI_RelatorioGerencial;
      Daruma_FI_AbreRelatorioGerencial: TDaruma_FI_AbreRelatorioGerencial;
      Daruma_FI_EnviarTextoCNF: TDaruma_FI_EnviarTextoCNF;
      Daruma_FI_FechaRelatorioGerencial: TDaruma_FI_FechaRelatorioGerencial;
      Daruma_FI_RecebimentoNaoFiscal: TDaruma_FI_RecebimentoNaoFiscal;
      Daruma_FI_AbreRecebimentoNaoFiscal: TDaruma_FI_AbreRecebimentoNaoFiscal;
      Daruma_FI_EfetuaFormaPagamentoNaoFiscal: TDaruma_FI_EfetuaFormaPagamentoNaoFiscal;
      Daruma_FI_Sangria: TDaruma_FI_Sangria;
      Daruma_FI_Suprimento: TDaruma_FI_Suprimento;
      Daruma_FI_FundoCaixa: TDaruma_FI_FundoCaixa;
      Daruma_FI_LeituraX: TDaruma_FI_LeituraX;
      Daruma_FI_ReducaoZ: TDaruma_FI_ReducaoZ;
      Daruma_FI_ReducaoZAjustaDataHora: TDaruma_FI_ReducaoZAjustaDataHora;
      Daruma_FI_LeituraMemoriaFiscalData: TDaruma_FI_LeituraMemoriaFiscalData;
      Daruma_FI_LeituraMemoriaFiscalReducao: TDaruma_FI_LeituraMemoriaFiscalReducao;
      Daruma_FI_LeituraMemoriaFiscalSerialData: TDaruma_FI_LeituraMemoriaFiscalSerialData;
      Daruma_FI_LeituraMemoriaFiscalSerialReducao: TDaruma_FI_LeituraMemoriaFiscalSerialReducao;
      Daruma_FI_VerificaDocAutenticacao: TDaruma_FI_VerificaDocAutenticacao;
      Daruma_FI_Autenticacao: TDaruma_FI_Autenticacao;
      Daruma_FI_AutenticacaoStr: TDaruma_FI_AutenticacaoStr;
      Daruma_FI_VerificaEstadoGaveta: TDaruma_FI_VerificaEstadoGaveta;
      Daruma_FI_VerificaEstadoGavetaStr: TDaruma_FI_VerificaEstadoGavetaStr;
      Daruma_FI_AcionaGaveta: TDaruma_FI_AcionaGaveta;
      Daruma_FI_AbrePortaSerial: TDaruma_FI_AbrePortaSerial;
      Daruma_FI_FechaPortaSerial: TDaruma_FI_FechaPortaSerial;
      Daruma_FI_AberturaDoDia: TDaruma_FI_AberturaDoDia;
      Daruma_FI_FechamentoDoDia: TDaruma_FI_FechamentoDoDia;
      Daruma_FI_ImprimeConfiguracoesImpressora: TDaruma_FI_ImprimeConfiguracoesImpressora;
      Daruma_FI_ProgramaAliquota: TDaruma_FI_ProgramaAliquota;
      Daruma_FI_NomeiaTotalizadorNaoSujeitoIcms: TDaruma_FI_NomeiaTotalizadorNaoSujeitoIcms;
      Daruma_FI_ProgramaFormasPagamento: TDaruma_FI_ProgramaFormasPagamento;
      Daruma_FI_ProgramaOperador: TDaruma_FI_ProgramaOperador;
      Daruma_FI_ProgramaArredondamento: TDaruma_FI_ProgramaArredondamento;
      Daruma_FI_ProgramaTruncamento: TDaruma_FI_ProgramaTruncamento;
      Daruma_FI_LinhasEntreCupons: TDaruma_FI_LinhasEntreCupons;
      Daruma_FI_EspacoEntreLinhas: TDaruma_FI_EspacoEntreLinhas;
      Daruma_FI_ProgramaHorarioVerao: TDaruma_FI_ProgramaHorarioVerao;
      Daruma_FI_EqualizaFormasPgto: TDaruma_FI_EqualizaFormasPgto;
      Daruma_FI_ProgramaVinculados: TDaruma_FI_ProgramaVinculados;
      Daruma_FI_ProgFormasPagtoSemVincular: TDaruma_FI_ProgFormasPagtoSemVincular;
      Daruma_FI_CfgFechaAutomaticoCupom: TDaruma_FI_CfgFechaAutomaticoCupom;
      Daruma_FI_CfgRedZAutomatico: TDaruma_FI_CfgRedZAutomatico;
      Daruma_FI_CfgImpEstGavVendas: TDaruma_FI_CfgImpEstGavVendas;
      Daruma_FI_CfgLeituraXAuto: TDaruma_FI_CfgLeituraXAuto;
      Daruma_FI_CfgCalcArredondamento: TDaruma_FI_CfgCalcArredondamento;
      Daruma_FI_CfgHorarioVerao: TDaruma_FI_CfgHorarioVerao;
      Daruma_FI_CfgSensorAut: TDaruma_FI_CfgSensorAut;
      Daruma_FI_CfgCupomAdicional: TDaruma_FI_CfgCupomAdicional;
      Daruma_FI_CfgPermMensPromCNF: TDaruma_FI_CfgPermMensPromCNF;
      Daruma_FI_CfgEspacamentoCupons: TDaruma_FI_CfgEspacamentoCupons;
      Daruma_FI_CfgHoraMinReducaoZ: TDaruma_FI_CfgHoraMinReducaoZ;
      Daruma_FI_CfgLimiarNearEnd: TDaruma_FI_CfgLimiarNearEnd;
      Daruma_Registry_AlteraRegistry: TDaruma_Registry_AlteraRegistry;
      Daruma_Registry_Porta: TDaruma_Registry_Porta;
      Daruma_Registry_MFD_LeituraMFCompleta: TDaruma_Registry_MFD_LeituraMFCompleta;
      Daruma_FIMFD_DownloadDaMFD: TDaruma_FIMFD_DownloadDaMFD;
      Daruma_Registry_Path: TDaruma_Registry_Path;
      Daruma_Registry_Status: TDaruma_Registry_Status;
      Daruma_Registry_StatusFuncao: TDaruma_Registry_StatusFuncao;
      Daruma_Registry_Retorno: TDaruma_Registry_Retorno;
      Daruma_Registry_ControlePorta: TDaruma_Registry_ControlePorta;
      Daruma_Registry_ModoGaveta: TDaruma_Registry_ModoGaveta;
      Daruma_Registry_Log: TDaruma_Registry_Log;
      Daruma_Registry_NomeLog: TDaruma_Registry_NomeLog;
      Daruma_Registry_Separador: TDaruma_Registry_Separador;
      Daruma_Registry_SeparaMsgPromo: TDaruma_Registry_SeparaMsgPromo;
      Daruma_Registry_ZAutomatica: TDaruma_Registry_ZAutomatica;
      Daruma_Registry_XAutomatica: TDaruma_Registry_XAutomatica;
      Daruma_Registry_VendeItemUmaLinha: TDaruma_Registry_VendeItemUmaLinha;
      Daruma_Registry_Default: TDaruma_Registry_Default;
      Daruma_Registry_RetornaValor: TDaruma_Registry_RetornaValor;
      Daruma_Registry_TerminalServer: TDaruma_Registry_TerminalServer;
      Daruma_Registry_ErroExtendidoOk: TDaruma_Registry_ErroExtendidoOk;
      Daruma_Registry_AbrirDiaFiscal: TDaruma_Registry_AbrirDiaFiscal;
      Daruma_Registry_VendaAutomatica: TDaruma_Registry_VendaAutomatica;
      Daruma_Registry_AplMensagem1:TDaruma_Registry_AplMensagem1;
      Daruma_Registry_AplMensagem2:TDaruma_Registry_AplMensagem2;
      Daruma_Registry_IgnorarPoucoPapel: TDaruma_Registry_IgnorarPoucoPapel;
      Daruma_Registry_ImprimeRegistry: TDaruma_Registry_ImprimeRegistry;
      Daruma_FI_StatusCupomFiscal: TDaruma_FI_StatusCupomFiscal;
      Daruma_FI_StatusRelatorioGerencial: TDaruma_FI_StatusRelatorioGerencial;
      Daruma_FI_StatusComprovanteNaoFiscalVinculado: TDaruma_FI_StatusComprovanteNaoFiscalVinculado;
      Daruma_FI_VerificaImpressoraLigada: TDaruma_FI_VerificaImpressoraLigada;
      Daruma_FI_VerificaTotalizadoresParciais: TDaruma_FI_VerificaTotalizadoresParciais;
      Daruma_FI_VerificaModoOperacao: TDaruma_FI_VerificaModoOperacao;
      Daruma_FI_VerificaTotalizadoresNaoFiscais: TDaruma_FI_VerificaTotalizadoresNaoFiscais;
      Daruma_FI_VerificaTotalizadoresNaoFiscaisEx: TDaruma_FI_VerificaTotalizadoresNaoFiscaisEx;
      Daruma_FI_VerificaTruncamento: TDaruma_FI_VerificaTruncamento;
      Daruma_FI_VerificaAliquotasIss: TDaruma_FI_VerificaAliquotasIss;
      Daruma_FI_VerificaIndiceAliquotasIss: TDaruma_FI_VerificaIndiceAliquotasIss;
      Daruma_FI_VerificaRecebimentoNaoFiscal: TDaruma_FI_VerificaRecebimentoNaoFiscal;
      Daruma_FI_VerificaTipoImpressora: TDaruma_FI_VerificaTipoImpressora;
      Daruma_FI_VerificaStatusCheque: TDaruma_FI_VerificaStatusCheque;
      Daruma_FI_VerificaModeloECF: TDaruma_FI_VerificaModeloECF;
      Daruma_FI_VerificaDescricaoFormasPagamento: TDaruma_FI_VerificaDescricaoFormasPagamento;
      Daruma_FI_VerificaXPendente: TDaruma_FI_VerificaXPendente;
      Daruma_FI_VerificaZPendente: TDaruma_FI_VerificaZPendente;
      Daruma_FI_VerificaDiaAberto: TDaruma_FI_VerificaDiaAberto;
      Daruma_FI_VerificaHorarioVerao: TDaruma_FI_VerificaHorarioVerao;
      Daruma_FI_VerificaFormasPagamento: TDaruma_FI_VerificaFormasPagamento;
      Daruma_FI_VerificaFormasPagamentoEx: TDaruma_FI_VerificaFormasPagamentoEx;
      Daruma_FI_VerificaEpromConectada: TDaruma_FI_VerificaEpromConectada;
      Daruma_FI_VerificaEstadoImpressora: TDaruma_FI_VerificaEstadoImpressora;
      Daruma_FI_ClicheProprietario: TDaruma_FI_ClicheProprietario;
      Daruma_FI_ClicheProprietarioEx: TDaruma_FI_ClicheProprietarioEx;
      Daruma_FI_NumeroCaixa: TDaruma_FI_NumeroCaixa;
      Daruma_FI_NumeroLoja: TDaruma_FI_NumeroLoja;
      Daruma_FI_NumeroSerie: TDaruma_FI_NumeroSerie;
      Daruma_FI_VersaoFirmware: TDaruma_FI_VersaoFirmware;
      Daruma_FI_CGC_IE: TDaruma_FI_CGC_IE;
      Daruma_FI_LerAliquotasComIndice: TDaruma_FI_LerAliquotasComIndice;
      Daruma_FI_NumeroCupom: TDaruma_FI_NumeroCupom;
      Daruma_FI_COO: TDaruma_FI_COO;
      Daruma_FI_MinutosImprimindo: TDaruma_FI_MinutosImprimindo;
      Daruma_FI_MinutosLigada: TDaruma_FI_MinutosLigada;
      Daruma_FI_NumeroSubstituicoesProprietario: TDaruma_FI_NumeroSubstituicoesProprietario;
      Daruma_FI_NumeroIntervencoes: TDaruma_FI_NumeroIntervencoes;
      Daruma_FI_NumeroReducoes: TDaruma_FI_NumeroReducoes;
      Daruma_FI_NumeroCuponsCancelados: TDaruma_FI_NumeroCuponsCancelados;
      Daruma_FI_NumeroOperacoesNaoFiscais: TDaruma_FI_NumeroOperacoesNaoFiscais;
      Daruma_FI_DataHoraImpressora: TDaruma_FI_DataHoraImpressora;
      Daruma_FI_DataHoraReducao: TDaruma_FI_DataHoraReducao;
      Daruma_FI_DataMovimento: TDaruma_FI_DataMovimento;
      Daruma_FI_ContadoresTotalizadoresNaoFiscais: TDaruma_FI_ContadoresTotalizadoresNaoFiscais;
      Daruma_FI_GrandeTotal: TDaruma_FI_GrandeTotal;
      Daruma_FI_Descontos: TDaruma_FI_Descontos;
      Daruma_FI_Acrescimos: TDaruma_FI_Acrescimos;
      Daruma_FI_Cancelamentos: TDaruma_FI_Cancelamentos;
      Daruma_FI_DadosUltimaReducao: TDaruma_FI_DadosUltimaReducao;
      Daruma_FI_SubTotal: TDaruma_FI_SubTotal;
      Daruma_FI_RetornoAliquotas: TDaruma_FI_RetornoAliquotas;
      Daruma_FI_ValorPagoUltimoCupom: TDaruma_FI_ValorPagoUltimoCupom;
      Daruma_FI_ValorFormaPagamento: TDaruma_FI_ValorFormaPagamento;
      Daruma_FI_ValorTotalizadorNaoFiscal: TDaruma_FI_ValorTotalizadorNaoFiscal;
      Daruma_FI_UltimoItemVendido: TDaruma_FI_UltimoItemVendido;
      Daruma_FI_UltimaFormaPagamento: TDaruma_FI_UltimaFormaPagamento;
      Daruma_FI_TipoUltimoDocumento: TDaruma_FI_TipoUltimoDocumento;
      Daruma_FI_MapaResumo: TDaruma_FI_MapaResumo;
      Daruma_FI_RelatorioTipo60Analitico: TDaruma_FI_RelatorioTipo60Analitico;
      Daruma_FI_RelatorioTipo60Mestre: TDaruma_FI_RelatorioTipo60Mestre;
      Daruma_FI_FlagsFiscais: TDaruma_FI_FlagsFiscais;
      Daruma_FI_PalavraStatus: TDaruma_FI_PalavraStatus;
      Daruma_FI_PalavraStatusBinario: TDaruma_FI_PalavraStatusBinario;
      Daruma_FI_SimboloMoeda: TDaruma_FI_SimboloMoeda;
      Daruma_FI_RetornoImpressora: TDaruma_FI_RetornoImpressora;
      Daruma_FI_RetornaErroExtendido: TDaruma_FI_RetornaErroExtendido;
      Daruma_FI_RetornaAcrescimoNF: TDaruma_FI_RetornaAcrescimoNF;
      Daruma_FI_RetornaCFCancelados: TDaruma_FI_RetornaCFCancelados;
      Daruma_FI_RetornaCNFCancelados: TDaruma_FI_RetornaCNFCancelados;
      Daruma_FI_RetornaCLX: TDaruma_FI_RetornaCLX;
      Daruma_FI_RetornaCNFNV: TDaruma_FI_RetornaCNFNV;
      Daruma_FI_RetornaCNFV: TDaruma_FI_RetornaCNFV;
      Daruma_FI_RetornaCRO: TDaruma_FI_RetornaCRO;
      Daruma_FI_RetornaCRZ: TDaruma_FI_RetornaCRZ;
      Daruma_FI_RetornaCRZRestante: TDaruma_FI_RetornaCRZRestante;
      Daruma_FI_RetornaCancelamentoNF: TDaruma_FI_RetornaCancelamentoNF;
      Daruma_FI_RetornaDescontoNF: TDaruma_FI_RetornaDescontoNF;
      Daruma_FI_RetornaGNF: TDaruma_FI_RetornaGNF;
      Daruma_FI_RetornaTempoImprimindo: TDaruma_FI_RetornaTempoImprimindo;
      Daruma_FI_RetornaTempoLigado: TDaruma_FI_RetornaTempoLigado;
      Daruma_FI_RetornaTotalPagamentos: TDaruma_FI_RetornaTotalPagamentos;
      Daruma_FI_RetornaTroco: TDaruma_FI_RetornaTroco;
      Daruma_FI_RetornaZeros: TDaruma_FI_RetornaZeros;
      Daruma_FI_RetornaValorComprovanteNaoFiscal: TDaruma_FI_RetornaValorComprovanteNaoFiscal;
      Daruma_FI_RetornaIndiceComprovanteNaoFiscal: TDaruma_FI_RetornaIndiceComprovanteNaoFiscal;
      Daruma_FI_RetornaRegistradoresNaoFiscais: TDaruma_FI_RetornaRegistradoresNaoFiscais;
      Daruma_FI_RetornaRegistradoresFiscais: TDaruma_FI_RetornaRegistradoresFiscais;
      Daruma_TEF_EsperarArquivo: TDaruma_TEF_EsperarArquivo;
      Daruma_TEF_ImprimirResposta: TDaruma_TEF_ImprimirResposta;
      Daruma_TEF_ImprimirRespostaCartao: TDaruma_TEF_ImprimirRespostaCartao;
      Daruma_TEF_FechaRelatorio: TDaruma_TEF_FechaRelatorio;
      Daruma_TEF_SetFocus: TDaruma_TEF_SetFocus;
      Daruma_TEF_TravarTeclado: TDaruma_TEF_TravarTeclado;
      Daruma_Registry_FS2000_CupomAdicional: TDaruma_Registry_FS2000_CupomAdicional;
      Daruma_Registry_FS2000_TempoEsperaCheque: TDaruma_Registry_FS2000_TempoEsperaCheque;
      Daruma_FI2000_DescontoSobreItemVendido: TDaruma_FI2000_DescontoSobreItemVendido;
      Daruma_FI2000_AcrescimosICMSISS: TDaruma_FI2000_AcrescimosICMSISS;
      Daruma_FI2000_CancelamentosICMSISS: TDaruma_FI2000_CancelamentosICMSISS;
      Daruma_FI2000_DescontosICMSISS: TDaruma_FI2000_DescontosICMSISS;
      Daruma_FI2000_LeituraInformacaoUltimosCNF: TDaruma_FI2000_LeituraInformacaoUltimosCNF;
      Daruma_FI2000_LeituraInformacaoUltimoDoc: TDaruma_FI2000_LeituraInformacaoUltimoDoc;
      Daruma_FI2000_VerificaRelatorioGerencial: TDaruma_FI2000_VerificaRelatorioGerencial;
      Daruma_FI2000_CriaRelatorioGerencial: TDaruma_FI2000_CriaRelatorioGerencial;
      Daruma_FI2000_AbreRelatorioGerencial: TDaruma_FI2000_AbreRelatorioGerencial;
      Daruma_FI2000_CancelamentoCNFV: TDaruma_FI2000_CancelamentoCNFV;
      Daruma_FI2000_SegundaViaCNFVinculado: TDaruma_FI2000_SegundaViaCNFVinculado;
      Daruma_FI2000_StatusCheque: TDaruma_FI2000_StatusCheque;
      Daruma_FI2000_ImprimirCheque: TDaruma_FI2000_ImprimirCheque;
      Daruma_FI2000_ImprimirVersoCheque: TDaruma_FI2000_ImprimirVersoCheque;
      Daruma_FI2000_LiberarCheque: TDaruma_FI2000_LiberarCheque;
      Daruma_FI2000_LeituraCodigoMICR: TDaruma_FI2000_LeituraCodigoMICR;
      Daruma_FI2000_CancelarCheque: TDaruma_FI2000_CancelarCheque;
      Daruma_FI2000_LeituraTabelaCheque: TDaruma_FI2000_LeituraTabelaCheque;
      Daruma_FI2000_CarregarCheque: TDaruma_FI2000_CarregarCheque;
      Daruma_FI2000_CorrigirGeometriaCheque: TDaruma_FI2000_CorrigirGeometriaCheque;

      ///////////////////////////////////////////////////////////////Metodos para o Sintegra//////////////////////////////////////////////////////////////////
      //Metodo de Alto Nivel
      Daruma_Sintegra_GerarRegistrosArq : TDaruma_Sintegra_GerarRegistrosArq;
      //Metodo de Médio Nível
      Daruma_Sintegra_GerarRegistro10 : TDaruma_Sintegra_GerarRegistro10;
      Daruma_Sintegra_GerarRegistro11 : TDaruma_Sintegra_GerarRegistro11;
      Daruma_Sintegra_GerarRegistro60M : TDaruma_Sintegra_GerarRegistro60M;
      Daruma_Sintegra_GerarRegistro60A : TDaruma_Sintegra_GerarRegistro60A;
      Daruma_Sintegra_GerarRegistro60D : TDaruma_Sintegra_GerarRegistro60D;
      Daruma_Sintegra_GerarRegistro60I : TDaruma_Sintegra_GerarRegistro60I;
      Daruma_Sintegra_GerarRegistro60R : TDaruma_Sintegra_GerarRegistro60R;
      Daruma_Sintegra_GerarRegistro90 : TDaruma_Sintegra_GerarRegistro90;
      Daruma_Registry_SintegraSeparador : TDaruma_Registry_SintegraSeparador;
      Daruma_Registry_SintegraPath : TDaruma_Registry_SintegraPath;
      //PAF-ECF
      Daruma_FIMFD_RetornaInformacao : TDaruma_FIMFD_RetornaInformacao;

      iRetorno:Integer;
      FPronto: Boolean;
      FNumPorta: Integer; {Numero da porta serial a qual a impressora esta conectada}
      FUserEvent: TUserEvent;
      FTotalCupom: TTotalCupom;
      FModelo: TECFModelo;
      FDados: TPrinterDados;
      Ftributacao: TTributacao;
      FRodape: TRodape;
      FStatus: TStatus;
      FEprom: string;
      FResp: string;
      FVlrCupom: string;
      grande_retorno: PChar;
      TabAliq_Zant: string;
      UltItem_Zant: string;
      dtr_desconto, dtr_acrescimo: string;
      contai_Zant: Integer;
      s1: array[1..255] of char;
      vol: string;
      textolivre: string;
      ptRetorno: Pointer;
      FOperacao: Boolean;
      FAfterReducaoZ: TReducaoZEvent;
      FAfterAbrirCupom: TAbrirCupomEvent;
      FBeforeAbrirCupom: TValidaAbrirCupomEvent;
      FAfterSangria: TSangriaEvent;
      FAfterSuprimento: TSuprimentoEvent;
      FAfterAbreCupomVinculado: TAbreCupomVinculado;
      FAfterAbreRelatorioGerencial: TAbreRelatorioGerencial;
      FAfterCancelaCupomAtual : TCancelaCupomAtual;
      FAfterAbreDiaFiscal: TAbreDia;

      function Trends_ret(resp: integer): boolean;
      function CarregaECF: boolean;

      function URN_Ret(retorno: integer): boolean;
      function URN_Ret2(retorno: integer): boolean;
      function URN_Ret3(retorno: integer): boolean;
      function DTR_proc(data: string): boolean;
      function zan_proc(data, param: string): boolean;
      function Bem_proc(data: string): boolean;
      function NCR_proc(data: string): boolean;
      function VeriDelphi: boolean;
      function LeProComp(iRetorno: Integer; lProcessaRet: Boolean): Boolean;
      procedure MensagemProComp(iRetorno: Integer);

      function GetRelatorioTipo60Mestre_Bematech(Var RegTipo60Mestre: TRegTipo60Mestre): Boolean;
    function GetRelatorioTipo60Analitico_Bematech(
             Var VetTipo60Analitico : TVetTipo60Analitico): Boolean;
    procedure InicializaPChar(var P: PChar; const ALength: Integer);
    function _AFRAC_FloatToPontoFlutuante(Valor: Double; CasasDec: Byte): TPontoFlutuante;overload;
    function _AFRAC_FloatToPontoFlutuante(Valor, Ponto : String; CasasDec : Byte): TPontoFlutuante;overload;
    function _AFRAC_BooleanToAcrescDesc(Desconto: Boolean): TAcreDesc;
    function MyStrCurToFloat(Curr, Ponto: string): Double;
    function _AFRAC_BooleanToTBooleano(Expressao: Boolean): TBooleano;
    function _AFRAC_BooleanToTPercValor(Expressao: Boolean): TPercValor;
    procedure _AFRAC_InicializaArray(var A: array of char);
    procedure _AFRAC_CopyStrToArray(var Dest: array of char;
      Source: String);
    function _AFRAC_IntToTInteiro(Valor: Integer): TInteiro;
    function _Bematech_Matr_DadosReducaoZ(var Dados: TRegDadosReducaoZ): Boolean;
    function _Daruma_Matr_DadosReducaoZ(var Dados: TRegDadosReducaoZ): Boolean;
    function _Daruma_Term_DadosReducaoZ(var Dados: TRegDadosReducaoZ): Boolean;

    function _Bematech_Term_DadosReducaoZ(var Dados: TRegDadosReducaoZ): Boolean;
    function _Elgin_DadosReducaoZ(var Dados: TRegDadosReducaoZ): Boolean;
    function _Elgin_DadosSintegra(var Dados: TRegDadosReducaoZ): Boolean;
    function _Sweda_DadosReducaoZ(var Dados: TRegDadosReducaoZ): Boolean;

   protected
      property Dados: TPrinterDados read FDados;
      property Tributacao: TTributacao read FTributacao;
      property Rodape: TRodape read FRodape;
      property Status: TStatus read FStatus;
   public
      constructor Create(AOwner: TComponent); override;
      { ================ Funcoes ====================== }
      function ObtemRetornoECF(var strMensagemErro: String): Boolean;
      procedure Analisa_iRetorno;
      function Retorno_Impressora(ErroCupomAberto: Boolean = True): Boolean;
      function NumSeqCupFisc: Word;
      function IniFechCupfisc(sFechar:String):Boolean;
      function IniFechCupfiscMFD(sFechar:String):Boolean;
      function IniciaFechamentoRecebimentoNaoFiscalMFD(sFechar:String):Boolean;
      function FechaRecebimentoNaoFiscalMFD(Mensagem : string): boolean;
      function TermFechCupFisc(Msg: String):Boolean;
      function EfetFormPagI(IndexFP:string; Valor:Currency):Boolean;
      function EfetFormPagII(IndexFP:string; Valor:Currency; DescFormPgto:String):Boolean;
      function ProgramaAliquota( Aliquota: String; ICMS_ISS: Integer ): boolean;
      function CupomAdicionalMFD: boolean;
      function AlteraSimboloMoeda( SimboloMoeda: String ): boolean;
      function ProgVerFormPagII(FormaPagto, OperacaoTef:String):boolean;
      function RetornoAliquotas( var Aliquotas: String ): boolean;
      function EstornoFormasPagamento( FormaOrigem: String; FormaDestino: String; Valor: String ): boolean;
      function CancelaAcrescimoDescontoSubtotalMFD( cFlag: string): boolean;
      function CancelaAcrescimoDescontoSubtotalRecebimentoMFD( cFlag: string): boolean;
      function CancelaAcrescimoDescontoItemMFD( cFlag, cItem: string ): boolean;

      function ReimpressaoNaoFiscalVinculadoMFD : boolean;
      function SegundaViaNaoFiscalVinculadoMFD  : boolean;

      function Crypto(const Str1: string): string;
      function inttobin(data: Integer): string;
      function bintoint(data: string): Integer;
      function IntToHex(numero: integer): string;
      function HextoInt(HexStr: string): integer;
      procedure TimeDelay(msecs: integer);
      function BiosInfo: string;
      function CPUMHz: string;
      function Modelos: string;
      //procedure ProgModalidades;
      procedure ProgModalidades( FormaPagamento: String; ValorFormaPagamento: String; Indice: String );
      function sepdados(dados: string; item_a_retornar: Integer): string;
      function Extenso(pValor: Real): string;
      function fExtenso(nValor: Real): string;
      function ExtensoMil(cVlr: string): string;
      function LenNum(Numero: Real): Integer;
      function zcomp(data: string; Tam: integer): string;
      function ParseParam(Parametros, Parametro: String): String;
      function MyStrToInt(strValue : String) : Integer;
      function IncChar(S: string; const Len: Integer; Car, LR : Char):String;
      function IncCharEx(S: string; const Len: Integer; Car, LR: Char): String;
      function returnNumber(text:string):String;
      function scomp(data: string; Tam: integer): string;
      function sdcomp(data: string; Tam: integer): string;
      function tiravg(data: string): string;
      function NCRCHQLAY(banco: integer): string;
      function ZNTCHQLAY(banco: integer): string;
      function urn_esp(Liga: string): boolean;
      function urn_naofisc(codigo, desc, valor, nome, codcli, cpf: string): boolean;
      function swd_naofisc(codigo, desc, valor, nome, codcli, cpf: string): boolean;
      function urn_log(Liga: string): boolean;
      function bem_refsan(sanref, valor: string): boolean;
      function ptov(data: string): string;
      procedure TablePack(Table: TTable);
      function VerificaEAN(CodEan: string): boolean;
      function iif(cond: boolean; se_verdadeiro: string; se_falso: string): string;
      function tiramsc(data: string): string;
      function space(Val: Integer): string;
      function nmmes(dados: string): string;
      function CheckCPF(cpf: string): boolean;
      function CheckCGC(cgc: string): boolean;
      { =============================================== }
      function LeituraMemoriaFiscalData(datainicial, datafinal: string): boolean;
      function LeituraMemoriaFiscalDataMFD(datainicial, datafinal, FlagLeitura : string): boolean;
      function LeituraMemoriaFiscalSerialDataMFD(ReducaoInicial, ReducaoFinal, FlagLeitura : string): boolean;
      function LeituraMemoriaFiscalReducao(reducaoinicial, reducaofinal: string): boolean;
      function LeituraMemoriaFiscalReducaoMFD(ReducaoInicial, ReducaoFinal, FlagLeitura : string): boolean;
      function LeituraMemoriaFiscalSerialReducaoMFD(ReducaoInicial, ReducaoFinal, FlagLeitura : string): boolean;
      function swd_proc(data: string): boolean;
      function RetornoSchD(retorno: integer): Boolean;
      function retsch2(retorno: integer): Boolean;
      function AbreComunicacao: Boolean;
      function FechaComunicacao: Boolean;
      function AtualizaStatus: Boolean;
      function AtualizaDados: Boolean;
      function AtualizaDadosncr(comando: string): Boolean;
      function AtualizaValorCupom: boolean;
      function AtualizaEprom: Boolean;
      function AtualizaTributacao: Boolean;
      function EmiteLeituraX(AbreVinculado: string): Boolean;
      function EmiteLeituraXSerial(AbreVinculado: string): Boolean;
      function ReducaoZ( Data: TDateTime; Hora: String ): Boolean;
      function AbreGaveta: Boolean;
      function AbreDiaFiscal(Data: TDateTime; Valor: Currency; Operador: string): Boolean;
      function FechaDiaFiscal(Operador: string): Boolean;
      function CancelaUltimoCupom(Valor: string): Boolean;
      function AbreCupomVinculado(Cupom, FormaPgto, Finalizadora, IndVinculado, Valor: String): boolean;
      function TextoCupomVinculado(Dados: string): boolean;
      function TextoVinculadoX(Dados: string): boolean;
      function AbreCupomFiscal(CGC:String): boolean;
      function VendeItem(Item: string): boolean;
      function VendeItem3dig(Item: string): boolean;
      function VendeItemDepartamento( Codigo: String; Descricao: String; Aliquota: String; ValorUnitario: String; Quantidade: String; Acrescimo: String; Desconto: String; IndiceDepartamento: String; UnidadeMedida: String): Boolean;
      function FechaCupomVinculado(sValues:String): boolean;
      function FechaCupomVinculadoSemErro(sValues:String): Boolean;
      function TotalizaCupomMFD: boolean;
      function FechaCupom( FormaPagamento: String; AcrescimoDesconto: String; TipoAcrescimoDesconto: String; ValorAcrescimoDesconto: String; ValorPago: String; Mensagem: String): boolean;
      function FechaCupomFiscal(ParamCupom: string): boolean;
      function SubtotalizaCupom(valor: string): boolean;
      function SubtotalizaCupomMFD: boolean;
      function PagamentoCupom(Dados: string): boolean;
      function CancelaUltimoItem(descricao, Valor: string): boolean;
      function AtivaVerao: boolean;
      function DestivaVerao: boolean;
      function cancelaItem(Item, posicao: string): boolean;
      function ImprimeChequeI(param, valor, Favorecido, Cidade, data, banco, ArqLayout, espacamento: string): boolean;
      function DescontoEmSubtotal(Valor: string): boolean;
      function AcrescimoEmSubtotal(Valor: string): boolean;
      function Autentica(Dados: string): boolean;
      function EspacoEntreLinhas( Dots: Integer ): boolean;
      function FechaCupomResumido( FormaPagamento: String; Mensagem: String ): boolean;
      function AutenticacaoMFD(Linhas, Texto : string) : boolean;
      function CancelaCupomAtual: boolean;
      function CancelaCupomAtualSemErro(TemVinculado : Boolean): Boolean;
      function Versao: string;
      function RelatorioGerencial( Texto: String ): boolean;
      function AbreRelatorioGerencial(Indice: String ): boolean;
      function AbreRelatorioGerencialMFD( Indice: String ): boolean;
      function CancelaItemGenerico( NumeroItem: String ): boolean;
      function UsaComprovanteNaoFiscalVinculado( Texto: String ): boolean;
      function UsaRelatorioGerencialMFD( Texto: String ): boolean;
      function FechaRelatorioGerencial: boolean;
      function AbreCupomMFD(CGC: string; Nome: string; Endereco : string): boolean;
      function CancelaCupomMFD(CGC, Nome, Endereco: string): boolean;
      function AbreRecebimentoNaoFiscalMFD(CGC, Nome, Endereco : string): boolean;
      function CancelaRecebimentoNaoFiscalMFD(CGC, Nome, Endereco : string): boolean;
      function EstornoNaoFiscalVinculadoMFD(CGC, Nome, Endereco : string): boolean;
      function AbreComprovanteNaoFiscalVinculado( FormaPagamento: String; Valor: String; NumeroCupom: String ): boolean;
      function AbreComprovanteNaoFiscalVinculadoMFD( FormaPagamento, Valor, NumeroCupom, CGC, nome, Endereco : string): boolean;
      function Sangria(Valor: Currency): boolean;
      function Suprimento(Valor: Currency; FormaPagamento: String ): boolean;
      function RecebimentoNaoFiscal( IndiceTotalizador: String; Valor: String; FormaPagamento: String ): boolean;
      function EfetuaRecebimentoNaoFiscalMFD(IndiceTotalizador, ValorRecebimento : string): boolean;
      function AcrescimoDescontoItemMFD(Item, AcrescimoDesconto,TipoAcrescimoDesconto, ValorAcrescimoDesconto: string): boolean;
      function AcrescimoDescontoSubtotalMFD( cFlag, cTipo, cValor: string): boolean;
      function AcrescimoDescontoSubtotalRecebimentoMFD( cFlag, cTipo, cValor: string ): boolean;
      function SubTotalizaRecebimentoMFD: boolean;
      function TotalizaRecebimentoMFD: boolean;
      function CancelaItemAnterior: boolean;
      function UsaUnidadeMedida( UnidadeMedida: String ): boolean;
      function AumentaDescricaoItem( Descricao: String ): boolean;
      function EfetuaFormaPagamento( FormaPagamento: String; ValorFormaPagamento: Double; Indice : String): boolean;
      function EfetuaFormaPagamentoMFD(FormaPagamento, ValorFormaPagamento, Parcelas, DescricaoFormaPagto: string): boolean;
      function ProgramaArredondamento: boolean;
      function ProgramaTruncamento: boolean;
      function NomeiaDepartamento( Indice: Integer; Departamento: String ): boolean;
      function NomeiaTotalizadorNaoSujeitoIcms( Indice: Integer; Totalizador: String ): boolean;
      function NomeiaRelatorioGerencialMFD(Indice, Descricao : string): boolean;
      function LinhasEntreCupons( Linhas: Integer ): boolean;
      function ProgramaCaracterAutenticacao( Parametros: String ): boolean;
      function ForcaImpactoAgulhas( ForcaImpacto: Integer ): boolean;
      function ResetaImpressora: boolean;
      function ImprimeCopiaCheque: boolean;
      function IncluiCidadeFavorecido( Cidade: String; Favorecido: String ): boolean;
      function VerificaStatusCheque( var StatusCheque: Integer ): boolean;
      function ValorFormaPagamento( FormaPagamento: String; Valor: String ): boolean;
      function ValorTotalizadorNaoFiscal( Totalizador: String; Valor: String ): boolean;
      function ProgramaMoedaSingular( MoedaSingular: String ): boolean;
      function ProgramaMoedaPlural( MoedaPlural: String ): boolean;
      function CancelaImpressaoCheque: boolean;
      function LeituraChequeMFD(CodigoCMC7 : string): boolean;
      function ImprimeCheque( Banco: String; Valor: String; Favorecido: String; Cidade: String; Data: String; Mensagem: String ): boolean;
      function ImprimeChequeMFD(NumeroBanco, Valor, Favorecido, Cidade, Data, Mensagem, ImpressaoVerso, Linhas : string): boolean;
      function VerificaModoOperacao( Modo: string ): boolean;
      function VerificaImpressoraLigada: boolean;
      function VerificaImpressoraLigadaTEF: boolean;
      function InfoBalanca(port: string; model: integer; peso : string; precoKilo : string;total : string): integer;
      function VerificaEstadoGaveta( var EstadoGaveta: Integer ): boolean;
      function VerificaEstadoImpressora( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): boolean;
      function VerificaEstadoImpressoraMFD( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer; Var ST3: Integer ): boolean;
      function VerificaTotalizadoresParciais( Totalizadores: String ): boolean;
      function SubTotal( SubTotal: String ): boolean;
      function ComprovantesNaoFiscaisNaoEmitidosMFD(var Comprovantes: String ): boolean;
      function CNPJMFD(CNPJ : string): boolean;
      function ContadorComprovantesCreditoMFD(var Comprovantes : string): boolean;
      function ContadorCupomFiscalMFD(var CuponsEmitidos : string): boolean;
      function ContadorFitaDetalheMFD(ContadorFita : string): boolean;
      function ContadorRelatoriosGerenciaisMFD (Relatorios : String): boolean;
      function ContadoresTotalizadoresNaoFiscaisMFD(Contadores : string): boolean;
      function DadosUltimaReducaoMFD(var DadosReducao : string): boolean;
      function DadosUltimaReducao(DadosReducao: String): Boolean;
      function DadosReducaoZ(var Dados: TRegDadosReducaoZ): Boolean;
      function DadosSintegra(var Dados: TRegDadosReducaoZ): Boolean;
      function DataHoraUltimoDocumentoMFD( cDataHora: string ): boolean;
      function InscricaoEstadualMFD(InscricaoEstadual : string): boolean;
      function InscricaoMunicipalMFD(InscricaoMunicipal : string): boolean;
      function MarcaModeloTipoImpressoraMFD(var Marca: String; var Modelo: String; var Tipo : String): boolean;
      function DataHoraGravacaoUsuarioSWBasicoMFAdicional(var dataUsuario : String; var dataSWBasico : String; var MFAdicional : Char): Boolean;
      function MinutosEmitindoDocumentosFiscaisMFD(Minutos : string): boolean;
      function NumeroSerieMFD(var sNumeroSerie : string): boolean;
      function NumeroSerieMemoriaMFD(sNumeroSerie : string): boolean;
      function PercentualLivreMFD( cMemoriaLivre: string ): boolean;
      function ReducoesRestantesMFD(Reducoes : string): boolean;
      function TotalLivreMFD( cMemoriaLivre: string ): boolean;
      function TamanhoTotalMFD( cTamanhoMFD: string ): boolean;
      function TempoOperacionalMFD(TempoOperacional : string): boolean;
      function VerificaFormasPagamentoMFD(FormasPagamento : string): boolean;
      function VerificaRecebimentoNaoFiscal(Recebimentos : string): boolean;
      function VerificaRecebimentoNaoFiscalMFD(Recebimentos : string): boolean;
      function VerificaRelatorioGerencialMFD(Relatorios : string): boolean;
      function VerificaTotalizadoresNaoFiscaisMFD(Totalizadores : string): boolean;
      function VerificaTotalizadoresParciaisMFD(Totalizadores : string): boolean;
      function VersaoFirmware(VersaoFirmware : string): boolean;
      function VersaoFirmwareMFD(var VersaoFirmware : string): boolean;
      function NumeroCupom( var NumeroCupom: String ): boolean;
      function VerificaDepartamentos( Departamentos: String ): boolean;
      function VerificaFormasPagamento( var Formas: String ): boolean;
      function VerificaTruncamento( Flag: string ): boolean;
      function FlagsFiscais( Var Flag: Integer ): boolean;
      function GrandeTotal( var GrandeTotal: String ): boolean;
      function Cancelamentos( ValorCancelamentos: String ): boolean;
      function Acrescimos( ValorAcrescimos: String ): boolean;
      function NumeroCuponsCancelados( var NumeroCancelamentos: String ):boolean;
      function MinutosImprimindo( Minutos: String ): boolean;
      function MinutosLigada( Minutos: String ): boolean;
      function NumeroLoja( var NumeroLoja: String ): boolean;
      function NumeroCaixa( var NumeroCaixa: String ): boolean;
      function UltimoItemVendido( NumeroItem: String ): boolean;
      function NumeroSubstituicoesProprietario(var NumeroSubstituicoes: String ): boolean;
      function NumeroSerie( var NumeroSerie: String ): boolean;
      function ProgramaIdAplicativo( cAplicativo,  cAplicativo2 : String) : boolean;
      function SimboloMoeda( SimboloMoeda: String ): boolean;
      function CGC_IE( CGC: String; IE: String ): boolean;
      function ClicheProprietario( Cliche: String ): boolean;
      function NumeroOperacoesNaoFiscais(var NumeroOperacoes: String): boolean;
      function NumeroIntervencoes( NumeroIntervencoes: String ): boolean;
      function NumeroReducoes( NumeroReducoes: String ) : boolean;
      function VerificaEpromConectada( Flag: String ): boolean;
      function DataHoraImpressora( Data: String; Hora: String ): boolean;
      function ContadoresTotalizadoresNaoFiscais( Contadores: String ): boolean;
      function VerificaTotalizadoresNaoFiscais( Totalizadores: String ): boolean;
      function DataHoraReducao( var Data: String; var Hora: String ): boolean;
      function DataMovimento( Data: String ): boolean;
      function VerificaAliquotasIss( Flag: String ): boolean;
      function VerificaTipoImpressora( Var TipoImpressora: Integer ): boolean;
      function VerificaIndiceAliquotasIss( var Flag: String ): boolean;
      function RelatorioTipo60Mestre(Var RegTipo60Mestre: TRegTipo60Mestre): Boolean;
      function RelatorioTipo60Analitico(Var VetTipo60Analitico : TVetTipo60Analitico): Boolean;
      function IsReducaoAutomatica: Boolean;
      function TemCupom: Boolean;
      function DataImpressora: TDateTime;
      //Sintegra

      function SintegraGerarRegistros(DataInicio, DataFim, Municipio, Fax, CodIdConvenio, CodIdNatureza, CodIdFinalidade, Logradouro, Numero, Complemento, Bairro, CEP, NomeContato,
                                      Telefone, Arquivo, Mes, Ano, RazaoSocial, Cidade: String; iRelatorios : Integer): Boolean;
      function SintegraGerarRegistro10( DataInicio: String; DataFim: String; Municipio: String; Fax: String; CodIdConvenio: String; CodIdNatureza: String; CodIdFinalidade: String; var Retorno: String): Boolean;
      function SintegraGerarRegistro11( Logradouro: String; Numero: String; Complemento: String; Bairro: String; CEP: String; NomeContato: String; Telefone: String; var Retorno: String): Boolean;
      function SintegraGerarRegistro60M( DataInicio: String; DataFim: String; var Retorno: String): Boolean;
      function SintegraGerarRegistro60A( DataInicio: String; DataFim: String; var Retorno: String): Boolean;
      function SintegraGerarRegistro60D( DataInicio: String; DataFim: String; var Retorno: String): Boolean;
      function SintegraGerarRegistro60I( DataInicio: String; DataFim: String; var Retorno: String): Boolean;
      function SintegraGerarRegistro60R( DataInicio: String; DataFim: String; var Retorno: String): Boolean;
      function SintegraGerarRegistro90( var Retorno: String): Boolean;
      function SintegraRegistrySeparador( Separador: String): Boolean;
      function SintegraRegistryPath( Path: String): Boolean;
      //PAF-ECF
      function RetornaInformacao(Indice : String; Tamanho : Integer; var Resultado : String): Boolean;
      function RetornaTotalizadorParcial(var AResultado : String): Boolean;
      function COO(var Inicial: String; var Final: String ): Boolean;
      function RetornaCancelamentoNF(CancelamentoNF: String): Boolean;
      function FormatarDataImpressora(Data: String): TDateTime;
      function FormatarDataHoraImpressora(DataHora: String): TDateTime;

      function MFD_LeituraMemoriaFiscal(Index: String): Boolean;
      function FIMFD_DownloadDaMFD(Str_Inicial, Str_Final, Str_Tipo : String): Boolean;
      function InicioFimGTsMFD(var cGTInicial: String; var cGTFinal: String ) : Boolean;

      { =================================================================================================================================== }
      {ACRESCENTADO PARA SCHALTER}
      function SchalterErros(NroRet:Integer;StrRet,TipoRet:string): Boolean;

   published
      property Pronto: boolean read FPronto write FPronto default True;
      property PortaSerial: Integer read FNumPorta write FNumporta;
      property OnError: TUserEvent read FUserEvent write FUserEvent;
      property OnTotalCupom: TTotalCupom read FTotalCupom write FTotalCupom;
      property Impressora: TECFModelo read FModelo write FModelo default None;
      property Eprom: string read FEprom write FEprom;
      property UltimaResp: string read Fresp write Fresp;
      property ValorCupom: string read FVlrCupom write FVlrCupom;
      property Operacao: boolean read FOperacao write FOperacao;
      Property AfterReducaoZ : TReducaoZEvent read FAfterReducaoZ write FAfterReducaoZ;
      Property AfterAbrirCupom : TAbrirCupomEvent read FAfterAbrirCupom write FAfterAbrirCupom;
      property BeforeAbrirCupom: TValidaAbrirCupomEvent read FBeforeAbrirCupom write FBeforeAbrirCupom;
      Property AfterSuprimento : TSuprimentoEvent read FAfterSuprimento write FAfterSuprimento;
      property AfterAbreDiaFiscal: TAbreDia read FAfterAbreDiaFiscal write FAfterAbreDiaFiscal;
      Property AfterSangria : TSangriaEvent read FAfterSangria write FAfterSangria;
      Property AfterAbreCupomVinculado : TAbreCupomVinculado read FAfterAbreCupomVinculado write FAfterAbreCupomVinculado;
      Property AfterAbreRelatorioGerencial : TAbreRelatorioGerencial read FAfterAbreRelatorioGerencial write FAfterAbreRelatorioGerencial;
      Property AfterCancelaCupomAtual : TCancelaCupomAtual read FAfterCancelaCupomAtual write FAfterCancelaCupomAtual;

   end;
   TEFiscal = class(TDefFPrinter)
      property Dados; // Abre uma subopcao para campos lidos e processados da impressora
      property Tributacao; // Abre uma subopcao para a tabela de tributacao
      property Rodape; // Linhas do Rodape dos cupons
      property Status; // Status da impressora
      property Pronto; // true se o ultimo comando jah foi executado
      property PortaSerial; // Numero da porta com
      property OnError; // Chama funcao se algum erro acontecer
      property OnTotalCupom; // Total do cupom, executa a cada AtualizaValorCupom e a cada Venda
      property Impressora; // Seleciona impressora apartir de uma tabela
      property Eprom; // Versao da Eprom
      property UltimaResp; // string cotendo a ultima resposta vinda da impressora
      property Operacao; // controla o tipo de oprecao na impressora
      property AfterReducaoZ; // executado depois de emitira a redução Z via comando
   end;

procedure Register;

procedure BlockInput(Block: LongBool);stdcall;external 'USER32.DLL';

implementation

uses uNumericFunctions, StrUtils, BDE, DateUtils;

constructor TDefFPrinter.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   FDados := TPrinterDados.Create(self);
   FTributacao := TTributacao.Create(self);
   FRodape := TRodape.Create(self);
   FStatus := TStatus.Create(Self);
end;
///////////////////////////////////////////////////
constructor TPrinterDados.Create(Owner: TDefFPrinter);
begin
   inherited Create;
   FOwner := Owner;
end;
///////////////////////////////////////////////////
constructor TTributacao.Create(Owner: TDefFPrinter);
begin
   inherited Create;
   FOwner := Owner;
end;
///////////////////////////////////////////////////
constructor TRodape.Create(Owner: TDefFPrinter);
begin
   inherited Create;
   FOwner := Owner;
end;
////////////////////////////////////////////////
constructor TStatus.Create(Owner: TDefFPrinter);
begin
   inherited Create;
   FOwner := Owner;
end;
///////////////////
procedure Register;
begin
   RegisterComponents('NewPower', [TEFiscal]);
end;
//////////////////////////////////////////////////////////////////
function TDefFPrinter.AbreRelatorioGerencial(Indice: String ): boolean;
begin
   Result := False;
   case impressora of
     BematechMP20, BematechMP40, BematechTermica:
       begin
         iRetorno := Bematech_RelatorioGerencial(' ');
         Analisa_iRetorno();
         Result:= (iRetorno=1);
       end;

     Sweda03, Sweda10 :
     begin
         iRetorno := Sweda_RelatorioGerencial(' ');
         Analisa_iRetorno();
         Result:= (iRetorno=1);
     end;

     Elgin:
       begin
         iRetorno := Elgin_AbreRelatorioGerencialMFD(Indice);
         Analisa_iRetorno();
         Result:= (iRetorno=1);
       end;
     AFRAC:
       begin
         iRetorno := AFRAC_AbrirRelatorioGerencial(' ');
         Analisa_iRetorno;
         Result:= (iRetorno=0);
       end;
     DarumaMatr, DarumaTerm:
     begin
       iRetorno := Daruma_FI_AbreRelatorioGerencial;
       Analisa_iRetorno;
       Result:= (iRetorno=1);
     end;
   end;
   Result := Result And Retorno_Impressora;

   If Result And Assigned(FAfterAbreRelatorioGerencial) Then
     FAfterAbreRelatorioGerencial(Self);

end;
//////////////////////////////////////////////////////////////////
function TDefFPrinter.RelatorioGerencial( Texto: String ): boolean;
var
  pLinha: array[0..160] of char;
begin
   Result := False;
   case impressora of
     BematechMP20, BematechMP40, BematechTermica:
       begin
        iRetorno := Bematech_RelatorioGerencial( texto );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
       end;

     Sweda03, Sweda10 :
     begin
        iRetorno := Sweda_RelatorioGerencial( texto );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Elgin:
       begin
        iRetorno := Elgin_RelatorioGerencial( texto );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
       end;
     AFRAC:
       begin
           FillChar(pLinha, 161, 0);
           if Trim(Texto) = '' then
           begin
             StrPCopy(pLinha, ' ');
             iRetorno := AFRAC_ImprimirVinculado(PChar(StringOfChar(' ', 48)), PChar(StringOfChar(' ', 48)));
           end
           else
           begin
             StrPCopy(pLinha, Copy(Texto, 1, 160));
             iRetorno := AFRAC_ImprimirRelatorioGerencial(pLinha);
           end;



         Analisa_iRetorno;
         Result:= (iRetorno=0);
       end;

     DarumaMatr, DarumaTerm:
     begin
       iRetorno := Daruma_FI_EnviarTextoCNF(Copy(Texto, 1, 600));
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;
   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////////////

function TDefFPrinter.TempoOperacionalMFD(TempoOperacional : string): boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica)then
   begin
      iRetorno := Bematech_TempoOperacionalMFD(TempoOperacional);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   if (impressora=Elgin) then
   begin
      iRetorno := Elgin_TempoOperacionalMFD(TempoOperacional);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.TamanhoTotalMFD( cTamanhoMFD: string ): boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then
   begin
      iRetorno := Bematech_TamanhoTotalMFD( cTamanhoMFD);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   if (impressora=Elgin) then begin
      iRetorno := Elgin_TamanhoTotalMFD( cTamanhoMFD);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
///////////////////////////////////////////////////////////////////////////
function TDefFPrinter.AbreRelatorioGerencialMFD( Indice: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
        iRetorno := Bematech_AbreRelatorioGerencialMFD( Indice );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;


     Sweda03, Sweda10 :
     begin
        iRetorno := Sweda_AbreRelatorioGerencialMFD( Indice );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Elgin :
     begin
        iRetorno := Elgin_AbreRelatorioGerencialMFD( Indice );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.UsaComprovanteNaoFiscalVinculado( Texto: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
        iRetorno := Bematech_UsaComprovanteNaoFiscalVinculado( texto );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
        iRetorno := Sweda_UsaComprovanteNaoFiscalVinculado( texto );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Elgin :
     begin
        iRetorno := Elgin_UsaComprovanteNaoFiscalVinculado( texto );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.AbreCupomMFD(CGC: string; Nome: string; Endereco : string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
        iRetorno := Bematech_AbreCupomMFD(CGC, Nome,Endereco);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
        iRetorno := Sweda_AbreCupomMFD(CGC, Nome, Endereco);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Elgin :
     begin
        iRetorno := Elgin_AbreCupomMFD(CGC, Nome,Endereco);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.CancelaCupomMFD(CGC, Nome, Endereco: string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
        iRetorno := Bematech_CancelaCupomMFD(CGC, Nome, Endereco);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
        iRetorno := Sweda_CancelaCupomMFD(CGC, Nome, Endereco);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Elgin :
     begin
        iRetorno := Elgin_CancelaCupomMFD(CGC, Nome, Endereco);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
///////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.CancelaRecebimentoNaoFiscalMFD(CGC, Nome, Endereco: string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       iRetorno := Bematech_CancelaRecebimentoNaoFiscalMFD(CGC, Nome, Endereco);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       iRetorno := Sweda_CancelaRecebimentoNaoFiscalMFD(CGC, Nome, Endereco);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin :
     begin
        iRetorno := Elgin_CancelaRecebimentoNaoFiscalMFD(CGC, Nome, Endereco);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.AbreRecebimentoNaoFiscalMFD(CGC, Nome, Endereco: string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
        iRetorno := Bematech_AbreRecebimentoNaoFiscalMFD(CGC, Nome, Endereco);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
        iRetorno := Sweda_AbreRecebimentoNaoFiscalMFD(CGC, Nome, Endereco);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Elgin :
     begin
        iRetorno := Elgin_AbreRecebimentoNaoFiscalMFD(CGC, Nome, Endereco);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaDepartamentos( Departamentos: String ): boolean;
begin
   Result := False;

  case impressora of
     BematechMP20, BematechMP40, BematechTermica:
      begin
        iRetorno := Bematech_VerificaDepartamentos( Departamentos );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
      end;

     Elgin:
     begin
        iRetorno := Elgin_VerificaDepartamentos( Departamentos );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////
function TDefFPrinter.NumeroCupom( var NumeroCupom: String ): boolean;
var
  pCupom: PChar;
  sCupom: String;
  i: integer;
begin
  Result := False;
  case impressora of
    BematechMP20, BematechMP40, BematechTermica:
      begin
        NumeroCupom := IncCharEx(NumeroCupom, 6, ' ', 'L');
        iRetorno := Bematech_NumeroCupom( NumeroCupom );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
      end;

    Sweda03, Sweda10:
    begin
        NumeroCupom := IncCharEx(NumeroCupom, 6, ' ', 'L');
        iRetorno := Sweda_NumeroCupom( NumeroCupom );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
    end;

    Elgin:
      begin
        NumeroCupom := IncCharEx(NumeroCupom, 6, ' ', 'L');
        iRetorno := Elgin_NumeroCupom( NumeroCupom );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
      end;

    Schalter3D:
      begin
        pCupom := Schalter3D_StatusCupom(0);
        NumeroCupom := StrPas(pCupom);
        Result := Copy(NumeroCupom, 1, 5) <> 'Erro:';
        if Result then
          NumeroCupom := Copy(NumeroCupom, 6, 6)
        else
          NumeroCupom := '';
      end;

    SCFI:
      begin
        pCupom := SCFI_ecfStatusCupom(i);
        NumeroCupom := StrPas(pCupom);
        Result := Copy(NumeroCupom, 1, 5) <> 'Erro:';
        if Result then
          NumeroCupom := Copy(NumeroCupom, 6, 6)
        else
          NumeroCupom := '';
      end;

    AFRAC:
      begin
        InicializaPChar(pCupom, 300);
        iRetorno := AFRAC_LerInformacaoImpressora('023', pCupom);
        Result:= (iRetorno=0);
        NumeroCupom := Trim(StrPas(pCupom));
        try
          StrToInt(NumeroCupom);
        except
          NumeroCupom := '999999';
        end;
      end;
    DarumaMatr, DarumaTerm:
    begin
      //SetLength (NumeroCupom, 6);
      InicializaPChar(pCupom, 6);
      SetLength (sCupom,6);
      iRetorno := Daruma_FI_NumeroCupom(sCupom);
      NumeroCupom := Copy(sCupom, 1, 6);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

  end;

  Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.EstornoNaoFiscalVinculadoMFD(CGC, Nome, Endereco: string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
        iRetorno := Bematech_EstornoNaoFiscalVinculadoMFD(CGC, Nome, Endereco);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
        iRetorno := Sweda_EstornoNaoFiscalVinculadoMFD(CGC, Nome, Endereco);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Elgin :
     begin
        iRetorno := Elgin_EstornoNaoFiscalVinculadoMFD(CGC, Nome, Endereco);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
///////////////////////////////////////////////////////////////////////////
function TDefFPrinter.PercentualLivreMFD( cMemoriaLivre: string ): boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then
   begin
      iRetorno := Bematech_PercentualLivreMFD( cMemoriaLivre );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   if (impressora=Elgin) then
   begin
      iRetorno := Elgin_PercentualLivreMFD( cMemoriaLivre );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.Cancelamentos( ValorCancelamentos: String ): boolean;
begin
   Result := False;

  case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
      iRetorno := Bematech_Cancelamentos( ValorCancelamentos );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
      iRetorno := Sweda_Cancelamentos( ValorCancelamentos );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_Cancelamentos( ValorCancelamentos );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.GrandeTotal(var GrandeTotal: String ): boolean;
var
  sResult : String;
begin
   Result := False;

  case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
      SetLength(sResult, 18);
      iRetorno := Bematech_GrandeTotal( sResult );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
      GrandeTotal := sResult;
     end;

     Sweda03, Sweda10:
     begin
      SetLength(sResult, 18);
      iRetorno := Sweda_GrandeTotal( sResult );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
      GrandeTotal := sResult;
     end;

     Elgin:
     begin
        sResult := '';
        SetLength(sResult, 18);
        iRetorno := Elgin_GrandeTotal( sResult );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
        GrandeTotal := sResult;
     end;

     DarumaMatr, DarumaTerm:
     begin
        SetLength(sResult, 18);
        iRetorno := Daruma_FI_GrandeTotal(sResult);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
        GrandeTotal := sResult;
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.FlagsFiscais( Var Flag: Integer ): boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then
   begin
      iRetorno := Bematech_FlagsFiscais( Flag );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   if (impressora=Elgin) then
   begin
      iRetorno := Elgin_FlagsFiscais( Flag );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.NumeroReducoes( NumeroReducoes: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
      iRetorno := Bematech_NumeroReducoes( NumeroReducoes );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
      iRetorno := Sweda_NumeroReducoes( NumeroReducoes );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_NumeroReducoes( NumeroReducoes );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.DataHoraImpressora( Data: String; Hora: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
       iRetorno := Bematech_DataHoraImpressora( Data, Hora );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
       iRetorno := Sweda_DataHoraImpressora( Data, Hora );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_DataHoraImpressora( Data, Hora );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     DarumaMatr, DarumaTerm:
     begin
       iRetorno := Daruma_FI_DataHoraImpressora(Data, Hora);
       Result   := (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaEpromConectada( Flag: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
      iRetorno := Bematech_VerificaEpromConectada( Flag );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin :
     begin
        iRetorno := Elgin_VerificaEpromConectada( Flag );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.NumeroIntervencoes( NumeroIntervencoes: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
      iRetorno := Bematech_NumeroIntervencoes( NumeroIntervencoes );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
      iRetorno := Sweda_NumeroIntervencoes( NumeroIntervencoes );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_NumeroIntervencoes( NumeroIntervencoes );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;

end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaTruncamento( Flag: string ): boolean;
begin
   Result := False;

  case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
      iRetorno := Bematech_VerificaTruncamento( Flag );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
      iRetorno := Sweda_VerificaTruncamento(Flag);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_VerificaTruncamento( Flag );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaFormasPagamento( var Formas: String ): boolean;
begin
   Result := False;

  case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
        SetLength (Formas, 3016);
        iRetorno := Bematech_VerificaFormasPagamento( Formas );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
        SetLength (Formas, 3016);
        iRetorno := Sweda_VerificaFormasPagamento(PChar(Formas));
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_VerificaFormasPagamento( Formas );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     DarumaMatr, DarumaTerm:
     begin
        SetLength (Formas, 275);
        iRetorno := Daruma_FI_VerificaDescricaoFormasPagamento( Formas );
        Analisa_iRetorno();
        Result := (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaRecebimentoNaoFiscal(Recebimentos : string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       iRetorno := Bematech_VerificaRecebimentoNaoFiscal(Recebimentos);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       iRetorno := Sweda_VerificaRecebimentoNaoFiscal(Recebimentos);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
       iRetorno := Elgin_VerificaRecebimentoNaoFiscal(Recebimentos);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaRecebimentoNaoFiscalMFD(Recebimentos : string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_VerificaRecebimentoNaoFiscalMFD(Recebimentos);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_VerificaRecebimentoNaoFiscalMFD(Recebimentos);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_VerificaRecebimentoNaoFiscalMFD(Recebimentos);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.VersaoFirmware(VersaoFirmware : string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_VersaoFirmware(VersaoFirmware);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_VersaoFirmware(VersaoFirmware);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_VersaoFirmware(VersaoFirmware);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.VersaoFirmwareMFD(var VersaoFirmware : string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_VersaoFirmwareMFD(VersaoFirmware);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_VersaoFirmwareMFD(VersaoFirmware);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_VersaoFirmware(VersaoFirmware);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.NumeroOperacoesNaoFiscais(var NumeroOperacoes: String): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
       SetLength(NumeroOperacoes, 6);
       iRetorno := Bematech_NumeroOperacoesNaoFiscais( NumeroOperacoes );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
       SetLength(NumeroOperacoes, 6);
       iRetorno := Sweda_NumeroOperacoesNaoFiscais( NumeroOperacoes );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
       iRetorno := Elgin_NumeroOperacoesNaoFiscais( NumeroOperacoes );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ClicheProprietario( Cliche: String ): boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then begin
      iRetorno := Bematech_ClicheProprietario( Cliche );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   if (impressora=Elgin) then begin
      iRetorno := Elgin_ClicheProprietario( Cliche );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaTotalizadoresParciaisMFD(Totalizadores : string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_VerificaTotalizadoresParciaisMFD(Totalizadores);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_VerificaTotalizadoresParciaisMFD(Totalizadores);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////
function TDefFPrinter.CGC_IE( CGC: String; IE: String ): boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then begin
      iRetorno := Bematech_CGC_IE( CGC,IE );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   if (impressora=Elgin) then begin
      iRetorno := Elgin_CGC_IE( CGC,IE );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////
function TDefFPrinter.SimboloMoeda( SimboloMoeda: String ): boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then begin
      iRetorno := Bematech_SimboloMoeda( SimboloMoeda );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   if (impressora=Elgin) then begin
      iRetorno := Elgin_SimboloMoeda( SimboloMoeda );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ProgramaIdAplicativo( cAplicativo,  cAplicativo2: String) : boolean;
begin
   Result := False;

   case impressora of
     BematechMP20, BematechMP40, BematechTermica:
     begin
       iRetorno := Bematech_ProgramaIdAplicativoMFD(pchar(cAplicativo + '       ' +cAplicativo2));
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       iRetorno := Sweda_Registry_AplMensagem1(Pchar(cAplicativo));
       Analisa_iRetorno();
       Result:= (iRetorno=1);

       if Result and (cAplicativo2 <> '') then
       begin
         iRetorno := Sweda_Registry_AplMensagem2(Pchar(cAplicativo2));
         Analisa_iRetorno();
         Result:= (iRetorno=1);
       end;
     end;

     Elgin:
     begin
       iRetorno := Elgin_ProgramaIdAplicativoMFD(pchar(cAplicativo + '       ' +cAplicativo2));
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     DarumaMatr, DarumaTerm:
     begin
       iRetorno := Daruma_Registry_AplMensagem1(cAplicativo);
       Result   := (iRetorno=1);

       iRetorno := Daruma_Registry_AplMensagem2(cAplicativo2);
       Result   := (iRetorno=1);

     end;

     else
       result := True;
   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////
function TDefFPrinter.NumeroSerie( var NumeroSerie: String ): boolean;
var
  pNumeroSerie: PChar;
begin

   Result := False;

   case impressora of
     BematechMP20, BematechMP40, BematechTermica:
     begin
       SetLength(NumeroSerie, 15);
       iRetorno := Bematech_NumeroSerie( NumeroSerie );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
       SetLength(NumeroSerie, 15);
       iRetorno := Sweda_NumeroSerie( NumeroSerie );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
       SetLength(NumeroSerie, 20);
       iRetorno := Elgin_NumeroSerie( NumeroSerie );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     AFRAC:
     begin
       InicializaPChar(pNumeroSerie, 300);
       iRetorno := AFRAC_LerInformacaoImpressora('002', pNumeroSerie);
       Result:= (iRetorno=0);
       NumeroSerie := Trim(StrPas(pNumeroSerie));
     end;

     Schalter3D:
     begin
       pNumeroSerie := Schalter3D_StatusEquipo;
       Result := Copy(NumeroSerie, 1 , 5) <> 'Erro:';
       if not Result then
         NumeroSerie := ''
       else
         NumeroSerie := Copy(StrPas(pNumeroSerie), 31, 9);
     end;

     SCFI:
     begin
       pNumeroSerie := SCFI_ecfStatusEquipo;
       Result := Copy(NumeroSerie, 1 , 5) <> 'Erro:';
       if not Result then
         NumeroSerie := ''
       else
         NumeroSerie := Copy(StrPas(pNumeroSerie), 31, 9);
     end;

     DarumaMatr, DarumaTerm:
     begin
       SetLength(NumeroSerie,15);
       iRetorno := Daruma_FI_NumeroSerie(NumeroSerie);
       Result   := (iRetorno=1);
     end;

     else
       result := True;
   end;

   Result := Result And Retorno_Impressora;

end;
/////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.NumeroSubstituicoesProprietario(var NumeroSubstituicoes: String ): boolean;
begin
   Result := False;

   case impressora of
     BematechMP20, BematechMP40, BematechTermica:
     begin
        iRetorno := Bematech_NumeroSubstituicoesProprietario( NumeroSubstituicoes );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
        iRetorno := Sweda_NumeroSubstituicoesProprietario(NumeroSubstituicoes);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_NumeroSubstituicoesProprietario( NumeroSubstituicoes );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.UltimoItemVendido( NumeroItem: String ): boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then begin
      iRetorno := Bematech_UltimoItemVendido( NumeroItem );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   if (impressora=Elgin) then begin
      iRetorno := Elgin_UltimoItemVendido( NumeroItem );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////
function TDefFPrinter.NumeroCaixa( var NumeroCaixa: String ): boolean;
begin
  Result := False;

  case impressora of

    BematechMP20, BematechMP40, BematechTermica:
    begin
      //SetLength(sNCaixa, 4);
      iRetorno := Bematech_NumeroCaixa(NumeroCaixa);
      if iRetorno <> -1 then
        Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

    Sweda03, Sweda10:
    begin
      iRetorno := Sweda_NumeroCaixa(NumeroCaixa);
      if iRetorno <> -1 then
        Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

    Elgin:
    begin
      iRetorno := Elgin_NumeroCaixa(NumeroCaixa);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

  end;

  Result := Result And Retorno_Impressora;

end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.NumeroLoja( var NumeroLoja: String ): boolean;
begin
   Result := False;

  case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
       iRetorno := Bematech_NumeroLoja( NumeroLoja );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
       iRetorno := Sweda_NumeroLoja(NumeroLoja);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_NumeroLoja( NumeroLoja );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaTipoImpressora( Var TipoImpressora: Integer ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
      iRetorno := Bematech_VerificaTipoImpressora( TipoImpressora );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
      iRetorno := Sweda_VerificaTipoImpressora( TipoImpressora );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_VerificaTipoImpressora( TipoImpressora );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaAliquotasIss( Flag: String ): boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then begin
      iRetorno := Bematech_VerificaAliquotasIss( Flag );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   if (impressora=Elgin) then begin
      iRetorno := Elgin_VerificaAliquotasIss( Flag );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaIndiceAliquotasIss(var Flag: String ): boolean;
var
  sResult : String;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
      SetLength(sResult, 48);
      iRetorno := Bematech_VerificaIndiceAliquotasIss( sResult );
      Flag := sResult;
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
      SetLength(sResult, 48);
      iRetorno := Sweda_VerificaIndiceAliquotasIss( PChar(sResult) );
      Flag := sResult;
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_VerificaIndiceAliquotasIss( Flag );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////
function TDefFPrinter.DataMovimento( Data: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
       iRetorno := Bematech_DataMovimento( Data );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
       iRetorno := Sweda_DataMovimento( Data );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_DataMovimento( Data );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.DataHoraReducao( var Data: String; var Hora: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
       SetLength(Data, 6);
       SetLength(Hora, 6);
       iRetorno := Bematech_DataHoraReducao(Data, Hora);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
       SetLength(Data, 6);
       SetLength(Hora, 6);
       iRetorno := Sweda_DataHoraReducao(Data, Hora);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
       SetLength(Data, 6);
       SetLength(Hora, 6);
       iRetorno := Elgin_DataHoraReducao(Data, Hora);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     DarumaMatr, DarumaTerm:
     begin
       SetLength(Data, 6);
       SetLength(Hora, 6);
       iRetorno := Daruma_FI_DataHoraReducao(Data, Hora);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaTotalizadoresNaoFiscaisMFD(Totalizadores : string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_VerificaTotalizadoresNaoFiscaisMFD(Totalizadores);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_VerificaTotalizadoresNaoFiscaisMFD(PChar(Totalizadores));
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_VerificaTotalizadoresNaoFiscaisMFD(Totalizadores);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.MinutosLigada( Minutos: String ): boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then begin
      iRetorno := Bematech_MinutosLigada( Minutos );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   if (impressora=Elgin) then begin
      iRetorno := Elgin_MinutosLigada( Minutos );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.MinutosImprimindo( Minutos: String ): boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then begin
      iRetorno := Bematech_MinutosImprimindo( Minutos );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   if (impressora=Elgin) then begin
      iRetorno := Elgin_MinutosImprimindo( Minutos );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaRelatorioGerencialMFD(Relatorios : string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_VerificaRelatorioGerencialMFD(Relatorios);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_VerificaRelatorioGerencialMFD(Relatorios);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;
   
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.NumeroCuponsCancelados( var NumeroCancelamentos: String ): boolean;
var
  sCCancelados : String;
begin
   Result := False;

  case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
      SetLength(sCCancelados ,4);
      iRetorno := Bematech_NumeroCuponsCancelados( sCCancelados );
      NumeroCancelamentos := sCCancelados;
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
      SetLength(sCCancelados, 4);
      iRetorno := Sweda_NumeroCuponsCancelados( sCCancelados );
      NumeroCancelamentos := sCCancelados;
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_NumeroCuponsCancelados( NumeroCancelamentos );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     DarumaMatr, DarumaTerm:
     begin
       SetLength(sCCancelados, 4);
       iRetorno := Daruma_FI_NumeroCuponsCancelados( sCCancelados );
       NumeroCancelamentos := sCCancelados;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.Acrescimos( ValorAcrescimos: String ): boolean;
begin
   Result := False;

  case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
      iRetorno := Bematech_Acrescimos( ValorAcrescimos );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
      iRetorno := Sweda_Acrescimos( ValorAcrescimos );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_Acrescimos( ValorAcrescimos );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaFormasPagamentoMFD(FormasPagamento : string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_VerificaFormasPagamentoMFD(FormasPagamento);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_VerificaFormasPagamentoMFD(FormasPagamento);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_VerificaFormasPagamentoMFD(FormasPagamento);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.TotalLivreMFD( cMemoriaLivre: string ): boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then begin
      iRetorno := Bematech_TotalLivreMFD( cMemoriaLivre );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   if (impressora=Elgin) then begin
      iRetorno := Elgin_TotalLivreMFD( cMemoriaLivre );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.AbreComprovanteNaoFiscalVinculado( FormaPagamento: String; Valor: String; NumeroCupom: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       FormaPagamento := Copy(FormaPagamento, 0, 16);
       iRetorno := Bematech_AbreComprovanteNaoFiscalVinculado( FormaPagamento,Valor,NumeroCupom );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       FormaPagamento := Copy(FormaPagamento, 0, 15);
       iRetorno := Sweda_AbreComprovanteNaoFiscalVinculado(FormaPagamento, Valor, NumeroCupom );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin :
     begin
       FormaPagamento := Copy(FormaPagamento, 0, 16);
       iRetorno := Elgin_AbreComprovanteNaoFiscalVinculado( FormaPagamento,Valor,NumeroCupom );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.AbreComprovanteNaoFiscalVinculadoMFD(FormaPagamento, Valor, NumeroCupom, CGC, nome, Endereco : string) : boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       FormaPagamento := Copy(FormaPagamento, 0, 16);
       iRetorno := Bematech_AbreComprovanteNaoFiscalVinculadoMFD(FormaPagamento, Valor, NumeroCupom, CGC, nome, Endereco);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       FormaPagamento := Copy(FormaPagamento, 0, 15);
       iRetorno := Sweda_AbreComprovanteNaoFiscalVinculadoMFD(FormaPagamento, Valor, NumeroCupom, CGC, nome, Endereco);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin :
     begin
       FormaPagamento := Copy(FormaPagamento, 0, 16);
       iRetorno := Elgin_AbreComprovanteNaoFiscalVinculadoMFD(FormaPagamento, Valor, NumeroCupom, CGC, nome, Endereco);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
///////////////////////////////////////////////////////
function TDefFPrinter.Sangria(Valor: Currency) : boolean;
var
  pValor: PChar;
begin
   Result := False;
   case impressora of
     BematechMP20, BematechMP40, BematechTermica:
     begin
        iRetorno := Bematech_Sangria(MyFormatCur(Valor, ','));
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
        iRetorno := Sweda_Sangria(MyFormatCur(Valor, ','));
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_Sangria(MyFormatCur(Valor, ','));
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     SCFI:
     begin
       pValor := PChar(StringReplace(MyFormatCur(Valor, '.'), '.', '', [rfReplaceAll]));
       SCFI_ecfImpCab(1);
       SCFI_ecfInicCupomNFiscal(1);
       iRetorno := SCFI_ecfVendaItem('SANGRIA', pValor, 01);
       SCFI_ecfPagamento(0, '0', pValor, 0);
       SCFI_ecfFimTrans('');
       Result := (iRetorno=0);
     end;

     DarumaMatr, DarumaTerm:
     begin
        iRetorno := Daruma_FI_Sangria(MyFormatCur(Valor, '.'));
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;
   end;
   Result := Result And Retorno_Impressora;

   If Result And Assigned(FAfterSangria) Then
     FAfterSangria(Self);

end;
/////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ContadorFitaDetalheMFD(ContadorFita : string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_ContadorFitaDetalheMFD(ContadorFita);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_ContadorFitaDetalheMFD(ContadorFita);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_ContadorFitaDetalheMFD(ContadorFita);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////
function TDefFPrinter.NumeroSerieMemoriaMFD(sNumeroSerie : string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_NumeroSerieMemoriaMFD(sNumeroSerie);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_NumeroSerieMemoriaMFD(sNumeroSerie);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_NumeroSerieMemoriaMFD(sNumeroSerie);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////
function TDefFPrinter.NumeroSerieMFD( var sNumeroSerie : string ): boolean;
var
  sResult: String;
begin
  Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       SetLength(sResult, 15);
       iRetorno := Bematech_NumeroSerieMFD(sResult);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       SetLength(sResult, 20);
       iRetorno := Sweda_NumeroSerieMFD(sResult);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
      iRetorno := Elgin_NumeroSerieMFD(sResult);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

  end;

  Result := Result And Retorno_Impressora;

  if Result then
    sNumeroSerie := sResult;
end;
/////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.MinutosEmitindoDocumentosFiscaisMFD(Minutos : string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       iRetorno := Bematech_MinutosEmitindoDocumentosFiscaisMFD(Minutos);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
       iRetorno := Elgin_MinutosEmitindoDocumentosFiscaisMFD(Minutos);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.MarcaModeloTipoImpressoraMFD(var Marca: String; var Modelo: String; var Tipo : String): boolean;
var
  sResult1, sResult2, sResult3: String;
begin
  Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       iRetorno := Bematech_MarcaModeloTipoImpressoraMFD(Marca, Modelo, Tipo);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       iRetorno := Sweda_MarcaModeloTipoImpressoraMFD(Marca, Modelo, Tipo);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
       iRetorno := Elgin_MarcaModeloTipoImpressoraMFD(Marca, Modelo, Tipo);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;
  Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.DataHoraGravacaoUsuarioSWBasicoMFAdicional(var dataUsuario : String;
  var dataSWBasico : String; var MFAdicional : Char): Boolean;
var
  sMFAdicional : String;
begin
  Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       iRetorno := Bematech_DataHoraGravacaoUsuarioSWBasicoMFAdicional(dataUsuario, dataSWBasico, MFAdicional);
      if iRetorno <> -1 then
        Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       SetLength(sMFAdicional, 5);

       iRetorno := Sweda_DataHoraGravacaoUsuarioSWBasicoMFAdicional(dataUsuario, dataSWBasico, sMFAdicional);
      if iRetorno <> -1 then
        Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
      iRetorno := Elgin_DataHoraSoftwareBasico(dataUsuario, dataSWBasico);
      if iRetorno <> -1 then
        Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

   end;

  Result := Result And Retorno_Impressora;
  
end;

function TDefFPrinter.InscricaoMunicipalMFD(InscricaoMunicipal : string): boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then begin
      iRetorno := Bematech_InscricaoMunicipalMFD(InscricaoMunicipal);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   if (impressora=Elgin) then begin
      iRetorno := Elgin_InscricaoMunicipalMFD(InscricaoMunicipal);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.InscricaoEstadualMFD(InscricaoEstadual : string): boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then begin
      iRetorno := Bematech_InscricaoEstadualMFD(InscricaoEstadual);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   if (impressora=Elgin) then begin
      iRetorno := Elgin_InscricaoEstadualMFD(InscricaoEstadual);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.DataHoraUltimoDocumentoMFD( cDataHora: string ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_DataHoraUltimoDocumentoMFD( cDataHora );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_DataHoraUltimoDocumentoMFD( cDataHora );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_DataHoraUltimoDocumentoMFD( cDataHora );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.DadosUltimaReducaoMFD(var DadosReducao : string): boolean;
var
  sResult: String;
begin
  Result := False;

   case impressora of

    BematechMP20, BematechMP40, BematechTermica :
    begin
      SetLength(sResult, 1278);
      iRetorno := Bematech_DadosUltimaReducaoMFD(sResult);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

    Sweda03, Sweda10 :
    begin
      SetLength(sResult, 1278);
      iRetorno := Sweda_DadosUltimaReducaoMFD(PChar(sResult));
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

    Elgin:
    begin
      SetLength(sResult, 1279);
      iRetorno := Elgin_DadosUltimaReducaoMFD(sResult);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

  end;

  Result := Result And Retorno_Impressora;

  if Result then
    DadosReducao := sResult;

end;

/////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.DadosUltimaReducao(DadosReducao: String): Boolean;
begin
  Result:= False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       iRetorno := Bematech_DadosUltimaReducao(DadosReducao);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       iRetorno := Sweda_DadosUltimaReducaoMFD(PChar(DadosReducao));
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
       iRetorno := Elgin_DadosUltimaReducao(DadosReducao);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;
  Result := Result And Retorno_Impressora;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaTotalizadoresNaoFiscais( Totalizadores: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
      iRetorno := Bematech_VerificaTotalizadoresNaoFiscais( Totalizadores );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
      iRetorno := Sweda_VerificaTotalizadoresNaoFiscaisEx(PChar(Totalizadores) );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_VerificaTotalizadoresNaoFiscais( Totalizadores );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ContadoresTotalizadoresNaoFiscais(Contadores : string): boolean;
begin

   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
      iRetorno := Bematech_ContadoresTotalizadoresNaoFiscais(Contadores);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_ContadoresTotalizadoresNaoFiscais(Contadores);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ContadoresTotalizadoresNaoFiscaisMFD(Contadores : string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_ContadoresTotalizadoresNaoFiscaisMFD(Contadores);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_ContadoresTotalizadoresNaoFiscaisMFD(Contadores);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ContadorRelatoriosGerenciaisMFD (Relatorios : String): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_ContadorRelatoriosGerenciaisMFD(Relatorios);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_ContadorRelatoriosGerenciaisMFD(Relatorios);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_ContadorRelatoriosGerenciaisMFD(Relatorios);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;
   end;

   Result := Result And Retorno_Impressora;
end;
///////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ContadorCupomFiscalMFD(var CuponsEmitidos : string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       SetLength(CuponsEmitidos, 6);
       iRetorno := Bematech_ContadorCupomFiscalMFD(CuponsEmitidos);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       SetLength(CuponsEmitidos, 6);
       iRetorno := Sweda_ContadorCupomFiscalMFD(CuponsEmitidos);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        CuponsEmitidos := '      ';
        iRetorno := Elgin_ContadorCupomFiscalMFD(CuponsEmitidos);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ReducoesRestantesMFD(Reducoes : string): boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then begin
      iRetorno := Bematech_ReducoesRestantesMFD(Reducoes);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   if (impressora=Elgin) then begin
      iRetorno := Elgin_ReducoesRestantesMFD(Reducoes);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.CNPJMFD(CNPJ : string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_CNPJMFD(CNPJ);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_CNPJMFD(CNPJ);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_CNPJMFD(CNPJ);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ContadorComprovantesCreditoMFD(var Comprovantes : string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      SetLength(Comprovantes, 4);
      iRetorno := Bematech_ContadorComprovantesCreditoMFD(Comprovantes);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      SetLength(Comprovantes, 4);
      iRetorno := Sweda_ContadorComprovantesCreditoMFD(Comprovantes);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
       SetLength(Comprovantes, 4);
       iRetorno := Elgin_ContadorComprovantesCreditoMFD(Comprovantes);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ComprovantesNaoFiscaisNaoEmitidosMFD(var Comprovantes: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_ComprovantesNaoFiscaisNaoEmitidosMFD( Comprovantes );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_ComprovantesNaoFiscaisNaoEmitidosMFD( Comprovantes );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_ComprovantesNaoFiscaisNaoEmitidosMFD( Comprovantes );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.RecebimentoNaoFiscal( IndiceTotalizador: String; Valor: String; FormaPagamento: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      FormaPagamento := Copy(FormaPagamento, 0, 16);
      iRetorno := Bematech_RecebimentoNaoFiscal(IndiceTotalizador,Valor,FormaPagamento);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;


     Sweda03, Sweda10 :
     begin
      FormaPagamento := Copy(FormaPagamento, 0, 16);
      iRetorno := Sweda_RecebimentoNaoFiscal(IndiceTotalizador, Valor, FormaPagamento);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin :
     begin
      FormaPagamento := Copy(FormaPagamento, 0, 16);
      iRetorno := Elgin_RecebimentoNaoFiscal(IndiceTotalizador,Valor,FormaPagamento);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
///////////////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.EfetuaRecebimentoNaoFiscalMFD(IndiceTotalizador, ValorRecebimento : string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_EfetuaRecebimentoNaoFiscalMFD(IndiceTotalizador, ValorRecebimento);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_EfetuaRecebimentoNaoFiscalMFD(IndiceTotalizador, ValorRecebimento);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
      iRetorno := Elgin_EfetuaRecebimentoNaoFiscalMFD(IndiceTotalizador, ValorRecebimento);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////
function TDefFPrinter.TotalizaRecebimentoMFD: boolean;
begin

   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_TotalizaRecebimentoMFD;
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_TotalizaRecebimentoMFD;
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin :
     begin
        iRetorno := Elgin_TotalizaRecebimentoMFD;
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;

end;
/////////////////////////////////////////////////////////
function TDefFPrinter.SubTotalizaRecebimentoMFD: boolean;
begin

   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_SubTotalizaRecebimentoMFD;
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin :
     begin
        iRetorno := Elgin_SubTotalizaRecebimentoMFD;
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;
   end;

   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.AcrescimoDescontoItemMFD(Item, AcrescimoDesconto,TipoAcrescimoDesconto, ValorAcrescimoDesconto: string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_AcrescimoDescontoItemMFD(Item, AcrescimoDesconto,TipoAcrescimoDesconto, ValorAcrescimoDesconto);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_AcrescimoDescontoItemMFD(Item, AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
      iRetorno := Elgin_AcrescimoDescontoItemMFD(Item, AcrescimoDesconto,TipoAcrescimoDesconto, ValorAcrescimoDesconto);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;
   end;

   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.AcrescimoDescontoSubtotalRecebimentoMFD( cFlag, cTipo, cValor: string): boolean;
begin
   Result := False;

   case impressora of
     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_AcrescimoDescontoSubtotalRecebimentoMFD(cFlag, cTipo, cValor);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_AcrescimoDescontoSubtotalRecebimentoMFD(cFlag, cTipo, cValor);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin :
     begin
        iRetorno := Elgin_AcrescimoDescontoSubtotalRecebimentoMFD(cFlag, cTipo, cValor);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.AcrescimoDescontoSubtotalMFD( cFlag, cTipo, cValor: string): boolean;
begin
   Result := False;

   case impressora of
     BematechMP20, BematechMP40, BematechTermica :
     begin
       iRetorno := Bematech_AcrescimoDescontoSubtotalMFD(cFlag, cTipo, cValor);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       iRetorno := Sweda_AcrescimoDescontoSubtotalMFD(cFlag, cTipo, cValor);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin :
     begin
       iRetorno := Elgin_AcrescimoDescontoSubtotalMFD(cFlag, cTipo, cValor);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
///////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.AumentaDescricaoItem( Descricao: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_AumentaDescricaoItem(Descricao);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_AumentaDescricaoItem(Descricao);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin :
      begin
        iRetorno := Elgin_AumentaDescricaoItem(Descricao);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
      end;

   end;
   Result := Result And Retorno_Impressora;
end;
///////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.UsaUnidadeMedida( UnidadeMedida: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_UsaUnidadeMedida(UnidadeMedida);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_UsaUnidadeMedida(UnidadeMedida);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin :
     begin
        iRetorno := Elgin_UsaUnidadeMedida(UnidadeMedida);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
///////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.EstornoFormasPagamento( FormaOrigem: String; FormaDestino: String; Valor: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
        iRetorno := Bematech_EstornoFormasPagamento(FormaOrigem,FormaDestino,Valor);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Elgin :
     begin
        iRetorno := Elgin_EstornoFormasPagamento(FormaOrigem,FormaDestino,Valor);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
        iRetorno := Sweda_EstornoFormasPagamento(FormaOrigem, FormaDestino, Valor);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
///////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.Suprimento(Valor: Currency; FormaPagamento: String ) : boolean;
var
  pValor: PChar;
begin
   Result := False;
   case Impressora of
     BematechMP20,BematechMP40, BematechTermica:
     begin
       FormaPagamento := Copy(FormaPagamento, 0, 16);
       iRetorno := Bematech_Suprimento(MyFormatCur(Valor, ','), FormaPagamento);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       FormaPagamento := Copy(FormaPagamento, 0, 15);
       iRetorno := Sweda_Suprimento(MyFormatCur(Valor, ','), FormaPagamento);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
       FormaPagamento := Copy(FormaPagamento, 0, 16);
       iRetorno := Elgin_Suprimento(MyFormatCur(Valor, ','), FormaPagamento);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     SCFI:
     begin
       pValor := PChar(StringReplace(MyFormatCur(Valor, '.'), '.', '', [rfReplaceAll]));
       SCFI_ecfImpCab(1);
       SCFI_ecfInicCupomNFiscal(1);
       iRetorno := SCFI_ecfVendaItem('SUPRIMENTO', pValor, 02);
       SCFI_ecfPagamento(0, '0', pValor, 0);
       SCFI_ecfFimTrans('');
       Result := (iRetorno=0);
     end;

     DarumaMatr, DarumaTerm:
     begin
       iRetorno := Daruma_FI_Suprimento(MyFormatCur(Valor, '.'), FormaPagamento);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;
   end;
   Result := Result And Retorno_Impressora;

   If Result And Assigned(FAfterSuprimento) Then
     FAfterSuprimento(Self);

end;
/////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaEstadoGaveta( var EstadoGaveta: Integer ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_VerificaEstadoGaveta( EstadoGaveta );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_VerificaEstadoGaveta( EstadoGaveta );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin :
     begin
        iRetorno := Elgin_VerificaEstadoGaveta( EstadoGaveta );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.InfoBalanca(port: string; model: integer; peso : string; precoKilo : string;total : string): integer;
begin
   Result := 0;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_InfoBalanca(port,model,peso,precoKilo,total);
      Analisa_iRetorno();
      Result:= iRetorno;
     end;

     Elgin :
     begin
        iRetorno := Elgin_InfoBalanca(port,model,peso,precoKilo,total);
        Analisa_iRetorno();
        Result:= iRetorno;
     end;

   end;
end;
/////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaImpressoraLigada: boolean;
var
  Estado: Array[0..1] of char;
  vret : PChar;
  sRetorno: string;
begin
   Result := False;
   case impressora of
     BematechMP20, BematechMP40, BematechTermica:
       begin
        iRetorno := Bematech_VerificaImpressoraLigada;
        Analisa_iRetorno();
        Result:= (iRetorno=1);
       end;

     Sweda03, Sweda10 :
     begin
        iRetorno := Sweda_VerificaImpressoraLigada;
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Elgin:
       begin
        iRetorno := Elgin_VerificaImpressoraLigada;
        Analisa_iRetorno();
        Result:= (iRetorno=1);
       end;

     AFRAC:
     begin
       _AFRAC_CopyStrToArray(Estado, '');
       AFRAC_VerificarEstado(Estado);

       Result := Estado <> '';
       if not result then
          Application.MessageBox( 'Impressora Desligada ou Desconectada', 'Atenção',
                                                  MB_IconInformation + MB_OK);
     end;
     Schalter3D:
     begin
       Result := Schalter3D_StatusImp <> 'Erro: 04';
       //
     end;

     SCFI:
     begin
       vret := SCFI_ecfStatusImp;
       sRetorno := copy(vret,3,3);
       iRetorno := StrToInt(sRetorno);
       Analisa_iRetorno();
       Result := (iRetorno <> 04);
     end;

     DarumaMatr, DarumaTerm:
     begin
       Result := Daruma_FI_VerificaImpressoraLigada = 1;
     end;
   end;
   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaImpressoraLigadaTEF: boolean;
var
  Estado: Array[0..1] of char;
  vret : PChar;
  sRetorno: string;
begin
   Result := False;
   case impressora of
     BematechMP20, BematechMP40, BematechTermica:
       begin
        iRetorno := Bematech_VerificaImpressoraLigada;
        Analisa_iRetorno();
        Result:= (iRetorno=1);
       end;

     Sweda03, Sweda10 :
     begin
        iRetorno := Sweda_VerificaImpressoraLigada;
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Elgin:
       begin
        iRetorno := Elgin_VerificaImpressoraLigada;
        Analisa_iRetorno();
        Result:= (iRetorno=1);
       end;

     AFRAC:
     begin
       _AFRAC_CopyStrToArray(Estado, '');
       AFRAC_VerificarEstado(Estado);

       Result := Estado <> '';
     end;
     
     Schalter3D:
     begin
       Result := Schalter3D_StatusImp <> 'Erro: 04';
       //
     end;

     SCFI:
     begin
       vret := SCFI_ecfStatusImp;
       sRetorno := copy(vret,3,3);
       iRetorno := StrToInt(sRetorno);

       Result := (iRetorno <> 04);

     end;

     DarumaMatr, DarumaTerm:
     begin
       Result := Daruma_FI_VerificaImpressoraLigada = 1;
       Analisa_iRetorno();
     end;
   end;

   Result := Result and Retorno_Impressora;

end;
/////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaModoOperacao( Modo: string ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_VerificaModoOperacao( Modo );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_VerificaModoOperacao( Modo );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_VerificaModoOperacao( Modo );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.FechaRelatorioGerencial: boolean;
var
  sStatus: String;
  Valor : Integer;
begin
   Result := False;
   case Impressora of

     BematechMP20, BematechMP40, BematechTermica:
       begin
          iRetorno := Bematech_FechaRelatorioGerencial;
          Analisa_iRetorno();
          Result:= (iRetorno=1);
       end;

     Sweda03, Sweda10 :
     begin
        SetLength(sStatus, 1);
        iRetorno := Sweda_StatusRelatorioGerencial(sStatus);
        Result := (iRetorno=1);
        Analisa_iRetorno;

        if Result and (Trim(sStatus) = '1') then
        begin
          iRetorno := Sweda_FechaRelatorioGerencial;
          Analisa_iRetorno();
          Result:= (iRetorno=1);
        end;
     end;

     Elgin:
       begin
          Valor := 0;
          iRetorno := Elgin_LeIndicadores(Valor);
          Analisa_iRetorno();
          Result:= (iRetorno=1);

          if (Valor = 1024) or (Valor = 15424) then
          begin
            iRetorno := Elgin_FechaRelatorioGerencial;
            Analisa_iRetorno();
            Result:= (iRetorno=1);
          end;
       end;

     AFRAC:
     begin
       iRetorno := AFRAC_FecharRelatorioGerencial;
       //Analisa_iRetorno();
       //Result:= (iRetorno = 0);
       Result := True;
     end;

     DarumaMatr, DarumaTerm:
     begin
       SetLength(sStatus, 2);
       iRetorno := Daruma_FI_StatusRelatorioGerencial(sStatus);
       Result := (iRetorno=1);
       Analisa_iRetorno;

       if Result and (Trim(sStatus) = '1') then
       begin
         iRetorno := Daruma_FI_FechaRelatorioGerencial;
         Analisa_iRetorno();
         Result:= (iRetorno=1);
       end;
     end;
   end;

   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.UsaRelatorioGerencialMFD( Texto: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
        iRetorno := Bematech_UsaRelatorioGerencialMFD( texto );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
        iRetorno := sweda_UsaRelatorioGerencialMFD( texto );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Elgin :
     begin
        iRetorno := Elgin_UsaRelatorioGerencialMFD( texto );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.EfetFormPagI(IndexFP:string; Valor:Currency):Boolean;
var  Valor1:String;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then begin
      if (StrToInt(IndexFP)<=0) or (StrToInt(IndexFP)>50) then
         Raise EInvalidEntry.Create('Indice da Forma de Pagamento Fora de Faixa (01 a 50)');

      Valor1:=Copy(FormatFloat('00000000000000',100*Valor),1,14);
      iRetorno := Bematech_EfetuaFormaPagamento(IndexFP,Valor1);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;

   if (impressora=Elgin) then begin
      if (StrToInt(IndexFP)<=0) or (StrToInt(IndexFP)>50) then
         Raise EInvalidEntry.Create('Indice da Forma de Pagamento Fora de Faixa (01 a 50)');

      Valor1:=Copy(FormatFloat('00000000000000',100*Valor),1,14);
      iRetorno := Elgin_EfetuaFormaPagamento(IndexFP,Valor1);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////
function TDefFPrinter.ImprimeCheque( Banco: String; Valor: String; Favorecido: String; Cidade: String; Data: String; Mensagem: String ): boolean;
var
  pBanco : array[0..3] of char;
  pValor : TPontoFlutuante;
  pFavorecido : array[0..80] of char;
  pCidade : array[0..30] of char;
  pData : TData;
  pMensagem : array[0..120] of char;

begin
   Result := False;
   case Impressora of
     BematechMP20, BematechMP40, BematechTermica:
     begin
        iRetorno := Bematech_ImprimeCheque( Banco,Valor,Favorecido,Cidade,Data,Mensagem );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
        iRetorno := Sweda_ImprimeCheque(Banco, Valor, Favorecido, Cidade, Data, Mensagem );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Elgin:
     begin
        iRetorno := Elgin_ImprimeCheque( Banco,Valor,Favorecido,Cidade,Data,Mensagem );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;
     AFRAC:
     begin
        _AFRAC_CopyStrToArray(pBanco, Banco);
        _AFRAC_CopyStrToArray(pFavorecido, Favorecido);
        _AFRAC_CopyStrToArray(pCidade, Cidade);
        _AFRAC_CopyStrToArray(pData, StringReplace(Data, '/', '', [rfReplaceAll]));
        _AFRAC_CopyStrToArray(pMensagem, Mensagem);

        pValor := _AFRAC_FloatToPontoFlutuante(MyStrToMoney(Valor), 2);

        iRetorno := AFRAC_ChequeImprimir(pBanco, pValor, pFavorecido, pCidade, pData, pMensagem);

        Analisa_iRetorno();
        Result:= (iRetorno=0);
     end;
   end;
   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////
function TDefFPrinter.ImprimeChequeMFD(NumeroBanco, Valor, Favorecido, Cidade, Data, Mensagem, ImpressaoVerso, Linhas : string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_ImprimeChequeMFD(NumeroBanco, Valor, Favorecido, Cidade, Data, Mensagem, ImpressaoVerso, Linhas);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_ImprimeChequeMFD(NumeroBanco, Valor, Favorecido, Cidade, Data, Mensagem, ImpressaoVerso);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin :
     begin
      iRetorno := Elgin_ImprimeChequeMFD(NumeroBanco, Valor, Favorecido, Cidade, Data, Mensagem, ImpressaoVerso, Linhas);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;

end;
/////////////////////////////////////////////////////////////////////
function TDefFPrinter.LeituraChequeMFD(CodigoCMC7 : string): boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then begin
      iRetorno := Bematech_LeituraChequeMFD(CodigoCMC7);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   if (impressora=Elgin) then begin
      iRetorno := Elgin_LeituraChequeMFD(CodigoCMC7);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.CancelaImpressaoCheque: boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then begin
      iRetorno := Bematech_CancelaImpressaoCheque;
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   if (impressora=Elgin) then begin
      iRetorno := Elgin_CancelaImpressaoCheque;
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ProgramaMoedaPlural( MoedaPlural: String ): boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then begin
      iRetorno := Bematech_ProgramaMoedaPlural( MoedaPlural );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   if (impressora=Elgin) then begin
      iRetorno := Elgin_ProgramaMoedaPlural( MoedaPlural );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ProgramaMoedaSingular( MoedaSingular: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_ProgramaMoedaSingular( MoedaSingular );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      iRetorno := Sweda_ProgramaMoedaSingular( MoedaSingular );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
      iRetorno := Elgin_ProgramaMoedaSingular( MoedaSingular );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ValorTotalizadorNaoFiscal( Totalizador: String; Valor: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      iRetorno := Bematech_ValorTotalizadorNaoFiscal( Totalizador,Valor );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin :
     begin
      iRetorno := Elgin_ValorTotalizadorNaoFiscal( Totalizador,Valor );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;

end;
/////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.EfetuaFormaPagamento( FormaPagamento: String; ValorFormaPagamento: Double; Indice : String ): boolean;
var
  pDescricao: PChar;
  pValor: PChar;
  pIndice: PChar;
  pMensagem: PChar;
begin
  Result := False;
  case Impressora of
    BematechMP20, BematechMP40, BematechTermica:
    begin
      FormaPagamento := Copy(FormaPagamento, 0, 16);
      iRetorno := Bematech_EfetuaFormaPagamento( FormaPagamento, MyFormatCur(ValorFormaPagamento, '.'));
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

    Sweda03, Sweda10 :
    begin
      FormaPagamento := Copy(FormaPagamento, 0, 15);
      iRetorno := Sweda_EfetuaFormaPagamento( FormaPagamento, MyFormatCur(ValorFormaPagamento, '.'));
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

    Elgin:
    begin
      FormaPagamento := Copy(FormaPagamento, 0, 16);
      iRetorno := Elgin_EfetuaFormaPagamento( FormaPagamento, MyFormatCur(ValorFormaPagamento, '.'));
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

    Schalter3D:
    begin
      pValor := PChar(StringReplace(MyFormatCur(ValorFormaPagamento, '.'), '.', '', [rfReplaceAll]));
      Result := RetornoSchD(Schalter3D_Pagamento(0, PChar(FormaPagamento), pValor, 0));
    end;

    SCFI:
    begin
      pValor := PChar(StringReplace(MyFormatCur(ValorFormaPagamento, '.'), '.', '', [rfReplaceAll]));
      iRetorno := SCFI_ecfPagamento(0, PChar(Indice), pValor, 0);
      Result := (iRetorno=0);
    end;

    AFRAC:
    begin
      pDescricao := PChar(IncCharEx(FormapAgamento, 30, ' ', 'R'));
      pIndice    := PChar(IncCharEx(Indice, 2, ' ', 'R'));
      pMensagem  := PChar(IncCharEx('', 80, ' ', 'R'));
      pValor     := PChar(StringReplace(MyFormatCur(ValorFormaPagamento, '.'), ',', '', [rfReplaceAll]));

      iRetorno := AFRAC_FormaPagamento(pDescricao, pIndice, pValor, pMensagem);

      Result := iRetorno=0;
      Analisa_iRetorno();
    end;

    DarumaMatr, DarumaTerm:
    begin
      FormaPagamento := Copy(FormaPagamento, 0, 16);

      iRetorno := Daruma_FI_EfetuaFormaPagamento(FormaPagamento, StringReplace(MyFormatCur(ValorFormaPagamento, '.'), ',', '', [rfReplaceAll]));

      Result := iRetorno=1;
      Analisa_iRetorno();

    end;
  end;
  Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.EfetuaFormaPagamentoMFD(FormaPagamento, ValorFormaPagamento, Parcelas, DescricaoFormaPagto: string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
      FormaPagamento := Copy(FormaPagamento, 0, 16);
      iRetorno := Bematech_EfetuaFormaPagamentoMFD(FormaPagamento, ValorFormaPagamento, Parcelas, DescricaoFormaPagto);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
      FormaPagamento := Copy(FormaPagamento, 0, 15);
      iRetorno := Sweda_EfetuaFormaPagamentoMFD(FormaPagamento, ValorFormaPagamento, Parcelas, DescricaoFormaPagto);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin :
     begin
      FormaPagamento := Copy(FormaPagamento, 0, 16);
      iRetorno := Elgin_EfetuaFormaPagamentoMFD(FormaPagamento, ValorFormaPagamento, Parcelas, DescricaoFormaPagto);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

   end;

  Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////////
function TDefFPrinter.AlteraSimboloMoeda( SimboloMoeda: String ): boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then begin
      iRetorno := Bematech_AlteraSimboloMoeda(SimboloMoeda);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;

   Result := False;
   if (impressora=Elgin) then begin
      iRetorno := Elgin_AlteraSimboloMoeda(SimboloMoeda);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ProgramaAliquota( Aliquota: String; ICMS_ISS: Integer ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
        iRetorno := Bematech_ProgramaAliquota( Aliquota,ICMS_ISS );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Elgin :
     begin
        iRetorno := Elgin_ProgramaAliquota( Aliquota,ICMS_ISS );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
        Result := False;
     end;
   end;

   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////////
function TDefFPrinter.CupomAdicionalMFD: boolean;
begin
   Result := False;

  case impressora of
    BematechMP20, BematechMP40, BematechTermica :
    begin
      iRetorno := Bematech_CupomAdicionalMFD;
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

    Elgin :
    begin
      iRetorno := Elgin_CupomAdicionalMFD;
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

    Sweda03, Sweda10 :
    begin
      iRetorno := Sweda_CupomAdicionalMFD;
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

   end;
   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.EfetFormPagII(IndexFP:string; Valor:Currency; DescFormPgto:String):Boolean;
var  Valor1:String;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then begin
      if (StrToInt(IndexFP)<=0) or (StrToInt(IndexFP)>50) then
         Raise EInvalidEntry.Create('Indice da Forma de Pagamento Fora de Faixa (01 a 50)');

      if Length(DescFormPgto)>80 then DescFormPgto := Copy(DescFormPgto,1,80);
      Valor1:=Copy(FormatFloat('00000000000000',100*Valor),1,14);

      iRetorno := Bematech_EfetuaFormaPagamentoDescricaoForma(IndexFP,Valor1,DescFormPgto);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;

   if (impressora=Elgin) then begin
      if (StrToInt(IndexFP)<=0) or (StrToInt(IndexFP)>50) then
         Raise EInvalidEntry.Create('Indice da Forma de Pagamento Fora de Faixa (01 a 50)');

      if Length(DescFormPgto)>80 then DescFormPgto := Copy(DescFormPgto,1,80);
      Valor1:=Copy(FormatFloat('00000000000000',100*Valor),1,14);

      iRetorno := Elgin_EfetuaFormaPagamentoDescricaoForma(IndexFP,Valor1,DescFormPgto);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;

   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.RetornoAliquotas( var Aliquotas: String ): boolean;
begin

   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
        SetLength(Aliquotas, 79);
        iRetorno := Bematech_RetornoAliquotas( Aliquotas );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Elgin :
     begin
        iRetorno := Elgin_RetornoAliquotas( Aliquotas );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     DarumaTerm, DarumaMatr :
     begin
        SetLength(Aliquotas, 79);
        iRetorno := Daruma_FI_RetornoAliquotas( Aliquotas );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
        SetLength(Aliquotas, 79);
        iRetorno := Sweda_RetornoAliquotas( PChar(Aliquotas) );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
     end;

   end;


   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ProgVerFormPagII(FormaPagto, OperacaoTef:String):boolean;
begin
   Result := False;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then begin
      iRetorno := Bematech_ProgramaFormaPagamentoMFD(FormaPagto, OperacaoTef);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;

   if (impressora=Elgin) then begin
      iRetorno := Elgin_ProgramaFormaPagamentoMFD(FormaPagto, OperacaoTef);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
   end;
   Result := Result And Retorno_Impressora;
end;
{ACRESCIDO APOS INSERIR IMPRESSORA SCHALTER}
function TDefFPrinter.SchalterErros(NroRet:Integer;StrRet,TipoRet:string):boolean;
var i,vPos : integer;
begin
   Pronto := false;
   if TipoRet = 'N' then begin
      if NroRet = 0 then begin
         result := true;
         Pronto := true;
      end else begin
         for i := 1 to 73 do  begin
            vPos := Pos(':',MsgSchalter[i]);
            if StrToInt(Copy(MsgSchalter[i],1,vPos-1))=NroRet then begin
               if Assigned(FUserEvent) then OnError(IntToStr(Abs(i)),MsgSchalter[i]);
               break;
            end;
         end;
         result := false;
      end;
   end else begin
      if Copy(StrRet,1,5)='Erro:' then begin
         for i := 1 to 73 do begin
            vPos := Pos(':',MsgSchalter[i]);
            if Copy(MsgSchalter[i],1,vPos-1)=Copy(StrRet,6,2) then begin
               if Assigned(FUserEvent) then OnError(IntToStr(Abs(i)),MsgSchalter[i]);
               break;
            end;
         end;
       Result := false;
      end else begin
         Pronto := true;
         Result := true;
      end;
   end;
end;
// **********************************************************************
// -------------------- Analisa a Variável iRetorno ---------------------

Procedure TDefFPrinter.Analisa_iRetorno;
var
  CodigoErro: array[0..50] of char;
  Mensagem:   array[0..80] of char;
  Acao:       array[0..80] of char;
  sMensagem, sSujestao : String;
begin
  case Impressora of
    BematechMP20, BematechMP40, BematechTermica:
    begin
      if iRetorno <> 0 then
      begin
        if iRetorno <> 1 then
          BlockInput(False);
        case iRetorno of
          00: Application.MessageBox( 'Erro de Comunicação !', 'Erro',MB_IconError + MB_OK);
          -1: Application.MessageBox( 'Erro de Execução na Função. Verifique!', 'Erro', MB_IconError + MB_OK);
          -2: Application.MessageBox( 'Parâmetro Inválido !', 'Erro',MB_IconError + MB_OK);
          -3: Application.MessageBox( 'Alíquota não programada !', 'Atenção',MB_IconInformation + MB_OK);
          -4: Application.MessageBox( 'Arquivo BemaFI32.INI não encontrado. Verifique!', 'Atenção',
                                        MB_IconInformation + MB_OK);
          -5: Application.MessageBox( 'Erro ao Abrir a Porta de Comunicação', 'Erro',
                                        MB_IconError + MB_OK);
          -6: {Application.MessageBox( 'Impressora Desligada ou Desconectada', 'Atenção',
                                        MB_IconInformation + MB_OK)};
          -7: Application.MessageBox( 'Banco Não Cadastrado no Arquivo BemaFI32.ini', 'Atenção',
                                        MB_IconInformation + MB_OK);
          -8: Application.MessageBox( 'Erro ao Criar ou Gravar no Arquivo Retorno.txt ou Status.txt', 'Erro',
                                        MB_IconError + MB_OK);
          -18: Application.MessageBox( 'Não foi possível abrir arquivo INTPOS.001 !', 'Atenção',
                                        MB_IconInformation + MB_OK);
          -19: Application.MessageBox( 'Parâmetro diferentes !', 'Atenção',
                                        MB_IconInformation + MB_OK);
          -20:
            Application.MessageBox( 'Transação cancelada pelo Operador !', 'Atenção',
                                        MB_IconInformation + MB_OK);
          -21:
            Application.MessageBox( 'A Transação não foi aprovada !', 'Atenção',
                                        MB_IconInformation + MB_OK);
          -22:
            Application.MessageBox( 'Não foi possível terminal a Impressão !', 'Atenção',
                                        MB_IconInformation + MB_OK);
          -23:
            Application.MessageBox( 'Não foi possível terminal a Operação !', 'Atenção',
                                        MB_IconInformation + MB_OK);
          -24:
            Application.MessageBox( 'Forma de pagamento não programada.', 'Atenção',
                                        MB_IconInformation + MB_OK);
          -25:
            Application.MessageBox( 'Totalizador não fiscal não programado.', 'Atenção',
                                        MB_IconInformation + MB_OK);
          -26:
            Application.MessageBox( 'Transação já Efetuada !', 'Atenção',
                                        MB_IconInformation + MB_OK);
          -28:
            Application.MessageBox( 'Não há Informações para serem Impressas !', 'Atenção',
                                        MB_IconInformation + MB_OK);
        end;
      end;
    end;

    Elgin:
    begin
      if iRetorno = 0 then
      begin
        If (ObtemRetornoECF(sMensagem)) Then
          Application.MessageBox(pChar(sMensagem), 'Erro',MB_IconError + MB_OK);
      end
      else
      begin
        if iRetorno <> 1 then
          BlockInput(False);
        case iRetorno of
          -2: Application.MessageBox( 'Parâmetro inválido na função !', 'Erro',MB_IconError + MB_OK);
          -4: Application.MessageBox( 'O arquivo de inicialização Elgin.ini não foi encontrado no diretório de sistema do Windows!', 'Atenção', MB_IconInformation + MB_OK);
          -5: Application.MessageBox( 'Erro ao abrir a porta de comunicação!', 'Erro', MB_IconInformation + MB_OK);
          -8: Application.MessageBox( 'Erro ao criar ou gravar no arquivo STATUS.TXT ou RETORNO.TXT', 'Erro', MB_IconInformation + MB_OK);
          -27: Application.MessageBox( 'Erro Nº -27 - Status da impressora diferente de 6,0,0,0 (Ack, St1, St2 e St3)', 'Erro', MB_IconInformation + MB_OK);
          -50: Application.MessageBox( 'Número de série inválido!', 'Erro', MB_IconInformation + MB_OK);
        end;
      end;
    end;

    AFRAC:
    begin
      if iRetorno <> 0 then
      begin
        FillChar(CodigoErro, Length(CodigoErro), 0);
        FillChar(Mensagem,   Length(Mensagem), 0);
        FillChar(Acao,       Length(Acao), 0);

        AFRAC_PegarCodigoErro(CodigoErro, Mensagem, Acao);

        case StrToInt(StrPas(CodigoErro)) of
          001: sMensagem := 'Cupom fiscal não aberto';
          002: sMensagem := 'Dia já encerrado';
          003: sMensagem := 'Item não registrado no cupom fiscal';
          004: sMensagem := 'Acréscimo ou desconto não registrado no cupom fiscal (fechamento de acréscimo/desconto exclusivamente)';
          005: sMensagem := 'Já houve desconto/acréscimo para este item';
          006: sMensagem := 'Acréscimo/desconto não fechado';
          007: sMensagem := 'Pagamento não realizado';
          008: sMensagem := 'Pagamento não completado';
          009: sMensagem := 'Cupom fiscal já aberto. Cancele o Cupom anterior';
          010: sMensagem := 'Alíquota informada não cadastrada ou fora da faixa';
          011: sMensagem := 'Tipo da situação tributária inválido';
          012: sMensagem := 'Forma de Pagamento não Cadastrada';
          013: sMensagem := 'Preço total igual a zero';
          014: sMensagem := 'Desconto maior ou igual ao valor do cupom';
          015: sMensagem := 'Quantidade excede ao limite permitido';
          016: sMensagem := 'Preço unitário excede ao limite permitido';
          017: sMensagem := 'Preço total excede ao limite permitido';
          018: sMensagem := 'Cupom já cancelado';
          019: sMensagem := 'Último documento não é um cupom fiscal';
          020: sMensagem := 'Tempo de tolerância para Redução Z excedido';
          021: sMensagem := 'Excedeu à quantidade de autenticações permitida';
          022: sMensagem := 'Troco não permitido para esta forma de pagamento';
          023: sMensagem := 'Limite de itens do cupom fiscal excedido';
          024: sMensagem := 'Limite de linhas para mensagem publicitária excedido';
          025: sMensagem := 'Impossível realizar troco. (não foi feito reforço)';
          026: sMensagem := 'Cupom finalizado com total nulo';
          027: sMensagem := 'Cupom anterior não pode ser cancelado';
          028: sMensagem := 'Cupom já totalizado';
          029: sMensagem := 'Necessário totalizar cupom antes de fechar';
          030: sMensagem := 'Troco não realizado';
          031: sMensagem := 'Necessário programar legenda';
          032: sMensagem := 'Acréscimo inválido';
          033: sMensagem := 'Desconto inválido';
          034: sMensagem := 'Repetição de desconto inválida';
          035: sMensagem := 'IOF não habilitado em MIT';
          036: sMensagem := 'Não permitido desconto em ISSQN';
          100: sMensagem := 'Cupom não vinculado não aberto';
          101: sMensagem := 'Cupom não vinculado sendo emitido';
          102: sMensagem := 'Comando não permitido durante cupom não fiscal não vinculado';
          103: sMensagem := 'Necessário abrir cupom não fiscal';
          104: sMensagem := 'Já houve lançamento em acumulador positivo';
          105: sMensagem := 'Já houve lançamento em acumulador negativo';
          150: sMensagem := 'Cupom vinculado não aberto';
          151: sMensagem := 'Cupom vinculado sendo emitido';
          152: sMensagem := 'Não há cupom vinculado para ser emitido';
          153: sMensagem := 'Cupom vinculado pendente. Pendências precisam ser emitidas';
          154: sMensagem := 'Excesso de cupons vinculados pendentes (máximo 30 pendências)';
          155: sMensagem := 'Não existem vínculos programados na impressora';
          156: sMensagem := 'Excedeu número de vias';
          157: sMensagem := 'COO não existe';
          200: sMensagem := 'Relatório Gerencial não aberto';
          201: sMensagem := 'Relatório Gerencial sendo emitido';
          202: sMensagem := 'Relatório Gerencial não cadastrado (novo convênio)';
          250: sMensagem := 'Redução Z já emitida. Impressora inoperante até 0:00 h.';
          251: sMensagem := 'É necessário executar redução Z';
          252: sMensagem := 'Dia já aberto';
          253: sMensagem := 'Dia não aberto';
          254: sMensagem := 'Necessário executar Leitura X';
          255: sMensagem := 'Posição da tabela de alíquotas já ocupada';
          256: sMensagem := 'A tabela de pagamentos não foi inicializada na impressora';
          300: sMensagem := 'Autenticação não permitida';
          301: sMensagem := 'Excedeu às repetições de autenticação';
          350: sMensagem := 'Entrada no horário de verão não pode provocar mudança de data';
          351: sMensagem := 'Não foi emitida Redução Z';
          352: sMensagem := 'O relógio já está em horário de verão';
          353: sMensagem := 'O relógio não está em horário de verão';
          354: sMensagem := 'Não é possível ajustar um horário inferior ao da redução Z';
          355: sMensagem := 'Excedeu o tempo de execução do comando';
          356: sMensagem := 'Data inválida';
          357: sMensagem := 'Hora inválida';
          358: sMensagem := 'Ajuste de hora diário já foi realizado';
          400: sMensagem := 'Porta não aberta';
          401: sMensagem := 'Erro na comunicação serial';
          402: sMensagem := 'Detectado algum problema na impressora (paper jam, sobretensão, etc)';
          403: sMensagem := 'Erro - Time Out - Computador não consegue estabelecer comunicação';
          450: sMensagem := 'Fim de papel';
          451: sMensagem := 'Papel acabando';
          500: sMensagem := 'Cheque não inserido';
          501: sMensagem := 'Não permitido na impressão de cheque.';
          502: sMensagem := 'Cheque: parâmetro fora de faixa;';
          503: sMensagem := 'Cheque: erro no campo valor;';
          504: sMensagem := 'Cheque: erro no campo local de emissão;';
          505: sMensagem := 'Cheque: erro no formato do pacote;';
          506: sMensagem := 'Cheque: erro no campo data;';
          507: sMensagem := 'Cheque: erro no campo favorecido;';
          508: sMensagem := 'Cheque: erro no campo 1ª linha de comentário;';
          509: sMensagem := 'Cheque: erro no campo 2ª linha de comentário;';
          510: sMensagem := 'Cheque: número de caracteres das 2 linhas de comentários somados superior a 120;';
          511: sMensagem := 'Cheque: soma dos deslocamentos verticais superior a DLSV;';
          512: sMensagem := 'Cheque: valor não pode ser impresso nas dimensões especificadas;';
          513: sMensagem := 'Cheque: valor por extenso não pode ser impresso nas dimensões especificadas;';
          514: sMensagem := 'Cheque: favorecido não pode ser impresso nas dimensões especificadas;';
          515: sMensagem := 'Cheque: data e local não podem ser impressos nas dimensões especificadas.';
          516: sMensagem := 'Cheque: 1ª linha de comentário não pode ser impressa nas dimensões especificadas;';
          517: sMensagem := 'Cheque: 2ª linha de comentário não pode ser impressa nas dimensões especificadas;';
          518: sMensagem := 'Cheque: caractere de preenchimento inválido;';
          519: sMensagem := 'Cheque: primeira linha de extenso em branco.';
          520: sMensagem := 'Está em estado de impressão de cheque';
          521: sMensagem := 'Não está em estado de impressão de cheque';
          522: sMensagem := 'Necessário inserir cheque';
          523: sMensagem := 'Erro de leitura de CMC7';
          524: sMensagem := 'Banco não cadastrado';
          525: sMensagem := 'Erro cadastro dos bancos. Arquivo BANCO ou equivalente';
          526: sMensagem := 'Excedeu o tamanho do extenso';
          527: sMensagem := 'Moeda não cadastrada';
          800: sMensagem := 'Intervalo inconsistente';
          801: sMensagem := 'A string TOTAL não é aceita';
          802: sMensagem := 'Argumentos inválidos';
          803: sMensagem := 'Comando inexistente';
          804: sMensagem := 'Sintaxe de comando errada';
          805: sMensagem := 'Comando desabilitado';
          806: sMensagem := 'Comando só aceito em intervenção fiscal';
          807: sMensagem := 'Comando enviado fora da seqüência lógica da impressora';
          808: sMensagem := 'Atributo de formatação inválido';
          809: sMensagem := 'Função não implementada';
          else sMensagem := 'Erro não documentado';
        end;

        case StrToInt(StrPas(Acao)) of
          0: sSujestao := 'Sem Sugestão.';
          1: sSujestao := 'Tentar novamente.';
          2: sSujestao := 'Ignorar.';
          3: sSujestao := 'Comando possivelmente foi executado, leia status para confirmar.';
          4: sSujestao := 'Suspender Execução por 10 segundos.';
          5: sSujestao := 'Abortar.';
        end;

        Application.MessageBox(PChar(Format('%S - %S'#13#10'Ação Recomendada: %S',
                                            [StrPas(CodigoErro), sMensagem, sSujestao])),
                               'Atenção', MB_IconInformation + MB_OK);

      end;
    end;

    DarumaMatr, DarumaTerm:
    begin

      if (iRetorno <> 1) then
      begin
        sMensagem := '';
        case iRetorno of
           0:  sMensagem := 'Impressora Desligada ou Desconectada !!';
          -1:  sMensagem := 'Erro de comunicação.';
          -2:  sMensagem := 'Parâmetro inválido passado no método.';
          -3:  sMensagem := 'Alíquota não programada no ECF.';
          -4:  sMensagem := 'A Chave ou Valor no Registry Não foi encontrado.';
          -5:  sMensagem := 'Erro ao abrir a porta de comunicação.';
          -8:  sMensagem := 'Erro ao criar ou gravar no arquivo STATUS.TXT ou RETORNO.TXT.';
          -24: sMensagem := 'Forma de pagamento não programada.';
          -27: sMensagem := 'A Função Executou o Comando porém o ECF sinalizou Erro, chame a DARUMA_FIR_RETORNOIMPRESSORA para identificar o Erro.';
          -31: sMensagem := 'Forma de pagamento não finalizada.';
        end;
        if sMensagem <> '' then
          Application.MessageBox(PChar(sMensagem), 'Atenção', MB_IconInformation + MB_OK);
      end;

    end;

    Sweda03, Sweda10:
    begin
      if (iRetorno <> 1) then
        Application.MessageBox(PChar('Comando não executado! Erro: ' + IntToStr(iRetorno)), 'Atenção', MB_IconInformation + MB_OK);
    end;

    SCFI:
    begin
      if (iRetorno <> 00) and (iRetorno <> 100) then
      begin
        sMensagem := '';
        case iRetorno of
          01: sMensagem := 'Erro de checksum.';
          02: sMensagem := 'Timeout RX.';
          03: sMensagem := 'Memória insuficiente.';
          04: sMensagem := 'Impressora fora de linha ou desligada';
          10: sMensagem := 'Erro de sobreposição.';
          11: sMensagem := 'Erro de paridade.';
          12: sMensagem := 'Erro de sobreposição e paridade.';
          13: sMensagem := 'Erro de formato.';
          14: sMensagem := 'Erro de sobreposição e formato.';
          15: sMensagem := 'Erro de paridade e sobreposição.';
          16: sMensagem := 'Erro de sobreposição, paridade e formato.';
          20: sMensagem := 'Erro no cadastro de bancos.';
          21: sMensagem := 'Banco não cadastrado.';
          22: sMensagem := 'Moeda não cadastrada.';
          23: sMensagem := 'Extenso excedido.';
          65: sMensagem := 'Em venda.';
          66: sMensagem := 'Limite de cabeçalho alcançado.';
          68: sMensagem := 'Cabeçalho impresso.';
          69: sMensagem := 'Não começou venda.';
          70: sMensagem := 'Valor inválido.';
          73: sMensagem := 'Valor a menor.';
          74: sMensagem := 'Valor a maior.';
          78: sMensagem := 'Número máximo de Reduções Z alcançado.';
          79: sMensagem := 'Erro de comunicação.';
          80: sMensagem := 'Palavra reservada.';
          81: sMensagem := 'Papel próximo do fim.';
          82: sMensagem := 'Data não localizada.';
          84: sMensagem := 'Erro de memória fiscal.';
          85: sMensagem := 'Perda da RAM.';
          86: sMensagem := 'Não houve pagamento.';
          87: sMensagem := 'Cupom já totalizado.';
          88: sMensagem := 'Não pode cancelar venda.';
          89: sMensagem := 'Comando não completo.';
          90: sMensagem := 'Cupom aberto.';
          91: sMensagem := 'Não há cupom a cancelar.';
          92: sMensagem := 'Tabela de taxa não inicializada.';
          94: sMensagem := 'Seleção de taxa inválida.';
          95: sMensagem := 'Cancelamento inválido.';
          96: sMensagem := 'Nada a retificar.';
          97: sMensagem := 'Redução não localizada.';
          98: sMensagem := 'Cabeçalho não carregado.';
          99: sMensagem := 'Impressora em intervenção técnica.';
          100: sMensagem := 'Impressora em período de venda.';
          101: sMensagem := 'Somente com intervenção técnica.';
          102: sMensagem := 'Desconto inválido.';
          103: sMensagem := 'Limite de linhas alcançado.';
          104: sMensagem := 'Somente após o total.';
          105: sMensagem := 'Dados inválidos.';
          106: sMensagem := 'Alteração de taxa não disponível.';
          107: sMensagem := 'Comando inválido.';
          108: sMensagem := 'Não houve o fechamento do dia.';
          109: sMensagem := 'Erro irrecuperável.';
          110: sMensagem := 'Alteração inválida.';
          111: sMensagem := 'Data já alterada.';
          112: sMensagem := 'Alíquota não carregada.';
          113: sMensagem := 'Fechamento diário não realizado.';
          114: sMensagem := 'Abertura do dia inválida.';
          115: sMensagem := 'Fechamento já realizado.';
          116: sMensagem := 'Ajuste somente de +/- 1 hora.';
          117: sMensagem := 'Acréscimo inválido.';
          118: sMensagem := 'Pagamento incompleto.';
          121: sMensagem := 'Erro de gravação na memória fiscal.';
          126: sMensagem := 'Comando fora de sequência.';
          127: sMensagem := 'Autenticação sem papel.';
          132: sMensagem := 'Queda de energia.';
          133: sMensagem := 'Data inválida.';
          134: sMensagem := 'Item fora da faixa.';
          135: sMensagem := 'Item não vendido.';
          136: sMensagem := 'Parâmetro errado.';
          137: sMensagem := 'Limite de valor ultrapassado.';
          138: sMensagem := 'Relógio fora de operação.';
          139: sMensagem := 'Pagamento não definido.';
          140: sMensagem := 'Limite de autenticação excedido.';
          141: sMensagem := 'Comando inválido.';
          142: sMensagem := 'Posição já programada.';
          143: sMensagem := 'Posição inexistente.';
          144: sMensagem := 'Cupom vinculado pendente.';
          145: sMensagem := 'Excesso de documentos vinculados.';
          147: sMensagem := 'Em horário já solicitado.';
          148: sMensagem := 'Oscilador do relógio desativado.';
          149: sMensagem := 'Formas de pagamento não inicializadas.';
          150: sMensagem := 'Inscrição Estadual inválida.';
          151: sMensagem := 'Estenso excedido.';
          152: sMensagem := 'Cupom está com subtotal zerado.';
          153: sMensagem := 'Codificação do GT já programada.';
          154: sMensagem := 'Não há vinculados a cupom.';
          155: sMensagem := 'Redução não permitida.';
          156: sMensagem := 'Caracter repetido na codificação do GT.';
          157: sMensagem := 'Caracter proibido na codificação do GT.';
        end;
        if sMensagem <> '' then
          Application.MessageBox(PChar(sMensagem), 'Atenção', MB_IconInformation + MB_OK);
      end;
    end;
  end;
end;

{* ========================================================================== *
   Função para Terminar o Fechamento do cupom fiscal
 * ========================================================================== *}
function TDefFPrinter.TermFechCupFisc(Msg: String):Boolean;
var
  Vinculado: TBooleano;
begin
   Result := False;
   case impressora of
     Sweda03, Sweda10:
     begin
       Msg := Copy(Msg,1,380);
       iRetorno := Sweda_TerminaFechamentoCupom(Msg);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Schalter3D:
       begin
         Schalter3D_LineFeed(1,1);
         Result := RetornoSchD(Schalter3D_FimTrans(' '));
         if Result then Schalter3D_LineFeed(1,8);
       end;

     BematechMP20, BematechMP40, BematechTermica:
       begin
         Msg := Copy(Msg,1,380);
         iRetorno := Bematech_TerminaFechamentoCupom(msg);
         Analisa_iRetorno();
         Result:= (iRetorno=1);
       end;

     Elgin:
       begin
         Msg := Copy(Msg,1,380);
         iRetorno := Elgin_TerminaFechamentoCupom(msg);
         Analisa_iRetorno();
         Result:= (iRetorno=1);
       end;

     Schalter2S:
       begin
         Schalter2S_ecfLineFeed(1,1);
         Result := RetornoSchD(Schalter2S_ecfFimTrans(' '));
       end;
     SCFI:
       begin
         if msg <> '' then
         begin
           SCFI_ecfLineFeed(1,1);
           iRetorno := SCFI_ecfImpLinha(PChar(Copy(msg, 1, 40)));
         end;
         SCFI_ecfLineFeed(1,1);
         iRetorno := SCFI_ecfFimTrans(' ');
         Analisa_iRetorno();
         Result := (iRetorno=0);
       end;

     AFRAC:
     begin
       iRetorno := AFRAC_InformarMensagemCupom(pchar(msg));
       iRetorno := AFRAC_FecharCupom(Vinculado);
       Analisa_iRetorno();
       Result:= (iRetorno=0);
     end;

     DarumaMatr, DarumaTerm:
     begin
       iRetorno := Daruma_FI_TerminaFechamentoCupom(pchar(Msg));
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;


     None:
     begin
         Result := True;
     end;
   end;
   Result := Result And Retorno_Impressora;
end;
{* ========================================================================== *
   Função para Início de Fechamento do Cupom Fiscal.
 * ========================================================================== *}
function TDefFPrinter.IniFechCupfisc(sFechar:String):Boolean;
var
   AcrescimoDesconto: String;
   TipoAcrescimoDesconto: String;
   ValorAcrescimoDesconto: String;
   PontoDecimal: String;
   Liquido: PChar;
   pAcrescimoDesconto: PChar;
   pTipoAcrescimoDesconto: PChar;
   pValorAcrescimoDesconto: PChar;

begin
  Result := False;

  AcrescimoDesconto      := ParseParam(sFechar, FISCAL_FECHA_NOTA_ACRES_DESC);
  TipoAcrescimoDesconto  := ParseParam(sFechar, FISCAL_FECHA_NOTA_TIPO_ACRES_DESC);
  ValorAcrescimoDesconto := ParseParam(sFechar, FISCAL_FECHA_NOTA_VALOR_ACRES_DESC);
  PontoDecimal           := ParseParam(sFechar, FISCAL_ITEM_PONTO_DEC);

   case impressora of
     Schalter2S, Schalter3D:
     begin
        Result := True;
     end;

     Sweda03, Sweda10:
     begin
       iRetorno := Sweda_IniciaFechamentoCupom(AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     BematechMP20, BematechMP40, BematechTermica:
     begin
      iRetorno := Bematech_IniciaFechamentoCupom(AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
       iRetorno := Elgin_IniciaFechamentoCupom(AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     AFRAC:
     begin
       pAcrescimoDesconto      := PChar(IntToStr(Byte(AcrescimoDesconto = 'D')));
       pTipoAcrescimoDesconto  := PChar(IntToStr(Byte(TipoAcrescimoDesconto = '$')));
       pValorAcrescimoDesconto := PChar(MyFormatCur(MyStrCurToFloat(ValorAcrescimoDesconto, PontoDecimal),'.'));

       if MyStrCurToFloat(ValorAcrescimoDesconto, PontoDecimal) <> 0 then
         begin
           iRetorno := AFRAC_AcrescimoDescontoCupom(pAcrescimoDesconto, pTipoAcrescimoDesconto, pValorAcrescimoDesconto, '');
           Analisa_iRetorno();
           Result := iRetorno=0;
           if Result then
           begin
             AFRAC_FecharAcrescimoDesconto('Acrescimo', 'Desconto', Liquido);
           end;
         end
       else
         Result := True;
     end;

     DarumaMatr, DarumaTerm:
     begin
       ValorAcrescimoDesconto := MyFloatToStr(MyStrCurToFloat(ValorAcrescimoDesconto, PontoDecimal));

       iRetorno := Daruma_FI_IniciaFechamentoCupom(AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     None:
     begin
         Result := True;
     end;

     SCFI:
     begin
       pValorAcrescimoDesconto := PChar(MyFormatCur(MyStrCurToFloat(ValorAcrescimoDesconto, PontoDecimal),'.'));

       if ValorAcrescimoDesconto <> '0.00' then
       begin
         iRetorno := SCFI_ecfSubTotal();
         Analisa_iRetorno();
         Result:= (iRetorno=0);
         if Result then
         begin
           if AcrescimoDesconto = 'D' then
              iRetorno := SCFI_ecfCancAcresDescSubTotal(0, 0, '       DESCONTO', PChar(tiramsc(pValorAcrescimoDesconto)));
          if AcrescimoDesconto = 'A' then
              iRetorno := SCFI_ecfCancAcresDescSubTotal(1, 0, '      ACRESCIMO', PChar(tiramsc(pValorAcrescimoDesconto)));
          Analisa_iRetorno();
          Result:= (iRetorno=0);
         end;
       end
       else
         Result := True;
     end;
   end;
   Result := Result And Retorno_Impressora;
end;
{* =================================================================================== *
   Função para Cancela Acrescimo Desconto Subtotal MFD
 * =================================================================================== *}
function TDefFPrinter.CancelaAcrescimoDescontoItemMFD( cFlag, cItem: string ): boolean;
begin
   Result := False;

   case impressora of
     Schalter2S, Schalter3D, SCFI:
     begin
        Result := True;
     end;

     Sweda03, Sweda10:
     begin
      iRetorno := Sweda_CancelaAcrescimoDescontoItemMFD(cFlag, cItem );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     BematechMP20, BematechMP40, BematechTermica:
     begin
      iRetorno := Bematech_CancelaAcrescimoDescontoItemMFD( cFlag, cItem );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
      iRetorno := Elgin_CancelaAcrescimoDescontoItemMFD( cFlag, cItem );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     None:
     begin
         Result := True;
     end;
   end;
   Result := Result And Retorno_Impressora;
end;
{* ========================================================================== *
   Função para Cancela Acrescimo Desconto Subtotal Recebimento MFD
 * ========================================================================== *}
function TDefFPrinter.CancelaAcrescimoDescontoSubtotalRecebimentoMFD(cFlag: string): boolean;
begin
   Result := False;

   case impressora of
     Schalter2S, Schalter3D, SCFI:
     begin
        Result := True;
     end;

     Sweda03, Sweda10:
     begin
         Result := True;
     end;

     BematechMP20, BematechMP40, BematechTermica:
     begin
      iRetorno := Bematech_CancelaAcrescimoDescontoSubtotalRecebimentoMFD( cFlag );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
      iRetorno := Elgin_CancelaAcrescimoDescontoSubtotalRecebimentoMFD( cFlag );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     None:
     begin
         Result := True;
     end;
   end;
   Result := Result And Retorno_Impressora;
end;
{* ========================================================================== *
   Função para Cancela Acrescimo Desconto Subtotal MFD
 * ========================================================================== *}
function TDefFPrinter.CancelaAcrescimoDescontoSubtotalMFD( cFlag: string): boolean;
begin
   Result := False;

   case impressora of
     Schalter2S, Schalter3D:
     begin
        Result := True;
     end;

     Sweda03, Sweda10:
     begin
      iRetorno := Sweda_CancelaAcrescimoDescontoSubtotalMFD( cFlag );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     BematechMP20, BematechMP40, BematechTermica:
     begin
      iRetorno := Bematech_CancelaAcrescimoDescontoSubtotalMFD( cFlag );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
      iRetorno := Elgin_CancelaAcrescimoDescontoSubtotalMFD( cFlag );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     SCFI:
     begin
      Result := True;
     end;

     None:
     begin
         Result := True;
     end;
   end;
   Result := Result And Retorno_Impressora;
end;
{* ========================================================================== *
   Função para Início de Fechamento do Cupom Fiscal MFD
 * ========================================================================== *}
function TDefFPrinter.IniFechCupfiscMFD(sFechar:String):Boolean;
var
   AcrescimoDesconto: String;
   TipoAcrescimoDesconto: String;
   ValorAcrescimoDesconto: String;
   ValorDesconto: String;
begin
   Result := False;

   AcrescimoDesconto      := ParseParam(sFechar, FISCAL_FECHA_NOTA_ACRES_DESC);
   TipoAcrescimoDesconto  := ParseParam(sFechar, FISCAL_FECHA_NOTA_TIPO_ACRES_DESC);
   ValorAcrescimoDesconto := ParseParam(sFechar, FISCAL_FECHA_NOTA_VALOR_ACRES_DESC);
   ValorDesconto          := ParseParam(sFechar, FISCAL_FECHA_NOTA_VALOR_DESCO);

   case impressora of
     Schalter2S, Schalter3D:
     begin
        Result := True;
     end;

     Sweda03, Sweda10:
     begin
       iRetorno := Sweda_IniciaFechamentoCupomMFD(AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto, ValorDesconto);
       Analisa_iRetorno();
       Result := (iRetorno=1);
     end;

     BematechMP20, BematechMP40, BematechTermica:
     begin
      iRetorno := Bematech_IniciaFechamentoCupomMFD(AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto, ValorDesconto);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
      iRetorno := Elgin_IniciaFechamentoCupomMFD(AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto, ValorDesconto);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     None:
     begin
         Result := True;
     end;

     SCFI:
     begin
       Result := True;
     end;
   end;
   Result := Result And Retorno_Impressora;
end;
{* ================================================================================ *
   Função para Início de Fechamento do Recebimento Nao Fiscal MFD
* ================================================================================= *}
function TDefFPrinter.FechaRecebimentoNaoFiscalMFD(Mensagem : string): boolean;
begin
   Result := False;

   case impressora of
     Schalter2S, Schalter3D, SCFI:
     begin
        Result := True;
     end;

     Sweda03, Sweda10:
     begin
       iRetorno := Sweda_FechaRecebimentoNaoFiscalMFD(Mensagem);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     BematechMP20, BematechMP40, BematechTermica:
     begin
      iRetorno := Bematech_FechaRecebimentoNaoFiscalMFD(Mensagem);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
      iRetorno := Elgin_FechaRecebimentoNaoFiscalMFD(Mensagem);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     None:
     begin
         Result := True;
     end;
   end;
   Result := Result And Retorno_Impressora;
end;

function TDefFPrinter.ReimpressaoNaoFiscalVinculadoMFD : boolean;
begin

  Result := False;

  case impressora of

    BematechMP20, BematechMP40, BematechTermica :
    begin
      iRetorno := Bematech_ReimpressaoNaoFiscalVinculadoMFD();
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

    Elgin :
    begin
      iRetorno := Elgin_ReimpressaoNaoFiscalVinculadoMFD();
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

    Sweda03, Sweda10 :
    begin
      iRetorno := Sweda_ReimpressaoNaoFiscalVinculadoMFD;
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;
  end;

   Result := Result And Retorno_Impressora;
end;

function TDefFPrinter.SegundaViaNaoFiscalVinculadoMFD : boolean;
begin
  Result := False;

  case impressora of

    BematechMP20, BematechMP40, BematechTermica :
    begin
      iRetorno := Bematech_SegundaViaNaoFiscalVinculadoMFD();
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

    Elgin :
    begin
      iRetorno := Elgin_SegundaViaNaoFiscalVinculadoMFD();
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

    Sweda03, Sweda10 :
    begin
      iRetorno := Sweda_SegundaViaNaoFiscalVinculadoMFD;
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;


  end;

  Result := Result And Retorno_Impressora;
end;

{* ================================================================================ *
   Função para Início de Fechamento do Recebimento Nao Fiscal MFD
* ================================================================================= *}
function TDefFPrinter.IniciaFechamentoRecebimentoNaoFiscalMFD(sFechar:String):Boolean;
var
   AcrescimoDesconto: String;
   TipoAcrescimoDesconto: String;
   ValorAcrescimo: String;
   ValorDesconto: String;
begin
  Result := False;

  AcrescimoDesconto    := ParseParam(sFechar, FISCAL_FECHA_NOTA_ACRES_DESC);
  TipoAcrescimoDesconto:= ParseParam(sFechar, FISCAL_FECHA_NOTA_TIPO_ACRES_DESC);
  ValorAcrescimo       := ParseParam(sFechar, FISCAL_FECHA_NOTA_VALOR_ACRES_DESC);
  ValorDesconto        := ParseParam(sFechar, FISCAL_FECHA_NOTA_VALOR_DESCO);

   case impressora of
     Schalter2S, Schalter3D:
     begin
        Result := True;
     end;

     Sweda03, Sweda10:
     begin
      iRetorno := Sweda_IniciaFechamentoRecebimentoNaoFiscalMFD(AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimo, ValorDesconto);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     BematechMP20, BematechMP40, BematechTermica:
     begin
      iRetorno := Bematech_IniciaFechamentoRecebimentoNaoFiscalMFD(AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimo, ValorDesconto);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     Elgin:
     begin
      iRetorno := Elgin_IniciaFechamentoRecebimentoNaoFiscalMFD(AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimo, ValorDesconto);
      Analisa_iRetorno();
      Result:= (iRetorno=1);
     end;

     None:
     begin
         Result := True;
     end;

     SCFI:
     begin
       Result := True;
     end;
   end;
   Result := Result And Retorno_Impressora;
end;

{* ========================================================================== *
    Função para obter o número sequencial do cupom fiscal.
 * ========================================================================== *}
Function TDefFPrinter.NumSeqCupFisc: Word;
var Retorno: String;
begin
   result := 0;
   if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then
       begin
         Result:= 0;
       end;

   if (impressora = Elgin) then
       begin
         Result:= 0;
       end;

   if (impressora=Schalter2S) or (impressora=Schalter3D) then
     begin
       NroRet := 0;
       StrRet :=  Schalter2S_ecfLeituraXSerial();
       if SchalterErros(NroRet,StrRet,'S') then
       begin
          Result := StrToInt(Copy(StrRet,23,6))+1;
       end;
     end;{schalter}

   if (impressora=SCFI) then
    begin
       NroRet := 0;
       StrRet := SCFI_ecfLeituraXSerial();
       if SchalterErros(NroRet,StrRet,'S') then
       begin
          Result := StrToInt(Copy(StrRet,23,6))+1;
       end;
    end;

   case impressora of
     Sweda03, Sweda10:
       begin
          Result := Sweda_MsgLog(PChar(Retorno));
       end;

     None:
       begin
         Result:=0;
       end;        
    end;
end;
//////////////////////////////////////////
function TDefFPrinter.Trends_ret(resp: integer): boolean;
begin
   dados.mensagem := '';
   Result := false;

   case resp of
      0: Result := true;
      1: dados.mensagem := 'Detectado pouco papel';
      2: dados.mensagem := 'Cupom finalizado com total nulo. Será emitido um cupom de cancelamento automaticamente';
      3: dados.mensagem := 'Abrindo relatório gerencial na Leitura X ou Redução Z';
   end;
   if copy(ultimaresp, 1, 1) = '-' then begin
      case strtointdef(copy(ultimaresp, 6, 2), 0) of
         0: Result := true;
         01: dados.mensagem := 'O cabeçalho contém caracteres invalidados';
         02: dados.mensagem := 'Comando inexistente';
         03: dados.mensagem := 'Valor não numérico em campo numérico';
         04: dados.mensagem := 'Valor fora da faixa entre 20 h E 7 Fh';
         05: dados.mensagem := 'Campo deve iniciar com "@", "&" ou "%"';
         06: dados.mensagem := 'Campo deve iniciar com "$", "#" ou "?"';
         07: dados.mensagem := 'O intervalo é inconsistente.' + #13 + 'O primeiro valor deve ser menor que o segundo valor(no caso de datas, valores anteriores a 010195 serão consideradas como pertencentes ao intervalo de anos 2000 - 2094.';
         09: dados.mensagem := 'A string "TOTAL" não é aceita';
         10: dados.mensagem := 'A sintaxe do comando está errada';
         11: dados.mensagem := 'Excedeu o nº máximo de linhas permitidas pelo comando';
         12: dados.mensagem := 'O terminador enviado não está obedecendo o protocolo de comunicação';
         13: dados.mensagem := 'O checksum enviado está incorreto';
         15: dados.mensagem := 'A situação tributária deve iniciar com "T", "F", "I" ou "N"';
         16: dados.mensagem := 'Data inválida';
         17: dados.mensagem := 'Hora inválida';
         18: dados.mensagem := 'Alíquota não programada ou fora do intervalo';
         19: dados.mensagem := 'O campo de sinal está incorreto';
         20: dados.mensagem := 'Comando só aceito em Intervenção Fiscal';
         21: dados.mensagem := 'Comando só aceito em modo Normal';
         22: dados.mensagem := 'Necessário abrir cupom fiscal';
         23: dados.mensagem := 'Comando não aceito durante cupom fiscal';
         24: dados.mensagem := 'Necessário abrir cupom não Fiscal';
         25: dados.mensagem := 'Comando não aceito durante Cupom Não Fiscal';
         26: dados.mensagem := 'O relógio já está em horário de verão';
         27: dados.mensagem := 'O relógio não está em horário de verão';
         28: dados.mensagem := 'Necessário realizar Redução Z';
         29: dados.mensagem := 'Fechamento do dia(Redução Z)já executado';
         30: dados.mensagem := 'Necessário programar legenda';
         31: dados.mensagem := 'Item inexistente ou já cancelado';
         32: dados.mensagem := 'O cupom anterior não pode ser cancelado';
         33: dados.mensagem := 'Detectado falta de papel';
         36: dados.mensagem := 'Necessário programar os dados do estabelecimento';
         37: dados.mensagem := 'Necessário realizar Intervenção Fiscal';
         38: dados.mensagem := 'A memória fiscal não permite mais realizar vendas.Só é possível executar Leitura X ou Leitura da Memória Fiscal';
         39: dados.mensagem := 'A memória fiscal não permite mais realizar vendas.Só é possível executar Leitura X ou Leitura da Memória Fiscal correu algum problema na memória NOVRAM.Será necessário realizar uma Intervenção Técnica';
         40: dados.mensagem := 'Necessário programar a data do relógio';
         41: dados.mensagem := 'Número máximo de itens por cupom ultrapassado';
         42: dados.mensagem := 'Já foi realizado o ajuste de hora diário';
         43: dados.mensagem := 'Comando válido ainda em execução';
         44: dados.mensagem := 'Está em estado de impressão de cheque';
         45: dados.mensagem := 'Não está em estado de impressão de cheque';
         46: dados.mensagem := 'Necessário inserir o cheque';
         47: dados.mensagem := 'Necessário inserir nova bobina';
         48: dados.mensagem := 'Necessário executar uma Leitura X';
         49: dados.mensagem := 'Detectado algum problema na impressora(paper jam, sobretensão, etc).';
         50: dados.mensagem := 'Cupom já foi totalizado';
         51: dados.mensagem := 'Necessário totalizar cupom antes de fechar';
         52: dados.mensagem := 'Necessário finalizar cupom com comando correto';
         53: dados.mensagem := 'Ocorreu erro de gravação na memória fiscal';
         54: dados.mensagem := 'Excedeu número máximo de estabelecimentos';
         55: dados.mensagem := 'Memória Fiscal não inicializada';
         56: dados.mensagem := 'Ultrapassou valor do pagamento';
         57: dados.mensagem := 'Registrador não programado ou troco já realizado';
         58: dados.mensagem := 'Falta completar valor do pagamento';
         59: dados.mensagem := 'Campo somente de caracteres não numéricos(Alfabéticos)';
         60: dados.mensagem := 'Excedeu campo máximo de caracteres';
         61: dados.mensagem := 'Troco não realizado';
         62: dados.mensagem := 'Comando desabilitado';
         91: dados.mensagem := 'Erro na abertura do arquivo de configuração(Erro da DLL)';
         92: dados.mensagem := 'Erro na abertura da porta COM(Erro da DLL)';
         93: dados.mensagem := 'Parâmetro com tamanho ou tipo inválido(Erro da DLL)';
         94: dados.mensagem := 'Erro no número de parâmetros(Erro da DLL)';
         95: dados.mensagem := 'Comando fora de seqüência(Erro da DLL)';
         96: dados.mensagem := 'Comando não Implementado(Erro da DLL)';
         97: dados.mensagem := 'Impressora desligada(Erro da DLL)';
         98: dados.mensagem := 'Timeout de Transmissão(Erro da DLL)';
         99: dados.mensagem := 'Timeout de Recepção(Erro da DLL)';
      end;
   end;
   if Result = false then begin
      if Dados.Mensagem = '' then Dados.Mensagem := 'Erro não identificado...';
      onError(' ', copy(ultimaresp, 5, 2) + ' - ' + dados.mensagem);
   end;
   pronto := true;
end;

/////////////////////////////////////////////////////
function TDefFPrinter.URN_Ret2(retorno: integer): Boolean;
begin
   Dados.mensagem := '';
   if (retorno = 0) or (retorno = 33) then begin
      result := True;
      pronto := true;
      exit;
   end;
   if retorno =  1 then Dados.mensagem := 'DLL já inicializada';
   if retorno =  2 then Dados.mensagem := 'DLL não inicializada';
   if retorno =  3 then Dados.mensagem := 'Falha no acesso a porta serial';
   if retorno =  4 then Dados.mensagem := 'Falha na configuração da porta serial';
   if retorno =  5 then Dados.mensagem := 'Porta serial não inicializada';
   if retorno =  6 then Dados.mensagem := 'Falha na transmissão: outra transmissão em andamento.';
   if retorno =  7 then Dados.mensagem := 'Tamanho do comando muito grande para a DLL';
   if retorno =  8 then Dados.mensagem := 'Impressora fora de linha, desligada ou desconectada.';
   if retorno =  9 then Dados.mensagem := 'Falha geral na transmissão do comando.';
   if retorno = 10 then Dados.mensagem := 'Timeout na recepção da resposta da impressora.';
   if retorno = 11 then Dados.mensagem := 'Falha geral na recepção da resposta.';
   if retorno = 12 then Dados.mensagem := 'Falha no acesso aos buffers internos da porta serial';
   if retorno = 13 then Dados.mensagem := 'Erro de frame na comunicação';
   if retorno = 14 then Dados.mensagem := 'Erro de overrun na comunicação';
   if retorno = 15 then Dados.mensagem := 'Break detectado na comunicação';
   if retorno = 16 then Dados.mensagem := 'Erro de acesso a porta serial durante a recepção';
   if retorno = 17 then Dados.mensagem := 'Tamanho do buffer de recepção da porta serial insuficiente para recepção dos dados.';
   if retorno = 18 then Dados.mensagem := 'Erro de paridade na comunicação';
   if retorno = 19 then Dados.mensagem := 'Tamanho do buffer de transmissão da porta serial insuficiente para comunicação.';
   if retorno = 20 then Dados.mensagem := 'Falha no acesso ao arquivo referenciado como parâmetro';
   if retorno = 21 then Dados.mensagem := 'Banco inexistente';
   if retorno = 22 then Dados.mensagem := 'Coordenada(s) do campo Valor inválida(s).';
   if retorno = 23 then Dados.mensagem := 'Coordenada(s) do campo Extenso inválida(s).';
   if retorno = 24 then Dados.mensagem := 'Coordenada(s) do campo Favorecido inválida(s).';
   if retorno = 25 then Dados.mensagem := 'Coordenada(s) do campo Cidade inválida(s).';
   if retorno = 26 then Dados.mensagem := 'Coordenada(s) do campo Mensagem inválida(s).';
   if retorno = 27 then Dados.mensagem := 'Coordenada(s) do campo Data inválida(s).';
   if retorno = 28 then Dados.mensagem := 'Valor do campo Espaçamento inválido.';
   if retorno = 29 then Dados.mensagem := 'Erro interno na comunicação com a impressora.';
   if retorno = 34 then Dados.mensagem := 'Cancelamento inválido';
   if retorno = 35 then Dados.mensagem := 'Abertura do dia inválida ';
   if retorno = 36 then Dados.mensagem := 'Alíquota não carregada';
   if retorno = 37 then Dados.mensagem := 'Erro de gravação na memória fiscal';
   if retorno = 38 then Dados.mensagem := 'Número máximo de troca de estabelecimentos alcançado';
   if retorno = 39 then Dados.mensagem := 'Impressora em intervenção técnica';
   if retorno = 40 then Dados.mensagem := 'Memória fiscal desconectada';
   if retorno = 41 then Dados.mensagem := 'Índice de Alíquota inválido';
   if retorno = 42 then Dados.mensagem := 'Não houve desconto anterior';
   if retorno = 43 then Dados.mensagem := 'Desconto inválido';
   if retorno = 45 then Dados.mensagem := 'Violação da memória RAM';
   if retorno = 46 then Dados.mensagem := 'Comando aceito apenas em intervenção técnica';
   if retorno = 48 then Dados.mensagem := 'Fechamento não realizado (Redução Z Pendente)';
   if retorno = 49 then Dados.mensagem := 'Fechamento já realizado';
   if retorno = 50 then Dados.mensagem := 'Comando fora de seqüência';
   if retorno = 51 then Dados.mensagem := 'Comando inexistente';
   if retorno = 52 then Dados.mensagem := 'Timeout de RX';
   if retorno = 54 then Dados.mensagem := 'Valor do desconto inválido';
   if retorno = 55 then Dados.mensagem := 'Alíquota indisponível';
   if retorno = 56 then Dados.mensagem := 'Troca dos dados do clichê apenas após o fechamento';
   if retorno = 57 then Dados.mensagem := 'Memória fiscal cheia';
   if retorno = 58 then Dados.mensagem := 'Troca de situação tributária apenas após fechamento';
   if retorno = 59 then Dados.mensagem := 'Código da mercadoria inválido';
   if retorno = 60 then Dados.mensagem := 'Clichê já impresso';
   if retorno = 61 then Dados.mensagem := 'Acerto do horário de verão permitido apenas após fechamento';
   if retorno = 62 then Dados.mensagem := 'Data/hora não pode ser menor que a data/hora da última gravada na MF';
   if retorno = 63 then Dados.mensagem := 'Falta papel para autenticar documento';
   if retorno = 64 then Dados.mensagem := 'Reservado';
   if retorno = 65 then Dados.mensagem := 'Desconto no subtotal inválido';
   if retorno = 66 then Dados.mensagem := 'Índice inválido';
   if retorno = 67 then Dados.mensagem := 'Forma de pagamento indisponível';
   if retorno = 68 then Dados.mensagem := 'Troca de forma de pagamento apenas após fechamento';
   if retorno = 69 then Dados.mensagem := 'Limite de autenticação alcançado';
   if retorno = 70 then Dados.mensagem := 'Forma de pagamento não cadastrada.';
   if retorno = 71 then Dados.mensagem := 'Papel perto do fim';
   if retorno = 72 then Dados.mensagem := 'Campo do cheque inválido';
   if retorno = 73 then Dados.mensagem := 'Inscrição Estadual ou CGC inválido';
   if retorno = 74 then Dados.mensagem := 'Montante da operação igual a zero';
   if retorno = 75 then Dados.mensagem := 'Falta memória RAM';
   if retorno = 76 then Dados.mensagem := 'Sem cartucho instalado';
   if retorno = 78 then Dados.mensagem := 'Carga dos dados do clichê apenas após a carga do CGC do proprietário';
   if retorno = 79 then Dados.mensagem := 'CPF/CGC inválido';
   if retorno = 80 then Dados.mensagem := 'Cartucho inexistente ou inválido';
   if retorno = 81 then Dados.mensagem := 'Cartucho apenas para leitura';
   if retorno = 82 then Dados.mensagem := 'Mecanismo não selecionado';
   if retorno = 83 then Dados.mensagem := 'Seqüência de pagamento inválida';
   if retorno = 84 then Dados.mensagem := 'Pagamento incompleto';
   if retorno = 85 then Dados.mensagem := 'Troca dos dados cadastrais apenas após fechamento';
   if retorno = 86 then Dados.mensagem := 'Troca do CGC/IE/IM apenas após fechamento';
   if retorno = 87 then Dados.mensagem := 'Cupom totalizado em zero';
   if retorno = 89 then Dados.mensagem := 'Não vinculado indisponível';
   if retorno = 90 then Dados.mensagem := 'Troca Não Vinculado apenas após fechamento';
   if retorno = 91 then Dados.mensagem := 'Erro gravação E2PROM';
   if retorno = 92 then Dados.mensagem := 'Não Vinculado só entrada ou só saída';
   if retorno = 105 then Dados.mensagem := 'Valor do relógio inválido';
   if retorno = 106 then Dados.mensagem := 'Acerto do horário de verão permitido apenas 1 vez ao dia.';
   if retorno = 107 then Dados.mensagem := 'Data inválida';
   if retorno = 108 then Dados.mensagem := 'Cartucho logger cheio';
   if retorno = 109 then Dados.mensagem := 'Impressora não pronta';
   if retorno = 110 then Dados.mensagem := 'Descrição inválida';
   if retorno = 111 then Dados.mensagem := 'Sem papel';
   if retorno = 112 then Dados.mensagem := 'Quantidade inválida';
   if retorno = 113 then Dados.mensagem := 'Valor item inválido';
   if retorno = 114 then Dados.mensagem := 'Problema relógio';
   if retorno = 115 then Dados.mensagem := 'Cheque não posicionado';
   if retorno = 116 then Dados.mensagem := 'Caracter inválido';
   if retorno = 117 then Dados.mensagem := 'Número de Operações excedidas';
   if retorno = 119 then Dados.mensagem := 'Necessita de troca de usuário';
   Result := false;
   if Dados.Mensagem = '' then
      Dados.Mensagem := 'Erro não identificado...';
   onError(' ', inttostr(retorno) + ' - ' + dados.mensagem);
   pronto := true;
end;

////////////////////////////////////////////
function TDefFPrinter.URN_Ret3(retorno: integer): Boolean;
begin
  
   Dados.mensagem := '';
   if (retorno = 0) or (retorno = 33) then begin
      result := True;
      pronto := true;
      exit;
   end;
   if retorno = 1 then Dados.mensagem := 'Comando Invalido para o Device. Erro Interno!';
   if retorno = 2 then Dados.mensagem := 'Impressora esta fora de linha, desligada ou desconectada';
   if retorno = 3 then Dados.mensagem := 'Device Driver ocupado. Erro Interno!';
   if retorno = 4 then Dados.mensagem := 'Comando nao implementado. Erro Interno!';
   if retorno = 5 then Dados.mensagem := 'Erro de Sintaxe em comando. Erro Interno!';
   if retorno = 6 then Dados.mensagem := 'Tempo para execucao do comando esgotado. Timeout';
   if retorno = 7 then Dados.mensagem := 'Parametro invalido passado para a LIB';
   if retorno = 8 then Dados.mensagem := 'LIB ja ativa' + #13 + 'Impressora Desligada ou Fora de Linha';
   if retorno = 9 then Dados.mensagem := 'LIB nao esta ativa ou Porta ocupada';
   if retorno = 10 then Dados.mensagem := 'Device Driver não instalado' + #13 + 'ou' + #13 + 'Não foi possivel inicializar a DLL.';
   if retorno = 11 then Dados.mensagem := 'Banco nao esta cadastrado no arquivo de configuracao';
   if retorno = 12 then Dados.mensagem := 'Coordenadas de Valor nao informadas ou invalida';
   if retorno = 13 then Dados.mensagem := 'Coordenadas de Extenso nao informadas ou invalida';
   if retorno = 14 then Dados.mensagem := 'Coordenadas de Favorecido nao informadas ou invalida';
   if retorno = 15 then Dados.mensagem := 'Coordenadas de Cidade nao informadas ou invalida';
   if retorno = 16 then Dados.mensagem := 'Coordenadas da Data nao informadas ou invalida';
   if retorno = 17 then dados.mensagem := 'Erro de sintaxe em descricao das coordenadas no arquivo';
   if retorno = 18 then dados.mensagem := 'Nao conseguiu acessar arquivo de configuracao';
   if retorno = 32 then dados.mensagem := 'Cancelamento invalido';
   //if retorno = 33 then dados.mensagem := 'Comando OK';
   if retorno = 34 then Dados.mensagem := 'Cancelamento inválido';
   if retorno = 35 then Dados.mensagem := 'Abertura do dia inválida ';
   if retorno = 36 then Dados.mensagem := 'Alíquota não carregada';
   if retorno = 37 then Dados.mensagem := 'Erro de gravação na memória fiscal';
   if retorno = 38 then Dados.mensagem := 'Número máximo de troca de estabelecimentos alcançado';
   if retorno = 39 then Dados.mensagem := 'Erro no byte verificador da memoria fiscal, nescessita intervencao';
   if retorno = 40 then Dados.mensagem := 'Impressora em intervencao';
   if retorno = 41 then Dados.mensagem := 'Memoria fiscal desconectada';
   if retorno = 42 then Dados.mensagem := 'Indice de aliquota invalido';
   if retorno = 43 then Dados.mensagem := 'Nao houve Desconto anterior';
   if retorno = 44 then Dados.mensagem := 'Desconto invalido';
   if retorno = 45 then Dados.mensagem := 'Nao houve acrescimo no subtotal';
   if retorno = 46 then Dados.mensagem := 'Comando aceito apenas em intervenção técnica';
   if retorno = 47 then Dados.mensagem := 'Violacao da memoria RAM';
   if retorno = 48 then Dados.mensagem := 'Comando aceito apenas em intervenção técnica';
   if retorno = 49 then Dados.mensagem := 'Memoria fiscal ja inicializada';
   if retorno = 50 then Dados.mensagem := 'Fechamento nao realizado, necessita reducao Z';
   if retorno = 51 then Dados.mensagem := 'Fechamento ja realizado';
   if retorno = 52 then Dados.mensagem := 'Comando Fora de sequencia';
   if retorno = 54 then Dados.mensagem := 'Nao houve pagamento';
   if retorno = 55 then Dados.mensagem := 'Cupom ja totalizado';
   if retorno = 56 then Dados.mensagem := 'Comando inexistente';
   if retorno = 57 then Dados.mensagem := 'Timeout da imrpessora (RX)';
   if retorno = 59 then Dados.mensagem := 'Nao houve desconto no subtotal';
   if retorno = 61 then Dados.mensagem := 'Valor do desconto invalido';
   if retorno = 63 then Dados.mensagem := 'Cancelamento de cupom invalido';
   if retorno = 65 then Dados.mensagem := 'Atualizacao do horario de verao nao permitida neste horario';
   if retorno = 66 then Dados.mensagem := 'Aliquota indisponivel';
   if retorno = 67 then Dados.mensagem := 'Troca dos dados do cliche apenas apos o fechamento';
   if retorno = 69 then Dados.mensagem := 'Memoria fiscal cheia';
   if retorno = 70 then Dados.mensagem := 'Troca de situacao tributaria somente apos o fechamento';
   if retorno = 71 then Dados.mensagem := 'Codigo de Mercadoria invalido.';
   if retorno = 72 then Dados.mensagem := 'Limite do valor do item ultrapassado';
   if retorno = 73 then Dados.mensagem := 'Cliche ja impressor';
   if retorno = 74 then Dados.mensagem := 'Acerto do horario de verao apenas apos o fechamento';
   if retorno = 75 then Dados.mensagem := 'Acerto do horario de verao permitido apenas uma vez ao dia';
   if retorno = 76 then Dados.mensagem := 'Relogio inconscistente, nescessita intervencao';
   if retorno = 77 then Dados.mensagem := 'Data nao pode ser menor que a ultima gravada na MF';
   if retorno = 78 then Dados.mensagem := 'Registrados indisponivel';
   if retorno = 80 then Dados.mensagem := 'Registrados invalido';
   if retorno = 81 then Dados.mensagem := 'Numero maximo de troca de simbolos de moeda alcancado.';
   if retorno = 82 then Dados.mensagem := 'Falta papel para autenticar o documento';
   if retorno = 83 then Dados.mensagem := 'Nao ha item a descontar.';
   if retorno = 84 then Dados.mensagem := 'transacao inexistente';
   if retorno = 85 then Dados.mensagem := 'Transacao ja cancelada';
   if retorno = 87 then Dados.mensagem := 'Falta papel';
   if retorno = 88 then Dados.mensagem := 'Acrescimo no subtotal invalido';
   if retorno = 89 then Dados.mensagem := 'Desconto no subtotal invalido';
   if retorno = 90 then Dados.mensagem := 'Valor relogio invalido';
   if retorno = 91 then Dados.mensagem := 'Forma de pagamento indisponível' + #13 + 'Tentativa de carga de uma forma de pagamento já carregada.' + #13 + 'O comando não será aceito.' + #13 + 'Uma forma de pagamento somente pode ser alterada após a redução Z em intervenção técnica.';
   if retorno = 92 then Dados.mensagem := 'Reducao nao permitida em intervencao tecnica';
   if retorno = 93 then Dados.mensagem := 'Indice de forma de pagamento invalido';
   if retorno = 94 then Dados.mensagem := 'Forma de pagamento indisponivel';
   if retorno = 95 then Dados.mensagem := 'Troca de forma de pafamento apenas apos o fechamento';
   if retorno = 96 then Dados.mensagem := 'Limite de autenticacao alcancado';
   if retorno = 97 then Dados.mensagem := 'Finalizadora nao habilitada';
   if retorno = 98 then Dados.mensagem := 'valor unitario invalido';
   if retorno = 99 then Dados.mensagem := 'Documento indisponível' + #13 + 'Tentativa de carregar um documento vinculado que já esteja carregado com uma descrição.' + #13 + 'O comando não será aceito.' + #13 + 'A descrição de um documento vinculado já carregado somente pode ser alterada após o fechamento diário (redução Z) e em intervenção técnica.';
   if retorno = 100 then Dados.mensagem := 'Tributo invalido';
   if retorno = 101 then Dados.mensagem := 'Vinculado Nao encontrado';
   if retorno = 102 then Dados.mensagem := 'Indice nao vinculado invalido';
   if retorno = 103 then Dados.mensagem := 'Documento nao vinculado indisponivel';
   if retorno = 104 then Dados.mensagem := 'Troca de documento nao vinculado apenas apos o fechamento';
   if retorno = 105 then Dados.mensagem := 'Vinculado nao encontrado';
   if retorno = 106 then Dados.mensagem := 'Valor da aliquota invalido';
   if retorno = 107 then Dados.mensagem := 'Inscricao estadual ou CGC invalido';
   if retorno = 108 then Dados.mensagem := 'Operacao invalida';
   if retorno = 109 then Dados.mensagem := 'Numero de vinculados por cupom exedido';
   if retorno = 110 then Dados.mensagem := 'Vinculado Cheio';
   if retorno = 111 then Dados.mensagem := 'Acrecimo financeiro nao habilitado';
   Result := false;
   if Dados.Mensagem = '' then
      Dados.Mensagem := 'Erro não identificado...';
   onError(' ', inttostr(retorno) + ' - ' + dados.mensagem);
   pronto := true;
end;

////////////////////////////////////////////
function TDefFPrinter.URN_Ret(retorno: integer): Boolean;
begin

   Dados.mensagem := '';
   if retorno = 0 then begin
      result := True;
      pronto := true;
      exit;
   end;
   if retorno = 1 then Dados.mensagem := 'Comando Invalido para o Device. Erro Interno!';
   if retorno = 2 then Dados.mensagem := 'Impressora esta fora de linha, desligada ou desconectada';
   if retorno = 3 then Dados.mensagem := 'Device Driver ocupado. Erro Interno!';
   if retorno = 4 then Dados.mensagem := 'Comando nao implementado. Erro Interno!';
   if retorno = 5 then Dados.mensagem := 'Erro de Sintaxe em comando. Erro Interno!';
   if retorno = 6 then Dados.mensagem := 'Tempo para execucao do comando esgotado. Timeout';
   if retorno = 7 then Dados.mensagem := 'Parametro invalido passado para a LIB';
   if retorno = 8 then Dados.mensagem := 'LIB ja esta ativa';
   if retorno = 9 then Dados.mensagem := 'LIB nao esta ativa ou Porta ocupada';
   if retorno = 10 then Dados.mensagem := 'Device Driver não instalado' + #13 + 'ou' + #13 + 'Não foi possivel inicializar a DLL.';
   if retorno = 11 then Dados.mensagem := 'Banco nao esta cadastrado no arquivo de configuracao';
   if retorno = 12 then Dados.mensagem := 'Coordenadas de Valor nao informadas ou invalida';
   if retorno = 13 then Dados.mensagem := 'Coordenadas de Extenso nao informadas ou invalida';
   if retorno = 14 then Dados.mensagem := 'Coordenadas de Favorecido nao informadas ou invalida';
   if retorno = 15 then Dados.mensagem := 'Coordenadas de Cidade nao informadas ou invalida';
   if retorno = 16 then Dados.mensagem := 'Coordenadas da Data nao informadas ou invalida';
   if retorno = 17 then Dados.mensagem := 'Erro de sintaxe em descricao das coordenadas no arquivo';
   if retorno = 18 then Dados.mensagem := 'Nao conseguiu acessar arquivo de configuracao';
   if retorno = 32 then Dados.mensagem := 'Cancelamento invalido';
   if retorno = 33 then Dados.mensagem := 'Abertura do dia invalida';
   if retorno = 34 then Dados.mensagem := 'Aliquota nao carregada';
   if retorno = 35 then Dados.mensagem := 'Erro na gravacao da memoria fiscal';
   if retorno = 36 then Dados.mensagem := 'Numero Maximo de Troca de Estabelecimento alcancado';
   if retorno = 37 then Dados.mensagem := 'Erro no Byte Verificador da Memoria Fiscal';
   if retorno = 38 then Dados.mensagem := 'Impressora em intervencao tecnica';
   if retorno = 39 then Dados.mensagem := 'Memoria Fiscal desconectada';
   if retorno = 40 then Dados.mensagem := 'Indice da Aliquota invalido';
   if retorno = 41 then Dados.mensagem := 'Nao houve desconto anterior';
   if retorno = 42 then Dados.mensagem := 'Desconto invalido';
   if retorno = 43 then Dados.mensagem := 'Nao houve acrescimo no subtotal';
   if retorno = 44 then Dados.mensagem := 'Data inicial nao localizada';
   if retorno = 45 then Dados.mensagem := 'Perda da memoria RAM';
   if retorno = 46 then Dados.mensagem := 'Comando aceito apenas em intervencao tecnica';
   if retorno = 47 then Dados.mensagem := 'Valor invalido p/ preenchimento do cheque';
   if retorno = 48 then Dados.mensagem := 'Memoria Fiscal ja inicializada';
   if retorno = 49 then Dados.mensagem := 'Fechamento nao realizado';
   if retorno = 50 then Dados.mensagem := 'Fechamento ja realizado';
   if retorno = 51 then Dados.mensagem := 'Comando fora de sequencia';
   if retorno = 52 then Dados.mensagem := 'Nao comecou a venda';
   if retorno = 53 then Dados.mensagem := 'Nao houve pagamento';
   if retorno = 54 then Dados.mensagem := 'Configuracao permitida apenas apos fechamento';
   if retorno = 55 then Dados.mensagem := 'Cupom ja totalizado';
   if retorno = 56 then Dados.mensagem := 'Comando inexistente';
   if retorno = 57 then Dados.mensagem := 'Impressora retornou timeout RX';
   if retorno = 58 then Dados.mensagem := 'Uso de palavra reservada';
   if retorno = 59 then Dados.mensagem := 'Nao houve desconto no subtotal';
   if retorno = 60 then Dados.mensagem := 'Caracter invalido';
   if retorno = 61 then Dados.mensagem := 'Valor de desconto invalido';
   if retorno = 62 then Dados.mensagem := 'Operacao nao permitida em documento nao fiscal';
   if retorno = 63 then Dados.mensagem := 'Cancelamento de cupom invalido';
   if retorno = 64 then Dados.mensagem := 'Propaganda permitida apenas apos pagamento completo';
   if retorno = 65 then Dados.mensagem := 'Falta inicializar cupom nao fiscal';
   if retorno = 66 then Dados.mensagem := 'Aliquota indisponivel';
   if retorno = 67 then Dados.mensagem := 'Troca de proprietario apenas apos fechamento';
   if retorno = 68 then Dados.mensagem := 'Reducao inicial nao localizada';
   if retorno = 69 then Dados.mensagem := 'Memoria fiscal cheia';
   if retorno = 70 then Dados.mensagem := 'Troca de situacao tributaria apenas apos fechamento';
   if retorno = 71 then Dados.mensagem := 'Codigo de mercadoria invalida';
   if retorno = 72 then Dados.mensagem := 'Limite de valor do item ultrapassado';
   if retorno = 73 then Dados.mensagem := 'Cabecalho ja impresso';
   if retorno = 74 then Dados.mensagem := 'Acerto de horario de verao somente apos fechamento';
   if retorno = 75 then Dados.mensagem := 'Acerto de horario de verao permitido somente 1 vez ao dia';
   if retorno = 76 then Dados.mensagem := 'Relogio inconsistente';
   if retorno = 77 then Dados.mensagem := 'Comando valido apenas para Nota Fiscal';
   if retorno = 78 then Dados.mensagem := 'Impressao de NFVC somente em venda';
   if retorno = 79 then Dados.mensagem := 'Campo ja impresso';
   if retorno = 80 then Dados.mensagem := 'Coordenada invalida';
   if retorno = 81 then Dados.mensagem := 'Registrador invalido';
   if retorno = 82 then Dados.mensagem := 'Nro. maximo de troca de simbolo da moeda alcancado';
   if retorno = 83 then Dados.mensagem := '1EF - Falta papel para autenticacao';
   if retorno = 84 then Dados.mensagem := 'Comando valido apenas para cupom fiscal';
   if retorno = 85 then Dados.mensagem := 'Nao ha item a descontar';
   if retorno = 86 then Dados.mensagem := 'Transacao inexistente';
   if retorno = 87 then Dados.mensagem := 'Transacao ja cancelada';
   if retorno = 88 then Dados.mensagem := 'Memoria fiscal nao apagada';
   if retorno = 89 then Dados.mensagem := 'Faltou papel/impressora nao pronta para imprimir';
   if retorno = 90 then Dados.mensagem := 'Acrescimo no subtotal invalido';
   if retorno = 91 then Dados.mensagem := 'Desconto no subtotal invalido';
   if retorno = 92 then Dados.mensagem := 'Valor do relogio invalido';
   if retorno = 93 then Dados.mensagem := 'Montante da operacao igual a 0 (zero)';
   if retorno = 94 then Dados.mensagem := 'Papel perto do fim';
   if retorno = 95 then Dados.mensagem := 'Nome da moeda nao carregado';
   if retorno = 96 then Dados.mensagem := 'NF - Necessita natureza da operacao';
   if retorno = 97 then Dados.mensagem := 'NF - Necessita configurar formulario';
   if retorno = 98 then Dados.mensagem := 'Intervencao Tecnica';
   // if retorno= #99 then mensagem := 'Em periodo de venda';
   // if retorno= #100 then mensagem := 'Em venda de item';
   // if retorno= #101 then mensagem := 'Em pagamento';
   // if retorno= #102 then mensagem := 'Em comercial';
   // if retorno = #103 then mensagem := 'Esperando fech. do cupom de leitura X ou reducao Z';
   // if retorno = #104 then mensagem := 'Em cupom nao fiscal';
   if retorno = 105 then Dados.mensagem := 'Dia fechado';
   if retorno = 106 then Dados.mensagem := 'impressora nao pronta';
   if retorno = 107 then Dados.mensagem := 'ERRO DESCONHECIDO ';
   if retorno = 108 then Dados.mensagem := 'Impressora retornou caracter desconhecido ';
   Result := false;
   if Dados.Mensagem = '' then Dados.Mensagem := 'Erro não identificado...';
   onError(' ', dados.mensagem);
   pronto := true;
end;

///////////////////////////////////////////////////////
function TDefFPrinter.Bem_proc(data: string): Boolean;
var
   status: string;
   txt: textfile;
   buffer: string;
   ret: integer;
   linha: string;
begin

   pronto := false;
   if copy(data, 1, 2) <> '57' then Buffer := #27 + '|' + trim(data) + '|' + #13 + #27
   else Buffer := #27 + '|' + data + '|' + #27;
   Result := false;
   ret := Bematech_FormataTX(Buffer);
   if ret > 0 then begin
      pronto := true;
      Result := false;
      Dados.Mensagem := 'Problemas na comunicação. Impressora não esta respondendo.';
      if (copy(data, 1, 5) <> '35|01') and (copy(data, 1, 5) <> '35|00') then onError(data, dados.mensagem);
      exit;
   end;
   if fileexists('mp20fi.ret') then begin
      assignfile(txt, 'mp20fi.ret');
      reset(txt);
      readln(txt, linha);
      closefile(txt);
      UltimaResp := linha;
      Result := true;
   end;
   if fileexists('status.ret') then begin
      assignfile(txt, 'status.ret');
      reset(txt);
      readln(txt, status);
      closefile(txt);
      if (trim(copy(status, 12, 80)) <> 'Pouco Papel!') and (status <> '') then begin
         UltimaResp := status;
         if (copy(data, 1, 5) <> '35|01') and (copy(data, 1, 5) <> '35|00') and (copy(data, 1, 2) <> '73') then begin
            onError(data, copy(status, 12, 255));
            Result := false;
         end else Result := true;
      end else Result := true;
   end;
   pronto := true;
end;

///////////////////////////////////////////////////////
function TDefFPrinter.zan_proc(data, param: string): boolean;
var
   Buffer: array[1..200] of char; // buffer da DLL Zanthus
   cmd3: pchar;
   r: char;
   ret: Integer;
   x: integer;
   a: string;
begin

   x := Length(param);
   a := IntToStr(x);
   pronto := false;
   cmd3 := PChar(param);
   if trim(param) <> '' then ret := Zanthus_EnviaComandoComArgumento(data[1], cmd3)
   else ret := Zanthus_EnviaComando(data[1]);
   if ret > 0 then begin
      Result := false;
      Dados.Mensagem := 'Problemas na comunicação. Impressora não esta respondendo.';
      pronto := true;
      if data = '0' then exit;
      onError(data + ' - ' + param, dados.mensagem);
      exit;
   end;
   Zanthus_LeBufferASCII(@buffer);
   ret := Zanthus_LeRetornoASCII();
   UltimaResp := char(ret) + '|' + buffer;
   //
   Result := true;
   r := Ultimaresp[1];
   if r <> '0' then Result := False;
   case r of
      '1': dados.mensagem := 'Comando não pode ser executado no presente estado do modulo fiscal';
      '2': dados.mensagem := 'Argumentos de entrada são inconsistentes';
      '3': dados.mensagem := 'Valor passado é muito elevado';
      '4': dados.mensagem := 'Configuração nao permite esse comando';
      '5': dados.mensagem := 'Memória fiscal esgotada';
      '6': dados.mensagem := 'Memoria fiscal ja inicializada';
      '7': dados.mensagem := 'Falha ao inicializar memoria fiscal';
      '8': dados.mensagem := 'Memoria fiscal ja tem numero de serie';
      '9': dados.mensagem := 'Memória Fiscal não está inicializada.';
      ':': dados.mensagem := 'Falha ao gravar na Memória Fiscal.';
      ';': dados.mensagem := 'Papel no fim.';
      '<': dados.mensagem := 'Falha na impressora.';
      '=': dados.mensagem := 'Memória do Módulo Fiscal violada.';
      '>': dados.mensagem := 'Falta Memória Fiscal.';
      '?': dados.mensagem := 'Comando inexistente.';
      '@': dados.mensagem := 'Deve fazer redução.';
      'A': dados.mensagem := 'Memória do Módulo Fiscal desprotegida (lacre rompido).';
      'B': dados.mensagem := 'Data não permite a operação.';
      'C': dados.mensagem := 'Fim de tabela (de CGC/IE ou de dias).';
      'D': dados.mensagem := 'Dados fixos do Módulo Fiscal estão inconsistentes.';
      'E': dados.mensagem := 'Falha ao configurar dimensões de cheque para impressão';
      'F': dados.mensagem := 'Falha ao imprimir cheque';
      'G': dados.mensagem := 'Falha ao alterar relógio';
      //    'H': dados.mensagem:='Linha não pode ser impressa';
      'I': dados.mensagem := 'Item já foi cancelado';
      'J': dados.mensagem := 'Item não tem descritivo armazenado, ou falta campo para impressão de cheque';
      'K': dados.mensagem := 'Tempo excedido';
      'L': dados.mensagem := 'Módulo Fiscal sem forma de pagamento cadastrada';
      'M': dados.mensagem := 'Versão do Módulo Fiscal difere da gravada na Memória Fiscal (necessita intervenção)';
      'O': dados.mensagem := 'Indica que a mensagem foi recebida com byte de verificação incorreto.';
      'P': dados.mensagem := 'Indica erro nos argumentos passados.';
      'Q': dados.mensagem := 'Indica erro no número de controle da mensagem.';
      'R': dados.mensagem := 'Indica que a resposta recebida não é válida.';
      'S': dados.mensagem := 'Indica que ultrapassou o máximo de tentativas de comunicação com a impressora';
      'T': dados.mensagem := 'Indica falha na transmissão de dados para a impressora.';
      'U': dados.mensagem := 'Indica que ultrapassou tempo máximo de espera de uma resposta da impressora.';
      'V': dados.mensagem := 'Indica que o comando enviado não foi reconhecido pela impressora.';
      'W': dados.mensagem := 'Indica que a impressora deve estar desligada.';
      'X': dados.mensagem := 'Indica que a serial detectou algum erro na recepção (overrun, framing, etc).';
      'Y': dados.mensagem := 'Indica que a resposta recebida está fora do protocolo.';
      'Z': dados.mensagem := 'Indica que o comando foi enviado, mas a resposta foi perdida.';
      '[': dados.mensagem := 'Indica que o comando foi enviado, mas os dados de retorno foram perdidos.';
      'm': dados.mensagem := 'Indica que a operação solicitada não é permitida no dispositivo ECF controlado.';
      'v': dados.mensagem := 'Indica que os parâmetros enviados ao Device Driver então incompletos.';
      'w': dados.mensagem := 'Indica que os parâmetros passados ultrapassaram o tamanho máximo permitido.';
      'x': dados.mensagem := 'Indica que os dados solicitados ultrapassaram o tamanho máximo permitido.';
      'y': dados.mensagem := 'Indica que o banco passado como parâmetro não está na faixa de mb_IconError or mb_OK a 999.';
      'z': dados.mensagem := 'Indica que o banco cujos dados foram solicitados não está cadastrado.';
   end;
   Dados.Mensagem := r + ' : ' + Dados.Mensagem;
   if not Result then begin
      if Dados.Mensagem = '' then Dados.Mensagem := 'Erro não identificado...';
      onError(data + ' - ' + param, dados.mensagem);
   end;
   pronto := true;
end;

////////////////////////////////////////////
function TDefFPrinter.swd_proc(data: string): Boolean;
begin
   Result := False;
end;
////////////////////////////////////////////
function TDefFPrinter.dtr_proc(data: string): Boolean;
var
   a: PChar;
begin
   Pronto := false;
   a := Dataregis_EnviaComando(data);
   Ultimaresp := strpas(a);
   Result := copy(UltimaResp, 1, 1) = '=';
   if copy(UltimaResp, 1, 1) <> '=' then begin
      dados.Mensagem := sepdados(UltimaResp, 2);
      onError(data, sepdados(UltimaResp, 3) + ' - ' + sepdados(UltimaResp, 2));
   end;
   Pronto := true;
end;
///////////////////////////////////////////////////
function TDefFPrinter.LeProComp(iRetorno: Integer; lProcessaRet: Boolean): Boolean;
var ptRetorno: Pointer;
   lRetornou: Boolean;
   dtHoraInicio: TDateTime;
   iTimeOut: Integer;
begin
   Result := (iRetorno = 0);
   if not Result then
      MensagemProcomp(iRetorno)
   else if lProcessaRet then begin
      ptRetorno := AllocMem(255);
      lRetornou := False;
      dtHoraInicio := Now;
      iTimeOut := 60000;
      while not lRetornou do
      begin
         iRetorno := Procomp_ObtemRetorno(ptRetorno);
         if (iRetorno = 0) then begin
//            showmessage(StrPas(ptRetorno)); // Mensagem quando comando OK
            Result := True;
            lRetornou := True;
         end
         else if (iRetorno > 0) or (iRetorno <> -26) then begin
            MensagemProComp(iRetorno);
            Result := False;
            lRetornou := True;
         end;
         // Ultrapassou o time-out de retorno da impressora
         if (Now > (dtHoraInicio + iTimeOut * (1 / 24 / 60 / 60 / 1000))) then begin
            ShowMessage('Erro de comunicação com a impressora fiscal ProComp !');
            Result := False;
            break;
         end;
         Sleep(100);
      end;
      FreeMem(ptRetorno);
   end;
end;
////////////////////////////////////////////////////
procedure TDefFPrinter.MensagemProComp(iRetorno: Integer);
begin
   Dados.Mensagem := '';
   case iRetorno of
      - 1: dados.mensagem := 'Erro genérico na execução da função. Perda de comunicação com a impressora.';
      - 3: dados.mensagem := 'Leitura assincrona em andamento. Comando sendo executado.';
      - 4: dados.mensagem := 'TimeOut na execucao do comando.';
      - 5: dados.mensagem := 'Tamanho da mensagem enviada pela impressora é maior que o buffer de recepção fornecido pela aplicação.';
      - 7: dados.mensagem := 'Erro no arquivo de configuração CIF.INI.';
      - 8: dados.mensagem := 'Falha na abertura da serial.';
      - 11: dados.mensagem := 'Tampa aberta.';
      - 12: dados.mensagem := 'Erro mecânico.';
      - 13: dados.mensagem := 'Erro irrecuperavel.';
      - 14: dados.mensagem := 'Temperatura da cabeça de impressão está alta.';
      - 15: dados.mensagem := 'Pouco papel.';
      - 16: dados.mensagem := 'Em inicio de cupom de venda.';
      - 17: dados.mensagem := 'Em venda de item.';
      - 18: dados.mensagem := 'Em cancelamento de item.';
      - 19: dados.mensagem := 'Em cancelamento de cupom.';
      - 20: dados.mensagem := 'Em fechamento de cupom.';
      - 21: dados.mensagem := 'Em Reducao Z.';
      - 22: dados.mensagem := 'Em Leitura X.';
      - 23: dados.mensagem := 'Em leitura de memória fiscal.';
      - 24: dados.mensagem := 'Em totalização.';
      - 25: dados.mensagem := 'Em pagamento.';
      - 26: dados.mensagem := 'Ainda não obteve retorno.';
      1: dados.mensagem := 'O cabeçalho contém caracteres inválidos.';
      2: dados.mensagem := 'Comando inexistente.';
      3: dados.mensagem := 'Valor não numérico em campo numérico.';
      4: dados.mensagem := 'Valor fora da faixa entre 20h e 7Fh.';
      5: dados.mensagem := 'Campo de iniciar com @, & ou %.';
      6: dados.mensagem := 'Campo de iniciar com $, # ou ?.';
      7: dados.mensagem := 'O intervalo é inconsistente. O primeiro deve menor que o segundo.';
      8: dados.mensagem := 'Tributo inválido.';
      9: dados.mensagem := 'A string TOTAL não é aceita.';
      10: dados.mensagem := 'A sintaxe do comando está errada.';
      11: dados.mensagem := 'Excedeu o número máximo de linhas permitidas pelo comando.';
      12: dados.mensagem := 'O terminador enviado não obedece o protocolo de comunicação.';
      13: dados.mensagem := 'O checksum enviado está incorreto.';
      15: dados.mensagem := 'A situação tributária deve iniciar com T, F ou N.';
      16: dados.mensagem := 'Data inválida.';
      17: dados.mensagem := 'Hora inválida.';
      18: dados.mensagem := 'Aliquota não programada ou fora do intervalo.';
      19: dados.mensagem := 'O campo de sinal está incorreto.';
      20: dados.mensagem := 'Comando só aceito em intervenção fiscal.';
      21: dados.mensagem := 'Comando só aceito em modo normal.';
      22: dados.mensagem := 'Necessário abrir cupom fiscal.';
      23: dados.mensagem := 'Comando não aceito durante cupom fiscal.';
      24: dados.mensagem := 'Necessário abrir cupom não fiscal.';
      25: dados.mensagem := 'Comando não aceito durante cupom não fiscal.';
      26: dados.mensagem := 'O relógio está em horário de verão.';
      27: dados.mensagem := 'O relógio não está em horário de verão.';
      28: dados.mensagem := 'Necessário realizar redução Z.';
      29: dados.mensagem := 'Fechamento do dia (Redução Z) já executado.';
      30: dados.mensagem := 'Necessário programar legenda.';
      31: dados.mensagem := 'Item inexistente ou já cancelado.';
      32: dados.mensagem := 'O cupom anterior não pode ser cancelado.';
      33: dados.mensagem := 'Detectado falta de papel.';
      36: dados.mensagem := 'Necessário programar os dados do estabelecimento.';
      37: dados.mensagem := 'Necessário realizar intervenção técnica.';
      38: dados.mensagem := 'A memória fiscal não permite mais realizar vendas.';
      39: dados.mensagem := 'Ocorreu algum problema na memória fiscal.';
      40: dados.mensagem := 'Necessário programar a data do relógio.';
      41: dados.mensagem := 'Número máximo de ítens por cupom ultrapassado.';
      42: dados.mensagem := 'Já foi realizado o ajuste de hora diário.';
      43: dados.mensagem := 'Comando válido ainda em execução.';
      44: dados.mensagem := 'Está em estado de impressão de cheque.';
      45: dados.mensagem := 'Não está em estado de impressão de cheque.';
      46: dados.mensagem := 'Necessário inserir o cheque.';
      47: dados.mensagem := 'Necessário inserir nova bobina.';
      48: dados.mensagem := 'Necessário executar leitura X.';
      49: dados.mensagem := 'Detectado algum problema na impressora.';
      50: dados.mensagem := 'Cupom já foi totalizado.';
      51: dados.mensagem := 'Necessário totalizar cupom antes de fechar.';
      52: dados.mensagem := 'Necessário finalizar cupom com comando correto.';
      53: dados.mensagem := 'Ocorreu erro de gravação na memória fiscal.';
      54: dados.mensagem := 'Excedeu número máximo de estabelecimentos.';
      55: dados.mensagem := 'Memória fiscal não inicializada completamente.';
      56: dados.mensagem := 'Ultrapassou valor do pagamento.';
      57: dados.mensagem := 'Registrador não programado ou troco já realizado.';
      58: dados.mensagem := 'Falta completar valor do pagamento.';
      59: dados.mensagem := 'Campo somente de caracteres não numéricos.';
      60: dados.mensagem := 'Excedeu campo máximo de caracteres.';
      61: dados.mensagem := 'Troco não realizado.';
      62: dados.mensagem := 'Comando desabilitado.';
   else
      dados.mensagem := 'Erro da impressora fiscal. Retorno desconhecido : ' + IntToStr(iRetorno);
   end;
   if Dados.Mensagem <> '' then onError('', dados.mensagem);
end;
////////////////////////////////////////////////////
function TDefFPrinter.RetornoSchD(retorno: integer): Boolean;
//var
   //mensagem: string;
begin
   result := false;
   if retorno = 00 then begin
      result := true;
      exit;
   end;
   dados.mensagem := 'Erro não documentado';
   if retorno = 01 then dados.mensagem := 'Erro de Checksum';
   if retorno = 02 then dados.mensagem := 'Timeout RX';
   if retorno = 03 then dados.mensagem := 'Memória Insuficiente';
   if retorno = 04 then dados.mensagem := 'Impressora fora de linha ou desligada';
   if retorno = 10 then dados.mensagem := 'Erro de sobreposição';
   if retorno = 11 then dados.mensagem := 'Erro de paridade';
   if retorno = 12 then dados.mensagem := 'Erro de sobreposição e paridade';
   if retorno = 13 then dados.mensagem := 'Erro de formato';
   if retorno = 14 then dados.mensagem := 'Erro de sobreposição e formato';
   if retorno = 15 then dados.mensagem := 'Erro de paridade e sobreposição';
   if retorno = 16 then dados.mensagem := 'Erro de sobreposição, paridade e formato';
   if retorno = 65 then dados.mensagem := 'Em venda';
   if retorno = 66 then dados.mensagem := 'Limite de cabeçalho alcançado';
   if retorno = 68 then dados.mensagem := 'Cabeçalho impresso';
   if retorno = 69 then dados.mensagem := 'Não começou venda';
   if retorno = 70 then dados.mensagem := 'Valor inválido';
   if retorno = 73 then dados.mensagem := 'Valor a menor';
   if retorno = 74 then dados.mensagem := 'Valor a maior';
   if retorno = 78 then dados.mensagem := 'Número máximo de Reduções Z alcançado';
   if retorno = 79 then dados.mensagem := 'Erro de comunicação';
   if retorno = 80 then dados.mensagem := 'Palavra reservada';
   if retorno = 81 then dados.mensagem := 'Papel próximo do fim';
   if retorno = 82 then dados.mensagem := 'Data não localizada';
   if retorno = 84 then dados.mensagem := 'Erro de memória fiscal';
   if retorno = 85 then dados.mensagem := 'Perda da RAM';
   if retorno = 86 then dados.mensagem := 'Não houve pagamento';
   if retorno = 87 then dados.mensagem := 'Cupom já totalizado';
   if retorno = 88 then dados.mensagem := 'Não pode cancelar venda';
   if retorno = 89 then dados.mensagem := 'Comando não completo';
   if retorno = 90 then dados.mensagem := 'Cupom aberto';
   if retorno = 91 then dados.mensagem := 'Não há cupom a cancelar';
   if retorno = 92 then dados.mensagem := 'Tabela de taxa não inicializada';
   if retorno = 94 then dados.mensagem := 'Seleção de taxa inválida';
   if retorno = 95 then dados.mensagem := 'Cancelamento inválido';
   if retorno = 96 then dados.mensagem := 'Nada a retificar';
   if retorno = 97 then dados.mensagem := 'Redução não localizada';
   if retorno = 98 then dados.mensagem := 'Cabeçalho não carregado';
   if retorno = 99 then dados.mensagem := 'Impressora em intervenção técnica';
   if retorno = 100 then dados.mensagem := 'Impressora em período de venda';
   if retorno = 101 then dados.mensagem := 'Somente com intervenção técnica';
   if retorno = 102 then dados.mensagem := 'Desconto inválido';
   if retorno = 103 then dados.mensagem := 'Limite de linhas alcançado';
   if retorno = 104 then dados.mensagem := 'Somente após o total';
   if retorno = 105 then dados.mensagem := 'Dados inválidos';
   if retorno = 106 then dados.mensagem := 'Alteração de taxa não disponível';
   if retorno = 107 then dados.mensagem := 'Comando inválido';
   if retorno = 108 then dados.mensagem := 'Não houve o fechamento do dia';
   if retorno = 109 then dados.mensagem := 'Erro irrecuperável';
   if retorno = 110 then dados.mensagem := 'Alteração inválida';
   if retorno = 111 then dados.mensagem := 'Data já alterada';
   if retorno = 112 then dados.mensagem := 'Alíquota não carregada';
   if retorno = 113 then dados.mensagem := 'Fechamento diário não realizado';
   if retorno = 114 then dados.mensagem := 'Abertura do dia inválida';
   if retorno = 115 then dados.mensagem := 'Fechamento já realizado';
   if retorno = 116 then dados.mensagem := 'Ajuste somente de +/- 1 horal';
   if retorno = 117 then dados.mensagem := 'Acréscimo inválido';
   if retorno = 118 then dados.mensagem := 'Pagamento incompleto';
   if retorno = 121 then dados.mensagem := 'Erro de gravação na memória fiscal';
   if retorno = 126 then dados.mensagem := 'Comando fora de seqüência';
   if retorno = 127 then dados.mensagem := 'Autenticação sem papel';
   if retorno = 132 then dados.mensagem := 'Queda de energia';
   if retorno = 133 then dados.mensagem := 'Data inválida';
   if retorno = 134 then dados.mensagem := 'Item fora da faixa';
   if retorno = 135 then dados.mensagem := 'Item não vendido';
   if retorno = 136 then dados.mensagem := 'Parâmetro errado';
   if retorno = 137 then dados.mensagem := 'Limite de valor ultrapassado';
   if retorno = 138 then dados.mensagem := 'Relogio interno da impressora Desativado';
   if retorno = 139 then dados.mensagem := 'Finalizadora nao cadastrada';
   if retorno = 142 then dados.mensagem := 'Posição já programada';
   if retorno = 143 then dados.mensagem := 'Posição inexistente';
   if retorno = 144 then dados.mensagem := 'Cupom não fiscal pendente';
   if retorno = 146 then dados.mensagem := 'Não há nenhum comprovante vinculado pendente';
   if retorno = 606 then dados.mensagem := 'Não foi possível setar os parâmetros configuráveis da porta serial';
   if retorno = 707 then dados.mensagem := 'Não foi possível programar os parâmetros setados referentes à porta serial';
   if retorno = 808 then dados.mensagem := 'Não foi possível limpar a fila de transmissão';
   if retorno = 809 then dados.mensagem := 'Não foi possível limpar a fila de recepção';
   if retorno = 909 then dados.mensagem := 'Ocorreu um erro na programação interna dos timeouts da porta serial';
   if retorno = 1010 then dados.mensagem := 'A porta serial requisitada está bloqueada por outro aplicativo';
   if retorno = 2323 then dados.mensagem := 'Ocorreu um problema desconhecido na recepção de retorno simples da impressora';
   onError('(???)', IntToStr(retorno) + ' - ' + dados.mensagem);
end;
////////////////////////////////////////////////////
function TDefFPrinter.retsch2(retorno: integer): Boolean;
//var
   //mensagem: string;
begin
   result := false;
   if retorno = 00 then begin
      result := true;
      exit;
   end;
   dados.mensagem := 'Erro não documentado';
   case retorno of
      01: dados.mensagem := 'Erro de checksum';
      02: dados.mensagem := 'Timeout RX';
      03: dados.mensagem := 'Memória insuficiente';
      04: dados.mensagem := 'Impressora fora de linha ou desligada';
      10: dados.mensagem := 'Erro de sobreposição';
      11: dados.mensagem := 'Erro de paridade';
      12: dados.mensagem := 'Erro de sobreposição e paridade';
      13: dados.mensagem := 'Erro de formato';
      14: dados.mensagem := 'Erro de sobreposição e formato';
      15: dados.mensagem := 'Erro de paridade e sobreposição';
      16: dados.mensagem := 'Erro de sobreposição, paridade e formato';
      65: dados.mensagem := 'Em venda';
      66: dados.mensagem := 'Limite de cabeçalho alcançado';
      68: dados.mensagem := 'Cabeçalho impresso';
      69: dados.mensagem := 'Não começou venda';
      70: dados.mensagem := 'Valor inválido';
      73: dados.mensagem := 'Valor a menor';
      74: dados.mensagem := 'Valor a maior';
      78: dados.mensagem := 'Número máximo de Reduções Z alcançado';
      79: dados.mensagem := 'Erro de comunicação';
      80: dados.mensagem := 'Palavra reservada';
      81: dados.mensagem := 'Papel próximo do fim';
      82: dados.mensagem := 'Data não localizada';
      84: dados.mensagem := 'Erro de memória fiscal';
      85: dados.mensagem := 'Perda da RAM';
      86: dados.mensagem := 'Não houve pagamento';
      87: dados.mensagem := 'Cupom já totalizado';
      88: dados.mensagem := 'Não pode cancelar venda';
      89: dados.mensagem := 'Comando não completo';
      90: dados.mensagem := 'Cupom aberto';
      91: dados.mensagem := 'Não há cupom a cancelar';
      92: dados.mensagem := 'Tabela de taxa não inicializada';
      94: dados.mensagem := 'Seleção de taxa inválida';
      95: dados.mensagem := 'Cancelamento inválido';
      96: dados.mensagem := 'Nada a retificar';
      97: dados.mensagem := 'Redução não localizada';
      98: dados.mensagem := 'Cabeçalho não carregado';
      99: dados.mensagem := 'Impressora em intervenção técnica';
      100: dados.mensagem := 'Impressora em período de venda';
      101: dados.mensagem := 'Somente com intervenção técnica';
      102: dados.mensagem := 'Desconto inválido';
      103: dados.mensagem := 'Limite de linhas alcançado';
      104: dados.mensagem := 'Somente após o total';
      105: dados.mensagem := 'Dados inválidos';
      106: dados.mensagem := 'Alteração de taxa não disponível';
      107: dados.mensagem := 'Comando inválido';
      108: dados.mensagem := 'Não houve o fechamento do dia';
      109: dados.mensagem := 'Erro irrecuperável';
      110: dados.mensagem := 'Alteração inválida';
      111: dados.mensagem := 'Data já alterada';
      112: dados.mensagem := 'Alíquota não carregada';
      113: dados.mensagem := 'Fechamento diário não realizado';
      114: dados.mensagem := 'Abertura do dia inválida';
      115: dados.mensagem := 'Fechamento já realizado';
      116: dados.mensagem := 'Ajuste somente de +/- 1 hora';
      117: dados.mensagem := 'Acréscimo inválido';
      118: dados.mensagem := 'Pagamento incompleto';
      121: dados.mensagem := 'Erro de gravação na memória fiscal';
      126: dados.mensagem := 'Comando fora de seqüência';
      127: dados.mensagem := 'Autenticação sem papel';
      132: dados.mensagem := 'Queda de energia';
      133: dados.mensagem := 'Data inválida';
      134: dados.mensagem := 'Item fora da faixa';
      135: dados.mensagem := 'Item não vendido';
      136: dados.mensagem := 'Parâmetro errado';
      137: dados.mensagem := 'Limite de valor ultrapassado';
      606: dados.mensagem := 'Não foi possível setar os parâmetros configuráveis da porta serial';
      707: dados.mensagem := 'Não foi possível programar os parâmetros setados referentes à porta serial';
      808: dados.mensagem := 'Não foi possível limpar a fila de transmissão';
      809: dados.mensagem := 'Não foi possível limpar a fila de recepção';
      909: dados.mensagem := 'Ocorreu um erro na programação interna dos timeouts da porta serial';
      1010: dados.mensagem := 'A porta serial requisitada está bloqueada por outro aplicativo';
      2323: dados.mensagem := 'Ocorreu um problema desconhecido na recepção de retorno simples da impressora';
   end;
   onError('(???)', IntToStr(retorno) + ' - ' + dados.mensagem);
end;
////////////////////////////////////////////////////
function TDefFPrinter.NCR_proc(data: string): Boolean;
var
   rsp: array[1..1024] of char;
   ret: Integer;
begin
   pronto := false;
   Result := True;
   FillChar(rsp, SizeOf(rsp), ' ');
   data := data + Chr(13) + Chr(0);
   ret := NCR_SendCmd(data, @rsp, 1024);
   if (ret < 0) and (copy(data, 1, 2) <> '38') and
      (copy(data, 1, 2) <> '46') and // Le versao da eprom
      (copy(data, 1, 2) <> '49') and // Le versao da eprom nas novas
      (copy(data, 1, 2) <> '01') then begin // Abre dia fiscal
      dados.Mensagem := 'Impressora não esta repondendo.';
      onError(data, dados.mensagem);
      result := false;
      pronto := true;
      exit;
   end;
   UltimaResp := rsp;
   if rsp <> '' then begin
      //Result := true;
      Dados.Mensagem := '';
   end;
   if copy(data, 1, 2) = '11' then begin
      if (impressora = NCR2x) or (impressora = NCR7141) then begin
         ValorCupom := sepdados(rsp, 2);
         dados.seqfinal := IntToStr(strtointdef(copy(sepdados(rsp, 1), 2, 6), 0) - 1);
      end;
      pronto := true;
      //Result := true;
   end;
   //   if (copy(data, 1, 2) = '19') then sleep(2000);
   if copy(data, 1, 2) = '30' then begin
      if (impressora = NCR2x) or (impressora = NCR7141) then begin
         ValorCupom := sepdados(rsp, 2);
         dados.seqfinal := IntToStr(strtointdef(copy(sepdados(rsp, 1), 2, 6), 0) - 1);
      end;
      pronto := true;
      //Result := true;
      exit;
   end;
   if copy(data, 1, 2) = '31' then begin
      if rsp[3] = '1' then status.GavetaAberta := true else status.GavetaAberta := false;
      if rsp[5] = '1' then status.CupomAberto := true else status.CupomAberto := false;
      if rsp[10] = '0' then status.FimDePapel := true else status.CupomAberto := false;
      if rsp[4] = '1' then status.DiaAberto := true else status.DiaAberto := false;
      pronto := true;
      //Result := true;
      exit;
   end;
   if copy(data, 1, 2) = '33' then begin
      dados.dataimp := copy(rsp, 1, 6);
      dados.horaimp := copy(rsp, 7, 4);
      pronto := true;
      //Result := true;
      exit;
   end;
   if copy(data, 1, 2) = '37' then begin
      dados.Loja := IntToStr(strtointdef(sepdados(rsp, 1), 0));
      dados.caixa := IntToStr(strtointdef(sepdados(rsp, 2), 0));
      dados.Operador := IntToStr(strtointdef(sepdados(rsp, 3), 0));
      pronto := true;
      //Result := true;
      exit;
   end;
   if copy(data, 1, 2) = '38' then begin
      if impressora = NCR1x then begin
         dados.NumCanc := sepdados(rsp, 3);
         dados.ValorDesc := sepdados(rsp, 47);
         dados.ValorAcres := sepdados(rsp, 48);
         dados.ValorCanc := sepdados(rsp, 49);
         dados.GTInicial := sepdados(rsp, 6);
         dados.GTFinal := sepdados(rsp, 1);
         dados.seqini := sepdados(rsp, 7);
         dados.seqfinal := IntToStr(strtointdef(sepdados(rsp, 2), 0) - 2);
         Tributacao.NaoTributado := sepdados(rsp, 37);
         Tributacao.FSubst := sepdados(rsp, 38);
         tributacao.FIsento := sepdados(rsp, 39);
         Tributacao.Aliquota01 := sepdados(rsp, 20);
         Tributacao.Aliquota02 := sepdados(rsp, 21);
         Tributacao.Aliquota03 := sepdados(rsp, 22);
         Tributacao.Aliquota04 := sepdados(rsp, 23);
         Tributacao.Aliquota05 := sepdados(rsp, 24);
         Tributacao.Aliquota06 := sepdados(rsp, 25);
         Tributacao.Aliquota07 := sepdados(rsp, 26);
         Tributacao.Aliquota08 := sepdados(rsp, 27);
         Tributacao.Aliquota09 := sepdados(rsp, 28);
      end;
      if (impressora = NCR2x) or (impressora = NCR7141) then begin
         dados.NumCanc := sepdados(rsp, 3);
         dados.ValorCanc := sepdados(rsp, 49);
         dados.ValorDesc := sepdados(rsp, 50);
         dados.ValorAcres := sepdados(rsp, 51);
         dados.GTInicial := sepdados(rsp, 7);
         dados.GTFinal := sepdados(rsp, 1);
         dados.seqini := sepdados(rsp, 8);
         dados.seqfinal := IntToStr(strtointdef(sepdados(rsp, 2), 0) - 1);
         Tributacao.FSubst := sepdados(rsp, 40);
         tributacao.FIsento := sepdados(rsp, 41);
         Tributacao.NaoTributado := sepdados(rsp, 42);
         Tributacao.Aliquota01 := sepdados(rsp, 22);
         Tributacao.Aliquota02 := sepdados(rsp, 23);
         Tributacao.Aliquota03 := sepdados(rsp, 24);
         Tributacao.Aliquota04 := sepdados(rsp, 25);
         Tributacao.Aliquota05 := sepdados(rsp, 26);
         Tributacao.Aliquota06 := sepdados(rsp, 27);
         Tributacao.Aliquota07 := sepdados(rsp, 28);
         Tributacao.Aliquota08 := sepdados(rsp, 29);
         Tributacao.Aliquota09 := sepdados(rsp, 30);
      end;
      pronto := true;
      //Result := true;
      exit;
   end;
   if copy(data, 1, 2) = '39' then begin
      dados.Reducoes := sepdados(rsp, 1);
      ValorCupom := sepdados(rsp, 11);
      pronto := true;
      //Result := true;
      exit;
   end;
   if copy(data, 1, 2) = '45' then begin
      dados.Serial := copy(rsp, 1, 11);
      pronto := true;
      //Result := true;
      exit;
   end;
   if copy(data, 1, 2) = '46' then begin
      Eprom := sepdados(rsp, 4);
      eprom := copy(eprom, 1, 2) + '.' + copy(eprom, 3, 2);
      pronto := true;
      //Result := true;
      exit;
   end;
   if copy(data, 1, 2) = '49' then begin
      eprom := copy(rsp, 1, 2) + '.' + copy(rsp, 3, 2);
      pronto := true;
      //Result := true;
      exit;
   end;
   //
   //
   if copy(rsp, 1, 1) = '=' then begin
      pronto := true;
      //Result := true;
      exit;
   end;
   if copy(rsp, 1, 1) = '' then Dados.Mensagem := 'Impressora nao esta respondendo';
   if copy(rsp, 1, 1) = '!' then Dados.Mensagem := 'Hora / Data não inicializadas';
   if copy(rsp, 1, 1) = '"' then Dados.Mensagem := 'Fim do Papel';
   if copy(rsp, 1, 1) = '#' then Dados.Mensagem := 'Inicialização incompleta';
   if copy(rsp, 1, 1) = '$' then Dados.Mensagem := 'Números não permitidos neste campo';
   if copy(rsp, 1, 1) = '%' then Dados.Mensagem := 'Função não permitida sem inicio de operação Fiscal';
   if copy(rsp, 1, 1) = '&' then Dados.Mensagem := 'Valor da venda maior que o permitido';
   if copy(rsp, 1, 1) = #39 then Dados.Mensagem := 'Time-out na Comunicação com o Impressor';
   if copy(rsp, 1, 1) = '(' then Dados.Mensagem := 'Impressão abortada pelo usuário';
   if copy(rsp, 1, 1) = ')' then Dados.Mensagem := 'Memória Fiscal Esgotada';
   if copy(rsp, 1, 1) = '*' then Dados.Mensagem := 'Não há reduções no intervalo pedido';
   if copy(rsp, 1, 1) = '+' then Dados.Mensagem := 'Tamanho Máximo do Valor Inválido';
   if copy(rsp, 1, 1) = ',' then Dados.Mensagem := 'DSR desabilitado na transmissão do Impressor';
   if copy(rsp, 1, 1) = '-' then Dados.Mensagem := 'Sem papel na Autenticação';
   if copy(rsp, 1, 1) = '.' then Dados.Mensagem := 'DSR desabilitado na transmissão para o PC';
   if copy(rsp, 1, 1) = '/' then Dados.Mensagem := 'Data menor que a da Memória Fiscal';
   if copy(rsp, 1, 1) = '0' then Dados.Mensagem := 'Caracter inválido na tabela de Tributações Reservada';
   if copy(rsp, 1, 1) = '1' then Dados.Mensagem := 'Tabela Totalizadores Reservados não inicializada';
   if copy(rsp, 1, 1) = '2' then Dados.Mensagem := 'Tabela de Tributações Válidas não inicializada';
   if copy(rsp, 1, 1) = '3' then Dados.Mensagem := 'Função não permitida após o Início do Dia';
   if copy(rsp, 1, 1) = '4' then Dados.Mensagem := 'Constantes não inicializadas';
   if copy(rsp, 1, 1) = '5' then Dados.Mensagem := 'CNPJ e Inscrição Estadual não inicializadas.';
   if copy(rsp, 1, 1) = '6' then Dados.Mensagem := 'Identificação da Moeda não inicializada';
   if copy(rsp, 1, 1) = '7' then Dados.Mensagem := 'Numero de dígitos do valor não inicializado';
   if copy(rsp, 1, 1) = '8' then Dados.Mensagem := 'Tabela de Alíquotas não inicializada';
   if copy(rsp, 1, 1) = '9' then Dados.Mensagem := 'Não é permitido o Reinicio do Dia após Redução Z';
   if copy(rsp, 1, 1) = ':' then Dados.Mensagem := 'Pagamento excedeu o total da venda';
   if copy(rsp, 1, 1) = ';' then Dados.Mensagem := 'Reservado para uso futuro';
   if copy(rsp, 1, 1) = '<' then Dados.Mensagem := 'Reservado para uso futuro';
   if copy(rsp, 1, 1) = '>' then Dados.Mensagem := 'Reservado para uso futuro';
   if copy(rsp, 1, 1) = '?' then Dados.Mensagem := 'Reservado para uso futuro';
   if copy(rsp, 1, 1) = '@' then Dados.Mensagem := 'Reservado para uso futuro';
   if copy(rsp, 1, 1) = 'A' then Dados.Mensagem := 'Função não permitida após totalização';
   if copy(rsp, 1, 1) = 'B' then Dados.Mensagem := 'Desconto sem venda ou não permitido nesta condição';
   if copy(rsp, 1, 1) = 'C' then Dados.Mensagem := 'Valor do desconto de item maior ou igual ao valor do item';
   if copy(rsp, 1, 1) = 'D' then Dados.Mensagem := 'Cancelamento sem venda ou não permitido nesta condição';
   if copy(rsp, 1, 1) = 'E' then Dados.Mensagem := 'Valor do cancelamento diferente do valor apurado';
   if copy(rsp, 1, 1) = 'F' then Dados.Mensagem := 'Mais de um desconto aplicado. Venda não pode ser cancelada';
   if copy(rsp, 1, 1) = 'G' then Dados.Mensagem := 'Cancelamento de desconto sem desconto aplicado';
   if copy(rsp, 1, 1) = 'H' then Dados.Mensagem := 'Total da operação igual a zero';
   if copy(rsp, 1, 1) = 'I' then Dados.Mensagem := 'Valor do desconto em subtotal maior ou igual ao valor da venda';
   if copy(rsp, 1, 1) = 'J' then Dados.Mensagem := 'Venda de produto com valor igual a zero';
   if copy(rsp, 1, 1) = 'K' then Dados.Mensagem := 'Valor total informado diferente do valor apurado';
   if copy(rsp, 1, 1) = 'L' then Dados.Mensagem := 'Não são permitidos mais comentários';
   if copy(rsp, 1, 1) = 'M' then Dados.Mensagem := 'Função não permitida sem início de operação Fiscal ou Não Fiscal';
   if copy(rsp, 1, 1) = 'N' then Dados.Mensagem := 'Não há cupom para autenticar';
   if copy(rsp, 1, 1) = 'O' then Dados.Mensagem := 'Função não permitida sem totalização';
   if copy(rsp, 1, 1) = 'P' then Dados.Mensagem := 'Memória fiscal não disponível';
   if copy(rsp, 1, 1) = 'Q' then Dados.Mensagem := 'Mensagem inválida';
   if copy(rsp, 1, 1) = 'R' then Dados.Mensagem := 'Equipamento necessita Intervenção Técnica';
   if copy(rsp, 1, 1) = 'S' then Dados.Mensagem := 'Não há mais espaço para esta alteração na EPROM';
   if copy(rsp, 1, 1) = 'T' then Dados.Mensagem := 'Função não permitida sem status de intervenção';
   if copy(rsp, 1, 1) = 'U' then Dados.Mensagem := 'Campo numérico inválido';
   if copy(rsp, 1, 1) = 'V' then Dados.Mensagem := 'Função inexistente';
   if copy(rsp, 1, 1) = 'W' then Dados.Mensagem := 'Função não permitida sem início do Dia';
   if copy(rsp, 1, 1) = 'X' then Dados.Mensagem := 'Hora / Data inválida';
   if copy(rsp, 1, 1) = 'Y' then Dados.Mensagem := 'Função não permitida durante operação Fiscal ou Não Fiscal';
   if copy(rsp, 1, 1) = 'Z' then Dados.Mensagem := 'Função não permitida com status de intervenção';
   if copy(rsp, 1, 1) = '[' then Dados.Mensagem := 'Tabela Tributações não Sujeitas ao ICMS não inicializada';
   if copy(rsp, 1, 1) = '\' then Dados.Mensagem := 'Necessita Redução Z';
   if copy(rsp, 1, 1) = ']' then Dados.Mensagem := 'Palavra de uso exclusivo do firmware fiscal';
   if copy(rsp, 1, 1) = '^' then Dados.Mensagem := 'Situação tributaria inválida';
   if copy(rsp, 1, 1) = '_' then Dados.Mensagem := 'Erro no calculo do valor total do item';
   if copy(rsp, 1, 1) = 'a' then Dados.Mensagem := 'Comprovante Pendente.';
   if copy(rsp, 1, 1) = ' ' then Dados.Mensagem := 'Impressora  não responde ( Desligada ou Cabo serial desconectado)';
   if (copy(data, 1, 2) = '07') or (copy(data, 1, 2) = '01') then begin
      Result := false;
      pronto := true;
      exit;
   end;
   dados.mensagem := '"' + copy(rsp, 1, 1) + '" - ' + dados.mensagem;
   onError(data, dados.mensagem);
   Result := false;
   pronto := true;
end;

function TDefFPrinter.LenNum(Numero: Real): Integer;
var
   cNumero: string;
begin
   cNumero := FormatFloat('0.000E+00', Numero);
   Result := StrToInt(Copy(cNumero, Length(cNumero) - 1, 2)) + 1
   {FloatToStrF(Numero; ffExponent; 14,2)}
end;

function TDefFPrinter.Extenso(pValor: Real): string;

var
   nParte1, nParte2: Comp;
   xExt1, xExt2, xJuncao: string;

begin
   nParte1 := Int(pValor);
   nParte2 := Round((pValor - nParte1) * 100);
   xExt1 := fExtenso(nParte1);
   xExt2 := fExtenso(nParte2);
   if ((Length(xExt1) = 0) and (Length(xExt2) = 0))
      then xExt1 := 'ZERO';

   if xExt1 = 'UM'
      then xExt1 := xExt1 + ' REAL'
   else if xExt1 <> '' then xExt1 := xExt1 + ' REAIS';

   if Length(xExt2) > 0
      then
      if xExt2 = 'UM'
         then xExt2 := xExt2 + ' CENTAVO'
      else xExt2 := xExt2 + ' CENTAVOS';

   if ((Length(xExt1) = 0) or (Length(xExt2) = 0))
      then xJuncao := ''
   else xJuncao := ' E ';

   Result := xExt1 + xJuncao + xExt2;

end;

function TDefFPrinter.fExtenso(nValor: Real): string;

const
   aExSP: array[1..8] of string = ('', ' MIL', ' MILHOES', ' BILHOES', ' TRILHOES',
      'QUATRILHOES', ' QUINQUALHOES', ' SEXTALHOES');
   aExSS: array[1..8] of string = ('', ' MIL', ' MILHAO ', ' BILHAO ', ' TRILHAO ',
      ' QUATRILHAO ', ' QUINQUALHAO ', ' SEXTALHAO');
var

   NumGrupos, n, nn: Integer;
   cValor, tExtenso, xExtenso, cGrupo: string;

begin
   NumGrupos := ((LenNum(nValor) + 2) div 3);
   cValor := zcomp(FloattoStr(nValor), NumGrupos * 3);
   tExtenso := '';
   xExtenso := '';

   for n := 1 to NumGrupos do
   begin
      cGrupo := Copy(cValor, n * 3 - 2, 3);
      xExtenso := ExtensoMil(cGrupo);
      nn := NumGrupos - n + 1;
      if Length(xExtenso) > 0
         then
      begin
         if cGrupo = '001'
            then xExtenso := xExtenso + aExSS[nn]
         else xExtenso := xExtenso + aExSP[nn];
         if Length(tExtenso) > 0
            then tExtenso := tExtenso + ' ';
         tExtenso := tExtenso + xExtenso;
      end;

   end;

   Result := tExtenso;
end;

function TDefFPrinter.ExtensoMil(cVlr: string): string;

const
   aExp: array[1..37] of string = (
      'UM', 'DOIS', 'TRES', 'QUATRO', 'CINCO', 'SEIS', 'SETE', 'OITO', 'NOVE', 'DEZ',
      'ONZE', 'DOZE', 'TREZE', 'QUATORZE', 'QUINZE', 'DEZESSEIS', 'DEZESSETE',
      'DEZOITO', 'DEZENOVE', 'VINTE', 'TRINTA', 'QUARENTA', 'CINQUENTA', 'SESSENTA',
      'SETENTA', 'OITENTA', 'NOVENTA', 'CEM', 'DUZENTOS', 'TREZENTOS', 'QUATROCENTOS',
      'QUINHENTOS', 'SEISCENTOS', 'SETECENTOS', 'OITOCENTOS', 'NOVECENTOS', 'CENTO'
      );

var
   c1, c2, c3: string;
   e1, e2, e3, cJuncao1, cJuncao2: string;
   n1, n2, n3, n23: Integer;

begin
   c1 := Copy(cVlr, 1, 1); c2 := Copy(cVlr, 2, 1); c3 := Copy(cVlr, 3, 1);
   n1 := StrToInt(c1); n2 := StrToInt(c2); n3 := StrToInt(c3);
   e1 := ''; e2 := ''; e3 := '';
   n23 := StrToInt(c2 + c3);
   if n1 > 0
      then
      if ((n1 = 1) and ((n2 + n3) > 0))
         then e1 := aExP[37]
      else e1 := aExp[27 + n1];
   if n2 > 1
      then begin
      e2 := aExp[18 + n2];
      if n3 > 0
         then e3 := aExp[n3];
   end
   else begin
      e2 := '';
      if n23 > 0
         then e3 := aExp[n23];
   end;
   if ((n1 = 0) or (n23 = 0))
      then cJuncao1 := ''
   else cJuncao1 := ' E ';
   if ((Length(e2) = 0) or (Length(e3) = 0))
      then cJuncao2 := ''
   else cJuncao2 := ' E ';
   Result := e1 + cJuncao1 + e2 + cJuncao2 + e3;
end;
///////////////////////////////////////////////
function TDefFPrinter.MyStrToInt(strValue : String) : Integer;
begin
   if Trim(strValue) = '' then
     begin
      Result := 0;
      Exit;
     end;

   try
     Result := StrToInt(strValue);
   except
     Result := 0;
   end;
end;
///////////////////////////////////////////////
function TDefFPrinter.returnNumber(text:string):String;
var
  i : Integer;
begin
  i:=1;
  while i <= length(text) do
     begin
     if not (text[i] in ['0'..'9']) then
        Delete(text, i, 1);
     inc(i);
     end;
  Result := text;
end;
///////////////////////////////////////////////
function TDefFPRinter.IncChar(S: string; const Len: Integer; Car, LR : Char):String;
var
  Q, LenS: Integer;
begin
  LenS := Length(S);
  if LenS < Len then
    for Q := 1 to Len - LenS do
      if LR = 'L' then
         S := Car + S
      else
         S := S + Car;
  Result := S;
end;
///////////////////////////////////////////////
function TDefFPrinter.zcomp(data: string; Tam: integer): string;
begin
   data := trim(data);
   if Length(data) = tam then Result := data else begin
      data := StringOfChar('0', 50) + trim(data);
      Result := copy(data, Length(data) - (tam - 1), tam);
   end;
end;
///////////////////////////////////////////////////////////////
function TDefFPrinter.ParseParam(Parametros, Parametro: String): String;
var
  p: integer;
  Temp: String;

begin

  p := Pos(UpperCase(Parametro), UpperCase(Parametros));

  if p = 0 then
    Result := ''
  else
    begin
      // Achou, corto até antes do nome do parametro
      Temp := copy(Parametros, p, Length(Parametros)-p+1);

      // Procuro pelo igual e corto tb
      p := Pos('=', UpperCase(Temp)) + 1;
      Temp := copy(Temp, p, Length(Temp)-p+1);

      // Pego até o ponto e vígula
      p := Pos(';', UpperCase(Temp));
      if p <> 0 then
        Temp := copy(Temp, 1, p-1);

      Result := Trim(Temp);
    end;
end;
///////////////////////////////////////////////
function TDefFPrinter.scomp(data: string; Tam: integer): string;
begin
   data := trim(data);
   if Length(data) = tam then Result := data else begin
      data := StringOfChar(' ', 50) + trim(data);
      Result := copy(data, Length(data) - (tam - 1), tam);
   end;
end;
///////////////////////////////////////////////
function TDefFPrinter.sdcomp(data: string; Tam: integer): string;
begin
   Result := copy(data + space(tam), 1, tam);
end;
////////////////////////////////////////////
function TDefFPrinter.space(val: Integer): string;
begin
   Result := StringOfChar(' ', val);
end;
/////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.sepdados(dados: string; item_a_retornar: Integer): string;
var
   items: array[1..100] of string;
   x: integer;
   aitem: Integer;
begin
   aitem := 1;
   for x := 1 to length(dados) do if dados[x] = '\' then inc(aitem) else items[aitem] := items[aitem] + dados[x];
   result := items[item_a_retornar];
end;
///////////////////////////////////////////////
function TDefFPrinter.tiravg(data: string): string;
var
   x: integer;
   a: string;
begin
   a := '';
   for x := 1 to length(data) do if (copy(data, x, 1) <> ',') then a := a + copy(data, x, 1);
   Result := trim(a);
end;
/////////////////////////////////////////////////
function TDefFPRinter.nmmes(dados: string): string;
var
   x: integer;
begin
   result := '';
   x := strtointdef(dados, 0);
   if x = 1 then result := 'Janeiro';
   if x = 2 then result := 'Fevereiro';
   if x = 3 then result := 'Marco';
   if x = 4 then result := 'Abril';
   if x = 5 then result := 'Maio';
   if x = 6 then result := 'Junho';
   if x = 7 then result := 'Julho';
   if x = 8 then result := 'Agosto';
   if x = 9 then result := 'Setembro';
   if x = 10 then result := 'Outubro';
   if x = 11 then result := 'Novembro';
   if x = 12 then result := 'Dezembro';
end;
////////////////////////////////////////////
function TDefFPrinter.CheckCPF(cpf: string): Boolean;
var
   soma: Integer;
   dg1, dg2: Integer;
begin
   result := false;
   if cpf = '' then exit;
   soma := 0;
   soma := soma + strtointdef(cpf[1], 0) * 10;
   soma := soma + strtointdef(cpf[2], 0) * 9;
   soma := soma + strtointdef(cpf[3], 0) * 8;
   soma := soma + strtointdef(cpf[4], 0) * 7;
   soma := soma + strtointdef(cpf[5], 0) * 6;
   soma := soma + strtointdef(cpf[6], 0) * 5;
   soma := soma + strtointdef(cpf[7], 0) * 4;
   soma := soma + strtointdef(cpf[8], 0) * 3;
   soma := soma + strtointdef(cpf[9], 0) * 2;
   dg1 := soma - ((soma div 11) * 11);
   if dg1 <= 1 then dg1 := 0 else dg1 := 11 - dg1;
   soma := 0;
   soma := soma + strtointdef(cpf[1], 0) * 11;
   soma := soma + strtointdef(cpf[2], 0) * 10;
   soma := soma + strtointdef(cpf[3], 0) * 9;
   soma := soma + strtointdef(cpf[4], 0) * 8;
   soma := soma + strtointdef(cpf[5], 0) * 7;
   soma := soma + strtointdef(cpf[6], 0) * 6;
   soma := soma + strtointdef(cpf[7], 0) * 5;
   soma := soma + strtointdef(cpf[8], 0) * 4;
   soma := soma + strtointdef(cpf[9], 0) * 3;
   soma := soma + (2 * dg1);
   dg2 := soma - ((soma div 11) * 11);
   if dg2 <= 1 then dg2 := 0 else dg2 := 11 - dg2;
   result := true;
   if (inttostr(dg1) <> cpf[10]) or (inttostr(dg2) <> cpf[11]) then result := false;
end;
////////////////////////////////////////////
function TDefFPRinter.CheckCGC(cgc: string): Boolean;
var
   soma: Integer;
   dg1, dg2: Integer;
begin
   Result := false;
   if cgc = '' then exit;
   soma := 0;
   soma := soma + strtointdef(cgc[1], 0) * 5;
   soma := soma + strtointdef(cgc[2], 0) * 4;
   soma := soma + strtointdef(cgc[3], 0) * 3;
   soma := soma + strtointdef(cgc[4], 0) * 2;
   soma := soma + strtointdef(cgc[5], 0) * 9;
   soma := soma + strtointdef(cgc[6], 0) * 8;
   soma := soma + strtointdef(cgc[7], 0) * 7;
   soma := soma + strtointdef(cgc[8], 0) * 6;
   soma := soma + strtointdef(cgc[9], 0) * 5;
   soma := soma + strtointdef(cgc[10], 0) * 4;
   soma := soma + strtointdef(cgc[11], 0) * 3;
   soma := soma + strtointdef(cgc[12], 0) * 2;
   dg1 := soma - ((soma div 11) * 11);
   if dg1 <= 1 then dg1 := 0 else dg1 := 11 - dg1;
   soma := 0;
   soma := soma + strtointdef(cgc[1], 0) * 6;
   soma := soma + strtointdef(cgc[2], 0) * 5;
   soma := soma + strtointdef(cgc[3], 0) * 4;
   soma := soma + strtointdef(cgc[4], 0) * 3;
   soma := soma + strtointdef(cgc[5], 0) * 2;
   soma := soma + strtointdef(cgc[6], 0) * 9;
   soma := soma + strtointdef(cgc[7], 0) * 8;
   soma := soma + strtointdef(cgc[8], 0) * 7;
   soma := soma + strtointdef(cgc[9], 0) * 6;
   soma := soma + strtointdef(cgc[10], 0) * 5;
   soma := soma + strtointdef(cgc[11], 0) * 4;
   soma := soma + strtointdef(cgc[12], 0) * 3;
   soma := soma + 2 * dg1;
   dg2 := soma - ((soma div 11) * 11);
   if dg2 <= 1 then dg2 := 0 else dg2 := 11 - dg2;
   result := true;
   if (inttostr(dg1) <> cgc[13]) or (inttostr(dg2) <> cgc[14]) then result := false;
end;
////////////////////////////////////////////////////////////////////////
function TDefFPrinter.iif(cond: boolean; se_verdadeiro: string; se_falso: string): string;
begin
   if cond then result := se_verdadeiro else result := se_falso;
end;
///////////////////////////////////////////////
function TDefFPRinter.tiramsc(data: string): string;
var
   x: integer;
begin
   result := '';
   for x := 1 to length(data) do if (data[x] in ['0'..'9']) then Result := Result + copy(data, x, 1);
end;
/////////////////////////////////////////////////////
function TDefFPRinter.NCRCHQLAY(banco: integer): string;
begin
   Result := '2056\68\';
   if Banco = 1 then Result := '2056\68\';
   if Banco = 3 then Result := '2062\70\';
   if Banco = 4 then Result := '2058\69\';
   if Banco = 6 then Result := '2052\68\';
   if Banco = 8 then Result := '2049\63\';
   if Banco = 22 then Result := '2066\70\';
   if Banco = 27 then Result := '2066\72\';
   if Banco = 28 then Result := '2068\71\';
   if Banco = 29 then Result := '2068\71\';
   if Banco = 31 then Result := '2060\70\';
   if Banco = 33 then Result := '2063\70\';
   if Banco = 34 then Result := '2060\70\';
   if Banco = 37 then Result := '2067\74\';
   if Banco = 38 then Result := '2050\65\';
   if Banco = 39 then Result := '2060\72\';
   if Banco = 41 then Result := '2070\74\';
   if Banco = 48 then Result := '2055\71\';
   if Banco = 70 then Result := '2067\74\';
   if Banco = 104 then Result := '2055\67\';
   if Banco = 106 then Result := '2068\71\';
   if Banco = 151 then Result := '2067\74\';
   if Banco = 152 then Result := '2067\74\';
   if Banco = 153 then Result := '2068\71\';
   if Banco = 168 then Result := '2062\70\';
   if Banco = 215 then Result := '2062\70\';
   if Banco = 230 then Result := '2062\70\';
   if Banco = 231 then Result := '2068\74\';
   if Banco = 237 then Result := '2060\67\';
   if Banco = 244 then Result := '2065\67\';
   if Banco = 275 then Result := '2060\66\';
   if Banco = 282 then Result := '2060\70\';
   if Banco = 291 then Result := '2058\67\';
   if Banco = 294 then Result := '2067\74\';
   if Banco = 302 then Result := '2067\74\';
   if Banco = 308 then Result := '2067\74\';
   if Banco = 320 then Result := '2060\70\';
   if Banco = 334 then Result := '2060\70\';
   if Banco = 341 then Result := '2064\68\';
   if Banco = 344 then Result := '2070\74\';
   if Banco = 346 then Result := '2070\74\';
   if Banco = 347 then Result := '2068\71\';
   if Banco = 353 then Result := '2068\74\';
   if Banco = 356 then Result := '2068\73\';
   if Banco = 369 then Result := '2060\70\';
   if Banco = 370 then Result := '2068\74\';
   if Banco = 372 then Result := '2066\70\';
   if Banco = 376 then Result := '2068\74\';
   if Banco = 388 then Result := '2068\70\';
   if Banco = 389 then Result := '2065\67\';
   if Banco = 392 then Result := '2066\70\';
   if Banco = 394 then Result := '2070\74\';
   if Banco = 399 then Result := '2055\67\';
   if Banco = 409 then Result := '2061\68\';
   if Banco = 415 then Result := '2060\63\';
   if Banco = 420 then Result := '2060\69\';
   if Banco = 422 then Result := '2060\69\';
   if Banco = 424 then Result := '2060\69\';
   if Banco = 434 then Result := '2064\74\';
   if Banco = 453 then Result := '2064\74\';
   if Banco = 456 then Result := '2064\74\';
   if Banco = 472 then Result := '2064\70\';
   if Banco = 477 then Result := '2064\70\';
   if Banco = 479 then Result := '2064\74\';
   if Banco = 483 then Result := '2060\72\';
   if Banco = 487 then Result := '2066\70\';
   if Banco = 494 then Result := '2060\70\';
   if Banco = 498 then Result := '2060\70\';
   if Banco = 602 then Result := '2060\70\';
   if Banco = 605 then Result := '2067\74\';
   if Banco = 745 then Result := '2058\66\';
end;
/////////////////////////////////////////////////////
function TDefFPRinter.ZNTCHQLAY(banco: integer): string;
var
   mat: array[1..69] of string;
   x: Integer;
begin
   mat[1] := '00010713171701019010306601050750106075010802927170100000000000000';
   mat[2] := '00030713171701020010306301040770107077010802824180100000000000000';
   mat[3] := '00040713171701019010306201040750106075010803127180100000000000000';
   mat[4] := '00060713171701019010306201040750106075010703127180100000000000000';
   mat[5] := '00080713171702020010406301050750107075010802825160200000000000000';
   mat[6] := '00220713171701021020306701040730106073010802926190300000000000000';
   mat[7] := '00270713171701021020306401040740107074010803027170100000000000000';
   mat[8] := '00280713171701020010306301040750107075010903127180100000000000000';
   mat[9] := '00290713171701020010306401040730106073010802724150100000000000000';
   mat[10] := '00310713171701020010306201040740106074010703127180100000000000000';
   mat[11] := '00330713171701021020406101040740106074010803330200200000000000000';
   mat[12] := '00340713171701021020406301050740107074010803128170100000000000000';
   mat[13] := '00370713171701021020306601040760107076010803228190100000000000000';
   mat[14] := '00380713171701020010306901040760106076010803027190200000000000000';
   mat[15] := '00390713171701021020305601040760106076010703128180100000000000000';
   mat[16] := '00410713171702020010406601050750108075010902623140100000000000000';
   mat[17] := '00480713171701021020306901040770106077010703430180300000000000000';
   mat[18] := '00700713171701021020306601040760107076010803228190100000000000000';
   mat[19] := '01040713171701019010306201050760107076010802622130100000000000000';
   mat[20] := '01060713171701021020306401040750107075010802926180400000000000000';
   mat[21] := '01510713171701021020306601040760107076010803228190100000000000000';
   mat[22] := '01520713171701021020306601040760107076010803228090100000000000000';
   mat[23] := '01530713171701019010406501050750108075010902926140100000000000000';
   mat[24] := '01680713171701019010306401040730106073010702526160200000000000000';
   mat[25] := '02150713171701019010306701050750107075010802925170100000000000000';
   mat[26] := '02300713171701020010306801050760107076010802623160100000000000000';
   mat[27] := '02310713171701019010306701040760106076010803229190500000000000000';
   mat[28] := '02370713171701020010406701050760107076070803127160200000000000000';
   mat[29] := '02440713171702022030406301050760108076010903128200400000000000000';
   mat[30] := '02750713171701021010307201050770107077010803127160200000000000000';
   mat[31] := '02820713171701019010306701050770107077010802825160100000000000000';
   mat[32] := '02910713171701026050306301040760107076150803430210500000000000000';
   mat[33] := '02940713171701020010306801040760106076010702724150100000000000000';
   mat[34] := '03020713171701021030306701040760107076010803228190100000000000000';
   mat[35] := '03080713171702019010306401050740107074010803128180200000000000000';
   mat[36] := '03200713171701019010307101040770106077010703126170100000000000000';
   mat[37] := '03340713171701019010306601040760106076010702623140100000000000000';
   mat[38] := '03410713171701019010406501060750107075010902925150200000000000000';
   mat[39] := '03440713171701021020306601050750107075010802825160100000000000000';
   mat[40] := '03460713171701018010306301040730107073010802824160200000000000000';
   mat[41] := '03470713171701023040306701050750107075010803027190500000000000000';
   mat[42] := '03530713171701020010307101040770106077010702723161100000000000000';
   mat[43] := '03560713171701020010306301040750107075010803229190200000000000000';
   mat[44] := '03690713171701021020306501040770106077010703027160100000000000000';
   mat[45] := '03700713171701019010306701040750107075010803227160100000000000000';
   mat[46] := '03720713171701020020306501040750106075010802926160100000000000000';
   mat[47] := '03760713171701019010306601050750107075010802624170100000000000000';
   mat[48] := '03880713171701020010306301040750107075010803127180100000000000000';
   mat[49] := '03890713171701019010406501060760108076010902924160100000000000000';
   mat[50] := '03920713171701019010306701040750106075010802823150100000000000000';
   mat[51] := '03940713171701020010306701040760107076010902825160100000000000000';
   mat[52] := '03990713171701020010306801040770106077010702723150200000000000000';
   mat[53] := '04090713171701020010306701050740107074010802925160200000000000000';
   mat[54] := '04150713171702020010406201050720107072010802926160200000000000000';
   mat[55] := '04200713171701019010306501040750106075010703026160100000000000000';
   mat[56] := '04220713171701020010306501050750107075010802523170100000000000000';
   mat[57] := '04240713171701019010306501040770106077010703229180300000000000000';
   mat[58] := '04340713171701021020306601040770107077010803228190100000000000000';
   mat[59] := '04530713171701019010306301040750107075010802724150100000000000000';
   mat[60] := '04560713171701019010306401040750107075010803128170200000000000000';
   mat[61] := '04720713171701020010306301040750107075010803127180100000000000000';
   mat[62] := '04770713171702019010306501050740107074010802926160100000000000000';
   mat[63] := '04790713171701019010306501040760107076010803228190400000000000000';
   mat[64] := '04830713171701019010306601040770106077010703228150100000000000000';
   mat[65] := '04870713171701021020305401040700106070080803229180200000000000000';
   mat[66] := '04940713171701019010306201040740106074010703127180100000000000000';
   mat[67] := '04980713171701021020306301040740106074010703128170100000000000000';
   mat[68] := '06020713171701021020306201040760106076010702824170100000000000000';
   mat[69] := '06050713171701021020306401040760106076010802925160100000000000000';
   for x := 1 to 69 do if banco = strtointdef(copy(mat[x], 1, 4), 0) then Result := mat[x];
   if Result = '' then Result := mat[1];
end;
///////////////////////////////////////////////
function TDefFPrinter.ptov(data: string): string;
var
   x: integer;
   a: string;
begin
   a := '';
   for x := 1 to length(data) do if data[x] = '.' then a := a + ',' else a := a + data[x];
   Result := trim(a);
end;
////////////////////////////////////////
procedure TDefFPrinter.TablePack(Table: TTable);
var
   TBDesc: CRTblDesc;
   hDb: hDbiDb;
   TablePath: array[0..dbiMaxPathLen] of char;
begin
   FillChar(TBDesc, Sizeof(TBDesc), 0);
   with TBDesc do begin
      StrPCopy(szTblName, Table.TableName);
      StrPCopy(szTblType, szParadox);
      bPack := True;
   end;
   hDb := nil;
   Check(DbiGetDirectory(Table.DBHandle, True, TablePath));
   Table.Close;
   Check(DbiOpenDatabase(nil, 'STANDARD', dbiReadWrite, dbiOpenExcl, nil, 0, nil, nil, hDb));
   Check(DbiSetDirectory(hDb, TablePath));
   Check(DBIDoRestructure(hDb, 1, @TBDesc, nil, nil, nil, False));
   Table.Open;
end;
////////////////////////////////////////////
function TDefFPrinter.AbreComunicacao: Boolean;
var
   Txt: textfile;
   iPortResult : Integer;
begin
   Result := false;
   if not CarregaECF then exit;
   try
      case Impressora of
         None: Result := false;
         Sweda03, Sweda10: // fprint1
            begin
              iPortResult := Sweda_AbrePortaSerial;
              if ((iPortResult = 0) or (iPortResult = -27)) then
                Result := False
              else
                Result := True;
            end;
         NCR2x, NCR1x, NCR7141: // fprint2
            begin
               case PortaSerial of
                  1: Result := NCR_setcomport(1) = 0;
                  2: Result := NCR_setcomport(2) = 0;
                  3: Result := NCR_setcomport(3) = 0;
                  4: Result := NCR_setcomport(4) = 0;
               end;
               //Result := true;
            end;
         Urano2EFE: // fprint3
            begin
               Result := Urano2EFE_IniciaImpressora(pchar('COM' + IntToStr(PortaSerial))) = 0;
            end;
         ZanthusIZ11, ZanthusIZ10, Zanthus2e,
            ZanthusIZ20, ZanthusIZ21, ZanthusIZ41: // fprint 4
            begin
               Result := Zanthus_InicializaPortaSerial(PortaSerial) = 0;
            end;
         BematechMP40, BematechMP20, BematechTermica: // fprint5
            begin
              Result := (Bematech_IniPortaStr('COM' + IntToStr(PortaSerial))<>0);
            end;
         Schalter3D: // fprint6
            begin
               Result := Schalter3D_ChangePort(PortaSerial - 1) = PortaSerial - 1;
            end;
         Urano1FIT: begin // fprint7
               Result := urn_ret2(Urano1FIT_InicializaDLL(pchar('COM' + IntToStr(PortaSerial))));
            end;
         Urano1EFC, Urano2EFC: // fprint8
            begin
               Result := UranoEFC_InicializaDLL(pchar('COM' + IntToStr(PortaSerial))) = 0;
            end;
         Schalter2S: // fprint9
            begin
               case PortaSerial of
                  1: Schalter2S_ChangePort(0);
                  2: Schalter2S_ChangePort(1);
                  3: Schalter2S_ChangePort(2);
                  4: Schalter2S_ChangePort(3);
               end;
               Result := true;
            end;
         SCFI:
            begin
               case PortaSerial of
                  0: SCFI_ChangePort(0);
                  1: SCFI_ChangePort(1);
                  2: SCFI_ChangePort(2);
                  3: SCFI_ChangePort(3);
               end;
               Result := true;
            end;
         Dataregis: begin // fprint10
               Result := Dataregis_AbrePorta(PortaSerial) = 0;
            end;
         Procomp_2011: begin // fprint11
               assignfile(Txt, 'cif.ini');
               rewrite(Txt);
               writeln(Txt, '[PORT]');
               writeln(Txt, 'COM=' + IntToStr(portaserial));
               closefile(Txt);
               Result := LeProComp(Procomp_OpenCIF, False);
            end;
         Trends10E: begin // fprint12
               assignfile(Txt, 'TRDECF32.CFG');
               rewrite(Txt);
               writeln(Txt, '[PORT]');
               writeln(Txt, 'COM=' + IntToStr(portaserial));
               closefile(Txt);
               Result := true;
            end;
        AFRAC: // fprint5
        begin
          Result := (AFRAC_AbrirPorta(PChar('COM' + IntToStr(PortaSerial)))<>0);
        end;
        Elgin: // fprint13
        begin
          Result := (Elgin_AbrePortaSerial = 1);
        end;
      end;

   except
      Result := false;
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////
function TDefFPrinter.FechaComunicacao: Boolean;
begin

   Result := False;

   case Impressora of
      None: exit;
      Dataregis: Result := Dataregis_Fechaporta = 0;

      Sweda03, Sweda10:
      begin
        iRetorno := Sweda_FechaPortaSerial;
        Analisa_iRetorno();
        Result := (iRetorno=1);
      end;

      NCR2x, NCR1x, NCR7141: if NCR_setcomport(0) = 0 then Result := true else Result := false;
      Urano2EFE: Result := Urano2EFE_finalizaimpressora = 0;
      Urano1EFC, Urano2EFC: Result := UranoEFC_Finalizadll = 0;
      Urano1FIT: Result := Urano1FIT_FinalizaDLL = 0;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41: Zanthus_FechaPortaSerial;
      Schalter3D: Schalter3D_Changeport(-1);
      Schalter2S: Result := retsch2(Schalter2S_Changeport(-1));
      SCFI: SCFI_Changeport(-1);

      BematechMP40, BematechMP20, BematechTermica:
      begin
        iRetorno := Bematech_FechaPorta;
        Analisa_iRetorno();
        Result:= (iRetorno=1);
      end;

      Elgin:
      begin
        iRetorno := Elgin_FechaPortaSerial;
        Analisa_iRetorno();
        Result:= (iRetorno=1);
      end;

      Procomp_2011: Result := LeProComp(Procomp_CloseCIF, False);
   end;

   case Impressora of
      Trends10E, Dataregis, Procomp_2011,
         Sweda03, Sweda10,
         Urano2EFE, Urano1FIT, Urano1EFC, Urano2EFC,
         Schalter3D, Schalter2S, SCFI,
         Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41, ZanthusIZ11, ZanthusIZ10,
         BematechMP40, BematechMP20, BematechTermica, Elgin,
         Ncr1x, NCR2x, NCR7141, AFRAC:
         begin
            freelibrary(HandleDLL);
            Result := true;
         end;
   end;


end;
////////////////////////////////////////////
function TDefFPrinter.AtualizaDados: Boolean;
var
   x: Integer;
begin
   Result := false;
   case Impressora of
      None: exit;
      Dataregis: begin
            Result := Dtr_proc('gSS');
            if not Result then exit;
            dados.Dataimp := sepdados(UltimaResp, 2);
            dados.Horaimp := sepdados(UltimaResp, 3);
            dados.loja := sepdados(UltimaResp, 4);
            dados.caixa := sepdados(UltimaResp, 5);
            dados.Operador := sepdados(UltimaResp, 6);
            dados.SeqIni := sepdados(UltimaResp, 7);
            dados.seqfinal := IntToStr(strtointdef(sepdados(UltimaResp, 8), 1) - 1);
            dados.Reducoes := sepdados(UltimaResp, 9);
            dados.NumCanc := sepdados(UltimaResp, 10);
            dados.GTInicial := sepdados(UltimaResp, 11);
            dados.GTFinal := sepdados(UltimaResp, 12);
            // venda bruta 13
            dados.ValorCanc := sepdados(UltimaResp, 14);
            dados.ValorDesc := sepdados(UltimaResp, 15);
            Dados.ValorAcres := sepdados(UltimaResp, 16);
            // dados.Serial foi colocado no atualiza eprom
         end;
      Sweda03:
         begin
            result := swd_proc(#27 + '.28}');
            if Result then begin
               Dados.Caixa := copy(UltimaResp, 95, 3);
               Dados.dataimp := copy(UltimaResp, 44, 6);
               Dados.horaimp := copy(UltimaResp, 50, 4);
            end else exit;
            //
            Result := swd_proc(#27 + '.271}');
            if Result then begin
               Dados.SeqFinal := IntToStr(strtointdef(copy(UltimaResp, 14, 4), 0) - 1); // Cupom Final
               Dados.Reducoes := copy(UltimaResp, 41, 4); // Contador de reducoes
               Dados.NumCanc := copy(Ultimaresp, 73, 4); // Número de cancelamentos (qtdade)
               Dados.ValorCanc := inttostr(strtointdef(copy(Ultimaresp, 77, 12), 0) + strtointdef(copy(Ultimaresp, 61, 12), 0)); // Total  de cancelamentos (moeda)
               Dados.ValorDesc := copy(Ultimaresp, 93, 12); // Total de Descontos
               Dados.GTFinal := copy(Ultimaresp, 21, 16); // Grande total (gt atual)
               Dados.GTInicial := zcomp(inttostr(strtointdef(Dados.GtFinal, 0) - strtointdef(copy(Ultimaresp, 45, 12), 0)), 16); // Gt Inicial
            end else exit;
            //
            Result := swd_proc(#27 + '.272}');
            if Result then begin
               dados.serial := copy(UltimaResp, 8, 11); // Total Isento
            end;
            //
            Result := swd_proc(#27 + '.279}');
            if Result then begin
               Dados.SeqIni := copy(Ultimaresp, 108, 4); //Cupon Inicial sweda
               Dados.ValorAcres := copy(Ultimaresp, 92, 12); // Total de Acrescimo
            end;
         end;
      Sweda10:
         begin
            result := swd_proc(#27 + '.28}');
            if Result then begin
               Dados.Caixa := copy(UltimaResp, 93, 3);
               Dados.dataimp := copy(UltimaResp, 47, 6);
               Dados.horaimp := copy(UltimaResp, 53, 4);
            end else exit;
            //
            Result := swd_proc(#27 + '.271}');
            if Result then begin
               Dados.SeqFinal := IntToStr(strtointdef(copy(UltimaResp, 14, 4), 0) - 1); // Cupom Final
               Dados.Reducoes := copy(UltimaResp, 41, 4); // Contador de reducoes
               Dados.NumCanc := copy(Ultimaresp, 73, 4); // Número de cancelamentos (qtdade)
               Dados.ValorCanc := inttostr(strtointdef(copy(Ultimaresp, 77, 12), 0) + strtointdef(copy(Ultimaresp, 61, 12), 0)); // Total  de cancelamentos (moeda)
               Dados.ValorDesc := copy(Ultimaresp, 93, 12); // Total de Descontos
               Dados.GTFinal := copy(Ultimaresp, 21, 16); // Grande total (gt atual)
               Dados.GTInicial := zcomp(inttostr(strtointdef(Dados.GtFinal, 0) - strtointdef(copy(Ultimaresp, 45, 12), 0)), 16); // Gt Inicial
            end else exit;
            //
            Result := swd_proc(#27 + '.273}');
            if Result then begin
               dados.serial := copy(Ultimaresp, 13, 9);
            end;
            //
            Result := swd_proc(#27 + '.27F}');
            if Result then begin
               Dados.ValorAcres := copy(Ultimaresp, 12, 12); // Total de Acrescimo
            end;
            //
            Result := swd_proc(#27 + '.27G}');
            if Result then begin
               Dados.SeqIni := copy(Ultimaresp, 8, 4); //Cupon Inicial sweda
               eprom := copy(Ultimaresp, 28, 5); // Versao da emprom
            end;
         end;
      NCR1x:
         begin
            sleep(1000);
            Result := NCR_Proc('33');
            sleep(350);

            Result := NCR_Proc('37');
            sleep(350);

            Result := NCR_Proc('38');
            sleep(350);

            Result := NCR_Proc('39');
            sleep(200);

            Result := NCR_Proc('45');
            sleep(200);
         end;
      NCR2x:
         begin
            sleep(1000);
            Result := NCR_Proc('33');
            sleep(350);
            Result := NCR_Proc('37');
            sleep(350);
            Result := NCR_Proc('38');
            sleep(350);
            Result := NCR_Proc('39');
            sleep(200);
            Result := NCR_Proc('45');
            sleep(200);
         end;
      NCR7141:
         begin
            sleep(1000);
            Result := NCR_Proc('33');
            sleep(350);
            Result := NCR_Proc('37');
            sleep(350);
            Result := NCR_Proc('38');
            sleep(350);
            Result := NCR_Proc('39');
            sleep(200);
            Result := NCR_Proc('45');
            sleep(200);
         end;
      Urano2EFE:
         begin
            StrCopy(@s1, '0');
            result := Urn_ret(Urano2EFE_LeRegistradores('49', @s1));
            vol := trim(StrPas(@s1));
            Dados.dataimp := copy(vol, 1, 2) + copy(vol, 4, 2) + copy(vol, 7, 2);
            //
            Urano2EFE_LeRegistradores('50', @s1);
            vol := trim(StrPas(@s1));
            Dados.horaimp := copy(vol, 1, 2) + copy(vol, 4, 2);
            //
            //LeRegistradores('75',@s1);dados.loja:=trim(StrPas(@s1));
            //LeRegistradores('',@s1);dados.Operador:=trim(StrPas(@s1));
            Urano2EFE_LeRegistradores('47', @s1); dados.serial := tiramsc(StrPas(@s1));
            Urano2EFE_LeRegistradores('48', @s1); dados.caixa := trim(StrPas(@s1));
            Urano2EFE_LeRegistradores('39', @s1); dados.SeqIni := IntToStr(strtointdef(tiramsc(StrPas(@s1)), 0));
            Urano2EFE_LeRegistradores('40', @s1); dados.seqfinal := IntToStr(strtointdef(tiramsc(StrPas(@s1)), 0) - 1);
            Urano2EFE_LeRegistradores('46', @s1); dados.Reducoes := tiramsc(StrPas(@s1));
            Urano2EFE_LeRegistradores('43', @s1); dados.NumCanc := tiramsc(StrPas(@s1));
            Urano2EFE_LeRegistradores('54', @s1); dados.GTInicial := tiramsc(StrPas(@s1));
            Urano2EFE_LeRegistradores('01', @s1); dados.GTFinal := tiramsc(StrPas(@s1));
            Urano2EFE_LeRegistradores('02', @s1); dados.ValorCanc := tiramsc(StrPas(@s1));
            Urano2EFE_LeRegistradores('03', @s1); dados.ValorDesc := tiramsc(StrPas(@s1));
            Urano2EFE_LeRegistradores('04', @s1); dados.ValorDesc := IntToStr(strtointdef(dados.ValorDesc, 0) + strtointdef(tiramsc(StrPas(@s1)), 0));
            Urano2EFE_LeRegistradores('05', @s1); dados.ValorAcres := tiramsc(StrPas(@s1));
         end;
      Urano1EFC, Urano2EFC:
         begin
            StrCopy(@s1, '0');
            result := Urn_ret3(UranoEFC_LeRegistradores('27', @s1));
            vol := trim(StrPas(@s1));
            Dados.dataimp := copy(vol, 1, 2) + copy(vol, 4, 2) + copy(vol, Length(vol) - 1, 2);
            //
            UranoEFC_LeRegistradores('28', @s1);
            vol := trim(StrPas(@s1));
            Dados.horaimp := copy(vol, 1, 2) + copy(vol, 4, 2);
            //
            //LeRegistradores('75',@s1); dados.loja:=trim(StrPas(@s1));
            //LeRegistradores('',@s1); dados.Operador:=trim(StrPas(@s1));
            UranoEFC_LeRegistradores('25', @s1); dados.serial := tiramsc(StrPas(@s1));
            UranoEFC_LeRegistradores('26', @s1); dados.caixa := tiramsc(StrPas(@s1));
            UranoEFC_LeRegistradores('17', @s1); dados.SeqIni := IntToStr(strtointdef(tiramsc(StrPas(@s1)), 0));
            UranoEFC_LeRegistradores('24', @s1); dados.Reducoes := tiramsc(StrPas(@s1));
            UranoEFC_LeRegistradores('21', @s1); dados.NumCanc := tiramsc(StrPas(@s1));
            UranoEFC_LeRegistradores('32', @s1); dados.GTInicial := tiramsc(StrPas(@s1));
            UranoEFC_LeRegistradores('01', @s1); dados.GTFinal := tiramsc(StrPas(@s1));
            UranoEFC_LeRegistradores('02', @s1); dados.ValorCanc := tiramsc(StrPas(@s1));
            UranoEFC_LeRegistradores('03', @s1); dados.ValorDesc := tiramsc(StrPas(@s1));
            UranoEFC_LeRegistradores('04', @s1); dados.ValorDesc := IntToStr(strtointdef(dados.ValorDesc, 0) + strtointdef(tiramsc(StrPas(@s1)), 0));
            UranoEFC_LeRegistradores('05', @s1); dados.ValorAcres := tiramsc(StrPas(@s1));
            UranoEFC_LeRegistradores('18', @s1); dados.seqfinal := IntToStr(strtointdef(tiramsc(StrPas(@s1)), 0) - 1);
         end;
      Urano1FIT:
         begin
            Result := false;
            x := 0;
            while (Result = false) and (x < 3) do begin
               inc(x);
               StrCopy(@s1, '0');
               result := Urn_ret2(Urano1FIT_LeRegistradores('063', @s1)); vol := trim(StrPas(@s1));
               Dados.dataimp := copy(vol, 1, 2) + copy(vol, 4, 2) + copy(vol, Length(vol) - 1, 2);
               //
               Urn_ret2(Urano1FIT_LeRegistradores('064', @s1)); vol := trim(StrPas(@s1));
               Dados.horaimp := zcomp(tiramsc(copy(vol, 1, 2) + copy(vol, 4, 2)), 4);
               //
               Urano1FIT_LeRegistradores('067', @s1); dados.serial := tiramsc(StrPas(@s1));
               Urano1FIT_LeRegistradores('071', @s1); dados.loja := trim(StrPas(@s1));
               Urano1FIT_LeRegistradores('072', @s1); dados.caixa := trim(StrPas(@s1));
               //Urano1FIT_LeRegistradores('',@s1);dados.Operador:=trim(StrPas(@s1));
               Urano1FIT_LeRegistradores('125', @s1); dados.SeqIni := IntToStr(strtointdef(tiramsc(StrPas(@s1)), 0));
               Urano1FIT_LeRegistradores('65', @s1); dados.seqfinal := IntToStr(strtointdef(tiramsc(StrPas(@s1)), 0) - 1);
               Urano1FIT_LeRegistradores('120', @s1); dados.Reducoes := tiramsc(StrPas(@s1));
               //Urano1FIT_LeRegistradores('',@s1); dados.NumCanc := tiramsc(StrPas(@s1));
               Urano1FIT_LeRegistradores('124', @s1); dados.GTInicial := tiramsc(StrPas(@s1));
               Urano1FIT_LeRegistradores('075', @s1); dados.GTFinal := tiramsc(StrPas(@s1));
               Urano1FIT_LeRegistradores('001', @s1); dados.ValorCanc := tiramsc(StrPas(@s1));
               Urano1FIT_LeRegistradores('002', @s1); dados.ValorDesc := IntToStr(strtointdef(tiramsc(StrPas(@s1)), 0));
               Urano1FIT_LeRegistradores('003', @s1); dados.ValorDesc := IntToStr(strtointdef(dados.ValorDesc, 0) + strtointdef(tiramsc(StrPas(@s1)), 0));
               Urano1FIT_LeRegistradores('004', @s1); dados.ValorAcres := tiramsc(StrPas(@s1));
            end;
         end;
      Zanthus2e, ZanthusIZ20:
         begin
            if zan_proc('R', '') then begin
               dados.dataimp := copy(UltimaResp, 3, 4) + copy(UltimaResp, 9, 2);
               dados.horaimp := copy(UltimaResp, 11, 4);
               //if (strtointdef(dados.horaimp,0)<200) then begin
               //   d:=dados.dataimp;
               //   d:=datetostr(strtodate(d[1]+d[2]+'/'+d[3]+d[4]+'/20'+d[5]+d[6])-1);
               //   d:=copy(d,1,2)+copy(d,4,2)+copy(d,Length(d)-1,2);
               //   dados.dataimp:=d;
               //end;
            end;
            //if zan_proc('P', '095303') then Dados.dataimp := copy(UltimaResp,3,6);
            if zan_proc('P', '095903') then Dados.seqini := copy(UltimaResp, 3, 6);
            if zan_proc('P', '095603') then Dados.seqfinal := IntToStr(strtointdef(copy(UltimaResp, 3, 6), 1) - 1);
            if zan_proc('P', '000102') then dados.caixa := IntToStr(strtointdef(copy(UltimaResp, 3, 4), 0));
            if zan_proc('P', '200002') then dados.reducoes := copy(ultimaresp, 3, 4);
            if zan_proc('P', '096702') then dados.NumCanc := copy(Ultimaresp, 3, 4);
            if zan_proc('P', '097708') then dados.GTInicial := copy(Ultimaresp, 3, 16);
            if zan_proc('P', '096908') then dados.GTFinal := copy(UltimaResp, 3, 16);
            if zan_proc('P', '112908') then dados.ValorCanc := copy(UltimaResp, 3, 16);
            if zan_proc('P', '112108') then Dados.ValorDesc := copy(UltimaResp, 3, 16);
            if zan_proc('P', '134108') then Dados.ValorAcres := copy(UltimaResp, 3, 16);
            if zan_proc('Q', '') then Dados.Serial := copy(UltimaResp, 3, 8);

            //dados.loja:=
            //dados.Operador:=
         end;
      ZanthusIZ11, ZanthusIZ10, ZanthusIZ21, ZanthusIZ41:
         begin
            if zan_proc('R', '') then begin
               dados.dataimp := copy(UltimaResp, 3, 4) + copy(UltimaResp, 9, 2);
               dados.horaimp := copy(UltimaResp, 11, 4);
               //if (strtointdef(dados.horaimp,0)<200) then begin
               //   d:=dados.dataimp;
               //   d:=datetostr(strtodate(d[1]+d[2]+'/'+d[3]+d[4]+'/20'+d[5]+d[6])-1);
               //   d:=copy(d,1,2)+copy(d,4,2)+copy(d,Length(d)-1,2);
               //   dados.dataimp:=d;
               //end;
            end;
            //if zan_proc('P', '117303') then Dados.dataimp := copy(UltimaResp,3,6);
            if zan_proc('P', '117903') then Dados.seqini := copy(UltimaResp, 3, 6);
            if zan_proc('P', '117606') then Dados.seqfinal := IntToStr(strtointdef(copy(UltimaResp, 3, 6), 1) - 1);
            if zan_proc('P', '000102') then dados.caixa := IntToStr(strtointdef(copy(UltimaResp, 3, 4), 0));
            if zan_proc('P', '220402') then dados.reducoes := copy(ultimaresp, 3, 4);
            if zan_proc('P', '118702') then dados.NumCanc := copy(Ultimaresp, 3, 4);
            if zan_proc('P', '119708') then dados.GTInicial := copy(Ultimaresp, 3, 16);
            if zan_proc('P', '118908') then dados.GTFinal := copy(UltimaResp, 3, 16);
            if zan_proc('P', '133308') then dados.ValorCanc := copy(UltimaResp, 3, 16);
            if zan_proc('P', '132508') then Dados.ValorDesc := copy(UltimaResp, 3, 16);
            if zan_proc('P', '134108') then Dados.ValorAcres := copy(UltimaResp, 3, 16);
            if zan_proc('Q', '') then Dados.Serial := copy(UltimaResp, 3, 8);
         end;
      BematechMP40, BematechMP20, BematechTermica:
         begin
            if bem_proc('35|23') then begin
               dados.dataimp := copy(UltimaResp, 1, 6);
               dados.horaimp := copy(UltimaResp, 7, 4);
            end;
            if bem_proc('35|00') then dados.serial := copy(UltimaResp, 1, 15);
            if bem_proc('35|14') then dados.Caixa := IntToStr(strtointdef(copy(UltimaResp, 1, 4), 0));
            if bem_proc('30') then dados.SeqFinal := IntToStr(strtointdef(copy(Ultimaresp, 1, 6), 0) - 1);
            //if bem_proc('35|15') then dados.Loja := IntToStr(strtointdef(copy(UltimaResp,1,4),0));
            if bem_proc('35|09') then dados.Reducoes := copy(UltimaResp, 1, 4); // Ctd. Reducoes
            if bem_proc('35|08') then dados.NumCanc := copy(UltimaResp, 1, 4); // Num. Doc. Cancelados
            if bem_proc('35|04') then dados.valorcanc := copy(UltimaResp, 1, 14); // Valor Cancelamentos
            if bem_proc('35|05') then dados.ValorDesc := copy(UltimaResp, 1, 14); // Valor dos descontos
            if bem_proc('35|03') then dados.gtfinal := copy(UltimaResp, 4, 18); // GT. Final
            if bem_proc('35|30') then dados.ValorAcres := copy(UltimaResp, 1, 14); // Valor dos acrescimos
            //copy(bem_proc('62|55'),569,6),0)
            if bem_proc('62|55') then dados.SeqIni := copy(UltimaResp, 569, 6); // Seq. Inicial
            atualizatributacao;
            dados.GTInicial := tiramsc(floattostr(strtofloat(dados.GTFinal) -
               (strtointdef(dados.valorcanc, 0) +
               strtointdef(dados.ValorDesc, 0) +
               strtointdef(tributacao.Aliquota01, 0) +
               strtointdef(tributacao.Aliquota02, 0) +
               strtointdef(tributacao.Aliquota03, 0) +
               strtointdef(tributacao.Aliquota04, 0) +
               strtointdef(tributacao.Aliquota05, 0) +
               strtointdef(tributacao.Aliquota06, 0) +
               strtointdef(tributacao.Aliquota07, 0) +
               strtointdef(tributacao.Aliquota08, 0) +
               strtointdef(tributacao.Aliquota09, 0) +
               strtointdef(tributacao.Substituicao, 0) +
               strtointdef(tributacao.Isento, 0))));
         end;

      Elgin:
         begin
            if bem_proc('35|23') then begin
               dados.dataimp := copy(UltimaResp, 1, 6);
               dados.horaimp := copy(UltimaResp, 7, 4);
            end;
            if bem_proc('35|00') then dados.serial := copy(UltimaResp, 1, 15);
            if bem_proc('35|14') then dados.Caixa := IntToStr(strtointdef(copy(UltimaResp, 1, 4), 0));
            if bem_proc('30') then dados.SeqFinal := IntToStr(strtointdef(copy(Ultimaresp, 1, 6), 0) - 1);
            //if bem_proc('35|15') then dados.Loja := IntToStr(strtointdef(copy(UltimaResp,1,4),0));
            if bem_proc('35|09') then dados.Reducoes := copy(UltimaResp, 1, 4); // Ctd. Reducoes
            if bem_proc('35|08') then dados.NumCanc := copy(UltimaResp, 1, 4); // Num. Doc. Cancelados
            if bem_proc('35|04') then dados.valorcanc := copy(UltimaResp, 1, 14); // Valor Cancelamentos
            if bem_proc('35|05') then dados.ValorDesc := copy(UltimaResp, 1, 14); // Valor dos descontos
            if bem_proc('35|03') then dados.gtfinal := copy(UltimaResp, 4, 18); // GT. Final
            if bem_proc('35|30') then dados.ValorAcres := copy(UltimaResp, 1, 14); // Valor dos acrescimos
            //copy(bem_proc('62|55'),569,6),0)
            if bem_proc('62|55') then dados.SeqIni := copy(UltimaResp, 569, 6); // Seq. Inicial
            atualizatributacao;
            dados.GTInicial := tiramsc(floattostr(strtofloat(dados.GTFinal) -
               (strtointdef(dados.valorcanc, 0) +
               strtointdef(dados.ValorDesc, 0) +
               strtointdef(tributacao.Aliquota01, 0) +
               strtointdef(tributacao.Aliquota02, 0) +
               strtointdef(tributacao.Aliquota03, 0) +
               strtointdef(tributacao.Aliquota04, 0) +
               strtointdef(tributacao.Aliquota05, 0) +
               strtointdef(tributacao.Aliquota06, 0) +
               strtointdef(tributacao.Aliquota07, 0) +
               strtointdef(tributacao.Aliquota08, 0) +
               strtointdef(tributacao.Aliquota09, 0) +
               strtointdef(tributacao.Substituicao, 0) +
               strtointdef(tributacao.Isento, 0))));
         end;
      Schalter3D:
         begin
            pronto := false;
            x := 1;
            UltimaResp := Schalter3D_StatusCupom(x);
            if pos('Erro', Ultimaresp) > 0 then begin
               Result := retornoschd(strtointdef(copy(Ultimaresp, 7, 3), 0));
               exit;
            end;
            Dados.dataimp := copy(UltimaResp, 18, 2) + copy(UltimaResp, 21, 2) + copy(UltimaResp, 24, 2);
            Dados.horaimp := copy(UltimaResp, 12, 4);
            dados.caixa := IntToStr(strtointdef(copy(UltimaResp, 1, 4), 0));
            dados.GTFInal := zcomp(inttostr(strtointdef(tiramsc(copy(Ultimaresp, 47, 21)), 0)), 16);
            //
            UltimaResp := Schalter3D_LeituraXSerial;
            dados.GTInicial := IntToStr(strtointdef(dados.GTFinal, 0) -
               strtointdef(tiramsc(copy(Ultimaresp, 98, 21)), 0) -
               strtointdef(tiramsc(copy(Ultimaresp, 41, 15)), 0) -
               strtointdef(tiramsc(copy(Ultimaresp, 62, 15)), 0));
            dados.SeqIni := copy(Ultimaresp, 17, 6);
            dados.seqfinal := zcomp(inttostr(strtointdef(tiramsc(copy(Ultimaresp, 23, 6)), 0) - 1), 6);
            dados.Reducoes := IntToStr(strtointdef(copy(Ultimaresp, 1, 4), 0) - 1);
            dados.NumCanc := copy(Ultimaresp, 29, 6);
            dados.ValorCanc := tiramsc(copy(Ultimaresp, 41, 15));
            dados.ValorDesc := tiramsc(copy(UltimaResp, 62, 15));
            dados.ValorAcres := tiramsc(copy(UltimaResp, 83, 15));
            pronto := true;
            //
           {dados.loja:=
            dados.Operador:= }
         end;
      Schalter2S:
         begin
            pronto := false;
            x := 1;
            grande_retorno := Schalter2S_ecfStatusCupom(x);

            ultimaresp := grande_retorno;
            dados.Caixa := copy(ultimaresp, 1, 4);
            //tipo documento := copy(grande_retorno,5,1);
            dados.SeqIni := copy(Ultimaresp, 17, 6);
            dados.SeqFinal := IntToStr(strtointdef(copy(ultimaresp, 6, 6), 2)); { Foi tirado -2 \Katia}
            dados.HoraImp := copy(ultimaresp, 12, 4);
            dados.dataimp := tiramsc(copy(ultimaresp, 18, 8));
            //subtotal := copy(ultimaresp,26,21);
            dados.GTFinal := tiramsc(copy(ultimaresp, 47, 21));
            //
            grande_retorno := Schalter2S_ecfLeituraXSerial();
            ultimaresp := grande_retorno;

            //dados.GTInicial :=
            dados.Reducoes := IntToStr(strtointdef(copy(Ultimaresp, 1, 4), 0) - 1); {Foi Incluido -1 \Katia}
            dados.NumCanc := copy(Ultimaresp, 29, 6);
            dados.ValorCanc := tiramsc(copy(Ultimaresp, 35, 21));
            dados.ValorDesc := tiramsc(copy(Ultimaresp, 56, 21));
            dados.ValorAcres := tiramsc(copy(UltimaResp, 77, 21));

            dados.GTInicial := IntToStr(strtointdef(dados.GTFinal, 0) -
               strtointdef(tiramsc(copy(Ultimaresp, 35, 21)), 0) -
               strtointdef(tiramsc(copy(Ultimaresp, 56, 21)), 0) -
               strtointdef(tiramsc(copy(Ultimaresp, 98, 21)), 0));
            //
            tributacao.Substituicao := tiramsc(copy(UltimaResp, 124, 13));
            tributacao.isento := tiramsc(copy(UltimaResp, 142, 13));
            tributacao.NaoTributado := tiramsc(copy(UltimaResp, 160, 13));
            tributacao.Aliquota01 := tiramsc(copy(UltimaResp, 183, 13));
            tributacao.Aliquota02 := tiramsc(copy(UltimaResp, 224, 13));
            tributacao.Aliquota03 := tiramsc(copy(UltimaResp, 265, 13));
            tributacao.Aliquota04 := tiramsc(copy(UltimaResp, 306, 13));
            tributacao.Aliquota05 := tiramsc(copy(UltimaResp, 347, 13));
            tributacao.Aliquota06 := tiramsc(copy(UltimaResp, 388, 13));
            tributacao.Aliquota07 := tiramsc(copy(UltimaResp, 429, 13));
            tributacao.Aliquota08 := tiramsc(copy(UltimaResp, 470, 13));
            tributacao.Aliquota09 := tiramsc(copy(UltimaResp, 511, 13));
            tributacao.Aliquota10 := tiramsc(copy(UltimaResp, 552, 13));
            pronto := true;
{            dados.loja:=
            dados.Operador:=
}
         end;
      SCFI:
         begin
            pronto := false;
            x := 1;
            grande_retorno := SCFI_ecfStatusCupom(x);

            ultimaresp := grande_retorno;
            dados.Caixa := copy(ultimaresp, 1, 4);
            //tipo documento := copy(grande_retorno,5,1);
            dados.SeqIni := copy(Ultimaresp, 17, 6);
            dados.SeqFinal := IntToStr(strtointdef(copy(ultimaresp, 6, 6), 2)); { Foi tirado -2 \Katia}
            dados.HoraImp := copy(ultimaresp, 12, 4);
            dados.dataimp := tiramsc(copy(ultimaresp, 18, 8));
            //subtotal := copy(ultimaresp,26,21);
            dados.GTFinal := tiramsc(copy(ultimaresp, 47, 21));
            //
            grande_retorno := SCFI_ecfLeituraXSerial();
            ultimaresp := grande_retorno;

            //dados.GTInicial :=
            dados.Reducoes := IntToStr(strtointdef(copy(Ultimaresp, 1, 4), 0) - 1); {Foi Incluido -1 \Katia}
            dados.NumCanc := copy(Ultimaresp, 29, 6);
            dados.ValorCanc := tiramsc(copy(Ultimaresp, 35, 21));
            dados.ValorDesc := tiramsc(copy(Ultimaresp, 56, 21));
            dados.ValorAcres := tiramsc(copy(UltimaResp, 77, 21));

            dados.GTInicial := IntToStr(strtointdef(dados.GTFinal, 0) -
               strtointdef(tiramsc(copy(Ultimaresp, 35, 21)), 0) -
               strtointdef(tiramsc(copy(Ultimaresp, 56, 21)), 0) -
               strtointdef(tiramsc(copy(Ultimaresp, 98, 21)), 0));
            //
            tributacao.Substituicao := tiramsc(copy(UltimaResp, 124, 13));
            tributacao.isento := tiramsc(copy(UltimaResp, 142, 13));
            tributacao.NaoTributado := tiramsc(copy(UltimaResp, 160, 13));
            tributacao.Aliquota01 := tiramsc(copy(UltimaResp, 183, 13));
            tributacao.Aliquota02 := tiramsc(copy(UltimaResp, 224, 13));
            tributacao.Aliquota03 := tiramsc(copy(UltimaResp, 265, 13));
            tributacao.Aliquota04 := tiramsc(copy(UltimaResp, 306, 13));
            tributacao.Aliquota05 := tiramsc(copy(UltimaResp, 347, 13));
            tributacao.Aliquota06 := tiramsc(copy(UltimaResp, 388, 13));
            tributacao.Aliquota07 := tiramsc(copy(UltimaResp, 429, 13));
            tributacao.Aliquota08 := tiramsc(copy(UltimaResp, 470, 13));
            tributacao.Aliquota09 := tiramsc(copy(UltimaResp, 511, 13));
            tributacao.Aliquota10 := tiramsc(copy(UltimaResp, 552, 13));
            pronto := true;
         end;
      Procomp_2011:
         begin
            try
              {Falta: GTInicial,CupomAtual,Cancelamentos$
              }
               Result := true;
               ptRetorno := AllocMem(255);
               LeProComp(Procomp_ECFID, True);
               LeProComp(Procomp_ObtemRetorno(PtRetorno), True);
               Dados.Caixa := copy(StrPas(ptRetorno), 20, 6);
               LeProComp(Procomp_TransDataHora, True);
               LeProComp(Procomp_ObtemRetorno(PtRetorno), True);
               Dados.DataImp := Tiramsc(copy(StrPas(ptRetorno), 6, 10));
               Dados.HoraImp := Tiramsc(copy(StrPas(ptRetorno), 15, 10));
               LeProComp(Procomp_EcfParEsp(PChar('42')), True);
               LeProComp(Procomp_ObtemRetorno(PtRetorno), True);
               Dados.reducoes := copy(StrPas(ptRetorno), 6, 4);
               LeProComp(Procomp_EcfParEsp(Pchar('36')), True);
               LeProComp(Procomp_ObtemRetorno(PtRetorno), True);
               Dados.ValorDesc := copy(StrPas(ptRetorno), 6, 15);
               LeProComp(Procomp_EcfParEsp(Pchar('37')), True);
               LeProComp(Procomp_ObtemRetorno(PtRetorno), True);
               Dados.ValorAcres := copy(StrPas(ptRetorno), 6, 15);
               LeProComp(Procomp_EcfParEsp(Pchar('44')), True);
               LeProComp(Procomp_ObtemRetorno(PtRetorno), True);
               Dados.NumCanc := copy(StrPas(ptRetorno), 6, 4);
               LeProComp(Procomp_EcfParEsp(Pchar('39')), True);
               LeProComp(Procomp_ObtemRetorno(PtRetorno), True);
               Dados.GTFinal := copy(StrPas(ptRetorno), 6, 19);

               LeProComp(Procomp_EcfParEsp(Pchar('41')), True);
               LeProComp(Procomp_ObtemRetorno(PtRetorno), True);
               Dados.SeqFinal := StrPas(ptRetorno);

               LeProComp(Procomp_EcfParEsp(Pchar('41')), True);
               LeProComp(Procomp_ObtemRetorno(PtRetorno), True);
               dados.SeqFinal := copy(StrPas(ptRetorno), 6, 6);
               Dados.SeqFinal := zComp(IntToStr(StrToInt(Dados.SeqFinal) - 1), 6);

               LeProComp(Procomp_EcfParEsp(Pchar('82')), True);
               LeProComp(Procomp_ObtemRetorno(PtRetorno), True);
               Dados.SeqIni := copy(StrPas(ptRetorno), 6, 6);

               Pronto := True;
            finally
               FreeMem(ptRetorno);
            end;
         end;
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Trends_EcfID(Ultimaresp);
            dados.serial := copy(ultimaresp, 10, 10);
            dados.Caixa := IntToStr(strtointdef(copy(ultimaresp, 20, 6), 0));
            Trends_TransDataHora(Ultimaresp);
            dados.DataImp := tiramsc(copy(ultimaresp, 6, 8));
            dados.horaimp := tiramsc(copy(ultimaresp, 15, 5));
            Trends_EcfPar('39', UltimaResp); // GT Final
            dados.GTFinal := copy(ultimaresp, 13, 12);
            Trends_EcfPar('40', UltimaResp); // Venda Bruta
            dados.GTInicial := formatfloat('000000000000', StrToFloat(dados.gtfinal) - StrToFloat(copy(ultimaresp, 13, 12)));
            Trends_EcfPar('82', UltimaResp); // Primeiro cupom do dia
            dados.SeqIni := copy(Ultimaresp, 12, 6);
            Trends_EcfPar('41', UltimaResp); // Contador de Operacoes
            dados.SeqFinal := IntToStr(strtointdef(copy(ultimaresp, 6, 6), 1) - 1);
            Trends_EcfPar('42', UltimaResp); // Contador de reducoes
            dados.reducoes := copy(ultimaresp, 6, 4);
            Trends_EcfPar('44', UltimaResp); // Contador de cancelamentos
            dados.NumCanc := copy(ultimaresp, 6, 4);
            Trends_EcfPar('36', UltimaResp); // Valor dos Descontos
            dados.valordesc := copy(ultimaresp, 10, 11);
            Trends_EcfPar('37', UltimaResp); // Valor dos Acrescimos
            dados.valorAcres := copy(ultimaresp, 10, 11);
            Result := Trends_ret(Trends_EcfPar('38', UltimaResp)); // Valor dos cancelamentos
            dados.valorcanc := copy(ultimaresp, 10, 11);
               //dados.loja := trim(StrPas(@s1));
               //dados.Operador:=trim(StrPas(@s1));

         end;
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////
function TDefFPrinter.AtualizaDadosNCR(comando: string): Boolean;
begin
   Result := NCR_Proc(comando);
end;
/////////////////////////////////////////////////
function TDefFPrinter.AtualizaValorCupom: Boolean;
var
   a, b: string;
   x: integer;
begin
   Result := false;
   case Impressora of
      None: Result := true;
      Dataregis:
         begin
            Result := DTR_Proc('C');
            valorcupom := sepdados(UltimaResp, 2);
         end;
      Sweda03:
         begin
            Result := swd_proc(#27 + '.28}');
            if Result then ValorCupom := copy(Ultimaresp, 100, 12);
         end;
      Sweda10:
         begin
            Result := swd_proc(#27 + '.28}');
            if Result then ValorCupom := copy(Ultimaresp, 98, 12);
         end;
      NCR1x: Result := NCR_Proc('39');
      NCR2x, NCR7141: Result := NCR_Proc('30');
      Urano2EFE:
         begin
            StrCopy(@s1, '0');
            result := Urn_ret(Urano2EFE_LeRegistradores('00', @s1));
            if Result then ValorCupom := tiramsc(StrPas(@s1)) else ValorCupom := '0';
         end;
      Urano1EFC, Urano2EFC:
         begin
            StrCopy(@s1, '0');
            Result := urn_ret3(UranoEFC_LeRegistradores('00', @s1));
            ValorCupom := tiramsc(StrPas(@s1));
         end;
      Urano1FIT:
         begin
            x := Urano1FIT_EstadoImpressora;
            if (x <> 201) and (x <> 203) and (x <> 204) then begin // Em venda ou pagamento ou finalizacao
               Result := false;
               ValorCupom := '0';
               exit;
            end;
            result := Urn_ret2(Urano1FIT_LeRegistradores('000', @s1));
            vol := trim(StrPas(@s1));
            if Result then valorcupom := vol else ValorCupom := '0';
         end;
      Zanthus2e, ZanthusIZ20:
         begin
            Result := zan_proc('P', '192908');
            if result then begin
               a := copy(UltimaResp, 3, 16);
               zan_proc('P', '193708');
               b := copy(UltimaResp, 3, 16);
               valorCupom := IntToStr(strtointdef(a, 0) - strtointdef(b, 0));
               if strtointdef(valorcupom,0)<0 then valorcupom := '0';
            end else valorcupom := '0';
         end;
      ZanthusIZ11, ZanthusIZ10, ZanthusIZ21, ZanthusIZ41:
         begin
            Result := zan_proc('P', '213308'); // valor do cupom em andamento
            if result then begin
               a := copy(UltimaResp, 3, 16);
               zan_proc('P', '214108'); // Valor jah pago
               b := copy(UltimaResp, 3, 16);
               valorCupom := IntToStr(strtointdef(a, 0) - strtointdef(b, 0));
               if strtointdef(valorcupom,0)<0 then valorcupom := '0';
            end else valorcupom := '0';
         end;
      Schalter3D:
         begin
            pronto := false;
            x := 1;
            UltimaResp := Schalter3D_StatusCupom(x);
            ValorCupom := tiramsc(copy(Ultimaresp, 26, 21));
            pronto := true;
         end;
      Schalter2S:
         begin
            pronto := false;
            x := 1;
            UltimaResp := Schalter2S_ecfStatusCupom(x);
            ValorCupom := tiramsc(copy(Ultimaresp, 26, 21));
            pronto := true;
         end;
      SCFI:
         begin
            pronto := false;
            x := 1;
            UltimaResp := SCFI_ecfStatusCupom(x);
            ValorCupom := tiramsc(copy(Ultimaresp, 26, 21));
            pronto := true;
         end;
      BematechMP40, BematechMP20, BematechTermica:
         begin
            Result := bem_proc('29');
            if result then Valorcupom := tiramsc(copy(Ultimaresp, 1, 14));
         end;
      Elgin:
         begin
            Result := bem_proc('29');
            if result then Valorcupom := tiramsc(copy(Ultimaresp, 1, 14));
         end;
      Procomp_2011:
         begin
            try
               ptRetorno := AllocMem(255);
              // Obtem o numero do cupom fiscal
               LeProComp(Procomp_EcfParEsp(Pchar('96')), True);
               LeProComp(Procomp_ObtemRetorno(PtRetorno), True);
               Valorcupom := copy(StrPas(ptRetorno), Length(StrPas(ptRetorno)) - 14, 15);
               pronto := true;
            finally
               FreeMem(ptRetorno);
            end;
         end;
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Trends_TransStatusDecod(UltimaResp); // Estado do ECF
            if copy(ultimaresp, 13, 1) = '1' then begin // Se estuiver com cupom aberto na ECF, senao volta 0
               Result := Trends_ret(Trends_EcfPar('96', UltimaResp)); // Total do cupom em andamento ou do ultimo
               ValorCupom := copy(ultimaresp, 10, 11);
            end else ValorCupom := '0'
         end;
   end;
end;
////////////////////////////////////////////
function TDefFPrinter.AtualizaEprom: Boolean;
begin
   Result := false;
   case Impressora of
      None: exit;
      Dataregis:
         begin
            Result := DTR_Proc('PS');
            Eprom := sepdados(ultimaresp, 2);
            dados.Serial := sepdados(ultimaresp, 5);
         end;
      Sweda03:
         begin
            //Result := swd_proc(#27 + '.27g}');
            Eprom := '03';
            Result := true;
         end;
      Sweda10:
         begin
            Result := swd_proc(#27 + '.27G}');
            if Result then begin
               eprom := copy(Ultimaresp, 28, 3); // Versao da emprom
            end;
         end;
      NCR2x: begin
            Result := true;
            eprom := '2.0';
         end;
      NCR7141: begin
            Result := true;
            Result := NCR_Proc('49');
         end;
      NCR1x: Result := NCR_Proc('460');
      Urano2EFE:
         begin
            StrCopy(@s1, '0');
            Urano2EFE_LeRegistradores('72', @s1);
            Eprom := StrPas(@s1);
         end;
      Urano1EFC, Urano2EFC:
         begin
            StrCopy(@s1, '0');
            UranoEFC_LeRegistradores('41', @s1);
            Eprom := trim(StrPas(@s1));
         end;
      Urano1FIT:
         begin
            StrCopy(@s1, '0');
            Urano1FIT_LeRegistradores('121', @s1);
            Eprom := StrPas(@s1);
         end;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            Result := zan_proc('0', '');
            eprom := copy(ultimaresp, 3, 2) + '.' + copy(ultimaresp, 5, 2);
            //zan_col:=strtointdef(copy(ultimaresp,9,2),0);
         end;
      Schalter3D:
         begin
            pronto := false;
            UltimaResp := Schalter3D_StatusEquipo;
            Eprom := copy(Ultimaresp, 26, 4) + copy(Ultimaresp, 11, 1);
            dados.Serial := copy(Ultimaresp, 31, 9);
            pronto := true;
         end;
      Schalter2S:
         begin
            Eprom := '02.04';
            Result := true;
            pronto := true;
         end;
      SCFI:
         begin
            pronto := false;
            UltimaResp := SCFI_ecfStatusEquipo;
            Eprom := copy(Ultimaresp, 26, 4) + copy(Ultimaresp, 11, 1);
            dados.Serial := copy(Ultimaresp, 31, 9);
            pronto := true;
         end;
      BematechMP40, BematechMP20, BematechTermica:
         begin
            Result := bem_proc('35|01');
            if result then begin
               eprom := copy(UltimaResp, 1, 2) + '.' + copy(UltimaResp, 3, 2);
               bem_proc('35|00');
               if copy(UltimaResp, 1, 2) = '47' then eprom := eprom + '-1E';
               if copy(UltimaResp, 1, 2) = '57' then eprom := eprom + '-2E';
            end;
         end;
      Elgin:
         begin
            Result := bem_proc('35|01');
            if result then begin
               eprom := copy(UltimaResp, 1, 2) + '.' + copy(UltimaResp, 3, 2);
               bem_proc('35|00');
               if copy(UltimaResp, 1, 2) = '47' then eprom := eprom + '-1E';
               if copy(UltimaResp, 1, 2) = '57' then eprom := eprom + '-2E';
            end;
         end;   
      Procomp_2011:
         begin
            try
               ptRetorno := AllocMem(255);
               LeProComp(Procomp_EcfParEsp(Pchar('47')), True);
               LeProComp(Procomp_ObtemRetorno(PtRetorno), True);
               eprom := StrPas(ptRetorno);
               Pronto := True;
            finally
               FreeMem(ptRetorno);
            end;
         end;
      Trends10E:
         begin
            Ultimaresp := space(1000);
            if textolivre <> 'busca' then begin
               Result := Trends_ret(Trends_EcfPar('47', UltimaResp));
            end else begin
               Trends_EcfPar('47', UltimaResp);
               if copy(ultimaresp, 1, 1) = '+' then Result := true else Result := false;
            end;
            eprom := copy(ultimaresp, 6, 7);
         end;
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////
function TDefFPrinter.AtualizaStatus: Boolean;
var
   x: Integer;
   a: string;
   mRetorno: Pointer;
begin
   Result := false;
   mRetorno := nil;
   case Impressora of
      None: exit;
      Dataregis:
         begin
            Result := DTR_Proc('R');
            a := sepdados(UltimaResp, 3) + '        ';
            if a[4] = 'S' then status.GavetaAberta := true else status.GavetaAberta := false;
            if a[2] = 'N' then status.FimDePapel := true else status.FimDePapel := false;
            if a[1] = 'V' then status.CupomAberto := true else status.CupomAberto := false;
         end;
      Sweda03:
         begin
            Result := SWD_Proc(#27 + '.23}');
            if Result then begin
               if copy(UltimaResp, 6, 1) = '0' then Status.FimDePapel := false else Status.GavetaAberta := True;
            end;
            Result := SWD_Proc(#27 + '.22}');
            if Result then begin
               if copy(UltimaResp, 6, 1) = '1' then Status.GavetaAberta := true else Status.GavetaAberta := false;
            end;
         end;
      Sweda10:
         begin
            Result := SWD_Proc(#27 + '.23}');
            if Result then begin
               if copy(UltimaResp, 6, 1) = '0' then Status.FimDePapel := false else Status.GavetaAberta := True;
            end;
            Result := SWD_Proc(#27 + '.22}');
            if Result then begin
               if copy(UltimaResp, 6, 1) = '1' then Status.GavetaAberta := true else Status.GavetaAberta := false;
            end;
         end;
      NCR2x, NCR7141, NCR1x: Result := NCR_Proc('31');
      Urano2EFE:
         begin
            x := Urano2EFE_LeituraSensor('3');
            if x = 49 then Status.GavetaAberta := true else Status.GavetaAberta := false;
            if x = 0 then Result := false else Result := true;
         end;
      Urano1EFC, Urano2EFC:
         begin
            x := UranoEFC_LeSensor('3');
            if x = 49 then Status.GavetaAberta := true else Status.GavetaAberta := false;
            x := UranoEFC_LeSensor('1');
            if x = 49 then Status.FimDePapel := true else Status.GavetaAberta := false;
            if x = 0 then Result := false else Result := true;
         end;
      Urano1fit:
         begin
            x := Urano1FIT_LeSensor('2');
            if x = 49 then Status.GavetaAberta := true else Status.GavetaAberta := false;
            if x = 0 then Result := false else Result := true;
         end;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            Result := zan_proc('S', '');
            if Result then begin
               status.gavetaAberta := (copy(ultimaresp, 4, 1) = '1');
               status.FimDePapel := (copy(ultimaresp, 6, 1) = '1');
               //status.CupomAberto
            end;
            AtualizaValorCupom;
            Status.CupomAberto := ValorCupom <> '0';
         end;
      Schalter3D:
         begin
            pronto := false;
            Ultimaresp := Schalter3D_StatusImp();
            if pos('Erro', Ultimaresp) > 0 then begin
               Result := retornoschd(strtointdef(copy(Ultimaresp, 7, 3), 0));
               exit;
            end;
            status.FimDePapel := copy(UltimaResp, 6, 1) = '1';
            status.GavetaAberta := copy(UltimaResp, 8, 1) = '0';
            status.CupomAberto := Pos(copy(UltimaResp, 3, 3), '090,065,123') > 0; // Alteracao do William
            //status.CupomAberto := copy(UltimaResp, 3, 3) <> '000';
            pronto := true;
         end;
      Schalter2S:
         begin
            Grande_retorno := Schalter2S_ecfStatusImp();
            ultimaresp := grande_retorno;
            status.FimDePapel := copy(ultimaresp, 6, 1) = '1';
            status.GavetaAberta := copy(ultimaresp, 8, 1) = '1';
            status.CupomAberto := strtointdef(copy(ultimaresp, 3, 3), 0) = 90;
         end;
      SCFI:
         begin
            Grande_retorno := SCFI_ecfStatusImp();
            ultimaresp := grande_retorno;
            status.FimDePapel := copy(ultimaresp, 6, 1) = '1';
            status.GavetaAberta := copy(ultimaresp, 8, 1) = '1';
            status.CupomAberto := strtointdef(copy(ultimaresp, 3, 3), 0) = 90;
         end;
      BematechMP40, BematechMP20, BematechTermica:
         begin
            Result := bem_proc('19');
            if trim(copy(UltimaResp, 12, 80)) = 'Pouco Papel!' then status.FimDePapel := true else status.FimDePapel := false;
            bem_proc('23');
            if UltimaResp = '000' then status.GavetaAberta := false;
            if UltimaResp = '255' then status.GavetaAberta := true;
         end;
      Elgin:
         begin
            Result := bem_proc('19');
            if trim(copy(UltimaResp, 12, 80)) = 'Pouco Papel!' then status.FimDePapel := true else status.FimDePapel := false;
            bem_proc('23');
            if UltimaResp = '000' then status.GavetaAberta := false;
            if UltimaResp = '255' then status.GavetaAberta := true;
         end;
      Procomp_2011:
         begin
            status.FimDePapel := Procomp_TransStatus(23, mRetorno) = 1;
            status.GavetaAberta := not Procomp_TransStatus(18, mRetorno) = 18;
            status.CupomAberto := Procomp_TransStatus(1, mRetorno) = 1;
            Pronto := True;
         end;
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Trends_TransStatusDecod(UltimaResp); // Estado do ECF
            if copy(ultimaresp, 23, 1) = '1' then status.FimDePapel := true else status.FimDePapel := false;
            if copy(ultimaresp, 13, 1) = '1' then status.CupomAberto := true else status.CupomAberto := false;
            if (copy(ultimaresp, 8, 1) = '0') and (copy(ultimaresp, 30, 1) = '0') then status.DiaAberto := true else status.DiaAberto := false;
            if copy(ultimaresp, 28, 1) = '1' then status.GavetaAberta := true else status.GavetaAberta := false;
            Result := true;

         end;
   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////
function TDefFPrinter.AtualizaTributacao: Boolean;
var
   x: Integer;
   a: string;
begin
   Result := false;
   case Impressora of
      None: exit;
      Dataregis: begin
            Result := DTR_Proc('GSS');
            for x := 1 to 10 do begin
               a := sepdados(ultimaresp, x + 1);
               if copy(a, 1, 1) = 'I' then Tributacao.Isento := copy(a, 7, 14);
               if copy(a, 1, 1) = 'F' then Tributacao.Substituicao := copy(a, 7, 14);
               if copy(a, 1, 1) = 'N' then Tributacao.NaoTributado := copy(a, 7, 14);
               if copy(a, 1, 1) = 'T' then begin
                  case x - 1 of
                     1: Tributacao.Aliquota01 := copy(a, 7, 14);
                     2: Tributacao.Aliquota02 := copy(a, 7, 14);
                     3: Tributacao.Aliquota03 := copy(a, 7, 14);
                     4: Tributacao.Aliquota04 := copy(a, 7, 14);
                     5: Tributacao.Aliquota05 := copy(a, 7, 14);
                     6: Tributacao.Aliquota06 := copy(a, 7, 14);
                     7: Tributacao.Aliquota07 := copy(a, 7, 14);
                     8: Tributacao.Aliquota08 := copy(a, 7, 14);
                     9: Tributacao.Aliquota09 := copy(a, 7, 14);
                     10: Tributacao.Aliquota10 := copy(a, 7, 14);
                  end;
               end;
            end;
         end;
      Sweda03:
         begin
            result := swd_proc(#27 + '.272}');
            if Result then begin
               Tributacao.Isento := copy(UltimaResp, 19, 12); // Total Isento
               Tributacao.NaoTributado := copy(Ultimaresp, 31, 12); // Total Nao tributado
               Tributacao.Substituicao := copy(Ultimaresp, 43, 12); // Total Substituicao
               Tributacao.Aliquota01 := copy(Ultimaresp, 98, 12); // Total Ident.  1
            end else exit;
            result := swd_proc(#27 + '.273}');
            if Result then begin
               Tributacao.Aliquota02 := copy(Ultimaresp, 11, 12); // Total Ident.  2
               Tributacao.Aliquota03 := copy(Ultimaresp, 26, 12); // Total Ident.  3
               Tributacao.Aliquota04 := copy(Ultimaresp, 41, 12); // Total Ident.  4
               Tributacao.Aliquota05 := copy(Ultimaresp, 56, 12); // Total Ident.  5
               Tributacao.Aliquota06 := copy(Ultimaresp, 71, 12); // Total Ident.  6
               Tributacao.Aliquota07 := copy(Ultimaresp, 86, 12); // Total Ident.  7
               Tributacao.Aliquota08 := copy(Ultimaresp, 101, 12); // Total Ident.  8
            end;
         end;
      Sweda10:
         begin
            result := swd_proc(#27 + '.273}');
            if Result then begin
               Tributacao.Isento := copy(UltimaResp, 22, 12); // Total Isento
               Tributacao.NaoTributado := copy(Ultimaresp, 34, 12); // Total Nao tributado
               Tributacao.Substituicao := copy(Ultimaresp, 46, 12); // Total Substituicao
               Tributacao.Aliquota01 := copy(Ultimaresp, 97, 12); // Total Ident.  1
            end else exit;
            result := swd_proc(#27 + '.274}');
            if Result then begin
               Tributacao.Aliquota02 := copy(Ultimaresp, 11, 12); // Total Ident.  2
               Tributacao.Aliquota03 := copy(Ultimaresp, 26, 12); // Total Ident.  3
               Tributacao.Aliquota04 := copy(Ultimaresp, 41, 12); // Total Ident.  4
               Tributacao.Aliquota05 := copy(Ultimaresp, 56, 12); // Total Ident.  5
               Tributacao.Aliquota06 := copy(Ultimaresp, 71, 12); // Total Ident.  6
               Tributacao.Aliquota07 := copy(Ultimaresp, 86, 12); // Total Ident.  7
               Tributacao.Aliquota08 := copy(Ultimaresp, 101, 12); // Total Ident.  8
            end;
         end;
      NCR2x, NCR7141, NCR1x: Result := NCR_Proc('38');
      Urano2EFE:
         begin
            StrCopy(@s1, '0');
            result := Urn_ret(Urano2EFE_LeRegistradores('22', @s1)); tributacao.Substituicao := tiramsc(StrPas(@s1));
            result := Urn_ret(Urano2EFE_LeRegistradores('23', @s1)); tributacao.Isento := tiramsc(StrPas(@s1));
            result := Urn_ret(Urano2EFE_LeRegistradores('24', @s1)); tributacao.NaoTributado := tiramsc(StrPas(@s1));
            result := Urn_ret(Urano2EFE_LeRegistradores('6', @s1)); tributacao.Aliquota00 := tiramsc(StrPas(@s1));
            result := Urn_ret(Urano2EFE_LeRegistradores('7', @s1)); tributacao.Aliquota01 := tiramsc(StrPas(@s1));
            result := Urn_ret(Urano2EFE_LeRegistradores('8', @s1)); tributacao.Aliquota02 := tiramsc(StrPas(@s1));
            result := Urn_ret(Urano2EFE_LeRegistradores('9', @s1)); tributacao.Aliquota03 := tiramsc(StrPas(@s1));
            result := Urn_ret(Urano2EFE_LeRegistradores('10', @s1)); tributacao.Aliquota04 := tiramsc(StrPas(@s1));
            result := Urn_ret(Urano2EFE_LeRegistradores('11', @s1)); tributacao.Aliquota05 := tiramsc(StrPas(@s1));
            result := Urn_ret(Urano2EFE_LeRegistradores('12', @s1)); tributacao.Aliquota06 := tiramsc(StrPas(@s1));
            result := Urn_ret(Urano2EFE_LeRegistradores('13', @s1)); tributacao.Aliquota07 := tiramsc(StrPas(@s1));
            result := Urn_ret(Urano2EFE_LeRegistradores('14', @s1)); tributacao.Aliquota08 := tiramsc(StrPas(@s1));
         end;
      Urano1EFC, Urano2EFC:
         begin
            StrCopy(@s1, '0');
            result := Urn_ret3(UranoEFC_LeRegistradores('13', @s1)); tributacao.Substituicao := tiramsc(StrPas(@s1));
            result := Urn_ret3(UranoEFC_LeRegistradores('14', @s1)); tributacao.Isento := tiramsc(StrPas(@s1));
            result := Urn_ret3(UranoEFC_LeRegistradores('15', @s1)); tributacao.NaoTributado := tiramsc(StrPas(@s1));
            result := Urn_ret3(UranoEFC_LeRegistradores('06', @s1)); tributacao.Aliquota00 := tiramsc(StrPas(@s1));
            result := Urn_ret3(UranoEFC_LeRegistradores('07', @s1)); tributacao.Aliquota01 := tiramsc(StrPas(@s1));
            result := Urn_ret3(UranoEFC_LeRegistradores('08', @s1)); tributacao.Aliquota02 := tiramsc(StrPas(@s1));
            result := Urn_ret3(UranoEFC_LeRegistradores('09', @s1)); tributacao.Aliquota03 := tiramsc(StrPas(@s1));
            result := Urn_ret3(UranoEFC_LeRegistradores('10', @s1)); tributacao.Aliquota04 := tiramsc(StrPas(@s1));
            result := Urn_ret3(UranoEFC_LeRegistradores('11', @s1)); tributacao.Aliquota05 := tiramsc(StrPas(@s1));
            result := Urn_ret3(UranoEFC_LeRegistradores('12', @s1)); tributacao.Aliquota06 := tiramsc(StrPas(@s1));
         end;
      Urano1fit:
         begin
            StrCopy(@s1, '0');
            result := Urn_ret2(Urano1FIT_LeRegistradores('017', @s1)); tributacao.Substituicao := tiramsc(StrPas(@s1));
            result := Urn_ret2(Urano1FIT_LeRegistradores('018', @s1)); tributacao.Isento := tiramsc(StrPas(@s1));
            result := Urn_ret2(Urano1FIT_LeRegistradores('019', @s1)); tributacao.NaoTributado := tiramsc(StrPas(@s1));
            result := Urn_ret2(Urano1FIT_LeRegistradores('005', @s1)); tributacao.Aliquota00 := tiramsc(StrPas(@s1));
            result := Urn_ret2(Urano1FIT_LeRegistradores('006', @s1)); tributacao.Aliquota01 := tiramsc(StrPas(@s1));
            result := Urn_ret2(Urano1FIT_LeRegistradores('007', @s1)); tributacao.Aliquota02 := tiramsc(StrPas(@s1));
            result := Urn_ret2(Urano1FIT_LeRegistradores('008', @s1)); tributacao.Aliquota03 := tiramsc(StrPas(@s1));
            result := Urn_ret2(Urano1FIT_LeRegistradores('009', @s1)); tributacao.Aliquota04 := tiramsc(StrPas(@s1));
            result := Urn_ret2(Urano1FIT_LeRegistradores('010', @s1)); tributacao.Aliquota05 := tiramsc(StrPas(@s1));
            result := Urn_ret2(Urano1FIT_LeRegistradores('011', @s1)); tributacao.Aliquota06 := tiramsc(StrPas(@s1));
            result := Urn_ret2(Urano1FIT_LeRegistradores('012', @s1)); tributacao.Aliquota07 := tiramsc(StrPas(@s1));
            result := Urn_ret2(Urano1FIT_LeRegistradores('013', @s1)); tributacao.Aliquota08 := tiramsc(StrPas(@s1));
         end;
      Zanthus2e, ZanthusIZ20:
         begin
            Result := zan_proc('P', '109708');
            if Result then Tributacao.Substituicao := copy(UltimaResp, 3, 16) else exit;
            if zan_proc('P', '110508') then Tributacao.Isento := copy(UltimaResp, 3, 16);
            if zan_proc('P', '111308') then Tributacao.NaoTributado := copy(UltimaResp, 3, 16);
            if zan_proc('P', '098508') then Tributacao.Aliquota01 := copy(UltimaResp, 7, 12);
            if zan_proc('P', '099308') then Tributacao.Aliquota02 := copy(UltimaResp, 7, 12);
            if zan_proc('P', '100108') then Tributacao.Aliquota03 := copy(UltimaResp, 7, 12);
            if zan_proc('P', '100908') then Tributacao.Aliquota04 := copy(UltimaResp, 7, 12);
            if zan_proc('P', '101708') then Tributacao.Aliquota05 := copy(UltimaResp, 7, 12);
            if zan_proc('P', '102508') then Tributacao.Aliquota06 := copy(UltimaResp, 7, 12);
            if zan_proc('P', '103308') then Tributacao.Aliquota07 := copy(UltimaResp, 7, 12);
            if zan_proc('P', '104108') then Tributacao.Aliquota08 := copy(UltimaResp, 7, 12);
         end;
      ZanthusIZ11, ZanthusIZ10, ZanthusIZ21, ZanthusIZ41:
         begin
            Result := zan_proc('P', '130108');
            if Result then Tributacao.Substituicao := copy(UltimaResp, 3, 16) else exit;
            if zan_proc('P', '130908') then Tributacao.Isento := copy(UltimaResp, 3, 16);
            if zan_proc('P', '131708') then Tributacao.NaoTributado := copy(UltimaResp, 3, 16);
            if zan_proc('P', '120508') then Tributacao.Aliquota01 := copy(UltimaResp, 7, 12);
            if zan_proc('P', '121308') then Tributacao.Aliquota02 := copy(UltimaResp, 7, 12);
            if zan_proc('P', '122108') then Tributacao.Aliquota03 := copy(UltimaResp, 7, 12);
            if zan_proc('P', '122908') then Tributacao.Aliquota04 := copy(UltimaResp, 7, 12);
            if zan_proc('P', '123708') then Tributacao.Aliquota05 := copy(UltimaResp, 7, 12);
            if zan_proc('P', '124508') then Tributacao.Aliquota06 := copy(UltimaResp, 7, 12);
            if zan_proc('P', '125308') then Tributacao.Aliquota07 := copy(UltimaResp, 7, 12);
            if zan_proc('P', '126108') then Tributacao.Aliquota08 := copy(UltimaResp, 7, 12);
         end;
      Schalter3D:
         begin
            pronto := false;
            UltimaResp := Schalter3D_LeituraXSerial;
            if pos('Erro', Ultimaresp) > 0 then begin
               Result := retornoschd(strtointdef(copy(Ultimaresp, 7, 3), 0));
               exit;
            end;
            tributacao.Isento := tiramsc(copy(UltimaResp, 142, 13));
            tributacao.NaoTributado := tiramsc(copy(UltimaResp, 160, 13));
            tributacao.Substituicao := tiramsc(copy(UltimaResp, 124, 13));
            tributacao.Aliquota00 := tiramsc(copy(UltimaResp, 183, 13));
            tributacao.Aliquota01 := tiramsc(copy(UltimaResp, 224, 13));
            tributacao.Aliquota02 := tiramsc(copy(UltimaResp, 265, 13));
            tributacao.Aliquota03 := tiramsc(copy(UltimaResp, 306, 13));
            tributacao.Aliquota04 := tiramsc(copy(UltimaResp, 347, 13));
            tributacao.Aliquota05 := tiramsc(copy(UltimaResp, 388, 13));
            tributacao.Aliquota06 := tiramsc(copy(UltimaResp, 429, 13));
            tributacao.Aliquota07 := tiramsc(copy(UltimaResp, 470, 13));
            tributacao.Aliquota08 := tiramsc(copy(UltimaResp, 511, 13));
            pronto := true;
         end;
      Schalter2S:
         begin
            grande_retorno := Schalter2S_ecfLeituraXSerial();
            //
            tributacao.Substituicao := tiramsc(copy(UltimaResp, 124, 13));
            tributacao.isento := tiramsc(copy(UltimaResp, 142, 13));
            tributacao.NaoTributado := tiramsc(copy(UltimaResp, 160, 13));
            tributacao.Aliquota01 := tiramsc(copy(UltimaResp, 183, 13));
            tributacao.Aliquota02 := tiramsc(copy(UltimaResp, 224, 13));
            tributacao.Aliquota03 := tiramsc(copy(UltimaResp, 265, 13));
            tributacao.Aliquota04 := tiramsc(copy(UltimaResp, 306, 13));
            tributacao.Aliquota05 := tiramsc(copy(UltimaResp, 347, 13));
            tributacao.Aliquota06 := tiramsc(copy(UltimaResp, 388, 13));
            tributacao.Aliquota07 := tiramsc(copy(UltimaResp, 429, 13));
            tributacao.Aliquota08 := tiramsc(copy(UltimaResp, 470, 13));
            tributacao.Aliquota09 := tiramsc(copy(UltimaResp, 511, 13));
            tributacao.Aliquota10 := tiramsc(copy(UltimaResp, 552, 13));
         end;
      SCFI:
         begin
            grande_retorno := SCFI_ecfLeituraXSerial();
            //
            tributacao.Substituicao := tiramsc(copy(UltimaResp, 124, 13));
            tributacao.isento := tiramsc(copy(UltimaResp, 142, 13));
            tributacao.NaoTributado := tiramsc(copy(UltimaResp, 160, 13));
            tributacao.Aliquota01 := tiramsc(copy(UltimaResp, 183, 13));
            tributacao.Aliquota02 := tiramsc(copy(UltimaResp, 224, 13));
            tributacao.Aliquota03 := tiramsc(copy(UltimaResp, 265, 13));
            tributacao.Aliquota04 := tiramsc(copy(UltimaResp, 306, 13));
            tributacao.Aliquota05 := tiramsc(copy(UltimaResp, 347, 13));
            tributacao.Aliquota06 := tiramsc(copy(UltimaResp, 388, 13));
            tributacao.Aliquota07 := tiramsc(copy(UltimaResp, 429, 13));
            tributacao.Aliquota08 := tiramsc(copy(UltimaResp, 470, 13));
            tributacao.Aliquota09 := tiramsc(copy(UltimaResp, 511, 13));
            tributacao.Aliquota10 := tiramsc(copy(UltimaResp, 552, 13));
         end;
      BematechMP40, BematechMP20, BematechTermica:
         begin
            if bem_proc('27') then begin
               tributacao.Substituicao := copy(UltimaResp, 253, 14); // Valor Subst. Trib.
               tributacao.Isento := copy(UltimaResp, 225, 14); // Valor Isentos
               tributacao.NaoTributado := copy(UltimaResp, 239, 14); // Valor Não Tributados
               tributacao.Aliquota01 := inttostr(strtointdef(copy(Ultimaresp, 1, 14), 0)); // Tribut 1 // Total Trib.  1
               tributacao.Aliquota02 := inttostr(strtointdef(copy(Ultimaresp, 15, 14), 0)); // Tribut 2 // Total Trib.  1
               tributacao.Aliquota03 := inttostr(strtointdef(copy(Ultimaresp, 29, 14), 0)); // Tribut 3 // Total Trib.  1
               tributacao.Aliquota04 := inttostr(strtointdef(copy(Ultimaresp, 43, 14), 0)); // Tribut 4 // Total Trib.  1
               tributacao.Aliquota05 := inttostr(strtointdef(copy(Ultimaresp, 57, 14), 0)); // Tribut 5 // Total Trib.  1
               tributacao.Aliquota06 := inttostr(strtointdef(copy(Ultimaresp, 71, 14), 0)); // Tribut 6 // Total Trib.  1
               tributacao.Aliquota07 := inttostr(strtointdef(copy(Ultimaresp, 85, 14), 0)); // Tribut 7 // Total Trib.  1
               tributacao.Aliquota08 := inttostr(strtointdef(copy(Ultimaresp, 99, 14), 0)); // Tribut 8 // Total Trib.  1
               tributacao.Aliquota09 := inttostr(strtointdef(copy(Ultimaresp, 113, 14), 0)); // Tribut 9 // Total Trib.  1
            end;
         end;
      Elgin:
         begin
            if bem_proc('27') then begin
               tributacao.Substituicao := copy(UltimaResp, 253, 14); // Valor Subst. Trib.
               tributacao.Isento := copy(UltimaResp, 225, 14); // Valor Isentos
               tributacao.NaoTributado := copy(UltimaResp, 239, 14); // Valor Não Tributados
               tributacao.Aliquota01 := inttostr(strtointdef(copy(Ultimaresp, 1, 14), 0)); // Tribut 1 // Total Trib.  1
               tributacao.Aliquota02 := inttostr(strtointdef(copy(Ultimaresp, 15, 14), 0)); // Tribut 2 // Total Trib.  1
               tributacao.Aliquota03 := inttostr(strtointdef(copy(Ultimaresp, 29, 14), 0)); // Tribut 3 // Total Trib.  1
               tributacao.Aliquota04 := inttostr(strtointdef(copy(Ultimaresp, 43, 14), 0)); // Tribut 4 // Total Trib.  1
               tributacao.Aliquota05 := inttostr(strtointdef(copy(Ultimaresp, 57, 14), 0)); // Tribut 5 // Total Trib.  1
               tributacao.Aliquota06 := inttostr(strtointdef(copy(Ultimaresp, 71, 14), 0)); // Tribut 6 // Total Trib.  1
               tributacao.Aliquota07 := inttostr(strtointdef(copy(Ultimaresp, 85, 14), 0)); // Tribut 7 // Total Trib.  1
               tributacao.Aliquota08 := inttostr(strtointdef(copy(Ultimaresp, 99, 14), 0)); // Tribut 8 // Total Trib.  1
               tributacao.Aliquota09 := inttostr(strtointdef(copy(Ultimaresp, 113, 14), 0)); // Tribut 9 // Total Trib.  1
            end;
         end;
      Procomp_2011:
         begin
            LeProComp(Procomp_EcfParEsp(Pchar('32')), True);
            Procomp_ObtemRetorno(PtRetorno);
            tributacao.Isento := copy(StrPas(PtRetorno), 6, 15); // Valor Isentos

            LeProComp(Procomp_EcfParEsp(Pchar('33')), True);
            Procomp_ObtemRetorno(PtRetorno);
            tributacao.NaoTributado := copy(StrPas(PtRetorno), 6, 15); // Valor Não Tributados

            LeProComp(Procomp_EcfParEsp(Pchar('34')), True);
            Procomp_ObtemRetorno(PtRetorno);
            tributacao.Substituicao := copy(StrPas(PtRetorno), 6, 15); // Valor Subst. Trib.

            LeProComp(Procomp_TransTabAliquotas, True);
            Procomp_ObtemRetorno(PtRetorno);
            a := StrPas(PtRetorno);

            tributacao.Aliquota00 := copy(a, 6, 4); // Tribut 1 // Total Trib.  1
            tributacao.Aliquota01 := copy(a, 10, 4); // Tribut 1 // Total Trib.  1
            tributacao.Aliquota02 := copy(a, 14, 4); // Tribut 2 // Total Trib.  1
            tributacao.Aliquota03 := copy(a, 18, 4); // Tribut 3 // Total Trib.  1
            tributacao.Aliquota04 := copy(a, 22, 4); // Tribut 4 // Total Trib.  1
            tributacao.Aliquota05 := copy(a, 26, 4); // Tribut 5 // Total Trib.  1
            tributacao.Aliquota06 := copy(a, 30, 4); // Tribut 6 // Total Trib.  1
            tributacao.Aliquota07 := copy(a, 34, 4); // Tribut 7 // Total Trib.  1
            tributacao.Aliquota08 := copy(a, 38, 4); // Tribut 8 // Total Trib.  1
            tributacao.Aliquota09 := copy(a, 42, 4); // Tribut 9 // Total Trib.  1
            tributacao.Aliquota10 := copy(a, 46, 4); // Tribut 10 // Total Trib.  1
            tributacao.Aliquota11 := copy(a, 50, 4); // Tribut 11// Total Trib.  1
            tributacao.Aliquota12 := copy(a, 54, 4); // Tribut 12 // Total Trib.  1
            tributacao.Aliquota13 := copy(a, 58, 4); // Tribut 13 // Total Trib.  1
            tributacao.Aliquota14 := copy(a, 62, 4); // Tribut 14 // Total Trib.  1
            tributacao.Aliquota15 := copy(a, 66, 4); // Tribut 15 // Total Trib.  1

            Pronto := True;
         end;
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Trends_EcfPar('32', UltimaResp); // Isentos
            tributacao.Isento := copy(ultimaresp, 10, 11);
            Trends_EcfPar('34', UltimaResp); // Substituicao
            tributacao.Substituicao := copy(ultimaresp, 10, 11);
            Trends_EcfPar('33', UltimaResp); // Substituicao
            tributacao.NaoTributado := copy(ultimaresp, 10, 11);
            Trends_EcfPar('00', UltimaResp); // T00
            tributacao.Aliquota00 := copy(ultimaresp, 10, 11);
            Trends_EcfPar('01', UltimaResp); // T01
            tributacao.Aliquota01 := copy(ultimaresp, 10, 11);
            Trends_EcfPar('02', UltimaResp); // T02
            tributacao.Aliquota02 := copy(ultimaresp, 10, 11);
            Trends_EcfPar('03', UltimaResp); // T03
            tributacao.Aliquota03 := copy(ultimaresp, 10, 11);
            Trends_EcfPar('04', UltimaResp); // T04
            tributacao.Aliquota04 := copy(ultimaresp, 10, 11);
            Trends_EcfPar('05', UltimaResp); // T05
            tributacao.Aliquota05 := copy(ultimaresp, 10, 11);
            Trends_EcfPar('06', UltimaResp); // T06
            tributacao.Aliquota06 := copy(ultimaresp, 10, 11);
            Trends_EcfPar('07', UltimaResp); // T07
            tributacao.Aliquota07 := copy(ultimaresp, 10, 11);
            Result := Trends_ret(Trends_EcfPar('08', UltimaResp)); // T08
            tributacao.Aliquota08 := copy(ultimaresp, 10, 11);

         end;
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////
function TDefFPrinter.AbreGaveta: Boolean;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis: Result := DTR_Proc('N');
      Sweda03, Sweda10:
         begin
            iRetorno := Sweda_AcionaGaveta;
            Analisa_iRetorno();
            Result:= (iRetorno=1);
         end;

      NCR2x, NCR7141, NCR1x: Result := NCR_Proc('21');
      Urano2EFE: result := Urn_Ret(Urano2EFE_AGaveta);
      Urano1EFC, Urano2EFC: result := Urn_Ret3(UranoEFC_AbreGaveta);
      Urano1FIT: result := Urn_Ret2(Urano1FIT_AbreGaveta);
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41: Result := zan_proc('T', '');
      Schalter3D: Schalter3D_AbreGaveta;
      Schalter2S: Result := retsch2(Schalter2S_ecfAbreGaveta);
      SCFI: SCFI_ecfAbreGaveta;
      BematechMP40, BematechMP20, BematechTermica: begin
              iRetorno := Bematech_AcionaGaveta;
              Analisa_iRetorno();
              Result:= (iRetorno=1);
      end;
      Elgin: begin
              iRetorno := Elgin_AcionaGaveta;
              Analisa_iRetorno();
              Result:= (iRetorno=1);
      end;
      Procomp_2011: LeProComp(Procomp_AbrirGaveta('0', '2', '2'), True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_AbrirGaveta('0', #12, #48, UltimaResp)); // Isentos
         end;

      AFRAC:
      begin
        iRetorno := AFRAC_AbrirGaveta;
        Analisa_iRetorno();
        Result:= (iRetorno=0);
      end;

      DarumaMatr, DarumaTerm:
      begin
        iRetorno := Daruma_FI_AcionaGaveta;
        Result   := iRetorno=1;
        Analisa_iRetorno();
      end;
   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////
function TDefFPrinter.ReducaoZ( Data: TDateTime; Hora: String ): Boolean;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis: Result := DTR_Proc('HS');
      Sweda03, Sweda10:
         begin
            iRetorno := Sweda_ReducaoZ(DateToStr(Data), Hora);
            Analisa_iRetorno();
            Result:= (iRetorno=1);
         end;

      NCR1x: Result := NCR_Proc('09');
      NCR2x, NCR7141: Result := NCR_Proc('090');
      Urano2EFE:
         begin
            result := Urn_ret(Urano2EFE_iniciaxz('1'));
            Urano2EFE_finalizaxz(PChar(Dados.Operador));
            Urano2EFE_avancolinha(0, 5);
            Urano2EFE_imprimecabecalho;
         end;
      Urano1EFC:
         begin
            result := Urn_ret3(UranoEFC_Relatorio_XZ('1'));
            sleep(2000);
            UranoEFC_AvancaLinhas('5');
            //UranoEFC_imprimecabecalho;
         end;
      Urano2EFC:
         begin
            result := Urn_ret3(UranoEFC_Relatorio_XZ('1'));
            sleep(2000);
            UranoEFC_AvancaLinhas('6');
         end;
      Urano1FIT:
         begin
            result := true;
            Urano1FIT_Relatorio_XZ('1');
            //sleep(10000);
            Urano1FIT_AvancaLinhas('08');
         end;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            Result := zan_proc('4', '');
            zan_proc('U', '00'); // avanca ate linha de corte
         end;
      Schalter3D:
         begin
            Result := retornoschd(Schalter3D_ReducaoZ(''));
            Schalter3D_LineFeed(1, 7);
         end;
      Schalter2S:
         begin
            Result := retsch2(Schalter2S_ecfReducaoZ(pchar('Oper:' + dados.operador)));
            Schalter2S_ecfLineFeed(1, 7);
         end;
      SCFI:
         begin
           iRetorno := SCFI_ecfReducaoZ(pchar('Oper:' + dados.operador));
           Analisa_iRetorno;
           Result := (iRetorno=0);
           SCFI_ecfLineFeed(1, 7);
         end;
      BematechMP40, BematechMP20, BematechTermica: begin
              iRetorno := Bematech_ReducaoZ(DateToStr(Data),Hora );
              Analisa_iRetorno();
              Result:= (iRetorno=1);
      end;

      Elgin:
      begin
        iRetorno := Elgin_ReducaoZ(DateToStr(Data), Hora );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
      end;

      Procomp_2011: LeProComp(Procomp_ReducaoZ('0'), True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_ReducaoZ('0', ultimaresp));
         end;

      AFRAC:
      begin
        iRetorno := AFRAC_ReducaoZ(PChar(FormatDateTime('DDMMYYYY', Data)));
        Result   := iRetorno=0;
        Analisa_iRetorno();
      end;

      DarumaMatr, DarumaTerm:
      begin
        iRetorno := Daruma_FI_ReducaoZ;
        Result   := iRetorno=1;
        Analisa_iRetorno();
      end;

   end;
   Result := Result And Retorno_Impressora;
   If Result And Assigned(FAfterReducaoZ) Then
     FAfterReducaoZ(Self);
end;
///////////////////////////////////////////////////////////////
function TDefFPrinter.AbreDiaFiscal(Data: TDateTime; Valor: Currency; Operador: string): Boolean;
var
   Txt: textfile;
   linha: string;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis:
         begin
            DTR_Proc('GNS');
            if (copy(eprom, 5, 1) = '4') or (copy(eprom, 5, 1) = '3') then result := DTR_Proc('O' + zcomp(Operador, 6)) else result := DTR_Proc('O' + zcomp(Operador, 3));
         end;
      Sweda03, Sweda10:
      begin
        iRetorno := Sweda_AberturaDoDia(pchar(MyFormatCur(Valor, '.')), pchar('Dinheiro'));
        Analisa_iRetorno();
        Result:= (iRetorno=1);
      end;

      NCR1x: begin
            Result := NCR_Proc('07' + Operador);
            if not Result then Result := NCR_Proc('010\' + Operador);
         end;
      NCR2x, NCR7141: begin
            Result := NCR_Proc('07' + Operador);
            if not Result then Result := NCR_Proc('010\' + Operador + '\0');
         end;
      Urano2EFE: Result := EmiteLeiturax('N');
      Urano1EFC:
         begin
            result := Urn_ret3(UranoEFC_Relatorio_XZ('0'));
            sleep(2000);
            UranoEFC_AvancaLinhas('05');
         end;
      Urano2EFC:
         begin
            result := Urn_ret3(UranoEFC_Relatorio_XZ('0'));
            sleep(2000);
            UranoEFC_AvancaLinhas('08');
         end;
      Urano1FIT:
         begin
            result := Urn_ret2(Urano1FIT_Relatorio_XZ('0'));
            Urano1FIT_AvancaLinhas('06');
         end;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            if (impressora = ZanthusIZ11) or (impressora = ZanthusIZ21) or (impressora = ZanthusIZ41) then zan_proc('P', '117201');
            if (impressora = ZanthusIZ10) or (impressora = ZanthusIZ20) or (impressora = Zanthus2e) then zan_proc('P', '095201');
            if copy(UltimaResp, 3, 2) = '01' then Result := zan_proc('1', '') // Abre dia
            else Result := zan_proc('3', ''); // emite X
            if result then begin
               if impressora = ZanthusIZ41 then zan_proc('U', '08') else zan_proc('U', '06'); // avanca 3 linhas
               zan_proc('6', ''); // Imprime cabecalho
            end;
         end;
      Schalter3D:
         begin
            Result := retornoschd(Schalter3D_LeituraX(''));
            retornoSchd(Schalter3D_lineFeed(1, 7));
         end;
      Schalter2S:
         begin
            Result := retsch2(Schalter2S_ecfLeituraX(PChar('Oper:' + dados.operador)));
            Schalter2S_ecfLineFeed(1, 7);
         end;
      SCFI:
         begin
           iRetorno := SCFI_ecfLeituraX('');
           Analisa_iRetorno();
           Result := (iRetorno=0);
         end;
      BematechMP40, BematechMP20, BematechTermica:
         begin
              iRetorno := Bematech_AberturaDoDia(pchar(MyFormatCur(Valor, '.')), pchar('Dinheiro'));
              Analisa_iRetorno();
              Result:= (iRetorno=1);
         end;
      Elgin:
         begin
              iRetorno := Elgin_AberturaDoDia(pchar(MyFormatCur(Valor, ',')), pchar('Dinheiro'));
              Analisa_iRetorno();
              Result:= (iRetorno=1);
         end;
      Procomp_2011: LeProComp(Procomp_LeituraX('0'), True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_LeituraX('0', UltimaResp));
         end;

      AFRAC:
      begin
        iRetorno := AFRAC_AbrirDia(PChar(FormatDateTime('DDMMYYYY', DATA)));
        Result := iRetorno=0;
        Analisa_iRetorno;
      end;

      DarumaMatr, DarumaTerm:
      begin
        iRetorno := Daruma_FI_AberturaDoDia(MyFormatCur(Valor, '.'), 'Dinheiro');
        Result := iRetorno = 1;
        Analisa_iRetorno;
      end;
   end;

   Result := Result And Retorno_Impressora();

   If Result And Assigned(FAfterAbreDiaFiscal) Then
     FAfterAbreDiaFiscal(Self);

end;
////////////////////////////////////////////////////////////////
function TDefFPrinter.FechaDiaFiscal(Operador: string): Boolean;
var
   Txt: textfile;
   linha: string;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis:
         begin
            DTR_Proc('GNS');
            if (copy(eprom, 5, 1) = '4') or (copy(eprom, 5, 1) = '3') then result := DTR_Proc('O' + zcomp(Operador, 6)) else result := DTR_Proc('O' + zcomp(Operador, 3));
         end;
      Sweda03, Sweda10:
      begin
        iRetorno := Sweda_FechamentoDoDia;
        Analisa_iRetorno();
        Result:= (iRetorno=1);
      end;
      NCR1x: begin
            Result := NCR_Proc('07' + Operador);
            if not Result then Result := NCR_Proc('010\' + Operador);
         end;
      NCR2x, NCR7141: begin
            Result := NCR_Proc('07' + Operador);
            if not Result then Result := NCR_Proc('010\' + Operador + '\0');
         end;
      Urano2EFE: Result := EmiteLeiturax('N');
      Urano1EFC:
         begin
            result := Urn_ret3(UranoEFC_Relatorio_XZ('0'));
            sleep(2000);
            UranoEFC_AvancaLinhas('05');
         end;
      Urano2EFC:
         begin
            result := Urn_ret3(UranoEFC_Relatorio_XZ('0'));
            sleep(2000);
            UranoEFC_AvancaLinhas('08');
         end;
      Urano1FIT:
         begin
            result := Urn_ret2(Urano1FIT_Relatorio_XZ('0'));
            Urano1FIT_AvancaLinhas('06');
         end;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            if (impressora = ZanthusIZ11) or (impressora = ZanthusIZ21) or (impressora = ZanthusIZ41) then zan_proc('P', '117201');
            if (impressora = ZanthusIZ10) or (impressora = ZanthusIZ20) or (impressora = Zanthus2e) then zan_proc('P', '095201');
            if copy(UltimaResp, 3, 2) = '01' then Result := zan_proc('1', '') // Abre dia
            else Result := zan_proc('3', ''); // emite X
            if result then begin
               if impressora = ZanthusIZ41 then zan_proc('U', '08') else zan_proc('U', '06'); // avanca 3 linhas
               zan_proc('6', ''); // Imprime cabecalho
            end;
         end;
      Schalter3D:
         begin
            Result := retornoschd(Schalter3D_LeituraX(''));
            retornoSchd(Schalter3D_lineFeed(1, 7));
         end;
      Schalter2S:
         begin
            Result := retsch2(Schalter2S_ecfLeituraX(PChar('Oper:' + dados.operador)));
            Schalter2S_ecfLineFeed(1, 7);
         end;
      SCFI:
         begin
           iRetorno := SCFI_ecfLeituraX(PChar('Oper:' + dados.operador));
           Analisa_iRetorno();
           Result := (iRetorno=0);
           if Result then
           begin
             iRetorno := SCFI_ecfReducaoZ(PChar('Oper:' + dados.operador));
             Analisa_iRetorno();
             Result := (iRetorno=0);
           end;
         end;
      BematechMP40, BematechMP20, BematechTermica:
         begin
              iRetorno := Bematech_FechamentoDoDia;
              Analisa_iRetorno();
              Result:= (iRetorno=1);
         end;
      Elgin:
         begin
              iRetorno := Elgin_FechamentoDoDia;
              Analisa_iRetorno();
              Result:= (iRetorno=1);
         end;
      Procomp_2011: LeProComp(Procomp_LeituraX('0'), True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_LeituraX('0', UltimaResp));
         end;
      AFRAC:
      begin
        iRetorno := AFRAC_ReducaoZ(PChar(FormatDateTime('DDMMYYYY', Date)));
        Result:= (iRetorno=0);
        Analisa_iRetorno();
      end;
      DarumaMatr, DarumaTerm:
      begin
        iRetorno := Daruma_FI_FechamentoDoDia;
        Result:= (iRetorno=1);
        Analisa_iRetorno();

        //Tem que emitir a Z depois do fechamento
        if Result then
        begin
          iRetorno := Daruma_FI_ReducaoZ;
          Result   := (iRetorno=1);
          Analisa_iRetorno();
        end;
      end;
   end;
   Result := Result And Retorno_Impressora();
   If Result And Assigned(FAfterReducaoZ) Then
     FAfterReducaoZ(Self);
end;
/////////////////////////////////////////////////////////////////
function TDefFPrinter.CancelaUltimoCupom(Valor: string): Boolean;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis: result := DTR_Proc('F');

      Sweda03, Sweda10:
      begin
        Result := bem_proc('14');
      end;

      NCR2x, NCR7141, NCR1x: Result := NCR_Proc('02' + Valor);
      Urano2EFE:
         begin
            result := Urn_ret(Urano2EFE_cancelacupom(PChar(Dados.Operador)));
            if Result then Urano2EFE_avancolinha(0, 7);
         end;
      Urano1EFC:
         begin
            Result := urn_ret3(UranoEFC_CancelaCupom('1', Dados.Operador));
            sleep(2000);
            UranoEFC_avancalinhas('05');
         end;
      Urano2EFC:
         begin
            Result := urn_ret3(UranoEFC_CancelaCupom('1', Dados.Operador));
            sleep(2000);
            UranoEFC_avancalinhas('08');
         end;
      Urano1FIT:
         begin
            result := Urn_ret2(Urano1FIT_cancelacupom(Dados.Operador));
            Urn_ret2(Urano1FIT_AvancaLinhas('06'));
         end;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            result := zan_proc('B', '');
            if result then zan_proc('@', '');
            zan_proc('U', '00'); // avanca ate linha de corte
         end;
      Schalter3D:
         begin
            Result := retornoschd(Schalter3D_CancDoc(''));
            Schalter3D_LineFeed(1, 7);
         end;
      Schalter2S:
         begin
            Result := retsch2(Schalter2S_ecfCancDoc(PChar('Oper:' + dados.operador)));
            Schalter2S_ecfLineFeed(1, 7);
         end;
      SCFI:
         begin
            iRetorno := SCFI_ecfCancDoc('');
            Analisa_iRetorno();
            Result := (iRetorno=0);
            SCFI_ecfLineFeed(1, 7);
         end;
      BematechMP40, BematechMP20, BematechTermica: Result := bem_proc('14');
      Elgin: Result := bem_proc('14');
      Procomp_2011: LeProComp(Procomp_CancelaCupomFiscal, True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_CancelaCupomFiscal(UltimaResp));
         end;
      AFRAC:
      begin
          iRetorno := AFRAC_CancelarCupom{(UltimoCOO)};
          Result := (iRetorno=0);
          Analisa_iRetorno;
      end;
   end;
   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////
function TDefFPrinter.EmiteLeituraX(AbreVinculado: string): Boolean;
begin
   Result := false;
   case Impressora of
      None: exit;
      Dataregis:
         begin
            if AbreVinculado = 'N' then Result := DTR_Proc('GNS') else begin
               if copy(eprom, 2, 1) = '9' then Result := DTR_Proc('GNS') else result := DTR_Proc('j' + space(40));
            end;
            sleep(10000);
         end;
         
      Sweda03, Sweda10:
         begin
         if AbreVinculado = 'N' then
            begin
              iRetorno := Sweda_LeituraX;
              Analisa_iRetorno();
              Result:= (iRetorno=1);
            end
         else
            result := True;
         end;

      NCR1x: if AbreVinculado = 'N' then Result := NCR_Proc('70') else Result := NCR_Proc('04X1');
      NCR2x: if AbreVinculado = 'N' then Result := NCR_Proc('700') else begin
            Result := NCR_Proc('701');
            sleep(2000);
         end;
      NCR7141: if AbreVinculado = 'N' then Result := NCR_Proc('700') else begin
            Result := NCR_Proc('701');
         end;
      Urano2EFE:
         begin
            if AbreVinculado = 'N' then begin
               result := Urn_ret(Urano2EFE_iniciaxz('0'));
               result := Urn_ret(Urano2EFE_finalizaxz(PChar(Dados.Operador)));
               result := Urn_ret(Urano2EFE_avancolinha(0, 7));
            end else begin
               Urano2EFE_imprimecabecalho;
               result := Urn_ret(Urano2EFE_IniciaCupomNFiscal);
            end;
         end;
      Urano1EFC:
         begin
            if AbreVinculado = 'S' then begin
               result := Urn_ret3(UranoEFC_relatorio_xz('2'));
               textolivre := '';
            end else begin
               result := Urn_ret3(UranoEFC_relatorio_xz('0'));
               sleep(2000);
               UranoEFC_AvancaLinhas('05');
            end;
         end;
      Urano2EFC:
         begin
            if AbreVinculado = 'S' then begin
               result := Urn_ret3(UranoEFC_relatorio_xz('2'));
               textolivre := '';
            end else begin
               result := Urn_ret3(UranoEFC_relatorio_xz('0'));
               sleep(2000);
               UranoEFC_AvancaLinhas('08');
            end;
         end;
      Urano1FIT:
         begin
            if AbreVinculado = 'S' then begin
               result := true; //Urn_ret2(Urano1FIT_Relatorio_XZ('2'));
               textolivre := '';
            end;
            if AbreVinculado = 'N' then begin
               result := Urn_ret2(Urano1FIT_Relatorio_XZ('0'));
               Urn_ret2(Urano1FIT_AvancaLinhas('06'));
            end;
         end;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            if AbreVinculado = 'S' then Result := zan_proc('3', '1') else begin
               Result := zan_proc('3', '');
               if result then begin
                  if impressora = ZanthusIZ41 then zan_proc('U', '08') else zan_proc('U', '06'); // avanca 3 linhas
                  zan_proc('6', ''); // Imprime cabecalho
               end;
            end;
         end;
      Schalter3D: if AbreVinculado = 'N' then begin
            Result := retornoschd(Schalter3D_LeituraX(PChar(dados.operador)));
            Schalter3D_LineFeed(1, 7);
         end else begin
            Result := retornoschd(Schalter3D_LXGerencial(PChar(dados.operador)));
            Schalter3D_InicCupomNFiscal(1);
         end;
      Schalter2S: if AbreVinculado = 'S' then begin
            Result := retsch2(Schalter2S_ecfImpCab(1));
            Result := retsch2(Schalter2S_ecfInicCupomNFiscal(1));
         end else begin
            Result := retsch2(Schalter2S_ecfLeituraX(PChar('Oper:' + dados.operador)));
            Schalter2S_ecfLineFeed(1, 7);
         end;
      SCFI: if AbreVinculado = 'S' then begin
            iRetorno := SCFI_ecfImpCab(1);
            Result := iRetorno = 0;
            iRetorno := SCFI_ecfInicCupomNFiscal(1);
            Result := iRetorno = 0;
         end else begin
            iRetorno := SCFI_ecfLeituraX(PChar('Oper:' + dados.operador));
            Result := iRetorno = 0;
            SCFI_ecfLineFeed(1, 7);
         end;
      BematechMP40, BematechMP20, BematechTermica: begin
         if AbreVinculado = 'N' then
            begin
              iRetorno := Bematech_LeituraX;
              Analisa_iRetorno();
              Result:= (iRetorno=1);
            end
         else
            result := true; //Bem_proc('20|'+space(39))
      end;
      Elgin: begin
         if AbreVinculado = 'N' then
            begin
              iRetorno := Elgin_LeituraX;
              Analisa_iRetorno();
              Result:= (iRetorno=1);
            end
         else
            result := true; //Bem_proc('20|'+space(39))
      end;
      Procomp_2011: if AbreVinculado = 'S' then LeProComp(Procomp_LeituraX('1'), True) else LeProComp(Procomp_LeituraX('0'), True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            if AbreVinculado = 'S' then Result := Trends_ret(Trends_LeituraX('1', UltimaResp)) else Result := Trends_ret(Trends_LeituraX('0', UltimaResp));
         end;
      AFRAC:
      begin
        iRetorno := AFRAC_LeituraX;
        Result   := iRetorno=0;
        Analisa_iRetorno; 
      end;
      DarumaMatr, DarumaTerm:
      begin
        iRetorno := Daruma_FI_LeituraX;
        Result   := iRetorno=1;
        Analisa_iRetorno;
      end;
   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////////
function TDefFPrinter.EmiteLeituraXSerial(AbreVinculado: string): Boolean;
begin
   Result := false;
   case Impressora of
      None: exit;
      Dataregis:
         begin
            if AbreVinculado = 'N' then Result := DTR_Proc('GNS') else begin
               if copy(eprom, 2, 1) = '9' then Result := DTR_Proc('GNS') else result := DTR_Proc('j' + space(40));
            end;
            sleep(10000);
         end;

      Sweda03, Sweda10:
         begin
            if AbreVinculado = 'N' then
               begin
                 iRetorno := Sweda_LeituraXSerial;
                 Analisa_iRetorno();
                 Result:= (iRetorno=1);
               end
            else
               Result := true;
         end;
         
      NCR1x: if AbreVinculado = 'N' then Result := NCR_Proc('70') else Result := NCR_Proc('04X1');
      //else begin Result := NCR_Proc('701');
      //sleep(2000);
      //end;
      NCR2x: if AbreVinculado = 'N' then Result := NCR_Proc('700') else begin
            Result := NCR_Proc('701');
            sleep(2000);
         end;
      NCR7141: if AbreVinculado = 'N' then Result := NCR_Proc('700') else begin
            Result := NCR_Proc('701');
         end;
      Urano2EFE:
         begin
            if AbreVinculado = 'N' then begin
               result := Urn_ret(Urano2EFE_iniciaxz('0'));
               result := Urn_ret(Urano2EFE_finalizaxz(PChar(Dados.Operador)));
               result := Urn_ret(Urano2EFE_avancolinha(0, 7));
            end else begin
               Urano2EFE_imprimecabecalho;
               result := Urn_ret(Urano2EFE_IniciaCupomNFiscal);
            end;
         end;
      Urano1EFC:
         begin
            if AbreVinculado = 'S' then begin
               result := Urn_ret3(UranoEFC_relatorio_xz('2'));
               textolivre := '';
            end else begin
               result := Urn_ret3(UranoEFC_relatorio_xz('0'));
               sleep(2000);
               UranoEFC_AvancaLinhas('05');
            end;
         end;
      Urano2EFC:
         begin
            if AbreVinculado = 'S' then begin
               result := Urn_ret3(UranoEFC_relatorio_xz('2'));
               textolivre := '';
            end else begin
               result := Urn_ret3(UranoEFC_relatorio_xz('0'));
               sleep(2000);
               UranoEFC_AvancaLinhas('08');
            end;
         end;
      Urano1FIT:
         begin
            if AbreVinculado = 'S' then begin
               result := true; //Urn_ret2(Urano1FIT_Relatorio_XZ('2'));
               textolivre := '';
            end;
            if AbreVinculado = 'N' then begin
               result := Urn_ret2(Urano1FIT_Relatorio_XZ('0'));
               Urn_ret2(Urano1FIT_AvancaLinhas('06'));
            end;
         end;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            if AbreVinculado = 'S' then Result := zan_proc('3', '1') else begin
               Result := zan_proc('3', '');
               if result then begin
                  if impressora = ZanthusIZ41 then zan_proc('U', '08') else zan_proc('U', '06'); // avanca 3 linhas
                  zan_proc('6', ''); // Imprime cabecalho
               end;
            end;
         end;
      Schalter3D: if AbreVinculado = 'N' then begin
            Result := retornoschd(Schalter3D_LeituraX(PChar(dados.operador)));
            Schalter3D_LineFeed(1, 7);
         end else begin
            Result := retornoschd(Schalter3D_LXGerencial(PChar(dados.operador)));
            Schalter3D_InicCupomNFiscal(1);
         end;
      Schalter2S: if AbreVinculado = 'S' then begin
            Result := retsch2(Schalter2S_ecfImpCab(1));
            Result := retsch2(Schalter2S_ecfInicCupomNFiscal(1));
         end else begin
            Result := retsch2(Schalter2S_ecfLeituraX(PChar('Oper:' + dados.operador)));
            Schalter2S_ecfLineFeed(1, 7);
         end;
      SCFI: if AbreVinculado = 'S' then begin
            iRetorno := SCFI_ecfImpCab(1);
            Result := iRetorno = 0;
            iRetorno := SCFI_ecfInicCupomNFiscal(1);
            Result := iRetorno = 0;
         end else begin
            iRetorno := SCFI_ecfLeituraX(PChar('Oper:' + dados.operador));
            Result := iRetorno = 0;
            SCFI_ecfLineFeed(1, 7);
         end;   
      BematechMP40, BematechMP20, BematechTermica: begin
        if AbreVinculado = 'N' then
           begin
              iRetorno := Bematech_LeituraXSerial;
              Analisa_iRetorno();
              Result:= (iRetorno=1);
           end
        else
           result := true; //Bem_proc('20|'+space(39))
        end;

       Elgin: begin
        if AbreVinculado = 'N' then
           begin
              iRetorno := Elgin_LeituraXSerial;
              Analisa_iRetorno();
              Result:= (iRetorno=1);
           end
        else
           result := true; //Bem_proc('20|'+space(39))
        end;
      Procomp_2011: if AbreVinculado = 'S' then LeProComp(Procomp_LeituraX('1'), True) else LeProComp(Procomp_LeituraX('0'), True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            if AbreVinculado = 'S' then Result := Trends_ret(Trends_LeituraX('1', UltimaResp)) else Result := Trends_ret(Trends_LeituraX('0', UltimaResp));
         end;
   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.AbreCupomVinculado(Cupom, FormaPgto, Finalizadora, IndVinculado, Valor: String): Boolean;
var
  pCupom: PChar;
  pFormaPgto: PChar;
  pIndice: PChar;
  pValor: PChar;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis:
         begin
            Result := DTR_Proc('J' + zcomp(inttostr(strtointdef(FormaPgto, 0) - 2), 2) + space(38));
            sleep(2000);
         end;
      Sweda03, Sweda10:
      begin
         iRetorno := Sweda_AbreComprovanteNaoFiscalVinculado(PChar(Copy(FormaPgto, 1, 16)), PChar(MyFormatCur(StrToFloat(Valor), ',')), PChar(Copy(Cupom, 1, 6)));
         Result := iRetorno=1;
         Analisa_iRetorno;
      end;
      
      NCR1x: Result := NCR_Proc('04X1');
      NCR2x: Result := NCR_Proc('04X0');
      NCR7141: Result := NCR_Proc('04X0\' + zcomp(IntToStr(strtoint(formapgto) - 1), 2) + '\' + valor);
      Urano2EFE: result := URN_ret(Urano2EFE_IniciaCupomNFiscal);
      Urano1FIT:
         begin
            cupom := IntToStr(strtointdef(cupom, 0) + 1);
            contai_zant := strtointdef(cupom, 0);
            Result := urn_ret2(Urano1FIT_VinculadoNSeq(cupom, '00', trim(finalizadora)));
            textolivre := '';
         end;
      Urano1EFC: Result := urn_ret3(UranoEFC_emitevinculado(PChar(IntToStr(strtointdef(cupom, 0))), PChar('01')));
      Urano2EFC: Result := urn_ret3(UranoEFC_emitevinculado(PChar(IntToStr(strtointdef(cupom, 0) - 1)), PChar('01')));
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41: Result := zan_proc('?', '');
      //Schalter3D:retornoschd(ecfInicCNFVinculado(PChar(cupom),PChar(FormaPgto),pchar('000000150')));
      Schalter3D:
         begin
            atualizaeprom;
            if eprom = '3.00D' then begin
               Result := retornoschd(Schalter3D_LXGerencial(''));
               Schalter3D_InicCupomNFiscal(1);
            end;
            if (eprom = '3.01D') or (eprom = '3.02D') or (eprom = '3.03D') or (eprom = '3.01S') or (eprom = '3.02S') or (eprom = '3.03S') then begin
               atualizavalorcupom;
               retornoschd(Schalter3D_ImpCab(0));
               //MessageDlg('Cupom: ' + cupom + #13 + 'Formapagto: ' + FormaPgto + #13 + 'Valorcupom: ' + valorcupom,mtWarning, [mbOK],0);
               Result := retornoschd(Schalter3D_InicCNFVinculado(PChar(IntToStr(strtointdef(cupom, 1) + 1)), '00', PChar(valor)));
               //Result := retornoschd(ecfInicCNFVinculado(PChar(cupom),PChar(FormaPgto), PChar(valorcupom)));
               Result := true;
            end;
         end;
      Schalter2S:
         begin
            Result := retsch2(Schalter2S_ecfImpCab(1));
            Result := retsch2(Schalter2S_ecfInicCupomNFiscal(1));
         end;
      SCFI:
         begin
            pCupom := PChar(Cupom);
            pIndice := PChar(IndVinculado);
            pValor := PChar(StringReplace(MyFormatCur(StrToFloat(Valor), '.'), '.', '', [rfReplaceAll]));

            iRetorno := SCFI_ecfImpCab(1);
            Result   := (iRetorno=0) or (iRetorno=65);
            if Result then
            begin
               iRetorno := SCFI_ecfInicCNFVinculado(pCupom, pIndice, pValor);
               Analisa_iRetorno();
               Result := (iRetorno=0);
            end;
         end;
      BematechMP40, BematechMP20, BematechTermica: begin
         iRetorno := Bematech_AbreComprovanteNaoFiscalVinculado(PChar(Copy(FormaPgto, 1, 16)), PChar(''), PChar(''));
         Result := iRetorno=1;
         Analisa_iRetorno;
         //Result := Bem_proc('66|' + Trim(Finalizadora) + '|');
         end;
      Elgin: begin
         iRetorno := Elgin_AbreComprovanteNaoFiscalVinculado(PChar(Copy(FormaPgto, 1, 16)), PChar(MyFormatCur(StrToFloat(Valor), ',')), PChar(Copy(Cupom, 1, 6)));
         Result := iRetorno=1;
         Analisa_iRetorno;
         //Result := Bem_proc('66|' + Trim(Finalizadora) + '|');
         end;
      Procomp_2011: LeProcomp(Procomp_AbreCupomVinculado(), True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_AbreCupomVinculado(UltimaResp));
         end;
      AFRAC:
      begin
        {FillChar(pFormaPgto, 31, 0);
        FillChar(pIndice, 3, 0);


        StrPCopy(pIndice, FormatFloat('13',0));

        StrPCopy(pFormaPgto, '');

        iRetorno := AFRAC_LerFormasDePagamento(pIndice, pFormaPgto);

        if iRetorno = 0 then
        begin
          //FillChar(pIndice, 3, 0);
          //StrPCopy(pIndice, IndVinculado);

          //FillChar(pCupom, 7, 0);
          StrPCopy(pCupom, IncCharEx(Cupom, 6, '0', 'L'));

          //FillChar(pValor, 17, 0);
          StrPCopy(pValor, ValorCupom);

          //3143
          iRetorno := AFRAC_AbrirVinculado(pCupom, pIndice, pValor);
        end;}

        pCupom := PChar(Cupom);
        pIndice := PChar(IndVinculado);
        pValor := PChar(MyFormatCur(StrToFloat(Valor), '.'));




        iRetorno := AFRAC_AbrirVinculado(pCupom, pIndice, pValor);
        Result := iRetorno = 0;
        Analisa_iRetorno;
      end;

      DarumaMatr, DarumaTerm:
      begin
         iRetorno := Daruma_FI_AbreComprovanteNaoFiscalVinculado(Copy(FormaPgto, 1, 16), MyFormatCur(StrToFloat(Valor), ','), Cupom);
         Result := iRetorno=1;
         Analisa_iRetorno;
      end;

   end;
   Result := Result And Retorno_Impressora;

   If Result And Assigned(FAfterAbreCupomVinculado) Then
     FAfterAbreCupomVinculado(Self);

end;
////////////////////////////////////////////////////////////////

function TDefFPrinter.TextoCupomVinculado(Dados: string): Boolean;
var
  pDados: array[0..48] of char;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis: result := DTR_Proc('J' + copy(dados + space(40), 1, 40));
      Sweda03, Sweda10:
      begin
        iRetorno := Sweda_UsaComprovanteNaoFiscalVinculado(PChar(Dados));
        Result := iRetorno=1;
        Analisa_iRetorno;
      end;

      NCR2x, NCR7141, NCR1x: Result := NCR_Proc('08' + copy(dados, 1, 40));
      Urano2EFE:
         begin
            if dados = #13 then dados := ' ';
            result := URN_ret(Urano2EFE_ImprimeLinhaNFiscal(pchar(copy(dados + space(40), 1, 40))));
         end;
      Urano1EFC:
         begin
            Result := true;
            if dados = #13 then begin
               if trim(textolivre) = '' then textolivre := space(47) + '.';
               Result := urn_ret3(UranoEFC_LinhasLivres(textolivre));
               textolivre := '';
               exit;
            end;
            if trim(dados) = '' then dados := space(43) + '.';
            textolivre := textolivre + copy('    ' + dados + space(48), 1, 48);
            if Length(textolivre) > 432 then begin
               Result := urn_ret3(UranoEFC_LinhasLivres(PChar(textolivre)));
               textolivre := '';
            end;
         end;
      Urano2EFC:
         begin
            Result := true;
            if dados = #13 then begin
               if trim(textolivre) = '' then textolivre := space(41) + '.';
               Result := urn_ret3(UranoEFC_LinhasLivres(textolivre));
               textolivre := '';
               exit;
            end;
            if trim(dados) = '' then dados := space(41) + '.';
            textolivre := textolivre + copy(dados + space(42), 1, 42);
            if Length(textolivre) > 378 then begin
               Result := urn_ret3(UranoEFC_LinhasLivres(PChar(textolivre)));
               textolivre := '';
            end;
         end;
      Urano1FIT:
         begin
            Result := true;
            if (dados = #13) then begin
               textolivre := textolivre + space(40) + #13;
               Result := URN_ret2(Urano1FIT_LInhasLivres(IntToStr(Length(textolivre)), textolivre));
               textolivre := '';
               exit;
            end;
            dados := copy(dados + space(40), 1, 40) + #13;
            textolivre := textolivre + dados;
            if (Length(textolivre) = 410) then begin
               Result := URN_ret2(Urano1FIT_LInhasLivres(IntToStr(Length(textolivre)), textolivre));
               textolivre := '';
            end;
         end;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41: Result := zan_proc('!', copy(dados, 1, 40));
      Schalter3D: Result := retornoschd(Schalter3D_implinha(pchar(copy(dados, 1, 40))));
      Schalter2S: Result := retsch2(Schalter2S_ecfImpLinha(pchar(copy(dados, 1, 40))));
      SCFI: begin
              iRetorno := SCFI_ecfImpLinha(pchar(copy(dados, 1, 40)));
              Analisa_iRetorno();
              Result := (iRetorno = 0);
         end;
      {BematechMP20:
         begin
            if dados = #13 then dados := space(40);
            if trim(copy(dados, 48, 1)) <> '' then result := bem_proc('67|' + copy(Dados + space(48), 1, 48)) else result := bem_proc('67|' + copy(Dados + space(48), 1, 47) + '.');
         end;}
      BematechMP20, BematechMP40, BematechTermica:  begin
            iRetorno := Bematech_UsaComprovanteNaoFiscalVinculado(PChar(Dados));
            //iRetorno := Bematech_UsaComprovanteNaoFiscalVinculadoTEF(PChar(Dados));
            Result := iRetorno=1;
            Analisa_iRetorno;
            {
            if dados = #13 then dados := space(40);
            if trim(copy(dados, 40, 1)) <> '' then result := bem_proc('67|' + copy(Dados + space(40), 1, 40)) else result := bem_proc('67|' + copy(Dados + space(39), 1, 39) + '.');
            }
         end;
      Elgin:  begin
            iRetorno := Elgin_UsaComprovanteNaoFiscalVinculado(PChar(Dados));
            Result := iRetorno=1;
            Analisa_iRetorno;
         end;
      Procomp_2011: LeProcomp(Procomp_ImprimeLinhaNaoFiscal('0', sdcomp(dados, 40)), True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_ImprimeLinhaNaoFiscal('0', space(4) + sdcomp(dados, 44), ultimaresp));
         end;
      AFRAC:
      begin
        FillChar(pDados, 49, 0);
        strPCopy(pDados, Copy(Dados, 1, 48));

        iRetorno := AFRAC_ImprimirVinculado(pDados, PChar(StringOfChar(' ',48)));
        Result := iRetorno=0;
        Analisa_iRetorno;
      end;

      DarumaMatr, DarumaTerm:
      begin
        iRetorno  := Daruma_FI_EnviarTextoCNF(Copy(Dados, 1, 600));
        Result := iRetorno=1;
        Analisa_iRetorno;
      end;
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////
function TDefFPrinter.TextoVinculadoX(Dados: string): Boolean;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis: result := DTR_Proc('j' + copy(dados + space(40), 1, 40));
      Sweda03: Result := swd_proc(#27 + '.080D' + copy(dados, 1, 40) + '}');
      Sweda10: Result := swd_proc(#27 + '.080' + copy(dados, 1, 40) + '}');
      NCR2x, NCR7141, NCR1x: Result := NCR_Proc('08' + copy(dados, 1, 40));
      Urano2EFE: result := URN_ret(Urano2EFE_ImprimeLinhaNFiscal(pchar(copy(dados, 1, 40))));
      Urano1EFC:
         begin
            if dados = #13 then begin
               if trim(textolivre) = '' then textolivre := space(47) + '.';
               Result := urn_ret3(UranoEFC_LinhasLivres(PChar(textolivre)));
               textolivre := '';
               exit;
            end;
            if trim(dados) = '' then dados := space(43) + '.';
            textolivre := textolivre + copy('    ' + dados + space(48), 1, 48);
            if Length(textolivre) > 432 then begin
               result := urn_ret3(UranoEFC_LinhasLivres(PChar(textolivre)));
               textolivre := '';
            end else Result := true;
         end;
      Urano2EFC:
         begin
            if dados = #13 then begin
               if trim(textolivre) = '' then textolivre := space(41) + '.';
               Result := urn_ret3(UranoEFC_LinhasLivres(PChar(textolivre)));
               textolivre := '';
               exit;
            end;
            if trim(dados) = '' then dados := space(41) + '.';
            textolivre := textolivre + copy(dados + space(42), 1, 42);
            if Length(textolivre) > 378 then begin
               result := urn_ret3(UranoEFC_LinhasLivres(PChar(textolivre)));
               textolivre := '';
            end else Result := true;
         end;
      Urano1FIT:
         begin
            if (dados = #13) then begin
               textolivre := textolivre + space(40) + #13;
               Result := URN_ret2(Urano1FIT_LInhasLivres(IntToStr(Length(textolivre)), textolivre));
               textolivre := '';
               exit;
            end;
            dados := copy(dados + space(40), 1, 40) + #13;
            textolivre := textolivre + dados;
            if Length(textolivre) = 410 then begin
               Result := URN_ret2(Urano1FIT_LInhasLivres(IntToStr(Length(textolivre)), textolivre));
               textolivre := '';
            end else Result := true;
         end;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41: Result := zan_proc('!', copy(dados, 1, 40));
      Schalter3D: retornoschd(Schalter3D_implinha(pchar(copy(dados, 1, 40))));
      Schalter2S: Result := retsch2(Schalter2S_ecfImpLinha(pchar(copy(dados, 1, 40))));
      SCFI:
         begin
            iRetorno := SCFI_ecfImpLinha(pchar(copy(dados, 1, 40)));
            Result := iRetorno = 0;
         end;
      BematechMP20:
         begin
            if dados = #13 then dados := space(40);
            if trim(copy(dados, 48, 1)) <> '' then result := bem_proc('20|' + copy(Dados + space(48), 1, 48)) else result := bem_proc('20|' + copy(Dados + space(48), 1, 47) + '.');
         end;
      BematechMP40, BematechTermica: begin
            if dados = #13 then dados := space(40);
            if trim(copy(dados, 40, 1)) <> '' then result := bem_proc('20|' + copy(Dados + space(40), 1, 40)) else result := bem_proc('20|' + copy(Dados + space(39), 1, 39) + '.');
         end;
      Elgin: begin
            if dados = #13 then dados := space(40);
            if trim(copy(dados, 40, 1)) <> '' then result := bem_proc('20|' + copy(Dados + space(40), 1, 40)) else result := bem_proc('20|' + copy(Dados + space(39), 1, 39) + '.');
         end;
      Procomp_2011: LeProcomp(Procomp_ImprimeLinhaNaoFiscal('0', scomp(dados, 40)), True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_ImprimeLinhaNaoFiscal('0', space(4) + sdcomp(dados, 44), ultimaresp));
         end;
   end;
   Result := Result And Retorno_Impressora;
end;

function TDefFPrinter.FechaCupomVinculado(sValues:String): Boolean;
var
  sPayType, sNote,
  Vinc, Seg : String;
  sStatus: String;
begin

   sPayType := ParseParam(sValues, FISCAL_FECHA_NOTA_TIPO_PAGAMENTO);
   sNote    := ParseParam(sValues, FISCAL_FECHA_NOTA_MSG);
   Vinc     := 'N'; //Informando "N", não haverá comprovante
   Seg      := 'N'; //Informando "N", não haverá segundo cupom; informando "S", o ECF emitirá

   Result := false;

   case Impressora of
      None: Result := false;
      Dataregis:
         begin
            DTR_Proc('S' +
               'S----------------------------------------' +
               'S' + copy(rodape.Linha1 + space(40), 1, 40) +
               'S' + copy(rodape.Linha2 + space(40), 1, 40) +
               'S' + copy(rodape.Linha3 + space(40), 1, 40) +
               'S' + copy(rodape.Linha4 + space(40), 1, 40) +
               'S' + copy(rodape.Linha5 + space(40), 1, 40));
            result := DTR_Proc('K');
         end;
      Sweda03, Sweda10:
         begin
              iRetorno := Sweda_FechaComprovanteNaoFiscalVinculado;
              Analisa_iRetorno();
              Result:= (iRetorno=1);
         end;
      NCR2x, NCR1x: Result := NCR_Proc('190\' + iif(rodape.linha1 <> '', '\' + rodape.linha1, '') +
            iif(rodape.linha2 <> '', '\' + rodape.linha2, '') +
            iif(rodape.linha3 <> '', '\' + rodape.linha3, '') +
            iif(rodape.linha4 <> '', '\' + rodape.linha4, '') +
            iif(rodape.linha5 <> '', '\' + rodape.linha5, ''));
      //NCR7141: Result := NCR_Proc('190' + iif(rodape.linha1 <> '', '\' + copy(rodape.linha1,1,40), '\') +
      //      iif(trim(rodape.linha2) <> '', '\' + copy(rodape.linha2,1,40), '') +
      //      iif(trim(rodape.linha3) <> '', '\' + copy(rodape.linha3,1,40), '') +
      //      iif(trim(rodape.linha4) <> '', '\' + copy(rodape.linha4,1,40), '') +
      //      iif(trim(rodape.linha5) <> '', '\' + copy(rodape.linha5,1,40), ''));
      NCR7141: Result := NCR_Proc('190');
      Urano2EFE:
         begin
            if rodape.linha1 <> '' then result := Urn_Ret(Urano2EFE_ImprimeLinhaNFiscal(PChar(Rodape.Linha1)));
            if rodape.linha2 <> '' then result := Urn_Ret(Urano2EFE_ImprimeLinhaNFiscal(PChar(Rodape.Linha2)));
            if rodape.linha3 <> '' then result := Urn_Ret(Urano2EFE_ImprimeLinhaNFiscal(PChar(Rodape.Linha3)));
            if rodape.linha4 <> '' then result := Urn_Ret(Urano2EFE_ImprimeLinhaNFiscal(PChar(Rodape.Linha4)));
            if rodape.linha5 <> '' then result := Urn_Ret(Urano2EFE_ImprimeLinhaNFiscal(PChar(Rodape.Linha5)));
            Urn_Ret(Urano2EFE_FinalizaVenda('0', PChar(Dados.Operador))); //FimCupomNFiscal;
            Urn_ret(Urano2EFE_avancolinha(0, 5));
            Urn_Ret(Urano2EFE_imprimecabecalho);
         end;
      Urano1EFC:
         begin
            if Length(textolivre) > 0 then UranoEFC_LInhasLivres(textolivre);
            textolivre := copy('    ' + rodape.linha1 + space(48), 1, 48);
            if rodape.linha2 <> '' then textolivre := textolivre + copy('    ' + rodape.linha2 + space(48), 1, 48);
            if rodape.linha3 <> '' then textolivre := textolivre + copy('    ' + rodape.linha3 + space(48), 1, 48);
            if rodape.linha4 <> '' then textolivre := textolivre + copy('    ' + rodape.linha4 + space(48), 1, 48);
            if rodape.linha5 <> '' then textolivre := textolivre + copy('    ' + rodape.linha5 + space(48), 1, 48);
            urn_ret3(UranoEFC_linhasLivres(textolivre));
            UranoEFC_FinalizaRelatorio(PChar(Dados.Operador));
            UranoEFC_FechaCupom(PChar(Dados.Operador));
            sleep(2000);
            Result := Urn_ret3(UranoEFC_AvancaLinhas('05'));
            textolivre := '';
         end;
      Urano2EFC:
         begin
            if Length(textolivre) > 0 then UranoEFC_LInhasLivres(textolivre);
            textolivre := copy(rodape.linha1 + space(42), 1, 42);
            if rodape.linha2 <> '' then textolivre := textolivre + copy(rodape.linha2 + space(42), 1, 42);
            if rodape.linha3 <> '' then textolivre := textolivre + copy(rodape.linha3 + space(42), 1, 42);
            if rodape.linha4 <> '' then textolivre := textolivre + copy(rodape.linha4 + space(42), 1, 42);
            if rodape.linha5 <> '' then textolivre := textolivre + copy(rodape.linha5 + space(42), 1, 42);
            urn_ret3(UranoEFC_linhasLivres(textolivre));
            UranoEFC_FinalizaRelatorio(PChar(Dados.Operador));
            UranoEFC_FechaCupom(PChar(Dados.Operador));
            sleep(2000);
            Result := Urn_ret3(UranoEFC_AvancaLinhas('08'));
            textolivre := '';
         end;
      Urano1FIT:
         begin
            if (Length(textolivre) > 0) and (Length(textolivre) > 205) then begin
               Urano1FIT_LInhasLivres(IntToStr(Length(textolivre)), textolivre);
               textolivre := '';
            end;
            if rodape.linha1 <> '' then textolivre := textolivre + copy(rodape.linha1 + space(40), 1, 40) + #13;
            if rodape.linha2 <> '' then textolivre := textolivre + copy(rodape.linha2 + space(40), 1, 40) + #13;
            if rodape.linha3 <> '' then textolivre := textolivre + copy(rodape.linha3 + space(40), 1, 40) + #13;
            if rodape.linha4 <> '' then textolivre := textolivre + copy(rodape.linha4 + space(40), 1, 40) + #13;
            if rodape.linha5 <> '' then textolivre := textolivre + copy(rodape.linha5 + space(40), 1, 40) + #13;
            Urano1FIT_LInhasLivres(IntToStr(Length(textolivre)), textolivre);
            textolivre := '';
            Result := Urn_ret2(Urano1FIT_FinalizaRelatorio);
            Urn_ret2(Urano1FIT_AvancaLinhas('06'));
         end;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            if rodape.linha1 <> '' then zan_proc('!', copy(Rodape.Linha1, 1, 40));
            if rodape.linha2 <> '' then zan_proc('!', copy(Rodape.Linha2, 1, 40));
            if rodape.linha3 <> '' then zan_proc('!', copy(Rodape.Linha3, 1, 40));
            if rodape.linha4 <> '' then zan_proc('!', copy(Rodape.Linha4, 1, 40));
            if rodape.linha5 <> '' then zan_proc('!', copy(Rodape.Linha5, 1, 40));
            Result := zan_proc('9', '');
            if result then begin
               if impressora = ZanthusIZ41 then zan_proc('U', '08') else zan_proc('U', '06'); // avanca 3 linhas
               zan_proc('6', ''); // Imprime cabecalho
            end;
         end;
      Schalter3D:
         begin
            retornoschd(Schalter3D_FimTrans(''));
            Schalter3D_LineFeed(1, 7);
         end;
      Schalter2S:
         begin
            if rodape.linha1 <> '' then Schalter2S_ecfImpLinha(PChar(copy(rodape.linha1 + space(40), 1, 40)));
            if rodape.linha2 <> '' then Schalter2S_ecfImpLinha(PChar(copy(rodape.linha2 + space(40), 1, 40)));
            if rodape.linha3 <> '' then Schalter2S_ecfImpLinha(PChar(copy(rodape.linha3 + space(40), 1, 40)));
            if rodape.linha4 <> '' then Schalter2S_ecfImpLinha(PChar(copy(rodape.linha4 + space(40), 1, 40)));
            if rodape.linha5 <> '' then Schalter2S_ecfImpLinha(PChar(copy(rodape.linha5 + space(40), 1, 40)));
            Result := retsch2(Schalter2S_ecfFimTrans(pchar('oper:' + dados.operador)));
            Schalter2S_ecfLineFeed(1, 7);
         end;
      SCFI:
         begin
            if rodape.linha1 <> '' then SCFI_ecfImpLinha(PChar(copy(rodape.linha1 + space(40), 1, 40)));
            if rodape.linha2 <> '' then SCFI_ecfImpLinha(PChar(copy(rodape.linha2 + space(40), 1, 40)));
            if rodape.linha3 <> '' then SCFI_ecfImpLinha(PChar(copy(rodape.linha3 + space(40), 1, 40)));
            if rodape.linha4 <> '' then SCFI_ecfImpLinha(PChar(copy(rodape.linha4 + space(40), 1, 40)));
            if rodape.linha5 <> '' then SCFI_ecfImpLinha(PChar(copy(rodape.linha5 + space(40), 1, 40)));
            iRetorno := SCFI_ecfFimTransVinc(pchar('oper:' + dados.operador), '00');
            Analisa_iRetorno();
            Result := (iRetorno=0);
            SCFI_ecfLineFeed(1, 7);
         end;
      BematechMP20, BematechMP40, BematechTermica:
         begin
              //iRetorno := Bematech_FechaCupomResumido(sPayType, sNote);
              iRetorno := Bematech_FechaComprovanteNaoFiscalVinculado;
              Analisa_iRetorno();
              Result:= (iRetorno=1);
         end;
      Elgin:
         begin
              //iRetorno := Bematech_FechaCupomResumido(sPayType, sNote);
              iRetorno := Elgin_FechaComprovanteNaoFiscalVinculado;
              Analisa_iRetorno();
              Result:= (iRetorno=1);
         end;
      Procomp_2011:
         begin
{            if rodape.linha1 <> '' then rodlinha:=rodlinha+rodape.linha1;
            if rodape.linha2 <> '' then rodlinha:=rodlinha+rodape.linha2;
            if rodape.linha3 <> '' then rodlinha:=rodlinha+rodape.linha3;
            if rodape.linha4 <> '' then rodlinha:=rodlinha+rodape.linha4;
            if rodape.linha5 <> '' then rodlinha:=rodlinha+rodape.linha5;
}
            LeProComp(Procomp_EncerrarCupom, True);
         end;
      Trends10E:
         begin
            Ultimaresp := space(1000);
            if trim(rodape.linha1) <> '' then Trends_ret(Trends_ImprimeLinhaNaoFiscal('0', space(4) + sdcomp(Rodape.Linha1, 44), Ultimaresp));
            if trim(rodape.linha2) <> '' then Trends_ret(Trends_ImprimeLinhaNaoFiscal('0', space(4) + sdcomp(Rodape.Linha2, 44), Ultimaresp));
            if trim(rodape.linha3) <> '' then Trends_ret(Trends_ImprimeLinhaNaoFiscal('0', space(4) + sdcomp(Rodape.Linha3, 44), Ultimaresp));
            if trim(rodape.linha4) <> '' then Trends_ret(Trends_ImprimeLinhaNaoFiscal('0', space(4) + sdcomp(Rodape.Linha4, 44), Ultimaresp));
            if trim(rodape.linha5) <> '' then Trends_ret(Trends_ImprimeLinhaNaoFiscal('0', space(4) + sdcomp(Rodape.Linha5, 44), Ultimaresp));
            Result := Trends_ret(Trends_EncerraCupomNaoFiscal(ultimaresp));
         end;
      AFRAC:
      begin
        iRetorno := AFRAC_FecharVinculado();
        Result := iRetorno=0;
        Analisa_iRetorno;
      end;

      DarumaMatr, DarumaTerm:
      begin
        SetLength(sStatus, 2);
        iRetorno := Daruma_FI_StatusComprovanteNaoFiscalVinculado(sStatus);
        Result := iRetorno=1;
        Analisa_iRetorno;
        if Result and (Trim(sStatus) = '1') then
        begin
          iRetorno := Daruma_FI_FechaComprovanteNaoFiscalVinculado;
          Result := iRetorno=1;
          Analisa_iRetorno;
        end;
      end;

   end;
   Result := Result And Retorno_Impressora;
end;


function TDefFPrinter.FechaCupomVinculadoSemErro(sValues:String): Boolean;
var
  sPayType, sNote,
  Vinc, Seg : String;
  sStatus: String;
begin

   sPayType := ParseParam(sValues, FISCAL_FECHA_NOTA_TIPO_PAGAMENTO);
   sNote    := ParseParam(sValues, FISCAL_FECHA_NOTA_MSG);
   Vinc     := 'N'; //Informando "N", não haverá comprovante
   Seg      := 'N'; //Informando "N", não haverá segundo cupom; informando "S", o ECF emitirá

   Result := false;

   case Impressora of
      None: Result := false;
      BematechMP20, BematechMP40, BematechTermica:
         begin
              //iRetorno := Bematech_FechaCupomResumido(sPayType, sNote);
              iRetorno := Bematech_FechaComprovanteNaoFiscalVinculado;
              Result:= (iRetorno=1);
         end;
      Elgin:
         begin
              //iRetorno := Bematech_FechaCupomResumido(sPayType, sNote);
              iRetorno := Elgin_FechaComprovanteNaoFiscalVinculado;
              Result:= (iRetorno=1);
         end;

      Sweda03, Sweda10:
         begin
              iRetorno := Sweda_FechaComprovanteNaoFiscalVinculado;
              Result:= (iRetorno=1);
         end;

      SCFI:
      begin
      // 
    //     iRetorno := SCFI_ecfFimTransVinc('', '00');
     //    Analisa_iRetorno();
    //     Result := (iRetorno=0);
         Result := True;
      end;
      
      AFRAC:
      begin
        iRetorno := AFRAC_FecharVinculado();
        //Result := iRetorno=0;
        Result := True;
      end;

      DarumaMatr, DarumaTerm:
      begin
        SetLength(sStatus, 2);
        iRetorno := Daruma_FI_StatusComprovanteNaoFiscalVinculado(sStatus);
        Result := iRetorno=1;
        if Result and (Trim(sStatus) = '1') then
        begin
          iRetorno := Daruma_FI_FechaComprovanteNaoFiscalVinculado;
          Result := iRetorno=1;
        end;
      end;

   end;
end;


////////////////////////////////////////////////////////////////
function TDefFPrinter.AbreCupomFiscal(CGC:String): boolean;
begin
   Result := False;

   If Assigned(FBeforeAbrirCupom) Then
     FBeforeAbrirCupom(Self, Result);

   if not Result then
     Exit;

   case Impressora of
      None: Result := false;
      Dataregis: result := True;

      Sweda03, Sweda10:
      begin
         iRetorno := Sweda_AbreCupom(CGC);
         Analisa_iRetorno();
         Result:= (iRetorno=1);
      end;

      NCR2x, NCR7141, NCR1x: Result := NCR_Proc('10');
      Urano2EFE: Result := true;
      Urano1EFC, Urano2EFC:
         begin
            UranoEFC_ImprimeCabecalho;
            Result := true;
            contai_Zant := 0;
         end;
      Urano1FIT:
         begin
            Urano1FIT_ImprimeCabecalho;
            Result := true;
            contai_Zant := 0;
         end;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            Result := zan_proc('8', '');
            if not result then exit;
            if Zan_Proc('P', '000420') then TabAliq_Zant := copy(Ultimaresp, 3, 50);
            contai_Zant := 0;
            if rodape.linha1 <> '' then zan_proc('o', '00' + rodape.linha1);
            if rodape.linha2 <> '' then zan_proc('o', '01' + rodape.linha2);
            if rodape.linha3 <> '' then zan_proc('o', '02' + rodape.linha3);
            if rodape.linha4 <> '' then zan_proc('o', '03' + rodape.linha4);
            if rodape.linha5 <> '' then zan_proc('o', '04' + rodape.linha5);
         end;
      Schalter3D:
         begin
            Result := true;
            Schalter3D_ImpCab(0);
            contai_Zant := 0;
         end;
      Schalter2S: Result := retsch2(Schalter2S_ecfImpCab(0));
      SCFI:
         begin
           iRetorno := SCFI_ecfImpCab(0);
           Analisa_iRetorno();
           Result := (iRetorno=0);
         end;
      BematechMP40, BematechMP20, BematechTermica: begin
           iRetorno := Bematech_AbreCupom(CGC);
           Analisa_iRetorno();
           Result:= (iRetorno=1);
      end;
      Elgin: begin
           iRetorno := Elgin_AbreCupom(CGC);
           Analisa_iRetorno();
           Result:= (iRetorno=1);
      end;
      Procomp_2011: LeProComp(Procomp_AbreCupomFiscal, True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_AbreCupomFiscal(ultimaresp));
         end;

      AFRAC:
      begin
        iRetorno := AFRAC_InformarCNPJ(PChar(CGC));
        Analisa_iRetorno();
        Result:= (iRetorno=0);

        if Result then
        begin
          iRetorno := AFRAC_AbrirCupom();
          Analisa_iRetorno();
          Result:= (iRetorno=0);
        end;
      end;

      DarumaMatr, DarumaTerm:
      begin
        iRetorno := Daruma_FI_AbreCupom(CGC);
        Result:= (iRetorno=1);
        Analisa_iRetorno();
      end;

   end;
   Result := Result And Retorno_Impressora();
   if Result then ValorCupom := '0';

   If Result And Assigned(FAfterAbrirCupom) Then
     FAfterAbrirCupom(Self);

end;
//////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.SubTotal( SubTotal: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       iRetorno := Bematech_SubTotal( SubTotal );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       iRetorno := Sweda_SubTotal(SubTotal);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
       iRetorno := Elgin_SubTotal( SubTotal );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaTotalizadoresParciais( Totalizadores: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       iRetorno := Bematech_VerificaTotalizadoresParciais( Totalizadores );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       iRetorno := Sweda_VerificaTotalizadoresParciais(Totalizadores);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
       iRetorno := Elgin_VerificaTotalizadoresParciais( Totalizadores );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaEstadoImpressora( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       iRetorno := Bematech_VerificaEstadoImpressora( ACK,ST1,ST2 );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       iRetorno := Sweda_VerificaEstadoImpressora(ACK, ST1, ST2);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
         iRetorno := Elgin_VerificaEstadoImpressora( ACK,ST1,ST2 );
         Analisa_iRetorno();
         Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaEstadoImpressoraMFD( Var ACK: Integer; Var ST1: Integer; Var ST2: Integer; Var ST3: Integer ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       iRetorno := Bematech_VerificaEstadoImpressoraMFD( ACK,ST1,ST2,ST3 );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       iRetorno := Sweda_VerificaEstadoImpressoraMFD(ACK, ST1, ST2, ST3);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
         iRetorno := Elgin_VerificaEstadoImpressoraMFD( ACK,ST1,ST2,ST3 );
         Analisa_iRetorno();
         Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.VendeItemDepartamento( Codigo: String; Descricao: String; Aliquota: String; ValorUnitario: String; Quantidade: String; Acrescimo: String; Desconto: String; IndiceDepartamento: String; UnidadeMedida: String): Boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
         iRetorno := Bematech_VendeItemDepartamento(Codigo,Descricao,Aliquota, ValorUnitario,Quantidade,Acrescimo,Desconto,IndiceDepartamento,UnidadeMedida);
         Analisa_iRetorno();
         Result:= (iRetorno=1);
     end;

     Elgin:
     begin
         iRetorno := Elgin_VendeItemDepartamento(Codigo,Descricao,Aliquota, ValorUnitario,Quantidade,Acrescimo,Desconto,IndiceDepartamento,UnidadeMedida);
         Analisa_iRetorno();
         Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
         iRetorno := Sweda_VendeItemDepartamento(Codigo,Descricao,Aliquota, Quantidade, ValorUnitario, Acrescimo, Desconto, IndiceDepartamento, UnidadeMedida);
         Analisa_iRetorno();
         Result:= (iRetorno=1);
     end;

   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.VendeItem(Item: string): Boolean;
var
   temp, a, b, c, d, e: string;
   quebrado: boolean;

   CasasDecimais : Integer;
   Codigo, Descricao, Aliquota,
   TipoQuantidade, TipoDesconto,
   Quantidade, ValorUnitario, ssQuantidade,
   ValorTotalItem, Desconto,
   ItemPos : String;


   sDesconto,
   sQuantidade,
   sValorUnitario,
   sValorTotalItem : TPontoFlutuante;

   sTipoDesconto: TAcreDesc;
   sTrunca, sLinhaSimples : TBooleano;


   sAliquota: TTributacaoAFRAC;

   sPercValor : TPercValor;

   sUnidade: array[0..3] of char;

   sCodigo: Array[0..20] of char;
   sDescricao: Array[0..200] of char;


   sTipoQuantidade,
   sCasasDecimais,
   sItemPos,
   sPontoDec : String;
   QtdeSchalter, VlrUniSchalter: String;

   pCodigo,
   pDescricao,
   pQuantidade,
   pValor,
   pUnidade,
   pDigitos: PChar;

   iAliquota, iQuant: Integer;
   dValorDesconto: Double;

begin
   Result := false;

   Codigo         := ParseParam(Item, FISCAL_ITEM_COD);
   Descricao      := ParseParam(Item, FISCAL_ITEM_DESCRIP);
   Aliquota       := ParseParam(Item, FISCAL_ITEM_ALIQ);
   TipoQuantidade := ParseParam(Item, FISCAL_ITEM_TIPO_QTY);
   TipoDesconto   := ParseParam(Item, FISCAL_ITEM_TIPO_DESC);
   Quantidade     := ParseParam(Item, FISCAL_ITEM_QTY);
   ValorUnitario  := ParseParam(Item, FISCAL_ITEM_VALOR_UNIT);
   ValorTotalItem := ParseParam(Item, FISCAL_ITEM_VALOR_TOTAL);
   Desconto       := ParseParam(Item, FISCAL_ITEM_VALOR_DESC);
   CasasDecimais  := MyStrToInt(ParseParam(Item, FISCAL_ITEM_CASA_DEC));
   ItemPos        := ParseParam(Item, FISCAL_ITEM_POSITION);
   sPontoDec      := ParseParam(Item, FISCAL_ITEM_PONTO_DEC);

   case Impressora of
      None: Result := false;
      Dataregis: result := DTR_Proc('A' + zcomp(sepdados(Item, 1), 13) + ' ' + // Codigo 13+1 espaco
            copy(copy(sepdados(Item, 2), 1, 20) + space(22), 1, 22) + //Descricao[22]
            zcomp(IntToStr(strtointdef(COPY(sepdados(Item, 3), 2, 1), 1) - 1), 2) + //Tributacao[2]
            zcomp(tiravg(ptov(sepdados(Item, 4))), 6) + //Quantidade[6]
            zcomp(tiravg(ptov(sepdados(Item, 5))), 9) + //Preco Unitario[9]
            zcomp(tiravg(ptov(sepdados(Item, 6))), 4)); //Desconto[4]
      Sweda03, Sweda10:
         begin
           iRetorno := Sweda_VendeItem(Copy(IncChar(Codigo, 13, '0', 'L'), 1, 13), //Para difenciar um campo do outro
                                           Copy(Descricao, 1, 29),
                                           Aliquota,
                                           TipoQuantidade,
                                           Quantidade,
                                           CasasDecimais,
                                           ValorUnitario,
                                           TipoDesconto,
                                           Desconto);
           Analisa_iRetorno();
           Result:= (iRetorno=1);
         end;
      NCR2x, NCR1X:
         begin
            a := sepdados(Item, 5);
            str(strtointdef(a, 0) / 100: 8: 2, a);
            a := ptov(a);
            b := trim(sepdados(Item, 4));
            str((StrTointdef(tiramsc(b), 0) / 1000) * (StrTointdef(tiramsc(a), 0) / 100) + 0.005: 9: 5, c);
            c := copy(c, 1, pos('.', c) + 2);
            c := tiramsc(c);
            if b = '1000' then b := '1' else begin
               str(strtointdef(b, 0) / 1000: 8: 3, b);
               b := ptov(b);
            end;
            if impressora = NCR1x then
               Result := NCR_Proc('11' + zcomp(sepdados(Item, 1), 13) + // codigo
                  '\' + sepdados(Item, 2) + // nome
                  '\' + sepdados(Item, 4) + // Quantidade
                  '\' + sepdados(Item, 5) + // preco
                  '\' + sepdados(Item, 8) + // total
                  '\' + sepdados(Item, 3)) // tributacao0
            else Result := NCR_Proc('11' + zcomp(sepdados(Item, 1), 13) + // codigo
                  '\' + sepdados(Item, 2) + // nome
                  '\' + b + // Quantidade
                  '\' + a + // preco
                  '\' + c + // total
                  '\' + sepdados(Item, 3)); // tributacao0
            a := sepdados(item, 6);
            if strtointdef(a, 0) > 0 then begin
               str(strtointdef(c, 0) / 100: 8: 2, c);
               c := ptov(c);
               str(strtofloat(c) * strtofloat(copy(a, 1, 2)) / 100: 8: 2, b);
               Result := NCR_Proc('12' + tiramsc(b)); // Desconto de item
            end;
         end;
      NCR7141:
         begin
            a := sepdados(Item, 5);
            a := formatfloat('####0.00', strtointdef(a, 0) / 100);
            b := trim(sepdados(Item, 4));
            b := formatfloat('####0.000', strtointdef(b, 0) / 1000);
            str(((strtoint(tiramsc(b)) * strtoint(tiramsc(a)))) / 100000: 12: 8, c);
            c := copy(c, 1, pos('.', c) + 4);
            if strtointdef(copy(c, pos('.', c) + 3, 1), 0) < 5 then c := copy(c, 1, pos('.', c) + 2);
            if strtointdef(copy(c, pos('.', c) + 3, 1), 0) > 5 then str(StrToFloat(ptov(copy(c, 1, pos('.', c) + 2))) + 0.01: 8: 2, c);
            if strtointdef(copy(c, pos('.', c) + 3, 1), 0) = 5 then begin
               if strtointdef(copy(c, pos('.', c) + 4, 5), 0) = 0 then begin
                  if odd(strtointdef(copy(c, pos('.', c) + 2, 1), 0)) then begin
                     str(StrToFloat(ptov(copy(c, 1, pos('.', c) + 2))) + 0.01: 8: 2, c);
                  end else begin
                     c := copy(c, 1, pos('.', c) + 2);
                  end;
               end else begin
                  str(StrToFloat(ptov(copy(c, 1, pos('.', c) + 2))) + 0.01: 8: 2, c);
               end;
            end;
            c := tiramsc(c);
            if trim(b) = '1,000' then b := '1'; // Para imprimir em uma linha apenas
            Result := NCR_Proc('11' + zcomp(sepdados(Item, 1), 13) + // codigo
               '\' + sepdados(Item, 2) + // nome
               '\' + b + // Quantidade
               '\' + a + // preco
               '\' + c + // total
               '\' + sepdados(Item, 3)); // tributacao
            a := sepdados(item, 6);
            if strtointdef(a, 0) > 0 then begin
               str(strtointdef(c, 0) / 100: 8: 2, c);
               c := ptov(c);
               str(strtofloat(c) * strtofloat(copy(a, 1, 2)) / 100: 8: 2, b);
               Result := NCR_Proc('12' + tiramsc(b)); // Desconto de item
            end;
         end;
      Urano2EFE:
         begin
            a := sepdados(Item, 3);
            if a = 'F' then a := '16';
            if a = 'I' then a := '17';
            if uppercase(a[1]) = 'T' then a := zcomp(copy(a, 2, 1), 2);
            str(strtointdef(sepdados(Item, 4), 0) / 1000: 8: 3, b); b := zcomp(ptov(b), 7);
            result := Urn_ret(Urano2EFE_VendaItem(pchar(sepdados(Item, 1)), //codigo
               pchar(copy(sepdados(Item, 2), 1, 17)), // Descricao
               PChar(b), // quantidade
               pchar(sepdados(Item, 5)), // preco
               pchar(a), // tributacao
               PChar(iif(copy(sepdados(Item, 1), 1, 1) = '2', 'KG', 'UN')), '0'));
            if not Result then exit;
            a := sepdados(item, 6);
            if strtointdef(a, 0) > 0 then begin
               str((strtointdef(sepdados(Item, 4), 0) / 1000) * strtointdef(sepdados(Item, 5), 0): 8: 2, temp);
               temp := copy(temp, 1, pos('.', temp) - 1);
               str(StrToFloat(temp) - ((strtointdef(temp, 0) * strtointdef(copy(a, 1, 2), 0)) div 100): 8: 0, a);
               a := IntToStr(strtointdef(temp, 0) - strtointdef(a, 0));
               Result := URN_Ret(Urano2EFE_DescontoItem('0', 'Item Anterior:', PChar(a))); // Desconto de item
            end;
         end;
      Urano1EFC, Urano2EFC:
         begin
            pronto := false;
            a := sepdados(Item, 3);
            if a = 'F' then a := '07';
            if a = 'I' then a := '08';
            d := sepdados(item, 4);
            e := sepdados(item, 1);
            if (copy(e, 1, 1) = '2') or (strtointdef(copy(d, Length(d) - 2, 3), 0) > 0) then quebrado := true else quebrado := false;
            if uppercase(a[1]) = 'T' then a := zcomp(copy(a, 2, 1), 2);
            b := zcomp(sepdados(Item, 4), 6);
            b := copy(b, 1, 3) + ',' + copy(b, 4, 3);
            //str(strtointdef(sepdados(Item, 4), 0) / 1000: 8: 3, b); b := zcomp(ptov(b), 7);
            result := Urn_ret3(UranoEFC_VendaItem(e, //codigo
               copy(sepdados(Item, 2), 1, 17), // Descricao
               b, // sepdados(Item, 4), // quantidade
               sepdados(Item, 5), // preco
               a, // tributacao
               iif(copy(e, 1, 1) = '2', 'KG', 'UN'), '0'));
            if not Result then exit;
            inc(contai_Zant);
            a := sepdados(item, 6);
            if strtointdef(a, 0) > 0 then begin
               str((strtointdef(sepdados(Item, 4), 0) / 1000) * strtointdef(sepdados(Item, 5), 0): 8: 2, temp);
               temp := copy(temp, 1, pos('.', temp) - 1);
               str(StrToFloat(temp) - ((strtointdef(temp, 0) * strtointdef(copy(a, 1, 2), 0)) div 100): 8: 0, a);
               a := IntToStr(strtointdef(temp, 0) - strtointdef(a, 0));
               Result := URN_Ret3(UranoEFC_DescontoItem('0', 'Item Anterior:', a)); // Desconto de item
            end;
         end;
      Urano1FIT:
         begin
            pronto := false;
            a := sepdados(Item, 3);
            if a = 'F' then a := '12';
            if a = 'I' then a := '13';
            d := sepdados(item, 4);
            e := sepdados(item, 1);
            if (copy(e, 1, 1) = '2') or (strtointdef(copy(d, Length(d) - 2, 3), 0) > 0) then quebrado := true else quebrado := false;
            if uppercase(a[1]) = 'T' then a := zcomp(copy(a, 2, 1), 2);
            str(strtointdef(sepdados(Item, 4), 0) / 1000: 8: 3, b); b := zcomp(ptov(b), 7);
            result := Urn_ret2(Urano1FIT_VendaItem(e, //codigo
               copy(sepdados(Item, 2), 1, 17), // Descricao
               iif(quebrado, d, copy(d, 1, Length(d) - 3)), // sepdados(Item, 4), // quantidade
               sepdados(Item, 5), // preco
               a, // tributacao
               iif(copy(e, 1, 1) = '2', 'KG', 'UN'), iif(quebrado, '1', '0')));
            if not Result then exit;
            inc(contai_Zant);
            a := sepdados(item, 6);
            if strtointdef(a, 0) > 0 then begin
               str((strtointdef(sepdados(Item, 4), 0) / 1000) * strtointdef(sepdados(Item, 5), 0): 8: 2, temp);
               temp := copy(temp, 1, pos('.', temp) - 1);
               str(StrToFloat(temp) - ((strtointdef(temp, 0) * strtointdef(copy(a, 1, 2), 0)) div 100): 8: 0, a);
               a := IntToStr(strtointdef(temp, 0) - strtointdef(a, 0));
               Result := URN_Ret2(Urano1FIT_DescontoItem('0', 'Item Anterior:', a)); // Desconto de item
            end;
         end;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            Result := zan_proc('g', '00' + sepdados(Item, 1) + ' ' + sepdados(Item, 2));
            if Result then begin
               if TabAliq_Zant = '' then if Zan_Proc('P', '000420') then TabAliq_Zant := copy(Ultimaresp, 3, 50);
               str(strtointdef(sepdados(item, 4), 0) / 1000: 8: 3, a);
               //a := space(11 - length(a)) + a;
               str(strtointdef(sepdados(item, 5), 0) / 100: 8: 2, b);
               if pos('.', b) = 0 then b := b + '.00' else b := b + '00';
               b := copy(b, 1, pos('.', b) + 2);
               b := ptov(b);
               b := space(9 - Length(b)) + b;
               e := copy(trim(sepdados(Item, 3)), 1, 1);
               if e <> 'T' then begin
                  if e = 'S' then e := 'F';
                  c := '       ';
               end else begin
                  c := copy(sepdados(Item, 3), 2, 2);
                  c := 'T' + copy(TabAliq_Zant, (strtointdef(copy(trim(sepdados(Item, 3)), 2, 2), 0) * 4) - 3, 2) + '.00' + '%';
               end;
               e := ' ' + e + ' '; // Determina se é tributado, Isento ou Substituicao
               //str(strtointdef(sepdados(item,8),0) / 100:8:2,d);
               d := formatfloat('#####0.000', strtointdef(sepdados(item, 8), 0) / 100);
               d := copy(d, 1, pos(',', d) + 2);
               d := ptov(d);
               d := space(10 - length(d)) + d;
               //d:=zcomp(d,11);
               if (impressora = ZanthusIZ10) or (impressora = ZanthusIZ11) then begin
                  Result := zan_proc(';', copy(a + 'x' + b + space(20), 1, 20)
                     + c // tributacao
                     + d // Valor total
                     + e);
               end else begin
                  Result := zan_proc(';', iif(impressora = ZanthusIZ41, '   ', '') + copy(a + 'x' + b + space(22), 1, 22) // quantidade X Preco unitario  aliquota
                     + c // tributacao
                     + d // Valor total
                     + e);
               end;
               a := sepdados(item, 6);
               if strtointdef(a, 0) > 0 then begin
                  //str((StrTointdef(tiravg(ptov(d)),0) * strtointdef(copy(a,1,2),0)) div 100:8:2,a);
                  a := floatToStr((StrTointdef(tiravg(ptov(d)), 0) * strtointdef(copy(a, 1, 2), 0)) / 10000);
                  a := ptov(a);
                  a := copy(a, 1, pos(',', a) + 2);
                  a := space(10 - length(a)) + a;
                  if (impressora = ZanthusIZ10) or (impressora = ZanthusIZ11) then begin
                     a := '      DESCONTO     ' + c + ' ' + a + e;
                  end else begin
                     a := '     DESCONTO       ' + c + ' ' + a + e;
                     a := space(42 - Length(a)) + a;
                  end;
                  zan_proc('<', iif(impressora = ZanthusIZ41, '   ', '') + a);
               end;
               if Result then begin
                  UltItem_Zant := item;
                  inc(contai_Zant);
               end;
               //   1.000x     4,80    T17.00%      4,80 T
            end;
         end;
      Schalter3D:
         begin
            {
            a := zcomp(sepdados(Item, 4), 10);
            b := sepdados(Item, 3);
            if b = 'F' then b := '16';                   
            if b = 'I' then b := '17';
            if uppercase(b[1]) = 'T' then b := zcomp(copy(sepdados(Item, 3), 2, 1), 2);
            Result := retornoschd(Schalter3D_Venda_item(PChar(zcomp(sepdados(Item, 1), 13)),
               PChar(sepdados(Item, 2)),
               PChar(copy(a, 5, 3)),
               PChar(copy(a, 8, 3)),
               PChar(sepdados(Item, 5)),
               strtointdef(b, 0)));
            a := sepdados(item, 6);
            if strtointdef(a, 0) > 0 then begin
               str((strtointdef(sepdados(Item, 4), 0) / 1000) * strtointdef(sepdados(Item, 5), 0): 8: 2, temp);
               temp := copy(temp, 1, pos('.', temp) - 1);
               str(StrToFloat(temp) - ((strtointdef(temp, 0) * strtointdef(copy(a, 1, 2), 0)) div 100): 8: 0, a);
               a := IntToStr(strtointdef(temp, 0) - strtointdef(a, 0));
               Schalter3D_DescItem(0, 'Desconto no Item Anterior', PChar(a));
            end;
            if Result then begin
               UltItem_Zant := item;
               inc(contai_Zant);
            end;}
            qtdeSchalter   := IncChar(MyFormatCur(MyStrCurToFloat(Quantidade, sPontoDec)/1000, ',') + '0', 7, '0', 'L');
            VlrUniSchalter := IntToStr(Trunc(MyStrCurToFloat(ValorUnitario, sPontoDec) * 100));

            pCodigo       := PChar(Copy(Codigo, 1, 13));
            pDescricao    := PChar(Copy(Descricao, 1, 62));
            pQuantidade   := PChar(qtdeSchalter);
            pValor        := PChar(VlrUniSchalter);
            pUnidade      := 'UN';
            pDigitos      := '2';

            iAliquota     := StrToIntDef(Aliquota, 0);

            Result := RetornoSchd(Schalter3D_Venda_item(pCodigo, pDescricao, pQuantidade, pValor, iAliquota, pUnidade,  pDigitos));

            dValorDesconto := MyStrCurToFloat(Desconto, sPontoDec);

            if Result and (dValorDesconto > 0) then
            begin

              if TipoDesconto = '%' then
                dValorDesconto := MyStrCurToFloat(Quantidade, sPontoDec)/1000 * MyStrCurToFloat(ValorUnitario, sPontoDec) * dValorDesconto / 100;


              dValorDesconto := dValorDesconto * 100;

              Result := RetornoSchd(Schalter3D_DescItem(0, 'Desconto no Item Anterior', PChar(IntToStr(Trunc(dValorDesconto)))));

            end;
         end;
      Schalter2S:
         begin
            a := sepdados(Item, 4);
            b := sepdados(Item, 3);
            if b = 'F' then b := '13';
            if b = 'I' then b := '14';
            b := tiramsc(b);
            if strtointdef(a, 0) = 1000 then begin
               Result := retsch2(Schalter2S_ecfVendaItem(PChar(
                  copy(sepdados(Item, 1) + sepdados(Item, 2) + space(30), 1, 30)),
                  PChar(sepdados(Item, 8)),
                  strtointdef(b, 0) - 1));
            end else begin
               Result := retsch2(Schalter2S_ecfVendaItem(PChar(
                  copy(sepdados(Item, 1) + sepdados(Item, 2) + space(30), 1, 30) + '     ' +
                  formatfloat('###0.000', strtointdef(a, 1000) / 1000) + ' x ' + formatfloat('###0.00', strtointdef(sepdados(Item, 5), 100) / 100)),
                  PChar(sepdados(Item, 8)),
                  strtointdef(b, 0) - 1));
            end;
            a := sepdados(item, 6);
            if strtointdef(a, 0) > 0 then begin
               str((strtointdef(sepdados(Item, 4), 0) / 1000) * strtointdef(sepdados(Item, 5), 0): 8: 2, temp);
               temp := copy(temp, 1, pos('.', temp) - 1);
               str(StrToFloat(temp) - ((strtointdef(temp, 0) * strtointdef(copy(a, 1, 2), 0)) div 100): 8: 0, a);
               a := IntToStr(strtointdef(temp, 0) - strtointdef(a, 0));
               retsch2(Schalter2S_ecfDescItem(0, 'DESCONTO NO ITEM ANTERIOR', PChar(a)));
            end;
            if Result then begin
               UltItem_Zant := item;
               inc(contai_Zant);
            end;
         end;
      SCFI:
         begin
            qtdeSchalter   := MyFormatDouble(MyStrCurToFloat(Quantidade, sPontoDec)/1000, ',');
            qtdeSchalter   := IncChar(qtdeSchalter, 7, '0', 'L');

            VlrUniSchalter := FloatToStr((MyStrCurToFloat(ValorUnitario, sPontoDec) * 100));

            pCodigo       := PChar(Copy(Codigo, 1, 13));
            pDescricao    := PChar(Copy(Descricao, 1, 62));
            pQuantidade   := PChar(QtdeSchalter);
            pValor        := PChar(VlrUniSchalter);

            pUnidade      := 'UN';
            pDigitos      := '2';

            iAliquota     := StrToIntDef(Aliquota, 0);

            iRetorno := SCFI_ecfVendaItem3d(pCodigo, pDescricao, pQuantidade, pValor, iAliquota, pUnidade,  pDigitos);
            Analisa_iRetorno();
            Result := (iRetorno = 0);

            dValorDesconto := MyStrCurToFloat(Desconto, sPontoDec);

            if Result and (dValorDesconto > 0) then
            begin

              if TipoDesconto = '%' then
                dValorDesconto := MyStrCurToFloat(Quantidade, sPontoDec)/1000 * MyStrCurToFloat(ValorUnitario, sPontoDec) * dValorDesconto / 100;


              dValorDesconto := dValorDesconto * 100;

              iRetorno := SCFI_ecfDescItem(0, 'Desconto no Item Anterior', PChar(IntToStr(Trunc(dValorDesconto))));
              Analisa_iRetorno();
              Result := (iRetorno = 0);
            end;
         end;
      BematechMP40, BematechMP20, BematechTermica:
         begin
         // Quantidade    := MyFormatDouble(MyStrCurToFloat(Quantidade, sPontoDec) / 10000, ',');
          //Quantidade    := IncChar(Quantidade, 7, '0', 'L');

           iRetorno := Bematech_VendeItem( Copy(IncChar(Codigo, 13, '0', 'L'), 1, 13), //Para difenciar um campo do outro
                                           Copy(Descricao, 1, 29),
                                           Aliquota,
                                           TipoQuantidade,
                                           Quantidade,
                                           CasasDecimais,
                                           ValorUnitario,
                                           TipoDesconto,
                                           Desconto);
           Analisa_iRetorno();
           Result:= (iRetorno=1);
         end;
      Elgin:
         begin

           iRetorno := Elgin_VendeItem( Copy(IncChar(Codigo, 13, '0', 'L'), 1, 13), //Para difenciar um campo do outro
                                           Copy(Descricao, 1, 29),
                                           Aliquota,
                                           TipoQuantidade,
                                           Quantidade,
                                           CasasDecimais,
                                           ValorUnitario,
                                           TipoDesconto,
                                           Desconto);
           Analisa_iRetorno();
           Result:= (iRetorno=1);
         end;
      Procomp_2011:
         begin
            a := '%'; // Percentual
            b := sepdados(Item, 3); // Tributacao
            c := sepdados(item, 2); // Descricao
            d := '0'; // Impressao normal em 2 linhas
            e := '0'; // Descricao com 20 caracteres
            if Pos('I', b) > 0 then b := 'I00'
            else if Pos('F', b) > 0 then b := 'F00'
            else if Pos('N', b) > 0 then b := 'N00'
            else if copy(b, 1, 1) = 'T' then b := 'T' + zcomp(copy(b, 2, 3), 2);
            if Length(c) <= 20 then c := copy(scomp(c, 20), 1, 20) else c := copy(c, 1, 20);
            LeProComp(Procomp_VendaItem(PChar(d), PChar(SepDados(Item, 4)),
               PChar('00' + SepDados(Item, 5)),
               PChar(b), PChar(a), PChar(SepDados(Item, 6)),
               PChar(SepDados(Item, 7)), PChar(zComp(SepDados(Item, 1),
               13)), PChar(e),
               PChar(c), PChar('              ')), True);
            a := sepdados(item, 6);
{               if strtointdef(a, 0) > 0 then begin
                  Procomp_DescontoItem('%',a,'');
               end;}
         end;
      Trends10E:
         begin
            Ultimaresp := space(1000);
            b := sepdados(Item, 3);
            if (b = 'F') or (b = 'ST') then b := 'F00';
            if (b = 'I') or (b = 'IS') then b := 'I00';
            if b[1] = 'T' then b := 'T0' + b[2];
            Result := Trends_ret(Trends_VendaItem(#0, // 0 normas - para 1 linha
               zcomp(sepdados(item, 4), 6), // Quantidade
               zcomp(sepdados(item, 5), 11), // Valor unitario
               b, // Tributacao
               '%', // Tipo desconto "&" valor ou "%" percentagem
               zcomp(sepdados(item, 6), 4), // Percentual de desconto
               iif(copy(sepdados(item, 1), 1, 1) = '2', 'KG', 'UN'), // Unidade de venda
               zcomp(sepdados(item, 1), 13), // Codigo do produto
               #0, // Tamanho da descricao (20)
               copy(sepdados(item, 2)+space(20),1,20), // Descricao
               'DESCONTO ITEM:', // Descricao do Desconto, quando usado
               Ultimaresp));
         end;
      AFRAC:
      begin
        Quantidade := MyFloatToStr(MyStrCurToFloat(Quantidade, sPontoDec) / 1000);
        //sTipoQuantidade  :=
        sTipoDesconto    := _AFRAC_BooleanToAcrescDesc(MyStrCurToFloat(Desconto, sPontoDec) >= 0);
        sQuantidade      := _AFRAC_FloatToPontoFlutuante(Quantidade, sPontoDec, CasasDecimais);
        sValorUnitario   := _AFRAC_FloatToPontoFlutuante(ValorUnitario, sPontoDec, CasasDecimais);
        sValorTotalItem  := _AFRAC_FloatToPontoFlutuante(ValorTotalItem, sPontoDec, CasasDecimais);
        sDesconto        := _AFRAC_FloatToPontoFlutuante(Desconto, sPontoDec, CasasDecimais);
        {
        FillChar(sAliquota, Length(sAliquota), 0);
        StrPCopy(sAliquota, 'M' + Aliquota);
        }

        FillChar(sAliquota, Length(sAliquota), 0);
        StrPCopy(sAliquota, Aliquota);


        FillChar(sUnidade, Length(sUnidade), 0);
        StrPCopy(sUnidade, 'UN');

        FillChar(sCodigo, Length(sCodigo), 0);
        StrPCopy(sCodigo, Codigo);

        FillChar(sDescricao, Length(sDescricao), 0);
        StrPCopy(sDescricao, Descricao);

        sTrunca := _AFRAC_BooleanToTBooleano(True);

        sPercValor := _AFRAC_BooleanToTPercValor(True);

        sLinhaSimples := _AFRAC_BooleanToTBooleano(True);

        iRetorno :=
        AFRAC_VenderItem(
           sCodigo, sDescricao,
           sQuantidade,
           sValorUnitario,
           sTipoDesconto,
           sPercValor,
           sDesconto,
           sValorTotalItem,
           sAliquota,
           sUnidade,
           sLinhaSimples);

        Result := iRetorno=0;
        Analisa_iRetorno();
      end;
      DarumaMatr, DarumaTerm:
      begin
       // Quantidade    := MyFormatDouble(MyStrCurToFloat(Quantidade, sPontoDec) / 1000, ',');
       // Quantidade    := IncChar(Quantidade, 7, '0', 'L');

        ValorUnitario := MyFloatToStr(MyStrCurToFloat(ValorUnitario, sPontoDec));
        Desconto      := MyFloatToStr(MyStrCurToFloat(Desconto, sPontoDec));

        iRetorno := Daruma_FI_VendeItem(Copy(Codigo, 1, 13),
                                        Copy(Descricao, 1, 29),
                                        Aliquota,
                                        TipoQuantidade,
                                        Quantidade,
                                        CasasDecimais,
                                        ValorUnitario,
                                        TipoDesconto,
                                        Desconto);
         Result := iRetorno=1;

        Analisa_iRetorno();
      end;
   end;
   Result := Result And Retorno_Impressora;
   if Result then begin
      ValorCupom := IntToStr(strtointdef(ValorCupom, 0) + (StrtointDef(sepdados(Item, 4), 0) * StrtointDef(sepdados(Item, 5), 0)));
      if assigned(FTotalCupom) then OnTotalCupom(valorCupom);
   end;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.VendeItem3dig(Item: string): Boolean;
var
   temp, a, b, c, d, e: string;
   quebrado: boolean;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis:
         begin
            result := DTR_Proc('a' + zcomp(sepdados(Item, 1), 13) + ' ' + // Codigo 13+1 espaco
               copy(copy(sepdados(Item, 2), 1, 20) + space(22), 1, 22) + //Descricao[22]
               zcomp(IntToStr(strtointdef(COPY(sepdados(Item, 3), 2, 1), 1) - 1), 2) + //Tributacao[2]
               zcomp(tiravg(ptov(sepdados(Item, 4))), 6) + //Quantidade[6]
               zcomp(tiravg(ptov(sepdados(Item, 5))), 9) + //Preco Unitario[9]
               zcomp(tiravg(ptov(sepdados(Item, 6))), 4) + //Desconto[4]
               'T'); // Ativa o Truncamento
         end;
      Sweda03:
         begin
            str((strtointdef(sepdados(Item, 4), 0) / 1000) * strtointdef(sepdados(Item, 5), 0): 8: 2, temp);
            temp := copy(temp, 1, pos('.', temp) - 1);
            a := copy(sepdados(Item, 3) + space(3), 1, 3);
            if (a[2] <> '0') and (a[1] <> 'I') and (a[1] <> 'F') then a := a[1] + '0' + a[2];
            Result := swd_proc(#27 + '.01' +
               zcomp(sepdados(Item, 1), 13) + // Codigo de Barra
               zcomp(sepdados(Item, 4), 7) + // Quantidade
               zcomp(sepdados(Item, 5), 9) + // valor Unitario
               zcomp(temp, 12) + // Valor total
               '~' + copy(sepdados(Item, 2) + space(24), 1, 24) + // Descricao
               copy(a + '   ', 1, 3) + // Tributacao
               '13}'); // Tamanho do codigo do produto
            a := sepdados(item, 6);
            if strtointdef(a, 0) > 0 then begin
               str(StrToFloat(temp) - ((strtointdef(temp, 0) * strtointdef(copy(a, 1, 2), 0)) div 100): 8: 0, a);
               a := IntToStr(strtointdef(temp, 0) - strtointdef(a, 0));
               Result := swd_proc(#27 + '.02NO ITEM   ' + zcomp(a, 12) + '}');
            end;
         end;
      Sweda10:
         begin
            str((strtointdef(sepdados(Item, 4), 0) / 1000) * strtointdef(sepdados(Item, 5), 0): 8: 2, temp);
            temp := copy(temp, 1, pos('.', temp) - 1);
            a := sepdados(Item, 3);
            if (a[2] <> '0') and (a[1] <> 'I') and (a[1] <> 'F') then a := a[1] + '0' + a[2];
            Result := swd_proc(#27 + '.01' +
               zcomp(sepdados(Item, 1), 13) + // Codigo de Barra
               zcomp(sepdados(Item, 4), 7) + // Quantidade
               zcomp(sepdados(Item, 5), 9) + // valor Unitario
               zcomp(temp, 12) + // Valor total
               '~' + copy(sepdados(Item, 2) + space(24), 1, 24) + // Descricao
               copy(a + '   ', 1, 3) + // Tributacao
               '13}'); // Tamanho do codigo do produto
            a := sepdados(item, 6);
            if strtointdef(a, 0) > 0 then begin
               str(StrToFloat(temp) - ((strtointdef(temp, 0) * strtointdef(copy(a, 1, 2), 0)) div 100): 8: 0, a);
               a := IntToStr(strtointdef(temp, 0) - strtointdef(a, 0));
               Result := swd_proc(#27 + '.02NO ITEM   ' + zcomp(a, 12) + '}');
            end;
         end;
      NCR2x, NCR1X:
         begin
            a := sepdados(Item, 5);
            str(strtointdef(a, 0) / 1000: 8: 3, a);
            a := ptov(a);
            b := trim(sepdados(Item, 4));
            str((StrTointdef(tiramsc(b), 0) / 1000) * (StrTointdef(tiramsc(a), 0) / 100) + 0.005: 9: 5, c);
            c := copy(c, 1, pos('.', c) + 2);
            c := tiramsc(c);
            if b = '1000' then b := '1' else begin
               str(strtointdef(b, 0) / 1000: 8: 3, b);
               b := ptov(b);
            end;
            if impressora = NCR1x then
               Result := NCR_Proc('11' + zcomp(sepdados(Item, 1), 13) + // codigo
                  '\' + sepdados(Item, 2) + // nome
                  '\' + sepdados(Item, 4) + // Quantidade
                  '\' + sepdados(Item, 5) + // preco
                  '\' + sepdados(Item, 8) + // total
                  '\' + sepdados(Item, 3)) // tributacao0
            else Result := NCR_Proc('11' + zcomp(sepdados(Item, 1), 13) + // codigo
                  '\' + sepdados(Item, 2) + // nome
                  '\' + b + // Quantidade
                  '\' + a + // preco
                  '\' + c + // total
                  '\' + sepdados(Item, 3)); // tributacao0
            a := sepdados(item, 6);
            if strtointdef(a, 0) > 0 then begin
               str(strtointdef(c, 0) / 100: 8: 2, c);
               c := ptov(c);
               str(strtofloat(c) * strtofloat(copy(a, 1, 2)) / 100: 8: 2, b);
               Result := NCR_Proc('12' + tiramsc(b)); // Desconto de item
            end;
         end;
      NCR7141:
         begin
            a := sepdados(Item, 5);
            a := formatfloat('####0.000', strtointdef(a, 0) / 1000);
            b := trim(sepdados(Item, 4));
            b := formatfloat('####0.000', strtointdef(b, 0) / 1000);
            str(((strtoint(tiramsc(b)) * strtoint(tiramsc(a)))) / 100000: 12: 8, c);
            c := copy(c, 1, pos('.', c) + 4);
            if strtointdef(copy(c, pos('.', c) + 3, 1), 0) < 5 then c := copy(c, 1, pos('.', c) + 2);
            if strtointdef(copy(c, pos('.', c) + 3, 1), 0) > 5 then str(StrToFloat(ptov(copy(c, 1, pos('.', c) + 2))) + 0.01: 8: 2, c);
            if strtointdef(copy(c, pos('.', c) + 3, 1), 0) = 5 then begin
               if strtointdef(copy(c, pos('.', c) + 4, 5), 0) = 0 then begin
                  if odd(strtointdef(copy(c, pos('.', c) + 2, 1), 0)) then begin
                     str(StrToFloat(ptov(copy(c, 1, pos('.', c) + 2))) + 0.01: 8: 2, c);
                  end else begin
                     c := copy(c, 1, pos('.', c) + 2);
                  end;
               end else begin
                  str(StrToFloat(ptov(copy(c, 1, pos('.', c) + 2))) + 0.01: 8: 2, c);
               end;
            end;
            c := tiramsc(c);
            if trim(b) = '1,000' then b := '1'; // Para imprimir em uma linha apenas
            Result := NCR_Proc('11' + zcomp(sepdados(Item, 1), 13) + // codigo
               '\' + sepdados(Item, 2) + // nome
               '\' + b + // Quantidade
               '\' + a + // preco
               '\' + c + // total
               '\' + sepdados(Item, 3)); // tributacao0

            a := sepdados(item, 6);
            if strtointdef(a, 0) > 0 then begin
               str(strtointdef(c, 0) / 100: 8: 2, c);
               c := ptov(c);
               str(strtofloat(c) * strtofloat(copy(a, 1, 2)) / 100: 8: 2, b);
               Result := NCR_Proc('12' + tiramsc(b)); // Desconto de item
            end;
         end;
      Urano2EFE:
         begin
            onError(item, 'VendeItem3Dig: Não suportado ou não desenvolvido nesta ECF');
         end;
      Urano1EFC, Urano2EFC:
         begin
            pronto := false;
            a := sepdados(Item, 3);
            if a = 'F' then a := '07';
            if a = 'I' then a := '08';
            e := sepdados(item, 1);
            if uppercase(a[1]) = 'T' then a := zcomp(copy(a, 2, 1), 2);
            b := zcomp(sepdados(Item, 4), 6);
            b := copy(b, 1, 3) + ',' + copy(b, 4, 3);
            //str(strtointdef(sepdados(Item, 4), 0) / 1000: 8: 3, b); b := zcomp(ptov(b), 7);
            result := Urn_ret3(UranoEFC_VendaItem(e, //codigo
               copy(sepdados(Item, 2), 1, 17), // Descricao
               sepdados(Item, 4), // quantidade
               sepdados(Item, 5), // preco
               a, // tributacao
               iif(copy(e, 1, 1) = '2', 'KG', 'UN'), '1'));
            if not Result then exit;
            inc(contai_Zant);
            a := sepdados(item, 6);
            if strtointdef(a, 0) > 0 then begin
               str((strtointdef(sepdados(Item, 4), 0) / 1000) * strtointdef(sepdados(Item, 5), 0): 8: 2, temp);
               temp := copy(temp, 1, pos('.', temp) - 1);
               str(StrToFloat(temp) - ((strtointdef(temp, 0) * strtointdef(copy(a, 1, 2), 0)) div 100): 8: 0, a);
               a := IntToStr(strtointdef(temp, 0) - strtointdef(a, 0));
               Result := URN_Ret3(UranoEFC_DescontoItem('0', 'Item Anterior:', a)); // Desconto de item
            end;
         end;
      Urano1FIT:
         begin
            pronto := false;
            a := sepdados(Item, 3);
            if a = 'F' then a := '12';
            if a = 'I' then a := '13';
            e := sepdados(item, 1);
            if uppercase(a[1]) = 'T' then a := zcomp(copy(a, 2, 1), 2);
            str(strtointdef(sepdados(Item, 4), 0) / 1000: 8: 3, b); b := zcomp(ptov(b), 7);
            result := Urn_ret2(Urano1FIT_VendaItem(e, //codigo
               copy(sepdados(Item, 2), 1, 17), // Descricao
               sepdados(Item, 4), // quantidade
               sepdados(Item, 5), // preco
               a, // tributacao
               iif(copy(e, 1, 1) = '2', 'KG', 'UN'), '1'));
            if not Result then exit;
            inc(contai_Zant);
            a := sepdados(item, 6);
            if strtointdef(a, 0) > 0 then begin
               str((strtointdef(sepdados(Item, 4), 0) / 1000) * strtointdef(sepdados(Item, 5), 0): 8: 2, temp);
               temp := copy(temp, 1, pos('.', temp) - 1);
               str(StrToFloat(temp) - ((strtointdef(temp, 0) * strtointdef(copy(a, 1, 2), 0)) div 100): 8: 0, a);
               a := IntToStr(strtointdef(temp, 0) - strtointdef(a, 0));
               Result := URN_Ret2(Urano1FIT_DescontoItem('0', 'Item Anterior:', a)); // Desconto de item
            end;
         end;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            onError(item, 'VendeItem3Dig: Não suportado ou não desenvolvido nesta ECF');
         end;
      Schalter3D:
         begin
            onError(item, 'VendeItem3Dig: Não suportado ou não desenvolvido nesta ECF');
         end;
      Schalter2S:
         begin
            onError(item, 'VendeItem3Dig: Não suportado ou não desenvolvido nesta ECF');
         end;
      SCFI:
         begin
            onError(item, 'VendeItem3Dig: Não suportado ou não desenvolvido nesta ECF');
         end;   
      BematechMP40, BematechMP20, BematechTermica:
         begin
            b := sepdados(Item, 3);
            if (b = 'F') or (b = 'ST') then b := 'FF';
            if (b = 'I') or (b = 'IS') then b := 'II';
            if b[1] = 'T' then b := '0' + b[2];
            Result := bem_proc('56|' +
               sepdados(item, 1) + '|' + // Codigo
               sepdados(item, 2) + '|' + // Descricao
               b + '|' + // Tributacao
               zcomp(sepdados(item, 4), 7) + '|' + // Quantidade
               zcomp(sepdados(item, 5), 8) + '|' + // Preco unitario
               sepdados(item, 6)); // Desconto em percentual
         end;
       Elgin:
         begin
            b := sepdados(Item, 3);
            if (b = 'F') or (b = 'ST') then b := 'FF';
            if (b = 'I') or (b = 'IS') then b := 'II';
            if b[1] = 'T' then b := '0' + b[2];
            Result := bem_proc('56|' +
               sepdados(item, 1) + '|' + // Codigo
               sepdados(item, 2) + '|' + // Descricao
               b + '|' + // Tributacao
               zcomp(sepdados(item, 4), 7) + '|' + // Quantidade
               zcomp(sepdados(item, 5), 8) + '|' + // Preco unitario
               sepdados(item, 6)); // Desconto em percentual
         end;
   end;
   Result := Result And Retorno_Impressora;
   if Result then begin
      ValorCupom := IntToStr(strtointdef(ValorCupom, 0) + (StrtointDef(sepdados(Item, 4), 0) * StrtointDef(sepdados(Item, 5), 0)));
      if assigned(FTotalCupom) then OnTotalCupom(valorCupom);
   end;
end;

////////////////////////////////////////////////////////////////
function TDefFPrinter.SubtotalizaCupom(valor: string): Boolean;
////////////////////////////////////////////////////////////////
var
   aComando: array[0..0] of Char;
   a: string;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis:
         begin
            result := AtualizaValorCupom;
         end;

      Sweda03, Sweda10:
      begin
         iRetorno := Sweda_SubTotal(valor);
         Analisa_iRetorno();
         Result:= (iRetorno=1);
      end;

      NCR1X: Result := NCR_proc('14' + tiramsc(Valor));
      NCR2x, NCR7141: Result := NCR_proc('14' + IntToStr(strtointdef(tiramsc(Valor), 0)));
      Urano2EFE, Urano1FIT, Urano1EFC, Urano2EFC: Result := true;
      ZanthusIZ11, ZanthusIZ10, zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            str(strtointdef(valor, 0) / 100: 8: 2, valor);
            valor := ptov(valor);
            if (impressora = ZanthusIZ10) or (impressora = ZanthusIZ11) then begin
               valor := space(37 - Length(valor)) + valor + '   ';
            end else begin
               valor := space(39 - Length(valor)) + valor + '   ';
            end;
            zan_proc('O', iif(impressora = ZanthusIZ41, '   ', '') + valor);
         end;
      Schalter3D, Schalter2S, SCFI: Result := true;
      BematechMP20,BematechMP40, BematechTermica: begin
         iRetorno := Bematech_SubTotal(valor);
         Analisa_iRetorno();
         Result:= (iRetorno=1);
         end;
      Elgin: begin
         iRetorno := Elgin_SubTotal(valor);
         Analisa_iRetorno();
         Result:= (iRetorno=1);
         end;
      Procomp_2011:
         begin
            a := '&';
            LeProComp(Procomp_TotalizarCupom(StrPCopy(aComando, ''),
               PChar(a),
               PChar('000000000000000'),
               PChar('              ')), True);
         end;
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := trends_ret(Trends_TotalizarCupomParcial(ultimaresp));
         end;
   end;
   Result := Result And Retorno_Impressora;
end;
///////////////////////////////////////////////////
function TDefFPrinter.SubtotalizaCupomMFD: Boolean;
///////////////////////////////////////////////////
var
   aComando: array[0..0] of Char;
   a: string;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis:
         begin
            result := AtualizaValorCupom;
         end;

      Sweda03, Sweda10:
      begin
         Result:= True;
      end;

      Urano2EFE, Urano1FIT, Urano1EFC, Urano2EFC: Result := true;
      Schalter3D, Schalter2S, SCFI: Result := true;

      BematechMP20,BematechMP40, BematechTermica: begin
         iRetorno := Bematech_SubTotalizaCupomMFD;
         Analisa_iRetorno();
         Result:= (iRetorno=1);
      end;
      Elgin: begin
         iRetorno := Elgin_SubTotalizaCupomMFD;
         Analisa_iRetorno();
         Result:= (iRetorno=1);
      end;

      Procomp_2011:
         begin
            a := '&';
            LeProComp(Procomp_TotalizarCupom(StrPCopy(aComando, ''),
               PChar(a),
               PChar('000000000000000'),
               PChar('              ')), True);
         end;
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := trends_ret(Trends_TotalizarCupomParcial(ultimaresp));
         end;
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////
function TDefFPrinter.PagamentoCupom(Dados: string): Boolean;
var
   x, y: Integer;
   princ, a, b: string;
begin
   // Dados devera set:FFDDDDDDDDDDVVVVVVVVVVVVVC (26 Caracteres)
   // F de Numero da finalizadora (2)
   // D Descricao da finalizadora (10)
   // V Valor da Finalizadora     (13)
   // C '!' se finalizadora normal ou '$' se finalizadora acumulada para cup.vinculados
   // Ex. 01Dinheiro  0000000001234!
   //////////////////////////////////////////////
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis:
         begin
            DTR_Proc('S' +
               'S----------------------------------------' +
               'S' + copy(rodape.Linha1 + space(40), 1, 40) +
               'S' + copy(rodape.Linha2 + space(40), 1, 40) +
               'S' + copy(rodape.Linha3 + space(40), 1, 40) +
               'S' + copy(rodape.Linha4 + space(40), 1, 40) +
               'S' + copy(rodape.Linha5 + space(40), 1, 40));
            for x := 1 to 20 do begin
               princ := sepdados(dados, x);
               if princ <> '' then begin
                  if (eprom[5] = '4') then begin
                     if (strtointdef(Dtr_desconto, 0) > 0) or (strtointdef(Dtr_acrescimo, 0) > 0) then begin
                        if strtointdef(Dtr_desconto, 0) > 0 then begin
                           Result := DTR_Proc('c' +
                              zcomp(IntToStr(strtointdef(copy(princ, 1, 2), 0) - 1), 2) +
                              zcomp('', 18) +
                              zcomp(copy(princ, 13, 13), 14) +
                              zcomp(dtr_desconto, 14) + 'D');
                           dtr_desconto := '0';
                        end;
                        if strtointdef(dtr_acrescimo, 0) > 0 then begin
                           Result := DTR_Proc('c' +
                              zcomp(IntToStr(strtointdef(copy(princ, 1, 2), 0) - 1), 2) +
                              zcomp('', 18) +
                              zcomp(copy(princ, 13, 13), 14) +
                              zcomp(dtr_acrescimo, 14) + 'A');
                           dtr_acrescimo := '0';
                        end;
                     end else begin
                        result := DTR_Proc('D' + zcomp(IntToStr(strtointdef(copy(princ, 1, 2), 0) - 1), 2) +
                           zcomp('', 18) +
                           zcomp(copy(princ, 13, 13), 14));
                     end;
                  end else begin
                     // 9.10
                     result := DTR_Proc('D' + zcomp(IntToStr(strtointdef(copy(princ, 1, 2), 0) - 1), 2) +
                        zcomp('', 18) +
                        zcomp(copy(princ, 13, 13), 14));
                  end;
                  sleep(700);
               end;
            end;
            sleep(1000);
         end;
      Sweda03:
         begin
            a := #27 + '.10';
            for x := 1 to 20 do begin
               princ := sepdados(dados, x);
               if princ <> '' then begin
                  a := a + copy(princ, 1, 2) + zcomp(copy(princ, 14, 12), 12);
               end;
            end;
            a := a + '}';
            Result := swd_proc(a);
            sleep(2000);
            pronto := true;
         end;
      Sweda10:
         begin
            a := #27 + '.10';
            for x := 1 to 20 do begin
               princ := sepdados(dados, x);
               if princ <> '' then begin
                  a := a + copy(princ, 1, 2) + zcomp(copy(princ, 14, 12), 12);
               end;
            end;
            a := a + '}';
            Result := swd_proc(a);
            sleep(2000);
            pronto := true;
         end;
      NCR1X:
         begin
            for x := 1 to 20 do begin
               princ := sepdados(dados, x);
               if princ <> '' then begin
                  result := NCR_proc('25' + copy(princ, 3, 10) + '\' + copy(princ, 13, 13));
               end;
            end;
         end;
      NCR2x, NCR7141:
         begin
            for x := 1 to 20 do begin
               princ := sepdados(dados, x);
               if princ <> '' then begin
                  result := NCR_proc('25' + copy(princ, 1, 2) + '\' + copy(princ, 13, 13));
               end;
            end;
         end;
      Urano2EFE:
         begin
            for x := 1 to 20 do begin
               princ := sepdados(dados, x);
               if princ <> '' then begin
                  result := URN_Ret(Urano2EFE_pagamento(PChar(copy(princ, 3, 10)), PChar(copy(princ, 13, 13))));
               end;
            end;
         end;
      Urano1EFC, Urano2EFC:
         begin
            //for x := 1 to 20 do begin
            Result := false;
            for x := 1 to 20 do begin
               princ := sepdados(dados, x);
               if princ <> '' then begin
                  a := copy(princ, 1, 2);
                  b := IntToStr(strtointdef(copy(princ, 13, 13), 0));
                  if princ[26] = '$' then
                     result := URN_Ret3(UranoEFC_pagamento(a, ':', b, '1'))
                  else
                     result := URN_Ret3(UranoEFC_pagamento(a, ':', b, '0'))
               end else exit;
            end;
         end;
      Urano1FIT:
         begin
            //for x := 1 to 20 do begin
            Result := false;
            x := 1;
            while x < 30 do begin
               princ := sepdados(dados, x);
               if princ <> '' then result := URN_Ret2(Urano1FIT_pagamento(copy(princ, 1, 2), space(10), copy(princ, 16, 10))) else exit;
               inc(x);
            end;
            pronto := true;
         end;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            if rodape.linha1 <> '' then result := zan_proc('o', '00' + rodape.linha1) else result := zan_proc('o', '00' + '.'); if not result then exit;
            if rodape.linha2 <> '' then result := zan_proc('o', '01' + rodape.linha2) else result := zan_proc('o', '00' + '.'); if not result then exit;
            if rodape.linha3 <> '' then result := zan_proc('o', '02' + rodape.linha3) else result := zan_proc('o', '00' + '.'); if not result then exit;
            if rodape.linha4 <> '' then result := zan_proc('o', '03' + rodape.linha4) else result := zan_proc('o', '00' + '.'); if not result then exit;
            if rodape.linha5 <> '' then result := zan_proc('o', '04' + rodape.linha5) else result := zan_proc('o', '00' + '.'); if not result then exit;
            AtualizaValorCupom;
            y := 0;
            for x := 1 to 20 do begin
               princ := sepdados(dados, x);
               if princ <> '' then begin
                  str(strtointdef(copy(princ, 13, 13), 0) / 100: 8: 2, a);
                  a := trim(ptov(a));
                  y := y + strtointdef(tiravg(a), 0);
                  if impressora = ZanthusIZ10 then Result := zan_proc('i', copy(princ, 1, 2) + space(37 - Length(a)) + a + '   ');
                  if impressora = ZanthusIZ11 then Result := zan_proc('i', copy(princ, 1, 2) + space(35 - Length(a)) + a + '   ');
                  if (impressora <> ZanthusIZ11) and (impressora <> ZanthusIZ10) then Result := zan_proc('i', copy(princ, 1, 2) + iif(impressora = ZanthusIZ41, '   ', '') + space(37 - Length(a)) + a + '   ');
               end;
               if not result then exit;
            end;
            if y > strtointdef(ValorCupom, 0) then begin
               y := y - strtointdef(ValorCupom, 0);
               str(y / 100: 8: 2, a);
               a := ptov(a);
               if (impressora = ZanthusIZ10) or (impressora = ZanthusIZ11) then begin
                  zan_proc('j', iif(impressora = ZanthusIZ41, '   ', '') + space(37 - length(a)) + a + space(3));
               end else begin
                  zan_proc('j', iif(impressora = ZanthusIZ41, '   ', '') + space(39 - length(a)) + a + space(3));
               end;
            end;
         end;
      Schalter3D:
         begin
            for x := 1 to 20 do begin
               princ := sepdados(dados, x);
               b := copy(princ, 16, 10);
               if princ <> '' then begin
                  sleep(50);
                  Result := retornoschd(Schalter3D_Pagamento(0, PChar(copy(princ, 1, 2)), PChar(b), 1));
               end;
            end;
         end;
      Schalter2S:
         begin
            for x := 1 to 20 do begin
               princ := sepdados(dados, x);
               b := copy(princ, 16, 10);
               if princ <> '' then begin
                  sleep(50);
                  Result := retsch2(Schalter2S_ecfPagCancPag(0, PChar(uppercase(copy(princ, 3, 10))), PChar(b), 1, 0));
               end;
            end;
         end;
      SCFI:
         begin
            for x := 1 to 20 do begin
               princ := sepdados(dados, x);
               b := copy(princ, 16, 10);
               if princ <> '' then begin
                  sleep(50);
                  iRetorno := SCFI_ecfPagCancPag(0, PChar(uppercase(copy(princ, 3, 10))), PChar(b), 1, 0);
                  Result := iRetorno = 0;
               end;
            end;
         end;
      BematechMP40, BematechMP20, BematechTermica:
         begin
            Bematech_FormataTX(#27 + '|32|d|00000000000000|' + #27);
            for x := 1 to 20 do begin
               princ := sepdados(dados, x);
               if princ <> '' then begin
                  sleep(50);
                  Result := bem_proc('72|' + copy(princ, 1, 2) + '|' + zcomp(copy(princ, 13, 13), 14));
               end;
            end;
         end;
     { Elgin:
         begin
            Elgin_FormataTX(#27 + '|32|d|00000000000000|' + #27);
            for x := 1 to 20 do begin
               princ := sepdados(dados, x);
               if princ <> '' then begin
                  sleep(50);
                  Result := bem_proc('72|' + copy(princ, 1, 2) + '|' + zcomp(copy(princ, 13, 13), 14));
               end;
            end;
         end; }
      Procomp_2011:
         begin
            a := '0';
            for x := 1 to 20 do begin
               princ := sepdados(dados, x);
               if princ <> '' then begin
                   // Efetua o pagamento
                  LeProComp(Procomp_Pagamento(Pchar(zComp(IntToStr(StrToInt(copy(princ, 1, 2)) - 1), 2)),
                     Pchar('00' + copy(princ, 13, 13)), Pchar(a)), True);
                  sleep(50);
               end;
            end;
             // Troco
            LeProComp(Procomp_Pagamento(Pchar('00'), Pchar('000000000000000'), Pchar(a)), True);
         end;
      Trends10E:
         begin
            Ultimaresp := space(1000);
            if strtointdef(dtr_acrescimo, 0) > 0 then begin
               Trends_TotalizarCupom('@', '&', zcomp(dtr_acrescimo, 15), #0, ultimaresp);
            end else begin
               if strtointdef(dtr_desconto, 0) > 0 then begin
                  Trends_TotalizarCupom(#0, '&', zcomp(dtr_desconto, 15), #0, ultimaresp);
               end else Trends_TotalizarCupom(#0, '&', zcomp('0', 15), #0, ultimaresp);
            end;
            dtr_acrescimo:='0';
            dtr_desconto:='0';
            y := 0;
            for x := 1 to 20 do begin
               princ := sepdados(dados, x);
               if princ <> '' then begin
                  a := princ;
                  Ultimaresp := space(1000);
                  Result := Trends_ret(Trends_Pagamento(zcomp(IntToStr(strtointdef(copy(princ, 1, 2), 1) - 1),2), zcomp(copy(princ, 13, 13),15), '0', ultimaresp));
                  y := y + strtointdef(copy(princ, 15, 11), 0);
               end;
            end;
            AtualizaValorCupom;
            if Y > strtointdef(valorcupom, 0) then Result := Trends_ret(Trends_Pagamento(copy(a, 1, 2), zcomp('0', 15), '1', ultimaresp));
         end;
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////
function TDefFPrinter.FechaCupomFiscal(ParamCupom: string): Boolean;
var
  rodlinha: string;
  CupomAnexo : String;
  FormaPagamento,
  AcrescimoDesconto,
  TipoAcrescimoDesconto,
  ValorAcrescimoDesconto,
  ValorPago,
  Mensagem,
  Indice: String;

  pDescricao: array[0..30] of char;
  pValor: TPontoFlutuante;
  pIndice : array[0..2] of char;
  pMensagem : array[0..80] of char;

  sPontoDec: String;

  Vinculado: TBooleano;
begin
   FormaPagamento         := ParseParam(ParamCupom, FISCAL_FECHA_NOTA_TIPO_PAGAMENTO);
   AcrescimoDesconto      := ParseParam(ParamCupom, FISCAL_FECHA_NOTA_ACRES_DESC);
   TipoAcrescimoDesconto  := ParseParam(ParamCupom, FISCAL_FECHA_NOTA_TIPO_ACRES_DESC);
   ValorAcrescimoDesconto := ParseParam(ParamCupom, FISCAL_FECHA_NOTA_VALOR_ACRES_DESC);
   ValorPago              := ParseParam(ParamCupom, FISCAL_FECHA_NOTA_VALOR_PAGO);
   Mensagem               := ParseParam(ParamCupom, FISCAL_FECHA_NOTA_MSG);
   sPontoDec              := ParseParam(ParamCupom, FISCAL_ITEM_PONTO_DEC);
   Indice                 := ParseParam(ParamCupom, FISCAL_FECHA_NOTA_IDX_PAGAMENTO);

   Result := false;
   CupomAnexo := 'N';
   case Impressora of
      None: Result := false;
      Dataregis: result := True;
      Sweda03, Sweda10:
       begin
            FormaPagamento := Copy(FormaPagamento, 0, 5);
            iRetorno := Sweda_FechaCupom(FormaPagamento, AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto, ValorPago, Mensagem);
            Analisa_iRetorno();
            Result:= (iRetorno=1);
       end;

      NCR2x, NCR7141, NCR1X: Result := NCR_Proc('190' + iif(trim(rodape.linha1) <> '', '\' + rodape.linha1, '') +
            iif(trim(rodape.linha2) <> '', '\' + rodape.linha2, '') +
            iif(trim(rodape.linha3) <> '', '\' + rodape.linha3, '') +
            iif(trim(rodape.linha4) <> '', '\' + rodape.linha4, '') +
            iif(trim(rodape.linha5) <> '', '\' + rodape.linha5, ''));
      Urano2EFE:
         begin
            result := Urn_Ret(Urano2EFE_MensagemPromocional('0', pchar(copy(' ' + rodape.linha1 + space(41), 1, 41) + copy('  ' + rodape.linha2 + space(42), 1, 42) + copy('  ' + rodape.linha3 + space(42), 1, 42))));
            result := Urn_Ret(Urano2EFE_FinalizaVenda('0', PChar(Dados.Operador)));
            result := Urn_Ret(Urano2EFE_avancolinha(0, 5));
            result := Urn_Ret(Urano2EFE_imprimecabecalho);
         end;
      Urano1EFC:
         begin
            Urn_Ret3(UranoEFC_Propaganda('0', PChar(
               copy('    ' + rodape.linha1 + space(48), 1, 48) +
               copy('    ' + rodape.linha2 + space(48), 1, 48) +
               copy('    ' + rodape.linha3 + space(48), 1, 48) +
               copy('    ' + rodape.linha4 + space(48), 1, 48)
               )));
            result := Urn_Ret3(UranoEFC_FechaCupom(PChar(Dados.Operador)));
            sleep(2000);
            Urn_ret3(UranoEFC_AvancaLinhas('5'));
         end;
      Urano2EFC:
         begin
            Urn_Ret3(UranoEFC_Propaganda('0', PChar(
               copy(rodape.linha1 + space(42), 1, 42) +
               copy(rodape.linha2 + space(42), 1, 42) +
               copy(rodape.linha3 + space(42), 1, 42) +
               copy(rodape.linha4 + space(42), 1, 42)
               )));
            result := Urn_Ret3(UranoEFC_FechaCupom(PChar(Dados.Operador)));
            sleep(2000);
            Urn_ret3(UranoEFC_AvancaLinhas('8'));
         end;
      Urano1FIT:
         begin
            Urn_Ret2(Urano1FIT_Propaganda(copy(rodape.linha1 + space(40), 1, 40) +
               copy(rodape.linha2 + space(40), 1, 40) +
               copy(rodape.linha3 + space(40), 1, 40) +
               copy(rodape.linha4 + space(40), 1, 40)));
            result := Urn_Ret2(Urano1FIT_FechaCUpom(Dados.Operador));
            Urn_ret2(Urano1FIT_AvancaLinhas('06'));
         end;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            //if rodape.linha1 <> '' then zan_proc('o', '00' + rodape.linha1);
            //if rodape.linha2 <> '' then zan_proc('o', '01' + rodape.linha2);
            //if rodape.linha3 <> '' then zan_proc('o', '02' + rodape.linha3);
            //if rodape.linha4 <> '' then zan_proc('o', '03' + rodape.linha4);
            //if rodape.linha5 <> '' then zan_proc('o', '04' + rodape.linha5);
            Result := zan_proc('9', '');
            if result then begin
               if impressora = ZanthusIZ41 then zan_proc('U', '08') else zan_proc('U', '06'); // avanca 3 linhas
               zan_proc('6', ''); // Imprime cabecalho
            end;
         end;
      Schalter3D:
         begin
            if rodape.linha1 <> '' then Schalter3D_ImpLinha(PChar(rodape.linha1));
            if rodape.linha2 <> '' then Schalter3D_ImpLinha(PChar(rodape.linha2));
            if rodape.linha3 <> '' then Schalter3D_ImpLinha(PChar(rodape.linha3));
            if rodape.linha4 <> '' then Schalter3D_ImpLinha(PChar(rodape.linha4));
            if rodape.linha5 <> '' then Schalter3D_ImpLinha(PChar(rodape.linha5));
            if CupomAnexo = 'S' then Schalter3D_FimTransVinc(PChar(dados.Operador), '01') else
               Result := retornoschd(Schalter3D_FimTrans(''));
            retornoSchd(Schalter3D_lineFeed(1, 7));
         end;
      Schalter2S:
         begin
            if rodape.linha1 <> '' then Schalter2S_ecfImpLinha(PChar(rodape.linha1));
            if rodape.linha2 <> '' then Schalter2S_ecfImpLinha(PChar(rodape.linha2));
            if rodape.linha3 <> '' then Schalter2S_ecfImpLinha(PChar(rodape.linha3));
            if rodape.linha4 <> '' then Schalter2S_ecfImpLinha(PChar(rodape.linha4));
            if rodape.linha5 <> '' then Schalter2S_ecfImpLinha(PChar(rodape.linha5));
            Result := retsch2(Schalter2S_ecfFimTrans(pchar('Oper:' + dados.operador)));
            Schalter2S_ecfLineFeed(1, 7);
         end;
      SCFI:
         begin
            if rodape.linha1 <> '' then Schalter2S_ecfImpLinha(PChar(rodape.linha1));
            if rodape.linha2 <> '' then Schalter2S_ecfImpLinha(PChar(rodape.linha2));
            if rodape.linha3 <> '' then Schalter2S_ecfImpLinha(PChar(rodape.linha3));
            if rodape.linha4 <> '' then Schalter2S_ecfImpLinha(PChar(rodape.linha4));
            if rodape.linha5 <> '' then Schalter2S_ecfImpLinha(PChar(rodape.linha5));
            iRetorno := SCFI_ecfFimTrans(pchar('Oper:' + dados.operador));
            Analisa_iRetorno();
            Result := (iRetorno=0);
            SCFI_ecfLineFeed(1, 7);
         end;
      BematechMP20, BematechMP40, BematechTermica:
         begin
            FormaPagamento := Copy(FormaPagamento, 0, 16);
            iRetorno := Bematech_FechaCupom(FormaPagamento, AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto, ValorPago, Mensagem);
            Analisa_iRetorno();
            Result:= (iRetorno=1);
         end;
      Elgin:
         begin
            FormaPagamento := Copy(FormaPagamento, 0, 16);
            iRetorno := Elgin_FechaCupom(FormaPagamento, AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto, ValorPago, Mensagem);
            Analisa_iRetorno();
            Result:= (iRetorno=1);
         end;
      Procomp_2011:
         begin
            rodlinha := '';
            if rodape.linha1 <> '' then rodlinha := rodlinha + sdcomp(rodape.linha1, 48);
            if rodape.linha2 <> '' then rodlinha := rodlinha + sdcomp(rodape.linha2, 48);
            if rodape.linha3 <> '' then rodlinha := rodlinha + sdcomp(rodape.linha3, 48);
            if rodape.linha4 <> '' then rodlinha := rodlinha + sdcomp(rodape.linha4, 48);
            if rodape.linha5 <> '' then rodlinha := rodlinha + sdcomp(rodape.linha5, 48);

            // Fecha o cupom fiscal
            LeProComp(Procomp_FechaCupomFiscal(Pchar('S' + zcomp(IntToStr(Length(rodlinha)), 3)), Pchar(rodlinha)), True);
//            LeProComp( Procomp_FechaCupomFiscal(Pchar('S250'),Pchar(rodlinha)),True);
         end;
      Trends10E:
         begin
            Ultimaresp := space(1000);
            rodlinha := '';
            if rodape.linha1 <> '' then rodlinha := rodlinha + space(4) + sdcomp(rodape.linha1, 44);
            if rodape.linha2 <> '' then rodlinha := rodlinha + space(4) + sdcomp(rodape.linha2, 44);
            if rodape.linha3 <> '' then rodlinha := rodlinha + space(4) + sdcomp(rodape.linha3, 44);
            if rodape.linha4 <> '' then rodlinha := rodlinha + space(4) + sdcomp(rodape.linha4, 44);
            if rodape.linha5 <> '' then rodlinha := rodlinha + space(4) + sdcomp(rodape.linha5, 44);
            Result := Trends_ret(Trends_FechaCupomFiscal(rodlinha, ultimaresp));
         end;
      AFRAC:
      begin
        Vinculado := _AFRAC_BooleanToTBooleano(False);
        _AFRAC_CopyStrToArray(pIndice, Indice);
        _AFRAC_CopyStrToArray(pDescricao, FormaPagamento);
        pValor := _AFRAC_FloatToPontoFlutuante(ValorPago, sPontoDec, 2);
        _AFRAC_CopyStrToArray(pMensagem, ' ');

        iRetorno := AFRAC_FormaPagamento(pDescricao, pIndice, pValor, pMensagem);

        Result := iRetorno=0;
        Analisa_iRetorno();

        if result then
        begin

          iRetorno := AFRAC_FecharCupom(Vinculado);
          Analisa_iRetorno();
          Result:= (iRetorno=0);
        end;
      end;
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////
function TDefFPrinter.CancelaUltimoItem(Descricao, Valor: string): Boolean;
var
   a, b, c, d: string;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis: result := Dtr_Proc('B');

      Sweda03, Sweda10:
      begin
        iRetorno := Sweda_CancelaItemAnterior;
        Analisa_iRetorno();
        Result:= (iRetorno=1);
      end;

      NCR2x, NCR7141, NCR1X: Result := NCR_Proc('15' + Valor);
      Urano2EFE:
         begin
            StrCopy(@s1, '0');
            result := Urn_ret(Urano2EFE_LeRegistradores('55', @s1));
            vol := IntToStr(strtointdef(tiramsc(StrPas(@s1)), 0));
            result := URN_Ret(Urano2EFE_CanItem(PChar(Descricao), PChar(vol)));
         end;
      Urano1EFC, Urano2EFC: result := URN_Ret3(UranoEFC_CancelaItem('Cancelado Ultimo Item', PChar(IntToStr(contai_Zant))));
      Urano1FIT: result := URN_Ret2(Urano1FIT_CancelaItem(zcomp(IntToStr(contai_Zant), 3)));
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            if UltItem_Zant = '' then begin
               onError('Cancelamento de Ultimo Item', 'Devido a incompatibilidade não posso excluir este item.' + #13 + 'Use o cancelamento de Item aleatorio para esta Operação!');
               Result := false;
               exit;
            end;
            if TabAliq_Zant = '' then if Zan_Proc('P', '000420') then TabAliq_Zant := copy(Ultimaresp, 3, 50);
            d := copy(trim(sepdados(UltItem_Zant, 3)), 1, 1);
            if d <> 'T' then begin
               if d = 'S' then d := 'F';
               b := '        ';
            end else begin
               b := copy(sepdados(UltItem_Zant, 3), 2, 2);
               b := 'T' + copy(TabAliq_Zant, (strtointdef(copy(trim(sepdados(UltItem_Zant, 3)), 2, 2), 0) * 4) - 3, 2) + '.00' + '% ';
            end;
            d := ' ' + d + ' '; // Determina se é tributado, Isento ou Substituicao
            str(strtointdef(sepdados(UltItem_Zant, 8), 0) / 100: 8: 2, c);
            c := ptov(c);
            c := space(7 - length(c)) + c;
            a := zcomp(inttostr(contai_Zant - 1), 4);
            if impressora = ZanthusIZ11 then begin
               result := zan_proc('d', a + scomp(sepdados(UltItem_Zant, 2), 22) + b + c + d);
            end else begin
               result := zan_proc('d', a + iif(impressora = ZanthusIZ41, '   ', '') + copy(sepdados(UltItem_Zant, 2) + space(24), 1, 24) + b + c + d);
            end;
            UltItem_Zant := '';
         end;
      Schalter3D: result := retornoschd(Schalter3D_CancItemDef(pchar(IntToStr(Contai_zant)), '** ITEM ANTERIOR CANCELADO **'));
      Schalter2S: Result := retsch2(Schalter2S_ecfCancItem('ITEM ANTERIOR CANCELADO'));
      SCFI:
         begin
           iRetorno := SCFI_ecfCancItem('ITEM ANTERIOR CANCELADO');
           Result := iRetorno = 0;
         end;
      BematechMP40, BematechMP20, BematechTermica: Result := bem_proc('13');
      Elgin: Result := bem_proc('13');
      //Procomp_2011: LeProComp(Procomp_CancItem(Contai_zant)); // Procomp precisa do numero do item p/ cancelar
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_CancelamentoItem(zcomp(IntToStr(contai_zant), 3), ultimaresp));
         end;
   end;
   Result := Result And Retorno_Impressora;
   if Result then begin
      ValorCupom := IntToStr(strtointdef(ValorCupom, 0) - strtointdef(tiravg(ptov(valor)), 0));
      if assigned(FTotalCupom) then OnTotalCupom(valorCupom);
   end;
end;
///////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ValorFormaPagamento( FormaPagamento: String; Valor: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       FormaPagamento := Copy(FormaPagamento, 0, 16);
       iRetorno := Bematech_ValorFormaPagamento( FormaPagamento,Valor );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin :
     begin
       FormaPagamento := Copy(FormaPagamento, 0, 16);
       iRetorno := Elgin_ValorFormaPagamento( FormaPagamento,Valor );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;

end;
///////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.IncluiCidadeFavorecido( Cidade: String; Favorecido: String ): boolean;
begin
   Result := False;
    if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then
       begin
       iRetorno := Bematech_IncluiCidadeFavorecido( Cidade,Favorecido );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
       end;
    if (impressora=Elgin) then
       begin
       iRetorno := Elgin_IncluiCidadeFavorecido( Cidade,Favorecido );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
       end;
    Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.VerificaStatusCheque( var StatusCheque: Integer ): boolean;
begin
   Result := False;
    if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then
       begin
       iRetorno := Bematech_VerificaStatusCheque(StatusCheque);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
       end;
    if (impressora=Elgin) then
       begin
       iRetorno := Elgin_VerificaStatusCheque(StatusCheque);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
       end;
    Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ImprimeCopiaCheque: boolean;
begin
   Result := False;
    if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then
       begin
       iRetorno := Bematech_ImprimeCopiaCheque;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
       end;
    if (impressora=Elgin) then
       begin
       iRetorno := Elgin_ImprimeCopiaCheque;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
       end;
    Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ResetaImpressora: boolean;
begin
   Result := False;
    if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then
       begin
       iRetorno := Bematech_ResetaImpressora;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
       end;
    if (impressora=Elgin) then
       begin
       iRetorno := Elgin_ResetaImpressora;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
       end;
    Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ForcaImpactoAgulhas( ForcaImpacto: Integer ): boolean;
begin
   Result := False;
    if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then
       begin
       iRetorno := Bematech_ForcaImpactoAgulhas( ForcaImpacto );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
       end;
    if (impressora=Elgin) then
       begin
       iRetorno := Elgin_ForcaImpactoAgulhas( ForcaImpacto );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
       end;
    Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.ProgramaCaracterAutenticacao( Parametros: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       iRetorno := Bematech_ProgramaCaracterAutenticacao( Parametros );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin :
     begin
       iRetorno := Elgin_ProgramaCaracterAutenticacao( Parametros );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////
function TDefFPrinter.LinhasEntreCupons( Linhas: Integer ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       iRetorno := Bematech_LinhasEntreCupons( Linhas );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin :
     begin
       iRetorno := Elgin_LinhasEntreCupons( Linhas );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;
    Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.NomeiaRelatorioGerencialMFD(Indice, Descricao : string): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       iRetorno := Bematech_NomeiaRelatorioGerencialMFD(Indice, Descricao);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin :
     begin
       iRetorno := Elgin_NomeiaRelatorioGerencialMFD(Indice, Descricao);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;
   end;

    Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.NomeiaTotalizadorNaoSujeitoIcms( Indice: Integer; Totalizador: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       iRetorno := Bematech_NomeiaTotalizadorNaoSujeitoIcms( Indice,Totalizador );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
       iRetorno := Elgin_NomeiaTotalizadorNaoSujeitoIcms( Indice,Totalizador );
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;
    Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.NomeiaDepartamento( Indice: Integer; Departamento: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       iRetorno := Bematech_NomeiaDepartamento( Indice,Departamento);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
       iRetorno := Elgin_NomeiaDepartamento( Indice,Departamento);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;
   end;

   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////
function TDefFPrinter.ProgramaTruncamento: boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       iRetorno := Bematech_ProgramaTruncamento;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       iRetorno := Sweda_ProgramaTruncamento;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin :
     begin
       iRetorno := Elgin_ProgramaTruncamento;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;

end;
////////////////////////////////////////////////////////////////
function TDefFPrinter.ProgramaArredondamento: boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       iRetorno := Bematech_ProgramaArredondamento;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       iRetorno := Sweda_ProgramaArredondamento;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin :
     begin
       iRetorno := Elgin_ProgramaArredondamento;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;

end;
///////////////////////////////////////////////////
function TDefFPrinter.CancelaItemAnterior: boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica :
     begin
       iRetorno := Bematech_CancelaItemAnterior;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       iRetorno := Sweda_CancelaItemAnterior;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin :
     begin
       iRetorno := Elgin_CancelaItemAnterior;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

    end;

    Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////
function TDefFPrinter.CancelaItemGenerico( NumeroItem: String ): boolean;
begin
   Result := False;

   case impressora of

    BematechMP20, BematechMP40, BematechTermica :
    begin
      iRetorno := Bematech_CancelaItemGenerico( NumeroItem );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

    Sweda03, Sweda10 :
    begin
      iRetorno := Sweda_CancelaItemGenerico( NumeroItem );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

    Elgin :
    begin
      iRetorno := Elgin_CancelaItemGenerico( NumeroItem );
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

    end;
    Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////
function TDefFPrinter.AtivaVerao: Boolean;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis: result := Dtr_Proc('TA');
      Sweda03, Sweda10: Result := swd_proc(#27 + '.36S}');
      NCR2x, NCR7141, NCR1X: Result := false;
      Urano2EFE: Result := URN_Ret(Urano2EFE_programaRelogio('1', '000000', '000000'));
      Urano1EFC, Urano2EFC: Result := urn_ret3(UranoEFC_ProgramaRelogio('1', '', ''));
      Urano1FIT: Result := urn_ret2(Urano1FIT_ProgramaRelogio('1', '', ''));
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41: Result := Zan_Proc('\', '1');
      Schalter3D: Result := retornoschd(Schalter3D_AcertaData(strtoint(copy(dados.dataimp, 1, 2)), strtoint(copy(dados.dataimp, 3, 2)), strtoint('20' + copy(dados.dataimp, 5, 2)), strtointdef(copy(dados.horaimp, 1, 2), 0) + 1, strtoint(copy(dados.horaimp, 3, 2)), 0));
      Schalter2S: Result := retsch2(Schalter2S_ecfAcertaData(strtoint(copy(dados.dataimp, 1, 2)), strtoint(copy(dados.dataimp, 3, 2)), strtoint('20' + copy(dados.dataimp, 5, 2)), strtointdef(copy(dados.horaimp, 1, 2), 0) + 1, strtoint(copy(dados.horaimp, 3, 2)), 0));
      SCFI: begin
             iRetorno := SCFI_ecfAcertaData(strtoint(copy(dados.dataimp, 1, 2)), strtoint(copy(dados.dataimp, 3, 2)), strtoint('20' + copy(dados.dataimp, 5, 2)), strtointdef(copy(dados.horaimp, 1, 2), 0) + 1, strtoint(copy(dados.horaimp, 3, 2)), 0);
             Analisa_iRetorno();
             Result := (iRetorno=0);
      end;       
      BematechMP40, BematechMP20, BematechTermica: begin
       iRetorno := Bematech_ProgramaHorarioVerao;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
      end;
      Elgin: begin
       iRetorno := Elgin_ProgramaHorarioVerao;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
      end;
      Procomp_2011: LeProComp(Procomp_ProgramaHorarioVerao('+'), True); // 0 Sem relatoria Vinculado 1 Com relatorio vinculado
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_ProgramaHorarioVerao('+', ultimaresp));
         end;
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////
function TDefFPrinter.DestivaVerao: Boolean;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis: result := Dtr_Proc('TD');
      Sweda03: Result := swd_proc(#27 + '.36N}');
      Sweda10: Result := swd_proc(#27 + '.36N}');
      NCR2x, NCR7141, NCR1X: Result := false;
      Urano2EFE: Result := URN_Ret(Urano2EFE_programaRelogio('2', '000000', '000000'));
      Urano1EFC, Urano2EFC: Result := urn_ret3(UranoEFC_ProgramaRelogio('2', '', ''));
      Urano1FIT: Result := urn_ret2(Urano1FIT_ProgramaRelogio('2', '', ''));
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41: Result := Zan_Proc('\', '0');
      Schalter3D: Result := retornoschd(Schalter3D_AcertaData(strtoint(copy(dados.dataimp, 1, 2)), strtoint(copy(dados.dataimp, 3, 2)), strtoint('20' + copy(dados.dataimp, 5, 2)), strtointdef(copy(dados.horaimp, 1, 2), 0) - 1, strtoint(copy(dados.horaimp, 3, 2)), 0));
      Schalter2S: Result := retsch2(Schalter2S_ecfAcertaData(strtoint(copy(dados.dataimp, 1, 2)), strtoint(copy(dados.dataimp, 3, 2)), strtoint('20' + copy(dados.dataimp, 5, 2)), strtointdef(copy(dados.horaimp, 1, 2), 0) - 1, strtoint(copy(dados.horaimp, 3, 2)), 0));
      SCFI:
         begin
            iRetorno := SCFI_ecfAcertaData(strtoint(copy(dados.dataimp, 1, 2)), strtoint(copy(dados.dataimp, 3, 2)), strtoint('20' + copy(dados.dataimp, 5, 2)), strtointdef(copy(dados.horaimp, 1, 2), 0) - 1, strtoint(copy(dados.horaimp, 3, 2)), 0);
            Result := iRetorno = 0;
         end;
      BematechMP40, BematechMP20, BematechTermica: Result := bem_proc('18');
      Elgin: Result := bem_proc('18');
      Procomp_2011: LeProComp(Procomp_ProgramaHorarioVerao('-'), True); // 0 Sem relatoria Vinculado 1 Com relatorio vinculado
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_ProgramaHorarioVerao('-', ultimaresp));
         end;
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.CancelaCupomAtual: Boolean;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis:
         begin
            Result := DTR_proc('D0000000000000000000000000000000000');
            sleep(4000);
            if Result then Result := DTR_proc('F');
            sleep(10000);
         end;

      Sweda03, Sweda10:
      begin
       iRetorno := Sweda_CancelaCupom;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
      end;

      NCR2x, NCR7141, NCR1X: Result := NCR_Proc('18');
      Urano2EFE:
         begin
            result := URN_Ret(Urano2EFE_cancelavenda(PChar(Dados.Operador)));
            result := URN_Ret(Urano2EFE_avancolinha(0, 5));
            result := URN_Ret(Urano2EFE_imprimecabecalho);
         end;
      Urano1EFC:
         begin
            result := URN_Ret3(UranoEFC_cancelavenda(Dados.Operador));
            sleep(2000);
            if Result then Urn_ret3(UranoEFC_AvancaLinhas('05'));
         end;
      Urano2EFC:
         begin
            result := URN_Ret3(UranoEFC_cancelavenda(Dados.Operador));
            sleep(2000);
            if Result then Urn_ret3(UranoEFC_AvancaLinhas('08'));
         end;
      Urano1FIT:
         begin
            result := URN_Ret2(Urano1FIT_cancelavenda(Dados.Operador));
            if Result then Urn_ret2(Urano1FIT_AvancaLinhas('06'));
         end;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            Result := zan_proc(':', '');
            if result then begin
               if impressora = ZanthusIZ41 then zan_proc('U', '08') else zan_proc('U', '06'); // avanca 3 linhas
               zan_proc('6', ''); // Imprime cabecalho
            end;
         end;
      Schalter3D:
         begin
            result := retornoSchd(Schalter3D_CancVenda(' '));
            retornoSchd(Schalter3D_lineFeed(1, 7));
         end;
      Schalter2S:
         begin
            result := retsch2(Schalter2S_ecfCancVenda(pchar('Oper:' + dados.operador)));
            retsch2(Schalter2S_ecflineFeed(1, 7));
         end;
      SCFI:
         begin
            iRetorno :=  SCFI_ecfCancVenda(pchar('Oper:' + dados.operador));
            Analisa_iRetorno();
            Result := (iRetorno=0);
            SCFI_ecflineFeed(1, 7);
         end;
      BematechMP40, BematechMP20, BematechTermica: begin
       iRetorno := Bematech_CancelaCupom;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
       end;
      Elgin: begin
       iRetorno := Elgin_CancelaCupom;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
       end;

      Procomp_2011: LeProComp(Procomp_CancelaCupomFiscal, True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_CancelaCupomFiscal(ultimaresp));
         end;
      AFRAC:
      begin
          iRetorno := AFRAC_CancelarCupom;
          Result := (iRetorno=0);
          Analisa_iRetorno;
      end;

      DarumaMatr, DarumaTerm:
      begin
        iRetorno := Daruma_FI_CancelaCupom;
        Result := (iRetorno=1);
        Analisa_iRetorno;
      end;

   end;
   Result := Result And Retorno_Impressora;

   If Result And Assigned(FAfterCancelaCupomAtual) Then
     FAfterCancelaCupomAtual(Self);

end;

function TDefFPrinter.CancelaCupomAtualSemErro(TemVinculado : Boolean): Boolean;
begin
   Result := false;
   case Impressora of
      None:
      begin
        Result := false;
      end;

      BematechMP40, BematechMP20, BematechTermica:
      begin
        //Tenho que cancelar o cupom vinculado caso use TEF.
        if TemVinculado then
          iRetorno := Bematech_EstornoNaoFiscalVinculadoMFD('', '', '');

        iRetorno := Bematech_CancelaCupom;
        Analisa_iRetorno();
        Result := (iRetorno=1);
      end;

      Elgin:
      begin
        iRetorno := Elgin_CancelaCupom;
        Analisa_iRetorno();
        Result := (iRetorno=1);
      end;

      Sweda03, Sweda10:
      begin
        //Tenho que cancelar o cupom vinculado caso use TEF.
        if TemVinculado then
          iRetorno := Sweda_EstornoNaoFiscalVinculadoMFD('', '', '');

       iRetorno := Sweda_CancelaCupom;
       Analisa_iRetorno();
       Result:= (iRetorno=1);
      end;

      Schalter3D:
      begin
        iRetorno := Schalter3D_CancVenda('');
        //Schalter3D_lineFeed(1, 7);
        Result := (iRetorno=0);
      end;

      SCFI:
      begin
        iRetorno := SCFI_ecfCancVenda('');
        //Schalter3D_lineFeed(1, 7);
        Result:= (iRetorno=0);
      end; 


      AFRAC:
      begin
        iRetorno := AFRAC_CancelarCupom;
        Result := (iRetorno=0);
      end;

      DarumaMatr, DarumaTerm:
      begin
        iRetorno := Daruma_FI_CancelaCupom;
        Result := (iRetorno=1);
      end;
   end;

  Result := Result And Retorno_Impressora;
   
end;


////////////////////////////////////////////////////////////////
function TDefFPrinter.ImprimeChequeI(param, valor, Favorecido, Cidade, data, Banco, ArqLayout, espacamento: string): Boolean;
var
   x: Integer;
   snd, a, b, c: string;
   CmdSwd: array[0..512] of Char;
begin
   Result := false;
   case Impressora of
      None, Urano1FIT: Result := false;
      Dataregis:
         begin
            if (eprom = '02.02') or (eprom[5] = '3') or (eprom[5] = '4') or (eprom = '01.02') then x := 50 else x := 30;
            result := DTR_proc('uA' +
               zcomp(sepdados(param, 1), 2) + zcomp(sepdados(param, 2), 2) + // Linha coluna Valor
               zcomp(sepdados(param, 3), 2) + zcomp(sepdados(param, 4), 2) + // Linha coluna Extenso 1
               zcomp(sepdados(param, 5), 2) + zcomp(sepdados(param, 6), 2) + // Linha coluna Extenso 2
               zcomp(sepdados(param, 7), 2) + zcomp(sepdados(param, 8), 2) + // Linha coluna Favorecido
               zcomp(sepdados(param, 9), 2) + zcomp(sepdados(param, 10), 2) + // Linha coluna cidade e data
               zcomp(tiravg(ptov(valor)), 14) + // Valor do cheque
               copy(Favorecido + space(x), 1, x) + // Favorecido
               copy(Cidade + space(20), 1, 20) + // Cidade
               data); // Data da impressao
            sleep(15000);
         end;
      Sweda03, Sweda10:
         begin
           Result := False;
         end;
      NCR1X: begin
            a := extenso(strtointdef(valor, 0) / 100);
            b := trim(copy(a, 65, 64)) + '****************************************************';
            b := copy(b, 1, 64);
            a := copy(a, 1, 64);
            Result := NCR_Proc(NCRCHQLAY(strtointdef(banco, 0)) + IntToStr(strtointdef(valor, 0)) + '\' + a + '\' + b + '\' + favorecido + '\' + copy(cidade, 1, 17) + '\' + data + '\ ');
         end;
      NCR2x, NCR7141: Result := NCR_Proc(NCRCHQLAY(strtointdef(banco, 0)) + IntToStr(strtointdef(valor, 0)) + '\' + favorecido + '\' + copy(cidade, 1, 17) + '\' + data + '\ ');
      Urano2EFE:
         begin
            valor := IntToStr(strtointdef(valor, 0));
            result := URN_Ret(Urano2EFE_ICheque(PChar(ArqLayout), PChar(valor), PChar(favorecido), PChar(cidade), pchar(data), PChar(banco), strtointdef(espacamento, 0)));
         end;
      Urano1EFC:
         begin
            valor := IntToStr(strtointdef(valor, 0));
            {result := urn_ret3(UranoEFC_ImprimeCheque(
               PChar(ArqLayout),
               PChar(banco),
               PChar(valor),
               PChar(favorecido),
               PChar(cidade),
               PChar(''),
               PChar(data)));}
         end;
      Urano2EFC:
         begin
            valor := IntToStr(strtointdef(valor, 0));
            result := urn_ret3(UranoEFC_ImprimeCheque(
               PChar(ArqLayout),
               PChar(banco),
               PChar(valor),
               PChar(favorecido),
               PChar(cidade),
               PChar('   '),
               PChar(data)));
         end;
      Zanthus2e: //,ZanthusIZ20:
         begin
            //param,valor,Favorecido,Cidade,data,Banco,ArqLayout:string):boolean;
            Zanthus_ConfiguraCheque(PChar(zcomp(banco, 3)));
            x := Zanthus_ImprimeCheque(PChar(tiravg(ptov(valor))), PChar(favorecido), PChar(cidade), PChar(data));
            dados.mensagem := '';
            if x = 0 then Result := true;
            if x = 1 then Dados.mensagem := 'Número do banco inválido.';
            if x = 2 then Dados.mensagem := 'Arquivo de tabela de bancos Não existe.';
            if x = 3 then Dados.mensagem := 'Falha ao abrir arquivo de tabela de bancos.';
            if x = 4 then Dados.mensagem := 'Banco Não cadastrado.';
            if x = 5 then Dados.mensagem := 'Arquivo de tabela de bancos inválido.';
            if x = 6 then Dados.mensagem := 'Falha ao enviar o comando para o ECF.';
            if x = 7 then Dados.mensagem := 'Impressora não pode imprimir cheque.';
            if x > 7 then dados.mensagem := inttostr(x) + ' - Não Documentado';
            if dados.mensagem <> '' then begin
               onError('Impressao de cheque', dados.mensagem);
               Result := false;
            end else Result := true;
         end;
      ZanthusIZ11, ZanthusIZ10, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            //zan_proc('k','00000713175001020010306701050760107074100903028180200000000000000');
            //assignfile(txt,'cheque.cfg');
            //reset(txt);
            //banco:=zcomp(banco,4);
            //while not eof(txt) do begin
            //   readln(txt,linha);
            //   if copy(linha,1,4)=banco then banco:='0000'+copy(linha,5,250);
            //end;
            //closefile(txt);
            zan_proc('k', zcomp(banco, 4)); //zan_proc('k', param);
            zan_proc('l', 'MREAL');
            zan_proc('l', 'NREAIS');
            zan_proc('l', '0' + trim(favorecido));
            zan_proc('l', '1' + trim(Cidade));
            zan_proc('l', '2' + data);
            zan_proc('l', '3' + zcomp(tiramsc(valor), 14));
            Result := zan_proc('m', '');
         end;
      BematechMP40, BematechTermica:
         begin
            bem_proc('58|REAL');
            bem_proc('59|REAIS');
            Result := bem_proc('57|001|' + zcomp(valor, 14) + '|' +
               favorecido + space(45 - Length(favorecido)) + '|' +
               space(27 - Length(Cidade)) + cidade + '|' +
               copy(dados.dataimp, 1, 2) + '|' + copy(nmmes(copy(dados.dataimp, 3, 2)) + space(10), 1, 10) + '|' + copy(dados.dataimp, 5, 2) + '|' +
               #13#10 + '' + #13#10 + '' + #13#10);
         end;
      Elgin:
         begin
            bem_proc('58|REAL');
            bem_proc('59|REAIS');
            Result := bem_proc('57|001|' + zcomp(valor, 14) + '|' +
               favorecido + space(45 - Length(favorecido)) + '|' +
               space(27 - Length(Cidade)) + cidade + '|' +
               copy(dados.dataimp, 1, 2) + '|' + copy(nmmes(copy(dados.dataimp, 3, 2)) + space(10), 1, 10) + '|' + copy(dados.dataimp, 5, 2) + '|' +
               #13#10 + '' + #13#10 + '' + #13#10);
         end;

      Schalter3D: Result := retornoschd(Schalter3D_ChequeDPrint300(strtointdef(banco, 999), PChar(Valor), PChar(Favorecido), PChar(Cidade), PChar(copy(Data, 1, 4) + '20' + copy(data, 5, 2)), '', 'REAL', 'REAIS'));
      Schalter2S, SCFI: Result := true;
   end;
   Result := Result And Retorno_Impressora;
end;
//////////////////////////////////////////////////////////////////
function TDefFPrinter.cancelaItem(Item, posicao: string): Boolean;
var
   a, b, c, d, temp: string;
   pPosicao: PChar;
begin
   posicao := IntToStr(strtointdef(posicao, 0)); // retira Zeros a esquerda, evitando problemas de mascara
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis:
         begin
            if eprom[2] = '9' then begin
               MessageDlg('Esse comando não funciona nesta impressora !!!', mtWarning, [mbOK], 0);
               Result := false;
               exit;
            end;
            result := DTR_proc('b' + zcomp(sepdados(Item, 1), 13) + ' ' + // Codigo 13+1 espaco
               copy(copy(sepdados(Item, 2), 1, 20) + space(22), 1, 22) + //Descricao[22]
               zcomp(IntToStr(strtointdef(COPY(sepdados(Item, 3), 2, 1), 1) - 1), 2) + //Tributacao[2]
               zcomp(tiravg(ptov(sepdados(Item, 4))), 6) + //Quantidade[6]
               zcomp(tiravg(ptov(sepdados(Item, 5))), 9) + //Preco Unitario[9]
               zcomp(tiravg(ptov(sepdados(Item, 6))), 4)); //Desconto[4]
         end;

      Sweda03, Sweda10:
      begin
         iRetorno := Sweda_CancelaItemGenerico(posicao);
         Analisa_iRetorno();
         Result:= (iRetorno=1);
      end;

      NCR2x, NCR1X:
         begin
            str((strtointdef(tiramsc(sepdados(Item, 4)), 0) / 1000) * strtointdef(tiramsc(sepdados(Item, 5)), 0) / 100: 8: 2, temp);
            temp := tiramsc(temp);
            Result := NCR_Proc('22' + zcomp(sepdados(Item, 1), 13) + '\' + // Codigo
               sepdados(item, 2) + '\' + // Descricao
               temp + '\' + // Preco total
               sepdados(Item, 3)); // Tributacao
         end;
      NCR7141:
         begin
            str((strtointdef(tiramsc(sepdados(Item, 4)), 0) / 1000) * strtointdef(tiramsc(sepdados(Item, 5)), 0) / 100: 8: 2, temp);
            temp := tiramsc(temp);
            Result := NCR_Proc('22' + zcomp(sepdados(Item, 1), 13) + '\' + // Codigo
               //sepdados(item, 2) + '\' + // Descricao
               temp + '\' + // Preco total
               sepdados(Item, 3)); // Tributacao
         end;
      Urano2EFE: result := URN_Ret(Urano2EFE_CanItem(PChar(sepdados(Item, 2)), PChar(Posicao)));
      Urano1EFC, Urano2EFC: result := URN_Ret3(UranoEFC_CancelaItem(PChar(sepdados(Item, 2)), PChar(zcomp(Posicao, 3))));
      Urano1FIT: result := URN_Ret2(Urano1FIT_CancelaItem(zcomp(Posicao, 3)));
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            if TabAliq_Zant = '' then if Zan_Proc('P', '000420') then TabAliq_Zant := copy(Ultimaresp, 3, 50);
            d := copy(trim(sepdados(Item, 3)), 1, 1);
            if d <> 'T' then begin
               if d = 'S' then d := 'F';
               b := '        ';
            end else begin
               b := copy(sepdados(Item, 3), 2, 2);
               b := 'T' + copy(TabAliq_Zant, (strtointdef(copy(trim(sepdados(Item, 3)), 2, 2), 0) * 4) - 3, 2) + '.00' + '% ';
            end;
            d := ' ' + d + ' '; // Determina se é tributado, Isento ou Substituicao
            str(strtointdef(tiravg(sepdados(Item, 8)), 0) / 100: 8: 2, c);
            c := ptov(c);
            c := space(7 - length(c)) + c;
            a := zcomp(inttostr(strtointdef(posicao, 0) - 1), 4);
            if impressora = ZanthusIZ11 then begin
               result := zan_proc('d', a + scomp(sepdados(Item, 2), 22) + b + c + d);
            end else begin
               result := zan_proc('d', a + iif(impressora = ZanthusIZ41, '   ', '') + copy(sepdados(Item, 2) + space(24), 1, 24) + b + c + d);
            end;

         end;
      Schalter3D: result := retornoschd(Schalter3D_CancItemDef(pchar(posicao), pchar(sepdados(item, 2))));
      Schalter2S: result := retsch2(Schalter2S_ecfCancItemDef(pchar(posicao), pchar(sepdados(item, 2))));
      SCFI: begin
         iRetorno := SCFI_ecfCancItemDef(pchar(posicao), pchar(sepdados(item, 2)));
         Analisa_iRetorno();
         Result := (iRetorno=0);
         end;
      BematechMP40, BematechMP20, BematechTermica: begin                     // Codigo
         iRetorno := Bematech_CancelaItemGenerico(posicao);
         Analisa_iRetorno();
         Result:= (iRetorno=1);
         end;
      Elgin: begin                     // Codigo
         iRetorno := Elgin_CancelaItemGenerico(posicao);
         Analisa_iRetorno();
         Result:= (iRetorno=1);
         end;
      Procomp_2011: LeProComp(Procomp_CancelamentoItem(copy(Posicao, 3, 4)), True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_CancelamentoItem(zcomp(posicao, 3), ultimaresp));
         end;
      AFRAC:
      begin
        pPosicao := PChar(FormatFloat('000000', StrToInt(Posicao)));
        iRetorno := AFRAC_CancelarItem(pPosicao);
        Result   := iRetorno=0;
        Analisa_iRetorno();
      end;

      DarumaMatr, DarumaTerm:
      begin
        iRetorno := Daruma_FI_CancelaItemGenerico(FormatFloat('00', StrToInt(Posicao)));
        Result   := (iRetorno = 1);
        Analisa_iRetorno();
      end;
   end;

   Result := Result And Retorno_Impressora;

   if Result = true then begin
      ValorCupom := IntToStr(strtointdef(ValorCupom, 0) - (StrtointDef(sepdados(Item, 4), 0) * StrtointDef(sepdados(Item, 5), 0)));
      if assigned(FTotalCupom) then OnTotalCupom(valorCupom);
   end;
end;
/////////////////////////////////////////////////////////////////
function TDefFPrinter.DescontoEmSubtotal(Valor: string): Boolean;
var
   aComando: array[0..0] of Char;
   a, b: string;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis:
         begin
            if eprom[5] = '4' then begin
               dtr_desconto := valor;
               Result := true;
            end else begin
               onError('DESCONTO', 'Operação não permitida neste modelo de ECF');
               dtr_desconto := '';
               result := false;
            end;
         end;
      Sweda03: Result := swd_proc(#27 + '.03   NA SOMA' + zcomp(tiravg(ptov(valor)), 12) + '}');
      Sweda10: Result := swd_proc(#27 + '.03   -----> ' + zcomp(tiravg(ptov(valor)), 12) + 'N}');
      NCR2x, NCR7141, NCR1x: Result := NCR_Proc('13' + Valor);
      Urano2EFE: result := URN_Ret(Urano2EFE_DescSubTotal('0', 'SOBRE O TOTAL DA VENDA', PChar(Valor)));
      Urano1EFC, Urano2EFC: result := URN_Ret3(UranoEFC_DescontoSubTotal('0', ' ', Valor));
      Urano1FIT: result := URN_Ret2(Urano1FIT_DescontoSubTotal(' ', Valor));
      ZanthusIZ11, ZanthusIZ10, zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            str(strtointdef(valor, 0) / 100: 8: 2, b);
            b := ptov(b);
            b := space(8 - length(b)) + b;
            if (impressora = ZanthusIZ10) or (impressora = ZanthusIZ11) then begin
               a := '                   DESCONTO: ';
            end else begin
               a := '                     DESCONTO: ';
            end;
            result := zan_proc('^', iif(impressora = ZanthusIZ41, '   ', '') + a + b + '   ');
         end;
      Schalter3D:
         begin
            retornoschd(Schalter3D_SubTotal());
            Result := retornoschd(Schalter3D_CancAcresDescSubTotal(0, 0, '       DESCONTO', PChar(tiramsc(valor))));
         end;
      Schalter2S:
         begin
            retsch2(Schalter2S_ecfSubTotal());
            Result := retsch2(Schalter2S_ecfCancAcresDescSubTotal(0, 0, '       DESCONTO', PChar(tiramsc(valor))));
         end;
      SCFI:
         begin
            SCFI_ecfSubTotal();
            iRetorno := SCFI_ecfCancAcresDescSubTotal(0, 0, '       DESCONTO', PChar(tiramsc(valor)));
            Result := iRetorno = 0;
         end;
      BematechMP40, BematechMP20, BematechTermica: Result := bem_proc('32|d|' + tiravg(ptov(valor)));
      Elgin: Result := bem_proc('32|d|' + tiravg(ptov(valor)));
      Procomp_2011: LeProComp(Procomp_TotalizarCupom(StrPCopy(aComando, '@'), PChar('&'), PChar(zComp(Valor, 15)), PChar(space(15))), True);
      Trends10E:
         begin
            dtr_desconto := valor;
            Result := true;
         end;
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.AcrescimoEmSubtotal(Valor: string): Boolean;
var
   aComando: array[0..0] of Char;
   a, b: string;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis:
         begin
            if eprom[5] = '4' then begin
               dtr_acrescimo := valor;
               Result := true;
            end else begin
               dtr_acrescimo := '';
               result := true;
            end;
         end;
      Sweda03: Result := swd_proc(#27 + '.11' + // Registro de Acrescimo
            '54' + // Legenda Acrescimo financeiro
            '0000' + // Pencentual
            zcomp(tiravg(ptov(valor)), 11) + // Valor do Acrescimo
            '   ' + // Tributacao para rateio
            'N}'); // Nao subtotalizar
      Sweda10: Result := swd_proc(#27 + '.11' + // Registro de Acrescimo
            '51' + // Legenda Acrescimo financeiro
            '0000' + // Pencentual
            zcomp(tiravg(ptov(valor)), 11) + // Valor do Acrescimo
            'N}'); // Nao subtotalizar
      NCR2x, NCR7141, NCR1X: Result := NCR_Proc('24' + Valor);
      Urano2EFE: Result := URN_Ret(Urano2EFE_AcrescSubTotal('0', 'SOBRE O TOTAL DA VEND', PChar(Valor)));
      Urano1EFC, Urano2EFC: Result := URN_Ret3(UranoEFC_AcrescimoSubTotal('0', ' ', Valor));
      Urano1FIT: Result := URN_Ret2(Urano1FIT_AcrescimoSubTotal(' ', Valor));
      ZanthusIZ11, ZanthusIZ10, zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            str(strtointdef(valor, 0) / 100: 8: 2, b);
            b := ptov(b);
            b := space(8 - length(b)) + b;
            if (impressora = ZanthusIZ10) or (impressora = ZanthusIZ11) then begin
               a := '       ACRESCIMO FINANCEIRO: ';
            end else begin
               a := '         ACRESCIMO FINANCEIRO: ';
            end;
            result := zan_proc('f', iif(impressora = ZanthusIZ41, '   ', '') + a + b + '   ');
         end;
      Schalter3D:
         begin
            retornoschd(Schalter3D_SubTotal());
            Result := retornoschd(Schalter3D_CancAcresDescSubTotal(1, 0, '      ACRESCIMO', PChar(tiramsc(valor))));
         end;
      Schalter2S:
         begin
            retsch2(Schalter2S_ecfSubTotal());
            Result := retsch2(Schalter2S_ecfCancAcresDescSubTotal(1, 0, '      ACRESCIMO', PChar(tiramsc(valor))));
         end;
       SCFI:
         begin
            SCFI_ecfSubTotal();
            iRetorno := SCFI_ecfCancAcresDescSubTotal(1, 0, '      ACRESCIMO', PChar(tiramsc(valor)));
            Result := iRetorno = 0;
         end;
      BematechMP40, BematechMP20, BematechTermica: Result := bem_proc('32|a|' + tiravg(ptov(valor)));
      Elgin: Result := bem_proc('32|a|' + tiravg(ptov(valor)));
      Procomp_2011: LeProComp(Procomp_TotalizarCupom(StrPCopy(aComando, ''), PChar('&'), PChar(zComp(Valor, 15)), PChar(space(15))), True);
      Trends10E:
         begin
            dtr_acrescimo := valor;
            Result := true;
         end;
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.Autentica(Dados: string): Boolean;
var
   CmdSwd: array[0..512] of Char;
begin
   Result := false;
   case Impressora of
      None, Urano1FIT: Result := false;
      Dataregis: result := DTR_Proc('E');

      Sweda03, Sweda10:
      begin
         iRetorno := Sweda_Autenticacao;
         Analisa_iRetorno();
         Result:= (iRetorno=1);
      end;

      NCR1X: Result := NCR_Proc('05' + copy(dados, 1, 10));
      NCR2x: Result := NCR_Proc('05        \' + dados); // 12345678\1-40
      NCR7141: Result := NCR_Proc('05        \' + dados); // 12345678\1-40
      Urano2EFE: result := URN_Ret(Urano2EFE_AutenticaDocumento(PCHAR(copy(dados, 1, 50))));
      Urano1EFC, Urano2EFC: Result := urn_ret3(UranoEFC_Autentica);
      Zanthus2e: begin
            zan_proc('`', '0000000000001');
            zan_proc('a', '0000' + dados);
            Result := zan_proc('b', '');
         end;
      ZanthusIZ11, ZanthusIZ10, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41: Result := zan_proc('n', ']' + Dados);
      Schalter3D: Result := retornoschd(Schalter3D_Autentica(PChar(dados)));
      Schalter2S: Result := retsch2(Schalter2S_ecfAutentica(PChar(dados)));
      SCFI: begin
         iRetorno := SCFI_ecfAutentica(PChar(dados));
         Analisa_iRetorno();
         Result := (iRetorno=0);
         end;
      BematechMP40, BematechMP20, BematechTermica: begin
         iRetorno := Bematech_Autenticacao;
         Analisa_iRetorno();
         Result:= (iRetorno=1);
         end;
      Elgin: begin
         iRetorno := Elgin_Autenticacao;
         Analisa_iRetorno();
         Result:= (iRetorno=1);
         end;
      Procomp_2011: LeProComp(Procomp_ImprimeValidacao(dados, ''), True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Trends_ModoChequeValidacao('0', '0', ultimaresp);
            Result := Trends_ret(Trends_ImprimeValidacao('|   |', #0, ultimaresp));
         end;
   end;
   Result := Result And Retorno_Impressora;
end;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.FechaCupom( FormaPagamento: String; AcrescimoDesconto: String; TipoAcrescimoDesconto: String; ValorAcrescimoDesconto: String; ValorPago: String; Mensagem: String): boolean;
begin
  Result := False;

  case impressora of
    BematechMP20, BematechMP40, BematechTermica :
    begin
       FormaPagamento := Copy(FormaPagamento, 0, 16);
       iRetorno := Bematech_FechaCupom( FormaPagamento,AcrescimoDesconto,TipoAcrescimoDesconto,ValorAcrescimoDesconto,ValorPago,Mensagem);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
    end;

    Sweda03, Sweda10 :
    begin
       FormaPagamento := Copy(FormaPagamento, 0, 15);
       iRetorno := Sweda_FechaCupom( FormaPagamento, AcrescimoDesconto, TipoAcrescimoDesconto, ValorAcrescimoDesconto, ValorPago, Mensagem);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
    end;

    Elgin :
    begin
       FormaPagamento := Copy(FormaPagamento, 0, 16);
       iRetorno := Elgin_FechaCupom( FormaPagamento,AcrescimoDesconto,TipoAcrescimoDesconto,ValorAcrescimoDesconto,ValorPago,Mensagem);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
    end;

  end;
  Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////
function TDefFPrinter.TotalizaCupomMFD: boolean;
begin

  Result := False;

  case impressora of
    BematechMP20, BematechMP40, BematechTermica :
    begin
      iRetorno := Bematech_TotalizaCupomMFD;
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

    Sweda03, Sweda10 :
    begin
      iRetorno := Sweda_TotalizaCupomMFD;
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

    Elgin :
    begin
      iRetorno := Elgin_TotalizaCupomMFD;
      Analisa_iRetorno();
      Result:= (iRetorno=1);
    end;

  end;

  Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.FechaCupomResumido( FormaPagamento: String; Mensagem: String ): boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
         FormaPagamento := Copy(FormaPagamento, 0, 16);
         iRetorno := Bematech_FechaCupomResumido(FormaPagamento,Mensagem);
         Analisa_iRetorno();
         Result:= (iRetorno=1);
     end;

     Elgin :
     begin
       FormaPagamento := Copy(FormaPagamento, 0, 16);
       iRetorno := Elgin_FechaCupomResumido(FormaPagamento,Mensagem);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10 :
     begin
       FormaPagamento := Copy(FormaPagamento, 0, 15);
       iRetorno := Sweda_FechaCupomResumido(FormaPagamento, Mensagem);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.EspacoEntreLinhas( Dots: Integer ): boolean;
begin
   Result := False;
    if (impressora=BematechMP20) or (impressora=BematechMP40) or (impressora=BematechTermica) then
       begin
       iRetorno := Bematech_EspacoEntreLinhas(dots);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
       end;
    if (impressora=Elgin) then
       begin
       iRetorno := Elgin_EspacoEntreLinhas(dots);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
       end;
    Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.AutenticacaoMFD(Linhas, Texto : string) : boolean;
begin
   Result := False;

   case impressora of

     BematechMP20, BematechMP40, BematechTermica:
     begin
       iRetorno := Bematech_AutenticacaoMFD(Linhas, Texto);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Elgin:
     begin
       iRetorno := Elgin_AutenticacaoMFD(Linhas, Texto);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
       iRetorno := Sweda_AutenticacaoMFD(Linhas, Texto);
       Analisa_iRetorno();
       Result:= (iRetorno=1);
     end;

   end;

   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.LeituraMemoriaFiscalData(datainicial, datafinal: string): boolean;
begin
   Result := false;
   case Impressora of
      Dataregis: result := DTR_proc('IN' + datainicial + datafinal);
      NCR2x, NCR7141, NCR1x: Result := NCR_Proc('67' + datainicial + '\' + datafinal);

      BematechMP40, BematechMP20, BematechTermica:
         begin
            //Result := bem_proc('|8|' + datainicial + '|' + datafinal + '|I|');
            iRetorno := Bematech_LeituraMemoriaFiscalData(datainicial, datafinal);
            Analisa_iRetorno();
            Result:= (iRetorno=1);
         end;
      Elgin:
         begin
            //Result := bem_proc('|8|' + datainicial + '|' + datafinal + '|I|');
            iRetorno := Elgin_LeituraMemoriaFiscalData(pchar(datainicial), pchar(datafinal));
            Analisa_iRetorno();
            Result:= (iRetorno=1);
         end;
      Schalter3D:
         begin
            Result := retornoschd(Schalter3D_LeitMemFisc(1, LPSTR(datainicial), LPSTR(datafinal), 1, 10, 'memSch.txt'));
            retornoschd(Schalter3D_LineFeed(1, 9));
         end;
      Sweda10, Sweda03:
        begin
            iRetorno := Sweda_LeituraMemoriaFiscalData(datainicial, datafinal);
            Analisa_iRetorno();
            Result:= (iRetorno=1);
        end;
      Schalter2S:
         begin
            Result := retsch2(Schalter2S_ecfLeitMemFisc(1, LPSTR(datainicial), LPSTR(datafinal), 1, 1, 'memSch.Text'));
            Schalter2S_ecfLineFeed(1, 7);
         end;
      SCFI:
         begin
            iRetorno := SCFI_ecfLeitMemFisc(1, LPSTR(datainicial), LPSTR(datafinal), 1, 1, 'memSch.Text');
            Result := iRetorno = 0;
            SCFI_ecfLineFeed(1, 7);
         end;
      Procomp_2011: LeProComp(Procomp_LeMemFiscalData(datainicial, datafinal, '0'), True);
      Urano2EFE: Result := Urano2EFE_LeituraMF('0', datainicial, datafinal, '0', '0') = 0;
      Urano1EFC, Urano2EFC: Result := UranoEFC_LeituraMF('0', datainicial, datafinal, '0', '0') = 0;
      Urano1FIT:
         begin
            Result := URN_Ret2(Urano1FIT_LeituraMF('0', datainicial, datafinal, '1', ''));
            Urano1FIT_AvancaLinhas('06');
         end;
      ZanthusIZ11, ZanthusIZ10, zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            Result := zan_proc('G', DataInicial + DataFinal + '0');
            zan_proc('6', '');
         end;
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_LeMemFiscalData(datainicial, datafinal, '0', ultimaresp));
         end;
      DarumaMatr, DarumaTerm:
         begin
            iRetorno := Daruma_FI_LeituraMemoriaFiscalData(pchar(datainicial), pchar(datafinal));
            Analisa_iRetorno();
            Result := (iRetorno=1);
         end;
   end;
   Result := Result And Retorno_Impressora;
end;
function TDefFPrinter.LeituraMemoriaFiscalDataMFD(datainicial, datafinal, FlagLeitura : string): boolean;
begin
   Result := false;
   case Impressora of
      Dataregis: result := DTR_proc('IN' + datainicial + datafinal);
      NCR2x, NCR7141, NCR1x: Result := NCR_Proc('67' + datainicial + '\' + datafinal);

      BematechMP40, BematechMP20, BematechTermica:
         begin
            //Result := bem_proc('|8|' + datainicial + '|' + datafinal + '|I|');
            iRetorno := Bematech_LeituraMemoriaFiscalDataMFD(datainicial, datafinal, FlagLeitura);
            Analisa_iRetorno();
            Result:= (iRetorno=1);
         end;
      Elgin:
         begin
            //Result := bem_proc('|8|' + datainicial + '|' + datafinal + '|I|');
            iRetorno := Elgin_LeituraMemoriaFiscalDataMFD(pchar(datainicial), pchar(datafinal), pchar(FlagLeitura));
            Analisa_iRetorno();
            Result:= (iRetorno=1);
         end;
      Schalter3D:
         begin
            Result := retornoschd(Schalter3D_LeitMemFisc(1, LPSTR(datainicial), LPSTR(datafinal), 1, 10, 'memSch.txt'));
            retornoschd(Schalter3D_LineFeed(1, 9));
         end;
      Sweda10, Sweda03:
         begin
            iRetorno := Sweda_LeituraMemoriaFiscalDataMFD(datainicial, datafinal, FlagLeitura);
            Analisa_iRetorno();
            Result:= (iRetorno=1);
         end;
      Schalter2S:
         begin
            Result := retsch2(Schalter2S_ecfLeitMemFisc(1, LPSTR(datainicial), LPSTR(datafinal), 1, 1, 'memSch.Text'));
            Schalter2S_ecfLineFeed(1, 7);
         end;
      SCFI:
         begin
            iRetorno := SCFI_ecfLeitMemFisc(1, LPSTR(datainicial), LPSTR(datafinal), 1, 1, 'memSch.Text');
            Result := iRetorno = 0;
            SCFI_ecfLineFeed(1, 7);
         end;
      Procomp_2011: LeProComp(Procomp_LeMemFiscalData(datainicial, datafinal, '0'), True);
      Urano2EFE: Result := Urano2EFE_LeituraMF('0', datainicial, datafinal, '0', '0') = 0;
      Urano1EFC, Urano2EFC: Result := UranoEFC_LeituraMF('0', datainicial, datafinal, '0', '0') = 0;
      Urano1FIT:
         begin
            Result := URN_Ret2(Urano1FIT_LeituraMF('0', datainicial, datafinal, '1', ''));
            Urano1FIT_AvancaLinhas('06');
         end;
      ZanthusIZ11, ZanthusIZ10, zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            Result := zan_proc('G', DataInicial + DataFinal + '0');
            zan_proc('6', '');
         end;
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_LeMemFiscalData(datainicial, datafinal, '0', ultimaresp));
         end;
      DarumaMatr, DarumaTerm:
         begin
            iRetorno := Daruma_FI_LeituraMemoriaFiscalData(pchar(datainicial), pchar(datafinal));
            Analisa_iRetorno();
            Result := (iRetorno=1);
         end;
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.LeituraMemoriaFiscalReducao(reducaoinicial, reducaofinal: string): boolean;
begin
   Result := false;
   case Impressora of
      Dataregis: result := DTR_proc('iN' + zcomp(reducaoinicial, 4) + zcomp(reducaofinal, 4));
      NCR2x, NCR7141, NCR1x: Result := NCR_Proc('66' + reducaoinicial + '\' + reducaofinal);
      BematechMP40, BematechMP20, BematechTermica:
        begin
          //Result := bem_proc('|08|00|' + reducaoinicial + '|00|' + reducaofinal + '|I|');
          iRetorno := Bematech_LeituraMemoriaFiscalReducao(reducaoinicial, reducaofinal);
          Analisa_iRetorno();
          Result:= (iRetorno=1);
        end;
      Elgin:
        begin
          //Result := bem_proc('|08|00|' + reducaoinicial + '|00|' + reducaofinal + '|I|');
          iRetorno := Elgin_LeituraMemoriaFiscalReducao(pchar(reducaoinicial), pchar(reducaofinal));
          Analisa_iRetorno();
          Result:= (iRetorno=1);
        end;
      Schalter3D:
         begin
            Result := retornoschd(Schalter3D_LeitMemFisc(2, LPSTR('010101'), LPSTR('100101'), StrToInt(reducaoinicial), StrToInt(reducaofinal), 'memSch.txt'));
            retornoschd(Schalter3D_LineFeed(1, 9));
         end;
      Sweda10, Sweda03:
        begin
          iRetorno := Sweda_LeituraMemoriaFiscalReducao(reducaoinicial, reducaofinal);
          Analisa_iRetorno();
          Result:= (iRetorno=1);
        end;

      Schalter2S:
         begin
            Result := retsch2(Schalter2S_ecfLeitMemFisc(2, LPSTR('010101'), LPSTR('010101'), StrToInt(reducaoinicial), StrToInt(reducaofinal), 'memSch.Text'));
            Schalter2S_ecfLineFeed(1, 7);
         end;
      SCFI:
         begin
            iRetorno := SCFI_ecfLeitMemFisc(2, LPSTR('010101'), LPSTR('010101'), StrToInt(reducaoinicial), StrToInt(reducaofinal), 'memSch.Text');
            Result := iRetorno = 0;
            SCFI_ecfLineFeed(1, 7);
         end;
      Procomp_2011: LeProComp(Procomp_LeMemFiscalReducao(PChar(reducaoinicial), PChar(reducaofinal), '1'), True);
      Urano2EFE: Result := Urano2EFE_LeituraMF('1', '0', '0', reducaoinicial, reducaofinal) = 0;
      Urano1EFC, Urano2EFC: Result := UranoEFC_LeituraMF('1', '0', '0', reducaoinicial, reducaofinal) = 0;
      Urano1FIT:
         begin
            Result := URN_Ret2(Urano1FIT_LeituraMF('1', reducaoinicial, reducaofinal, '1', ''));
            Urano1FIT_AvancaLinhas('06');
         end;
      ZanthusIZ11, ZanthusIZ10, zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            Result := zan_proc('H', ReducaoInicial + ReducaoFinal + '0');
            zan_proc('6', '');
            zan_proc('6', '');
         end;
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_LeMemFiscalReducao(reducaoinicial, reducaofinal, '0', ultimaresp));
         end;
      DarumaMatr, DarumaTerm:
         begin
            iRetorno := Daruma_FI_LeituraMemoriaFiscalReducao(pchar(reducaoinicial), pchar(reducaofinal));
            Analisa_iRetorno();
            Result := (iRetorno=1);
         end;
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.LeituraMemoriaFiscalReducaoMFD(ReducaoInicial, ReducaoFinal, FlagLeitura : string): boolean;
begin
   Result := false;
   case Impressora of
      Dataregis: result := DTR_proc('iN' + zcomp(reducaoinicial, 4) + zcomp(reducaofinal, 4));
      NCR2x, NCR7141, NCR1x: Result := NCR_Proc('66' + reducaoinicial + '\' + reducaofinal);
      BematechMP40, BematechMP20, BematechTermica: begin
        iRetorno := Bematech_LeituraMemoriaFiscalReducaoMFD(ReducaoInicial, ReducaoFinal, FlagLeitura );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
        end;

      Elgin: begin
        iRetorno := Elgin_LeituraMemoriaFiscalReducaoMFD(ReducaoInicial, ReducaoFinal, FlagLeitura );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
        end;

      Schalter3D:
         begin
            Result := retornoschd(Schalter3D_LeitMemFisc(2, LPSTR('010101'), LPSTR('100101'), StrToInt(reducaoinicial), StrToInt(reducaofinal), 'memSch.txt'));
            retornoschd(Schalter3D_LineFeed(1, 9));
         end;
      Sweda10, Sweda03:
      begin
        iRetorno := Sweda_LeituraMemoriaFiscalReducaoMFD(ReducaoInicial, ReducaoFinal, FlagLeitura );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
      end;

      Schalter2S:
         begin
            Result := retsch2(Schalter2S_ecfLeitMemFisc(2, LPSTR('010101'), LPSTR('010101'), StrToInt(reducaoinicial), StrToInt(reducaofinal), 'memSch.Text'));
            Schalter2S_ecfLineFeed(1, 7);
         end;
      SCFI:
         begin
            iRetorno := SCFI_ecfLeitMemFisc(2, LPSTR('010101'), LPSTR('010101'), StrToInt(reducaoinicial), StrToInt(reducaofinal), 'memSch.Text');
            Analisa_iRetorno();
            Result := (iRetorno=0);
            SCFI_ecfLineFeed(1, 7);
         end;
      Procomp_2011: LeProComp(Procomp_LeMemFiscalReducao(PChar(reducaoinicial), PChar(reducaofinal), '1'), True);
      Urano2EFE: Result := Urano2EFE_LeituraMF('1', '0', '0', reducaoinicial, reducaofinal) = 0;
      Urano1EFC, Urano2EFC: Result := UranoEFC_LeituraMF('1', '0', '0', reducaoinicial, reducaofinal) = 0;
      Urano1FIT:
         begin
            Result := URN_Ret2(Urano1FIT_LeituraMF('1', reducaoinicial, reducaofinal, '1', ''));
            Urano1FIT_AvancaLinhas('06');
         end;
      ZanthusIZ11, ZanthusIZ10, zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            Result := zan_proc('H', ReducaoInicial + ReducaoFinal + '0');
            zan_proc('6', '');
            zan_proc('6', '');
         end;
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_LeMemFiscalReducao(reducaoinicial, reducaofinal, '0', ultimaresp));
         end;

      DarumaMatr, DarumaTerm:
         begin
            iRetorno := Daruma_FI_LeituraMemoriaFiscalReducao(pchar(reducaoinicial), pchar(reducaofinal));
            Analisa_iRetorno();
            Result := (iRetorno=1);
         end;
   end;
   Result := Result And Retorno_Impressora;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.LeituraMemoriaFiscalSerialReducaoMFD(ReducaoInicial, ReducaoFinal, FlagLeitura : string): boolean;
begin
   Result := false;
   case Impressora of
      Dataregis: result := DTR_proc('iN' + zcomp(reducaoinicial, 4) + zcomp(reducaofinal, 4));
      NCR2x, NCR7141, NCR1x: Result := NCR_Proc('66' + reducaoinicial + '\' + reducaofinal);
      BematechMP40, BematechMP20, BematechTermica: begin
        iRetorno := Bematech_LeituraMemoriaFiscalSerialReducaoMFD(ReducaoInicial, ReducaoFinal, FlagLeitura );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
      end;

      Elgin: begin
        iRetorno := Elgin_LeituraMemoriaFiscalSerialReducaoMFD(ReducaoInicial, ReducaoFinal, FlagLeitura );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
      end;

      Schalter3D:
         begin
            Result := retornoschd(Schalter3D_LeitMemFisc(2, LPSTR('010101'), LPSTR('100101'), StrToInt(reducaoinicial), StrToInt(reducaofinal), 'memSch.txt'));
            retornoschd(Schalter3D_LineFeed(1, 9));
         end;
      Sweda10, Sweda03:
      begin
        iRetorno := Sweda_LeituraMemoriaFiscalSerialReducaoMFD(ReducaoInicial, ReducaoFinal, FlagLeitura );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
      end;

      Schalter2S:
         begin
            Result := retsch2(Schalter2S_ecfLeitMemFisc(2, LPSTR('010101'), LPSTR('010101'), StrToInt(reducaoinicial), StrToInt(reducaofinal), 'memSch.Text'));
            Schalter2S_ecfLineFeed(1, 7);
         end;
      SCFI:
         begin
            iRetorno := SCFI_ecfLeitMemFisc(2, LPSTR('010101'), LPSTR('010101'), StrToInt(reducaoinicial), StrToInt(reducaofinal), 'memSch.Text');
            Analisa_iRetorno();
            Result := (iRetorno=0);
            SCFI_ecfLineFeed(1, 7);
         end;
      Procomp_2011: LeProComp(Procomp_LeMemFiscalReducao(PChar(reducaoinicial), PChar(reducaofinal), '1'), True);
      Urano2EFE: Result := Urano2EFE_LeituraMF('1', '0', '0', reducaoinicial, reducaofinal) = 0;
      Urano1EFC, Urano2EFC: Result := UranoEFC_LeituraMF('1', '0', '0', reducaoinicial, reducaofinal) = 0;
      Urano1FIT:
         begin
            Result := URN_Ret2(Urano1FIT_LeituraMF('1', reducaoinicial, reducaofinal, '1', ''));
            Urano1FIT_AvancaLinhas('06');
         end;
      ZanthusIZ11, ZanthusIZ10, zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            Result := zan_proc('H', ReducaoInicial + ReducaoFinal + '0');
            zan_proc('6', '');
            zan_proc('6', '');
         end;
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_LeMemFiscalReducao(reducaoinicial, reducaofinal, '0', ultimaresp));
         end;
      DarumaMatr, DarumaTerm:
         begin
            iRetorno := Daruma_FI_LeituraMemoriaFiscalSerialReducao(pchar(reducaoinicial), pchar(reducaofinal));
            Analisa_iRetorno();
            Result := (iRetorno=1);
         end;
   end;
   Result := Result And Retorno_Impressora;

   if Result then
     Application.MessageBox( 'RETORNO.TXT criado com sucesso !', 'Atenção', MB_IconInformation + MB_OK );
end;
////////////////////////////////////////////
function TDefFPrinter.LeituraMemoriaFiscalSerialDataMFD(ReducaoInicial, ReducaoFinal, FlagLeitura : string): boolean;
begin
   Result := false;
   case Impressora of
      Dataregis: result := DTR_proc('iN' + zcomp(reducaoinicial, 4) + zcomp(reducaofinal, 4));
      NCR2x, NCR7141, NCR1x: Result := NCR_Proc('66' + reducaoinicial + '\' + reducaofinal);
      BematechMP40, BematechMP20, BematechTermica: begin
        iRetorno := Bematech_LeituraMemoriaFiscalSerialDataMFD(ReducaoInicial, ReducaoFinal, FlagLeitura );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
      end;

      Elgin: begin
        iRetorno := Elgin_LeituraMemoriaFiscalSerialDataMFD(ReducaoInicial, ReducaoFinal, FlagLeitura );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
      end;

      Schalter3D:
         begin
            Result := retornoschd(Schalter3D_LeitMemFisc(2, LPSTR('010101'), LPSTR('100101'), StrToInt(reducaoinicial), StrToInt(reducaofinal), 'memSch.txt'));
            retornoschd(Schalter3D_LineFeed(1, 9));
         end;
      Sweda10, Sweda03:
      begin
        iRetorno := Sweda_LeituraMemoriaFiscalSerialDataMFD(ReducaoInicial, ReducaoFinal, FlagLeitura );
        Analisa_iRetorno();
        Result:= (iRetorno=1);
      end;
      Schalter2S:
         begin
            Result := retsch2(Schalter2S_ecfLeitMemFisc(2, LPSTR('010101'), LPSTR('010101'), StrToInt(reducaoinicial), StrToInt(reducaofinal), 'memSch.Text'));
            Schalter2S_ecfLineFeed(1, 7);
         end;
      SCFI:
         begin
            iRetorno := SCFI_ecfLeitMemFisc(2, LPSTR('010101'), LPSTR('010101'), StrToInt(reducaoinicial), StrToInt(reducaofinal), 'memSch.Text');
            Analisa_iRetorno();
            Result := (iRetorno=0);
            SCFI_ecfLineFeed(1, 7);
         end;
      Procomp_2011: LeProComp(Procomp_LeMemFiscalReducao(PChar(reducaoinicial), PChar(reducaofinal), '1'), True);
      Urano2EFE: Result := Urano2EFE_LeituraMF('1', '0', '0', reducaoinicial, reducaofinal) = 0;
      Urano1EFC, Urano2EFC: Result := UranoEFC_LeituraMF('1', '0', '0', reducaoinicial, reducaofinal) = 0;
      Urano1FIT:
         begin
            Result := URN_Ret2(Urano1FIT_LeituraMF('1', reducaoinicial, reducaofinal, '1', ''));
            Urano1FIT_AvancaLinhas('06');
         end;
      ZanthusIZ11, ZanthusIZ10, zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            Result := zan_proc('H', ReducaoInicial + ReducaoFinal + '0');
            zan_proc('6', '');
            zan_proc('6', '');
         end;
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_LeMemFiscalReducao(reducaoinicial, reducaofinal, '0', ultimaresp));
         end;

      DarumaMatr, DarumaTerm:
         begin
            iRetorno := Daruma_FI_LeituraMemoriaFiscalSerialData(pchar(reducaoinicial), pchar(reducaofinal));
            Analisa_iRetorno();
            Result := (iRetorno=1);
         end;


   end;
   Result := Result And Retorno_Impressora;

   if Result then
     Application.MessageBox('RETORNO.TXT criado com sucesso !', 'Atenção', MB_IconInformation + MB_OK );
end;
////////////////////////////////////////////

function TDefFPrinter.Modelos: string;
begin
   Result :=
      'Sweda03' + '|' +
      'Sweda10' + '|' +
      'Dataregis' + '|' +
      'NCR1x' + '|' +
      'NCR2x' + '|' +
      'NCR7141' + '|' +
      'Urano2EFE' + '|' +
      'Urano1EFC' + '|' +
      'Urano2EFC' + '|' +
      'Urano1FIT' + '|' +
      'Zanthus2e' + '|' +
      'ZanthusIZ10' + '|' +
      'ZanthusIZ11' + '|' +
      'ZanthusIZ20' + '|' +
      'ZanthusIZ21' + '|' +
      'ZanthusIZ41' + '|' +
      'Schalter2S' + '|' +
      'Schalter3D' + '|' +
      'BematechMP20' + '|' +
      'BematechMP40' + '|' +
      'Procomp_2011' + '|' +
      'Trends10E' + '|' +
      'Elgin' + '|' +
      'Schalter_SCFI' + '|';
end;
/////////////////////////////////////////////////////////////////////////////////////////////
procedure TDefFPrinter.ProgModalidades(FormaPagamento: String; ValorFormaPagamento: String; Indice: String);
var
  Vinculado : TBooleano;
  pDescricao: array[0..30] of char;
  pValor: TPontoFlutuante;
  pIndice : array[0..2] of char;
  pMensagem : array[0..80] of char;
begin
   case impressora of
      NCR2x, NCR7141:
         begin
            ncr_proc('88' + 'DINHEIRO\' +
               'CHEQUE\' +
               'CHEQUE-PRE\' +
               'TICKET\' +
               'CARTAO\' +
               'VALE\' +
               'CONVENIO\' +
               'CONTRA-VALE\' +
               'CREDIARIO\' +
               'BONUS\ \ \ \ \ ');
         end;
      sweda03: swd_proc(#27 + '.39Dinheiro       Cheque         Cheque-Pre     Ticket         Cartao         Vale           Convenio       Contra-Vale    Crediario      Bonus          }');
      sweda10:
         begin
            swd_proc(#27 + '.39Dinheiro       Cheque         Cheque-Pre     Ticket         Cartao         Vale           Convenio       Contra-Vale    Crediario      Bonus          }');
            swd_proc(#27 + '.47+&RECEBIMENTOS  }');
         end;
      Schalter3D:
         begin
            //
            retornoschd(Schalter3D_ProgNFComprov('00', 'GENERICO', 'N', 'N', 'N', 'N', 'S', '99'));
            //
            //retornoschd(ecfProgNFComprov('00', 'CV CHEQUE', 'N', 'N', 'N', 'N', 'S', '01'));
            //retornoschd(ecfProgNFComprov('01', 'CV CHEQUE PRE', 'N', 'N', 'N', 'N', 'S', '02'));
            //retornoschd(ecfProgNFComprov('02', 'CV TICKET', 'N', 'N', 'N', 'N', 'S', '03'));
            //retornoschd(ecfProgNFComprov('03', 'CV CARTAO', 'N', 'N', 'N', 'N', 'S', '04'));
            //retornoschd(ecfProgNFComprov('04', 'CV VALE', 'N', 'N', 'N', 'N', 'S', '05'));
            //retornoschd(ecfProgNFComprov('05', 'CV CONVENIO', 'N', 'N', 'N', 'N', 'S', '06'));
            //retornoschd(ecfProgNFComprov('06', 'CV CONTRA-VALE', 'N', 'N', 'N', 'N', 'S', '07'));
            //retornoschd(ecfProgNFComprov('07', 'CREDIARIO', 'N', 'N', 'N', 'N', 'S', '08'));
            //retornoschd(ecfProgNFComprov('11', 'TERMO DE COMPROMISSO', 'N', 'N', 'N', 'N', 'S', '06'));
            //retornoschd(ecfProgNFComprov('06', 'RELATORIOS', 'N', 'N', 'N', 'N', 'N', '00'));
             //
            retornoschd(Schalter3D_PayPatterns('01', 'DINHEIRO'));
            retornoschd(Schalter3D_PayPatterns('02', 'CHEQUE'));
            retornoschd(Schalter3D_PayPatterns('03', 'CHEQUE-PRE'));
            retornoschd(Schalter3D_PayPatterns('04', 'TICKET'));
            retornoschd(Schalter3D_PayPatterns('05', 'CARTAO'));
            retornoschd(Schalter3D_PayPatterns('06', 'VALE'));
            retornoschd(Schalter3D_PayPatterns('07', 'CONVENIO'));
            retornoschd(Schalter3D_PayPatterns('08', 'CONTRA-VALE'));
            retornoschd(Schalter3D_PayPatterns('09', 'CREDIARIO'));
            retornoschd(Schalter3D_PayPatterns('10', 'BONUS'));
         end;
      ZanthusIZ11, ZanthusIZ10, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
            zan_proc('W', 'P01DINHEIRO');
            zan_proc('W', 'P02CHEQUE');
            zan_proc('W', 'P03CHEQUE-PRE');
            zan_proc('W', 'P04TICKET');
            zan_proc('W', 'P05CARTAO');
            zan_proc('W', 'P06VALE');
            zan_proc('W', 'P07CONVENIO');
            zan_proc('W', 'P08CONTRA-VALE');
            zan_proc('W', 'P09RETIRADA');
            zan_proc('W', 'P10CP-CREDITO');
            zan_proc('W', 'P11DUPLICATA');
            zan_proc('W', 'P12CREDIARIO');
            zan_proc('W', 'P13OUTROS');
            zan_proc('W', 'P14BONUS');
         end;
      Urano2EFE:
         begin
            Urano2EFE_NomeMoeda('REAL', 'REAIS');
         end;
      Urano1FIT:
         begin
            urn_ret2(Urano1FIT_formaPagamento('01', 'DINHEIRO'));
            urn_ret2(Urano1FIT_formaPagamento('02', 'CHEQUE'));
            urn_ret2(Urano1FIT_formaPagamento('03', 'CHEQUE-PRE'));
            urn_ret2(Urano1FIT_formaPagamento('04', 'TICKET'));
            urn_ret2(Urano1FIT_formaPagamento('05', 'CARTAO'));
            urn_ret2(Urano1FIT_formaPagamento('06', 'VALE'));
            urn_ret2(Urano1FIT_formaPagamento('07', 'CONVENIO'));
            urn_ret2(Urano1FIT_formaPagamento('08', 'CONTRA-VALE'));
            urn_ret2(Urano1FIT_formaPagamento('09', 'CREDIARIO'));
            urn_ret2(Urano1FIT_formaPagamento('10', 'BONUS'));
         end;
      Urano1EFC, Urano2EFC:
         begin
            urn_ret3(UranoEFC_NomeMoeda('REAL', 'REAIS'));
            urn_ret3(UranoEFC_formaPagamento('01', 'DINHEIRO'));
            urn_ret3(UranoEFC_formaPagamento('02', 'CHEQUE'));
            urn_ret3(UranoEFC_formaPagamento('03', 'CHEQUE-PRE'));
            urn_ret3(UranoEFC_formaPagamento('04', 'TICKET'));
            urn_ret3(UranoEFC_formaPagamento('05', 'CARTAO'));
            urn_ret3(UranoEFC_formaPagamento('06', 'VALE'));
            urn_ret3(UranoEFC_formaPagamento('07', 'CONVENIO'));
            urn_ret3(UranoEFC_formaPagamento('08', 'CONTRA-VALE'));
            urn_ret3(UranoEFC_formaPagamento('09', 'CREDIARIO'));
            UranoEFC_formaPagamento('10', 'BONUS');
            urn_ret3(UranoEFC_CargaNaoVinculado('00', 'RECEBIMENTO'));
            urn_ret3(UranoEFC_CargaNaoVinculado('01', 'DOC.VINCULADO'));
         end;
      BematechMP40, BematechMP20, BematechTermica:
         begin
            FormaPagamento := Copy(FormaPagamento, 0, 16);
            Bematech_EfetuaFormaPagamento( FormaPagamento, ValorFormaPagamento );
         end;
      Elgin:
         begin
            FormaPagamento := Copy(FormaPagamento, 0, 16);
            Elgin_EfetuaFormaPagamento( FormaPagamento, ValorFormaPagamento );
         end;
      AFRAC:
      begin
        Vinculado := _AFRAC_BooleanToTBooleano(True);
        {AFRAC_ProgramarFormasDePagamento('01', 'DINHEIRO', Vinculado);
        AFRAC_ProgramarFormasDePagamento('02', 'CHEQUE', Vinculado);
        AFRAC_ProgramarFormasDePagamento('03', 'CHEQUE-PRE', Vinculado);
        AFRAC_ProgramarFormasDePagamento('04', 'TICKET', Vinculado);
        AFRAC_ProgramarFormasDePagamento('05', 'CARTAO', Vinculado);
        AFRAC_ProgramarFormasDePagamento('06', 'VALE', Vinculado);
        AFRAC_ProgramarFormasDePagamento('07', 'CONVENIO', Vinculado);
        AFRAC_ProgramarFormasDePagamento('08', 'CONTRA-VALE', Vinculado);
        AFRAC_ProgramarFormasDePagamento('09', 'CREDIARIO', Vinculado);
        AFRAC_ProgramarFormasDePagamento('10', 'BONUS', Vinculado);
        AFRAC_ProgramarFormasDePagamento('13', 'CARTAO TEF                    ', '1');}
      end;

      SCFI:
      begin
            retornoschd(SCFI_ecfProgNFComprov('00', 'GENERICO', 'N', 'N', 'N', 'N', 'S', '99'));
            retornoschd(SCFI_ecfPayPatterns('01', 'DINHEIRO'));
            retornoschd(SCFI_ecfPayPatterns('02', 'CHEQUE'));
            retornoschd(SCFI_ecfPayPatterns('03', 'CHEQUE-PRE'));
            retornoschd(SCFI_ecfPayPatterns('04', 'TICKET'));
            retornoschd(SCFI_ecfPayPatterns('05', 'CARTAO'));
            retornoschd(SCFI_ecfPayPatterns('06', 'VALE'));
            retornoschd(SCFI_ecfPayPatterns('07', 'CONVENIO'));
            retornoschd(SCFI_ecfPayPatterns('08', 'CONTRA-VALE'));
            retornoschd(SCFI_ecfPayPatterns('09', 'CREDIARIO'));
            retornoschd(SCFI_ecfPayPatterns('10', 'BONUS'));
      end;
   end;
end;
////////////////////////////////////////////
function TDefFPrinter.urn_esp(Liga: string): boolean;
begin
   Result := false;
   case Impressora of
      Urano2EFE: if Liga = 'S' then Result := urn_ret(Urano2EFE_EspacamentoLinhas(1)) else Result := urn_ret(Urano2EFE_EspacamentoLinhas(0));
      Urano1FIT: if Liga = 'S' then Result := urn_ret2(Urano1FIT_EspacamentoLinhas(1)) else Result := urn_ret2(Urano1FIT_EspacamentoLinhas(0));
   end;
end;
////////////////////////////////////////////
function TDefFPrinter.urn_naofisc(codigo, desc, valor, nome, codcli, cpf: string): boolean;
begin
   Result := false;
   case Impressora of
      Urano1EFC, Urano2EFC:
         begin
            Result := urn_ret3(UranoEFC_EmiteNaoVinculado(PChar(codigo), PChar(desc), PChar(tiramsc(valor))));
            if CODCli <> '00000000000000' then begin
               urn_ret3(UranoEFC_pagamento('07', '  ', tiramsc(valor), '0'));
               urn_ret3(UranoEFC_IdComprador(nome, iif(Length(tiramsc(cpf)) = 11, '0', '1'), cpf, 'RECONHECO  E  PAGAREI  -------------------',
                  'A DIVIDA APRENSENTADA.      ASSINATURA    '));
            end else urn_ret3(UranoEFC_pagamento('01', '  ', tiramsc(valor), '0'));
            urn_ret3(UranoEFC_FechaCupom(dados.operador));
            sleep(2000);
            UranoEFC_AvancaLinhas('6');
         end;
   end;
end;
////////////////////////////////////////////
function TDefFPrinter.swd_naofisc(codigo, desc, valor, nome, codcli, cpf: string): boolean;
var
   CmdSwd: array[0..512] of Char;
   Resposta: string;
begin
   Result := false;
   case Impressora of
      Sweda10:
         begin
            swd_proc(#27 + '.1901');
            swd_proc(#27 + '.0702' + zcomp(tiramsc(valor), 12) + copy(desc + space(40), 1, 40));
            if trim(rodape.linha1) <> '' then swd_proc(#27 + '.080' + copy(rodape.Linha1 + space(40), 1, 40));
            if trim(rodape.linha2) <> '' then swd_proc(#27 + '.080' + copy(rodape.Linha2 + space(40), 1, 40));
            if trim(rodape.linha3) <> '' then swd_proc(#27 + '.080' + copy(rodape.Linha3 + space(40), 1, 40));
            if trim(rodape.linha4) <> '' then swd_proc(#27 + '.080' + copy(rodape.Linha4 + space(40), 1, 40));
            if trim(rodape.linha5) <> '' then swd_proc(#27 + '.080' + copy(rodape.Linha5 + space(40), 1, 40));
            result := swd_proc(#27 + '.12}');

            //StrPCopy(Cmdswd, #27 + '.12}');
            //Resposta := EnviaComando(CmdSwd);
         end;
   end;
end;
////////////////////////////////////////////
function TDefFPrinter.urn_log(Liga: string): boolean;
begin
   Result := false;
   case Impressora of
      Urano1FIT: if Liga = 'S' then Result := urn_ret2(Urano1FIT_LogSerial('1')) else Result := urn_ret2(Urano1FIT_LogSerial('0'));
   end;
end;
////////////////////////////////////////////
function TDefFPrinter.bem_refsan(sanref, valor: string): boolean;
begin
   Result := Bem_proc('25|' + sanref + '|' + zcomp(tiravg(ptov(valor)), 14));
end;
////////////////////////////////////////////
function TDefFPrinter.VeriDelphi: boolean;
var
   H2, H3, H4: HWND;
const
   A1: array[0..12] of char = 'TApplication'#0;
   A2: array[0..15] of char = 'TAlignPalette'#0;
   A3: array[0..18] of char = 'TPropertyInspector'#0;
   A4: array[0..11] of char = 'TAppBuilder'#0;
   //T1 : array[0..10] of char = 'Delphi 3.0'#0;
begin
   //H1:=FindWindow(A1, T1);
   H2 := FindWindow(A2, nil);
   H3 := FindWindow(A3, nil);
   H4 := FindWindow(A4, nil);
   //Result:=(H1<>0) and (H2<>0) and (H3<>0) and (H4<>0);
   Result := (H2 <> 0) and (H3 <> 0) and (H4 <> 0);
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.IntToHex(numero: integer): string;
const
   hex: array[0..15] of char = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
begin
   while numero <> 0 do begin
      result := hex[15 and numero] + result; {=(n mod 15)}
      numero := numero shr 4;
   end; {=n div 16}
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.HextoInt(HexStr: string): integer;
const
   Hex: array['A'..'F'] of integer = (10, 11, 12, 13, 14, 15);
var
   i: integer;
begin
   Result := 0;
   for i := 1 to Length(HexStr) do
      if HexStr[i] < 'A' then Result := Result * 16 + Ord(HexStr[i]) - 48 else Result := Result * 16 + Hex[HexStr[i]];
end;
////////////////////////////////////////////
function TDefFPrinter.inttobin(data: Integer): string;
var
   res: string;
begin
   res := '';
   while data > 0 do begin
      res := inttostr(data mod 2) + res;
      data := data div 2;
   end;
   Result := res;
end;
////////////////////////////////////////////
function TDefFPrinter.bintoint(data: string): Integer;
var
   x: integer;
   res: Integer;
begin
   res := 0;
   for x := 1 to length(data) do res := res + (strtoint(data[length(data) - (x - 1)]) * round(intpower(2, (x - 1))));
   result := res;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.Versao: string;
begin
   Result := 'EFiscal 1.0';
end;
/////////////////////////////////////////////////
procedure TDefFPrinter.timeDelay(msecs: Longint); // Atrasa a execucao em Milisegundos
var
   FirstTick: longint;
begin
   if msecs = 0 then exit;
   FirstTick := GetTickCount;
   repeat
      Application.ProcessMessages;
   until (ABS(GetTickCount) - FirstTick) >= msecs;
end;
////////////////////////////////////////////
function TDefFPrinter.BiosInfo: string;
var
   a, b, c, d, e, f: string;
begin
   a := string(Pchar(Ptr($FEC71))); //Número serial da MotherBoard
   b := string(Pchar(Ptr($FE061))); //Modelo da BIOS
   c := string(Pchar(Ptr($FE091))); //Fabricante
   d := string(Pchar(Ptr($FFFF5))); //Data Fabricação
   with TRegistry.create do begin
      try
         RootKey := HKEY_LOCAL_MACHINE;
         LazyWrite := false;
         OpenKey('Enum\Root\*PNP0C01\0000', False);
         e := ReadString('BusType');
         f := ReadString('MachineType');
         CloseKey;
      finally
         Free;
      end;
   end;
   Result := a + '\' + b + '\' + c + '\' + d + '\' + e + '\' + f;
end;
////////////////////////////////////////////
function TDefFPrinter.CPUMHz: string;
var
   t: DWORD;
   mhi, mlo, nhi, nlo: DWORD;
   t0, t1, chi, clo, shr32: Comp;
begin
   shr32 := 65536;
   shr32 := shr32 * 65536;
   t := GetTickCount;
   while t = GetTickCount do ;
   asm
      DB 0FH
      DB 031H
      mov mhi,edx
      mov mlo,eax
   end;
   while GetTickCount < (t + 1000) do ;
   asm
      DB 0FH
      DB 031H
      mov nhi,edx
      mov nlo,eax
   end;
   chi := mhi;
   //if mhi < 0 then chi := chi + shr32;  -- Comentado pq um DWORD nunca vai ser menor que zero !!! :-p
   clo := mlo;
   //if mlo < 0 then clo := clo + shr32;  -- Comentado pq um DWORD nunca vai ser menor que zero !!! :-p
   t0 := chi * shr32 + clo;
   chi := nhi;
   //if nhi < 0 then chi := chi + shr32;  -- Comentado pq um DWORD nunca vai ser menor que zero !!! :-p
   clo := nlo;
   //if nlo < 0 then clo := clo + shr32;  -- Comentado pq um DWORD nunca vai ser menor que zero !!! :-p
   t1 := chi * shr32 + clo;
   result := formatfloat('#####0.0', (t1 - t0) / 1E6);
end;
///////////////////////////////////////////////////////
function TDefFPrinter.VerificaEAN(CodEan: string): boolean;
var
   soma, i, calculo: integer;
begin
   result := false;
   if (CodEan <> '000000000000') then begin
      CodEan := zcomp(CodEan, 13);
      calculo := 3;
      soma := 0;
      for i := 0 to 11 do begin
         soma := soma + (StrToIntdef(CodEan[12 - i], 0) * calculo);
         if calculo = 3 then calculo := 1 else calculo := 3;
      end;
      if (soma mod 10) > 0 then soma := (((soma div 10) + 1) * 10) - soma else soma := 0;
      Result := CodEan[13] = IntToStr(soma);
   end;
end;
////////////////////////////////////////////////
function TDefFPrinter.Crypto(const Str1: string): string;
var
   Mascara, Str2: string;
   PonM, PonS: Byte;
begin
   Mascara := 'LKJSDFKLASJFIOWEFNAKSDFNLAKJDFLS'; //'#$%$'#13#12; {Esta string e' o segredo da criptografia}
   Str2 := '';
   PonM := 1;
   for PonS := 1 to length(Str1) do begin
      //AppendStr(Str2, Chr(Ord(Str1[PonS]) xor Ord(Mascara[PonM]))); -- Função depreciada
      Str2 := Str2 + (Chr(Ord(Str1[PonS]) xor Ord(Mascara[PonM])));
      Inc(PonM);
      if PonM > Length(Mascara) then PonM := 1;
   end;
   Result := Str2;
end;
////////////////////////////////////////////
function TDefFPrinter.CarregaECF: boolean;
begin
   case impressora of
      Sweda03, Sweda10:
         begin
            NomeDll := 'CONVECF.dll';
            HandleDLL := LoadLibrary(PChar(NomeDll));
            if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
            Result := true;
            // Funções de Comunicação  ---------------------------------------------------------------------------------------------------------------
            @Sweda_AbrePortaSerial := GetProcAddress(HandleDLL, 'ECF_AbrePortaSerial');
            @Sweda_FechaPortaSerial := GetProcAddress(HandleDLL, 'ECF_FechaPortaSerial');
            @Sweda_MsgLog := GetProcAddress(HandleDLL, 'ECF_MsgLog');
            //Funções de Início de Dia
            @Sweda_AberturaDoDia := GetProcAddress(HandleDLL, 'ECF_AberturaDoDia');
            //Funções de Status ---------------------------------------------------------------------------------------------------------------
            @Sweda_RetornoImpressoraMFD := GetProcAddress(HandleDLL, 'ECF_RetornoImpressoraMFD');
            @Sweda_RetornaTipoEcf := GetProcAddress(HandleDLL, 'ECF_RetornaTipoEcf');
            @Sweda_VersaoDll := GetProcAddress(HandleDLL, 'ECF_VersaoDll');
            @Sweda_VersaoFirmware := GetProcAddress(HandleDLL, 'ECF_VersaoFirmware');
            @Sweda_VersaoFirmwareMFD := GetProcAddress(HandleDLL, 'ECF_VersaoFirmwareMFD');
            @Sweda_NumeroSerie := GetProcAddress(HandleDLL, 'ECF_NumeroSerie');
            @Sweda_NumeroSerieMFD := GetProcAddress(HandleDLL, 'ECF_NumeroSerieMFD');
            @Sweda_NumeroSerieMemoriaMFD := GetProcAddress(HandleDLL, 'ECF_NumeroSerieMemoriaMFD');
            @Sweda_Registry_AplMensagem1 := GetProcAddress(HandleDLL, 'ECF_Registry_AplMensagem1');
            @Sweda_Registry_AplMensagem2 := GetProcAddress(HandleDLL, 'ECF_Registry_AplMensagem2');
            @Sweda_VerificaFormasPagamentoMFD := GetProcAddress(HandleDLL, 'ECF_VerificaFormasPagamentoMFD');
            @Sweda_MarcaModeloTipoImpressoraMFD := GetProcAddress(HandleDLL, 'ECF_MarcaModeloTipoImpressoraMFD');
            @Sweda_DataHoraGravacaoUsuarioSWBasicoMFAdicional := GetProcAddress(HandleDLL, 'ECF_DataHoraGravacaoUsuarioSWBasicoMFAdicional');
            @Sweda_CGC_IE := GetProcAddress(HandleDLL, 'ECF_CGC_IE');
            @Sweda_CNPJMFD := GetProcAddress(HandleDLL, 'ECF_CNPJMFD');
            @Sweda_InscricaoEstadualMFD := GetProcAddress(HandleDLL, 'ECF_InscricaoEstadualMFD');
            @Sweda_InscricaoMunicipalMFD := GetProcAddress(HandleDLL, 'ECF_InscricaoMunicipalMFD');
            @Sweda_NumeroSubstituicoesProprietario := GetProcAddress(HandleDLL, 'ECF_NumeroSubstituicoesProprietario');
            @Sweda_SimboloMoeda := GetProcAddress(HandleDLL, 'ECF_SimboloMoeda');
            @Sweda_ClicheProprietario := GetProcAddress(HandleDLL, 'ECF_ClicheProprietario');
            @Sweda_NumeroLoja := GetProcAddress(HandleDLL, 'ECF_NumeroLoja');
            @Sweda_NumeroCaixa := GetProcAddress(HandleDLL, 'ECF_NumeroCaixa');
            @Sweda_DataHoraImpressora := GetProcAddress(HandleDLL, 'ECF_DataHoraImpressora');
            @Sweda_LerAliquotasComIndice := GetProcAddress(HandleDLL, 'ECF_LerAliquotasComIndice');
            @Sweda_VerificaTotalizadoresNaoFiscaisMFD := GetProcAddress(HandleDLL, 'ECF_VerificaTotalizadoresNaoFiscaisMFD');
            @Sweda_VerificaModoOperacao := GetProcAddress(HandleDLL, 'ECF_VerificaModoOperacao');
            @Sweda_VerificaImpressoraLigada := GetProcAddress(HandleDLL, 'ECF_VerificaImpressoraLigada');
            @Sweda_VerificaDescricaoFormasPagamento := GetProcAddress(HandleDLL, 'ECF_VerificaDescricaoFormasPagamento');
            @Sweda_VerificaTotalizadoresNaoFiscaisEx := GetProcAddress(HandleDLL, 'ECF_VerificaTotalizadoresNaoFiscaisEx');
            @Sweda_VerificaRelatorioGerencialProgMFD := GetProcAddress(HandleDLL, 'ECF_VerificaRelatorioGerencialProgMFD');
            @Sweda_CasasDecimaisProgramada := GetProcAddress(HandleDLL, 'ECF_CasasDecimaisProgramada');
            @Sweda_VerificaTruncamento := GetProcAddress(HandleDLL, 'ECF_VerificaTruncamento');
            @Sweda_VerificaEstadoImpressoraMFD := GetProcAddress(HandleDLL, 'ECF_VerificaEstadoImpressoraMFD');
            @Sweda_VerificaTotalizadoresParciais := GetProcAddress(HandleDLL, 'ECF_VerificaTotalizadoresParciais');
            @Sweda_RetornoAliquotas := GetProcAddress(HandleDLL, 'ECF_RetornoAliquotas');
            @Sweda_ImprimeCopiaCheque := GetProcAddress(HandleDLL, 'ECF_ImprimeCopiaCheque');
            @Sweda_CancelaImpressaoCheque := GetProcAddress(HandleDLL, 'ECF_CancelaImpressaoCheque');
            // Funções de Leituras Fiscais  ---------------------------------------------------------------------------------------------------------------
            @Sweda_LeituraX := GetProcAddress(HandleDLL, 'ECF_LeituraX');
            @Sweda_LeituraMemoriaFiscalData := GetProcAddress(HandleDLL, 'ECF_LeituraMemoriaFiscalData');
            @Sweda_LeituraMemoriaFiscalDataMFD := GetProcAddress(HandleDLL, 'ECF_LeituraMemoriaFiscalDataMFD');
            @Sweda_LeituraMemoriaFiscalReducao := GetProcAddress(HandleDLL, 'ECF_LeituraMemoriaFiscalReducao');
            @Sweda_LeituraMemoriaFiscalReducaoMFD := GetProcAddress(HandleDLL, 'ECF_LeituraMemoriaFiscalReducaoMFD');
            // Funções do Cupom Fiscal  ---------------------------------------------------------------------------------------------------------------
            @Sweda_AbreCupom := GetProcAddress(HandleDLL, 'ECF_AbreCupom');
            @Sweda_AbreCupomMFD := GetProcAddress(HandleDLL, 'ECF_AbreCupomMFD');
            @Sweda_IdentificaConsumidor := GetProcAddress(HandleDLL, 'ECF_IdentificaConsumidor');
            @Sweda_AumentaDescricaoItem := GetProcAddress(HandleDLL, 'ECF_AumentaDescricaoItem');
            @Sweda_UsaUnidadeMedida := GetProcAddress(HandleDLL, 'ECF_UsaUnidadeMedida');
            @Sweda_VendeItem := GetProcAddress(HandleDLL, 'ECF_VendeItem');
            @Sweda_VendeItemTresDecimais := GetProcAddress(HandleDLL, 'ECF_VendeItemTresDecimais');
            @Sweda_VendeItemDepartamento := GetProcAddress(HandleDLL, 'ECF_VendeItemDepartamento');
            @Sweda_DescontoSobreItemVendido := GetProcAddress(HandleDLL, 'ECF_DescontoSobreItemVendido');
            @Sweda_AcrescimoDescontoItemMFD := GetProcAddress(HandleDLL, 'ECF_AcrescimoDescontoItemMFD');
            @Sweda_CancelaItemAnterior := GetProcAddress(HandleDLL, 'ECF_CancelaItemAnterior');
            @Sweda_CancelaItemGenerico := GetProcAddress(HandleDLL, 'ECF_CancelaItemGenerico');
            @Sweda_CancelaAcrescimoDescontoItemMFD := GetProcAddress(HandleDLL, 'ECF_CancelaAcrescimoDescontoItemMFD');
            @Sweda_IniciaFechamentoCupom := GetProcAddress(HandleDLL, 'ECF_IniciaFechamentoCupom');
            @Sweda_IniciaFechamentoCupomMFD := GetProcAddress(HandleDLL, 'ECF_IniciaFechamentoCupomMFD');
            @Sweda_AcrescimoDescontoSubtotalMFD := GetProcAddress(HandleDLL, 'ECF_AcrescimoDescontoSubtotalMFD');
            @Sweda_TotalizaCupomMFD := GetProcAddress(HandleDLL, 'ECF_TotalizaCupomMFD');
            @Sweda_EfetuaFormaPagamento := GetProcAddress(HandleDLL, 'ECF_EfetuaFormaPagamento');
            @Sweda_EfetuaFormaPagamentoDescricaoForma := GetProcAddress(HandleDLL, 'ECF_EfetuaFormaPagamentoDescricaoForma');
            @Sweda_EfetuaFormaPagamentoMFD := GetProcAddress(HandleDLL, 'ECF_EfetuaFormaPagamentoMFD');
            @Sweda_TerminaFechamentoCupom := GetProcAddress(HandleDLL, 'ECF_TerminaFechamentoCupom');
            @Sweda_FechaCupom := GetProcAddress(HandleDLL, 'ECF_FechaCupom');
            @Sweda_FechaCupomResumido := GetProcAddress(HandleDLL, 'ECF_FechaCupomResumido');
            @Sweda_AtivaDesativaCorteProximoMFD := GetProcAddress(HandleDLL, 'ECF_AtivaDesativaCorteProximoMFD');
            @Sweda_CupomAdicionalMFD := GetProcAddress(HandleDLL, 'ECF_CupomAdicionalMFD');
            @Sweda_ProgramaArredondamento := GetProcAddress(HandleDLL, 'ECF_ProgramaArredondamento');
            @Sweda_ProgramaTruncamento := GetProcAddress(HandleDLL, 'ECF_ProgramaTruncamento');
            @Sweda_EstornoFormasPagamento := GetProcAddress(HandleDLL, 'ECF_EstornoFormasPagamento');
            // Funções de Cancelamento  ---------------------------------------------------------------------------------------------------------------
            @Sweda_CancelaCupom := GetProcAddress(HandleDLL, 'ECF_CancelaCupom');
            @Sweda_CancelaCupomMFD := GetProcAddress(HandleDLL, 'ECF_CancelaCupomMFD');
            @Sweda_CancelaAcrescimoDescontoSubtotalMFD := GetProcAddress(HandleDLL, 'ECF_CancelaAcrescimoDescontoSubtotalMFD');

            // Funções de COmprovante Crédito e Débito (TEF) ---------------------------------------------------------------------------------------------------------------
            @Sweda_IniciaModoTEF := GetProcAddress(HandleDLL, 'ECF_IniciaModoTEF');
            @Sweda_FinalizaModoTEF := GetProcAddress(HandleDLL, 'ECF_FinalizaModoTEF');
            @Sweda_AbreComprovanteNaoFiscalVinculado := GetProcAddress(HandleDLL, 'ECF_AbreComprovanteNaoFiscalVinculado');
            @Sweda_AbreComprovanteNaoFiscalVinculadoMFD := GetProcAddress(HandleDLL, 'ECF_AbreComprovanteNaoFiscalVinculadoMFD');
            @Sweda_UsaComprovanteNaoFiscalVinculadoTEF := GetProcAddress(HandleDLL, 'ECF_UsaComprovanteNaoFiscalVinculadoTEF');
            @Sweda_UsaComprovanteNaoFiscalVinculado := GetProcAddress(HandleDLL, 'ECF_UsaComprovanteNaoFiscalVinculado');
            @Sweda_FechaComprovanteNaoFiscalVinculado := GetProcAddress(HandleDLL, 'ECF_FechaComprovanteNaoFiscalVinculado');
            @Sweda_SegundaViaNaoFiscalVinculadoMFD := GetProcAddress(HandleDLL, 'ECF_SegundaViaNaoFiscalVinculadoMFD');
            @Sweda_ReimpressaoNaoFiscalVinculadoMFD := GetProcAddress(HandleDLL, 'ECF_ReimpressaoNaoFiscalVinculadoMFD');
            @Sweda_EstornoNaoFiscalVinculadoMFD := GetProcAddress(HandleDLL, 'ECF_EstornoNaoFiscalVinculadoMFD');
            @Sweda_TEF_ImprimirRespostaCartao := GetProcAddress(HandleDLL, 'ECF_TEF_ImprimirRespostaCartao');
            @Sweda_TEF_FechaRelatorio := GetProcAddress(HandleDLL, 'ECF_TEF_FechaRelatorio');
            @Sweda_RelatorioGerencialTEF := GetProcAddress(HandleDLL, 'ECF_RelatorioGerencialTEF');
            @Sweda_UsaRelatorioGerencialMFDTEF := GetProcAddress(HandleDLL, 'ECF_UsaRelatorioGerencialMFDTEF');
            // Funções de Comprovantes  ---------------------------------------------------------------------------------------------------------------
            @Sweda_Suprimento := GetProcAddress(HandleDLL, 'ECF_Suprimento');
            @Sweda_Sangria := GetProcAddress(HandleDLL, 'ECF_Sangria');
            @Sweda_AbreRecebimentoNaoFiscalMFD := GetProcAddress(HandleDLL, 'ECF_AbreRecebimentoNaoFiscalMFD');
            @Sweda_AbreRecebimentoNaoFiscal := GetProcAddress(HandleDLL, 'ECF_AbreRecebimentoNaoFiscal');
            @Sweda_RecebimentoNaoFiscal := GetProcAddress(HandleDLL, 'ECF_RecebimentoNaoFiscal');
            @Sweda_EfetuaRecebimentoNaoFiscalMFD := GetProcAddress(HandleDLL, 'ECF_EfetuaRecebimentoNaoFiscalMFD');
            @Sweda_CancelaItemNaoFiscalMFD := GetProcAddress(HandleDLL, 'ECF_CancelaItemNaoFiscalMFD');
            @Sweda_AcrescimoItemNaoFiscalMFD := GetProcAddress(HandleDLL, 'ECF_AcrescimoItemNaoFiscalMFD');
            @Sweda_AcrescimoDescontoSubtotalRecebimentoMFD := GetProcAddress(HandleDLL, 'ECF_AcrescimoDescontoSubtotalRecebimentoMFD');
            @Sweda_TotalizaRecebimentoMFD := GetProcAddress(HandleDLL, 'ECF_TotalizaRecebimentoMFD');
            @Sweda_IniciaFechamentoRecebimentoNaoFiscalMFD := GetProcAddress(HandleDLL, 'ECF_IniciaFechamentoRecebimentoNaoFiscalMFD');
            @Sweda_FechaRecebimentoNaoFiscalMFD := GetProcAddress(HandleDLL, 'ECF_FechaRecebimentoNaoFiscalMFD');
            @Sweda_CancelaRecebimentoNaoFiscalMFD := GetProcAddress(HandleDLL, 'ECF_CancelaRecebimentoNaoFiscalMFD');
            @Sweda_EfetuaFormaPagamentoNaoFiscal := GetProcAddress(HandleDLL, 'ECF_EfetuaFormaPagamentoNaoFiscal');
            // Funções de Relatório Gerencial  ---------------------------------------------------------------------------------------------------------------
            @Sweda_AbreRelatorioGerencial := GetProcAddress(HandleDLL, 'ECF_AbreRelatorioGerencial');
            @Sweda_AbreRelatorioGerencialMFD := GetProcAddress(HandleDLL, 'ECF_AbreRelatorioGerencialMFD');
            @Sweda_EnviarTextoCNF := GetProcAddress(HandleDLL, 'ECF_EnviarTextoCNF');
            @Sweda_RelatorioGerencial := GetProcAddress(HandleDLL, 'ECF_RelatorioGerencial');
            @Sweda_UsaRelatorioGerencialMFD := GetProcAddress(HandleDLL, 'ECF_UsaRelatorioGerencialMFD');
            @Sweda_FechaRelatorioGerencial := GetProcAddress(HandleDLL, 'ECF_FechaRelatorioGerencial');
            // Funções de Fechamento do dia ---------------------------------------------------------------------------------------------------------------
            @Sweda_FechamentoDoDia := GetProcAddress(HandleDLL, 'ECF_FechamentoDoDia');
            @Sweda_ReducaoZ := GetProcAddress(HandleDLL, 'ECF_ReducaoZ');
            // Funções de Autenticações ---------------------------------------------------------------------------------------------------------------
            @Sweda_Autenticacao := GetProcAddress(HandleDLL, 'ECF_Autenticacao');
            @Sweda_AutenticacaoMFD := GetProcAddress(HandleDLL, 'ECF_AutenticacaoMFD');
            @Sweda_AutenticacaoStr := GetProcAddress(HandleDLL, 'ECF_AutenticacaoStr');
            @Sweda_VerificaDocAutenticacao := GetProcAddress(HandleDLL, 'ECF_VerificaDocAutenticacao');
            // Funções de Gaveta ---------------------------------------------------------------------------------------------------------------
            @Sweda_AcionaGaveta := GetProcAddress(HandleDLL, 'ECF_AcionaGaveta');
            @Sweda_VerificaEstadoGaveta := GetProcAddress(HandleDLL, 'ECF_VerificaEstadoGaveta');
            @Sweda_VerificaEstadoGavetaStr := GetProcAddress(HandleDLL, 'ECF_VerificaEstadoGavetaStr');
            //Funções de Cheque ---------------------------------------------------------------------------------------------------------------
            @Sweda_ProgramaMoedaSingular := GetProcAddress(HandleDLL, 'ECF_ProgramaMoedaSingular');
            @Sweda_ProgramaMoedaPlural := GetProcAddress(HandleDLL, 'ECF_ProgramaMoedaPlural');
            @Sweda_IncluiCidadeFavorecido := GetProcAddress(HandleDLL, 'ECF_IncluiCidadeFavorecido');
            @Sweda_VerificaStatusCheque := GetProcAddress(HandleDLL, 'ECF_VerificaStatusCheque');
            @Sweda_VerificaStatusChequeStr := GetProcAddress(HandleDLL, 'ECF_VerificaStatusChequeStr');
            @Sweda_ImprimeCheque := GetProcAddress(HandleDLL, 'ECF_ImprimeCheque');
            @Sweda_ImprimeChequeMFD := GetProcAddress(HandleDLL, 'ECF_ImprimeChequeMFD');
            @Sweda_LeituraChequeMFD := GetProcAddress(HandleDLL, 'ECF_LeituraChequeMFD');
            @Sweda_LeituraLeiautesCheques := GetProcAddress(HandleDLL, 'ECF_LeituraLeiautesCheques');
            //Funções de Status Ultima Transacao ---------------------------------------------------------------------------------------------------------------
            @Sweda_TipoUltimoDocumento := GetProcAddress(HandleDLL, 'ECF_TipoUltimoDocumento');
            @Sweda_SubTotal := GetProcAddress(HandleDLL, 'ECF_SubTotal');
            @Sweda_SubTotalComprovanteNaoFiscalMFD := GetProcAddress(HandleDLL, 'ECF_SubTotalComprovanteNaoFiscalMFD');
            @Sweda_ValorPagoUltimoCupom := GetProcAddress(HandleDLL, 'ECF_ValorPagoUltimoCupom');
            @Sweda_NumeroCupom := GetProcAddress(HandleDLL, 'ECF_NumeroCupom');
            @Sweda_VerificaFormasPagamento := GetProcAddress(HandleDLL, 'ECF_VerificaFormasPagamento');
            @Sweda_TotaisVenda := GetProcAddress(HandleDLL, 'ECF_TotaisVenda');
            @Sweda_ValorAcrescimosUltimoCupom := GetProcAddress(HandleDLL, 'ECF_ValorAcrescimosUltimoCupom');
            @Sweda_ValorDescontosUltimoCupom := GetProcAddress(HandleDLL, 'ECF_ValorDescontosUltimoCupom');
            @Sweda_ValorCancelamentosUltimoCupom := GetProcAddress(HandleDLL, 'ECF_ValorCancelamentosUltimoCupom');
            @Sweda_ValorCancelamentosUltimoCupomISS := GetProcAddress(HandleDLL, 'ECF_ValorCancelamentosUltimoCupomISS');
            //Funções de Status Acumuladores Diários ---------------------------------------------------------------------------------------------------------------
            @Sweda_Acrescimos := GetProcAddress(HandleDLL, 'ECF_Acrescimos');
            @Sweda_Descontos := GetProcAddress(HandleDLL, 'ECF_Descontos');
            @Sweda_VerificaRecebimentoNaoFiscal := GetProcAddress(HandleDLL, 'ECF_VerificaRecebimentoNaoFiscal');
            @Sweda_VerificaRecebimentoNaoFiscalMFD := GetProcAddress(HandleDLL, 'ECF_VerificaRecebimentoNaoFiscalMFD');
            @Sweda_Cancelamentos := GetProcAddress(HandleDLL, 'ECF_Cancelamentos');
            @Sweda_GrandeTotal := GetProcAddress(HandleDLL, 'ECF_GrandeTotal');
            @Sweda_VendaBruta := GetProcAddress(HandleDLL, 'ECF_VendaBruta');
            @Sweda_RetornaAcrescimoNF := GetProcAddress(HandleDLL, 'ECF_RetornaAcrescimoNF');
            @Sweda_RetornaDescontoNF:= GetProcAddress(HandleDLL, 'ECF_RetornaDescontoNF');
            @Sweda_RetornaCancelamentoNF := GetProcAddress(HandleDLL, 'ECF_RetornaCancelamentoNF');
            @Sweda_RetornaTroco := GetProcAddress(HandleDLL, 'ECF_RetornaTroco');
            //Funções de Status Contadores  ---------------------------------------------------------------------------------------------------------------
            @Sweda_NumeroIntervencoes := GetProcAddress(HandleDLL, 'ECF_NumeroIntervencoes');
            @Sweda_ContadorCupomFiscalMFD := GetProcAddress(HandleDLL, 'ECF_ContadorCupomFiscalMFD');
            @Sweda_NumeroCuponsCancelados := GetProcAddress(HandleDLL, 'ECF_NumeroCuponsCancelados');
            @Sweda_NumeroOperacoesNaoFiscais := GetProcAddress(HandleDLL, 'ECF_NumeroOperacoesNaoFiscais');
            @Sweda_ContadorComprovantesCreditoMFD := GetProcAddress(HandleDLL, 'ECF_ContadorComprovantesCreditoMFD');
            @Sweda_ComprovantesNaoFiscaisNaoEmitidosMFD := GetProcAddress(HandleDLL, 'ECF_ComprovantesNaoFiscaisNaoEmitidosMFD');
            @Sweda_ContadorOperacoesNaoFiscaisCanceladasMFD := GetProcAddress(HandleDLL, 'ECF_ContadorOperacoesNaoFiscaisCanceladasMFD');
            @Sweda_ContadorFitaDetalheMFD := GetProcAddress(HandleDLL, 'ECF_ContadorFitaDetalheMFD');
            @Sweda_ContadorRelatoriosGerenciaisMFD := GetProcAddress(HandleDLL, 'ECF_ContadorRelatoriosGerenciaisMFD');
            @Sweda_NumeroReducoes := GetProcAddress(HandleDLL, 'ECF_NumeroReducoes');
            @Sweda_RetornaCOO := GetProcAddress(HandleDLL, 'ECF_RetornaCOO');
            @Sweda_COO := GetProcAddress(HandleDLL, 'ECF_COO');
            //Funções de Status do ECF  ---------------------------------------------------------------------------------------------------------------
            @Sweda_FlagsFiscais := GetProcAddress(HandleDLL, 'ECF_FlagsFiscais');
            @Sweda_VerificaEstadoImpressora := GetProcAddress(HandleDLL, 'ECF_VerificaEstadoImpressora');
            @Sweda_RetornoImpressora := GetProcAddress(HandleDLL, 'ECF_RetornoImpressora');
            @Sweda_VerificaTipoImpressora := GetProcAddress(HandleDLL, 'ECF_VerificaTipoImpressora');
            @Sweda_VerificaIndiceAliquotasIss := GetProcAddress(HandleDLL, 'ECF_VerificaIndiceAliquotasIss');
            @Sweda_StatusEstendidoMFD := GetProcAddress(HandleDLL, 'ECF_StatusEstendidoMFD');
            @Sweda_StatusCupomFiscal := GetProcAddress(HandleDLL, 'ECF_StatusCupomFiscal');
            @Sweda_StatusRelatorioGerencial := GetProcAddress(HandleDLL, 'ECF_StatusRelatorioGerencial');
            @Sweda_StatusComprovanteNaoFiscalVinculado := GetProcAddress(HandleDLL, 'ECF_StatusComprovanteNaoFiscalVinculado');
            @Sweda_StatusComprovanteNaoFiscalNaoVinculado := GetProcAddress(HandleDLL, 'ECF_StatusComprovanteNaoFiscalNaoVinculado');
            @Sweda_VerificaModeloEcf := GetProcAddress(HandleDLL, 'ECF_VerificaModeloEcf');
            @Sweda_VerificaHorarioVerao := GetProcAddress(HandleDLL, 'ECF_VerificaHorarioVerao');
            @Sweda_VerificaZPendente := GetProcAddress(HandleDLL, 'ECF_VerificaZPendente');
            @Sweda_VerificaDiaAberto := GetProcAddress(HandleDLL, 'ECF_VerificaDiaAberto');
            @Sweda_VerificaFlagCorteMFD := GetProcAddress(HandleDLL, 'ECF_VerificaFlagCorteMFD');
            @Sweda_GeraRFD := GetProcAddress(HandleDLL, 'ECF_GeraRFD');
            // Funções Status Diversos---------------------------------------------------------------------
            @Sweda_PercentualLivreMFD := GetProcAddress(HandleDLL, 'ECF_PercentualLivreMFD');
            @Sweda_TotalLivreMFD := GetProcAddress(HandleDLL, 'ECF_TotalLivreMFD');
            @Sweda_ReducoesRestantesMFD := GetProcAddress(HandleDLL, 'ECF_ReducoesRestantesMFD');
            @Sweda_TamanhoTotalMFD := GetProcAddress(HandleDLL, 'ECF_TamanhoTotalMFD');
            @Sweda_TempoRestanteComprovanteMFD := GetProcAddress(HandleDLL, 'ECF_TempoRestanteComprovanteMFD');
            @Sweda_DataMovimento := GetProcAddress(HandleDLL, 'ECF_DataMovimento');
            // Status de Valores após a Redução Z ---------------------------------------------------------------
            @Sweda_DataHoraUltimoDocumentoMFD := GetProcAddress(HandleDLL, 'ECF_DataHoraUltimoDocumentoMFD');
            @Sweda_DataHoraReducao := GetProcAddress(HandleDLL, 'ECF_DataHoraReducao');
            @Sweda_DataMovimentoUltimaReducaoMFD := GetProcAddress(HandleDLL, 'ECF_DataMovimentoUltimaReducaoMFD');
            @Sweda_InicioFimCOOsMFD := GetProcAddress(HandleDLL, 'ECF_InicioFimCOOsMFD');
            @Sweda_InicioFimGTsMFD := GetProcAddress(HandleDLL, 'ECF_InicioFimGTsMFD');
            @Sweda_GrandeTotalUltimaReducaoMFD := GetProcAddress(HandleDLL, 'ECF_GrandeTotalUltimaReducaoMFD');
            @Sweda_DadosUltimaReducaoMFD := GetProcAddress(HandleDLL, 'ECF_DadosUltimaReducaoMFD');
            @Sweda_MapaResumoMFD := GetProcAddress(HandleDLL, 'ECF_MapaResumoMFD');
            // Funções SINTEGRA ---------------------------------------------------------------------
            @Sweda_ArquivoSintegra2004MFD := GetProcAddress(HandleDLL, 'ECF_ArquivoSintegra2004MFD');
            @Sweda_RelatorioSintegraMFD := GetProcAddress(HandleDLL, 'ECF_RelatorioSintegraMFD');
            @Sweda_RegistrosTipo60 := GetProcAddress(HandleDLL, 'ECF_RegistrosTipo60');
            @Sweda_RelatorioTipo60Mestre := GetProcAddress(HandleDLL, 'ECF_RelatorioTipo60Mestre');
            @Sweda_RelatorioTipo60Analitico := GetProcAddress(HandleDLL, 'ECF_RelatorioTipo60Analitico');
            @Sweda_RelatorioTipo60AnaliticoMFD := GetProcAddress(HandleDLL, 'ECF_RelatorioTipo60AnaliticoMFD');
            // Funções CAptura Movimento Gravado ECF ---------------------------------------------------------------------
            @Sweda_LeituraXSerial := GetProcAddress(HandleDLL, 'ECF_LeituraXSerial');
            @Sweda_LeituraMemoriaFiscalSerialData := GetProcAddress(HandleDLL, 'ECF_LeituraMemoriaFiscalSerialData');
            @Sweda_LeituraMemoriaFiscalSerialDataMFD := GetProcAddress(HandleDLL, 'ECF_LeituraMemoriaFiscalSerialDataMFD');
            @Sweda_LeituraMemoriaFiscalSerialReducao := GetProcAddress(HandleDLL, 'ECF_LeituraMemoriaFiscalSerialReducao');
            @Sweda_LeituraMemoriaFiscalSerialReducaoMFD := GetProcAddress(HandleDLL, 'ECF_LeituraMemoriaFiscalSerialReducaoMFD');
            @Sweda_DownloadSB := GetProcAddress(HandleDLL, 'ECF_DownloadSB');
            @Sweda_DownloadMF := GetProcAddress(HandleDLL, 'ECF_DownloadMF');
            @Sweda_DownloadMFD := GetProcAddress(HandleDLL, 'ECF_DownloadMFD');
            @Sweda_FormatoDadosMFD := GetProcAddress(HandleDLL, 'ECF_FormatoDadosMFD');
            @Sweda_CapturaDocumentos := GetProcAddress(HandleDLL, 'ECF_CapturaDocumentos');
            // Funções COTEPE --------------------------------------------------------------------------------------------------------------
            @Sweda_TabelaMercadoriasServicos3404 := GetProcAddress(HandleDLL, 'ECF_TabelaMercadoriasServicos3404');
            @Sweda_ReproduzirMemoriaFiscalMFD := GetProcAddress(HandleDLL, 'ECF_ReproduzirMemoriaFiscalMFD');
            @Sweda_GeraRegistrosCAT52MFD := GetProcAddress(HandleDLL, 'ECF_GeraRegistrosCAT52MFD');
            //Funções Código de Barras--------------------------------------------------------------------
            @Sweda_ConfiguraCodigoBarrasMFD := GetProcAddress(HandleDLL, 'ECF_ConfiguraCodigoBarrasMFD');
            @Sweda_CodigoBarrasCODABARMFD := GetProcAddress(HandleDLL, 'ECF_CodigoBarrasCODABARMFD');
            @Sweda_CodigoBarrasCODE39MFD := GetProcAddress(HandleDLL, 'ECF_CodigoBarrasCODE39MFD');
            @Sweda_CodigoBarrasEAN13MFD := GetProcAddress(HandleDLL, 'ECF_CodigoBarrasEAN13MFD');
            @Sweda_CodigoBarrasEAN8MFD := GetProcAddress(HandleDLL, 'ECF_CodigoBarrasEAN8MFD');
            @Sweda_CodigoBarrasITFMFD := GetProcAddress(HandleDLL, 'ECF_CodigoBarrasITFMFD');
            @Sweda_CodigoBarrasUPCAMFD := GetProcAddress(HandleDLL, 'ECF_CodigoBarrasUPCAMFD');
            @Sweda_CodigoBarrasUPCEMFD := GetProcAddress(HandleDLL, 'ECF_CodigoBarrasUPCEMFD');
         end;

      NCR1x, NCR2x, NCR7141:
         begin
            NomeDll := 'EFiscal2.dll';
            HandleDLL := LoadLibrary(PChar(NomeDll));
            if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
            Result := true;
            @NCR_SendCMD := GetProcAddress(HandleDLL, '_IF_SendCmd@12');
            @NCR_SetComPort := GetProcAddress(HandleDLL, '_IF_SetCommPort@4');
         end;
         
      Urano2EFE:
         begin
            NomeDll := 'EFiscal3.dll';
            HandleDLL := LoadLibrary(PChar(NomeDll));
            if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
            Result := true;
            @Urano2EFE_LeituraMF := GetProcAddress(HandleDLL, 'LeituraMemFiscal');
            @Urano2EFE_IniciaImpressora := GetProcAddress(HandleDLL, 'IniciaImpressora');
            @Urano2EFE_FinalizaImpressora := GetProcAddress(HandleDLL, 'FinalizaImpressora');
            @Urano2EFE_ImprimeCabecalho := GetProcAddress(HandleDLL, 'ImprimeCabecalho');
            @Urano2EFE_VendaItem := GetProcAddress(HandleDLL, 'VendaItem');
            @Urano2EFE_CanItem := GetProcAddress(HandleDLL, 'CancelaItem');
            @Urano2EFE_DescontoItem := GetProcAddress(HandleDLL, 'DescontoItem');
            @Urano2EFE_Pagamento := GetProcAddress(HandleDLL, 'Pagamento');
            @Urano2EFE_FinalizaVenda := GetProcAddress(HandleDLL, 'FinalizaVenda');
            @Urano2EFE_ImprimeLinhaNFiscal := GetProcAddress(HandleDLL, 'ImprimeLinhaNFiscal');
            @Urano2EFE_CancelaVenda := GetProcAddress(HandleDLL, 'CancelaVenda');
            @Urano2EFE_CancelaCupom := GetProcAddress(HandleDLL, 'CancelaCupom');
            @Urano2EFE_AcrescSubTotal := GetProcAddress(HandleDLL, 'AcrescSubTotal');
            @Urano2EFE_DescSubTotal := GetProcAddress(HandleDLL, 'DescSubTotal');
            @Urano2EFE_IniciaXZ := GetProcAddress(HandleDLL, 'IniciaXZ');
            @Urano2EFE_FinalizaXZ := GetProcAddress(HandleDLL, 'FinalizaXZ');
            @Urano2EFE_MensagemPromocional := GetProcAddress(HandleDLL, 'MensagemPromocional');
            @Urano2EFE_ProgramaRelogio := GetProcAddress(HandleDLL, 'ProgramaRelogio');
            @Urano2EFE_AGaveta := GetProcAddress(HandleDLL, 'AbreGaveta');
            @Urano2EFE_AvancoLinha := GetProcAddress(HandleDLL, 'AvancoLinha');
            @Urano2EFE_IniciaCupomNFiscal := GetProcAddress(HandleDLL, 'IniciaCupomNFiscal');
            @Urano2EFE_LeRegistradores := GetProcAddress(HandleDLL, 'LeRegistradores');
            @Urano2EFE_AutenticaDocumento := GetProcAddress(HandleDLL, 'AutenticaDocumento');
            @Urano2EFE_LeituraSensor := GetProcAddress(HandleDLL, 'LeituraSensor');
            @Urano2EFE_ICheque := GetProcAddress(HandleDLL, 'ImprimeCheque');
            @Urano2EFE_NomeMoeda := GetProcAddress(HandleDLL, 'NomeMoeda');
            @Urano2EFE_EspacamentoLinhas := GetProcAddress(HandleDLL, 'EspacamentoLinhas');
         end;
      Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41, ZanthusIZ11, ZanthusIZ10:
         begin
            NomeDll := 'EFiscal4.dll';
            HandleDLL := LoadLibrary(PChar(NomeDll));
            if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
            Result := true;
            @Zanthus_InicializaPortaSerial := GetProcAddress(HandleDLL, 'ZECF_InicializaPortaSerial');
            @Zanthus_FechaPortaSerial := GetProcAddress(HandleDLL, 'ZECF_FechaPortaSerial');
            @Zanthus_EnviaComandoComArgumento := GetProcAddress(HandleDLL, 'ZECF_EnviaComandoComArgumento');
            @Zanthus_EnviaComando := GetProcAddress(HandleDLL, 'ZECF_EnviaComando');
            @Zanthus_LeBufferASCII := GetProcAddress(HandleDLL, 'ZECF_LeBufferASCII');
            @Zanthus_LeRetorno := GetProcAddress(HandleDLL, 'ZECF_LeRetorno');
            @Zanthus_LeRetornoASCII := GetProcAddress(HandleDLL, 'ZECF_LeRetornoASCII');
            @Zanthus_ConfiguraCheque := GetProcAddress(HandleDLL, 'ZECF_ConfiguraCheque');
            @Zanthus_ConfiguraMoeda := GetProcAddress(HandleDLL, 'ZECF_ConfiguraMoeda');
            @Zanthus_ImprimeCheque := GetProcAddress(HandleDLL, 'ZECF_ImprimeCheque');
         end;
      BematechMP40, BematechMP20, BematechTermica:
         begin
            //NomeDll := 'EFiscal5.dll';
            NomeDll := 'BemaFI32.dll';
            HandleDLL := LoadLibrary(PChar(NomeDll));
            if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
            Result := true;
            /////////////////////////////// Parte implementada de novas funcoes Bematech /////////////////////////////////////////////////////////////
            // Funções de Inicialização
            @Bematech_AlteraSimboloMoeda:=GetProcAddress(HandleDLL, 'Bematech_FI_AlteraSimboloMoeda');
            @Bematech_ProgramaAliquota:=GetProcAddress(HandleDLL, 'Bematech_FI_ProgramaAliquota');
            @Bematech_ProgramaHorarioVerao:=GetProcAddress(HandleDLL, 'Bematech_FI_ProgramaHorarioVerao');
            @Bematech_NomeiaDepartamento:=GetProcAddress(HandleDLL, 'Bematech_FI_NomeiaDepartamento');
            @Bematech_NomeiaTotalizadorNaoSujeitoIcms:=GetProcAddress(HandleDLL, 'Bematech_FI_NomeiaTotalizadorNaoSujeitoIcms');
            @Bematech_ProgramaArredondamento:=GetProcAddress(HandleDLL, 'Bematech_FI_ProgramaArredondamento');
            @Bematech_ProgramaTruncamento:=GetProcAddress(HandleDLL, 'Bematech_FI_ProgramaTruncamento');
            @Bematech_LinhasEntreCupons:=GetProcAddress(HandleDLL, 'Bematech_FI_LinhasEntreCupons');
            @Bematech_EspacoEntreLinhas:=GetProcAddress(HandleDLL, 'Bematech_FI_EspacoEntreLinhas');
            @Bematech_ForcaImpactoAgulhas:=GetProcAddress(HandleDLL, 'Bematech_FI_ForcaImpactoAgulhas');
            // Funções do Cupom Fiscal
            @Bematech_AbreCupom:=GetProcAddress(HandleDLL, 'Bematech_FI_AbreCupom');
            @Bematech_VendeItem:=GetProcAddress(HandleDLL, 'Bematech_FI_VendeItem');
            @Bematech_VendeItemDepartamento:=GetProcAddress(HandleDLL, 'Bematech_FI_VendeItemDepartamento');
            @Bematech_CancelaItemAnterior:=GetProcAddress(HandleDLL, 'Bematech_FI_CancelaItemAnterior');
            @Bematech_CancelaItemGenerico:=GetProcAddress(HandleDLL, 'Bematech_FI_CancelaItemGenerico');
            @Bematech_CancelaCupom:=GetProcAddress(HandleDLL, 'Bematech_FI_CancelaCupom');
            @Bematech_FechaCupomResumido:=GetProcAddress(HandleDLL, 'Bematech_FI_FechaCupomResumido');
            @Bematech_FechaCupom:=GetProcAddress(HandleDLL, 'Bematech_FI_FechaCupom');
            @Bematech_ResetaImpressora:=GetProcAddress(HandleDLL, 'Bematech_FI_ResetaImpressora');
            @Bematech_IniciaFechamentoCupom:=GetProcAddress(HandleDLL, 'Bematech_FI_IniciaFechamentoCupom');
            @Bematech_EfetuaFormaPagamento:=GetProcAddress(HandleDLL, 'Bematech_FI_EfetuaFormaPagamento');
            @Bematech_EfetuaFormaPagamentoDescricaoForma:=GetProcAddress(HandleDLL, 'Bematech_FI_EfetuaFormaPagamentoDescricaoForma');
            @Bematech_TerminaFechamentoCupom:=GetProcAddress(HandleDLL, 'Bematech_FI_TerminaFechamentoCupom');
            @Bematech_EstornoFormasPagamento:=GetProcAddress(HandleDLL, 'Bematech_FI_EstornoFormasPagamento');
            @Bematech_UsaUnidadeMedida:=GetProcAddress(HandleDLL, 'Bematech_FI_UsaUnidadeMedida');
            @Bematech_AumentaDescricaoItem:=GetProcAddress(HandleDLL, 'Bematech_FI_AumentaDescricaoItem');
            // Funções dos Relatórios Fiscais
            @Bematech_LeituraX:=GetProcAddress(HandleDLL, 'Bematech_FI_LeituraX');
            @Bematech_ReducaoZ:=GetProcAddress(HandleDLL, 'Bematech_FI_ReducaoZ');
            @Bematech_RelatorioGerencial:=GetProcAddress(HandleDLL, 'Bematech_FI_RelatorioGerencial');
            @Bematech_FechaRelatorioGerencial:=GetProcAddress(HandleDLL, 'Bematech_FI_FechaRelatorioGerencial');
            @Bematech_LeituraMemoriaFiscalData:=GetProcAddress(HandleDLL, 'Bematech_FI_LeituraMemoriaFiscalData');
            @Bematech_LeituraMemoriaFiscalReducao:=GetProcAddress(HandleDLL, 'Bematech_FI_LeituraMemoriaFiscalReducao');
            @Bematech_LeituraMemoriaFiscalSerialData:=GetProcAddress(HandleDLL, 'Bematech_FI_LeituraMemoriaFiscalSerialData');
            @Bematech_LeituraMemoriaFiscalSerialReducao:=GetProcAddress(HandleDLL, 'Bematech_FI_LeituraMemoriaFiscalSerialReducao');
            // Funções das Operações Não Fiscais
            @Bematech_RecebimentoNaoFiscal:=GetProcAddress(HandleDLL, 'Bematech_FI_RecebimentoNaoFiscal');
            @Bematech_AbreComprovanteNaoFiscalVinculado:=GetProcAddress(HandleDLL, 'Bematech_FI_AbreComprovanteNaoFiscalVinculado');
            @Bematech_UsaComprovanteNaoFiscalVinculado:=GetProcAddress(HandleDLL, 'Bematech_FI_UsaComprovanteNaoFiscalVinculado');
            @Bematech_UsaComprovanteNaoFiscalVinculadoTEF:=GetProcAddress(HandleDLL, 'Bematech_FI_UsaComprovanteNaoFiscalVinculadoTEF');
            @Bematech_FechaComprovanteNaoFiscalVinculado:=GetProcAddress(HandleDLL, 'Bematech_FI_FechaComprovanteNaoFiscalVinculado');
            @Bematech_Sangria:=GetProcAddress(HandleDLL, 'Bematech_FI_Sangria');
            @Bematech_Suprimento:=GetProcAddress(HandleDLL, 'Bematech_FI_Suprimento');
            // Funções de Informações da Impressora
            @Bematech_NumeroSerie:=GetProcAddress(HandleDLL, 'Bematech_FI_NumeroSerie');
            @Bematech_ProgramaIdAplicativoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_ProgramaIdAplicativoMFD');
            @Bematech_SubTotal:=GetProcAddress(HandleDLL, 'Bematech_FI_SubTotal');
            @Bematech_NumeroCupom:=GetProcAddress(HandleDLL, 'Bematech_FI_NumeroCupom');
            @Bematech_LeituraXSerial:=GetProcAddress(HandleDLL, 'Bematech_FI_LeituraXSerial');
            @Bematech_VersaoFirmware:=GetProcAddress(HandleDLL, 'Bematech_FI_VersaoFirmware');
            @Bematech_CGC_IE:=GetProcAddress(HandleDLL, 'Bematech_FI_CGC_IE');
            @Bematech_GrandeTotal:=GetProcAddress(HandleDLL, 'Bematech_FI_GrandeTotal');
            @Bematech_Cancelamentos:=GetProcAddress(HandleDLL, 'Bematech_FI_Cancelamentos');
            @Bematech_Descontos:=GetProcAddress(HandleDLL, 'Bematech_FI_Descontos');
            @Bematech_NumeroOperacoesNaoFiscais:=GetProcAddress(HandleDLL, 'Bematech_FI_NumeroOperacoesNaoFiscais');
            @Bematech_NumeroCuponsCancelados:=GetProcAddress(HandleDLL, 'Bematech_FI_NumeroCuponsCancelados');
            @Bematech_NumeroIntervencoes:=GetProcAddress(HandleDLL, 'Bematech_FI_NumeroIntervencoes');
            @Bematech_NumeroReducoes:=GetProcAddress(HandleDLL, 'Bematech_FI_NumeroReducoes');
            @Bematech_NumeroSubstituicoesProprietario:=GetProcAddress(HandleDLL, 'Bematech_FI_NumeroSubstituicoesProprietario');
            @Bematech_UltimoItemVendido:=GetProcAddress(HandleDLL, 'Bematech_FI_UltimoItemVendido');
            @Bematech_ClicheProprietario:=GetProcAddress(HandleDLL, 'Bematech_FI_ClicheProprietario');
            @Bematech_NumeroCaixa:=GetProcAddress(HandleDLL, 'Bematech_FI_NumeroCaixa');
            @Bematech_NumeroLoja:=GetProcAddress(HandleDLL, 'Bematech_FI_NumeroLoja');
            @Bematech_SimboloMoeda:=GetProcAddress(HandleDLL, 'Bematech_FI_SimboloMoeda');
            @Bematech_MinutosLigada:=GetProcAddress(HandleDLL, 'Bematech_FI_MinutosLigada');
            @Bematech_MinutosImprimindo:=GetProcAddress(HandleDLL, 'Bematech_FI_MinutosImprimindo');
            @Bematech_VerificaModoOperacao:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaModoOperacao');
            @Bematech_VerificaEpromConectada:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaEpromConectada');
            @Bematech_FlagsFiscais:=GetProcAddress(HandleDLL, 'Bematech_FI_FlagsFiscais');
            @Bematech_ValorPagoUltimoCupom:=GetProcAddress(HandleDLL, 'Bematech_FI_ValorPagoUltimoCupom');
            @Bematech_DataHoraImpressora:=GetProcAddress(HandleDLL, 'Bematech_FI_DataHoraImpressora');
            @Bematech_ContadoresTotalizadoresNaoFiscais:=GetProcAddress(HandleDLL, 'Bematech_FI_ContadoresTotalizadoresNaoFiscais');
            @Bematech_VerificaTotalizadoresNaoFiscais:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaTotalizadoresNaoFiscais');
            @Bematech_DataHoraReducao:=GetProcAddress(HandleDLL, 'Bematech_FI_DataHoraReducao');
            @Bematech_DataMovimento:=GetProcAddress(HandleDLL, 'Bematech_FI_DataMovimento');
            @Bematech_VerificaTruncamento:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaTruncamento');
            @Bematech_Acrescimos:=GetProcAddress(HandleDLL, 'Bematech_FI_Acrescimos');
            @Bematech_ContadorBilhetePassagem:=GetProcAddress(HandleDLL, 'Bematech_FI_ContadorBilhetePassagem');
            @Bematech_VerificaAliquotasIss:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaAliquotasIss');
            @Bematech_VerificaFormasPagamento:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaFormasPagamento');
            @Bematech_VerificaRecebimentoNaoFiscal:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaRecebimentoNaoFiscal');
            @Bematech_VerificaDepartamentos:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaDepartamentos');
            @Bematech_VerificaTipoImpressora:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaTipoImpressora');
            @Bematech_VerificaTotalizadoresParciais:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaTotalizadoresParciais');
            @Bematech_RetornoAliquotas:=GetProcAddress(HandleDLL, 'Bematech_FI_RetornoAliquotas');
            @Bematech_VerificaEstadoImpressora:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaEstadoImpressora');
            @Bematech_DadosUltimaReducao:=GetProcAddress(HandleDLL, 'Bematech_FI_DadosUltimaReducao');
            @Bematech_MonitoramentoPapel:=GetProcAddress(HandleDLL, 'Bematech_FI_MonitoramentoPapel');
            @Bematech_VerificaIndiceAliquotasIss:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaIndiceAliquotasIss');
            @Bematech_ValorFormaPagamento:=GetProcAddress(HandleDLL, 'Bematech_FI_ValorFormaPagamento');
            @Bematech_ValorTotalizadorNaoFiscal:=GetProcAddress(HandleDLL, 'Bematech_FI_ValorTotalizadorNaoFiscal');
            @Bematech_LeArquivoRetorno:=GetProcAddress(HandleDLL, 'Bematech_FI_LeArquivoRetorno');
            @Bematech_RegistrosTipo60:=GetProcAddress(HandleDLL, 'Bematech_FI_RegistrosTipo60');
            // Funções de Autenticação e Gaveta de Dinheiro
            @Bematech_Autenticacao:=GetProcAddress(HandleDLL, 'Bematech_FI_Autenticacao');
            @Bematech_ProgramaCaracterAutenticacao:=GetProcAddress(HandleDLL, 'Bematech_FI_ProgramaCaracterAutenticacao');
            @Bematech_AcionaGaveta:=GetProcAddress(HandleDLL, 'Bematech_FI_AcionaGaveta');
            @Bematech_VerificaEstadoGaveta:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaEstadoGaveta');
            // Funções de Impressão de Cheques
            @Bematech_ProgramaMoedaSingular:=GetProcAddress(HandleDLL, 'Bematech_FI_ProgramaMoedaSingular');
            @Bematech_ProgramaMoedaPlural:=GetProcAddress(HandleDLL, 'Bematech_FI_ProgramaMoedaPlural');
            @Bematech_CancelaImpressaoCheque:=GetProcAddress(HandleDLL, 'Bematech_FI_CancelaImpressaoCheque');
            @Bematech_VerificaStatusCheque:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaStatusCheque');
            @Bematech_ImprimeCheque:=GetProcAddress(HandleDLL, 'Bematech_FI_ImprimeCheque');
            @Bematech_IncluiCidadeFavorecido:=GetProcAddress(HandleDLL, 'Bematech_FI_IncluiCidadeFavorecido');
            @Bematech_ImprimeCopiaCheque:=GetProcAddress(HandleDLL, 'Bematech_FI_ImprimeCopiaCheque');
            // Outras Funções
            @Bematech_AbrePortaSerial:=GetProcAddress(HandleDLL, 'Bematech_FI_AbrePortaSerial');
            @Bematech_RetornoImpressora:=GetProcAddress(HandleDLL, 'Bematech_FI_RetornoImpressora');
            @Bematech_FechaPortaSerial:=GetProcAddress(HandleDLL, 'Bematech_FI_FechaPortaSerial');
            @Bematech_MapaResumo:=GetProcAddress(HandleDLL, 'Bematech_FI_MapaResumo');
            @Bematech_AberturaDoDia:=GetProcAddress(HandleDLL, 'Bematech_FI_AberturaDoDia');
            @Bematech_FechamentoDoDia:=GetProcAddress(HandleDLL, 'Bematech_FI_FechamentoDoDia');
            @Bematech_ImprimeConfiguracoesImpressora:=GetProcAddress(HandleDLL, 'Bematech_FI_ImprimeConfiguracoesImpressora');
            @Bematech_ImprimeDepartamentos:=GetProcAddress(HandleDLL, 'Bematech_FI_ImprimeDepartamentos');
            @Bematech_RelatorioTipo60Analitico:=GetProcAddress(HandleDLL, 'Bematech_FI_RelatorioTipo60Analitico');
            @Bematech_RelatorioTipo60Mestre:=GetProcAddress(HandleDLL, 'Bematech_FI_RelatorioTipo60Mestre');
            @Bematech_VerificaImpressoraLigada:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaImpressoraLigada');
            // Funções da Impressora Fiscal MFD
            @Bematech_AbreCupomMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_AbreCupomMFD');
            @Bematech_CancelaCupomMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_CancelaCupomMFD');
            @Bematech_ProgramaFormaPagamentoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_ProgramaFormaPagamentoMFD');
            @Bematech_EfetuaFormaPagamentoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_EfetuaFormaPagamentoMFD');
            @Bematech_CupomAdicionalMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_CupomAdicionalMFD');
            @Bematech_AcrescimoDescontoItemMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_AcrescimoDescontoItemMFD');
            @Bematech_NomeiaRelatorioGerencialMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_NomeiaRelatorioGerencialMFD');
            @Bematech_AutenticacaoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_AutenticacaoMFD');
            @Bematech_AbreComprovanteNaoFiscalVinculadoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_AbreComprovanteNaoFiscalVinculadoMFD');
            @Bematech_ReimpressaoNaoFiscalVinculadoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_ReimpressaoNaoFiscalVinculadoMFD');
            @Bematech_AbreRecebimentoNaoFiscalMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_AbreRecebimentoNaoFiscalMFD');
            @Bematech_EfetuaRecebimentoNaoFiscalMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_EfetuaRecebimentoNaoFiscalMFD');
            @Bematech_IniciaFechamentoCupomMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_IniciaFechamentoCupomMFD');
            @Bematech_IniciaFechamentoRecebimentoNaoFiscalMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_IniciaFechamentoRecebimentoNaoFiscalMFD');
            @Bematech_FechaRecebimentoNaoFiscalMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_FechaRecebimentoNaoFiscalMFD');
            @Bematech_CancelaRecebimentoNaoFiscalMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_CancelaRecebimentoNaoFiscalMFD');
            @Bematech_AbreRelatorioGerencialMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_AbreRelatorioGerencialMFD');
            @Bematech_UsaRelatorioGerencialMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_UsaRelatorioGerencialMFD');
            @Bematech_SegundaViaNaoFiscalVinculadoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_SegundaViaNaoFiscalVinculadoMFD');
            @Bematech_EstornoNaoFiscalVinculadoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_EstornoNaoFiscalVinculadoMFD');
            @Bematech_NumeroSerieMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_NumeroSerieMFD');
            @Bematech_VersaoFirmwareMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_VersaoFirmwareMFD');
            @Bematech_CNPJMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_CNPJMFD');
            @Bematech_InscricaoEstadualMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_InscricaoEstadualMFD');
            @Bematech_InscricaoMunicipalMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_InscricaoMunicipalMFD');
            @Bematech_TempoOperacionalMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_TempoOperacionalMFD');
            @Bematech_MinutosEmitindoDocumentosFiscaisMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_MinutosEmitindoDocumentosFiscaisMFD');
            @Bematech_ContadoresTotalizadoresNaoFiscaisMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_ContadoresTotalizadoresNaoFiscaisMFD');
            @Bematech_VerificaTotalizadoresNaoFiscaisMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaTotalizadoresNaoFiscaisMFD');
            @Bematech_VerificaFormasPagamentoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaFormasPagamentoMFD');
            @Bematech_VerificaRecebimentoNaoFiscalMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaRecebimentoNaoFiscalMFD');
            @Bematech_VerificaRelatorioGerencialMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaRelatorioGerencialMFD');
            @Bematech_ContadorComprovantesCreditoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_ContadorComprovantesCreditoMFD');
            @Bematech_ContadorOperacoesNaoFiscaisCanceladasMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_ContadorOperacoesNaoFiscaisCanceladasMFD');
            @Bematech_ContadorRelatoriosGerenciaisMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_ContadorRelatoriosGerenciaisMFD');
            @Bematech_ContadorCupomFiscalMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_ContadorCupomFiscalMFD');
            @Bematech_ContadorFitaDetalheMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_ContadorFitaDetalheMFD');
            @Bematech_ComprovantesNaoFiscaisNaoEmitidosMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_ComprovantesNaoFiscaisNaoEmitidosMFD');
            @Bematech_NumeroSerieMemoriaMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_NumeroSerieMemoriaMFD');
            @Bematech_MarcaModeloTipoImpressoraMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_MarcaModeloTipoImpressoraMFD');
            @Bematech_DataHoraGravacaoUsuarioSWBasicoMFAdicional:=GetProcAddress(HandleDLL, 'Bematech_FI_DataHoraGravacaoUsuarioSWBasicoMFAdicional');
            @Bematech_ReducoesRestantesMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_ReducoesRestantesMFD');
            @Bematech_VerificaTotalizadoresParciaisMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaTotalizadoresParciaisMFD');
            @Bematech_DadosUltimaReducaoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_DadosUltimaReducaoMFD');
            @Bematech_LeituraMemoriaFiscalDataMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_LeituraMemoriaFiscalDataMFD');
            @Bematech_LeituraMemoriaFiscalReducaoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_LeituraMemoriaFiscalReducaoMFD');
            @Bematech_LeituraMemoriaFiscalSerialDataMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_LeituraMemoriaFiscalSerialDataMFD');
            @Bematech_LeituraMemoriaFiscalSerialReducaoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_LeituraMemoriaFiscalSerialReducaoMFD');
            @Bematech_LeituraChequeMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_LeituraChequeMFD');
            @Bematech_ImprimeChequeMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_ImprimeChequeMFD');
            @Bematech_HabilitaDesabilitaRetornoEstendidoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_HabilitaDesabilitaRetornoEstendidoMFD');
            @Bematech_RetornoImpressoraMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_RetornoImpressoraMFD');
            @Bematech_AbreBilhetePassagemMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_AbreBilhetePassagemMFD');
            @Bematech_CancelaAcrescimoDescontoItemMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_CancelaAcrescimoDescontoItemMFD');
            @Bematech_SubTotalizaCupomMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_SubTotalizaCupomMFD');
            @Bematech_SubTotalizaRecebimentoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_SubTotalizaRecebimentoMFD');
            @Bematech_TotalLivreMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_TotalLivreMFD');
            @Bematech_TamanhoTotalMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_TamanhoTotalMFD');
            @Bematech_AcrescimoDescontoSubtotalRecebimentoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_AcrescimoDescontoSubtotalRecebimentoMFD');
            @Bematech_AcrescimoDescontoSubtotalMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_AcrescimoDescontoSubtotalMFD');
            @Bematech_CancelaAcrescimoDescontoSubtotalMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_CancelaAcrescimoDescontoSubtotalMFD');
            @Bematech_CancelaAcrescimoDescontoSubtotalRecebimentoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_CancelaAcrescimoDescontoSubtotalRecebimentoMFD');
            @Bematech_TotalizaCupomMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_TotalizaCupomMFD');
            @Bematech_TotalizaRecebimentoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_TotalizaRecebimentoMFD');
            @Bematech_PercentualLivreMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_PercentualLivreMFD');
            @Bematech_DataHoraUltimoDocumentoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_DataHoraUltimoDocumentoMFD');
            @Bematech_MapaResumoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_MapaResumoMFD');
            @Bematech_RelatorioTipo60AnaliticoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_RelatorioTipo60AnaliticoMFD');
            @Bematech_ValorFormaPagamentoMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_ValorFormaPagamentoMFD');
            @Bematech_ValorTotalizadorNaoFiscalMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_ValorTotalizadorNaoFiscalMFD');
            @Bematech_VerificaEstadoImpressoraMFD:=GetProcAddress(HandleDLL, 'Bematech_FI_VerificaEstadoImpressoraMFD');
            // Funções para o TEF
            @Bematech_TEF_Status:=GetProcAddress(HandleDLL, 'Bematech_FITEF_Status');
            @Bematech_TEF_VendaCartao:=GetProcAddress(HandleDLL, 'Bematech_FITEF_VendaCartao');
            @Bematech_TEF_ConfirmaVenda:=GetProcAddress(HandleDLL, 'Bematech_FITEF_ConfirmaVenda');
            @Bematech_TEF_NaoConfirmaVendaImpressao:=GetProcAddress(HandleDLL, 'Bematech_FITEF_NaoConfirmaVendaImpressao');
            @Bematech_TEF_CancelaVendaCartao:=GetProcAddress(HandleDLL, 'Bematech_FITEF_CancelaVendaCartao');
            @Bematech_TEF_ImprimeTEF:=GetProcAddress(HandleDLL, 'Bematech_FITEF_ImprimeTEF');
            @Bematech_TEF_ImprimeRelatorio:=GetProcAddress(HandleDLL, 'Bematech_FITEF_ImprimeRelatorio');
            @Bematech_TEF_ADM:=GetProcAddress(HandleDLL, 'Bematech_FITEF_ADM');
            @Bematech_TEF_VendaCompleta:=GetProcAddress(HandleDLL, 'Bematech_FITEF_VendaCompleta');
            @Bematech_TEF_ConfiguraDiretorioTef:=GetProcAddress(HandleDLL, 'Bematech_FITEF_ConfiguraDiretorioTef');
            @Bematech_TEF_VendaCheque:=GetProcAddress(HandleDLL, 'Bematech_FITEF_VendaCheque');
            @Bematech_TEF_ApagaResiduos:=GetProcAddress(HandleDLL, 'Bematech_FITEF_ApagaResiduos');
            // Funções para a Balança
            @Bematech_InfoBalanca:=GetProcAddress(HandleDLL, 'Bematech_FI_InfoBalanca');
            // Funcoes Sintegra
            @Bematech_FI_RelatorioSintegraMFD := GetProcAddress(HandleDLL, 'Bematech_FI_RelatorioSintegraMFD');
            //PAF
            @Bematech_FI_DownloadMFD := GetProcAddress(HandleDLL, 'Bematech_FI_DownloadMFD');
            @Bematech_FI_InicioFimCOOsMFD := GetProcAddress(HandleDLL, 'Bematech_FI_InicioFimCOOsMFD');
            @Bematech_FI_InicioFimGTsMFD := GetProcAddress(HandleDLL, 'Bematech_FI_InicioFimGTsMFD');


{ Fim da Declaração }

            NomeDll := 'EFiscal55.dll';
            HandleDLL := LoadLibrary(PChar(NomeDll));
            if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
            Result := true;
            @Bematech_IniPortaStr := GetProcAddress(HandleDLL, 'IniPortaStr');
            @Bematech_FormataTX := GetProcAddress(HandleDLL, 'FormataTX');
            @Bematech_FechaPorta := GetProcAddress(HandleDLL, 'FechaPorta');
            @Bematech_Status_Mp20FI := GetProcAddress(HandleDLL, 'Status_Mp20FI');
         end;


      Elgin:
         begin
            NomeDll := 'elgin.dll';
            HandleDLL := LoadLibrary(PChar(NomeDll));
            if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
            Result := true;
            /////////////////////////////// Parte implementada de novas funcoes Elgin /////////////////////////////////////////////////////////////
            // Funções de Inicialização
            @Elgin_AlteraSimboloMoeda:=GetProcAddress(HandleDLL, 'Elgin_AlteraSimboloMoeda');
            @Elgin_ProgramaAliquota:=GetProcAddress(HandleDLL, 'Elgin_ProgramaAliquota');
            @Elgin_ProgramaHorarioVerao:=GetProcAddress(HandleDLL, 'Elgin_ProgramaHorarioVerao');
            @Elgin_NomeiaDepartamento:=GetProcAddress(HandleDLL, 'Elgin_NomeiaDepartamento');
            @Elgin_NomeiaTotalizadorNaoSujeitoIcms:=GetProcAddress(HandleDLL, 'Elgin_NomeiaTotalizadorNaoSujeitoIcms');
            @Elgin_ProgramaArredondamento:=GetProcAddress(HandleDLL, 'Elgin_ProgramaArredondamento');
            @Elgin_ProgramaTruncamento:=GetProcAddress(HandleDLL, 'Elgin_ProgramaTruncamento');
            @Elgin_LinhasEntreCupons:=GetProcAddress(HandleDLL, 'Elgin_LinhasEntreCupons');
            @Elgin_EspacoEntreLinhas:=GetProcAddress(HandleDLL, 'Elgin_EspacoEntreLinhas');
            @Elgin_ForcaImpactoAgulhas:=GetProcAddress(HandleDLL, 'Elgin_ForcaImpactoAgulhas');
            // Funções do Cupom Fiscal
            @Elgin_AbreCupom:=GetProcAddress(HandleDLL, 'Elgin_AbreCupom');
            @Elgin_VendeItem:=GetProcAddress(HandleDLL, 'Elgin_VendeItem');
            @Elgin_VendeItemDepartamento:=GetProcAddress(HandleDLL, 'Elgin_VendeItemDepartamento');
            @Elgin_CancelaItemAnterior:=GetProcAddress(HandleDLL, 'Elgin_CancelaItemAnterior');
            @Elgin_CancelaItemGenerico:=GetProcAddress(HandleDLL, 'Elgin_CancelaItemGenerico');
            @Elgin_CancelaCupom:=GetProcAddress(HandleDLL, 'Elgin_CancelaCupom');
            @Elgin_FechaCupomResumido:=GetProcAddress(HandleDLL, 'Elgin_FechaCupomResumido');
            @Elgin_FechaCupom:=GetProcAddress(HandleDLL, 'Elgin_FechaCupom');
            @Elgin_ResetaImpressora:=GetProcAddress(HandleDLL, 'Elgin_ResetaImpressora');
            @Elgin_IniciaFechamentoCupom:=GetProcAddress(HandleDLL, 'Elgin_IniciaFechamentoCupom');
            @Elgin_EfetuaFormaPagamento:=GetProcAddress(HandleDLL, 'Elgin_EfetuaFormaPagamento');
            @Elgin_EfetuaFormaPagamentoDescricaoForma:=GetProcAddress(HandleDLL, 'Elgin_EfetuaFormaPagamentoDescricaoForma');
            @Elgin_TerminaFechamentoCupom:=GetProcAddress(HandleDLL, 'Elgin_TerminaFechamentoCupom');
            @Elgin_EstornoFormasPagamento:=GetProcAddress(HandleDLL, 'Elgin_EstornoFormasPagamento');
            @Elgin_UsaUnidadeMedida:=GetProcAddress(HandleDLL, 'Elgin_UsaUnidadeMedida');
            @Elgin_AumentaDescricaoItem:=GetProcAddress(HandleDLL, 'Elgin_AumentaDescricaoItem');
            // Funções dos Relatórios Fiscais
            @Elgin_LeituraX:=GetProcAddress(HandleDLL, 'Elgin_LeituraX');
            @Elgin_ReducaoZ:=GetProcAddress(HandleDLL, 'Elgin_ReducaoZ');
            @Elgin_RelatorioGerencial:=GetProcAddress(HandleDLL, 'Elgin_RelatorioGerencial');
            @Elgin_AbreRelatorioGerencial:=GetProcAddress(HandleDLL, 'Elgin_AbreRelatorioGerencial');
            @Elgin_FechaRelatorioGerencial:=GetProcAddress(HandleDLL, 'Elgin_FechaRelatorioGerencial');
            @Elgin_LeIndicadores:=GetProcAddress(HandleDLL, 'Elgin_LeIndicadores');
            @Elgin_LeituraMemoriaFiscalData:=GetProcAddress(HandleDLL, 'Elgin_LeituraMemoriaFiscalData');
            @Elgin_LeituraMemoriaFiscalReducao:=GetProcAddress(HandleDLL, 'Elgin_LeituraMemoriaFiscalReducao');
            @Elgin_LeituraMemoriaFiscalSerialData:=GetProcAddress(HandleDLL, 'Elgin_LeituraMemoriaFiscalSerialData');
            @Elgin_LeituraMemoriaFiscalSerialReducao:=GetProcAddress(HandleDLL, 'Elgin_LeituraMemoriaFiscalSerialReducao');
            // Funções das Operações Não Fiscais
            @Elgin_RecebimentoNaoFiscal:=GetProcAddress(HandleDLL, 'Elgin_RecebimentoNaoFiscal');
            @Elgin_AbreComprovanteNaoFiscalVinculado:=GetProcAddress(HandleDLL, 'Elgin_AbreComprovanteNaoFiscalVinculado');
            @Elgin_UsaComprovanteNaoFiscalVinculado:=GetProcAddress(HandleDLL, 'Elgin_UsaComprovanteNaoFiscalVinculado');
            @Elgin_FechaComprovanteNaoFiscalVinculado:=GetProcAddress(HandleDLL, 'Elgin_FechaComprovanteNaoFiscalVinculado');
            @Elgin_Sangria:=GetProcAddress(HandleDLL, 'Elgin_Sangria');
            @Elgin_Suprimento:=GetProcAddress(HandleDLL, 'Elgin_Suprimento');
            // Funções de Informações da Impressora
            @Elgin_NumeroSerie:=GetProcAddress(HandleDLL, 'Elgin_NumeroSerie');
            @Elgin_SubTotal:=GetProcAddress(HandleDLL, 'Elgin_SubTotal');
            @Elgin_NumeroCupom:=GetProcAddress(HandleDLL, 'Elgin_NumeroCupom');
            @Elgin_LeituraXSerial:=GetProcAddress(HandleDLL, 'Elgin_LeituraXSerial');
            @Elgin_VersaoFirmware:=GetProcAddress(HandleDLL, 'Elgin_VersaoFirmware');
            @Elgin_CGC_IE:=GetProcAddress(HandleDLL, 'Elgin_CGC_IE');
            @Elgin_GrandeTotal:=GetProcAddress(HandleDLL, 'Elgin_GrandeTotal');
            @Elgin_Cancelamentos:=GetProcAddress(HandleDLL, 'Elgin_Cancelamentos');
            @Elgin_Descontos:=GetProcAddress(HandleDLL, 'Elgin_Descontos');
            @Elgin_NumeroOperacoesNaoFiscais:=GetProcAddress(HandleDLL, 'Elgin_NumeroOperacoesNaoFiscais');
            @Elgin_NumeroCuponsCancelados:=GetProcAddress(HandleDLL, 'Elgin_NumeroCuponsCancelados');
            @Elgin_NumeroIntervencoes:=GetProcAddress(HandleDLL, 'Elgin_NumeroIntervencoes');
            @Elgin_NumeroReducoes:=GetProcAddress(HandleDLL, 'Elgin_NumeroReducoes');
            @Elgin_NumeroSubstituicoesProprietario:=GetProcAddress(HandleDLL, 'Elgin_NumeroSubstituicoesProprietario');
            @Elgin_UltimoItemVendido:=GetProcAddress(HandleDLL, 'Elgin_UltimoItemVendido');
            @Elgin_ClicheProprietario:=GetProcAddress(HandleDLL, 'Elgin_ClicheProprietario');
            @Elgin_NumeroCaixa:=GetProcAddress(HandleDLL, 'Elgin_NumeroCaixa');
            @Elgin_NumeroLoja:=GetProcAddress(HandleDLL, 'Elgin_NumeroLoja');
            @Elgin_SimboloMoeda:=GetProcAddress(HandleDLL, 'Elgin_SimboloMoeda');
            @Elgin_MinutosLigada:=GetProcAddress(HandleDLL, 'Elgin_MinutosLigada');
            @Elgin_MinutosImprimindo:=GetProcAddress(HandleDLL, 'Elgin_MinutosImprimindo');
            @Elgin_VerificaModoOperacao:=GetProcAddress(HandleDLL, 'Elgin_VerificaModoOperacao');
            @Elgin_VerificaEpromConectada:=GetProcAddress(HandleDLL, 'Elgin_VerificaEpromConectada');
            @Elgin_FlagsFiscais:=GetProcAddress(HandleDLL, 'Elgin_FlagsFiscais');
            @Elgin_ValorPagoUltimoCupom:=GetProcAddress(HandleDLL, 'Elgin_ValorPagoUltimoCupom');
            @Elgin_DataHoraImpressora:=GetProcAddress(HandleDLL, 'Elgin_DataHoraImpressora');
            @Elgin_ContadoresTotalizadoresNaoFiscais:=GetProcAddress(HandleDLL, 'Elgin_ContadoresTotalizadoresNaoFiscais');
            @Elgin_VerificaTotalizadoresNaoFiscais:=GetProcAddress(HandleDLL, 'Elgin_VerificaTotalizadoresNaoFiscais');
            @Elgin_DataHoraReducao:=GetProcAddress(HandleDLL, 'Elgin_DataHoraReducao');
            @Elgin_DataMovimento:=GetProcAddress(HandleDLL, 'Elgin_DataMovimento');
            @Elgin_VerificaTruncamento:=GetProcAddress(HandleDLL, 'Elgin_VerificaTruncamento');
            @Elgin_Acrescimos:=GetProcAddress(HandleDLL, 'Elgin_Acrescimos');
            @Elgin_ContadorBilhetePassagem:=GetProcAddress(HandleDLL, 'Elgin_ContadorBilhetePassagem');
            @Elgin_VerificaAliquotasIss:=GetProcAddress(HandleDLL, 'Elgin_VerificaAliquotasIss');
            @Elgin_VerificaFormasPagamento:=GetProcAddress(HandleDLL, 'Elgin_VerificaFormasPagamento');
            @Elgin_VerificaRecebimentoNaoFiscal:=GetProcAddress(HandleDLL, 'Elgin_VerificaRecebimentoNaoFiscal');
            @Elgin_VerificaDepartamentos:=GetProcAddress(HandleDLL, 'Elgin_VerificaDepartamentos');
            @Elgin_VerificaTipoImpressora:=GetProcAddress(HandleDLL, 'Elgin_VerificaTipoImpressora');
            @Elgin_VerificaTotalizadoresParciais:=GetProcAddress(HandleDLL, 'Elgin_VerificaTotalizadoresParciais');
            @Elgin_RetornoAliquotas:=GetProcAddress(HandleDLL, 'Elgin_RetornoAliquotas');
            @Elgin_VerificaEstadoImpressora:=GetProcAddress(HandleDLL, 'Elgin_VerificaEstadoImpressora');
            @Elgin_DadosUltimaReducao:=GetProcAddress(HandleDLL, 'Elgin_DadosUltimaReducao');
            @Elgin_MonitoramentoPapel:=GetProcAddress(HandleDLL, 'Elgin_MonitoramentoPapel');
            @Elgin_VerificaIndiceAliquotasIss:=GetProcAddress(HandleDLL, 'Elgin_VerificaIndiceAliquotasIss');
            @Elgin_ValorFormaPagamento:=GetProcAddress(HandleDLL, 'Elgin_ValorFormaPagamento');
            @Elgin_ValorTotalizadorNaoFiscal:=GetProcAddress(HandleDLL, 'Elgin_ValorTotalizadorNaoFiscal');
            @Elgin_LeArquivoRetorno:=GetProcAddress(HandleDLL, 'Elgin_LeArquivoRetorno');
            @Elgin_RegistrosTipo60:=GetProcAddress(HandleDLL, 'Elgin_RegistrosTipo60');
            // Funções de Autenticação e Gaveta de Dinheiro
            @Elgin_Autenticacao:=GetProcAddress(HandleDLL, 'Elgin_Autenticacao');
            @Elgin_ProgramaCaracterAutenticacao:=GetProcAddress(HandleDLL, 'Elgin_ProgramaCaracterAutenticacao');
            @Elgin_AcionaGaveta:=GetProcAddress(HandleDLL, 'Elgin_AcionaGaveta');
            @Elgin_VerificaEstadoGaveta:=GetProcAddress(HandleDLL, 'Elgin_VerificaEstadoGaveta');
            // Funções de Impressão de Cheques
            @Elgin_ProgramaMoedaSingular:=GetProcAddress(HandleDLL, 'Elgin_ProgramaMoedaSingular');
            @Elgin_ProgramaMoedaPlural:=GetProcAddress(HandleDLL, 'Elgin_ProgramaMoedaPlural');
            @Elgin_CancelaImpressaoCheque:=GetProcAddress(HandleDLL, 'Elgin_CancelaImpressaoCheque');
            @Elgin_VerificaStatusCheque:=GetProcAddress(HandleDLL, 'Elgin_VerificaStatusCheque');
            @Elgin_ImprimeCheque:=GetProcAddress(HandleDLL, 'Elgin_ImprimeCheque');
            @Elgin_IncluiCidadeFavorecido:=GetProcAddress(HandleDLL, 'Elgin_IncluiCidadeFavorecido');
            @Elgin_ImprimeCopiaCheque:=GetProcAddress(HandleDLL, 'Elgin_ImprimeCopiaCheque');
            // Outras Funções
            @Elgin_AbrePortaSerial:=GetProcAddress(HandleDLL, 'Elgin_AbrePortaSerial');
            @Elgin_RetornoImpressora:=GetProcAddress(HandleDLL, 'Elgin_RetornoImpressora');
            @Elgin_FechaPortaSerial:=GetProcAddress(HandleDLL, 'Elgin_FechaPortaSerial');
            @Elgin_MapaResumo:=GetProcAddress(HandleDLL, 'Elgin_MapaResumo');
            @Elgin_AberturaDoDia:=GetProcAddress(HandleDLL, 'Elgin_AberturaDoDia');
            @Elgin_FechamentoDoDia:=GetProcAddress(HandleDLL, 'Elgin_FechamentoDoDia');
            @Elgin_ImprimeConfiguracoesImpressora:=GetProcAddress(HandleDLL, 'Elgin_ImprimeConfiguracoesImpressora');
            @Elgin_ImprimeDepartamentos:=GetProcAddress(HandleDLL, 'Elgin_ImprimeDepartamentos');
            @Elgin_RelatorioTipo60Analitico:=GetProcAddress(HandleDLL, 'Elgin_RelatorioTipo60Analitico');
            @Elgin_RelatorioTipo60Mestre:=GetProcAddress(HandleDLL, 'Elgin_RelatorioTipo60Mestre');
            @Elgin_VerificaImpressoraLigada:=GetProcAddress(HandleDLL, 'Elgin_VerificaImpressoraLigada');
            // Funções da Impressora Fiscal MFD
            @Elgin_AbreCupomMFD:=GetProcAddress(HandleDLL, 'Elgin_AbreCupomMFD');
            @Elgin_CancelaCupomMFD:=GetProcAddress(HandleDLL, 'Elgin_CancelaCupomMFD');
            @Elgin_ProgramaFormaPagamentoMFD:=GetProcAddress(HandleDLL, 'Elgin_ProgramaFormaPagamentoMFD');
            @Elgin_EfetuaFormaPagamentoMFD:=GetProcAddress(HandleDLL, 'Elgin_EfetuaFormaPagamentoMFD');
            @Elgin_CupomAdicionalMFD:=GetProcAddress(HandleDLL, 'Elgin_CupomAdicionalMFD');
            @Elgin_AcrescimoDescontoItemMFD:=GetProcAddress(HandleDLL, 'Elgin_AcrescimoDescontoItemMFD');
            @Elgin_NomeiaRelatorioGerencialMFD:=GetProcAddress(HandleDLL, 'Elgin_NomeiaRelatorioGerencialMFD');
            @Elgin_AutenticacaoMFD:=GetProcAddress(HandleDLL, 'Elgin_AutenticacaoMFD');
            @Elgin_AbreComprovanteNaoFiscalVinculadoMFD:=GetProcAddress(HandleDLL, 'Elgin_AbreComprovanteNaoFiscalVinculadoMFD');
            @Elgin_ReimpressaoNaoFiscalVinculadoMFD:=GetProcAddress(HandleDLL, 'Elgin_ReimpressaoNaoFiscalVinculadoMFD');
            @Elgin_AbreRecebimentoNaoFiscalMFD:=GetProcAddress(HandleDLL, 'Elgin_AbreRecebimentoNaoFiscalMFD');
            @Elgin_EfetuaRecebimentoNaoFiscalMFD:=GetProcAddress(HandleDLL, 'Elgin_EfetuaRecebimentoNaoFiscalMFD');
            @Elgin_IniciaFechamentoCupomMFD:=GetProcAddress(HandleDLL, 'Elgin_IniciaFechamentoCupomMFD');
            @Elgin_IniciaFechamentoRecebimentoNaoFiscalMFD:=GetProcAddress(HandleDLL, 'Elgin_IniciaFechamentoRecebimentoNaoFiscalMFD');
            @Elgin_FechaRecebimentoNaoFiscalMFD:=GetProcAddress(HandleDLL, 'Elgin_FechaRecebimentoNaoFiscalMFD');
            @Elgin_CancelaRecebimentoNaoFiscalMFD:=GetProcAddress(HandleDLL, 'Elgin_CancelaRecebimentoNaoFiscalMFD');
            @Elgin_AbreRelatorioGerencialMFD:=GetProcAddress(HandleDLL, 'Elgin_AbreRelatorioGerencialMFD');
            @Elgin_UsaRelatorioGerencialMFD:=GetProcAddress(HandleDLL, 'Elgin_UsaRelatorioGerencialMFD');
            @Elgin_SegundaViaNaoFiscalVinculadoMFD:=GetProcAddress(HandleDLL, 'Elgin_SegundaViaNaoFiscalVinculadoMFD');
            @Elgin_EstornoNaoFiscalVinculadoMFD:=GetProcAddress(HandleDLL, 'Elgin_EstornoNaoFiscalVinculadoMFD');
            @Elgin_NumeroSerieMFD:=GetProcAddress(HandleDLL, 'Elgin_NumeroSerieMFD');
            @Elgin_VersaoFirmwareMFD:=GetProcAddress(HandleDLL, 'Elgin_VersaoFirmwareMFD');
            @Elgin_CNPJMFD:=GetProcAddress(HandleDLL, 'Elgin_CNPJMFD');
            @Elgin_InscricaoEstadualMFD:=GetProcAddress(HandleDLL, 'Elgin_InscricaoEstadualMFD');
            @Elgin_InscricaoMunicipalMFD:=GetProcAddress(HandleDLL, 'Elgin_InscricaoMunicipalMFD');
            @Elgin_TempoOperacionalMFD:=GetProcAddress(HandleDLL, 'Elgin_TempoOperacionalMFD');
            @Elgin_MinutosEmitindoDocumentosFiscaisMFD:=GetProcAddress(HandleDLL, 'Elgin_MinutosEmitindoDocumentosFiscaisMFD');
            @Elgin_ContadoresTotalizadoresNaoFiscaisMFD:=GetProcAddress(HandleDLL, 'Elgin_ContadoresTotalizadoresNaoFiscaisMFD');
            @Elgin_VerificaTotalizadoresNaoFiscaisMFD:=GetProcAddress(HandleDLL, 'Elgin_VerificaTotalizadoresNaoFiscaisMFD');
            @Elgin_VerificaFormasPagamentoMFD:=GetProcAddress(HandleDLL, 'Elgin_VerificaFormasPagamentoMFD');
            @Elgin_VerificaRecebimentoNaoFiscalMFD:=GetProcAddress(HandleDLL, 'Elgin_VerificaRecebimentoNaoFiscalMFD');
            @Elgin_VerificaRelatorioGerencialMFD:=GetProcAddress(HandleDLL, 'Elgin_VerificaRelatorioGerencialMFD');
            @Elgin_ContadorComprovantesCreditoMFD:=GetProcAddress(HandleDLL, 'Elgin_ContadorComprovantesCreditoMFD');
            @Elgin_ContadorOperacoesNaoFiscaisCanceladasMFD:=GetProcAddress(HandleDLL, 'Elgin_ContadorOperacoesNaoFiscaisCanceladasMFD');
            @Elgin_ContadorRelatoriosGerenciaisMFD:=GetProcAddress(HandleDLL, 'Elgin_ContadorRelatoriosGerenciaisMFD');
            @Elgin_ContadorCupomFiscalMFD:=GetProcAddress(HandleDLL, 'Elgin_ContadorCupomFiscalMFD');
            @Elgin_ContadorFitaDetalheMFD:=GetProcAddress(HandleDLL, 'Elgin_ContadorFitaDetalheMFD');
            @Elgin_ComprovantesNaoFiscaisNaoEmitidosMFD:=GetProcAddress(HandleDLL, 'Elgin_ComprovantesNaoFiscaisNaoEmitidosMFD');
            @Elgin_NumeroSerieMemoriaMFD:=GetProcAddress(HandleDLL, 'Elgin_NumeroSerieMemoriaMFD');
            @Elgin_MarcaModeloTipoImpressoraMFD:=GetProcAddress(HandleDLL, 'Elgin_MarcaModeloTipoImpressoraMFD');
            @Elgin_DataHoraSoftwareBasico:=GetProcAddress(HandleDLL, 'Elgin_DataHoraSoftwareBasico');
            @Elgin_ReducoesRestantesMFD:=GetProcAddress(HandleDLL, 'Elgin_ReducoesRestantesMFD');
            @Elgin_VerificaTotalizadoresParciaisMFD:=GetProcAddress(HandleDLL, 'Elgin_VerificaTotalizadoresParciaisMFD');
            @Elgin_DadosUltimaReducaoMFD:=GetProcAddress(HandleDLL, 'Elgin_DadosUltimaReducaoMFD');
            @Elgin_LeituraMemoriaFiscalDataMFD:=GetProcAddress(HandleDLL, 'Elgin_LeituraMemoriaFiscalDataMFD');
            @Elgin_LeituraMemoriaFiscalReducaoMFD:=GetProcAddress(HandleDLL, 'Elgin_LeituraMemoriaFiscalReducaoMFD');
            @Elgin_LeituraMemoriaFiscalSerialDataMFD:=GetProcAddress(HandleDLL, 'Elgin_LeituraMemoriaFiscalSerialDataMFD');
            @Elgin_LeituraMemoriaFiscalSerialReducaoMFD:=GetProcAddress(HandleDLL, 'Elgin_LeituraMemoriaFiscalSerialReducaoMFD');
            @Elgin_LeituraChequeMFD:=GetProcAddress(HandleDLL, 'Elgin_LeituraChequeMFD');
            @Elgin_ImprimeChequeMFD:=GetProcAddress(HandleDLL, 'Elgin_ImprimeChequeMFD');
            @Elgin_HabilitaDesabilitaRetornoEstendidoMFD:=GetProcAddress(HandleDLL, 'Elgin_HabilitaDesabilitaRetornoEstendidoMFD');
            @Elgin_RetornoImpressoraMFD:=GetProcAddress(HandleDLL, 'Elgin_RetornoImpressoraMFD');
            @Elgin_AbreBilhetePassagemMFD:=GetProcAddress(HandleDLL, 'Elgin_AbreBilhetePassagemMFD');
            @Elgin_CancelaAcrescimoDescontoItemMFD:=GetProcAddress(HandleDLL, 'Elgin_CancelaAcrescimoDescontoItemMFD');
            @Elgin_SubTotalizaCupomMFD:=GetProcAddress(HandleDLL, 'Elgin_SubTotalizaCupomMFD');
            @Elgin_SubTotalizaRecebimentoMFD:=GetProcAddress(HandleDLL, 'Elgin_SubTotalizaRecebimentoMFD');
            @Elgin_TotalLivreMFD:=GetProcAddress(HandleDLL, 'Elgin_TotalLivreMFD');
            @Elgin_TamanhoTotalMFD:=GetProcAddress(HandleDLL, 'Elgin_TamanhoTotalMFD');
            @Elgin_AcrescimoDescontoSubtotalRecebimentoMFD:=GetProcAddress(HandleDLL, 'Elgin_AcrescimoDescontoSubtotalRecebimentoMFD');
            @Elgin_AcrescimoDescontoSubtotalMFD:=GetProcAddress(HandleDLL, 'Elgin_AcrescimoDescontoSubtotalMFD');
            @Elgin_CancelaAcrescimoDescontoSubtotalMFD:=GetProcAddress(HandleDLL, 'Elgin_CancelaAcrescimoDescontoSubtotalMFD');
            @Elgin_CancelaAcrescimoDescontoSubtotalRecebimentoMFD:=GetProcAddress(HandleDLL, 'Elgin_CancelaAcrescimoDescontoSubtotalRecebimentoMFD');
            @Elgin_TotalizaCupomMFD:=GetProcAddress(HandleDLL, 'Elgin_TotalizaCupomMFD');
            @Elgin_TotalizaRecebimentoMFD:=GetProcAddress(HandleDLL, 'Elgin_TotalizaRecebimentoMFD');
            @Elgin_PercentualLivreMFD:=GetProcAddress(HandleDLL, 'Elgin_PercentualLivreMFD');
            @Elgin_DataHoraUltimoDocumentoMFD:=GetProcAddress(HandleDLL, 'Elgin_DataHoraUltimoDocumentoMFD');
            @Elgin_MapaResumoMFD:=GetProcAddress(HandleDLL, 'Elgin_MapaResumoMFD');
            @Elgin_RelatorioTipo60AnaliticoMFD:=GetProcAddress(HandleDLL, 'Elgin_RelatorioTipo60AnaliticoMFD');
            @Elgin_ValorFormaPagamentoMFD:=GetProcAddress(HandleDLL, 'Elgin_ValorFormaPagamentoMFD');
            @Elgin_ValorTotalizadorNaoFiscalMFD:=GetProcAddress(HandleDLL, 'Elgin_ValorTotalizadorNaoFiscalMFD');
            @Elgin_VerificaEstadoImpressoraMFD:=GetProcAddress(HandleDLL, 'Elgin_VerificaEstadoImpressoraMFD');
            @Elgin_ProgramaIdAplicativoMFD:=GetProcAddress(HandleDLL, 'Elgin_ProgramaIdAplicativoMFD');
            // Funções para o TEF
            @Elgin_TEF_Status:=GetProcAddress(HandleDLL, 'Elgin_Status');
            @Elgin_TEF_VendaCartao:=GetProcAddress(HandleDLL, 'Elgin_VendaCartao');
            @Elgin_TEF_ConfirmaVenda:=GetProcAddress(HandleDLL, 'Elgin_ConfirmaVenda');
            @Elgin_TEF_NaoConfirmaVendaImpressao:=GetProcAddress(HandleDLL, 'Elgin_NaoConfirmaVendaImpressao');
            @Elgin_TEF_CancelaVendaCartao:=GetProcAddress(HandleDLL, 'Elgin_CancelaVendaCartao');
            @Elgin_TEF_ImprimeTEF:=GetProcAddress(HandleDLL, 'Elgin_ImprimeTEF');
            @Elgin_TEF_ImprimeRelatorio:=GetProcAddress(HandleDLL, 'Elgin_ImprimeRelatorio');
            @Elgin_TEF_ADM:=GetProcAddress(HandleDLL, 'Elgin_ADM');
            @Elgin_TEF_VendaCompleta:=GetProcAddress(HandleDLL, 'Elgin_VendaCompleta');
            @Elgin_TEF_ConfiguraDiretorioTef:=GetProcAddress(HandleDLL, 'Elgin_ConfiguraDiretorioTef');
            @Elgin_TEF_VendaCheque:=GetProcAddress(HandleDLL, 'Elgin_VendaCheque');
            @Elgin_TEF_ApagaResiduos:=GetProcAddress(HandleDLL, 'Elgin_ApagaResiduos');
            // Funções para a Balança
            @Elgin_InfoBalanca:=GetProcAddress(HandleDLL, 'Elgin_InfoBalanca');
            //PAF
            @Elgin_DownloadMFD:=GetProcAddress(HandleDLL, 'Elgin_DownloadMFD');

            { Fim da Declaração }
         end;

      SCFI:
         begin
            NomeDll := 'dll32phi.dll';
            HandleDLL := LoadLibrary(PChar(NomeDll));
            if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
            Result := true;
            @SCFI_ecfLeitMemFisc := GetProcAddress(HandleDLL, 'ecfLeitMemFisc');
            @SCFI_ChangePort := GetProcAddress(HandleDLL, 'ChangePort');
            @SCFI_ecfStatusCupom := GetProcAddress(HandleDLL, 'ecfStatusCupom');
            @SCFI_ecfLeituraXSerial := GetProcAddress(HandleDLL, 'ecfLeituraXSerial');
            @SCFI_ecfStatusImp := GetProcAddress(HandleDLL, 'ecfStatusImp');
            @SCFI_ecfAbreGaveta := GetProcAddress(HandleDLL, 'ecfAbreGaveta');
            @SCFI_dllActiveDebug := GetProcAddress(HandleDLL, 'dllActiveDebug');
            @SCFI_ecfReducaoZ := GetProcAddress(HandleDLL, 'ecfReducaoZ');
            @SCFI_ecfLineFeed := GetProcAddress(HandleDLL, 'ecfLineFeed');
            @SCFI_ecfLeituraX := GetProcAddress(HandleDLL, 'ecfLeituraX');
            @SCFI_ecfCancDoc := GetProcAddress(HandleDLL, 'ecfCancDoc');
            @SCFI_ecfInicCupomNFiscal := GetProcAddress(HandleDLL, 'ecfInicCupomNFiscal');
            @SCFI_ecfImpLinha := GetProcAddress(HandleDLL, 'ecfImpLinha');
            @SCFI_ecfFimTrans := GetProcAddress(HandleDLL, 'ecfFimTrans');
            @SCFI_ecfImpCab := GetProcAddress(HandleDLL, 'ecfImpCab');
            @SCFI_ecfCargaAliqSelect := GetProcAddress(HandleDLL, 'ecfCargaAliqSelect');
            @SCFI_ecfVenda_Item := GetProcAddress(HandleDLL, 'ecfVenda_Item');
            @SCFI_ecfVendaItem := GetProcAddress(HandleDLL, 'ecfVendaItem');
            @SCFI_ecfVendaItem78 := GetProcAddress(HandleDLL, 'ecfVendaItem78');
            @SCFI_ecfVendaItem3d := GetProcAddress(HandleDLL, 'ecfVendaItem3d');
            @SCFI_ecfDescItem := GetProcAddress(HandleDLL, 'ecfDescItem');
            @SCFI_ecfPagCancPag := GetProcAddress(HandleDLL, 'ecfPagCancPag');
            @SCFI_ecfCancItem := GetProcAddress(HandleDLL, 'ecfCancItem');
            @SCFI_ecfAcertaData := GetProcAddress(HandleDLL, 'ecfAcertaData');
            @SCFI_ecfCancVenda := GetProcAddress(HandleDLL, 'ecfCancVenda');
            @SCFI_ecfCancItemDef := GetProcAddress(HandleDLL, 'ecfCancItemDef');
            @SCFI_ecfSubTotal := GetProcAddress(HandleDLL, 'ecfSubTotal');
            @SCFI_ecfCancAcresDescSubTotal := GetProcAddress(HandleDLL, 'ecfCancAcresDescSubTotal');
            @SCFI_ecfAutentica := GetProcAddress(HandleDLL, 'ecfAutentica');
            @SCFI_ecfImpCheque := GetProcAddress(HandleDLL, 'ecfImpCheque');
            @SCFI_ecfImpChequeTPrint := GetProcAddress(HandleDLL, 'ecfImpChequeTPrint');
            @SCFI_ecfChequeDPrint300 := GetProcAddress(HandleDLL, 'ecfChequeDPrint300');
            @SCFI_ecfFimTransVinc := GetProcAddress(HandleDLL, 'ecfFimTransVinc');
            @SCFI_ecfRZGerencial := GetProcAddress(HandleDLL, 'ecfRZGerencial');
            @SCFI_ecfLXGerencial := GetProcAddress(HandleDLL, 'ecfLXGerencial');
            @SCFI_ecfProgNFComprov := GetProcAddress(HandleDLL, 'ecfProgNFComprov');
            @SCFI_ecfInicCNFVinculado := GetProcAddress(HandleDLL, 'ecfInicCNFVinculado');
            @SCFI_ecfPrazoCancPrazo := GetProcAddress(HandleDLL, 'ecfPrazoCancPrazo');
            @SCFI_ecfPagamento := GetProcAddress(HandleDLL, 'ecfPagamento');
            @SCFI_ecfPayPatterns := GetProcAddress(HandleDLL, 'ecfPayPatterns');
            @SCFI_ecfStatusDocsNFs := GetProcAddress(HandleDLL, 'ecfStatusDocsNFs');
            @SCFI_ecfStatusEquipo := GetProcAddress(HandleDLL, 'ecfStatusEquipo');
         end;
      Schalter3D:
         begin
            NomeDll := 'EFiscal6.dll';
            HandleDLL := LoadLibrary(PChar(NomeDll));
            if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
            Result := true;
            @Schalter3D_FimTransVinc := GetProcAddress(HandleDLL, 'ecfFimTransVinc');
            @Schalter3D_FimTrans := GetProcAddress(HandleDLL, 'ecfFimTrans');
            @Schalter3D_ProgNFComprov := GetProcAddress(HandleDLL, 'ecfProgNFComprov');
            @Schalter3D_StatusDocsNFs := GetProcAddress(HandleDLL, 'ecfStatusDocsNFs');
            @Schalter3D_InicCNFVinculado := GetProcAddress(HandleDLL, 'ecfInicCNFVinculado');
            @Schalter3D_PayPatterns := GetProcAddress(HandleDLL, 'ecfPayPatterns');
            @Schalter3D_ChangePort := GetProcAddress(HandleDLL, 'ChangePort');
            @Schalter3D_StatusEquipo := GetProcAddress(HandleDLL, 'ecfStatusEquipo');
            @Schalter3D_AbreGaveta := GetProcAddress(HandleDLL, 'ecfAbreGaveta');
            @Schalter3D_LeituraX := GetProcAddress(HandleDLL, 'ecfLeituraX');
            @Schalter3D_ReducaoZ := GetProcAddress(HandleDLL, 'ecfReducaoZ');
            @Schalter3D_CancDoc := GetProcAddress(HandleDLL, 'ecfCancDoc');
            @Schalter3D_CancVenda := GetProcAddress(HandleDLL, 'ecfCancVenda');
            @Schalter3D_LineFeed := GetProcAddress(HandleDLL, 'ecfLineFeed');
            @Schalter3D_ImpLinha := GetProcAddress(HandleDLL, 'ecfImpLinha');
            @Schalter3D_Autentica := GetProcAddress(HandleDLL, 'ecfAutentica');
            @Schalter3D_StatusImp := GetProcAddress(HandleDLL, 'ecfStatusImp');
            @Schalter3D_StatusCupom := GetProcAddress(HandleDLL, 'ecfStatusCupom');
            @Schalter3D_ImpCab := GetProcAddress(HandleDLL, 'ecfImpCab');
            @Schalter3D_InicCupomNFiscal := GetProcAddress(HandleDLL, 'ecfInicCupomNFiscal');
            @Schalter3D_Venda_Item := GetProcAddress(HandleDLL, 'ecfVendaItem3d');
            @Schalter3D_DescItem := GetProcAddress(HandleDLL, 'ecfDescItem');
            @Schalter3D_CancItem := GetProcAddress(HandleDLL, 'ecfCancItem');
            @Schalter3D_PagCancPag := GetProcAddress(HandleDLL, 'ecfPagCancPag');
            @Schalter3D_PrazoCancPrazo := GetProcAddress(HandleDLL, 'ecfPrazoCancPrazo');
            @Schalter3D_SubTotal := GetProcAddress(HandleDLL, 'ecfSubTotal');
            @Schalter3D_CancAcresDescSubTotal := GetProcAddress(HandleDLL, 'ecfCancAcresDescSubTotal');
            @Schalter3D_LeitMemFisc := GetProcAddress(HandleDLL, 'ecfLeitMemFisc');
            @Schalter3D_LeitXSer := GetProcAddress(HandleDLL, 'ecfLeitXSer');
            @Schalter3D_LeituraXSerial := GetProcAddress(HandleDLL, 'ecfLeituraXSerial');
            @Schalter3D_AcertaData := GetProcAddress(HandleDLL, 'ecfAcertaData');
            @Schalter3D_CancItemDef := GetProcAddress(HandleDLL, 'ecfCancItemDef');
            @Schalter3D_ImpCheque := GetProcAddress(HandleDLL, 'ecfImpCheque');
            @Schalter3D_ImpChequeTPrint := GetProcAddress(HandleDLL, 'ecfImpChequeTPrint');
            @Schalter3D_ChequeDPrint300 := GetProcAddress(HandleDLL, 'ecfChequeDPrint300');
            @Schalter3D_LXGerencial := GetProcAddress(HandleDLL, 'ecfLXGerencial');
            @Schalter3D_Pagamento := GetProcAddress(HandleDLL, 'ecfPagamento');
            @Schalter3D_ParamStatusEquipo := GetProcAddress(HandleDLL, 'ecfParamStatusEquipo');
         end;
      Urano1FIT:
         begin
            NomeDll := 'EFiscal7.dll';
            HandleDLL := LoadLibrary(PChar(NomeDll));
            if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
            Result := true;
            @Urano1FIT_InicializaDLL := GetProcAddress(HandleDLL, 'ecf_InicializaDLL');
            //
            @Urano1FIT_LeituraMF := GetProcAddress(HandleDLL, 'ecf_LeECF');
            @Urano1FIT_LogSerial := GetProcAddress(HandleDLL, 'ecf_LogSerial');
            @Urano1FIT_LeSensor := GetProcAddress(HandleDLL, 'ecf_LeSensor');
            @Urano1FIT_FinalizaDLL := GetProcAddress(HandleDLL, 'ecf_FinalizaDLL');
            @Urano1FIT_AvancaLinhas := GetProcAddress(HandleDLL, 'ecf_AvancaLinhas');
            @Urano1FIT_EstadoImpressora := GetProcAddress(HandleDLL, 'ecf_EstadoImpressora');
            @Urano1FIT_AbreGaveta := GetProcAddress(HandleDLL, 'ecf_AbreGaveta');
            @Urano1FIT_LeRegistradores := GetProcAddress(HandleDLL, 'ecf_LeRegistrador');
            @Urano1FIT_VendaItem := GetProcAddress(HandleDLL, 'ecf_VendaItem');
            @Urano1FIT_CancelaVenda := GetProcAddress(HandleDLL, 'ecf_CancelaVenda');
            @Urano1FIT_CancelaCupom := GetProcAddress(HandleDLL, 'ecf_CancelaCupom');
            @Urano1FIT_Relatorio_XZ := GetProcAddress(HandleDLL, 'ecf_Relatorio_XZ');
            @Urano1FIT_FechaCupom := GetProcAddress(HandleDLL, 'ecf_FechaCupom');
            @Urano1FIT_Pagamento := GetProcAddress(HandleDLL, 'ecf_Pagamento');
            @Urano1FIT_ImprimeCabecalho := GetProcAddress(HandleDLL, 'ecf_ImprimeCabecalho');
            @Urano1FIT_Propaganda := GetProcAddress(HandleDLL, 'ecf_Propaganda');
            @Urano1FIT_CargaCliche := GetProcAddress(HandleDLL, 'ecf_CargaCliche');
            @Urano1FIT_IdComprador := GetProcAddress(HandleDLL, 'ecf_IdComprador');
            @Urano1FIT_CargaAliquota := GetProcAddress(HandleDLL, 'ecf_CargaAliquota');
            @Urano1FIT_LeECF := GetProcAddress(HandleDLL, 'ecf_LeECF');
            @Urano1FIT_CancelaItem := GetProcAddress(HandleDLL, 'ecf_CancelaItem');
            @Urano1FIT_AcrescimoSubtotal := GetProcAddress(HandleDLL, 'ecf_AcrescimoSubtotal');
            @Urano1FIT_DescontoSubtotal := GetProcAddress(HandleDLL, 'ecf_DescontoSubtotal');
            @Urano1FIT_DescontoItem := GetProcAddress(HandleDLL, 'ecf_DescontoItem');
            @Urano1FIT_ProgramaRelogio := GetProcAddress(HandleDLL, 'ecf_ProgramaRelogio');
            @Urano1FIT_FormaPagamento := GetProcAddress(HandleDLL, 'ecf_FormaPagamento');
            @Urano1FIT_CargaNaoVinculado := GetProcAddress(HandleDLL, 'ecf_CargaNaoVinculado');
            @Urano1FIT_EspacamentoLinhas := GetProcAddress(HandleDLL, 'ecf_EspacamentoLinhas');
            @Urano1FIT_VinculadoTEF := GetProcAddress(HandleDLL, 'ecf_VinculadoTEF');
            @Urano1FIT_Autentica := GetProcAddress(HandleDLL, 'ecf_Autentica');
            @Urano1FIT_CupomStub := GetProcAddress(HandleDLL, 'ecf_CupomStub');
            @Urano1FIT_ImprimeCheque := GetProcAddress(HandleDLL, 'ecf_ImprimeCheque');
            @Urano1FIT_NovoEstabelecimento := GetProcAddress(HandleDLL, 'ecf_NovoEstabelecimento');
            @Urano1FIT_VinculadoCartao := GetProcAddress(HandleDLL, 'ecf_VinculadoCartao');
            @Urano1FIT_Mecanismo := GetProcAddress(HandleDLL, 'ecf_Mecanismo');
            @Urano1FIT_EmiteNaoVinculado := GetProcAddress(HandleDLL, 'ecf_EmiteNaoVinculado');
            @Urano1FIT_FinalizaRelatorio := GetProcAddress(HandleDLL, 'ecf_FinalizaRelatorio');
            @Urano1FIT_CortaPapel := GetProcAddress(HandleDLL, 'ecf_CortaPapel');
            @Urano1FIT_LinhasLivres := GetProcAddress(HandleDLL, 'ecf_LinhasLivres');
            @Urano1FIT_Vinculado := GetProcAddress(HandleDLL, 'ecf_Vinculado');
            @Urano1FIT_Rascunho := GetProcAddress(HandleDLL, 'ecf_Rascunho');
            @Urano1FIT_ContrasteTermico := GetProcAddress(HandleDLL, 'ecf_ContrasteTermico');
            @Urano1FIT_VinculadoNSeq := GetProcAddress(HandleDLL, 'ecf_VinculadoNSeq');
         end;
      Urano1EFC, Urano2EFC:
         begin
            NomeDll := 'EFiscal8.dll';
            HandleDLL := LoadLibrary(PChar(NomeDll));
            if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
            Result := true;
            @UranoEFC_InicializaDLL := GetProcAddress(HandleDLL, 'InicializaDLL');
            @UranoEFC_LeituraMF := GetProcAddress(HandleDLL, 'LeituraMF');
            @UranoEFC_FinalizaDLL := GetProcAddress(HandleDLL, 'FinalizaDLL');
            @UranoEFC_DescontoItem := GetProcAddress(HandleDLL, 'DescontoItem');
            @UranoEFC_EstadoImpressora := GetProcAddress(HandleDLL, 'EstadoImpressora');
            @UranoEFC_FormaPagamento := GetProcAddress(HandleDLL, 'FormaPagamento');
            @UranoEFC_ImprimeCabecalho := GetProcAddress(HandleDLL, 'ImprimeCabecalho');
            @UranoEFC_VendaItem := GetProcAddress(HandleDLL, 'VendaItem');
            @UranoEFC_CancelaItem := GetProcAddress(HandleDLL, 'CancelaItem');
            @UranoEFC_Pagamento := GetProcAddress(HandleDLL, 'Pagamento');
            @UranoEFC_EmiteVinculado := GetProcAddress(HandleDLL, 'EmiteVinculado');
            @UranoEFC_EmiteNaoVinculado := GetProcAddress(HandleDLL, 'EmiteNaoVinculado');
            @UranoEFC_FechaCupom := GetProcAddress(HandleDLL, 'FechaCupom');
            @UranoEFC_LinhasLivres := GetProcAddress(HandleDLL, 'LinhasLivres');
            @UranoEFC_CancelaVenda := GetProcAddress(HandleDLL, 'CancelaVenda');
            @UranoEFC_CancelaCupom := GetProcAddress(HandleDLL, 'CancelaCupom');
            @UranoEFC_DescontoSubtotal := GetProcAddress(HandleDLL, 'DescontoSubtotal');
            @UranoEFC_AcrescimoSubtotal := GetProcAddress(HandleDLL, 'AcrescimoSubtotal');
            @UranoEFC_Relatorio_XZ := GetProcAddress(HandleDLL, 'Relatorio_XZ');
            @UranoEFC_FinalizaRelatorio := GetProcAddress(HandleDLL, 'FinalizaRelatorio');
            @UranoEFC_propaganda := GetProcAddress(HandleDLL, 'Propaganda');
            @UranoEFC_ProgramaRelogio := GetProcAddress(HandleDLL, 'ProgramaRelogio');
            @UranoEFC_AbreGaveta := GetProcAddress(HandleDLL, 'AbreGaveta');
            @UranoEFC_AvancaLinhas := GetProcAddress(HandleDLL, 'AvancaLinhas');
            @UranoEFC_LeRegistradores := GetProcAddress(HandleDLL, 'LeRegistrador');
            @UranoEFC_Autentica := GetProcAddress(HandleDLL, 'Autentica');
            @UranoEFC_LeSensor := GetProcAddress(HandleDLL, 'LeSensor');
            @UranoEFC_IdComprador := GetProcAddress(HandleDLL, 'IdComprador');
            @UranoEFC_CupomStub := GetProcAddress(HandleDLL, 'CupomStub');
            @UranoEFC_SimboloMoeda := GetProcAddress(HandleDLL, 'SimboloMoeda');
            @UranoEFC_ConfiguraCabRodape := GetProcAddress(HandleDLL, 'ConfiguraCabRodape');
            @UranoEFC_VersaoBiblioteca := GetProcAddress(HandleDLL, 'VersaoBiblioteca');
            @UranoEFC_ImprimeCheque := GetProcAddress(HandleDLL, 'ImprimeCheque');
            @UranoEFC_EspacamentoLinhas := GetProcAddress(HandleDLL, 'Espacamento');
            @UranoEFC_ConfiguraDocFiscal := GetProcAddress(HandleDLL, 'ConfiguraDocFiscal');
            @UranoEFC_NomeMoeda := GetProcAddress(HandleDLL, 'NomeMoeda');
            @UranoEFC_HabVinculadoNSeq := GetProcAddress(HandleDLL, 'HabVinculadoNSeq');
            @UranoEFC_CargaNaoVinculado := GetProcAddress(HandleDLL, 'CargaNaoVinculado');
            @UranoEFC_NomeMoeda := GetProcAddress(HandleDLL, 'NomeMoeda');
         end;
      Schalter2S:
         begin
            NomeDll := 'EFiscal9.dll';
            HandleDLL := LoadLibrary(PChar(NomeDll));
            if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
            Result := true;
            @Schalter2S_ecfLeitMemFisc := GetProcAddress(HandleDLL, 'ecfLeitMemFisc');
            @Schalter2S_ChangePort := GetProcAddress(HandleDLL, 'ChangePort');
            @Schalter2S_ecfStatusCupom := GetProcAddress(HandleDLL, 'ecfStatusCupom');
            @Schalter2S_ecfLeituraXSerial := GetProcAddress(HandleDLL, 'ecfLeituraXSerial');
            @Schalter2S_ecfStatusImp := GetProcAddress(HandleDLL, 'ecfStatusImp');
            @Schalter2S_ecfAbreGaveta := GetProcAddress(HandleDLL, 'ecfAbreGaveta');
            @Schalter2S_ecfReducaoZ := GetProcAddress(HandleDLL, 'ecfReducaoZ');
            @Schalter2S_ecfLineFeed := GetProcAddress(HandleDLL, 'ecfLineFeed');
            @Schalter2S_ecfLeituraX := GetProcAddress(HandleDLL, 'ecfLeituraX');
            @Schalter2S_ecfCancDoc := GetProcAddress(HandleDLL, 'ecfCancDoc');
            @Schalter2S_ecfInicCupomNFiscal := GetProcAddress(HandleDLL, 'ecfInicCupomNFiscal');
            @Schalter2S_ecfImpLinha := GetProcAddress(HandleDLL, 'ecfImpLinha');
            @Schalter2S_ecfFimTrans := GetProcAddress(HandleDLL, 'ecfFimTrans');
            @Schalter2S_ecfImpCab := GetProcAddress(HandleDLL, 'ecfImpCab');
            @Schalter2S_ecfVenda_Item := GetProcAddress(HandleDLL, 'ecfVendaItem');
            @Schalter2S_ecfVendaItem := GetProcAddress(HandleDLL, 'ecfVendaItem');
            @Schalter2S_ecfDescItem := GetProcAddress(HandleDLL, 'ecfDescItem');
            @Schalter2S_ecfPagCancPag := GetProcAddress(HandleDLL, 'ecfPagCancPag');
            @Schalter2S_ecfCancItem := GetProcAddress(HandleDLL, 'ecfCancItem');
            @Schalter2S_ecfAcertaData := GetProcAddress(HandleDLL, 'ecfAcertaData');
            @Schalter2S_ecfCancVenda := GetProcAddress(HandleDLL, 'ecfCancVenda');
            @Schalter2S_ecfCancItemDef := GetProcAddress(HandleDLL, 'ecfCancItemDef');
            @Schalter2S_ecfSubTotal := GetProcAddress(HandleDLL, 'ecfSubTotal');
            @Schalter2S_ecfCancAcresDescSubTotal := GetProcAddress(HandleDLL, 'ecfCancAcresDescSubTotal');
            @Schalter2S_ecfAutentica := GetProcAddress(HandleDLL, 'ecfAutentica');
         end;
      Dataregis:
         begin
            NomeDll := 'EFiscal10.dll';
            HandleDLL := LoadLibrary(PChar(NomeDll));
            if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
            Result := true;
            Dataregis_AbrePorta := GetProcAddress(HandleDLL, 'DTR_AbrePorta');
            Dataregis_FechaPorta := GetProcAddress(HandleDLL, 'DTR_FechaPorta');
            Dataregis_EnviaComando := GetProcAddress(HandleDLL, 'DTR_EnviaComando');
         end;
      Procomp_2011:
         begin
            NomeDll := 'EFiscal11.dll';
            HandleDLL := LoadLibrary(PChar(NomeDll));
            if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
            Result := true;
            @Procomp_DescontoItem := GetProcAddress(HandleDLL, 'DESCONTOITEM');
            @Procomp_OpenCIF := GetProcAddress(HandleDLL, 'OPENCIF');
            @Procomp_CloseCIF := GetProcAddress(HandleDLL, 'CLOSECIF');
            @Procomp_AbreCupomFiscal := GetProcAddress(HandleDLL, 'ABRECUPOMFISCAL');
            @Procomp_AbreCupomVinculado := GetProcAddress(HandleDLL, 'ABRECUPOMVINCULADO');
            @Procomp_VendaItem := GetProcAddress(HandleDLL, 'VENDAITEM');
            @Procomp_CancelamentoItem := GetProcAddress(HandleDLL, 'CANCELAMENTOITEM');
            @Procomp_ObtemRetorno := GetProcAddress(HandleDLL, 'OBTEMRETORNO');
            @Procomp_TotalizarCupom := GetProcAddress(HandleDLL, 'TOTALIZARCUPOM');
            @Procomp_Pagamento := GetProcAddress(HandleDLL, 'PAGAMENTO');
            @Procomp_FechaCupomFiscal := GetProcAddress(HandleDLL, 'FECHACUPOMFISCAL');
            @Procomp_CancelaCupomFiscal := GetProcAddress(HandleDLL, 'CANCELACUPOMFISCAL');
            @Procomp_LeituraX := GetProcAddress(HandleDLL, 'LEITURAX');
            @Procomp_ReducaoZ := GetProcAddress(HandleDLL, 'REDUCAOZ');
            @Procomp_LeMemFiscalData := GetProcAddress(HandleDLL, 'LEMEMFISCALDATA');
            @Procomp_LeMemFiscalReducao := GetProcAddress(HandleDLL, 'LEMEMFISCALREDUCAO');
            @Procomp_AbreCupomNaoVinculado := GetProcAddress(HandleDLL, 'ABRECUPOMNAOVINCULADO');
            @Procomp_EncerrarCupom := GetProcAddress(HandleDLL, 'ENCERRARCUPOM');
            @Procomp_ImprimeLinhaNaoFiscal := GetProcAddress(HandleDLL, 'IMPRIMELINHANAOFISCAL');
            @Procomp_TransStatus := GetProcAddress(HandleDLL, 'TRANSSTATUS');
            @Procomp_ECFPar := GetProcAddress(HandleDLL, 'ECFPAR');
            @Procomp_ECFParEsp := GetProcAddress(HandleDLL, 'ECFPARESP');
            @Procomp_ECFID := GetProcAddress(HandleDLL, 'ECFID');
            @Procomp_TransTabAliquotas := GetProcAddress(HandleDLL, 'TRANSTABALIQUOTAS');
            @Procomp_AbrirGaveta := GetProcAddress(HandleDLL, 'ABRIRGAVETA');
            @Procomp_ProgramaHorarioVerao := GetProcAddress(HandleDLL, 'PROGRAMAHORARIOVERAO');
            @Procomp_AvancaLinha := GetProcAddress(HandleDLL, 'AVANCALINHA');
            @Procomp_ProgLinhaAdicional := GetProcAddress(HandleDLL, 'PROGLINHAADICIONAL');
            @Procomp_ModoChequeValidacao := GetProcAddress(HandleDLL, 'MODOCHEQUEVALIDACAO');
            @Procomp_ImprimeValidacao := GetProcAddress(HandleDLL, 'IMPRIMEVALIDACAO');
            @Procomp_TransDataHora := GetProcAddress(HandleDLL, 'TRANSDATAHORA');
         end;
      Trends10E:
         begin
            NomeDll := 'EFiscal12.dll';
            HandleDLL := LoadLibrary(PChar(NomeDll));
            if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
            Result := true;
            @Trends_ModoChequeValidacao := GetProcAddress(HandleDLL, 'ModoChequeValidacao');
            @Trends_ImprimeCheque := GetProcAddress(HandleDLL, 'ImprimeCheque');
            @Trends_ImprimeValidacao := GetProcAddress(HandleDLL, 'ImprimeValidacao');
            @Trends_CancelaChequeValidacao := GetProcAddress(HandleDLL, 'CancelaChequeValidacao');
            @Trends_TotalizarCupomParcial := GetProcAddress(HandleDLL, 'TotalizarCupomParcial');
            @Trends_TotalizarCupom := GetProcAddress(HandleDLL, 'TotalizarCupom');
            @Trends_Pagamento := GetProcAddress(HandleDLL, 'Pagamento');
            @Trends_FechaCupomFiscal := GetProcAddress(HandleDLL, 'FechaCupomFiscal');
            @Trends_DescontoItem := GetProcAddress(HandleDLL, 'DescontoItem');
            @Trends_AbreCupomFiscal := GetProcAddress(HandleDLL, 'AbreCupomFiscal');
            @Trends_VendaItem := GetProcAddress(HandleDLL, 'VendaItem');
            @Trends_CancelamentoItem := GetProcAddress(HandleDLL, 'CancelamentoItem');
            @Trends_CancelaCupomFiscal := GetProcAddress(HandleDLL, 'CancelaCupomFiscal');
            @Trends_LeituraX := GetProcAddress(HandleDLL, 'LeituraX');
            @Trends_ReducaoZ := GetProcAddress(HandleDLL, 'ReducaoZ');
            @Trends_LeMemFiscalData := GetProcAddress(HandleDLL, 'LeMemFiscalData');
            @Trends_LeMemFiscalReducao := GetProcAddress(HandleDLL, 'LeMemFiscalReducao');
            @Trends_AbreCupomVinculado := GetProcAddress(HandleDLL, 'AbreCupomVinculado');
            @Trends_EncerraCupomNaoFiscal := GetProcAddress(HandleDLL, 'EncerraCupomNaoFiscal');
            @Trends_AbreCupomNaoVinculado := GetProcAddress(HandleDLL, 'AbreCupomNaoVinculado');
            @Trends_OperRegNaoVinculado := GetProcAddress(HandleDLL, 'OperRegNaoVinculado');
            @Trends_CancelaCupomNaoFiscal := GetProcAddress(HandleDLL, 'CancelaCupomNaoFiscal');
            @Trends_ImprimeLinhaNaoFiscal := GetProcAddress(HandleDLL, 'ImprimeLinhaNaoFiscal');
            @Trends_ProgramaLegenda := GetProcAddress(HandleDLL, 'ProgramaLegenda');
            @Trends_AbrirGaveta := GetProcAddress(HandleDLL, 'AbrirGaveta');
            @Trends_ProgramaHorarioVerao := GetProcAddress(HandleDLL, 'ProgramaHorarioVerao');
            @Trends_ImprimeTotalizadores := GetProcAddress(HandleDLL, 'ImprimeTotalizadores');
            @Trends_TransTabAliquotas := GetProcAddress(HandleDLL, 'TransTabAliquotas');
            @Trends_TransTotCont := GetProcAddress(HandleDLL, 'TransTotCont');
            @Trends_TransStatusDecod := GetProcAddress(HandleDLL, 'TransStatusDecod');
            @Trends_TransDataHora := GetProcAddress(HandleDLL, 'TransDataHora');
            @Trends_EcfPar := GetProcAddress(HandleDLL, 'EcfPar');
            @Trends_ProgLinhaAdicional := GetProcAddress(HandleDLL, 'ProgLinhaAdicional');
            @Trends_AjusteHora := GetProcAddress(HandleDLL, 'AjusteHora');
            @Trends_EcfID := GetProcAddress(HandleDLL, 'EcfID');
            @Trends_ProgRelogio := GetProcAddress(HandleDLL, 'ProgRelogio');
            @Trends_GravaDados := GetProcAddress(HandleDLL, 'GravaDados');
            @Trends_RecompoeDadosNOVRAM := GetProcAddress(HandleDLL, 'RecompoeDadosNOVRAM');
            @Trends_ProgNumSerie := GetProcAddress(HandleDLL, 'ProgNumSerie');
            @Trends_ProgAliquotas := GetProcAddress(HandleDLL, 'ProgAliquotas');
            @Trends_ProgSimbolo := GetProcAddress(HandleDLL, 'ProgSimbolo');
            @Trends_ProgRazaoSocial := GetProcAddress(HandleDLL, 'ProgRazaoSocial');
            @Trends_ProgMoeda := GetProcAddress(HandleDLL, 'ProgMoeda');
            @Trends_ProgArredondamento := GetProcAddress(HandleDLL, 'ProgArredondamento');
         end;
      AFRAC:
        begin
          NomeDll := 'ecfafrac.dll';
          HandleDLL := LoadLibrary(PChar(NomeDll));
          if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
          Result := true;

          @AFRAC_AbrirCupom                         := GetProcAddress(HandleDLL, 'AFRAC_AbrirCupom');
          @AFRAC_VenderItem                         := GetProcAddress(HandleDLL, 'AFRAC_VenderItem');
          @AFRAC_AcrescimoDescontoItem              := GetProcAddress(HandleDLL, 'AFRAC_AcrescimoDescontoItem');
          @AFRAC_CancelarItem                       := GetProcAddress(HandleDLL, 'AFRAC_CancelarItem');
          @AFRAC_AcrescimoDescontoCupom             := GetProcAddress(HandleDLL, 'AFRAC_AcrescimoDescontoCupom');
          @AFRAC_FecharAcrescimoDesconto            := GetProcAddress(HandleDLL, 'AFRAC_FecharAcrescimoDesconto');
          @AFRAC_FormaPagamento                     := GetProcAddress(HandleDLL, 'AFRAC_FormaPagamento');
          @AFRAC_InformarCNPJ                       := GetProcAddress(HandleDLL, 'AFRAC_InformarCNPJ');
          @AFRAC_InformarRazaoSocial                := GetProcAddress(HandleDLL, 'AFRAC_InformarRazaoSocial');
          @AFRAC_InformarInscricao                  := GetProcAddress(HandleDLL, 'AFRAC_InformarInscricao');
          @AFRAC_InformarEndereco                   := GetProcAddress(HandleDLL, 'AFRAC_InformarEndereco');
          @AFRAC_InformarGerente                    := GetProcAddress(HandleDLL, 'AFRAC_InformarGerente');
          @AFRAC_InformarOperador                   := GetProcAddress(HandleDLL, 'AFRAC_InformarOperador');
          @AFRAC_InformarVendedor                   := GetProcAddress(HandleDLL, 'AFRAC_InformarVendedor');
          @AFRAC_InformarMensagemCupom              := GetProcAddress(HandleDLL, 'AFRAC_InformarMensagemCupom');
          @AFRAC_FecharCupom                        := GetProcAddress(HandleDLL, 'AFRAC_FecharCupom');
          @AFRAC_CancelarCupom                      := GetProcAddress(HandleDLL, 'AFRAC_CancelarCupom');


          (* Funcoes de Configuração e Relatórios AFRAC *)

          @AFRAC_AbrirVinculado                     := GetProcAddress(HandleDLL, 'AFRAC_AbrirVinculado');
          @AFRAC_ImprimirVinculado                  := GetProcAddress(HandleDLL, 'AFRAC_ImprimirVinculado');
          @AFRAC_FecharVinculado                    := GetProcAddress(HandleDLL, 'AFRAC_FecharVinculado');
          @AFRAC_CancelarVinculado                  := GetProcAddress(HandleDLL, 'AFRAC_CancelarVinculado');
          @AFRAC_AbrirNaoFiscalNaoVinculado         := GetProcAddress(HandleDLL, 'AFRAC_AbrirNaoFiscalNaoVinculado');
          @AFRAC_RegistrarNaoFiscal                 := GetProcAddress(HandleDLL, 'AFRAC_RegistrarNaoFiscal');
          @AFRAC_CancelarNaoVinculado               := GetProcAddress(HandleDLL, 'AFRAC_CancelarNaoVinculado');
          @AFRAC_AbrirRelatorioGerencial            := GetProcAddress(HandleDLL, 'AFRAC_AbrirRelatorioGerencial');
          @AFRAC_ImprimirRelatorioGerencial         := GetProcAddress(HandleDLL, 'AFRAC_ImprimirRelatorioGerencial');
          @AFRAC_FecharRelatorioGerencial           := GetProcAddress(HandleDLL, 'AFRAC_FecharRelatorioGerencial');
          @AFRAC_LeituraX                           := GetProcAddress(HandleDLL, 'AFRAC_LeituraX');
          @AFRAC_ReducaoZ                           := GetProcAddress(HandleDLL, 'AFRAC_ReducaoZ');
          @AFRAC_EmitirLeituraMemoriaFiscal         := GetProcAddress(HandleDLL, 'AFRAC_EmitirLeituraMemoriaFiscal');
          @AFRAC_GravarLeituraX                     := GetProcAddress(HandleDLL, 'AFRAC_GravarLeituraX');
          @AFRAC_GravarLeituraMemoriaFiscal         := GetProcAddress(HandleDLL, 'AFRAC_GravarLeituraMemoriaFiscal');


          (* Funcoes de Status e Informações AFRAC *)

          @AFRAC_LerInformacaoImpressora            := GetProcAddress(HandleDLL, 'AFRAC_LerInformacaoImpressora');
          @AFRAC_LerAliquotas                       := GetProcAddress(HandleDLL, 'AFRAC_LerAliquotas');
          @AFRAC_LerValorTotalAliquotas             := GetProcAddress(HandleDLL, 'AFRAC_LerValorTotalAliquotas');
          @AFRAC_LerTotalizadoresNSICMS             := GetProcAddress(HandleDLL, 'AFRAC_LerTotalizadoresNSICMS');
          @AFRAC_LerTodasFormasPagamento            := GetProcAddress(HandleDLL, 'AFRAC_LerTodasFormasPagamento');
          @AFRAC_AbrirPorta                         := GetProcAddress(HandleDLL, 'AFRAC_AbrirPorta');
          @AFRAC_FecharPorta                        := GetProcAddress(HandleDLL, 'AFRAC_FecharPorta');
          @AFRAC_VerificarEstado                    := GetProcAddress(HandleDLL, 'AFRAC_VerificarEstado');
          @AFRAC_Retornar_Features                  := GetProcAddress(HandleDLL, 'AFRAC_Retornar_Features');
          @AFRAC_PegarCodigoErro                    := GetProcAddress(HandleDLL, 'AFRAC_PegarCodigoErro');
          @AFRAC_ConfigurarFonte                    := GetProcAddress(HandleDLL, 'AFRAC_ConfigurarFonte');
          @AFRAC_InformarFonte                      := GetProcAddress(HandleDLL, 'AFRAC_InformarFonte');
          @AFRAC_Configura                          := GetProcAddress(HandleDLL, 'AFRAC_Configura');
          @AFRAC_Indice                             := GetProcAddress(HandleDLL, 'AFRAC_Indice');
          @AFRAC_Fabricante                         := GetProcAddress(HandleDLL, 'AFRAC_Fabricante');


          (* Funcoes Auxiliares AFRAC *)

          @AFRAC_Autenticar                         := GetProcAddress(HandleDLL, 'AFRAC_Autenticar');
          @AFRAC_RepetirAutenticacao                := GetProcAddress(HandleDLL, 'AFRAC_RepetirAutenticacao');
          @AFRAC_AbrirGaveta                        := GetProcAddress(HandleDLL, 'AFRAC_AbrirGaveta');
          @AFRAC_VerificarGaveta                    := GetProcAddress(HandleDLL, 'AFRAC_VerificarGaveta');
          @AFRAC_ChequeProgramarMoeda               := GetProcAddress(HandleDLL, 'AFRAC_ChequeProgramarMoeda');
          @AFRAC_ChequeImprimir                     := GetProcAddress(HandleDLL, 'AFRAC_ChequeImprimir');
          @AFRAC_ChequeConfigurarFormatacao         := GetProcAddress(HandleDLL, 'AFRAC_ChequeConfigurarFormatacao');
          @AFRAC_ChequeImprimirVerso                := GetProcAddress(HandleDLL, 'AFRAC_ChequeImprimirVerso');
          @AFRAC_ChequeLerCMC7                      := GetProcAddress(HandleDLL, 'AFRAC_ChequeLerCMC7');
          @AFRAC_ChequeExpulsar                     := GetProcAddress(HandleDLL, 'AFRAC_ChequeExpulsar');
          @AFRAC_ProgramarTributacao                := GetProcAddress(HandleDLL, 'AFRAC_ProgramarTributacao');
          @AFRAC_EntrarHorarioVerao                 := GetProcAddress(HandleDLL, 'AFRAC_EntrarHorarioVerao');
          @AFRAC_SairHorarioVerao                   := GetProcAddress(HandleDLL, 'AFRAC_SairHorarioVerao');
          @AFRAC_AjustarRelogio                     := GetProcAddress(HandleDLL, 'AFRAC_AjustarRelogio');
          @AFRAC_ArredondarTruncar                  := GetProcAddress(HandleDLL, 'AFRAC_ArredondarTruncar');
          @AFRAC_ForcarImpactoAgulhas               := GetProcAddress(HandleDLL, 'AFRAC_ForcarImpactoAgulhas');
          @AFRAC_ConfigurarLinhasEntreCupons        := GetProcAddress(HandleDLL, 'AFRAC_ConfigurarLinhasEntreCupons');
          @AFRAC_ProgramarTotalizadorNaoSujeitoICMS := GetProcAddress(HandleDLL, 'AFRAC_ProgramarTotalizadorNaoSujeitoICMS');
          @AFRAC_ProgramarRelatorioGerencial        := GetProcAddress(HandleDLL, 'AFRAC_ProgramarRelatorioGerencial');
          @AFRAC_LerIndiceRelatorioGerencial        := GetProcAddress(HandleDLL, 'AFRAC_LerIndiceRelatorioGerencial');
          @AFRAC_ProgramarFormasDePagamento         := GetProcAddress(HandleDLL, 'AFRAC_ProgramarFormasDePagamento');
          @AFRAC_LerFormasDePagamento                := GetProcAddress(HandleDLL, 'AFRAC_LerFormasDePagamento');
          @AFRAC_SetaPadrao                         := GetProcAddress(HandleDLL, 'AFRAC_SetaPadrao');
          @AFRAC_AbrirDia                           := GetProcAddress(HandleDLL, 'AFRAC_AbrirDia');
        end;
      DarumaMatr, DarumaTerm:
        begin
          NomeDll := 'Daruma32.dll';
          HandleDLL := LoadLibrary(PChar(NomeDll));
          if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
          Result := true;

          @Daruma_FI_AbreCupom := GetProcAddress(HandleDLL, 'Daruma_FI_AbreCupom');
          @Daruma_FI_VendeItem := GetProcAddress(HandleDLL, 'Daruma_FI_VendeItem');
          @Daruma_FI_VendeItemDepartamento := GetProcAddress(HandleDLL, 'Daruma_FI_VendeItemDepartamento');
          @Daruma_FI_VendeItemTresDecimais := GetProcAddress(HandleDLL, 'Daruma_FI_VendeItemTresDecimais');
          @Daruma_FI_FechaCupomResumido := GetProcAddress(HandleDLL, 'Daruma_FI_FechaCupomResumido');
          @Daruma_FI_IniciaFechamentoCupom := GetProcAddress(HandleDLL, 'Daruma_FI_IniciaFechamentoCupom');
          @Daruma_FI_EfetuaFormaPagamento := GetProcAddress(HandleDLL, 'Daruma_FI_EfetuaFormaPagamento');
          @Daruma_FI_EfetuaFormaPagamentoDescricaoForma := GetProcAddress(HandleDLL, 'Daruma_FI_EfetuaFormaPagamentoDescricaoForma');
          @Daruma_FI_IdentificaConsumidor := GetProcAddress(HandleDLL, 'Daruma_FI_IdentificaConsumidor');
          @Daruma_FI_TerminaFechamentoCupom := GetProcAddress(HandleDLL, 'Daruma_FI_TerminaFechamentoCupom');
          @Daruma_FI_FechaCupom := GetProcAddress(HandleDLL, 'Daruma_FI_FechaCupom');
          @Daruma_FI_CancelaItemAnterior := GetProcAddress(HandleDLL, 'Daruma_FI_CancelaItemAnterior');
          @Daruma_FI_CancelaItemGenerico := GetProcAddress(HandleDLL, 'Daruma_FI_CancelaItemGenerico');
          @Daruma_FI_CancelaCupom := GetProcAddress(HandleDLL, 'Daruma_FI_CancelaCupom');
          @Daruma_FI_AumentaDescricaoItem := GetProcAddress(HandleDLL, 'Daruma_FI_AumentaDescricaoItem');
          @Daruma_FI_UsaUnidadeMedida := GetProcAddress(HandleDLL, 'Daruma_FI_UsaUnidadeMedida');
          @Daruma_FI_EmitirCupomAdicional := GetProcAddress(HandleDLL, 'Daruma_FI_EmitirCupomAdicional');
          @Daruma_FI_EstornoFormasPagamento := GetProcAddress(HandleDLL, 'Daruma_FI_EstornoFormasPagamento');
          @Daruma_FI_AbreComprovanteNaoFiscalVinculado := GetProcAddress(HandleDLL, 'Daruma_FI_AbreComprovanteNaoFiscalVinculado');
          @Daruma_FI_UsaComprovanteNaoFiscalVinculado := GetProcAddress(HandleDLL, 'Daruma_FI_UsaComprovanteNaoFiscalVinculado');
          @Daruma_FI_FechaComprovanteNaoFiscalVinculado := GetProcAddress(HandleDLL, 'Daruma_FI_FechaComprovanteNaoFiscalVinculado');
          @Daruma_FI_RelatorioGerencial := GetProcAddress(HandleDLL, 'Daruma_FI_RelatorioGerencial');
          @Daruma_FI_AbreRelatorioGerencial := GetProcAddress(HandleDLL, 'Daruma_FI_AbreRelatorioGerencial');
          @Daruma_FI_EnviarTextoCNF := GetProcAddress(HandleDLL, 'Daruma_FI_EnviarTextoCNF');
          @Daruma_FI_FechaRelatorioGerencial := GetProcAddress(HandleDLL, 'Daruma_FI_FechaRelatorioGerencial');
          @Daruma_FI_RecebimentoNaoFiscal := GetProcAddress(HandleDLL, 'Daruma_FI_RecebimentoNaoFiscal');
          @Daruma_FI_AbreRecebimentoNaoFiscal := GetProcAddress(HandleDLL, 'Daruma_FI_AbreRecebimentoNaoFiscal');
          @Daruma_FI_EfetuaFormaPagamentoNaoFiscal := GetProcAddress(HandleDLL, 'Daruma_FI_EfetuaFormaPagamentoNaoFiscal');
          @Daruma_FI_Sangria := GetProcAddress(HandleDLL, 'Daruma_FI_Sangria');
          @Daruma_FI_Suprimento := GetProcAddress(HandleDLL, 'Daruma_FI_Suprimento');
          @Daruma_FI_FundoCaixa := GetProcAddress(HandleDLL, 'Daruma_FI_FundoCaixa');
          @Daruma_FI_LeituraX := GetProcAddress(HandleDLL, 'Daruma_FI_LeituraX');
          @Daruma_FI_ReducaoZ := GetProcAddress(HandleDLL, 'Daruma_FI_ReducaoZ');
          @Daruma_FI_ReducaoZAjustaDataHora := GetProcAddress(HandleDLL, 'Daruma_FI_ReducaoZAjustaDataHora');
          @Daruma_FI_LeituraMemoriaFiscalData := GetProcAddress(HandleDLL, 'Daruma_FI_LeituraMemoriaFiscalData');
          @Daruma_FI_LeituraMemoriaFiscalReducao := GetProcAddress(HandleDLL, 'Daruma_FI_LeituraMemoriaFiscalReducao');
          @Daruma_FI_LeituraMemoriaFiscalSerialData := GetProcAddress(HandleDLL, 'Daruma_FI_LeituraMemoriaFiscalSerialData');
          @Daruma_FI_LeituraMemoriaFiscalSerialReducao := GetProcAddress(HandleDLL, 'Daruma_FI_LeituraMemoriaFiscalSerialReducao');
          @Daruma_FI_VerificaDocAutenticacao := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaDocAutenticacao');
          @Daruma_FI_Autenticacao := GetProcAddress(HandleDLL, 'Daruma_FI_Autenticacao');
          @Daruma_FI_AutenticacaoStr := GetProcAddress(HandleDLL, 'Daruma_FI_AutenticacaoStr');
          @Daruma_FI_VerificaEstadoGaveta := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaEstadoGaveta');
          @Daruma_FI_VerificaEstadoGavetaStr := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaEstadoGavetaStr');
          @Daruma_FI_AcionaGaveta := GetProcAddress(HandleDLL, 'Daruma_FI_AcionaGaveta');
          @Daruma_FI_AbrePortaSerial := GetProcAddress(HandleDLL, 'Daruma_FI_AbrePortaSerial');
          @Daruma_FI_FechaPortaSerial := GetProcAddress(HandleDLL, 'Daruma_FI_FechaPortaSerial');
          @Daruma_FI_AberturaDoDia := GetProcAddress(HandleDLL, 'Daruma_FI_AberturaDoDia');
          @Daruma_FI_FechamentoDoDia := GetProcAddress(HandleDLL, 'Daruma_FI_FechamentoDoDia');
          @Daruma_FI_ImprimeConfiguracoesImpressora := GetProcAddress(HandleDLL, 'Daruma_FI_ImprimeConfiguracoesImpressora');
          @Daruma_FI_ProgramaAliquota := GetProcAddress(HandleDLL, 'Daruma_FI_ProgramaAliquota');
          @Daruma_FI_NomeiaTotalizadorNaoSujeitoIcms := GetProcAddress(HandleDLL, 'Daruma_FI_NomeiaTotalizadorNaoSujeitoIcms');
          @Daruma_FI_ProgramaFormasPagamento := GetProcAddress(HandleDLL, 'Daruma_FI_ProgramaFormasPagamento');
          @Daruma_FI_ProgramaOperador := GetProcAddress(HandleDLL, 'Daruma_FI_ProgramaOperador');
          @Daruma_FI_ProgramaArredondamento := GetProcAddress(HandleDLL, 'Daruma_FI_ProgramaArredondamento');
          @Daruma_FI_ProgramaTruncamento := GetProcAddress(HandleDLL, 'Daruma_FI_ProgramaTruncamento');
          @Daruma_FI_LinhasEntreCupons := GetProcAddress(HandleDLL, 'Daruma_FI_LinhasEntreCupons');
          @Daruma_FI_EspacoEntreLinhas := GetProcAddress(HandleDLL, 'Daruma_FI_EspacoEntreLinhas');
          @Daruma_FI_ProgramaHorarioVerao := GetProcAddress(HandleDLL, 'Daruma_FI_ProgramaHorarioVerao');
          @Daruma_FI_EqualizaFormasPgto := GetProcAddress(HandleDLL, 'Daruma_FI_EqualizaFormasPgto');
          @Daruma_FI_ProgramaVinculados := GetProcAddress(HandleDLL, 'Daruma_FI_ProgramaVinculados');
          @Daruma_FI_ProgFormasPagtoSemVincular := GetProcAddress(HandleDLL, 'Daruma_FI_ProgFormasPagtoSemVincular');
          @Daruma_FI_CfgFechaAutomaticoCupom := GetProcAddress(HandleDLL, 'Daruma_FI_CfgFechaAutomaticoCupom');
          @Daruma_FI_CfgRedZAutomatico := GetProcAddress(HandleDLL, 'Daruma_FI_CfgRedZAutomatico');
          @Daruma_FI_CfgImpEstGavVendas := GetProcAddress(HandleDLL, 'Daruma_FI_CfgImpEstGavVendas');
          @Daruma_FI_CfgLeituraXAuto := GetProcAddress(HandleDLL, 'Daruma_FI_CfgLeituraXAuto');
          @Daruma_FI_CfgCalcArredondamento := GetProcAddress(HandleDLL, 'Daruma_FI_CfgCalcArredondamento');
          @Daruma_FI_CfgHorarioVerao := GetProcAddress(HandleDLL, 'Daruma_FI_CfgHorarioVerao');
          @Daruma_FI_CfgSensorAut := GetProcAddress(HandleDLL, 'Daruma_FI_CfgSensorAut');
          @Daruma_FI_CfgCupomAdicional := GetProcAddress(HandleDLL, 'Daruma_FI_CfgCupomAdicional');
          @Daruma_FI_CfgPermMensPromCNF := GetProcAddress(HandleDLL, 'Daruma_FI_CfgPermMensPromCNF');
          @Daruma_FI_CfgEspacamentoCupons := GetProcAddress(HandleDLL, 'Daruma_FI_CfgEspacamentoCupons');
          @Daruma_FI_CfgHoraMinReducaoZ := GetProcAddress(HandleDLL, 'Daruma_FI_CfgHoraMinReducaoZ');
          @Daruma_FI_CfgLimiarNearEnd := GetProcAddress(HandleDLL, 'Daruma_FI_CfgLimiarNearEnd');
          @Daruma_Registry_AlteraRegistry := GetProcAddress(HandleDLL, 'Daruma_Registry_AlteraRegistry');
          @Daruma_Registry_Porta := GetProcAddress(HandleDLL, 'Daruma_Registry_Porta');
          @Daruma_Registry_MFD_LeituraMFCompleta := GetProcAddress(HandleDLL, 'Daruma_Registry_MFD_LeituraMFCompleta');
          @Daruma_FIMFD_DownloadDaMFD := GetProcAddress(HandleDLL, 'Daruma_FIMFD_DownloadDaMFD');
          @Daruma_Registry_Path := GetProcAddress(HandleDLL, 'Daruma_Registry_Path');
          @Daruma_Registry_Status := GetProcAddress(HandleDLL, 'Daruma_Registry_Status');
          @Daruma_Registry_StatusFuncao := GetProcAddress(HandleDLL, 'Daruma_Registry_StatusFuncao');
          @Daruma_Registry_Retorno := GetProcAddress(HandleDLL, 'Daruma_Registry_Retorno');
          @Daruma_Registry_ControlePorta := GetProcAddress(HandleDLL, 'Daruma_Registry_ControlePorta');
          @Daruma_Registry_ModoGaveta := GetProcAddress(HandleDLL, 'Daruma_Registry_ModoGaveta');
          @Daruma_Registry_Log := GetProcAddress(HandleDLL, 'Daruma_Registry_Log');
          @Daruma_Registry_NomeLog := GetProcAddress(HandleDLL, 'Daruma_Registry_NomeLog');
          @Daruma_Registry_Separador := GetProcAddress(HandleDLL, 'Daruma_Registry_Separador');
          @Daruma_Registry_SeparaMsgPromo := GetProcAddress(HandleDLL, 'Daruma_Registry_SeparaMsgPromo');
          @Daruma_Registry_ZAutomatica := GetProcAddress(HandleDLL, 'Daruma_Registry_ZAutomatica');
          @Daruma_Registry_XAutomatica := GetProcAddress(HandleDLL, 'Daruma_Registry_XAutomatica');
          @Daruma_Registry_VendeItemUmaLinha := GetProcAddress(HandleDLL, 'Daruma_Registry_VendeItemUmaLinha');
          @Daruma_Registry_Default := GetProcAddress(HandleDLL, 'Daruma_Registry_Default');
          @Daruma_Registry_RetornaValor := GetProcAddress(HandleDLL, 'Daruma_Registry_RetornaValor');
          @Daruma_Registry_TerminalServer := GetProcAddress(HandleDLL, 'Daruma_Registry_TerminalServer');
          @Daruma_Registry_ErroExtendidoOk := GetProcAddress(HandleDLL, 'Daruma_Registry_ErroExtendidoOk');
          @Daruma_Registry_AbrirDiaFiscal := GetProcAddress(HandleDLL, 'Daruma_Registry_AbrirDiaFiscal');
          @Daruma_Registry_VendaAutomatica := GetProcAddress(HandleDLL, 'Daruma_Registry_VendaAutomatica');
          @Daruma_Registry_AplMensagem1 := GetProcAddress(HandleDLL, 'Daruma_Registry_AplMensagem1');
          @Daruma_Registry_AplMensagem2 := GetProcAddress(HandleDLL, 'Daruma_Registry_AplMensagem2');
          @Daruma_Registry_IgnorarPoucoPapel := GetProcAddress(HandleDLL, 'Daruma_Registry_IgnorarPoucoPapel');
          @Daruma_Registry_ImprimeRegistry := GetProcAddress(HandleDLL, 'Daruma_Registry_ImprimeRegistry');
          @Daruma_FI_StatusCupomFiscal := GetProcAddress(HandleDLL, 'Daruma_FI_StatusCupomFiscal');
          @Daruma_FI_StatusRelatorioGerencial := GetProcAddress(HandleDLL, 'Daruma_FI_StatusRelatorioGerencial');
          @Daruma_FI_StatusComprovanteNaoFiscalVinculado := GetProcAddress(HandleDLL, 'Daruma_FI_StatusComprovanteNaoFiscalVinculado');
          @Daruma_FI_VerificaImpressoraLigada := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaImpressoraLigada');
          @Daruma_FI_VerificaTotalizadoresParciais := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaTotalizadoresParciais');
          @Daruma_FI_VerificaModoOperacao := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaModoOperacao');
          @Daruma_FI_VerificaTotalizadoresNaoFiscais := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaTotalizadoresNaoFiscais');
          @Daruma_FI_VerificaTotalizadoresNaoFiscaisEx := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaTotalizadoresNaoFiscaisEx');
          @Daruma_FI_VerificaTruncamento := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaTruncamento');
          @Daruma_FI_VerificaAliquotasIss := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaAliquotasIss');
          @Daruma_FI_VerificaIndiceAliquotasIss := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaIndiceAliquotasIss');
          @Daruma_FI_VerificaRecebimentoNaoFiscal := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaRecebimentoNaoFiscal');
          @Daruma_FI_VerificaTipoImpressora := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaTipoImpressora');
          @Daruma_FI_VerificaStatusCheque := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaStatusCheque');
          @Daruma_FI_VerificaModeloECF := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaModeloECF');
          @Daruma_FI_VerificaDescricaoFormasPagamento := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaDescricaoFormasPagamento');
          @Daruma_FI_VerificaXPendente := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaXPendente');
          @Daruma_FI_VerificaZPendente := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaZPendente');
          @Daruma_FI_VerificaDiaAberto := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaDiaAberto');
          @Daruma_FI_VerificaHorarioVerao := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaHorarioVerao');
          @Daruma_FI_VerificaFormasPagamento := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaFormasPagamento');
          @Daruma_FI_VerificaFormasPagamentoEx := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaFormasPagamentoEx');
          @Daruma_FI_VerificaEpromConectada := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaEpromConectada');
          @Daruma_FI_VerificaEstadoImpressora := GetProcAddress(HandleDLL, 'Daruma_FI_VerificaEstadoImpressora');
          @Daruma_FI_ClicheProprietario := GetProcAddress(HandleDLL, 'Daruma_FI_ClicheProprietario');
          @Daruma_FI_ClicheProprietarioEx := GetProcAddress(HandleDLL, 'Daruma_FI_ClicheProprietarioEx');
          @Daruma_FI_NumeroCaixa := GetProcAddress(HandleDLL, 'Daruma_FI_NumeroCaixa');
          @Daruma_FI_NumeroLoja := GetProcAddress(HandleDLL, 'Daruma_FI_NumeroLoja');
          @Daruma_FI_NumeroSerie := GetProcAddress(HandleDLL, 'Daruma_FI_NumeroSerie');
          @Daruma_FI_VersaoFirmware := GetProcAddress(HandleDLL, 'Daruma_FI_VersaoFirmware');
          @Daruma_FI_CGC_IE := GetProcAddress(HandleDLL, 'Daruma_FI_CGC_IE');
          @Daruma_FI_LerAliquotasComIndice := GetProcAddress(HandleDLL, 'Daruma_FI_LerAliquotasComIndice');
          @Daruma_FI_NumeroCupom := GetProcAddress(HandleDLL, 'Daruma_FI_NumeroCupom');
          @Daruma_FI_COO := GetProcAddress(HandleDLL, 'Daruma_FI_COO');
          @Daruma_FI_MinutosImprimindo := GetProcAddress(HandleDLL, 'Daruma_FI_MinutosImprimindo');
          @Daruma_FI_MinutosLigada := GetProcAddress(HandleDLL, 'Daruma_FI_MinutosLigada');
          @Daruma_FI_NumeroSubstituicoesProprietario := GetProcAddress(HandleDLL, 'Daruma_FI_NumeroSubstituicoesProprietario');
          @Daruma_FI_NumeroIntervencoes := GetProcAddress(HandleDLL, 'Daruma_FI_NumeroIntervencoes');
          @Daruma_FI_NumeroReducoes := GetProcAddress(HandleDLL, 'Daruma_FI_NumeroReducoes');
          @Daruma_FI_NumeroCuponsCancelados := GetProcAddress(HandleDLL, 'Daruma_FI_NumeroCuponsCancelados');
          @Daruma_FI_NumeroOperacoesNaoFiscais := GetProcAddress(HandleDLL, 'Daruma_FI_NumeroOperacoesNaoFiscais');
          @Daruma_FI_DataHoraImpressora := GetProcAddress(HandleDLL, 'Daruma_FI_DataHoraImpressora');
          @Daruma_FI_DataHoraReducao := GetProcAddress(HandleDLL, 'Daruma_FI_DataHoraReducao');
          @Daruma_FI_DataMovimento := GetProcAddress(HandleDLL, 'Daruma_FI_DataMovimento');
          @Daruma_FI_ContadoresTotalizadoresNaoFiscais := GetProcAddress(HandleDLL, 'Daruma_FI_ContadoresTotalizadoresNaoFiscais');
          @Daruma_FI_GrandeTotal := GetProcAddress(HandleDLL, 'Daruma_FI_GrandeTotal');
          @Daruma_FI_Descontos := GetProcAddress(HandleDLL, 'Daruma_FI_Descontos');
          @Daruma_FI_Acrescimos := GetProcAddress(HandleDLL, 'Daruma_FI_Acrescimos');
          @Daruma_FI_Cancelamentos := GetProcAddress(HandleDLL, 'Daruma_FI_Cancelamentos');
          @Daruma_FI_DadosUltimaReducao := GetProcAddress(HandleDLL, 'Daruma_FI_DadosUltimaReducao');
          @Daruma_FI_SubTotal := GetProcAddress(HandleDLL, 'Daruma_FI_SubTotal');
          @Daruma_FI_RetornoAliquotas := GetProcAddress(HandleDLL, 'Daruma_FI_RetornoAliquotas');
          @Daruma_FI_ValorPagoUltimoCupom := GetProcAddress(HandleDLL, 'Daruma_FI_ValorPagoUltimoCupom');
          @Daruma_FI_ValorFormaPagamento := GetProcAddress(HandleDLL, 'Daruma_FI_ValorFormaPagamento');
          @Daruma_FI_ValorTotalizadorNaoFiscal := GetProcAddress(HandleDLL, 'Daruma_FI_ValorTotalizadorNaoFiscal');
          @Daruma_FI_UltimoItemVendido := GetProcAddress(HandleDLL, 'Daruma_FI_UltimoItemVendido');
          @Daruma_FI_UltimaFormaPagamento := GetProcAddress(HandleDLL, 'Daruma_FI_UltimaFormaPagamento');
          @Daruma_FI_TipoUltimoDocumento := GetProcAddress(HandleDLL, 'Daruma_FI_TipoUltimoDocumento');
          @Daruma_FI_MapaResumo := GetProcAddress(HandleDLL, 'Daruma_FI_MapaResumo');
          @Daruma_FI_RelatorioTipo60Analitico := GetProcAddress(HandleDLL, 'Daruma_FI_RelatorioTipo60Analitico');
          @Daruma_FI_RelatorioTipo60Mestre := GetProcAddress(HandleDLL, 'Daruma_FI_RelatorioTipo60Mestre');
          @Daruma_FI_FlagsFiscais := GetProcAddress(HandleDLL, 'Daruma_FI_FlagsFiscais');
          @Daruma_FI_PalavraStatus := GetProcAddress(HandleDLL, 'Daruma_FI_PalavraStatus');
          @Daruma_FI_PalavraStatusBinario := GetProcAddress(HandleDLL, 'Daruma_FI_PalavraStatusBinario');
          @Daruma_FI_SimboloMoeda := GetProcAddress(HandleDLL, 'Daruma_FI_SimboloMoeda');
          @Daruma_FI_RetornoImpressora := GetProcAddress(HandleDLL, 'Daruma_FI_RetornoImpressora');
          @Daruma_FI_RetornaErroExtendido := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaErroExtendido');
          @Daruma_FI_RetornaAcrescimoNF := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaAcrescimoNF');
          @Daruma_FI_RetornaCFCancelados := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaCFCancelados');
          @Daruma_FI_RetornaCNFCancelados := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaCNFCancelados');
          @Daruma_FI_RetornaCLX := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaCLX');
          @Daruma_FI_RetornaCNFNV := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaCNFNV');
          @Daruma_FI_RetornaCNFV := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaCNFV');
          @Daruma_FI_RetornaCRO := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaCRO');
          @Daruma_FI_RetornaCRZ := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaCRZ');
          @Daruma_FI_RetornaCRZRestante := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaCRZRestante');
          @Daruma_FI_RetornaCancelamentoNF := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaCancelamentoNF');
          @Daruma_FI_RetornaDescontoNF := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaDescontoNF');
          @Daruma_FI_RetornaGNF := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaGNF');
          @Daruma_FI_RetornaTempoImprimindo := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaTempoImprimindo');
          @Daruma_FI_RetornaTempoLigado := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaTempoLigado');
          @Daruma_FI_RetornaTotalPagamentos := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaTotalPagamentos');
          @Daruma_FI_RetornaTroco := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaTroco');
          @Daruma_FI_RetornaZeros := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaZeros');
          @Daruma_FI_RetornaValorComprovanteNaoFiscal := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaValorComprovanteNaoFiscal');
          @Daruma_FI_RetornaIndiceComprovanteNaoFiscal := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaIndiceComprovanteNaoFiscal');
          @Daruma_FI_RetornaRegistradoresNaoFiscais := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaRegistradoresNaoFiscais');
          @Daruma_FI_RetornaRegistradoresFiscais := GetProcAddress(HandleDLL, 'Daruma_FI_RetornaRegistradoresFiscais');
          @Daruma_TEF_EsperarArquivo := GetProcAddress(HandleDLL, 'Daruma_TEF_EsperarArquivo');
          @Daruma_TEF_ImprimirResposta := GetProcAddress(HandleDLL, 'Daruma_TEF_ImprimirResposta');
          @Daruma_TEF_ImprimirRespostaCartao := GetProcAddress(HandleDLL, 'Daruma_TEF_ImprimirRespostaCartao');
          @Daruma_TEF_FechaRelatorio := GetProcAddress(HandleDLL, 'Daruma_TEF_FechaRelatorio');
          @Daruma_TEF_SetFocus := GetProcAddress(HandleDLL, 'Daruma_TEF_SetFocus');
          @Daruma_TEF_TravarTeclado := GetProcAddress(HandleDLL, 'Daruma_TEF_TravarTeclado');
          @Daruma_Registry_FS2000_CupomAdicional := GetProcAddress(HandleDLL, 'Daruma_Registry_FS2000_CupomAdicional');
          @Daruma_Registry_FS2000_TempoEsperaCheque := GetProcAddress(HandleDLL, 'Daruma_Registry_FS2000_TempoEsperaCheque');
          @Daruma_FI2000_DescontoSobreItemVendido := GetProcAddress(HandleDLL, 'Daruma_FI2000_DescontoSobreItemVendido');
          @Daruma_FI2000_AcrescimosICMSISS := GetProcAddress(HandleDLL, 'Daruma_FI2000_AcrescimosICMSISS');
          @Daruma_FI2000_CancelamentosICMSISS := GetProcAddress(HandleDLL, 'Daruma_FI2000_CancelamentosICMSISS');
          @Daruma_FI2000_DescontosICMSISS := GetProcAddress(HandleDLL, 'Daruma_FI2000_DescontosICMSISS');
          @Daruma_FI2000_LeituraInformacaoUltimosCNF := GetProcAddress(HandleDLL, 'Daruma_FI2000_LeituraInformacaoUltimosCNF');
          @Daruma_FI2000_LeituraInformacaoUltimoDoc := GetProcAddress(HandleDLL, 'Daruma_FI2000_LeituraInformacaoUltimoDoc');
          @Daruma_FI2000_VerificaRelatorioGerencial := GetProcAddress(HandleDLL, 'Daruma_FI2000_VerificaRelatorioGerencial');
          @Daruma_FI2000_CriaRelatorioGerencial := GetProcAddress(HandleDLL, 'Daruma_FI2000_CriaRelatorioGerencial');
          @Daruma_FI2000_AbreRelatorioGerencial := GetProcAddress(HandleDLL, 'Daruma_FI2000_AbreRelatorioGerencial');
          @Daruma_FI2000_CancelamentoCNFV := GetProcAddress(HandleDLL, 'Daruma_FI2000_CancelamentoCNFV');
          @Daruma_FI2000_SegundaViaCNFVinculado := GetProcAddress(HandleDLL, 'Daruma_FI2000_SegundaViaCNFVinculado');
          @Daruma_FI2000_StatusCheque := GetProcAddress(HandleDLL, 'Daruma_FI2000_StatusCheque');
          @Daruma_FI2000_ImprimirCheque := GetProcAddress(HandleDLL, 'Daruma_FI2000_ImprimirCheque');
          @Daruma_FI2000_ImprimirVersoCheque := GetProcAddress(HandleDLL, 'Daruma_FI2000_ImprimirVersoCheque');
          @Daruma_FI2000_LiberarCheque := GetProcAddress(HandleDLL, 'Daruma_FI2000_LiberarCheque');
          @Daruma_FI2000_LeituraCodigoMICR := GetProcAddress(HandleDLL, 'Daruma_FI2000_LeituraCodigoMICR');
          @Daruma_FI2000_CancelarCheque := GetProcAddress(HandleDLL, 'Daruma_FI2000_CancelarCheque');
          @Daruma_FI2000_LeituraTabelaCheque := GetProcAddress(HandleDLL, 'Daruma_FI2000_LeituraTabelaCheque');
          @Daruma_FI2000_CarregarCheque := GetProcAddress(HandleDLL, 'Daruma_FI2000_CarregarCheque');
          @Daruma_FI2000_CorrigirGeometriaCheque := GetProcAddress(HandleDLL, 'Daruma_FI2000_CorrigirGeometriaCheque');
          @Daruma_Sintegra_GerarRegistrosArq := GetProcAddress(HandleDLL, 'Daruma_Sintegra_GerarRegistrosArq');
          @Daruma_Sintegra_GerarRegistro10 := GetProcAddress(HandleDLL, 'Daruma_Sintegra_GerarRegistro10');
          @Daruma_Sintegra_GerarRegistro11 := GetProcAddress(HandleDLL, 'Daruma_Sintegra_GerarRegistro11');
          @Daruma_Sintegra_GerarRegistro60M := GetProcAddress(HandleDLL, 'Daruma_Sintegra_GerarRegistro60M');
          @Daruma_Sintegra_GerarRegistro60A := GetProcAddress(HandleDLL, 'Daruma_Sintegra_GerarRegistro60A');
          @Daruma_Sintegra_GerarRegistro60D := GetProcAddress(HandleDLL, 'Daruma_Sintegra_GerarRegistro60D');
          @Daruma_Sintegra_GerarRegistro60I := GetProcAddress(HandleDLL, 'Daruma_Sintegra_GerarRegistro60I');
          @Daruma_Sintegra_GerarRegistro60R := GetProcAddress(HandleDLL, 'Daruma_Sintegra_GerarRegistro60R');
          @Daruma_Sintegra_GerarRegistro90 := GetProcAddress(HandleDLL, 'Daruma_Sintegra_GerarRegistro90');
          @Daruma_Registry_SintegraSeparador := GetProcAddress(HandleDLL, 'Daruma_Registry_SintegraSeparador');
          @Daruma_Registry_SintegraPath := GetProcAddress(HandleDLL, 'Daruma_Registry_SintegraPath');
          @Daruma_FIMFD_RetornaInformacao := GetProcAddress(HandleDLL, 'Daruma_FIMFD_RetornaInformacao');
        end;
   else Result := true;
   end;
end;


function TDefFPRinter.Retorno_Impressora(ErroCupomAberto: Boolean = True) : Boolean;
Var
  iACK, iST1, iST2, iST3, iST1Tmp: Integer;
  strErroMsg: string;
  iCodErro: integer;
Begin
  iACK := 0; iST1 := 0; iST2 := 0;
  case Impressora of
    BematechMP20, BematechMP40, BematechTermica:
       begin

          iRetorno := Bematech_RetornoImpressora(iACK, iST1, iST2);

          Result := (iACK <> 21) And (iST2 = 0);

          If iACK = 6 then
          BEGIN
            if (iST1 <> 0) or (iST2 <> 0) then
              if iST1 <> 64 then
                BlockInput(False);

            // Verifica ST1
            IF iST1 >= 128 Then BEGIN iST1 := iST1 - 128; Application.MessageBox('Fim de Papel.', 'Erro', MB_OK + MB_ICONERROR); Result := False; END;
            IF iST1 >= 64  Then BEGIN iST1 := iST1 - 64;  {Application.MessageBox('Pouco Papel.', 'Atenção', MB_OK + MB_ICONEXCLAMATION);} END;
            IF iST1 >= 32  Then BEGIN iST1 := iST1 - 32;  Application.MessageBox('Erro no Relógio.', 'Erro', MB_OK + MB_ICONERROR); Result := False; END;
            IF iST1 >= 16  Then BEGIN iST1 := iST1 - 16;  Application.MessageBox('Impressora em ERRO.', 'Erro', MB_OK + MB_ICONERROR); Result := False; END;
            IF iST1 >= 8   Then BEGIN iST1 := iST1 - 8;   Application.MessageBox('CMD Não Iniciado com ESC.', 'Erro', MB_OK + MB_ICONERROR); Result := False; END;
            IF iST1 >= 4   Then BEGIN iST1 := iST1 - 4;   Application.MessageBox('Comando Inexistente.', 'Erro', MB_OK + MB_ICONERROR); Result := False; END;
            IF iST1 >= 2   Then BEGIN iST1 := iST1 - 2;   Application.MessageBox('Cupom Aberto.', 'Erro', MB_OK + MB_ICONERROR); {Result := False;} END;
            IF iST1 >= 1   Then BEGIN iST1 := iST1 - 1;   Application.MessageBox('Número de Parâmetros inválido.', 'Erro', MB_OK + MB_ICONERROR); Result := False; END;

            // Verifica ST2
            IF iST2 >= 128 Then BEGIN iST2 := iST2 - 128; Application.MessageBox('Tipo de parâmetro inválido.', 'Erro', MB_OK + MB_ICONERROR); END;
            IF iST2 >= 64  Then BEGIN iST2 := iST2 - 64;  Application.MessageBox('Memória fiscal lotada.', 'Erro', MB_OK + MB_ICONERROR); END;
            IF iST2 >= 32  Then BEGIN iST2 := iST2 - 32;  Application.MessageBox('CMOS não volátil.', 'Erro', MB_OK + MB_ICONERROR); END;
            IF iST2 >= 16  Then BEGIN iST2 := iST2 - 16;  Application.MessageBox('Aliquota Não Programada.', 'Erro', MB_OK + MB_ICONERROR); END;
            IF iST2 >= 8   Then BEGIN iST2 := iST2 - 8;   Application.MessageBox('Alíquotas Lotadas.', 'Erro', MB_OK + MB_ICONERROR); END;
            IF iST2 >= 4   Then BEGIN iST2 := iST2 - 4;   Application.MessageBox('Cancelamento Não Permitido', 'Erro', MB_OK + MB_ICONERROR); END;
            IF iST2 >= 2   Then BEGIN iST2 := iST2 - 2;   Application.MessageBox('CGC/IE Não Programados', 'Erro', MB_OK + MB_ICONERROR); END;
            IF iST2 >= 1   Then BEGIN iST2 := iST2 - 1;   {Application.MessageBox('Comando Não Executado', 'Erro', MB_OK + MB_ICONERROR)}; END;
          End;

          If iACK = 21 Then
          begin
            BlockInput(False);
            Application.MessageBox('A Impressora retornou NAK.', 'Erro', MB_OK + MB_ICONERROR);
          end;
       end;

    Elgin:
       begin 
          strErroMsg := StringOfChar(' ', 100);
          iRetorno := Elgin_RetornoImpressora( iCodErro, strErroMsg );
          Result := ((iRetorno = 1) and (iCodErro = 0));
          if (not Result) then
            Application.MessageBox(Pchar('Erro Nº '+ IntToStr(iCodErro) + chr(13) + chr(10) + strErroMsg), 'Erro', MB_OK + MB_ICONERROR);
       end;


    AFRAC:
    begin
      Result := True;
    end;

    DarumaMatr, DarumaTerm:
    begin
      iRetorno := Daruma_FI_RetornoImpressora(iACK, iST1, iST2);

      Result := (iACK <> 21) And (iST2 = 0);

      if iACK = 6 then
      begin
        if (iST1 <> 0) or (iST2 <> 0) then
          if iST1 <> 64 then
            BlockInput(False);

        if (iST1 and 128) <> 0 then begin Application.MessageBox('O papel acabou.', 'Erro', MB_OK + MB_ICONERROR); Result := False; end;
        if (iST1 and 64)  <> 0 then begin Application.MessageBox('O papel está acabando.', 'Erro', MB_OK + MB_ICONERROR); Result := False; end;
        if (iST1 and 32)  <> 0 then begin Application.MessageBox('Erro no relógio da impressora.', 'Erro', MB_OK + MB_ICONERROR); Result := False; end;
        if (iST1 and 16)  <> 0 then begin Application.MessageBox('Impressora em erro.', 'Erro', MB_OK + MB_ICONERROR); Result := False; end;
        if (iST1 and 8)   <> 0 then begin Application.MessageBox('primeiro dado do método não foi ESC(1Bh).', 'Erro', MB_OK + MB_ICONERROR); Result := False; end;
        if (iST1 and 4)   <> 0 then begin Application.MessageBox('Método inexistente.', 'Erro', MB_OK + MB_ICONERROR); Result := False; end;
        //if (iST1 and 2)   <> 0 then begin Application.MessageBox('Cupom Fiscal Aberto.', 'Erro', MB_OK + MB_ICONERROR); Result := False; end;
        if (iST1 and 1)   <> 0 then begin Application.MessageBox('Numero de oarãmetros inválido.', 'Erro', MB_OK + MB_ICONERROR); Result := False; end;

        if (iST2 and 128) <> 0 then begin Application.MessageBox('Tipo de parâmetro Inválido.', 'Erro', MB_OK + MB_ICONERROR); Result := False; end;
        if (iST2 and 64)  <> 0 then begin Application.MessageBox('Memória Fiscal cheia.', 'Erro', MB_OK + MB_ICONERROR); Result := False; end;
        if (iST2 and 32)  <> 0 then begin Application.MessageBox('Erro na memória RAM não volátil.', 'Erro', MB_OK + MB_ICONERROR); Result := False; end;
        if (iST2 and 16)  <> 0 then begin Application.MessageBox('Aliquota não definida.', 'Erro', MB_OK + MB_ICONERROR); Result := False; end;
        if (iST2 and 8)   <> 0 then begin Application.MessageBox('Capacidade de alíquotas esgotada.', 'Erro', MB_OK + MB_ICONERROR); Result := False; end;
        if (iST2 and 4)   <> 0 then begin Application.MessageBox('Este cancelamento não é permitido.', 'Erro', MB_OK + MB_ICONERROR); Result := False; end;
        if (iST2 and 2)   <> 0 then begin Application.MessageBox('CNPJ/IE do proprietário não definidos.', 'Erro', MB_OK + MB_ICONERROR); Result := False; end;
        if (iST2 and 1)   <> 0 then begin Application.MessageBox('Método não executado.', 'Erro', MB_OK + MB_ICONERROR); Result := False; end;
      end;

      if iACK = 21 Then
      begin
        BlockInput(False);
        Application.MessageBox('A Impressora retornou NAK.', 'Erro', MB_OK + MB_ICONERROR);
      end;
    end;

    Sweda03, Sweda10:
    begin
      iACK   := 0;
      iST1   := 0;
      iST2   := 0;
      iST3   := 0;
      strErroMsg := '';

      iRetorno := Sweda_RetornoImpressoraMFD(iACK, iST1, iST2, iST3);
      Result := (iRetorno = 1);

      if not Result then
        Application.MessageBox('Falha na Execução do comando', 'Erro', MB_OK + MB_ICONERROR);

      {
      case iST3 of
        //0:   strErroMsg:='COMANDO OK';
        1:   strErroMsg:='COMANDO INVÁLIDO';
        2:   strErroMsg:='ERRO DESCONHECIDO';
        3:   strErroMsg:='NÚMERO DE PARÂMETRO INVÁLIDO';
        4:   strErroMsg:='TIPO DE PARÂMETRO INVÁLIDO';
        5:   strErroMsg:='TODAS ALÍQUOTAS JÁ PROGRAMADAS';
        6:   strErroMsg:='TOTALIZADOR NÃO FISCAL JÁ PROGRAMADO';
        7:   strErroMsg:='CUPOM FISCAL ABERTO';
        8:   strErroMsg:='CUPOM FISCAL FECHADO';
        9:   strErroMsg:='ECF OCUPADO';
        10:  strErroMsg:='IMPRESSORA EM ERRO';
        11:   strErroMsg:='IMPRESSORA SEM PAPEL';
        12:   strErroMsg:='IMPRESSORA COM CABEÇA LEVANTADA';
        13:   strErroMsg:='IMPRESSORA OFF LINE';
        14:   strErroMsg:='ALÍQUOTA NÃO PROGRAMADA';
        15:   strErroMsg:='TERMINADOR DE STRING FALTANDO';
        16:   strErroMsg:='ACRÉSCIMO OU DESCONTO MAIOR QUE O TOTAL DO CUPOM FISCAL';
        17:   strErroMsg:='CUPOM FISCAL SEM ITEM VENDIDO';
        18:   strErroMsg:='COMANDO NÃO EFETIVADO';
        19:   strErroMsg:='SEM ESPAÇO PARA NOVAS FORMAS DE PAGAMENTO';
        20:   strErroMsg:='FORMA DE PAGAMENTO NÃO PROGRAMADA';
        21:   strErroMsg:='ÍNDICE MAIOR QUE NÚMERO DE FORMA DE PAGAMENTO';
        22:   strErroMsg:='FORMAS DE PAGAMENTO ENCERRADAS';
        23:   strErroMsg:='CUPOM NÃO TOTALIZADO';
        24:   strErroMsg:='COMANDO MAIOR QUE 7Fh (127d)';
        25:   strErroMsg:='CUPOM FISCAL ABERTO E SEM ÍTEM';
        26:   strErroMsg:='CANCELAMENTO NÃO IMEDIATAMENTE APÓS';
        27:   strErroMsg:='CANCELAMENTO JÁ EFETUADO';
        28:   strErroMsg:='COMPROVANTE DE CRÉDITO OU DÉBITO NÃO PERMITIDO OU JÁ EMITIDO';
        29:   strErroMsg:='MEIO DE PAGAMENTO NÃO PERMITE TEF';
        30:   strErroMsg:='SEM COMPROVANTE NÃO FISCAL ABERTO';
        31:   strErroMsg:='COMPROVANTE DE CRÉDITO OU DÉBITO JÁ ABERTO';
        32:   strErroMsg:='REIMPRESSÃO NÃO PERMITIDA';
        33:   strErroMsg:='COMPROVANTE NÃO FISCAL JÁ ABERTO';
        34:   strErroMsg:='TOTALIZADOR NÃO FISCAL NÃO PROGRAMADO';
        35:   strErroMsg:='CUPOM NÃO FISCAL SEM ÍTEM VENDIDO';
        36:   strErroMsg:='ACRÉSCIMO E DESCONTO MAIOR QUE TOTAL CNF';
        37:   strErroMsg:='MEIO DE PAGAMENTO NÃO INDICADO';
        38:   strErroMsg:='MEIO DE PAGAMENTO DIFERENTE DO TOTAL DO RECEBIMENTO';
        39:   strErroMsg:='NÃO PERMITIDO MAIS DE UMA SANGRIA OU SUPRIMENTO';
        40:   strErroMsg:='RELATÓRIO GERENCIAL JÁ PROGRAMADO';
        41:   strErroMsg:='RELATÓRIO GERENCIAL NÃO PROGRAMADO';
        42:   strErroMsg:='RELATÓRIO GERENCIAL NÃO PERMITIDO';
        43:   strErroMsg:='MFD NÃO INICIALIZADA';
        44:   strErroMsg:='MFD AUSENTE';
        45:   strErroMsg:='MFD SEM NÚMERO DE SÉRIE';
        46:   strErroMsg:='MFD JÁ INICIALIZADA';
        47:   strErroMsg:='MFD LOTADA';
        48:   strErroMsg:='CUPOM NÃO FISCAL ABERTO';
        49:   strErroMsg:='MEMÓRIA FISCAL DESCONECTADA';
        50:   strErroMsg:='MEMÓRIA FISCAL SEM NÚMERO DE SÉRIE DA MFD';
        51:   strErroMsg:='MEMÓRIA FISCAL LOTADA';
        52:   strErroMsg:='DATA INICIAL INVÁLIDA';
        53:   strErroMsg:='DATA FINAL INVÁLIDA';
        54:   strErroMsg:='CONTADOR DE REDUÇÃO Z INICIAL INVÁLIDO';
        55:   strErroMsg:='CONTADOR DE REDUÇÃO Z FINAL INVÁLIDO';
        56:   strErroMsg:='ERRO DE ALOCAÇÃO';
        57:   strErroMsg:='DADOS DO RTC INCORRETOS';
        58:   strErroMsg:='DATA ANTERIOR AO ÚLTIMO DOCUMENTO EMITIDO';
        59:   strErroMsg:='FORA DE INTERVENÇÃO TÉCNICA';
        60:   strErroMsg:='EM INTERVENÇÃO TÉCNICA';
        61:   strErroMsg:='ERRO NA MEMÓRIA DE TRABALHO';
        62:   strErroMsg:='JÁ HOUVE MOVIMENTO NO DIA';
        63:   strErroMsg:='BLOQUEIO POR RZ';
        64:   strErroMsg:='FORMA DE PAGAMENTO ABERTA';
        65:   strErroMsg:='AGUARDANDO PRIMEIRO PROPRIETÁRIO';
        66:   strErroMsg:='AGUARDANDO RZ';
        67:   strErroMsg:='ECF OU LOJA IGUAL A ZERO';
        68:   strErroMsg:='CUPOM ADICIONAL NÃO PERMITIDO';
        69:   strErroMsg:='DESCONTO MAIOR QUE TOTAL VENDIDO EM ICMS';
        70:   strErroMsg:='RECEBIMENTO NÃO FISCAL NULO NÃO PERMITIDO';
        71:   strErroMsg:='ACRÉSCIMO OU DESCONTO MAIOR QUE TOTAL NÃO FISCAL';
        72:   strErroMsg:='MEMÓRIA FISCAL LOTADA PARA NOVO CARTUCHO';
        73:   strErroMsg:='ERRO DE GRAVAÇÃO NA MF';
        74:   strErroMsg:='ERRO DE GRAVAÇÃO NA MFD';
        75:   strErroMsg:='DADOS DO RTC ANTERIORES AO ÚLTIMO DOC ARMAZENADO';
        76:   strErroMsg:='MEMÓRIA FISCAL SEM ESPAÇO PARA GRAVAR LEITURAS DA MFD';
        77:   strErroMsg:='MEMÓRIA FISCAL SEM ESPAÇO PARA GRAVAR VERSAO DO SB';
        78:   strErroMsg:='DESCRIÇÃO IGUAL A DEFAULT NÃO PERMITIDO';
        79:   strErroMsg:='EXTRAPOLADO NÚMERO DE REPETIÇÕES PERMITIDAS';
        80:   strErroMsg:='SEGUNDA VIA DO COMPROVANTE DE CRÉDITO OU DÉBITO NÃO PERMITIDO';
        81:   strErroMsg:='PARCELAMENTO FORA DA SEQUÊNCIA';
        82:   strErroMsg:='COMPROVANTE DE CRÉDITO OU DÉBITO ABERTO';
        83:   strErroMsg:='TEXTO COM SEQUÊNCIA DE ESC INVÁLIDA';
        84:   strErroMsg:='TEXTO COM SEQUÊNCIA DE ESC INCOMPLETA';
        85:   strErroMsg:='VENDA COM VALOR NULO';
        86:   strErroMsg:='ESTORNO DE VALOR NULO ';
        87:   strErroMsg:='FORMA DE PAGAMENTO DIFERENTE DO TOTAL DA SANGRIA';
        88:   strErroMsg:='REDUÇÃO NÃO PERMITIDA EM INTERVENÇÃO TÉCNICA';
        89:   strErroMsg:='AGUARDANDO RZ PARA ENTRADA EM INTERVENÇÃO TÉCNICA';
        90:   strErroMsg:='FORMA DE PAGAMENTO COM VALOR NULO NÃO PERMITIDO';
        91:   strErroMsg:='ACRÉSCIMO E DESCONTO MAIOR QUE VALOR DO ÍTEM';
        92:   strErroMsg:='AUTENTICAÇÃO NÃO PERMITIDA';
        93:   strErroMsg:='TIMEOUT NA VALIDAÇÃO';
        94:   strErroMsg:='COMANDO NÃO EXECUTADO EM IMPRESSORA BILHETE DE PASSAGEM';
        95:   strErroMsg:='COMANDO NÃO EXECUTADO EM IMPRESSORA DE CUPOM FISCAL';
        96:   strErroMsg:='CUPOM NÃO FISCAL FECHADO';
        97:   strErroMsg:='PARÂMETRO NÃO ASCII EM CAMPO ASCII';
        98:   strErroMsg:='PARÂMETRO NÃO ASCII NUMÉRICO EM CAMPO ASCII NUMÉRICO';
        99:   strErroMsg:='TIPO DE TRANSPORTE INVÁLIDO';
        100:  strErroMsg:='DATA E HORA INVÁLIDA';
        101:  strErroMsg:='SEM RELATÓRIO GERENCIAL OU COMPROVANTE DE CRÉDITO OU DÉBITO ABERTO';
        102:  strErroMsg:='NÚMERO DO TOTALIZADOR NÃO FISCAL INVÁLIDO';
        103:  strErroMsg:='PARÂMETRO DE ACRÉSCIMO OU DESCONTO INVÁLIDO';
        104:  strErroMsg:='ACRÉSCIMO OU DESCONTO EM SANGRIA OU SUPRIMENTO NÃO PERMITIDO';
        105:  strErroMsg:='NÚMERO DO RELATÓRIO GERENCIAL INVÁLIDO';
        106:  strErroMsg:='FORMA DE PAGAMENTO ORIGEM NÃO PROGRAMADA';
        107:  strErroMsg:='FORMA DE PAGAMENTO DESTINO NÃO PROGRAMADA';
        108:  strErroMsg:='ESTORNO MAIOR QUE FORMA PAGAMENTO';
        109:  strErroMsg:='CARACTER NUMÉRICO NA CODIFICAÇÃO GT NÃO PERMITIDO';
        110:  strErroMsg:='ERRO NA INICIALIZAÇÃO DA MF';
        111:  strErroMsg:='NOME DO TOTALIZADOR EM BRANCO NÃO PERMITIDO';
        112:  strErroMsg:='DATA E HORA ANTERIORES AO ÚLTIMO DOC ARMAZENADO';
        113:  strErroMsg:='PARÂMETRO DE ACRÉSCIMO OU DESCONTO INVÁLIDO';
        114:  strErroMsg:='ÍTEM ANTERIOR AOS TREZENTOS ÚLTIMOS';
        115:  strErroMsg:='ÍTEM NÃO EXISTE OU JÁ CANCELADO';
        116:  strErroMsg:='CÓDIGO COM ESPAÇOS NÃO PERMITIDO';
        117:  strErroMsg:='DESCRICAO SEM CARACTER ALFABÉTICO NÃO PERMITIDO';
        118:  strErroMsg:='ACRÉSCIMO MAIOR QUE VALOR DO ÍTEM';
        119:  strErroMsg:='DESCONTO MAIOR QUE VALOR DO ÍTEM';
        120:  strErroMsg:='DESCONTO EM ISS NÃO PERMITIDO';
        121:  strErroMsg:='ACRÉSCIMO EM ÍTEM JÁ EFETUADO';
        122:  strErroMsg:='DESCONTO EM ÍTEM JÁ EFETUADO';
        123:  strErroMsg:='ERRO NA MEMÓRIA FISCAL CHAMAR CREDENCIADO';
        124:  strErroMsg:='AGUARDANDO GRAVAÇÃO NA MEMÓRIA FISCAL';
        125:  strErroMsg:='CARACTER REPETIDO NA CODIFICAÇÃO DO GT';
        126:  strErroMsg:='VERSÃO JÁ GRAVADA NA MEMÓRIA FISCAL';
        127:  strErroMsg:='ESTOURO DE CAPACIDADE NO CHEQUE';
        128:  strErroMsg:='TIMEOUT NA LEITURA DO CHEQUE';
        129:  strErroMsg:='MÊS INVÁLIDO';
        130:  strErroMsg:='COORDENADA INVÁLIDA';
        131:  strErroMsg:='SOBREPOSIÇÃO DE TEXTO';
        132:  strErroMsg:='SOBREPOSIÇÃO DE TEXTO NO VALOR';
        133:  strErroMsg:='SOBREPOSIÇÃO DE TEXTO NO EXTENSO';
        134:  strErroMsg:='SOBREPOSIÇÃO DE TEXTO NO FAVORECIDO';
        135:  strErroMsg:='SOBREPOSIÇÃO DE TEXTO NA LOCALIDADE';
        136:  strErroMsg:='SOBREPOSIÇÃO DE TEXTO NO OPCIONAL';
        137:  strErroMsg:='SOBREPOSIÇÃO DE TEXTO NO DIA';
        138:  strErroMsg:='SOBREPOSIÇÃO DE TEXTO NO MÊS';
        139:  strErroMsg:='SOBREPOSIÇÃO DE TEXTO NO ANO';
        140:  strErroMsg:='USANDO MFD DE OUTRO ECF';
        141:  strErroMsg:='PRIMEIRO DADO DIFERENTE DE ESC OU 1C';
        142:  strErroMsg:='NÃO PERMITIDO ALTERAR SEM INTERVENÇÃO TÉCNICA';
        143:  strErroMsg:='DADOS DA ÚLTIMA RZ CORROMPIDOS';
        144:  strErroMsg:='COMANDO NÃO PERMITIDO NO MODO INICIALIZAÇÃO';
        145:  strErroMsg:='AGUARDANDO ACERTO DE RELÓGIO';
        146:  strErroMsg:='MFD JÁ INICIALIZADA PARA OUTRA MF';
        147:  strErroMsg:='AGUARDANDO ACERTO DO RELÓGIO OU DESBLOQUEIO PELO TECLADO';
        148:  strErroMsg:='VALOR FORMA DE PAGAMENTO MAIOR QUE MÁXIMO PERMITIDO';
        149:  strErroMsg:='RAZÃO SOCIAL EM BRANCO';
        150:  strErroMsg:='NOME DE FANTASIA EM BRANCO';
        151:  strErroMsg:='ENDEREÇO EM BRANCO';
        152:  strErroMsg:='ESTORNO DE CDC NÃO PERMITIDO';
        153:  strErroMsg:='DADOS DO PROPRIETÁRIO IGUAIS AO ATUAL';
        154:  strErroMsg:='ESTORNO DE FORMA DE PAGAMENTO NÃO PERMITIDO';
        155:  strErroMsg:=' DESCRIÇÃO FORMA DE PAGAMENTO IGUAL JÁ PROGRAMADA';
        156:  strErroMsg:='ACERTO DE HORÁRIO DE VERÃO SÓ IMEDIATAMENTE APÓS RZ';
        157:  strErroMsg:='IT NÃO PERMITIDA MF RESERVADA PARA RZ';
        158:  strErroMsg:='SENHA CNPJ INVÁLIDA';
        159:  strErroMsg:='TIMEOUT NA INICIALIZAÇÃO DA NOVA MF';
        160:  strErroMsg:='NÃO ENCONTRADO DADOS NA MFD';
        161:  strErroMsg:='SANGRIA OU SUPRIMENTO DEVEM SER ÚNICOS NO CNF';
        162:  strErroMsg:='ÍNDICE DA FORMA DE PAGAMENTO NULO NÃO PERMITIDO';
        163:  strErroMsg:='UF DESTINO INVÁLIDA';
        164:  strErroMsg:='TIPO DE TRANSPORTE INCOMPATÍVEL COM UF DESTINO';
        165:  strErroMsg:='DESCRIÇÃO DO PRIMEIRO ÍTEM DO BILHETE DE PASSAGEM DIFERENTE DE "TARIFA"';
        166:  strErroMsg:='AGUARDANDO IMPRESSÃO DE CHEQUE OU AUTENTICAÇÃO';
        167:  strErroMsg:='NÃO PERMITIDO PROGRAMAÇAO CNPJ IE COM ESPAÇOS EM BRANCO';
        168:  strErroMsg:='NÃO PERMITIDO PROGRAMAÇÃO UF COM ESPAÇOS EM BRANCO';
        169:  strErroMsg:='NÚMERO DE IMPRESSÕES DA FITA DETALHE NESTA INTERVENÇÃO TÉCNICA ESGOTADO';
        170:  strErroMsg:='CF JÁ SUBTOTALIZADO';
        171:  strErroMsg:='CUPOM NÃO SUBTOTALIZADO';
        172:  strErroMsg:='ACRÉSCIMO EM SUBTOTAL JÁ EFETUADO';
        173:  strErroMsg:='DESCONTO EM SUBTOTAL JÁ EFETUADO';
        174:  strErroMsg:='ACRÉSCIMO NULO NÃO PERMITIDO';
        175:  strErroMsg:='DESCONTO NULO NÃO PERMITIDO';
        176:  strErroMsg:='CANCELAMENTO DE ACRÉSCIMO OU DESCONTO EM SUBTOTAL NÃO PERMITIDO';
        177:  strErroMsg:='DATA INVÁLIDA';
        178:  strErroMsg:='VALOR DO CHEQUE NULO NÃO PERMITIDO';
        179:  strErroMsg:='VALOR DO CHEQUE INVÁLIDO';
        180:  strErroMsg:='CHEQUE SEM LOCALIDADE NÃO PERMITIDO';
        181:  strErroMsg:='CANCELAMENTO ACRÉSCIMO EM ÍTEM NÃO PERMITIDO';
        182:  strErroMsg:='CANCELAMENTO DESCONTO EM ÍTEM NÃO PERMITIDO';
        183:  strErroMsg:='NÚMERO MÁXIMO DE ÍTENS ATINGIDO';
        184:  strErroMsg:='NÚMERO DE ÍTEM NULO NÃO PERMITIDO';
        185:  strErroMsg:='MAIS QUE DUAS ALÍQUOTAS DIFERENTES NO BILHETE DE PASSAGEM NÃO PERMITIDO';
        186:  strErroMsg:='ACRÉSCIMO OU DESCONTO EM ITEM NÃO PERMITIDO';
        187:  strErroMsg:='CANCELAMENTO DE ACRÉSCIMO OU DESCONTO EM ITEM NÃO PERMITIDO';
        188:  strErroMsg:='CLICHE JÁ IMPRESSO';
        189:  strErroMsg:='TEXTO OPCIONAL DO CHEQUE EXCEDEU O MÁXIMO PERMITIDO';
        190:  strErroMsg:='IMPRESSÃO AUTOMÁTICA NO VERSO NÃO PERMITIDO NESTE EQUIPAMENTO';
        191:  strErroMsg:='TIMEOUT NA INSERÇÃO DO CHEQUE';
        192:  strErroMsg:='OVERFLOW NA CAPACIDADE DE TEXTO DO COMPROVANTE DE CRÉDITO OU DÉBITO';
        193:  strErroMsg:='PROGRAMAÇÃO DE ESPAÇOS ENTRE CUPONS MENOR QUE O MÍNIMO PERMITIDO';
        194:  strErroMsg:='EQUIPAMENTO NÃO POSSUI LEITOR DE CHEQUE';
        195:  strErroMsg:='PROGRAMAÇÃO DE ALÍQUOTA COM VALOR NULO NÃO PERMITIDO';
        196:  strErroMsg:='PARÂMETRO BAUD RATE INVÁLIDO';
        197:  strErroMsg:='CONFIGURAÇÃO PERMITIDA SOMENTE PELA PORTA DOS FISCO';
        198:  strErroMsg:='VALOR TOTAL DO ITEM EXCEDE 11 DÍGITOS';
        199:  strErroMsg:='PROGRAMAÇÃO DA MOEDA COM ESPAÇOS EM BRACO NÃO PERMITIDO';
        200:  strErroMsg:='CASAS DECIMAIS DEVEM SER PROGRAMADAS COM 2 OU 3';
        201:  strErroMsg:='NÃO PERMITE CADASTRAR USUÁRIOS DIFERENTES NA MESMA MFD';
        202:  strErroMsg:='IDENTIFICAÇÃO DO CONSUMIDOR NÃO PERMITIDA PARA SANGRIA OU SUPRIMENTO';
        203:  strErroMsg:='CASAS DECIMAIS EM QUANTIDADE MAIOR DO QUE A PERMITIDA';
        204:  strErroMsg:='CASAS DECIMAIS DO UNITÁRIO MAIOR DO QUE O PERMITIDA';
        205:  strErroMsg:='POSIÇÃO RESERVADA PARA ICMS';
        206:  strErroMsg:='POSIÇÃO RESERVADA PARA ISS';
        207:  strErroMsg:='TODAS AS ALÍQUOTAS COM A MESMA VINCULAÇÃO NÃO PERMITIDO';
        208:  strErroMsg:='DATA DE EMBARQUE ANTERIOR A DATA DE EMISSÃO';
      end;

      if strErroMsg <> '' then
      begin
        Result := False;
        Application.MessageBox(Pchar(strErroMsg), 'Erro', MB_OK + MB_ICONERROR);
      end;
      }

    end;

    SCFI:
    begin
      Result := True;
    end;

    Else
      Result := True;
  end;
End;


function TDefFPrinter.TemCupom : Boolean;
var
  ACK, ST1, ST2: Integer;
  pStatus: PChar;
  sStatus: String;
begin
  case Impressora Of
    BematechMP20, BematechMP40, BematechTermica:
    begin
       ACK := 0;
       ST1 := 0;
       ST2 := 0;
       iRetorno := Bematech_VerificaEstadoImpressora( ACK,ST1,ST2 );
       Analisa_iRetorno();
       Result := (ACK = 6) and ((ST1 and 2) = 2);
    end;

    Sweda03, Sweda10:
    begin
      SetLength(sStatus, 2);
      iRetorno := Sweda_StatusCupomFiscal(sStatus);
      Result := Trim(sStatus) = '1';
    end;

    Elgin:
    begin
       ACK := 0;
       ST1 := 0;
       ST2 := 0;
       iRetorno := Elgin_VerificaEstadoImpressora(ACK, ST1, ST2);
       Analisa_iRetorno();
       Result := (ACK = 6) and ((ST1 and 2) = 2);
    end;

    AFRAC:
    begin

      Result := False;
    end;

    Schalter3D:
    begin
      pStatus := Schalter3D_StatusImp;
      sStatus := StrPas(pStatus);
      sStatus := Copy(sStatus, 3, 3);
      Result := (sStatus = '065') or (sStatus = '090');
    end;

    SCFI:
    begin
      pStatus := SCFI_ecfStatusImp;
      sStatus := StrPas(pStatus);
      sStatus := Copy(sStatus, 3, 3);
      Result := (sStatus = '065') or (sStatus = '090');
    end;

    DarumaMatr, DarumaTerm:
    begin
      SetLength (sStatus, 2);
      iRetorno := Daruma_FI_StatusCupomFiscal(sStatus);
      Result := Trim(sStatus) = '1';
    end;
  end;
end;


function TDefFPrinter.DataImpressora : TDateTime;
var
   strData, strHora: String;
   ADay, AMonth, AYear, AHour, AMinute, ASecond, AMilliSecond: Word;
   pData: PChar;
begin
  Result := Trunc(NOW);
  case Impressora Of

    BematechMP20, BematechMP40, BematechTermica:
    begin
       strData := IncCharEx(strData, 6, ' ', 'L');
       strHora := IncCharEx(strHora, 6, ' ', 'L');

       iRetorno := Bematech_DataHoraImpressora(strData, strHora);
       Analisa_iRetorno();
       if (iRetorno <> 1) then
         Result := Trunc(NOW)
       else
         begin
           ADay   := StrToInt(Copy(strData, 1, 2));
           AMonth := StrToInt(Copy(strData, 3, 2));
           AYear  := StrToInt(Copy(strData, 5, 2));
           AYear  := AYear + 2000;
           AHour   := StrToInt(Copy(strHora, 1, 2));
           AMinute := StrToInt(Copy(strHora, 3, 2));
           ASecond := StrToInt(Copy(strHora, 5, 2));
           Result := EncodeDateTime(AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
         end;
    end;

    Sweda03, Sweda10:
    begin
       strData := IncCharEx(strData, 6, ' ', 'L');
       strHora := IncCharEx(strHora, 6, ' ', 'L');

       iRetorno := Sweda_DataHoraImpressora(strData, strHora);
       Analisa_iRetorno();
       
       if (iRetorno <> 1) then
         Result := Trunc(NOW)
       else
         begin
           ADay   := StrToInt(Copy(strData, 1, 2));
           AMonth := StrToInt(Copy(strData, 3, 2));
           AYear  := StrToInt(Copy(strData, 5, 2));
           AYear  := AYear + 2000;
           AHour   := StrToInt(Copy(strHora, 1, 2));
           AMinute := StrToInt(Copy(strHora, 3, 2));
           ASecond := StrToInt(Copy(strHora, 5, 2));
           Result := EncodeDateTime(AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
         end;
    end;

    Elgin:
    begin
       strData := IncCharEx(strData, 6, ' ', 'L');
       strHora := IncCharEx(strHora, 6, ' ', 'L');

       iRetorno := Elgin_DataHoraImpressora(strData, strHora);
       Analisa_iRetorno();
       if (iRetorno <> 1) then
         Result := Trunc(NOW)
       else
         begin
           ADay   := StrToInt(Copy(strData, 1, 2));
           AMonth := StrToInt(Copy(strData, 3, 2));
           AYear  := StrToInt(Copy(strData, 5, 2));
           AYear  := AYear + 2000;
           AHour   := StrToInt(Copy(strHora, 1, 2));
           AMinute := StrToInt(Copy(strHora, 3, 2));
           ASecond := StrToInt(Copy(strHora, 5, 2));
           Result := EncodeDateTime(AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
         end;
    end;

    AFRAC:
      begin
      (*
        InicializaPChar(pData, 19);
        iRetorno := AFRAC_LerInformacaoImpressora('017', pData);
        strData  := Trim(StrPas(pData));

        if (iRetorno <> 0) then
          Result := Trunc(NOW)
        else
          begin
             ADay   := StrToInt(Copy(strData, 1, 2));
             AMonth := StrToInt(Copy(strData, 4, 2));
             AYear  := StrToInt(Copy(strData, 7, 4));
             Result := EncodeDate(AYear, AMonth, ADay);
          end;
      *)
      end;

    DarumaMatr, DarumaTerm:
    begin

      strData := IncCharEx(strData, 6, ' ', 'L');
      strHora := IncCharEx(strHora, 6, ' ', 'L');

      iRetorno := Daruma_FI_DataHoraImpressora(strData, strHora);
      Analisa_iRetorno();
      if (iRetorno <> 1) then
        Result := Trunc(NOW)
      else
        begin
          ADay    := StrToInt(Copy(strData, 1, 2));
          AMonth  := StrToInt(Copy(strData, 3, 2));
          AYear   := StrToInt(Copy(strData, 5, 2));
          AYear   := AYear + 2000;
          AHour   := StrToInt(Copy(strHora, 1, 2));
          AMinute := StrToInt(Copy(strHora, 3, 2));
          ASecond := StrToInt(Copy(strHora, 5, 2));
          Result := EncodeDateTime(AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
        end;

    end;
  end;
end;





///////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.RelatorioTipo60Mestre(Var RegTipo60Mestre: TRegTipo60Mestre): Boolean;
///////////////////////////////////////////////////////////////////////////////
begin
  Result := False;
  case impressora of
    BematechMP20, BematechMP40, BematechTermica:
      Result := GetRelatorioTipo60Mestre_Bematech(RegTipo60Mestre);
  {  Elgin:
      Result := GetRelatorioTipo60Mestre_Elgin(RegTipo60Mestre);}
  end;
end;

///////////////////////////////////////////////////////////////////////////////
function TDefFPrinter.RelatorioTipo60Analitico(Var VetTipo60Analitico : TVetTipo60Analitico): Boolean;
///////////////////////////////////////////////////////////////////////////////
begin
  Result := False;
  case impressora of
    BematechMP20, BematechMP40, BematechTermica:
      Result := GetRelatorioTipo60Analitico_Bematech(VetTipo60Analitico);
  end;
end;

function TDefFPrinter.GetRelatorioTipo60Mestre_Bematech(Var RegTipo60Mestre: TRegTipo60Mestre): Boolean;
Var
  Retorno: String;
  I : Integer;
  OldShortDateFormat : String;
  OldDecimalSeparator : Char;
begin
  OldShortDateFormat  := ShortDateFormat;
  OldDecimalSeparator := DecimalSeparator;
  Try
    ShortDateFormat  := 'dd/mm/yy';
    DecimalSeparator := '.';

    iRetorno := Bematech_RelatorioTipo60Mestre();
    Analisa_iRetorno();
    Result := (iRetorno>0);

    Retorno := IncCharEx(Retorno, 624, ' ', 'L');
    iRetorno := Bematech_LeArquivoRetorno(Retorno);
    Analisa_iRetorno();
    Result := Result And (iRetorno>0);

    I := 0;
    While Length(Retorno) > 0 Do
      With RegTipo60Mestre Do
      begin
        Inc(I);

        Delete(Retorno, 1, 27);
        Case I Of
          3:  dDataEmissao  :=  StrToDate(Trim(Copy(Retorno, 1, 25)));
          4:  sNumeroSerie  :=  Trim(Copy(Retorno, 1, 25));
          5:  nNumeroOrdem  :=  StrToInt(Trim(Copy(Retorno, 1, 25)));
          6:  sModelo       :=  Trim(Copy(Retorno, 1, 25));
          7:  nContInicio   :=  StrToInt(Trim(Copy(Retorno, 1, 25)));
          8:  nContFim      :=  StrToInt(Trim(Copy(Retorno, 1, 25)));
          9:  nContReducaoZ :=  StrToInt(Trim(Copy(Retorno, 1, 25)));
          10: nContReinicio :=  StrToInt(Trim(Copy(Retorno, 1, 25)));
          11: nVendaBruta   :=  StrToFloat(StringReplace(StringReplace(Trim(Copy(Retorno, 1, 25)), '.', '', [rfReplaceAll]), ',', '.', [rfReplaceAll]));
          12: nTotalGeral   :=  StrToFloat(StringReplace(StringReplace(Trim(Copy(Retorno, 1, 25)), '.', '', [rfReplaceAll]), ',', '.', [rfReplaceAll]));
          Else;
        End;
        Delete(Retorno, 1, 25);
      end;
  Finally
    ShortDateFormat  := OldShortDateFormat;
    DecimalSeparator := OldDecimalSeparator;
  End;
end;


function TDefFPrinter.GetRelatorioTipo60Analitico_Bematech(Var VetTipo60Analitico : TVetTipo60Analitico): Boolean;
Var
  sIndiceAliquotas, sRetorno : String;
  nAliquotas : Integer;
  OldShortDateFormat  : String;
  OldDecimalSeparator : Char;
begin
  sIndiceAliquotas := IncCharEx(sIndiceAliquotas, 100, ' ', 'L');
  iRetorno := Bematech_RetornoAliquotas(sIndiceAliquotas);
  Analisa_iRetorno();
  Result := (iRetorno>0);


  nAliquotas := FISCAL_NUM_ALIQUOTAS_FIXAS;
  While Pos(',', sIndiceAliquotas) > 0 Do
  begin
    Delete(sIndiceAliquotas, Pos(',', sIndiceAliquotas), 1);
    Inc(nAliquotas);
  end;
  iRetorno := Bematech_RegistrosTipo60();
  Analisa_iRetorno();
  Result := Result And (iRetorno>0);
  sRetorno := IncCharEx(sRetorno, 126 + (nAliquotas * 126), ' ', 'L');
  iRetorno := Bematech_LeArquivoRetorno(sRetorno);
  Analisa_iRetorno();
  Result := Result And (iRetorno>0);


  Delete(sRetorno, 1 , 126);


  OldShortDateFormat  := ShortDateFormat;
  OldDecimalSeparator := DecimalSeparator;
  Try
    ShortDateFormat  := 'dd/mm/yyyy';
    DecimalSeparator := '.';

  SetLength(VetTipo60Analitico, 0);

   While Trim(sRetorno) <> '' Do
    begin
      sRetorno := Trim(sRetorno);
      SetLength(VetTipo60Analitico, Length(VetTipo60Analitico) + 1);
      VetTipo60Analitico[Length(VetTipo60Analitico) - 1].dDataEmissao := StrToDate(Copy(sRetorno, 10, 2) +'/'+ Copy(sRetorno, 8, 2) +'/'+ Copy(sRetorno, 4, 4));
      VetTipo60Analitico[Length(VetTipo60Analitico) - 1].sNumeroSerie := Trim(Copy(sRetorno, 12, 20));
      Delete(sRetorno, 1 , 31);
      VetTipo60Analitico[Length(VetTipo60Analitico) - 1].sSitTributaria := Trim(Copy(sRetorno, 1, 4));
      VetTipo60Analitico[Length(VetTipo60Analitico) - 1].nVlrAcumTotPar := StrToFloat(Trim(Copy(sRetorno, 5, 10)) + '.' + Copy(sRetorno, 15, 2));
      Delete(sRetorno, 1 , 17);
    end;
  Finally
    ShortDateFormat  := OldShortDateFormat;
    DecimalSeparator := OldDecimalSeparator;
  End;
end;



function TDefFPRinter.IncCharEx(S: string; const Len: Integer; Car, LR : Char):String;
var
  i : Integer;
begin
  Result := S;
  if Length(S) < Len then
    for i := 1 to Len - Length(S) do
      if LR = 'L' then
         Result := Car + Result
      else
         Result := Result + Car;
end;

function TDefFPRinter.IsReducaoAutomatica : Boolean;
var
  DadosReducao : String;
begin
  Result := False;
  case impressora of
    BematechMP20, BematechMP40, BematechTermica:
    begin
      DadosReducao := '';
      DadosReducao := IncCharEx(DadosReducao, 631, ' ', 'L');
      If DadosUltimaReducao(DadosReducao) Then
        Result := Copy(DadosReducao, 1, 2) = '01';
    end;

    Elgin:
    begin
      DadosReducao := '';
      DadosReducao := IncCharEx(DadosReducao, 631, ' ', 'L');
      If DadosUltimaReducao(DadosReducao) Then
        Result := Copy(DadosReducao, 1, 2) = '01';
    end;
  end;
end;

procedure TDefFPRinter.InicializaPChar(var P: PChar; const ALength: Integer);
begin
  P := PChar(IncCharEx('', ALength, ' ', 'L'));
end;


function TDefFPRinter._AFRAC_FloatToPontoFlutuante(Valor, Ponto : String; CasasDec : Byte): TPontoFlutuante;
begin
  Result := _AFRAC_FloatToPontoFlutuante(MyStrCurToFloat(Valor, Ponto), CasasDec);
end;


function TDefFPRinter._AFRAC_FloatToPontoFlutuante(Valor : Double; CasasDec : Byte): TPontoFlutuante;
var
  strFormat : String;
begin
  strFormat := '.';
  strFormat := IncCharEx(strFormat, CasasDec + 1, '0', 'R');
  strFormat := IncCharEx(strFormat, 1, '0', 'L');

  FillChar(Result, Length(Result), 0);
  StrPCopy(Result, IncCharEx(StringReplace(FormatFloat(strFormat, Valor), ',', '.', [rfReplaceAll]), 16, '0', 'L'));
end;

function TDefFPRinter._AFRAC_IntToTInteiro(Valor : Integer): TInteiro;
var
  strFormat : String;
begin
  strFormat := IntToStr(Valor);
  strFormat := IncCharEx(strFormat, Length(Result) - 1, '0', 'L');

  FillChar(Result, Length(Result), 0);
  StrPCopy(Result, strFormat);
end;

function TDefFPRinter._AFRAC_BooleanToAcrescDesc(Desconto : Boolean) : TAcreDesc;
begin
  FillChar(Result, Length(Result), 0);
  StrPCopy(Result, IntToStr(Byte(Desconto)));
end;

function TDefFPRinter.MyStrCurToFloat(Curr: string; Ponto : string): Double;
begin
  Result := MyStrToMoney(StringReplace(Curr, Ponto, DecimalSeparator, [rfReplaceAll]))
end;

function TDefFPRinter._AFRAC_BooleanToTBooleano(Expressao : Boolean) : TBooleano;
begin
  FillChar(Result, Length(Result), 0);
  StrPCopy(Result, IntToStr(Byte(Expressao)));
end;

function TDefFPRinter._AFRAC_BooleanToTPercValor(Expressao : Boolean) : TPercValor;
begin
  FillChar(Result, Length(Result), 0);
  StrPCopy(Result, IntToStr(Byte(Expressao)));
end;

procedure TDefFPRinter._AFRAC_InicializaArray(var A: Array of char);
begin
  FillChar(A, Length(A), 0);
end;

procedure TDefFPRinter._AFRAC_CopyStrToArray(var Dest: Array of char; Source: String);
begin
  _AFRAC_InicializaArray(Dest);
  StrPCopy(Dest, Source);
end;

function TDefFPrinter.DadosReducaoZ(var Dados: TRegDadosReducaoZ): Boolean;
begin
  case impressora of
    BematechMP20, BematechMP40:
    begin
      Result := _Bematech_Matr_DadosReducaoZ(Dados);
    end;

    BematechTermica:
    begin
      Result := _Bematech_Term_DadosReducaoZ(Dados);
    end;

    Sweda03, Sweda10:
    begin
      Result := _Sweda_DadosReducaoZ(Dados);
    end;

    Elgin:
    begin
      Result := _Elgin_DadosReducaoZ(Dados);
    end;

    DarumaMatr:
    begin
      Result := _Daruma_Matr_DadosReducaoZ(Dados);
    end;

    DarumaTerm:
    begin
      Result := _Daruma_Term_DadosReducaoZ(Dados);
    end;
  end;
end;

function TDefFPrinter._Daruma_Matr_DadosReducaoZ(var Dados: TRegDadosReducaoZ): Boolean;
var
  i: Integer;
  sNumCancelamentos: String;
  slFile, slTemp: TStringList;
  Stream: TStream;
  cVendaBruta: Currency;
  OldShortDateFormat: String;
  OldDecimalSeparator: Char;
begin
  // Mestre
  iRetorno := Daruma_FI_RelatorioTipo60Mestre;
  Result := (iRetorno = 1);
  Analisa_iRetorno;
  if not Result then Exit;

  SetLength(sNumCancelamentos, 4);
  iRetorno := Daruma_FI_NumeroCuponsCancelados(sNumCancelamentos);
  Result := (iRetorno = 1);
  Analisa_iRetorno;
  if not Result then Exit;

  Dados.ANumCancelamentos := StrToInt(sNumCancelamentos);

  OldShortDateFormat := ShortDateFormat;
  OldDecimalSeparator := DecimalSeparator;

  try
    ShortDateFormat := 'dd/mm/yy';
    DecimalSeparator := ',';

    slFile := TStringList.Create;
    slTemp := TStringList.Create;
    try
      Stream := TFileStream.Create('C:\RETORNO.TXT', fmOpenRead or fmShareDenyNone);
      try
        slFile.LoadFromStream(Stream);
      finally
        FreeAndNil(Stream);
      end;

      for i := 0 to Pred(slFile.Count) do
      begin
        Trim(slFile[i]);
        if slFile.Strings[i] <> '' then
          slTemp.Add(slFile.Strings[i]);
      end;

      for i := 0 to Pred(slTemp.Count) do
        case i of
          2: Dados.AMovDate := StrToDate(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))));
          3: Dados.ANumeroSerie := Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i])));
          4: Dados.ANumeroECF := StrToInt(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))));
          6: Dados.ACOOInicial := StrToInt(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))));
          7: Dados.ACOOFinal := StrToInt(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))));
          8: Dados.ANumReducaoZ := StrToInt(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))));
          10: cVendaBruta := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
          11: Dados.AGTFinal := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));

        end;

      Dados.AGTInicial := Dados.AGTFinal - cVendaBruta;

      if FileExists('C:\RETORNO.TXT') then
        DeleteFile('C:\RETORNO.TXT');
    finally
      FreeAndNil(slFile);
    end;

    // Analítico
    Daruma_FI_RelatorioTipo60Analitico;
    Result := (iRetorno = 1);
    Analisa_iRetorno;
    if not Result then Exit;

    slFile := TStringList.Create;
    slTemp := TStringList.Create;
    try
      Stream := TFileStream.Create('C:\RETORNO.TXT', fmOpenRead or fmShareDenyNone);
      try
        slFile.LoadFromStream(Stream);
      finally
        FreeAndNil(Stream);
      end;

      for i := 0 to Pred(slFile.Count) do
      begin
        Trim(slFile[i]);
        if slFile.Strings[i] <> '' then
          slTemp.Add(slFile.Strings[i]);
      end;

      for i := 0 to Pred(slTemp.Count) do
      begin
        case i of
          4: Dados.AValCancelamentos := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
          5: Dados.AValDescontos     := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
          6: Dados.ASubstituicaoTrib := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
          7: Dados.AIsencao          := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
          8: Dados.ANaoTributavel    := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
        end;

        if (i > 8) and (i < Pred(slTemp.Count)) then
          if StrToCurr(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll])) <> 0 then
          begin
            SetLength(Dados.AAliquota, Length(Dados.AAliquota)+1);
            Dados.AAliquota[Length(Dados.AAliquota)-1] := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], 1, Pos(':', slTemp.Strings[i])-1)), '.', '', [rfReplaceAll])) / 100;

            SetLength(Dados.ABaseCalculo, Length(Dados.ABaseCalculo)+1);
            Dados.ABaseCalculo[Length(Dados.ABaseCalculo)-1] := StrToCurr(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));

            SetLength(Dados.AValImposto, Length(Dados.AValImposto)+1);
            Dados.AValImposto[Length(Dados.AValImposto)-1] := Dados.ABaseCalculo[Length(Dados.ABaseCalculo)-1] * (Dados.AAliquota[Length(Dados.AAliquota)-1] / 100);
          end;
      end;

      if FileExists('C:\Retorno.TXT') then
        DeleteFile('C:\Retorno.TXT');
    finally
      FreeAndNil(slFile);
    end;
  finally
    DecimalSeparator := OldDecimalSeparator;
    ShortDateFormat := OldShortDateFormat;
  end;
end;

function TDefFPrinter.SintegraGerarRegistros(DataInicio, DataFim,
  Municipio, Fax, CodIdConvenio, CodIdNatureza, CodIdFinalidade,
  Logradouro, Numero, Complemento, Bairro, CEP, NomeContato,
  Telefone, Arquivo, Mes, Ano, RazaoSocial, Cidade: String;
  iRelatorios : Integer): Boolean;
begin

   Result := false;
   case Impressora of
      BematechMP40, BematechMP20, BematechTermica: begin

        {
         // Verifica quais registros serão gerados no relatorio
         iRelatorios := 0;
         if Check60M.Checked = True then iRelatorios := iRelatorios + 1;
         if Check60A.Checked = True then iRelatorios := iRelatorios + 2;
         if Check60D.Checked = True then iRelatorios := iRelatorios + 4;
         if Check60I.Checked = True then iRelatorios := iRelatorios + 8;
         if Check60R.Checked = True then iRelatorios := iRelatorios + 16;
         if Check75.Checked  = True then iRelatorios := iRelatorios + 32;

         // Apaga o arquivo SINTEGRA.TXT se existir
         if FileExists( 'SINTEGRA.TXT' ) then
            DeleteFile( 'SINTEGRA.TXT' );
        }

           iRetorno := Bematech_FI_RelatorioSintegraMFD(iRelatorios,
                                                        Arquivo,
                                                        Mes,
                                                        Ano,
                                                        RazaoSocial,
                                                        Logradouro,
                                                        Numero,
                                                        Complemento,
                                                        Bairro,
                                                        Cidade,
                                                        CEP,
                                                        Telefone,
                                                        Fax,
                                                        NomeContato);

           Analisa_iRetorno();
           Result:= (iRetorno=1);
      end;


      Sweda03, Sweda10:
      begin
           iRetorno := Sweda_RelatorioSintegraMFD(iRelatorios,
                                                  Arquivo,
                                                  Mes,
                                                  Ano,
                                                  RazaoSocial,
                                                  Logradouro,
                                                  Numero,
                                                  Complemento,
                                                  Bairro,
                                                  Cidade,
                                                  CEP,
                                                  Telefone,
                                                  Fax,
                                                  NomeContato);

           Analisa_iRetorno();
           Result:= (iRetorno=1);
      end;

      DarumaMatr, DarumaTerm:
      begin

        DataInicio := Copy(DataInicio, 1, 2) + Copy(DataInicio, 4, 2) + Copy(DataInicio, 9, 2);
        DataFim    := Copy(DataFim, 1, 2) + Copy(DataFim, 4, 2) + Copy(DataFim, 9, 2);;

        iRetorno := Daruma_Sintegra_GerarRegistrosArq(DataInicio,
                                                      DataFim,
                                                      Municipio,
                                                      Fax,
                                                      CodIdConvenio,
                                                      CodIdNatureza,
                                                      CodIdFinalidade,
                                                      Logradouro,
                                                      Numero,
                                                      Complemento,
                                                      Bairro,
                                                      CEP,
                                                      NomeContato,
                                                      Telefone);

        Result:= (iRetorno=1);
        Analisa_iRetorno();
      end;

   end;

   Result := Result And Retorno_Impressora();

end;

function TDefFPrinter.SintegraGerarRegistro10(DataInicio, DataFim,
  Municipio, Fax, CodIdConvenio, CodIdNatureza, CodIdFinalidade : String;
  var Retorno: String): Boolean;
begin

   Result := false;
   case Impressora of

      DarumaMatr, DarumaTerm:
      begin
        DataInicio := Copy(DataInicio, 1, 2) + Copy(DataInicio, 4, 2) + Copy(DataInicio, 9, 2);
        DataFim    := Copy(DataFim, 1, 2) + Copy(DataFim, 4, 2) + Copy(DataFim, 9, 2);;

        iRetorno := Daruma_Sintegra_GerarRegistro10(DataInicio,
                                                    DataFim,
                                                    Municipio,
                                                    Fax,
                                                    CodIdConvenio,
                                                    CodIdNatureza,
                                                    CodIdFinalidade,
                                                    Retorno);
        Result:= (iRetorno=1);
        Analisa_iRetorno();
      end;

   end;

   Result := Result And Retorno_Impressora();

end;

function TDefFPrinter.SintegraGerarRegistro11(Logradouro, Numero,
  Complemento, Bairro, CEP, NomeContato, Telefone : String;
  var Retorno: String): Boolean;
begin

   Result := false;
   case Impressora of
      DarumaMatr, DarumaTerm:
      begin
        iRetorno := Daruma_Sintegra_GerarRegistro11(Logradouro,
                                                    Numero,
                                                    Complemento,
                                                    Bairro,
                                                    CEP,
                                                    NomeContato,
                                                    Telefone,
                                                    Retorno);
        Result:= (iRetorno=1);
        Analisa_iRetorno();
      end;

   end;

   Result := Result And Retorno_Impressora();

end;

function TDefFPrinter.SintegraGerarRegistro60A(DataInicio, DataFim : String;
  var Retorno: String): Boolean;
begin

   Result := false;
   case Impressora of
      DarumaMatr, DarumaTerm:
      begin
        DataInicio := Copy(DataInicio, 1, 2) + Copy(DataInicio, 4, 2) + Copy(DataInicio, 9, 2);
        DataFim    := Copy(DataFim, 1, 2) + Copy(DataFim, 4, 2) + Copy(DataFim, 9, 2);;

        iRetorno := Daruma_Sintegra_GerarRegistro60A(DataInicio,
                                                     DataFim,
                                                     Retorno);
        Result:= (iRetorno=1);
        Analisa_iRetorno();
      end;

   end;

   Result := Result And Retorno_Impressora();

end;

function TDefFPrinter.SintegraGerarRegistro60D(DataInicio, DataFim : String;
  var Retorno: String): Boolean;
begin

   Result := false;
   case Impressora of
      DarumaMatr, DarumaTerm:
      begin
        DataInicio := Copy(DataInicio, 1, 2) + Copy(DataInicio, 4, 2) + Copy(DataInicio, 9, 2);
        DataFim    := Copy(DataFim, 1, 2) + Copy(DataFim, 4, 2) + Copy(DataFim, 9, 2);;

        iRetorno := Daruma_Sintegra_GerarRegistro60D(DataInicio,
                                                     DataFim,
                                                     Retorno);
        Result:= (iRetorno=1);
        Analisa_iRetorno();
      end;

   end;

   Result := Result And Retorno_Impressora();

end;

function TDefFPrinter.SintegraGerarRegistro60I(DataInicio, DataFim : String;
  var Retorno: String): Boolean;
begin

   Result := false;
   case Impressora of
      DarumaMatr, DarumaTerm:
      begin
        DataInicio := Copy(DataInicio, 1, 2) + Copy(DataInicio, 4, 2) + Copy(DataInicio, 9, 2);
        DataFim    := Copy(DataFim, 1, 2) + Copy(DataFim, 4, 2) + Copy(DataFim, 9, 2);;

        iRetorno := Daruma_Sintegra_GerarRegistro60I(DataInicio,
                                                     DataFim,
                                                     Retorno);
        Result:= (iRetorno=1);
        Analisa_iRetorno();
      end;

   end;

   Result := Result And Retorno_Impressora();

end;

function TDefFPrinter.SintegraGerarRegistro60M(DataInicio, DataFim : String;
  var Retorno: String): Boolean;
begin

   Result := false;
   case Impressora of
      DarumaMatr, DarumaTerm:
      begin
        DataInicio := Copy(DataInicio, 1, 2) + Copy(DataInicio, 4, 2) + Copy(DataInicio, 9, 2);
        DataFim    := Copy(DataFim, 1, 2) + Copy(DataFim, 4, 2) + Copy(DataFim, 9, 2);;

        iRetorno := Daruma_Sintegra_GerarRegistro60M(DataInicio,
                                                     DataFim,
                                                     Retorno);
        Result:= (iRetorno=1);
        Analisa_iRetorno();
      end;

   end;

   Result := Result And Retorno_Impressora();

end;

function TDefFPrinter.SintegraGerarRegistro60R(DataInicio, DataFim : String;
  var Retorno: String): Boolean;
begin

   Result := false;
   case Impressora of
      DarumaMatr, DarumaTerm:
      begin
        DataInicio := Copy(DataInicio, 1, 2) + Copy(DataInicio, 4, 2) + Copy(DataInicio, 9, 2);
        DataFim    := Copy(DataFim, 1, 2) + Copy(DataFim, 4, 2) + Copy(DataFim, 9, 2);;

        iRetorno := Daruma_Sintegra_GerarRegistro60R(DataInicio,
                                                     DataFim,
                                                     Retorno);
        Result:= (iRetorno=1);
        Analisa_iRetorno();
      end;

   end;

   Result := Result And Retorno_Impressora();

end;

function TDefFPrinter.SintegraGerarRegistro90(var Retorno: String): Boolean;
begin

   Result := false;
   case Impressora of
      DarumaMatr, DarumaTerm:
      begin
        iRetorno := Daruma_Sintegra_GerarRegistro90(Retorno);
        Result:= (iRetorno=1);
        Analisa_iRetorno();
      end;

   end;

   Result := Result And Retorno_Impressora();

end;

function TDefFPrinter.SintegraRegistryPath(Path: String): Boolean;
begin

   Result := false;
   case Impressora of
      DarumaMatr, DarumaTerm:
      begin
        iRetorno := Daruma_Registry_SintegraPath(Path);
        Result:= (iRetorno=1);
        Analisa_iRetorno();
      end;

   end;

   Result := Result And Retorno_Impressora();
end;

function TDefFPrinter.SintegraRegistrySeparador(
  Separador: String): Boolean;
begin

   Result := false;
   case Impressora of
      DarumaMatr, DarumaTerm:
      begin
        iRetorno := Daruma_Registry_SintegraSeparador(Separador);
        Result:= (iRetorno=1);
        Analisa_iRetorno();
      end;

   end;

   Result := Result And Retorno_Impressora();

end;

function TDefFPrinter.RetornaTotalizadorParcial(var AResultado : String): Boolean;
var
  Str_Valor: String;
begin

   Result := False;
   case impressora of
     DarumaMatr, DarumaTerm:
     begin
        setlength(Str_valor, 1164);
        iRetorno := Daruma_FIMFD_RetornaInformacao('140', Str_valor);
        Analisa_iRetorno();
        Result := (iRetorno=1);
        AResultado := Copy(Str_valor, 843, 80);
     end;

     BematechMP20, BematechMP40, BematechTermica:
     begin
        SetLength(Str_valor, 1278);
        iRetorno := Bematech_DadosUltimaReducaoMFD(Str_valor);
        Analisa_iRetorno();
        Result:= (iRetorno=1);
        AResultado := Copy(Str_valor, 1208, 64);
     end;

     Sweda03, Sweda10:
     begin
        SetLength(Str_valor, 1278);
        iRetorno := Sweda_DadosUltimaReducaoMFD(PChar(Str_valor));
        Analisa_iRetorno();
        Result:= (iRetorno=1);
        AResultado := Copy(Str_valor, 1208, 64);
     end;


     Elgin:
     begin
     end;

     SCFI:
     begin
     end;

   end;

   Result := Result And Retorno_Impressora;

end;

function TDefFPrinter.RetornaInformacao(Indice: String; Tamanho : Integer;
  var Resultado: String): Boolean;
var
  Str_Valor: String;
begin

   Result := False;
   case impressora of
     DarumaMatr, DarumaTerm:
     begin
        setlength(Str_valor, Tamanho);

        iRetorno := Daruma_FIMFD_RetornaInformacao(Indice, Str_valor);
        Analisa_iRetorno();
        Result := (iRetorno=1);
        Resultado := Str_valor;
     end;

     BematechMP20, BematechMP40, BematechTermica:
     begin
     end;

     Sweda03, Sweda10:
     begin
     end;

     Elgin:
     begin
     end;

     SCFI:
     begin
     end;

   end;

   Result := Result And Retorno_Impressora;

end;

function TDefFPrinter._Daruma_Term_DadosReducaoZ(var Dados: TRegDadosReducaoZ): Boolean;
var
  i, iICMS, iISSQN: Integer;
  sCodigo,
  sValorAcumulado,
  sResultado, sResultado2: String;
begin
  if RetornaInformacao('140', 1164, sResultado) then
  begin
    Dados.AMovDate          := FormatarDataImpressora(Copy(sResultado, 1, 8));
    Dados.ANumReducaoZ      := StrToInt(Copy(sResultado, 927, 4));
    Dados.AValCancelamentos := StrToCurr(Copy(sResultado, 73, 14))/100;
    Dados.AValDescontos     := StrToCurr(Copy(sResultado, 45, 14))/100;

    if StrToCurr(Copy(sResultado, 27, 18)) <> 0 then
      Dados.AGTInicial := StrToCurr(Copy(sResultado, 27, 18))/100
    else
      Dados.AGTInicial := 0;

    if StrToCurr(Copy(sResultado, 9, 18)) <> 0 then
      Dados.AGTFinal := StrToCurr(Copy(sResultado, 9, 18))/100
    else
      Dados.AGTFinal := 0;

    Dados.ASubstituicaoTrib := (StrToCurr(Copy(sResultado, 353, 14)) +
                                 StrToCurr(Copy(sResultado, 367, 14)) +
                                 StrToCurr(Copy(sResultado, 437, 14)) +
                                 StrToCurr(Copy(sResultado, 451, 14)))/100;

    Dados.AIsencao := (StrToCurr(Copy(sResultado, 381, 14)) +
                        StrToCurr(Copy(sResultado, 395, 14)) +
                        StrToCurr(Copy(sResultado, 465, 14)) +
                        StrToCurr(Copy(sResultado, 479, 14)))/100;

    Dados.ANaoTributavel := (StrToCurr(Copy(sResultado, 409, 14)) +
                              StrToCurr(Copy(sResultado, 423, 14)) +
                              StrToCurr(Copy(sResultado, 493, 14)) +
                              StrToCurr(Copy(sResultado, 507, 14)))/100;

    Dados.AContadorReducaoZ := StrToInt(Copy(sResultado, 927, 4));

    Dados.AContadorOrdemOperacao := StrToInt(Copy(sResultado, 935, 6));

    Dados.AContadorReinicioOperacao := StrToInt(Copy(sResultado, 923, 4));

    // 1 – ICMS e 2 – ISSQN
    sCodigo := Copy(sResultado, 843, 80);
    sValorAcumulado := Copy(sResultado, 129, 224);

    for i := 0 to 15 do
    begin
      if StrToFloat(Copy(sCodigo, (i*5)+2, 4)) <> 0 then
      begin
        // Dados para Sal_TributacaoECF
        SetLength(Dados.AAliquota, i+1);
        Dados.AAliquota[i] := StrToFloat(Copy(sCodigo, (i*5)+2, 4))/100;

        SetLength(Dados.ABaseCalculo, i+1);
        Dados.ABaseCalculo[i] := StrToCurr(Copy(sValorAcumulado, (i*14)+1, 14))/100;

        SetLength(Dados.AValImposto, i+1);
        Dados.AValImposto[i] := Dados.ABaseCalculo[i] * (Dados.AAliquota[i]/100);

        // Dados para Sal_TotalizadorParcial
        SetLength(Dados.ATribReducaoZList, i+1);
        if Copy(sCodigo, (i*5)+1, 1) = '1' then
        begin
          Inc(iICMS);
          if Length(IntToStr(iICMS)) = 1 then
            Dados.ATribReducaoZList[i].Codigo := '0' + IntToStr(iICMS) + 'T' + Copy(sCodigo, (i*5)+2, 4)
          else if Length(IntToStr(iICMS)) = 2 then
            Dados.ATribReducaoZList[i].Codigo := IntToStr(iICMS) + 'T' + Copy(sCodigo, (i*5)+2, 4);
        end
        else if Copy(sCodigo, (i*5)+1, 1) = '2' then
        begin
          Inc(iISSQN);
          if Length(IntToStr(iISSQN)) = 1 then
            Dados.ATribReducaoZList[i].Codigo := '0' + IntToStr(iISSQN) + 'T' + Copy(sCodigo, (i*5)+2, 4)
          else if Length(IntToStr(iISSQN)) = 2 then
            Dados.ATribReducaoZList[i].Codigo := IntToStr(iISSQN) + 'T' + Copy(sCodigo, (i*5)+2, 4);
        end;

        Dados.ATribReducaoZList[i].ValorAcumulado := StrToCurr(Copy(sValorAcumulado, (i*14)+1, 14))/100;
      end;
    end;

  end;

  if RetornaInformacao('78', 21, sResultado) then
  begin
    Dados.ANumeroSerie := Copy(sResultado, 1, 20);
    Dados.AMFAdicional := Copy(sResultado, 21, 1);
  end;

  if NumeroLoja(sResultado) then
    Dados.ANumeroLoja := StrToInt(sResultado);

  if RetornaInformacao('107', 3, sResultado) then
    Dados.ANumeroECF := StrToInt(Copy(sResultado, 1, 3));


  if COO(sResultado, sResultado2) then
  begin
    Dados.ACOOInicial := StrToInt(sResultado);
    Dados.ACOOFinal := StrToInt(sResultado2);
  end;

  if NumeroCuponsCancelados(sResultado) then
    Dados.ANumCancelamentos := StrToInt(sResultado);


  if RetornaInformacao('79', 7, sResultado) then
    Dados.ATipoECF := Copy(sResultado, 1, 7);

  if RetornaInformacao('80', 20, sResultado) then
    Dados.AMarcaECF := Copy(sResultado, 1, 20);

  if RetornaInformacao('81', 20, sResultado) then
    Dados.AModeloECF := Copy(sResultado, 1, 20);

  if RetornaInformacao('83', 6, sResultado) then
    Dados.AVersaoSBECF := Copy(sResultado, 1, 6);

  if RetornaInformacao('85', 14, sResultado) then
    Dados.ADataInstalacaoSBECF := FormatarDataHoraImpressora(Copy(sResultado, 1, 14));

  if RetornaInformacao('94', 2, sResultado) then
    Dados.ANumeroUsuarioECF := StrToInt(Copy(sResultado, 1, 2));

  if RetornaInformacao('109', 1, sResultado) then
    Dados.AIncideISSQN := StrToBool(Copy(sResultado, 1, 1));

  if DataHoraReducao(sResultado, sResultado2) then
    Dados.ADataEmissao := FormatarDataHoraImpressora(sResultado + sResultado2);

end;

function TDefFPrinter._Bematech_Matr_DadosReducaoZ(var Dados: TRegDadosReducaoZ): Boolean;
var
  i: Integer;
  sNumCancelamentos: String;
  slFile, slTemp: TStringList;
  Stream: TStream;
  cVendaBruta: Currency;
  OldShortDateFormat: String;
  OldDecimalSeparator: Char;
begin
  // Mestre
  Bematech_RelatorioTipo60Mestre;
  SetLength(sNumCancelamentos, 4);
  iRetorno := Bematech_NumeroCuponsCancelados(sNumCancelamentos);

  Result := (iRetorno = 0);
  Analisa_iRetorno;
  if not Result then Exit;

  Dados.ANumCancelamentos := StrToInt(sNumCancelamentos);

  slFile := TStringList.Create;
  slTemp := TStringList.Create;
  try
    Stream := TFileStream.Create('C:\Retorno.TXT', fmOpenRead or fmShareDenyNone);
    try
      slFile.LoadFromStream(Stream);
    finally
      FreeAndNil(Stream);
    end;

    for i := 0 to Pred(slFile.Count) do
    begin
      Trim(slFile[i]);
      if slFile.Strings[i] <> '' then
        slTemp.Add(slFile.Strings[i]);
    end;

    for i := 0 to Pred(slTemp.Count) do
      case i of
        2: Dados.AMovDate := StrToDate(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))));
        3: Dados.ANumeroSerie := Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i])));
        4: Dados.ANumeroECF := StrToInt(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))));
        6: Dados.ACOOInicial := StrToInt(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))));
        7: Dados.ACOOFinal := StrToInt(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))));
        8: Dados.ANumReducaoZ := StrToInt(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))));
        10: cVendaBruta := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
        11: Dados.AGTFinal := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
      end;

    Dados.AGTInicial := Dados.AGTFinal - cVendaBruta;

    if FileExists('C:\Retorno.TXT') then
      DeleteFile('C:\Retorno.TXT');
  finally
    FreeAndNil(slFile);
  end;

  // Analítico
  Bematech_RelatorioTipo60Analitico;

  slFile := TStringList.Create;
  slTemp := TStringList.Create;
  try
    Stream := TFileStream.Create('C:\Retorno.TXT', fmOpenRead or fmShareDenyNone);
    try
      slFile.LoadFromStream(Stream);
    finally
      FreeAndNil(Stream);
    end;

    for i := 0 to Pred(slFile.Count) do
    begin
      Trim(slFile[i]);
      if slFile.Strings[i] <> '' then
        slTemp.Add(slFile.Strings[i]);
    end;

    for i := 0 to Pred(slTemp.Count) do
    begin
      case i of
        4: Dados.AValCancelamentos := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
        5: Dados.AValDescontos     := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
        6: Dados.ASubstituicaoTrib := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
        7: Dados.AIsencao          := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
        8: Dados.ANaoTributavel    := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
      end;

      if (i > 8) and (i < Pred(slTemp.Count)) then
        if StrToCurr(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll])) <> 0 then
        begin
          SetLength(Dados.AAliquota, Length(Dados.AAliquota)+1);
          Dados.AAliquota[Length(Dados.AAliquota)-1] := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], 1, Pos(':', slTemp.Strings[i])-1)), '.', '', [rfReplaceAll])) / 100;

          SetLength(Dados.ABaseCalculo, Length(Dados.ABaseCalculo)+1);
          Dados.ABaseCalculo[Length(Dados.ABaseCalculo)-1] := StrToCurr(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));

          SetLength(Dados.AValImposto, Length(Dados.AValImposto)+1);
          Dados.AValImposto[Length(Dados.AValImposto)-1] := Dados.ABaseCalculo[Length(Dados.ABaseCalculo)-1] * (Dados.AAliquota[Length(Dados.AAliquota)-1] / 100);
        end;
    end;

    if FileExists('C:\Retorno.TXT') then
      DeleteFile('C:\Retorno.TXT');
  finally
    FreeAndNil(slFile);
  end;
end;

function TDefFPrinter._Bematech_Term_DadosReducaoZ(var Dados: TRegDadosReducaoZ): Boolean;
var
  sResultado: String;
  sCodigo, sValorAcumulado, sIndexISS, sIndex : String;
  i, iICMS, iISSQN, iRetorno : Integer;
  sGTInicial, sGTFinal : String;
  sNumeroSubstituicoes : String;
  sData, sHora : String;
begin

  SetLength(sGTInicial, 18);
  SetLength(sGTFinal, 18);

  VerificaIndiceAliquotasIss(sIndexISS);

  if DadosUltimaReducaoMFD(sResultado) then
  begin
    Dados.AMovDate := FormatarDataImpressora(Copy(sResultado, 1273, 6));

    Dados.ANumReducaoZ := StrToInt(Copy(sResultado, 9, 4));

    Dados.ASubstituicaoTrib := (StrToCurr(Copy(sResultado, 590, 14)) +
                                StrToCurr(Copy(sResultado, 635, 14)))/100;

    Dados.AIsencao := (StrToCurr(Copy(sResultado, 560, 14)) +
                       StrToCurr(Copy(sResultado, 605, 14)))/100;

    Dados.ANaoTributavel := (StrToCurr(Copy(sResultado, 575, 14)) +
                             StrToCurr(Copy(sResultado, 620, 14)))/100;

    Dados.AContadorReducaoZ := StrToInt(Copy(sResultado, 9, 4));

    Dados.AContadorOrdemOperacao := StrToInt(Copy(sResultado, 14, 6));

    Dados.AContadorReinicioOperacao := StrToInt(Copy(sResultado, 4, 4));

    Dados.AValCancelamentos := StrToCurr(Copy(sResultado, 710, 14))/100;

    Dados.ANumCancelamentos := StrToInt(Copy(sResultado, 54, 4));

    Dados.AValDescontos := (StrToCurr(Copy(sResultado, 650, 14)) + StrToCurr(Copy(sResultado, 665, 14)))/100;


    // 1 – ICMS e 2 – ISSQN
    sCodigo := Copy(sResultado, 1208, 64);
    sValorAcumulado := Copy(sResultado, 335, 204);

    for i := 0 to 15 do
    begin
      if StrToFloat(Copy(sCodigo, (i*4)+1, 4)) <> 0 then
      begin
        // Dados para Sal_TributacaoECF
        SetLength(Dados.AAliquota, i+1);
        Dados.AAliquota[i] := StrToFloat(Copy(sCodigo, (i*4)+1, 4))/100;

        SetLength(Dados.ABaseCalculo, i+1);
        Dados.ABaseCalculo[i] := StrToCurr(Copy(sValorAcumulado, (i*14)+1, 14))/100;

        SetLength(Dados.AValImposto, i+1);
        Dados.AValImposto[i] := Dados.ABaseCalculo[i] * (Dados.AAliquota[i]/100);

        // Dados para Sal_TotalizadorParcial
        SetLength(Dados.ATribReducaoZList, i+1);
        //if (Copy(sCodigo, (i*4)+1, 1) = '1') or (Copy(sCodigo, (i*4)+1, 1) = '0') then

        sIndex := FormatFloat('00', i+1);

        if Pos(sIndex, sIndexISS) = 0 then
        begin
          Inc(iICMS);
          if Length(IntToStr(iICMS)) = 1 then
            Dados.ATribReducaoZList[i].Codigo := '0' + IntToStr(iICMS) + 'T' + Copy(sCodigo, (i*4)+1, 4)
          else if Length(IntToStr(iICMS)) = 2 then
            Dados.ATribReducaoZList[i].Codigo := IntToStr(iICMS) + 'T' + Copy(sCodigo, (i*4)+1, 4);
        end
        else //ISS
        begin
          Inc(iISSQN);
          if Length(IntToStr(iISSQN)) = 1 then
            Dados.ATribReducaoZList[i].Codigo := '0' + IntToStr(iISSQN) + 'T' + Copy(sCodigo, (i*4)+1, 4)
          else if Length(IntToStr(iISSQN)) = 2 then
            Dados.ATribReducaoZList[i].Codigo := IntToStr(iISSQN) + 'T' + Copy(sCodigo, (i*4)+1, 4);
        end;

        Dados.ATribReducaoZList[i].ValorAcumulado := StrToCurr(Copy(sValorAcumulado, (i*14)+1, 14))/100;
      end;
    end;

  end;

  if InicioFimGTsMFD(sGTInicial, sGTFinal) then
  begin
    Dados.AGTInicial := StrToCurr(sGTInicial)/100;
    Dados.AGTFinal := StrToCurr(sGTFinal)/100;
  end;

  Dados.AIncideISSQN := False;

  Result := True;

end;

function TDefFPrinter.InicioFimGTsMFD(var cGTInicial: String; var cGTFinal: String ) : Boolean;
begin
   Result := False;

   case impressora of
     DarumaMatr, DarumaTerm:
     begin
     end;

     BematechMP20, BematechMP40, BematechTermica:
     begin
        iRetorno := Bematech_FI_InicioFimGTsMFD(cGTInicial, cGTFinal);
        Analisa_iRetorno();
        Result := (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
        iRetorno := Sweda_InicioFimGTsMFD(cGTInicial, cGTFinal);
        Analisa_iRetorno();
        Result := (iRetorno=1);
     end;

     Elgin:
     begin
     end;

     SCFI:
     begin
     end;

   end;

   Result := Result And Retorno_Impressora;
end;

function TDefFPrinter.COO(var Inicial, Final: String): Boolean;
var
  COOInicial, COOFinal: String;
begin
   Result := False;

   case impressora of
     DarumaMatr, DarumaTerm:
     begin
       SetLength(COOInicial, 6);
       SetLength(COOFinal, 6);
       iRetorno := Daruma_FI_COO(COOInicial, COOFinal);
       Analisa_iRetorno();
       Result := (iRetorno=1);
       Inicial := COOInicial;
       Final   := COOFinal;
     end;

     BematechMP20, BematechMP40, BematechTermica:
     begin
        iRetorno := Bematech_FI_InicioFimCOOsMFD(Inicial, Final);
        Analisa_iRetorno();
        Result := (iRetorno=1);
     end;

     Sweda03, Sweda10:
     begin
        SetLength(COOInicial, 6);
        SetLength(COOFinal, 6);
        iRetorno := Sweda_InicioFimCOOsMFD(PChar(Inicial), PChar(Final));
        Analisa_iRetorno();
        Result := (iRetorno=1);
     end;

     Elgin:
     begin
     end;

     SCFI:
     begin
     end;

   end;

   Result := Result And Retorno_Impressora;
end;

function TDefFPrinter.RetornaCancelamentoNF(CancelamentoNF: String): Boolean;
var
  Str_Valor: String;
begin
   Result := False;
   SetLength(Str_Valor, 14);

   case impressora of
     DarumaMatr, DarumaTerm:
     begin
        iRetorno := Daruma_FI_RetornaCancelamentoNF(Str_Valor);
        Analisa_iRetorno();
        Result := (iRetorno=1);
     end;

     BematechMP20, BematechMP40, BematechTermica:
     begin
     end;

     Sweda03, Sweda10:
     begin
     end;

     Elgin:
     begin
     end;

     SCFI:
     begin
     end;

   end;

   Result := Result And Retorno_Impressora;
   if Result then
     CancelamentoNF := Str_Valor;
end;

function TDefFPrinter.FormatarDataImpressora(Data: String): TDateTime;
var
  Dia, Mes, Ano: Word;
begin
  Dia := StrToInt(Copy(Data, 1, 2));
  Mes := StrToInt(Copy(Data, 3, 2));
  Ano := StrToInt(Copy(Data, 5, 4));

  if Length(Data) = 14 then
    Ano := StrToInt(Copy(Data, 5, 4))
  else
    Ano := StrToInt('20' + Copy(Data, 5, 2));

  Result := EncodeDate(Ano, Mes, Dia);
end;

function TDefFPrinter.FormatarDataHoraImpressora(DataHora: String): TDateTime;
var
  Dia, Mes, Ano, Hor, Min, Seg: Word;
begin
  Dia := StrToInt(Copy(DataHora, 1, 2));
  Mes := StrToInt(Copy(DataHora, 3, 2));

  if Length(DataHora) = 14 then
  begin
    Ano := StrToInt(Copy(DataHora, 5, 4));
    Hor := StrToInt(Copy(DataHora, 9, 2));
    Min := StrToInt(Copy(DataHora, 11, 2));
    Seg := StrToInt(Copy(DataHora, 13, 2));
  end
  else
  begin
    Ano := StrToInt('20' + Copy(DataHora, 5, 2));
    Hor := StrToInt(Copy(DataHora, 7, 2));
    Min := StrToInt(Copy(DataHora, 9, 2));
    Seg := StrToInt(Copy(DataHora, 11, 2));
  end;

  Result := EncodeDateTime(Ano, Mes, Dia, Hor, Min, Seg, 0);
end;

function TDefFPrinter.MFD_LeituraMemoriaFiscal(Index: String): Boolean;
begin

   Result := False;

   case Impressora of
      None: Result := false;
      Dataregis: result := True;
      Sweda03, Sweda10:
      begin
      end;
      NCR2x, NCR7141, NCR1x: ;
      Urano2EFE: ;
      Urano1EFC, Urano2EFC:
         begin
         end;
      Urano1FIT:
         begin
         end;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
         end;
      Schalter3D:
         begin
         end;
      Schalter2S: Result := retsch2(Schalter2S_ecfImpCab(0));
      SCFI:
         begin
         end;
      BematechMP40, BematechMP20, BematechTermica: begin
      {
           iRetorno := Bematech_AbreCupom(CGC);
           Analisa_iRetorno();
           Result:= (iRetorno=1);
      }
      end;
      Elgin: begin
      {
           iRetorno := Elgin_AbreCupom(CGC);
           Analisa_iRetorno();
           Result:= (iRetorno=1);
      }
      end;
      Procomp_2011: LeProComp(Procomp_AbreCupomFiscal, True);
      Trends10E:
         begin
         end;

      AFRAC:
      begin
      end;

      DarumaMatr, DarumaTerm:
      begin
        iRetorno := Daruma_Registry_MFD_LeituraMFCompleta(Index);
        Result:= (iRetorno=1);
        Analisa_iRetorno();
      end;

   end;

   Result := Result And Retorno_Impressora();

end;

function TDefFPrinter.FIMFD_DownloadDaMFD(Str_Inicial,
  Str_Final, Str_Tipo: String): Boolean;
var
  cArquivo, cUsuario : String;
begin

   Result := False;

   case Impressora of
      None: Result := false;
      Dataregis: result := True;
      NCR2x, NCR7141, NCR1x: ;
      Urano2EFE: ;
      Urano1EFC, Urano2EFC:
         begin
         end;
      Urano1FIT:
         begin
         end;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41:
         begin
         end;
      Schalter3D:
         begin
         end;
      Schalter2S: Result := retsch2(Schalter2S_ecfImpCab(0));
      SCFI:
         begin
         end;
      BematechMP40, BematechMP20, BematechTermica:
      begin
           cArquivo := 'DOWNLOAD.MFD';
           cUsuario := '1';
           iRetorno := Bematech_FI_DownloadMFD(pchar(cArquivo), pchar(Str_Tipo), pchar(Str_Inicial), pchar(Str_Final), pchar(cUsuario));
           Analisa_iRetorno();
           Result:= (iRetorno=1);
      end;

      Sweda03, Sweda10:
      begin
        cArquivo := 'DOWNLOAD.MFD';
        cUsuario := '1';
        iRetorno := Sweda_DownloadMFD(pchar(cArquivo), pchar(Str_Tipo), pchar(Str_Inicial), pchar(Str_Final), pchar(cUsuario));
        Analisa_iRetorno();
        Result:= (iRetorno=1);
      end;

      Elgin:
      begin
           cArquivo := 'DOWNLOAD.TXT';
           cUsuario := '1';
           iRetorno := Elgin_DownloadMFD(cArquivo, Str_Tipo, Str_Inicial, Str_Final, cUsuario);
           Analisa_iRetorno();
           Result:= (iRetorno=1);
      end;
      Procomp_2011: LeProComp(Procomp_AbreCupomFiscal, True);
      Trends10E:
         begin
         end;

      AFRAC:
      begin
      end;

      DarumaMatr, DarumaTerm:
      begin
        iRetorno := Daruma_FIMFD_DownloadDaMFD(pchar(Str_Inicial), pchar(Str_Final));
        Result:= (iRetorno=1);
        Analisa_iRetorno();
      end;

   end;

   Result := Result And Retorno_Impressora();

end;

function TDefFPrinter.ObtemRetornoECF(
  var strMensagemErro: String): Boolean;
var
  iRetorno, iCodErro: Integer;
  strErroMsg: String;
  bSucesso: Boolean;
begin

  case Impressora of
    Elgin:
        begin
          strErroMsg := StringOfChar(' ',100);
          iRetorno    := Elgin_RetornoImpressora(iCodErro, strErroMsg);
          strMensagemErro := 'Erro nº: ' + intToStr(iCodErro) + ' - ' + strErroMsg;

          If (iRetorno = 1) Then
            bSucesso := True
          Else
            bSucesso := False;

          ObtemRetornoECF := bSucesso;
        end;
  end;
end;

function TDefFPrinter._Elgin_DadosReducaoZ(
  var Dados: TRegDadosReducaoZ): Boolean;
var
  i, iICMS, iISSQN : Integer;
  sNumCancelamentos, sDadosReducaoZ,
  sCodigo, sValorAcumulado, sIndexISS, sIndex : String;
begin

  Result := _Elgin_DadosSintegra(Dados);

  if Result and DadosUltimaReducaoMFD(sDadosReducaoZ) then
  begin

    Dados.AContadorReinicioOperacao := StrToInt(Copy(sDadosReducaoZ, 4, 4));
    Dados.AContadorReducaoZ         := StrToInt(Copy(sDadosReducaoZ, 9, 4));
    Dados.AContadorOrdemOperacao    := StrToInt(Copy(sDadosReducaoZ, 14, 6));

    // 1 – ICMS e 2 – ISSQN
    sCodigo := Copy(sDadosReducaoZ, 1208, 64);
    sValorAcumulado := Copy(sDadosReducaoZ, 335, 224);

    for i := 0 to 8 do
    begin
      if StrToFloatDef(Copy(sCodigo, (i*4)+1, 4), 0) <> 0 then
      begin
        // Dados para Sal_TributacaoECF
        SetLength(Dados.AAliquota, i+1);
        Dados.AAliquota[i] := StrToFloat(Copy(sCodigo, (i*4)+1, 4))/100;

        SetLength(Dados.ABaseCalculo, i+1);
        Dados.ABaseCalculo[i] := StrToCurr(Copy(sValorAcumulado, (i*14)+1, 14))/100;

        SetLength(Dados.AValImposto, i+1);
        Dados.AValImposto[i] := Dados.ABaseCalculo[i] * (Dados.AAliquota[i]/100);

        // Dados para Sal_TotalizadorParcial
        SetLength(Dados.ATribReducaoZList, i+1);
        //if (Copy(sCodigo, (i*4)+1, 1) = '1') or (Copy(sCodigo, (i*4)+1, 1) = '0') then

        sIndex := FormatFloat('00', i);

        if Pos(sIndex, sIndexISS) = 0 then
        begin
          if Length(IntToStr(iICMS)) = 1 then
            Dados.ATribReducaoZList[i].Codigo := '0' + IntToStr(iICMS) + 'T' + Copy(sCodigo, (i*4)+1, 4)
          else if Length(IntToStr(iICMS)) = 2 then
            Dados.ATribReducaoZList[i].Codigo := IntToStr(iICMS) + 'T' + Copy(sCodigo, (i*4)+1, 4);
          Inc(iICMS);
        end
        else //ISS
        begin
          if Length(IntToStr(iISSQN)) = 1 then
            Dados.ATribReducaoZList[i].Codigo := '0' + IntToStr(iISSQN) + 'T' + Copy(sCodigo, (i*4)+1, 4)
          else if Length(IntToStr(iISSQN)) = 2 then
            Dados.ATribReducaoZList[i].Codigo := IntToStr(iISSQN) + 'T' + Copy(sCodigo, (i*4)+1, 4);
          Inc(iISSQN);
        end;

        Dados.ATribReducaoZList[i].ValorAcumulado := StrToCurr(Copy(sValorAcumulado, (i*14)+1, 14))/100;
      end;
    end;

{
    Dados.AMovDate **** Sem Hora
    Dados.ANumCancelamentos
}

  end;


  Result := True;


end;

function TDefFPrinter._Elgin_DadosSintegra(
  var Dados: TRegDadosReducaoZ): Boolean;
var
  i : Integer;
  slFile, slTemp: TStringList;
  Stream: TStream;
  cVendaBruta: Currency;
begin

  if FileExists('C:\Retorno.TXT') then
    DeleteFile('C:\Retorno.TXT');

  // Mestre
  Elgin_RelatorioTipo60Mestre;

  slFile := TStringList.Create;
  slTemp := TStringList.Create;
  try
    Stream := TFileStream.Create('C:\Retorno.TXT', fmOpenRead or fmShareDenyNone);
    try
      slFile.LoadFromStream(Stream);
    finally
      FreeAndNil(Stream);
    end;

    for i := 0 to Pred(slFile.Count) do
    begin
      Trim(slFile[i]);
      if slFile.Strings[i] <> '' then
        slTemp.Add(slFile.Strings[i]);
    end;

    for i := 0 to Pred(slTemp.Count) do
      case i of
        2: Dados.AMovDate := StrToDate(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))));
        3: Dados.ANumeroSerie := Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i])));
        4: Dados.ANumeroECF := StrToInt(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))));
        6: Dados.ACOOInicial := StrToInt(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))));
        7: Dados.ACOOFinal := StrToInt(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))));
        8: Dados.ANumReducaoZ := StrToInt(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))));
        10: cVendaBruta := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
        11: Dados.AGTFinal := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
      end;

    Dados.AGTInicial := Dados.AGTFinal - cVendaBruta;

    if FileExists('C:\Retorno.TXT') then
      DeleteFile('C:\Retorno.TXT');
  finally
    FreeAndNil(slFile);
  end;

  // Analítico
  Elgin_RelatorioTipo60Analitico;

  slFile := TStringList.Create;
  slTemp := TStringList.Create;
  try
    Stream := TFileStream.Create('C:\Retorno.TXT', fmOpenRead or fmShareDenyNone);
    try
      slFile.LoadFromStream(Stream);
    finally
      FreeAndNil(Stream);
    end;

    for i := 0 to Pred(slFile.Count) do
    begin
      Trim(slFile[i]);
      if slFile.Strings[i] <> '' then
        slTemp.Add(slFile.Strings[i]);
    end;

    for i := 0 to Pred(slTemp.Count) do
    begin
      case i of
        4: Dados.AValCancelamentos := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
        5: Dados.AValCancelamentos := Dados.AValCancelamentos + StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
        6: Dados.AValDescontos     := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
        7: Dados.ASubstituicaoTrib := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
        8: Dados.AIsencao          := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
        9: Dados.ANaoTributavel    := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
       10: Dados.ASubstituicaoTrib := Dados.ASubstituicaoTrib + StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
       11: Dados.AIsencao          := Dados.AIsencao + StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
       12: Dados.ANaoTributavel    := Dados.ANaoTributavel + StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));
      end;

      if (i > 12) and (i < Pred(slTemp.Count)) then
        if StrToCurr(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll])) <> 0 then
        begin
          SetLength(Dados.AAliquota, Length(Dados.AAliquota)+1);
          Dados.AAliquota[Length(Dados.AAliquota)-1] := StrToFloat(StringReplace(Trim(Copy(slTemp.Strings[i], 1, Pos(':', slTemp.Strings[i])-1)), '.', '', [rfReplaceAll])) / 100;

          SetLength(Dados.ABaseCalculo, Length(Dados.ABaseCalculo)+1);
          Dados.ABaseCalculo[Length(Dados.ABaseCalculo)-1] := StrToCurr(StringReplace(Trim(Copy(slTemp.Strings[i], Pos(':', slTemp.Strings[i])+1, Length(slTemp.Strings[i]))), '.', '', [rfReplaceAll]));

          SetLength(Dados.AValImposto, Length(Dados.AValImposto)+1);
          Dados.AValImposto[Length(Dados.AValImposto)-1] := Dados.ABaseCalculo[Length(Dados.ABaseCalculo)-1] * (Dados.AAliquota[Length(Dados.AAliquota)-1] / 100);
        end;
    end;

    if FileExists('C:\Retorno.TXT') then
      DeleteFile('C:\Retorno.TXT');
  finally
    FreeAndNil(slFile);
  end;

  Result := True;

end;

function TDefFPrinter.DadosSintegra(var Dados: TRegDadosReducaoZ): Boolean;
begin

  case impressora of
    BematechMP20, BematechMP40:
    begin
      Result := True;
    end;

    BematechTermica:
    begin
      Result := True;
    end;

    Sweda03, Sweda10:
    begin
      Result := True;
    end;

    Elgin:
    begin
      Result := _Elgin_DadosSintegra(Dados);
    end;

    DarumaMatr:
    begin
      Result := True;
    end;

    DarumaTerm:
    begin
      Result := True;
    end;
  end;

end;

function TDefFPrinter._Sweda_DadosReducaoZ(
  var Dados: TRegDadosReducaoZ): Boolean;

  type
        RegUltimaZ = record
        ModoRZ: Array[0..2] of char;
        CRO: Array[0..4] of char;
        CRZ: Array[0..4] of char;
        COO: Array[0..6] of char;
        GNF: Array[0..6] of char;
        CCF: Array[0..6] of char;
        GRG: Array[0..6] of char;
        CFD: Array[0..6] of char;
        NFC: Array[0..4] of char;
        CFC: Array[0..4] of char;
        CON: Array[0..29] of Array[0..3] of char;
        Separador: char;
        CER: Array[0..29] of Array[0..3] of char;
        Separador2: char;
        CDC: Array[0..4] of char;
        CDN: Array[0..4] of char;
        VAZIO: Array[0..4] of char;
        GT: Array[0..18] of char;
        ParciaisTributados: Array[0..15] of Array[0..13] of char;
        Separador3: char;
        I_ICMS: Array[0..14] of char ;
        N_ICMS: Array[0..14] of char ;
        F_ICMS: Array[0..14] of char ;
        I_ISS: Array[0..14] of char ;
        N_ISS: Array[0..14] of char ;
        F_ISS: Array[0..14] of char ;
        D_ICMS: Array[0..14] of char ; // desconto
        D_ISS: Array[0..14] of char ;
        A_ICMS: Array[0..14] of char ; // acrescimo
        A_ISS: Array[0..14] of char ;
        C_ICMS: Array[0..14] of char ; // Cancelamento
        C_ISS: Array[0..14] of char ;
        ParciaisNaoTributados: Array[0..27] of Array[0..13] of char;
        Separador4: char;
        SANGRIA: Array[0..14] of char ;
        SUPRIMENTO: Array[0..14] of char ;
        C_NFISC: Array[0..14] of char ; // Cancelamento nao fiscal
        D_NFISC: Array[0..14] of char ; // Desconto nao fiscal
        A_NFISC: Array[0..14] of char ; // Acréscimo nao fiscal
        Aliquotas: Array[0..15] of Array[0..3] of char;
        Separador5: char;
        DataMovimento: Array[0..6] of char;
    end;

var
  dadosZ : RegUltimaZ;
  sResultado, sResultado2, sIndexISS, sIndex : String;
  i, iICMS, iISSQN : integer;
  sGTInicial, sGTFinal : String;
  Conteudo:Array[0..3020] of char;
begin

  VerificaIndiceAliquotasIss(sIndexISS);

  SetLength(sGTInicial, 18);
  SetLength(sGTFinal, 18);

  iRetorno := Sweda_DadosUltimaReducaoMFD(Conteudo);
  Analisa_iRetorno();
  Result:= (iRetorno=1);
  Result := Result And Retorno_Impressora;

  if Result then
  begin
    CopyMemory(@dadosZ, @Conteudo, 1278);

    Dados.AMovDate := FormatarDataImpressora(dadosZ.DataMovimento);

    Dados.ANumReducaoZ := StrToInt(ReturnNumber(dadosz.CRZ));

    Dados.ASubstituicaoTrib := (StrToFloat(copy(dadosz.F_ICMS,1,14))/100);

    Dados.AIsencao := (StrToFloat(copy(dadosz.I_ICMS,1,14))/100);

    Dados.ANaoTributavel := (StrToFloat(copy(dadosz.N_ICMS,1,14))/100);

    Dados.AContadorReducaoZ := StrToInt(ReturnNumber(dadosz.CRZ));

    Dados.AContadorOrdemOperacao := StrToInt(ReturnNumber(dadosz.COO));

    Dados.AContadorReinicioOperacao := StrToInt(ReturnNumber(dadosz.CRO));

    Dados.AValCancelamentos := (StrToFloat(copy(dadosz.C_ICMS,1,14))/100);

    Dados.ANumCancelamentos := 0;

    Dados.AValDescontos := (StrToFloat(copy(dadosz.D_ICMS,1,14))/100);

    for i := 0 to 15 do
    begin
      if StrToFloat(copy(dadosZ.Aliquotas[i],1,4))/100 <> 0 then
      begin
        // Dados para Sal_TributacaoECF
        SetLength(Dados.AAliquota, i+1);
        Dados.AAliquota[i] := (StrToFloat(copy(dadosZ.Aliquotas[i],1,4))/100);

        SetLength(Dados.ABaseCalculo, i+1);
        Dados.ABaseCalculo[i] := (StrToCurr(copy(dadosZ.ParciaisTributados[i],1,14))/100);

        SetLength(Dados.AValImposto, i+1);
        Dados.AValImposto[i] := Dados.ABaseCalculo[i] * (Dados.AAliquota[i]/100);

        // Dados para Sal_TotalizadorParcial
        SetLength(Dados.ATribReducaoZList, i+1);

        sIndex := FormatFloat('00', i+1);

        if Pos(sIndex, sIndexISS) = 0 then
        begin
          Inc(iICMS);
          if Length(IntToStr(iICMS)) = 1 then
            Dados.ATribReducaoZList[i].Codigo := '0' + IntToStr(iICMS) + 'T' + copy(dadosZ.Aliquotas[i],1,4)
          else if Length(IntToStr(iICMS)) = 2 then
            Dados.ATribReducaoZList[i].Codigo := IntToStr(iICMS) + 'T' + copy(dadosZ.Aliquotas[i],1,4);
        end
        else //ISS
        begin
          Inc(iISSQN);
          if Length(IntToStr(iISSQN)) = 1 then
            Dados.ATribReducaoZList[i].Codigo := '0' + IntToStr(iISSQN) + 'T' + copy(dadosZ.Aliquotas[i],1,4)
          else if Length(IntToStr(iISSQN)) = 2 then
            Dados.ATribReducaoZList[i].Codigo := IntToStr(iISSQN) + 'T' + copy(dadosZ.Aliquotas[i],1,4);
        end;

        Dados.ATribReducaoZList[i].ValorAcumulado := Dados.ABaseCalculo[i];
      end;
    end;

    Dados.AIncideISSQN := False;

  end;


  if InicioFimGTsMFD(sGTInicial, sGTFinal) then
  begin
    Dados.AGTInicial := StrToCurr(sGTInicial)/100;
    Dados.AGTFinal := StrToCurr(sGTFinal)/100;
  end;

  Result := True;

end;

end.


