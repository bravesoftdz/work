unit ECFiscal;
{
  By: SERVIEMA Serviços de Informática, tels. (0xx21) 3242-0409/81723856
  Data: 03/02/2004
  Descrição: Componente desenvolvido para Impressoras Ficais ECFs
  Cliente: Igmam Empreendimentos LTDA

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
type

   TECFModelo = (None, Demo, Sweda03, Sweda10,
      NCR2x, NCR1x, NCR7141,
      Urano2EFE, Urano1EFC, Urano2EFC, Urano1FIT,
      Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41, ZanthusIZ11, ZanthusIZ10,
      Schalter3D, Schalter2S,
      Trends10E,
      Dataregis, BematechMP40, BematechMP20, Procomp_2011);

   {=======================  FUNCOES DA SWEDA ==================}
   PSweda_AbrePorta = function(Numero, Timeout: Integer): Boolean; far;
   PSweda_EnviaComando = function(Texto1: PChar): ShortString; far;
   PSweda_FechaPorta = function(Numero: Integer): Boolean; far;

   {=======================  FUNCOES DA NCR ==================}
   PNCR_SendCmd = function(cmd: string; rsp: pointer; rsplen: longint): longint; stdcall;
   PNCR_SetComPort = function(porta: integer): longint; stdcall;

   {=======================  FUNCOES DA Urano2EFE ==================}
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

   {=======================  FUNCOES DA ZANTHUS ==================}
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

   {=======================  FUNCOES DA BEMATECH ==================}
   PBematech_IniPortaStr = function(Porta: string): integer; stdcall;
   PBematech_FormataTX = function(BUFFER: string): integer; stdcall;
   PBematech_FechaPorta = function: integer; stdcall;
   PBematech_Status_Mp20FI = function(var Ret: integer; var ACK: integer; var ST1: integer; var ST2: Integer): integer; stdcall;

   {=======================  FUNCOES DA SCHALTER3D ==================}
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
   PSchalter3D_StatusCupom = function(var general_flag: integer): PChar; stdcall;
   PSchalter3D_ImpCab = function(byEst: integer): integer; stdcall;
   PSchalter3D_InicCupomNFiscal = function(byEst: integer): integer; stdcall;
   PSchalter3D_Venda_Item = function(szCodigo: LPSTR; szDescricao: LPSTR; szQInteira: LPSTR; szQFracionada: LPSTR; szValor: LPSTR; byTaxa: integer): integer; stdcall;
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

   {=======================  FUNCOES DA URANO1FIT ==================}
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

   {=======================  FUNCOES DA URANOEFC ==================}
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

   {=======================  FUNCOES DA SCHALTER2S ==================}
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

   {=======================  FUNCOES DA DATAREGIS ==================}
   PDataregis_AbrePorta = function(Porta: integer): Integer;
   PDataregis_FechaPorta = function: Integer;
   PDataregis_EnviaComando = function(data: string): Pchar;

   {=======================  FUNCOES DA PROCOMP ==================}
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

   {=======================  FUNCOES DA TRENDS ==================}
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
   {====================================================================================================}

   TUserEvent = procedure(comando: string; MsgError: string) of object;

   TTotalCupom = procedure(ValorCupom: string) of object;

   TDefFPrinters = class;


   TPrinterDados = class(TPersistent)
   private
      FOwner: TDefFPrinters;
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
   public
      constructor Create(Owner: TDefFPrinters);
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
   {=====================================================}
   TTributacao = class(TPersistent)
   private
      FOwner: TDefFPrinters;
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
      constructor Create(Owner: TDefFPrinters);
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
   {=====================================================}
   TRodape = class(TPersistent)
   private
      FOwner: TDefFPrinters;
      FLinha1: string;
      FLinha2: string;
      FLinha3: string;
      FLinha4: string;
      FLinha5: string;
   public
      constructor Create(Owner: TDefFPrinters);
   published
      property Linha1: string read FLinha1 write FLinha1;
      property Linha2: string read FLinha2 write FLinha2;
      property Linha3: string read FLinha3 write FLinha3;
      property Linha4: string read FLinha4 write FLinha4;
      property Linha5: string read FLinha5 write FLinha5;
   end;
   {=====================================================}
   TStatus = class(TPersistent)
   private
      FOwner: TDefFPrinters;
      FGavetaAberta: Boolean;
      FFimDePapel: Boolean;
      FCupomAberto: Boolean;
      FDiaAberto: Boolean;
   public
      constructor Create(Owner: TDefFPrinters);
   published
      property GavetaAberta: boolean read FGavetaAberta write FGavetaAberta;
      property FimDePapel: boolean read FFimDePapel write FFimDePapel;
      property CupomAberto: boolean read FCupomAberto write FCupomAberto;
      property DiaAberto: boolean read FDiaAberto write FDiaAberto;
   end;
   {=====================================================}
   TDefFPrinters = class(TComponent)
   private
      HandleDLL: THandle;
      NomeDll: string;
      { ---- Declaracao das funcoes das DLLs --- }
      Sweda_AbrePorta: PSweda_AbrePorta;
      Sweda_EnviaComando: PSweda_EnviaComando;
      Sweda_FechaPorta: PSweda_FechaPorta;
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
      {----------------------------------------------------------}
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
      //FSer: THANDLE;
      //Fpov: POVERLAPPED;
      //Fov: TOVERLAPPED;
      //dsr: bool;
      grande_retorno: PChar;
      TabAliq_Zant: string;
      UltItem_Zant: string;
      dtr_desconto, dtr_acrescimo: string;
      contai_Zant: Integer;
      //Text1: array[0..299] of char;
      //Text2: array[0..299] of char;
      //Text3: array[0..299] of char;
      s1: array[1..255] of char;
      vol: string;
      textolivre: string;
      ptRetorno: Pointer;
      FOperacao: Boolean;

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
   protected
      property Dados: TPrinterDados read FDados;
      property Tributacao: TTributacao read FTributacao;
      property Rodape: TRodape read FRodape;
      property Status: TStatus read FStatus;
   public
      constructor Create(AOwner: TComponent); override;
      {================ Funcoes ======================}
      function Crypto(const Str1: string): string;
      function inttobin(data: Integer): string;
      function bintoint(data: string): Integer;
      function IntToHex(numero: integer): string;
      function HextoInt(HexStr: string): integer;
      procedure TimeDelay(msecs: integer);
      function BiosInfo: string;
      function CPUMHz: string;
      function Modelos: string;
      procedure ProgModalidades;
      function sepdados(dados: string; item_a_retornar: Integer): string;
      function Extenso(pValor: Real): string;
      function fExtenso(nValor: Real): string;
      function ExtensoMil(cVlr: string): string;
      function LenNum(Numero: Real): Integer;
      function zcomp(data: string; Tam: integer): string;
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
      {===============================================}
      function LeituraMemoriaFiscalData(datainicial, datafinal: string): boolean;
      function LeituraMemoriaFiscalReducao(reducaoinicial, reducaofinal: string): boolean;
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
      function ReducaoZ: Boolean;
      function AbreGaveta: Boolean;
      function AbreDiaFiscal(Operador: string): Boolean;
      function CancelaUltimoCupom(Valor: string): Boolean;
      function AbreCupomVinculado(Cupom, FormaPgto, Finalizadora, valor: string): boolean;
      function TextoCupomVinculado(Dados: string): boolean;
      function TextoVinculadoX(Dados: string): boolean;
      function AbreCupomFiscal: boolean;
      function VendeItem(Item: string): boolean;
      function VendeItem3dig(Item: string): boolean;
      function FechaCupomVinculado: boolean;
      function FechaCupomFiscal(CupomAnexo: string): boolean;
      function SubtotalizaCupom(valor: string): boolean;
      function PagamentoCupom(Dados: string): boolean;
      function CancelaUltimoItem(descricao, Valor: string): boolean;
      function AtivaVerao: boolean;
      function DestivaVerao: boolean;
      function cancelaItem(Item, posicao: string): boolean;
      function ImprimeCheque(param, valor, Favorecido, Cidade, data, banco, ArqLayout, espacamento: string): boolean;
      function DescontoEmSubtotal(Valor: string): boolean;
      function AcrescimoEmSubtotal(Valor: string): boolean;
      function Autentica(Dados: string): boolean;
      function CancelaCupomAtual: boolean;
      function Versao: string;
      {===============================================}
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
   end;
   TECFiscal = class(TDefFPrinters)
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
   end;

procedure Register;

implementation

///////////////////////////////////////////////////
constructor TDefFPrinters.Create(AOwner: TComponent);
///////////////////////////////////////////////////
begin
   inherited Create(AOwner);
   FDados := TPrinterDados.Create(self);
   FTributacao := TTributacao.Create(self);
   FRodape := TRodape.Create(self);
   FStatus := TStatus.Create(Self);
end;

///////////////////////////////////////////////////
constructor TPrinterDados.Create(Owner: TDefFPrinters);
///////////////////////////////////////////////////
begin
   inherited Create;
   FOwner := Owner;
end;

///////////////////////////////////////////////////
constructor TTributacao.Create(Owner: TDefFPrinters);
///////////////////////////////////////////////////
begin
   inherited Create;
   FOwner := Owner;
end;
///////////////////////////////////////////////////
constructor TRodape.Create(Owner: TDefFPrinters);
///////////////////////////////////////////////////
begin
   inherited Create;
   FOwner := Owner;
end;
////////////////////////////////////////////////////
constructor TStatus.Create(Owner: TDefFPrinters);
////////////////////////////////////////////////////
begin
   inherited Create;
   FOwner := Owner;
end;
////////////////////////////////////////////////////
procedure Register;
////////////////////////////////////////////////////
begin
   RegisterComponents('NewPower', [TECFiscal]);
end;

//////////////////////////////////////////
function TDefFPrinters.Trends_ret(resp: integer): boolean;
//////////////////////////////////////////
begin
   dados.mensagem := '';
   {todo : mudado por mim}
   Result := false;
   
   case resp of
      0: Result := true;
      1: dados.mensagem := 'Detectado pouco papel';
      2: dados.mensagem := 'Cupom finalizado com total nulo. Será emitido um cupom de cancelamento automaticamente';
      3: dados.mensagem := 'Abrindo relatório gerencial na Leitura X ou Redução Z';
   end;
   if copy(ultimaresp, 1, 1) = '-' then begin
      //Result := false;
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
///////////////////////////////////////////
function TDefFPrinters.URN_Ret2(retorno: integer): Boolean;
////////////////////////////////////////////
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
   //if retorno = 33 then Dados.mensagem := 'Comando executado com sucesso.';
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
function TDefFPrinters.URN_Ret3(retorno: integer): Boolean;
////////////////////////////////////////////
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
function TDefFPrinters.URN_Ret(retorno: integer): Boolean;
////////////////////////////////////////////
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
function TDefFPrinters.Bem_proc(data: string): Boolean;
///////////////////////////////////////////////////////
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
   //if copy(data,1,2)= '22' then sleep(1000);
   //if copy(data,1,2)= '29' then sleep(1000);
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
function TDefFPrinters.zan_proc(data, param: string): boolean;
///////////////////////////////////////////////////////
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
function TDefFPrinters.swd_proc(data: string): Boolean;
////////////////////////////////////////////
var
   CmdSwd: array[0..512] of Char;
   Resposta: string;
   ret: boolean;
begin
   ret := false;
   Pronto := false;
   StrPCopy(Cmdswd, data);
   Resposta := Sweda_EnviaComando(CmdSwd);
   if copy(resposta, 2, 1) = '+' then ret := true;
   if (copy(resposta, 2, 1) = '-') and (copy(data, 3, 3) <> '27G') then begin
      ret := false;
      dados.Mensagem := resposta;
      if (data <> #27 + '.28}') and (data<>#27 + '.42}') then onError(data, iif(Length(resposta) > 8, copy(resposta, 7, Length(resposta) - 7), resposta));
   end;
   UltimaResp := resposta;
   Pronto := true;
   Result := ret;
end;
////////////////////////////////////////////
function TDefFPrinters.dtr_proc(data: string): Boolean;
////////////////////////////////////////////
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
function TDefFPrinters.LeProComp(iRetorno: Integer; lProcessaRet: Boolean): Boolean;
////////////////////////////////////////////////////
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
procedure TDefFPrinters.MensagemProComp(iRetorno: Integer);
///////////////////////////////////////////////////
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
function TDefFPrinters.RetornoSchD(retorno: integer): Boolean;
////////////////////////////////////////////////////
{todo : mudado por mim}
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
   if retorno = 146 then dados.mensagem := 'Não há nenhum compromvante vinculado pendente';
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
function TDefFPrinters.retsch2(retorno: integer): Boolean;
////////////////////////////////////////////////////
{todo : mudado por mim}
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
function TDefFPrinters.NCR_proc(data: string): Boolean;
///////////////////////////////////////////////////
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

function TDefFPrinters.LenNum(Numero: Real): Integer;
var
   cNumero: string;
begin
   cNumero := FormatFloat('0.000E+00', Numero);
   Result := StrToInt(Copy(cNumero, Length(cNumero) - 1, 2)) + 1

   {FloatToStrF(Numero; ffExponent; 14,2)}
end;

function TDefFPrinters.Extenso(pValor: Real): string;

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

function TDefFPrinters.fExtenso(nValor: Real): string;

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

function TDefFPrinters.ExtensoMil(cVlr: string): string;

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
function TDefFPrinters.zcomp(data: string; Tam: integer): string;
///////////////////////////////////////////////
begin
   data := trim(data);
   if Length(data) = tam then Result := data else begin
      data := StringOfChar('0', 50) + trim(data);
      Result := copy(data, Length(data) - (tam - 1), tam);
   end;
end;
///////////////////////////////////////////////
function TDefFPrinters.scomp(data: string; Tam: integer): string;
///////////////////////////////////////////////
begin
   data := trim(data);
   if Length(data) = tam then Result := data else begin
      data := StringOfChar(' ', 50) + trim(data);
      Result := copy(data, Length(data) - (tam - 1), tam);
   end;
end;
///////////////////////////////////////////////
function TDefFPrinters.sdcomp(data: string; Tam: integer): string;
///////////////////////////////////////////////
begin
   Result := copy(data + space(tam), 1, tam);
end;
////////////////////////////////////////////
function TDefFPrinters.space(val: Integer): string;
////////////////////////////////////////////
begin
   Result := StringOfChar(' ', val);
end;
/////////////////////////////////////////////////////////////////////////////////
function TDefFPrinters.sepdados(dados: string; item_a_retornar: Integer): string;
/////////////////////////////////////////////////////////////////////////////////
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
function TDefFPrinters.tiravg(data: string): string;
///////////////////////////////////////////////
var
   x: integer;
   a: string;
begin
   a := '';
   for x := 1 to length(data) do if (copy(data, x, 1) <> ',') then a := a + copy(data, x, 1);
   Result := trim(a);
end;
/////////////////////////////////////////////////
function TDefFPrinters.nmmes(dados: string): string;
/////////////////////////////////////////////////
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
function TDefFPrinters.CheckCPF(cpf: string): Boolean;
////////////////////////////////////////////
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
function TDefFPrinters.CheckCGC(cgc: string): Boolean;
////////////////////////////////////////////
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
function TDefFPrinters.iif(cond: boolean; se_verdadeiro: string; se_falso: string): string;
////////////////////////////////////////////////////////////////////////
begin
   if cond then result := se_verdadeiro else result := se_falso;
end;
///////////////////////////////////////////////
function TDefFPrinters.tiramsc(data: string): string;
///////////////////////////////////////////////
var
   x: integer;
begin
   result := '';
   for x := 1 to length(data) do if (data[x] in ['0'..'9']) then Result := Result + copy(data, x, 1);
end;
/////////////////////////////////////////////////////
function TDefFPrinters.NCRCHQLAY(banco: integer): string;
/////////////////////////////////////////////////////
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
function TDefFPrinters.ZNTCHQLAY(banco: integer): string;
/////////////////////////////////////////////////////
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

function TDefFPrinters.ptov(data: string): string;
///////////////////////////////////////////////
var
   x: integer;
   a: string;
begin
   a := '';
   for x := 1 to length(data) do if data[x] = '.' then a := a + ',' else a := a + data[x];
   Result := trim(a);
end;
////////////////////////////////////////
procedure TDefFPrinters.TablePack(Table: TTable);
////////////////////////////////////////
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
function TDefFPrinters.AbreComunicacao: Boolean;
////////////////////////////////////////////
var
   Txt: textfile;
begin
   Result := false;
   if not CarregaECF then exit;
   try
      case Impressora of
         None: Result := false;
         demo: Result := true;
         Sweda03, Sweda10: // fprint1
            begin
               Result := Sweda_AbrePorta(PortaSerial, 15);
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
               Result :=Urano2EFE_IniciaImpressora(pchar('COM' + IntToStr(PortaSerial))) = 0;
            end;
         ZanthusIZ11, ZanthusIZ10, Zanthus2e,
            ZanthusIZ20, ZanthusIZ21, ZanthusIZ41: // fprint 4
            begin
               Result := Zanthus_InicializaPortaSerial(PortaSerial) = 0;
            end;
         BematechMP40, BematechMP20: // fprint5
            begin
               if Bematech_IniPortaStr(pchar('COM'+IntToStr(PortaSerial)))=1 then
                  Result := true;
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
      end;
   except
      Result := false;
   end;
end;
////////////////////////////////////////////
function TDefFPrinters.FechaComunicacao: Boolean;
////////////////////////////////////////////
begin
   Result := false;
   case Impressora of
      None: exit;
      demo: Result := true;
      Dataregis: Result := Dataregis_Fechaporta = 0;
      Sweda03, Sweda10: Result := Sweda_FechaPorta(PortaSerial);
      NCR2x, NCR1x, NCR7141: if NCR_setcomport(0) = 0 then Result := true else Result := false;
      Urano2EFE: Result := Urano2EFE_finalizaimpressora = 0;
      Urano1EFC, Urano2EFC: Result := UranoEFC_Finalizadll = 0;
      Urano1FIT: Result := Urano1FIT_FinalizaDLL = 0;
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41: Zanthus_FechaPortaSerial;
      Schalter3D: Schalter3D_Changeport(-1);
      Schalter2S: Result := retsch2(Schalter2S_Changeport(-1));
      BematechMP40, BematechMP20: Result := Bematech_FechaPorta = 1;
      Procomp_2011: Result := LeProComp(Procomp_CloseCIF, False);
   end;
   case Impressora of
      Trends10E, Dataregis, Procomp_2011,
         Sweda03, Sweda10,
         Urano2EFE, Urano1FIT, Urano1EFC, Urano2EFC,
         Schalter3D, Schalter2S,
         Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41, ZanthusIZ11, ZanthusIZ10,
         BematechMP40, BematechMP20,
         Ncr1x, NCR2x, NCR7141:
         begin
            freelibrary(HandleDLL);
            Result := true;
         end;
   end;
end;
////////////////////////////////////////////
function TDefFPrinters.AtualizaDados: Boolean;
////////////////////////////////////////////
var
   x: Integer;
begin
   Result := false;
   case Impressora of
      None: exit;
      demo: begin
            Dados.dataimp := tiramsc(datetostr(date));
            dados.dataimp := copy(dados.dataimp, 1, 4) + copy(dados.dataimp, Length(dados.dataimp) - 1, 2);
            Dados.horaimp := tiramsc(copy(timetostr(time), 1, 5));
            dados.loja := '01';
            dados.caixa := '001';
            dados.Operador := '01';
            dados.SeqIni := '00001';
            dados.seqfinal := '000002';
            dados.Reducoes := '0001';
            dados.NumCanc := '00';
            dados.GTInicial := '000000';
            dados.GTFinal := '0';
            dados.ValorCanc := '0';
            dados.ValorDesc := '0';
            dados.ValorDesc := '0';
            dados.ValorAcres := '0';
            dados.Serial := '1234567890';
            pronto := true;
            Result := true;
         end;
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
      BematechMP40, BematechMP20:
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
end;
////////////////////////////////////////////
function TDefFPrinters.AtualizaDadosNCR(comando: string): Boolean;
////////////////////////////////////////////
begin
   Result := NCR_Proc(comando);
end;
/////////////////////////////////////////////////
function TDefFPrinters.AtualizaValorCupom: Boolean;
/////////////////////////////////////////////////
var
   a, b: string;
   x: integer;
begin
   Result := false;
   case Impressora of
      None: Result := true;
      demo: Result := true;
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
      BematechMP40, BematechMP20:
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
function TDefFPrinters.AtualizaEprom: Boolean;
////////////////////////////////////////////
begin
   Result := false;
   case Impressora of
      None: exit;
      demo: begin
            eprom := 'DEMO';
            pronto := true;
            Result := true;
         end;
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
      BematechMP40, BematechMP20:
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
end;
////////////////////////////////////////////
function TDefFPrinters.AtualizaStatus: Boolean;
////////////////////////////////////////////
var
   x: Integer;
   a: string;
   mRetorno: Pointer;
begin
   Result := false;
   mRetorno := nil;
   case Impressora of
      None: exit;
      demo: Result := true;
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
      BematechMP40, BematechMP20:
         begin
            Result := bem_proc('19');
            if trim(copy(UltimaResp, 12, 80)) = 'Pouco Papel!' then status.FimDePapel := true else status.FimDePapel := false;
            bem_proc('23');
            if UltimaResp = '000' then status.GavetaAberta := false;
            if UltimaResp = '255' then status.GavetaAberta := true;
            //bem_proc('35|17');
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
end;
////////////////////////////////////////////
function TDefFPrinters.AtualizaTributacao: Boolean;
////////////////////////////////////////////
var
   x: Integer;
   a: string;
begin
   Result := false;
   case Impressora of
      None: exit;
      demo: Result := true;
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
      BematechMP40, BematechMP20:
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
end;
////////////////////////////////////////////
function TDefFPrinters.AbreGaveta: Boolean;
////////////////////////////////////////////
begin
   Result := false;
   case Impressora of
      None: Result := false;
      demo: Result := true;
      Dataregis: Result := DTR_Proc('N');
      Sweda03: Result := swd_proc(#27 + '.42}');
      Sweda10:
         begin
            swd_proc(#27 + '.42}');
            swd_proc(#27 + '.21}');
            result := true;
         end;
      NCR2x, NCR7141, NCR1x: Result := NCR_Proc('21');
      Urano2EFE: result := Urn_Ret(Urano2EFE_AGaveta);
      Urano1EFC, Urano2EFC: result := Urn_Ret3(UranoEFC_AbreGaveta);
      Urano1FIT: result := Urn_Ret2(Urano1FIT_AbreGaveta);
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41: Result := zan_proc('T', '');
      Schalter3D: Schalter3D_AbreGaveta;
      Schalter2S: Result := retsch2(Schalter2S_ecfAbreGaveta);
      BematechMP40, BematechMP20: Result := bem_proc('22|z');
      Procomp_2011: LeProComp(Procomp_AbrirGaveta('0', '2', '2'), True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_AbrirGaveta('0', #12, #48, UltimaResp)); // Isentos
         end;
   end;
end;
////////////////////////////////////////////
function TDefFPrinters.ReducaoZ: Boolean;
////////////////////////////////////////////
begin
   Result := false;
   case Impressora of
      None: Result := false;
      Dataregis: Result := DTR_Proc('HS');
      Sweda03: Result := swd_proc(#27 + '.14}');
      Sweda10: Result := swd_proc(#27 + '.14N}');
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
      BematechMP40, BematechMP20: Result := bem_proc('05');
      Procomp_2011: LeProComp(Procomp_ReducaoZ('0'), True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_ReducaoZ('0', ultimaresp));
         end;
   end;
end;
////////////////////////////////////////////
function TDefFPrinters.AbreDiaFiscal(Operador: string): Boolean;
////////////////////////////////////////////
var
   Txt: textfile;
   linha: string;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      demo: Result := true;
      Dataregis:
         begin
            DTR_Proc('GNS');
            if (copy(eprom, 5, 1) = '4') or (copy(eprom, 5, 1) = '3') then result := DTR_Proc('O' + zcomp(Operador, 6)) else result := DTR_Proc('O' + zcomp(Operador, 3));
         end;
      Sweda03: result := EmiteLeituraX('N');
      Sweda10: result := EmiteLeituraX('N');
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
      BematechMP40, BematechMP20:
         begin
            if fileexists('bematech.fin') then begin
               assignfile(Txt, 'bematech.fin');
               reset(Txt);
               readln(Txt, linha);
               closefile(Txt);
               Bem_proc('73|' + linha);
            end else Bem_proc('73|CHEQUE|CHEQUE-PRE|TICKET|CARTAO|VALE|CONVENIO|CONTRA-VALE|CREDIARIO');
            ProgModalidades;
            Result := bem_proc('6');
         end;
      Procomp_2011: LeProComp(Procomp_LeituraX('0'), True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_LeituraX('0', UltimaResp));
         end;
   end;
end;
////////////////////////////////////////////
function TDefFPrinters.CancelaUltimoCupom(Valor: string): Boolean;
////////////////////////////////////////////
begin
   Result := false;
   case Impressora of
      None: Result := false;
      demo: Result := true;
      Dataregis: result := DTR_Proc('F');
      Sweda03:
         begin
            Result := swd_proc(#27 + '.05}');
            pronto := false;
            while copy(UltimaResp, 7, 1) <> 'C' do begin
               sleep(200);
               swd_proc(#27 + '.28}');
               Application.ProcessMessages;
            end;
            pronto := true;
         end;
      Sweda10:
         begin
            Result := swd_proc(#27 + '.05}');
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
      BematechMP40, BematechMP20: Result := bem_proc('14');
      Procomp_2011: LeProComp(Procomp_CancelaCupomFiscal, True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_CancelaCupomFiscal(UltimaResp));
         end;
   end;
end;
/////////////////////////////////////////////////////////////////////
function TDefFPrinters.EmiteLeituraX(AbreVinculado: string): Boolean;
/////////////////////////////////////////////////////////////////////
begin
   Result := false;
   case Impressora of
      None: exit;
      demo: Result := true;
      Dataregis:
         begin
            if AbreVinculado = 'N' then Result := DTR_Proc('GNS') else begin
               if copy(eprom, 2, 1) = '9' then Result := DTR_Proc('GNS') else result := DTR_Proc('j' + space(40));
            end;
            sleep(10000);
         end;
      Sweda03:
         begin
            Result := swd_proc(#27 + '.13}');
            if Result then begin
               sleep(35000);
               if AbreVinculado = 'S' then swd_proc(#27 + '.19}');
            end;
         end;
      Sweda10:
         begin
            Result := swd_proc(#27 + '.13' + AbreVinculado + '}');
            if AbreVinculado = 'N' then begin
               pronto := false;
               while copy(UltimaResp, 10, 1) <> 'C' do begin
                  sleep(400);
                  swd_proc(#27 + '.28}');
                  Application.ProcessMessages;
               end;
               sleep(10000);
               pronto := true;
            end;
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
      BematechMP40, BematechMP20: if AbreVinculado = 'N' then Result := bem_proc('6') else result := true; //Bem_proc('20|'+space(39))
      Procomp_2011: if AbreVinculado = 'S' then LeProComp(Procomp_LeituraX('1'), True) else LeProComp(Procomp_LeituraX('0'), True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            if AbreVinculado = 'S' then Result := Trends_ret(Trends_LeituraX('1', UltimaResp)) else Result := Trends_ret(Trends_LeituraX('0', UltimaResp));
         end;
   end;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinters.AbreCupomVinculado(Cupom, FormaPgto, Finalizadora, valor: string): Boolean;
//////////////////////////////////////////////////////////////////////////////////////////////////
begin
   Result := false;
   case Impressora of
      None: Result := false;
      demo: Result := true;
      Dataregis:
         begin
            Result := DTR_Proc('J' + zcomp(inttostr(strtointdef(FormaPgto, 0) - 2), 2) + space(38));
            sleep(2000);
         end;
      Sweda03: result := swd_proc(#27 + '.19}');
      Sweda10: result := swd_proc(#27 + '.1900' + zcomp(IntToStr(strtointdef(cupom, 0) + 1), 4) + zcomp(formaPgto, 2) + space(20) + '}');
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
      BematechMP40, BematechMP20: Result := Bem_proc('66|' + Trim(Finalizadora) + '|');
      Procomp_2011: LeProcomp(Procomp_AbreCupomVinculado(), True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_AbreCupomVinculado(UltimaResp));
         end;
   end;
end;
////////////////////////////////////////////////////////////////
function TDefFPrinters.TextoCupomVinculado(Dados: string): Boolean;
////////////////////////////////////////////////////////////////
begin
   Result := false;
   case Impressora of
      None: Result := false;
      demo: Result := true;
      Dataregis: result := DTR_Proc('J' + copy(dados + space(40), 1, 40));
      Sweda03: Result := swd_proc(#27 + '.080D' + copy(dados, 1, 40) + '}');
      Sweda10: Result := swd_proc(#27 + '.080' + copy(dados, 1, 40) + '}');
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
      BematechMP20:
         begin
            if dados = #13 then dados := space(40);
            if trim(copy(dados, 48, 1)) <> '' then result := bem_proc('67|' + copy(Dados + space(48), 1, 48)) else result := bem_proc('67|' + copy(Dados + space(48), 1, 47) + '.');
         end;
      BematechMP40: begin
            if dados = #13 then dados := space(40);
            if trim(copy(dados, 40, 1)) <> '' then result := bem_proc('67|' + copy(Dados + space(40), 1, 40)) else result := bem_proc('67|' + copy(Dados + space(39), 1, 39) + '.');
         end;
      Procomp_2011: LeProcomp(Procomp_ImprimeLinhaNaoFiscal('0', sdcomp(dados, 40)), True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_ImprimeLinhaNaoFiscal('0', space(4) + sdcomp(dados, 44), ultimaresp));
         end;
   end;
end;
////////////////////////////////////////////////////////////////
function TDefFPrinters.TextoVinculadoX(Dados: string): Boolean;
////////////////////////////////////////////////////////////////
begin
   Result := false;
   case Impressora of
      None: Result := false;
      demo: Result := true;
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
      BematechMP20:
         begin
            if dados = #13 then dados := space(40);
            if trim(copy(dados, 48, 1)) <> '' then result := bem_proc('20|' + copy(Dados + space(48), 1, 48)) else result := bem_proc('20|' + copy(Dados + space(48), 1, 47) + '.');
         end;
      BematechMP40: begin
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
end;
////////////////////////////////////////////////////////////////
function TDefFPrinters.FechaCupomVinculado: Boolean;
////////////////////////////////////////////////////////////////
begin
   Result := false;
   case Impressora of
      None: Result := false;
      demo: Result := true;
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
      Sweda03: result := swd_proc(#27 + '.12'
            + iif(trim(rodape.linha1) <> '', '0' + copy(rodape.Linha1 + space(40), 1, 40), '')
            + iif(trim(rodape.linha2) <> '', '0' + copy(rodape.linha2 + space(40), 1, 40), '')
            + iif(trim(rodape.linha3) <> '', '0' + copy(rodape.linha3 + space(40), 1, 40), '')
            + iif(trim(rodape.linha4) <> '', '0' + copy(rodape.linha4 + space(40), 1, 40), '')
            + iif(trim(rodape.linha5) <> '', '0' + copy(rodape.linha5 + space(40), 1, 40), '')
            + '}');
      Sweda10:
         begin
            if trim(rodape.linha1) <> '' then swd_proc(#27 + '.080' + copy(rodape.Linha1 + space(40), 1, 40));
            if trim(rodape.linha2) <> '' then swd_proc(#27 + '.080' + copy(rodape.Linha2 + space(40), 1, 40));
            if trim(rodape.linha3) <> '' then swd_proc(#27 + '.080' + copy(rodape.Linha3 + space(40), 1, 40));
            if trim(rodape.linha4) <> '' then swd_proc(#27 + '.080' + copy(rodape.Linha4 + space(40), 1, 40));
            if trim(rodape.linha5) <> '' then swd_proc(#27 + '.080' + copy(rodape.Linha5 + space(40), 1, 40));
            result := swd_proc(#27 + '.12}');
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
      BematechMP20:
         begin
            if trim(rodape.linha1) <> '' then bem_proc('67|' + copy(Rodape.Linha1 + space(47), 1, 47) + '.');
            if trim(rodape.linha2) <> '' then bem_proc('67|' + copy(Rodape.Linha2 + space(47), 1, 47) + '.');
            if trim(rodape.linha3) <> '' then bem_proc('67|' + copy(Rodape.Linha3 + space(47), 1, 47) + '.');
            if trim(rodape.linha4) <> '' then bem_proc('67|' + copy(Rodape.Linha4 + space(47), 1, 47) + '.');
            if trim(rodape.linha5) <> '' then bem_proc('67|' + copy(Rodape.Linha5 + space(47), 1, 47) + '.');
            Result := bem_proc('21');
         end;
      BematechMP40:
         begin
            if trim(rodape.linha1) <> '' then if trim(copy(rodape.linha1, 40, 1)) <> '' then bem_proc('67|' + Rodape.Linha1) else bem_proc('67|' + copy(Rodape.Linha1 + space(39), 1, 39) + '.');
            if trim(rodape.linha2) <> '' then if trim(copy(rodape.linha2, 40, 1)) <> '' then bem_proc('67|' + Rodape.Linha2) else bem_proc('67|' + copy(Rodape.Linha2 + space(39), 1, 39) + '.');
            if trim(rodape.linha3) <> '' then if trim(copy(rodape.linha3, 40, 1)) <> '' then bem_proc('67|' + Rodape.Linha3) else bem_proc('67|' + copy(Rodape.Linha3 + space(39), 1, 39) + '.');
            if trim(rodape.linha4) <> '' then if trim(copy(rodape.linha4, 40, 1)) <> '' then bem_proc('67|' + Rodape.Linha4) else bem_proc('67|' + copy(Rodape.Linha4 + space(39), 1, 39) + '.');
            if trim(rodape.linha5) <> '' then if trim(copy(rodape.linha5, 40, 1)) <> '' then bem_proc('67|' + Rodape.Linha5) else bem_proc('67|' + copy(Rodape.Linha5 + space(39), 1, 39) + '.');
            Result := bem_proc('21');
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
   end;
end;
////////////////////////////////////////////////////////////////
function TDefFPrinters.AbreCupomFiscal: Boolean;
////////////////////////////////////////////////////////////////
begin
   Result := false;
   case Impressora of
      None: Result := false;
      demo: Result := true;
      Dataregis: result := True;
      Sweda03: Result := swd_proc(#27 + '.17}');
      Sweda10: Result := swd_proc(#27 + '.17}');
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
      BematechMP40, BematechMP20: Result := bem_proc('0');
      Procomp_2011: LeProComp(Procomp_AbreCupomFiscal, True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_AbreCupomFiscal(ultimaresp));
         end;
   end;
   if Result then ValorCupom := '0';
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinters.VendeItem(Item: string): Boolean;
////////////////////////////////////////////////////////////////////////////////////////////
var
   temp, a, b, c, d, e: string;
   quebrado: boolean;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      demo: Result := true;
      Dataregis: result := DTR_Proc('A' + zcomp(sepdados(Item, 1), 13) + ' ' + // Codigo 13+1 espaco
            copy(copy(sepdados(Item, 2), 1, 20) + space(22), 1, 22) + //Descricao[22]
            zcomp(IntToStr(strtointdef(COPY(sepdados(Item, 3), 2, 1), 1) - 1), 2) + //Tributacao[2]
            zcomp(tiravg(ptov(sepdados(Item, 4))), 6) + //Quantidade[6]
            zcomp(tiravg(ptov(sepdados(Item, 5))), 9) + //Preco Unitario[9]
            zcomp(tiravg(ptov(sepdados(Item, 6))), 4)); //Desconto[4]
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
               copy(sepdados(Item, 2) + space(24), 1, 24) + // Descricao
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
               copy(sepdados(Item, 2) + space(24), 1, 24) + // Descricao
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
      BematechMP40, BematechMP20:
         begin
            b := sepdados(Item, 3);
            if (b = 'F') or (b = 'ST') then b := 'FF';
            if (b = 'I') or (b = 'IS') then b := 'II';
            if b[1] = 'T' then b := '0' + b[2];
            Result := bem_proc('09|' +
               sepdados(item, 1) + '|' + // Codigo
               sepdados(item, 2) + '|' + // Descricao
               b + '|' + // Tributacao
               zcomp(sepdados(item, 4), 7) + '|' + // Quantidade
               zcomp(sepdados(item, 5), 8) + '|' + // Preco unitario
               sepdados(item, 6)); // Desconto em percentual
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
   end;
   if Result then begin
      ValorCupom := IntToStr(strtointdef(ValorCupom, 0) + (StrtointDef(sepdados(Item, 4), 0) * StrtointDef(sepdados(Item, 5), 0)));
      if assigned(FTotalCupom) then OnTotalCupom(valorCupom);
   end;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinters.VendeItem3dig(Item: string): Boolean;
////////////////////////////////////////////////////////////////////////////////////////////
var
   temp, a, b, c, d, e: string;
   quebrado: boolean;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      demo: Result := true;
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
      BematechMP40, BematechMP20:
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
   if Result then begin
      ValorCupom := IntToStr(strtointdef(ValorCupom, 0) + (StrtointDef(sepdados(Item, 4), 0) * StrtointDef(sepdados(Item, 5), 0)));
      if assigned(FTotalCupom) then OnTotalCupom(valorCupom);
   end;
end;

////////////////////////////////////////////////////////////////
function TDefFPrinters.SubtotalizaCupom(valor: string): Boolean;
////////////////////////////////////////////////////////////////
var
   aComando: array[0..0] of Char;
   a: string;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      demo: Result := true;
      Dataregis:
         begin
            result := AtualizaValorCupom;
         end;
      Sweda03: Result := true;
      Sweda10: Result := true;
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
      Schalter3D, Schalter2S: Result := true;
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
end;
////////////////////////////////////////////////////////////////
function TDefFPrinters.PagamentoCupom(Dados: string): Boolean;
////////////////////////////////////////////////////////////////
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
      demo: Result := true;
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
      BematechMP40, BematechMP20:
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
end;
////////////////////////////////////////////////////////////////
function TDefFPrinters.FechaCupomFiscal(CupomAnexo: string): Boolean;
////////////////////////////////////////////////////////////////
var
   rodlinha: string;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      demo: Result := true;
      Dataregis: result := True;
      Sweda03:
         begin
            result := swd_proc(#27 + '.12'
               + '0' + copy(rodape.Linha1 + space(40), 1, 40)
               + '0' + copy(rodape.linha2 + space(40), 1, 40)
               + '0' + copy(rodape.linha3 + space(40), 1, 40)
               + '0' + copy(rodape.linha4 + space(40), 1, 40)
               + '0' + copy(rodape.linha5 + space(40), 1, 40) + '}');
            sleep(3000);
            pronto := true;
         end;
      Sweda10:
         begin
            result := swd_proc(#27 + '.12' + CupomAnexo[1] + 'N'
               + iif(trim(rodape.linha1) <> '', '0' + copy(rodape.Linha1 + space(40), 1, 40), '')
               + iif(trim(rodape.linha2) <> '', '0' + copy(rodape.linha2 + space(40), 1, 40), '')
               + iif(trim(rodape.linha3) <> '', '0' + copy(rodape.linha3 + space(40), 1, 40), '')
               + iif(trim(rodape.linha4) <> '', '0' + copy(rodape.linha4 + space(40), 1, 40), '')
               + iif(trim(rodape.linha5) <> '', '0' + copy(rodape.linha5 + space(40), 1, 40), '')
               + '}');
            sleep(3000);
            pronto := true;
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
      BematechMP20:
         begin
            rodlinha := '';
            if rodape.linha1 <> '' then if trim(copy(rodape.linha1, 40, 1)) <> '' then rodlinha := rodlinha + copy(rodape.linha1 + space(48), 1, 48) else rodlinha := rodlinha + copy(rodape.linha1 + space(48), 1, 47) + '.';
            if rodape.linha2 <> '' then if trim(copy(rodape.linha2, 40, 1)) <> '' then rodlinha := rodlinha + copy(rodape.linha2 + space(48), 1, 48) else rodlinha := rodlinha + copy(rodape.linha2 + space(48), 1, 47) + '.';
            if rodape.linha3 <> '' then if trim(copy(rodape.linha3, 40, 1)) <> '' then rodlinha := rodlinha + copy(rodape.linha3 + space(48), 1, 48) else rodlinha := rodlinha + copy(rodape.linha3 + space(48), 1, 47) + '.';
            if rodape.linha4 <> '' then if trim(copy(rodape.linha4, 40, 1)) <> '' then rodlinha := rodlinha + copy(rodape.linha4 + space(48), 1, 48) else rodlinha := rodlinha + copy(rodape.linha4 + space(48), 1, 47) + '.';
            if rodape.linha5 <> '' then if trim(copy(rodape.linha5, 40, 1)) <> '' then rodlinha := rodlinha + copy(rodape.linha5 + space(48), 1, 48) else rodlinha := rodlinha + copy(rodape.linha5 + space(48), 1, 47) + '.';
            if rodlinha = '' then rodlinha := '------------------------------------------------';
            Result := Bem_proc('34|' + rodlinha + #13);
         end;
      BematechMP40:
         begin
            rodlinha := '';
            if rodape.linha1 <> '' then if trim(copy(rodape.linha1, 40, 1)) <> '' then rodlinha := rodlinha + copy(rodape.linha1 + space(40), 1, 40) else rodlinha := rodlinha + copy(rodape.linha1 + space(40), 1, 39) + '.';
            if rodape.linha2 <> '' then if trim(copy(rodape.linha2, 40, 1)) <> '' then rodlinha := rodlinha + copy(rodape.linha2 + space(40), 1, 40) else rodlinha := rodlinha + copy(rodape.linha2 + space(40), 1, 39) + '.';
            if rodape.linha3 <> '' then if trim(copy(rodape.linha3, 40, 1)) <> '' then rodlinha := rodlinha + copy(rodape.linha3 + space(40), 1, 40) else rodlinha := rodlinha + copy(rodape.linha3 + space(40), 1, 39) + '.';
            if rodape.linha4 <> '' then if trim(copy(rodape.linha4, 40, 1)) <> '' then rodlinha := rodlinha + copy(rodape.linha4 + space(40), 1, 40) else rodlinha := rodlinha + copy(rodape.linha4 + space(40), 1, 39) + '.';
            if rodape.linha5 <> '' then if trim(copy(rodape.linha5, 40, 1)) <> '' then rodlinha := rodlinha + copy(rodape.linha5 + space(40), 1, 40) else rodlinha := rodlinha + copy(rodape.linha5 + space(40), 1, 39) + '.';
            if rodlinha = '' then rodlinha := '----------------------------------------';
            Result := Bem_proc('34|' + rodlinha + #13);
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
   end;
end;
////////////////////////////////////////////////////////////////
function TDefFPrinters.CancelaUltimoItem(Descricao, Valor: string): Boolean;
////////////////////////////////////////////////////////////////
var
   a, b, c, d: string;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      demo: Result := true;
      Dataregis: result := Dtr_Proc('B');
      Sweda03: Result := swd_proc(#27 + '.04}');
      Sweda10: Result := swd_proc(#27 + '.04}');
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
      BematechMP40, BematechMP20: Result := bem_proc('13');
      //Procomp_2011: LeProComp(Procomp_CancItem(Contai_zant)); // Procomp precisa do numero do item p/ cancelar
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_CancelamentoItem(zcomp(IntToStr(contai_zant), 3), ultimaresp));
         end;
   end;
   if Result then begin
      ValorCupom := IntToStr(strtointdef(ValorCupom, 0) - strtointdef(tiravg(ptov(valor)), 0));
      if assigned(FTotalCupom) then OnTotalCupom(valorCupom);
   end;
end;
////////////////////////////////////////////////////////////////
function TDefFPrinters.AtivaVerao: Boolean;
////////////////////////////////////////////////////////////////
begin
   Result := false;
   case Impressora of
      None: Result := false;
      demo: Result := true;
      Dataregis: result := Dtr_Proc('TA');
      Sweda03: Result := swd_proc(#27 + '.36S}');
      Sweda10: Result := swd_proc(#27 + '.36S}');
      NCR2x, NCR7141, NCR1X: Result := false;
      Urano2EFE: Result := URN_Ret(Urano2EFE_programaRelogio('1', '000000', '000000'));
      Urano1EFC, Urano2EFC: Result := urn_ret3(UranoEFC_ProgramaRelogio('1', '', ''));
      Urano1FIT: Result := urn_ret2(Urano1FIT_ProgramaRelogio('1', '', ''));
      ZanthusIZ11, ZanthusIZ10, Zanthus2e, ZanthusIZ20, ZanthusIZ21, ZanthusIZ41: Result := Zan_Proc('\', '1');
      Schalter3D: Result := retornoschd(Schalter3D_AcertaData(strtoint(copy(dados.dataimp, 1, 2)), strtoint(copy(dados.dataimp, 3, 2)), strtoint('20' + copy(dados.dataimp, 5, 2)), strtointdef(copy(dados.horaimp, 1, 2), 0) + 1, strtoint(copy(dados.horaimp, 3, 2)), 0));
      Schalter2S: Result := retsch2(Schalter2S_ecfAcertaData(strtoint(copy(dados.dataimp, 1, 2)), strtoint(copy(dados.dataimp, 3, 2)), strtoint('20' + copy(dados.dataimp, 5, 2)), strtointdef(copy(dados.horaimp, 1, 2), 0) + 1, strtoint(copy(dados.horaimp, 3, 2)), 0));
      BematechMP40, BematechMP20: Result := bem_proc('18');
      Procomp_2011: LeProComp(Procomp_ProgramaHorarioVerao('+'), True); // 0 Sem relatoria Vinculado 1 Com relatorio vinculado
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_ProgramaHorarioVerao('+', ultimaresp));
         end;
   end;
end;
////////////////////////////////////////////////////////////////
function TDefFPrinters.DestivaVerao: Boolean;
////////////////////////////////////////////////////////////////
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
      BematechMP40, BematechMP20: Result := bem_proc('18');
      Procomp_2011: LeProComp(Procomp_ProgramaHorarioVerao('-'), True); // 0 Sem relatoria Vinculado 1 Com relatorio vinculado
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_ProgramaHorarioVerao('-', ultimaresp));
         end;
   end;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinters.CancelaCupomAtual: Boolean;
////////////////////////////////////////////////////////////////////////////////////////////
begin
   Result := false;
   case Impressora of
      None: Result := false;
      demo: Result := true;
      Dataregis:
         begin
            Result := DTR_proc('D0000000000000000000000000000000000');
            sleep(4000);
            if Result then Result := DTR_proc('F');
            sleep(10000);
         end;
      Sweda03: Result := swd_proc(#27 + '.05}');
      Sweda10: Result := swd_proc(#27 + '.05}');
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
            result := retornoSchd(Schalter3D_CancVenda(''));
            retornoSchd(Schalter3D_lineFeed(1, 7));
         end;
      Schalter2S:
         begin
            result := retsch2(Schalter2S_ecfCancVenda(pchar('Oper:' + dados.operador)));
            retsch2(Schalter2S_ecflineFeed(1, 7));
         end;
      BematechMP40, BematechMP20: Result := bem_proc('14');
      Procomp_2011: LeProComp(Procomp_CancelaCupomFiscal, True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_CancelaCupomFiscal(ultimaresp));
         end;
   end;
end;
////////////////////////////////////////////////////////////////
function TDefFPrinters.ImprimeCheque(param, valor, Favorecido, Cidade, data, Banco, ArqLayout, espacamento: string): Boolean;
////////////////////////////////////////////////////////////////
var
   x: Integer;
   snd, a, b, c: string;
   CmdSwd: array[0..512] of Char;
begin
   Result := false;
   case Impressora of
      None, Urano1FIT: Result := false;
      demo: Result := true;
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
      Sweda03:
         begin
            Pronto := false;
            StrPCopy(Cmdswd, #27 + '.240 }');
            UltimaResp := Sweda_EnviaComando(CmdSwd);
            while copy(UltimaResp, 2, 1) = '-' do begin
               sleep(500);
               StrPCopy(Cmdswd, #27 + '.23}');
               UltimaResp := Sweda_EnviaComando(CmdSwd);
               Application.ProcessMessages;
            end;
            if (copy(ultimaresp, 2, 1) = '+') and (copy(ultimaresp, 5, 1) <> '0') then begin
               swd_proc(#27 + '.25}');
               dados.mensagem := 'Tempo Esgotado para impressao';
               onError('Dados do Cheque', 'Tempo Esgotado para impressao ' + #13 + 'Cancelada impressão do Cheque');
               Result := false;
               exit;
            end;
            str(strtointdef(tiramsc(valor), 0) / 100: 8: 2, a);
            snd := #27 + '.240 }';
            sleep(500);
            b := extenso(StrToFloat(ptov(valor)) / 100);
            c := copy(b, 77 - strtointdef(sepdados(param, 4), 0), 77 - strtointdef(sepdados(param, 6), 0));
            b := copy(b, 1, 77 - strtointdef(sepdados(param, 4), 0));
            for x := 1 to 13 do begin
               if strtointdef(sepdados(param, 1), 0) = x then begin
                  snd := #27 + '.240' + space(strtointdef(sepdados(param, 2), 0) - 1) + '(' + ptov(trim(a)) + ')}';
               end;
               if strtointdef(sepdados(param, 3), 0) = x then begin
                  //snd := #27 + '.240' + space(strtointdef(sepdados(param,4),0)) + copy(a,1,77 - strtointdef(sepdados(param,4),0) - 1) + '}';
                  snd := #27 + '.240' + space(strtointdef(sepdados(param, 4), 0)) + b + '}';
               end;
               if strtointdef(sepdados(param, 5), 0) = x then begin
                  //if 77 - strtointdef(sepdados(param,4),0) > 3 then begin
                     //a := extenso(StrToFloat(ptov(valor))/100);
                     //snd := #27 + '.240' + space(strtointdef(sepdados(param,6),0)) + copy(a,77 - Length(a) - strtointdef(sepdados(param,4),0) + 1,50) + '}';
                  //end;
                  if c <> '' then snd := #27 + '.240' + space(strtointdef(sepdados(param, 4), 0)) + c + '}';

               end;
               if strtointdef(sepdados(param, 7), 0) = x then snd := #27 + '.240' + space(strtointdef(sepdados(param, 8), 0)) + favorecido + '}';
               if strtointdef(sepdados(param, 9), 0) = x then begin
                  snd := #27 + '.240' + space(strtointdef(sepdados(param, 10), 0)) + cidade;
                  snd := snd + space(strtointdef(sepdados(param, 11), 0) - Length(snd)) + copy(data, 1, 2);
                  snd := snd + space(strtointdef(sepdados(param, 12), 0) - Length(snd)) + nmmes(copy(data, 3, 2));
                  snd := snd + space(strtointdef(sepdados(param, 13), 0) - Length(snd)) + copy(data, 5, 2) + '}';
               end;
               Result := swd_proc(snd);
               snd := #27 + '.240 }';
               sleep(500);
            end;
            Result := swd_proc(#27 + '.25}');
            StrPCopy(Cmdswd, #27 + '.23}');
            UltimaResp := Sweda_EnviaComando(CmdSwd);
            while copy(UltimaResp, 2, 1) = '-' do begin
               sleep(500);
               StrPCopy(Cmdswd, #27 + '.23}');
               UltimaResp := Sweda_EnviaComando(CmdSwd);
               Application.ProcessMessages;
            end;
            sleep(1000);
            pronto := true;
         end;
      Sweda10: Result := swd_proc(#27 + '.24'
            + zcomp(banco, 3) // Banco
            + zcomp(valor, 12) // Valor
            + ' ' // Verso
            + space(120) // Informacoes
            + '2' // numero de digitos para expressao o ano
            + copy(data, 1, 4) + '20' + copy(data, 5, 2) + '}'); // Data
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
      BematechMP40:
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
      Schalter2S: Result := true;
   end;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinters.cancelaItem(Item, posicao: string): Boolean;
////////////////////////////////////////////////////////////////////////////////////////////
var
   a, b, c, d, temp: string;
begin
   posicao := IntToStr(strtointdef(posicao, 0)); // retira Zeros a esquerda, evitando problemas de mascara
   Result := false;
   case Impressora of
      None: Result := false;
      demo: Result := true;
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
      Sweda03: Result := false;
      Sweda10: Result := swd_proc(#27 + '.04' + zcomp(posicao, 3) + '}');
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
      BematechMP40, BematechMP20: Result := bem_proc('31|' + zcomp(posicao, 4));
      Procomp_2011: LeProComp(Procomp_CancelamentoItem(copy(Posicao, 3, 4)), True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Result := Trends_ret(Trends_CancelamentoItem(zcomp(posicao, 3), ultimaresp));
         end;
   end;
   if Result = true then begin
      ValorCupom := IntToStr(strtointdef(ValorCupom, 0) - (StrtointDef(sepdados(Item, 4), 0) * StrtointDef(sepdados(Item, 5), 0)));
      if assigned(FTotalCupom) then OnTotalCupom(valorCupom);
   end;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinters.DescontoEmSubtotal(Valor: string): Boolean;
////////////////////////////////////////////////////////////////////////////////////////////
var
   aComando: array[0..0] of Char;
   a, b: string;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      demo: Result := true;
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
      BematechMP40, BematechMP20: Result := bem_proc('32|d|' + tiravg(ptov(valor)));
      Procomp_2011: LeProComp(Procomp_TotalizarCupom(StrPCopy(aComando, '@'), PChar('&'), PChar(zComp(Valor, 15)), PChar(space(15))), True);
      Trends10E:
         begin
            dtr_desconto := valor;
            Result := true;
         end;
   end;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinters.AcrescimoEmSubtotal(Valor: string): Boolean;
////////////////////////////////////////////////////////////////////////////////////////////
var
   aComando: array[0..0] of Char;
   a, b: string;
begin
   Result := false;
   case Impressora of
      None: Result := false;
      demo: Result := true;
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
      BematechMP40, BematechMP20: Result := bem_proc('32|a|' + tiravg(ptov(valor)));
      Procomp_2011: LeProComp(Procomp_TotalizarCupom(StrPCopy(aComando, ''), PChar('&'), PChar(zComp(Valor, 15)), PChar(space(15))), True);
      Trends10E:
         begin
            dtr_acrescimo := valor;
            Result := true;
         end;
   end;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinters.Autentica(Dados: string): Boolean;
////////////////////////////////////////////////////////////////////////////////////////////
var
   CmdSwd: array[0..512] of Char;
begin
   Result := false;
   case Impressora of
      None, Urano1FIT: Result := false;
      demo: Result := true;
      Dataregis: result := DTR_Proc('E');
      Sweda03:
         begin
            pronto := false;
            StrPCopy(Cmdswd, #27 + '.260' + copy(dados + space(40), 1, 40) + '}');
            UltimaResp := Sweda_EnviaComando(CmdSwd);
            while copy(UltimaResp, 5, 1) <> '0' do begin
               sleep(500);
               StrPCopy(Cmdswd, #27 + '.23}');
               UltimaResp := Sweda_EnviaComando(CmdSwd);
               Application.ProcessMessages;
            end;
            sleep(1000);
            //if (copy(ultimaresp,2,1) = '+') and (copy(ultimaresp,5,1) <> '0') then begin
             //  swd_proc(#27 + '.25}');
               //dados.Mensagem := 'Tempo Esgotado para impressao';
              // onError('Dados do Cheque', 'Tempo Esgotado para impressao ' + #13 + 'Cancelada impressão do Cheque');
               //Result := false;
               //exit;
//            end;}

            Result := swd_proc(#27 + '.260' + copy(dados + space(40), 1, 40) + '}');
            swd_proc(#27 + '.25}');

            StrPCopy(Cmdswd, #27 + '.23}');
            UltimaResp := Sweda_EnviaComando(CmdSwd);
            while copy(UltimaResp, 2, 1) = '-' do begin
               sleep(500);
               StrPCopy(Cmdswd, #27 + '.23}');
               UltimaResp := Sweda_EnviaComando(CmdSwd);
               Application.ProcessMessages;
            end;
            pronto := true;
         end;
      //Sweda10: Result := swd_proc(#27 + '.200N' + scomp(dados, 15) + '1N}');
      Sweda10: Result := swd_proc(#27 + '.200N' + '000000000000000' + '1N}');
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
      BematechMP40, BematechMP20: Result := bem_proc('16');
      Procomp_2011: LeProComp(Procomp_ImprimeValidacao(dados, ''), True);
      Trends10E:
         begin
            Ultimaresp := space(1000);
            Trends_ModoChequeValidacao('0', '0', ultimaresp);
            Result := Trends_ret(Trends_ImprimeValidacao('|   |', #0, ultimaresp));
         end;
   end;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinters.LeituraMemoriaFiscalData(datainicial, datafinal: string): boolean;
////////////////////////////////////////////////////////////////////////////////////////////
begin
   Result := false;
   case Impressora of
      Dataregis: result := DTR_proc('IN' + datainicial + datafinal);
      NCR2x, NCR7141, NCR1x: Result := NCR_Proc('67' + datainicial + '\' + datafinal);
      BematechMP40, BematechMP20: Result := bem_proc('|8|' + datainicial + '|' + datafinal + '|I|');
      Schalter3D:
         begin
            Result := retornoschd(Schalter3D_LeitMemFisc(1, LPSTR(datainicial), LPSTR(datafinal), 1, 10, 'memSch.txt'));
            retornoschd(Schalter3D_LineFeed(1, 9));
         end;
      Sweda10, Sweda03: Result := swd_proc(#27 + '.16' + datainicial + datafinal + '}');
      Schalter2S:
         begin
            Result := retsch2(Schalter2S_ecfLeitMemFisc(1, LPSTR(datainicial), LPSTR(datafinal), 1, 1, 'memSch.Text'));
            Schalter2S_ecfLineFeed(1, 7);
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
   end;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinters.LeituraMemoriaFiscalReducao(reducaoinicial, reducaofinal: string): boolean;
////////////////////////////////////////////////////////////////////////////////////////////
begin
   Result := false;
   case Impressora of
      Dataregis: result := DTR_proc('iN' + zcomp(reducaoinicial, 4) + zcomp(reducaofinal, 4));
      NCR2x, NCR7141, NCR1x: Result := NCR_Proc('66' + reducaoinicial + '\' + reducaofinal);
      BematechMP40, BematechMP20: Result := bem_proc('|08|00|' + reducaoinicial + '|00|' + reducaofinal + '|I|');
      Schalter3D:
         begin
            Result := retornoschd(Schalter3D_LeitMemFisc(2, LPSTR('010101'), LPSTR('100101'), StrToInt(reducaoinicial), StrToInt(reducaofinal), 'memSch.txt'));
            retornoschd(Schalter3D_LineFeed(1, 9));
         end;
      Sweda10, Sweda03: Result := swd_proc(#27 + '.15' + zcomp(reducaoinicial, 4) + zcomp(reducaofinal, 4) + '}');
      Schalter2S:
         begin
            Result := retsch2(Schalter2S_ecfLeitMemFisc(2, LPSTR('010101'), LPSTR('010101'), StrToInt(reducaoinicial), StrToInt(reducaofinal), 'memSch.Text'));
            Schalter2S_ecfLineFeed(1, 7);
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
   end;
end;

////////////////////////////////////////////
function TDefFPrinters.Modelos: string;
////////////////////////////////////////////
begin
   Result :=
      //'Demo' + '|' +
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
      'Trends10E' + '|';
end;
////////////////////////////////////////////
procedure TDefFPrinters.ProgModalidades;
////////////////////////////////////////////
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
      BematechMP40, BematechMP20:
         begin
            Bem_proc('39|1');
            //Bem_proc('73|CHEQUE|CHEQUE-PRE|TICKET|CARTAO|VALE|CONVENIO|CONTRA-VALE|CREDIARIO|BONUS');
            //BEM_PROC('64|000|126|018|018|126|000|126|064|064|126|000|002|002|126|126|002|002|000'); // AUT
            //BEM_PROC('64|000|126|018|018|012|000|126|066|066|060|000|006|024|096|096|024|006|000'); // PDV
         end;
   end;
end;
////////////////////////////////////////////
function TDefFPrinters.urn_esp(Liga: string): boolean;
////////////////////////////////////////////
begin
   Result := false;
   case Impressora of
      Urano2EFE: if Liga = 'S' then Result := urn_ret(Urano2EFE_EspacamentoLinhas(1)) else Result := urn_ret(Urano2EFE_EspacamentoLinhas(0));
      Urano1FIT: if Liga = 'S' then Result := urn_ret2(Urano1FIT_EspacamentoLinhas(1)) else Result := urn_ret2(Urano1FIT_EspacamentoLinhas(0));
   end;
end;
////////////////////////////////////////////
function TDefFPrinters.urn_naofisc(codigo, desc, valor, nome, codcli, cpf: string): boolean;
////////////////////////////////////////////
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
function TDefFPrinters.swd_naofisc(codigo, desc, valor, nome, codcli, cpf: string): boolean;
////////////////////////////////////////////
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
function TDefFPrinters.urn_log(Liga: string): boolean;
////////////////////////////////////////////
begin
   Result := false;
   case Impressora of
      Urano1FIT: if Liga = 'S' then Result := urn_ret2(Urano1FIT_LogSerial('1')) else Result := urn_ret2(Urano1FIT_LogSerial('0'));
   end;
end;
////////////////////////////////////////////
function TDefFPrinters.bem_refsan(sanref, valor: string): boolean;
////////////////////////////////////////////
begin
   Result := Bem_proc('25|' + sanref + '|' + zcomp(tiravg(ptov(valor)), 14));
end;
////////////////////////////////////////////
function TDefFPrinters.VeriDelphi: boolean;
////////////////////////////////////////////
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
   //if not Result then MessageDlg('Versão demonstrativa do Fprinter...' + #13 + #13 + 'Maiores informações em www.fprinter.cjb.net',mtWarning, [mbOK],0);
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinters.IntToHex(numero: integer): string;
////////////////////////////////////////////////////////////////////////////////////////////
const
   hex: array[0..15] of char = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
begin
   while numero <> 0 do begin
      result := hex[15 and numero] + result; {=(n mod 15)}
      numero := numero shr 4;
   end; {=n div 16}
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinters.HextoInt(HexStr: string): integer;
////////////////////////////////////////////////////////////////////////////////////////////
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
function TDefFPrinters.inttobin(data: Integer): string;
////////////////////////////////////////////
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
function TDefFPrinters.bintoint(data: string): Integer;
////////////////////////////////////////////
var
   x: integer;
   res: Integer;
begin
   res := 0;
   for x := 1 to length(data) do res := res + (strtoint(data[length(data) - (x - 1)]) * round(intpower(2, (x - 1))));
   result := res;
end;
////////////////////////////////////////////////////////////////////////////////////////////
function TDefFPrinters.Versao: string;
////////////////////////////////////////////////////////////////////////////////////////////
begin
   Result := 'EFiscal 1.0';
end;


/////////////////////////////////////////////////
procedure TDefFPrinters.timeDelay(msecs: integer); // Atrasa a execucao em Milisegundos
/////////////////////////////////////////////////
var
   FirstTick: longint;
begin
   if msecs = 0 then exit;
   FirstTick := GetTickCount;
   repeat
      Application.ProcessMessages;
   until GetTickCount - FirstTick >= msecs;
end;

////////////////////////////////////////////
function TDefFPrinters.BiosInfo: string;
////////////////////////////////////////////
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
function TDefFPrinters.CPUMHz: string;
////////////////////////////////////////////
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
   if mhi < 0 then chi := chi + shr32;
   clo := mlo;
   if mlo < 0 then clo := clo + shr32;
   t0 := chi * shr32 + clo;
   chi := nhi;
   if nhi < 0 then chi := chi + shr32;
   clo := nlo;
   if nlo < 0 then clo := clo + shr32;
   t1 := chi * shr32 + clo;
   result := formatfloat('#####0.0', (t1 - t0) / 1E6);
end;
///////////////////////////////////////////////////////
function TDefFPrinters.VerificaEAN(CodEan: string): boolean;
///////////////////////////////////////////////////////
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
function TDefFPrinters.Crypto(const Str1: string): string;
////////////////////////////////////////////////
var
   Mascara, Str2: string;
   PonM, PonS: Byte;
begin
   Mascara := 'LKJSDFKLASJFIOWEFNAKSDFNLAKJDFLS'; //'#$%$'#13#12; {Esta string e' o segredo da criptografia}
   Str2 := '';
   PonM := 1;
   for PonS := 1 to length(Str1) do begin
      AppendStr(Str2, Chr(Ord(Str1[PonS]) xor Ord(Mascara[PonM])));
      Inc(PonM);
      if PonM > Length(Mascara) then PonM := 1;
   end;
   Result := Str2;
end;
////////////////////////////////////////////
function TDefFPrinters.CarregaECF: boolean;
////////////////////////////////////////////
begin
   case impressora of
      Sweda03, Sweda10:
         begin
            NomeDll := 'ECFiscal1.dll';
            HandleDLL := LoadLibrary(PChar(NomeDll));
            if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
            Result := true;
            @Sweda_AbrePorta := GetProcAddress(HandleDLL, 'AbrePorta');
            @Sweda_EnviaComando := GetProcAddress(HandleDLL, 'EnviaComando');
            @Sweda_FechaPorta := GetProcAddress(HandleDLL, 'FechaPorta');
         end;
      NCR1x, NCR2x, NCR7141:
         begin
            NomeDll := 'ECFiscal2.dll';
            HandleDLL := LoadLibrary(PChar(NomeDll));
            if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
            Result := true;
            @NCR_SendCMD := GetProcAddress(HandleDLL, '_IF_SendCmd@12');
            @NCR_SetComPort := GetProcAddress(HandleDLL, '_IF_SetCommPort@4');
         end;
      Urano2EFE:
         begin
            NomeDll := 'ECFiscal3.dll';
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
            NomeDll := 'ECFiscal4.dll';
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
      BematechMP40, BematechMP20:
         begin
            NomeDll := 'ECFiscal5.dll';
            HandleDLL := LoadLibrary(PChar(NomeDll));
            if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
            Result := true;
            @Bematech_IniPortaStr := GetProcAddress(HandleDLL, 'IniPortaStr');
            @Bematech_FormataTX := GetProcAddress(HandleDLL, 'FormataTX');
            @Bematech_FechaPorta := GetProcAddress(HandleDLL, 'FechaPorta');
            @Bematech_Status_Mp20FI := GetProcAddress(HandleDLL, 'Status_Mp20FI');
         end;
      Schalter3D:
         begin
            NomeDll := 'ECFiscal6.dll';
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
            @Schalter3D_Venda_Item := GetProcAddress(HandleDLL, 'ecfVenda_Item');
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
         end;
      Urano1FIT:
         begin
            NomeDll := 'ECFiscal7.dll';
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
            NomeDll := 'ECFiscal8.dll';
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
            NomeDll := 'ECFiscal9.dll';
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
            NomeDll := 'ECFiscal10.dll';
            HandleDLL := LoadLibrary(PChar(NomeDll));
            if HandleDLL = 0 then raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [NomeDll, GetLastError]);
            Result := true;
            Dataregis_AbrePorta := GetProcAddress(HandleDLL, 'DTR_AbrePorta');
            Dataregis_FechaPorta := GetProcAddress(HandleDLL, 'DTR_FechaPorta');
            Dataregis_EnviaComando := GetProcAddress(HandleDLL, 'DTR_EnviaComando');
         end;
      Procomp_2011:
         begin
            NomeDll := 'ECFiscal11.dll';
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
            NomeDll := 'ECFiscal12.dll';
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
   else Result := true;
   end;
end;

end.

