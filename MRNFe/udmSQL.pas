unit udmSQL;

interface

uses
  SysUtils, Classes, DB, DBTables, ADODB, pcnConversao, pcnNFE, Provider,
  DBClient, PowerADOQuery, LookUpADOQuery;

const
  TIPO_NOTA_VENDA         = 0;
  TIPO_NOTA_TRANSFERENCIA = 1;

  NFE_VERSAO = '1.0.0.22';

type
  TdaNotaFiscal = class(TObject)
  private

  public
    function SelectedCount: integer;
    function ProximaSelecionada: boolean;
    procedure First;
    procedure Next;
  end;

  TdmSQL = class(TDataModule)
    ADOConnection: TADOConnection;
    dsInvoice: TADODataSet;
    dsInvoiceItem: TADODataSet;
    adodsNotaFiscal: TADODataSet;
    cdsNotaFiscal: TClientDataSet;
    dspNotaFiscal: TDataSetProvider;
    dsNotaFiscal: TDataSource;
    dsImportarVendas: TADODataSet;
    spGetNextID: TADOStoredProc;
    cmdInsertMovimento: TADOCommand;
    dsTransferencia: TADODataSet;
    dsTransferenciaItem: TADODataSet;
    dsImportarTransferencia: TADODataSet;
    dsInvoiceItemIDInventoryMov: TIntegerField;
    dsInvoiceItemM_Model: TStringField;
    dsInvoiceItemM_Description: TStringField;
    dsInvoiceItemIM_QTY: TBCDField;
    dsInvoiceItemIM_SalePrice: TBCDField;
    dsInvoiceItemU_Unidade: TStringField;
    dsInvoiceItemU_Sigla: TStringField;
    dsInvoiceItemT_SituacaoTributaria: TIntegerField;
    dsInvoiceItemTaxCategoriaPer: TBCDField;
    dsInvoiceItemTaxEstadoPerc: TBCDField;
    dsInvoiceItemTaxItemPer: TBCDField;
    dsInvoiceItemEstadoCliente: TStringField;
    dsInvoiceItemEstadoLoja: TStringField;
    dsInvoiceItemMVAInterno: TBCDField;
    dsInvoiceItemMVAInterestadual: TBCDField;
    dsInvoiceItemSitTribItem: TIntegerField;
    dsInvoiceItemSitTribCategoria: TIntegerField;
    dsTransferenciaItemIDInventoryMov: TIntegerField;
    dsTransferenciaItemM_Model: TStringField;
    dsTransferenciaItemM_Description: TStringField;
    dsTransferenciaItemIM_QTY: TBCDField;
    dsTransferenciaItemIM_SalePrice: TBCDField;
    dsTransferenciaItemU_Unidade: TStringField;
    dsTransferenciaItemU_Sigla: TStringField;
    dsTransferenciaItemT_SituacaoTributaria: TIntegerField;
    dsTransferenciaItemTaxCategoriaPer: TBCDField;
    dsTransferenciaItemTaxEstadoPerc: TBCDField;
    dsTransferenciaItemTaxItemPer: TBCDField;
    dsTransferenciaItemEstadoCliente: TStringField;
    dsTransferenciaItemEstadoLoja: TStringField;
    dsTransferenciaItemMVAInterno: TBCDField;
    dsTransferenciaItemMVAInterestadual: TBCDField;
    dsTransferenciaItemSitTribItem: TIntegerField;
    dsTransferenciaItemSitTribCategoria: TIntegerField;
    dsInvoiceItemCFOP_Number: TStringField;
    dsTransferenciaItemCFOP_Number: TStringField;
    dsInvoiceItemT_Aliquota: TCurrencyField;
    dsTransferenciaItemT_Aliquota: TCurrencyField;
    dsInvoiceItemIM_Frete: TBCDField;
    dsTransferenciaItemIM_Frete: TBCDField;
    dsInvoiceItemTotalFrete: TBCDField;
    dsTransferenciaItemTotalFrete: TBCDField;
    dsInvoiceItemIM_Discount: TBCDField;
    dsTransferenciaItemIM_Discount: TBCDField;
    dsInvoiceItemM_SerialNumber: TBooleanField;
    dsTransferenciaItemM_SerialNumber: TBooleanField;
    dsInvItemSerial: TADODataSet;
    dsInvoiceItemM_NCMCodigo: TStringField;
    quLookUPEmpresa: TLookUpADOQuery;
    quLookUPEmpresaIDEmpresa: TIntegerField;
    quLookUPEmpresaEmpresa: TStringField;
    dsLookUpEmpresa: TDataSource;
    dsInvoiceItemMVAPercent: TCurrencyField;
    dsTransferenciaItemMVAPercent: TCurrencyField;
    dsInvoiceItemT_AliquotaST: TBCDField;
    dsTransferenciaItemT_AliquotaST: TBCDField;
    dsInvoiceItemAliquotaDesc: TStringField;
    dsTransferenciaItemAliquotaDesc: TStringField;
    dsTransferenciaItemM_NCMCodigo: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure dsInvoiceItemCalcFields(DataSet: TDataSet);
    procedure dsInvoiceAfterOpen(DataSet: TDataSet);
    procedure dsTransferenciaItemCalcFields(DataSet: TDataSet);
    procedure dsTransferenciaAfterOpen(DataSet: TDataSet);
  private
    FCFOP : String;
    function GetNextID(Const sTabela: String): LongInt;
    function RetChar(sEntrada: String): String;
    function AcertaCEP(sCEP: String): Integer;
    function GetTpNF(cInvoiceSubTotal: currency): TpcnTipoNFe;
    function GetTipoFrete(iTipo: Integer): TpcnModalidadeFrete;
    function GetIndPag(i: integer): TpcnIndicadorPagamento;
    function GetUnidade(sUnidade: String): String;
    function DateAsSring(aDateTime: TDateTime): String;
    function MontaCNPJCPF(sCNPJ, sCPF: String; bJuridico: boolean): String;
    function GetNotaFiscalSQL( iSituacaoIndex: integer; sOrigem, sReferencia: String;
                               dtInicio, dtFim: TDateTime): String;

    procedure PreencheVenda(IDInvoice: integer; aNFe: TNFe);
    procedure PreencheVendaItem(IDInvoice: integer; aNFe: TNFe);

    procedure PreencheTransferencia(IDTransferencia: integer; aNFe: TNFe);
    procedure PreencheTransferenciaItem(IDTransferencia: integer; aNFe: TNFe);

    function GetModelSerialNumber(iIDInvMov : Integer):String;
  public
    FTipoNota       : Integer;
    FAmbiente       : TpcnTipoAmbiente;
    daNotaFiscal    : TdaNotaFiscal;
    FCalcFreete     : Boolean;
    FHideItemDesc   : Boolean;
    FIDEmpresaVenda : Integer;
    FDecimal        : Integer;
    FNumCopia       : Integer;

    procedure AbreCdsNotaFiscal( iSituacaoIndex: integer; sOrigem, sReferencia: String;
                                 dtInicio, dtFim: TDateTime);

    procedure SelectAll(bSelected: boolean);

    procedure PreecheNotaFiscal(aNFe: TNFe);

    procedure SalvaFalhaEnvio(sXMLEnviado, sXMLRecebido, sMensagemErro: WideString);
    procedure SalvaSucessoEnvio(sXMLEnviado, sXMLRecebido: WideString; sChave : String);
    procedure SalvaEnvioCompleto(sXMLEnviado, sXMLRecebido: WideString; sChave : String);
    procedure SalvaAprovacaoEnvio(sXMLRecebido: WideString);
    procedure SalvaCancelamentoEnvio(sXMLRecebido: WideString);
    procedure SalvaImpressao;

    function InserirMovimento(AOrigem : String; AID : Integer):boolean;

    function RetornaXMLNotaFiscal : String;
    function GetIDEmpresa : Variant;
    function IsAmbienteProducao: Boolean;
  end;


const
  SQL_FORMATACAO_DATA = ' YYYYMMDD';

  SQL_NF_SITUACAO_PENDENTE        = 'Pendente';
  SQL_NF_SITUACAO_ERRO_ENVIO      = 'ErroEnvio';
  SQL_NF_SITUACAO_AGUARDANDO      = 'Aguardando';
  SQL_NF_SITUACAO_APROVADA        = 'Aprovada';
  SQL_NF_SITUACAO_REJEITADA       = 'Rejeitada';
  SQL_NF_SITUACAO_IMPRESSA        = 'Impressa';
  SQL_NF_SITUACAO_CANCELADA       = 'Cancelada';

var
  dmSQL: TdmSQL;

implementation

uses ufrmGerenciaEnvioNF, uFrmServerInfo, Registry, uParamFunctions,
  uSystemConst, Variants, uStringfunctions, uNumericFunctions;

{$R *.dfm}

{ TdaNF }

procedure TdaNotaFiscal.First;
begin
  dmSQL.cdsNotaFiscal.First;
end;

procedure TdaNotaFiscal.Next;
begin
  dmSQL.cdsNotaFiscal.Next;
end;

function TdaNotaFiscal.ProximaSelecionada: boolean;
begin
  with dmSQL.cdsNotaFiscal do
  try
    DisableControls;

    while (not FieldByName('Selecionado').AsBoolean and not EOF) do
      Next;

    Result := not EOF;
  finally
    EnableControls;
  end;
end;

function TdaNotaFiscal.SelectedCount: integer;
begin
  Result := 0;
  with dmSQL.cdsNotaFiscal do
  try
    DisableControls;
    First;
    while not EOF do begin
      if FieldByName('Selecionado').AsBoolean then
        Inc(Result);
      Next;
    end;
    First;
  finally
    EnableControls
  end;
end;

{ TdmSQL }

function TdmSQL.RetChar(sEntrada: String): String;
var
  i: integer;
begin
  Result := '';
  for i := 1 to Length(sEntrada) do
    if (sEntrada[i] >= '0') and (sEntrada[i] <= '9') then
      Result := Result + sEntrada[i];
end;

function TdmSQL.AcertaCEP(sCEP: String): Integer;
begin
  result := StrToIntDef(RetChar(sCEP), 0);
end;

function TdmSQL.GetIndPag(i: integer): TpcnIndicadorPagamento;
begin
  case i of
    0: result := ipVista;
    1: result := ipPrazo;
    else result := ipOutras;
  end;
end;

function TdmSQL.GetTipoFrete(iTipo: Integer): TpcnModalidadeFrete;
begin
  if iTipo = 2 then
    Result := mfContaDestinatario
  else
    Result := mfContaEmitente;
end;

function TdmSQL.GetTpNF(cInvoiceSubTotal: currency): TpcnTipoNFe;
begin
  if cInvoiceSubTotal < 0 then
    result := tnEntrada
  else
    result := tnSaida;
end;

function TdmSQL.GetUnidade(sUnidade: String): String;
begin
  if Trim(sUnidade) = '' then
    result := 'UN'
  else
    result := Trim(sUnidade);
end;

procedure TdmSQL.PreencheVenda(IDInvoice: integer; aNFe: TNFe);
begin
  with dsInvoice do
  try
    Parameters.ParamByName('IDInvoice').value := IDInvoice;
    Parameters.ParamByName('IDEmpresa').value := GetIDEmpresa;
    Open;

    aNFe.infNFe.ID  := FieldByName('I_InvoiceCode').AsString;

    // -------------------------------------------------------------------------
    // Identificacao
    // -------------------------------------------------------------------------
    with aNFe.Ide do begin
      verProc := NFE_VERSAO;
      tpAmb   := FAmbiente;

      // Descrição da Natureza da Operação
      natOp := FieldByName('CFOP_Description').AsString;

      // Número do Documento Fiscal
      nNF := FieldByName('I_InvoiceCode').AsInteger;

      // Código numérico que compõe a Chave de Acesso. Número
      // aleatório gerado pelo emitente para cada NF-e para evitar
      // acessos indevidos da NF-e.
      cNF := FieldByName('I_InvoiceCode').AsInteger;

      // Utilizar o código 55 para identificação da NF-e, emitida em
      // substituição ao modelo 1 ou 1A.
      modelo := 55;

      // Série do Documento Fiscal, informar 0 (zero) para série única.
      serie := 1;

      // Data de emissão do Documento Fiscal
      dEmi := FieldByName('I_InvoiceDate').AsDateTime;

      // Data de Saída ou da Entrada da Mercadoria/Produto
      dSaiEnt := FieldByName('I_InvoiceDate').AsDateTime;

      // Tipo do Documento Fiscal (Entrada / Saida)
      if FCalcFreete then
        tpNF := GetTpNF(FieldByName('I_SubTotal').AsCurrency + FieldByName('I_Frete').AsCurrency)
      else
        tpNF := GetTpNF(FieldByName('I_SubTotal').AsCurrency);

      // Pagamento a vista ou parcelado?
      indPag := GetindPag(FieldByName('I_IDFormOfPayment').AsInteger);

      // Código da UF do emitente do Documento Fiscal
      cUF := StrToIntDef(FieldByName('E_UFCodigo').AsString, 0);

      // Código do Município de Ocorrência do Fato Gerador
      cMunFG := StrToIntDef(FieldByName('E_MunicipioCode').AsString, 0);

      //Indicador de pagamento 0 – pagamento à vista; 1 – pagamento à prazo; 2 - outros.
      case FieldByName('I_IndPayment').AsInteger of
        0 : indPag := ipVista;
        1 : indPag := ipPrazo;
      end;
    end;

    

    // -------------------------------------------------------------------------
    // Emitente
    // -------------------------------------------------------------------------
    with aNFe.Emit do begin
      // Autoexplicativo
      CNPJCPF := RetChar(FieldByName('E_CGC').AsString);

      // Inscricao estadual
      IE := RetChar(FieldByName('E_InscricaoEstadual').AsString);

      // Razão Social ou Nome do Emitente
      xNome := FieldByName('E_RazaoSocial').AsString;

      // Nome fantasia
      xFant := FieldByName('E_NomeFantasia').AsString;
    end;

    // -------------------------------------------------------------------------
    // Endereco do Emitente
    // -------------------------------------------------------------------------
    with aNFe.Emit.EnderEmit do begin
      // Logradouro
      xLgr := FieldByName('E_Endereco').AsString;

      // Numero
      nro := FieldByName('E_Numero').AsString;

      // Complemento
      xCpl := FieldByName('E_Coplemento').AsString;

      // Bairro
      xBairro := FieldByName('E_Bairro').AsString;

      // Codigo do municipio segundo o IBGE
      cMun := StrToIntDef(FieldByName('E_MunicipioCode').AsString, 0);

      // Nome do município
      xMun := FieldByName('E_Municipio').AsString;

      // Sigla da UF
      UF := FieldByName('E_IDEstado').AsString;

      CEP   := AcertaCEP(FieldByName('E_CEP').AsString);
      cPais := 1058;
      xPais := 'BRASIL';

      // Preencher com Código DDD + número do telefone
      fone := FieldByName('E_Telefone').AsString;

    end;

    // -------------------------------------------------------------------------
    // Destinatario
    // -------------------------------------------------------------------------
    with aNFe.Dest do begin
      // CNPJ ou CPF
      CNPJCPF := MontaCNPJCPF(  FieldByName('P_CPF').AsString,
                                FieldByName('P_CPF').AsString,
                                FieldByName('P_Juridico').AsBoolean );

      // Inscricao Estadual
      // Informar a IE quando o destinatário for contribuinto do ICMS.
      // Informar ISENTO quando o destinatário for contribuinto do
      // ICMS, mas não estiver obrigado à inscrição no cadastro de
      // contribuintes do ICMS. Não informar o conteúdo da TAG
      // se o destinatário não for contribuinte do ICMS.
      IE := RetChar(FieldByName('P_InscEstadual').AsString);

      //Razão Social ou nome do destinatário
      xNome := FieldByName('P_Pessoa').AsString;
    end;

    // -------------------------------------------------------------------------
    // Endereco do destinatario
    // -------------------------------------------------------------------------
    with aNFe.Dest.EnderDest do begin
      xLgr    := FieldByName('P_Endereco').AsString;
      nro     := FieldByName('P_ComplementoNum').AsString;
      xCpl    := FieldByName('P_Complemento').AsString;
      xBairro := FieldByName('P_Bairro').AsString;
      cMun    := StrToIntDef(FieldByName('P_MunicipioCode').AsString, 0);
      xMun    := FieldByName('P_Municipio').AsString;
      UF      := FieldByName('P_IDEstado').AsString;
      CEP     := AcertaCEP(FieldByName('P_CEP').AsString);
      cPais   := 1058;
      xPais   := 'BRASIL';

      // Preencher com Código DDD + número do telefone
      Fone := Trim( FieldByName('P_PhoneAreaCode').AsString +
                    FieldByName('P_Telefone').AsString );
    end;

    // -------------------------------------------------------------------------
    // Transportadora
    // -------------------------------------------------------------------------
    if FieldByName('T_Pessoa').AsString <> '' then
    begin

      aNFe.Transp.modFrete := GetTipoFrete(FieldByName('T_TipoDeFrete').AsInteger);

      aNFe.Transp.veicTransp.RNTC  := '';
      aNFe.Transp.veicTransp.placa := '';
      aNFe.Transp.veicTransp.UF    := '';

      with aNFe.Transp.Transporta do begin
        xEnder  := FieldByName('T_Endereco').AsString;
        xMun    := FieldByName('T_Municipio').AsString;
        xNome   := FieldByName('T_Pessoa').AsString;
        CNPJCPF := FieldByName('T_CPF').AsString;
        IE      := FieldByName('T_InscEstadual').AsString;
        UF      := FieldByName('T_IDEstado').AsString;
      end;

    end;

    // -------------------------------------------------------------------------
    // INFORMAÇÕES COMPLEMENTARES
    // -------------------------------------------------------------------------
    if FieldByName('I_DeliverConfirmation').AsBoolean then
    begin
      aNFe.InfAdic.infCpl := FieldByName('I_DeliverAddress').AsString + '. ';
      if FieldByName('I_DeliverOBS').AsString <> '' then
        aNFe.InfAdic.infCpl := aNFe.InfAdic.infCpl + FieldByName('I_DeliverOBS').AsString + '. ';
    end;


    if FieldByName('I_PrintNotes').AsBoolean then
      aNFe.InfAdic.infCpl := aNFe.InfAdic.infCpl + FieldByName('I_Notes').AsString + '. ';

  finally
    Close;
  end;

end;

procedure TdmSQL.PreencheVendaItem(IDInvoice: integer; aNFe: TNFe);
var
  dciItem: TDetCollectionItem;
  iCount: integer;
  cTotalFrete, cItemFreteTotal, cAcrescimo, cDesconto : Currency;
  sInfoSub, sSerialNum : String;
begin
  iCount := 1;
  with dsInvoiceItem do
  try
    Parameters.ParamByName('IDInvoice').value := IDInvoice;
    Open;

    if FCalcFreete then
      cTotalFrete := FieldByName('TotalFrete').AsCurrency
    else
      cTotalFrete := 0;

    cItemFreteTotal := 0;

    // Zera os totais
    with aNFe.Total.ICMSTot do begin
      vBC   := 0;
      vBCST := 0;
      vICMS := 0;
      vST   := 0;
      vNF   := 0;
      vProd := 0;
    end;

    while not EOF do begin
      // Adiciona um novo item a nota
      dciItem := aNFe.Det.Add;

      // -----------------------------------------------------------------------
      // Produto
      // -----------------------------------------------------------------------
      with dciItem.Prod do begin
        // Numero do item na nota
        nItem := iCount;

        // Código do produto ou serviço
        cProd := FieldByName('M_Model').AsString;

        // Descrição do produto ou serviço
        xProd := FieldByName('M_Description').AsString;

        // NCM do Produto
        if (FieldByName('M_NCMCodigo').AsString <> '') then
          NCM := ReturnNumber(FieldByName('M_NCMCodigo').AsString);

        // Quantidade Comercial
        qCom := ABS(FieldByName('IM_QTY').AsCurrency);

        // Quantidade Tributável
        qTrib := ABS(FieldByName('IM_QTY').AsCurrency);

        //Valor Desconto/Acrescimo total do produto
        cDesconto := FieldByName('IM_Discount').AsCurrency;

        if not FHideItemDesc then
        begin
          cAcrescimo := 0;
          if cDesconto < 0 then
            cAcrescimo := ABS(cDesconto)
          else
            vDesc := cDesconto;

          // Valor Unitário de comercialização
          vUnCom := ABS(FieldByName('IM_SalePrice').AsCurrency) + (cAcrescimo/qCom);

          // Valor Unitário de tributação
          vUnTrib := ABS(FieldByName('IM_SalePrice').AsCurrency) + (cAcrescimo/qCom);
        end
        else
        begin //Colocar o valor do desconto dentro do valor de venda
          cAcrescimo := 0;
          if cDesconto < 0 then
            cAcrescimo := ABS(cDesconto)
          else
            vDesc := 0;

          // Valor Unitário de comercialização
          vUnCom := ABS(FieldByName('IM_SalePrice').AsCurrency) - (cDesconto) + (cAcrescimo/qCom);

          // Valor Unitário de tributação
          vUnTrib := ABS(FieldByName('IM_SalePrice').AsCurrency) - (cDesconto) + (cAcrescimo/qCom);
        end;

        // Valor Total Bruto dos Produtos ou Serviços
        vProd := TruncDecimal((vUnCom * qCom) - (vDesc * qCom), FDecimal);

        // Unidade Comercial
        uCom := GetUnidade(FieldByName('U_Sigla').AsString);

        // Unidade Tributável
        uTrib := GetUnidade(FieldByName('U_Sigla').AsString);

        // Código Fiscal de Operações e Prestações
        //TODO
        CFOP := FieldByName('CFOP_Number').AsString;
        //CFOP := '5949';

        // Frete (Total do Frete divido por produto)
        if FCalcFreete then
        begin
          vFrete := FieldByName('IM_Frete').AsCurrency;
          cItemFreteTotal := cItemFreteTotal + vFrete;
          //Ajustar o ultimo registro arredondando o desconto para bater com desconto total
          if (RecNo = RecordCount) then
          begin
            if (cItemFreteTotal < cTotalFrete) then
              vFrete := vFrete + ABS(cItemFreteTotal - cTotalFrete)
            else if (cItemFreteTotal > cTotalFrete) then
              vFrete := vFrete - ABS(cItemFreteTotal - cTotalFrete);
          end;
        end
        else
          vFrete := 0;
      end;

      //Informações de OBS quando o produto for Substituicao
      if (sInfoSub = '') and (FieldByName('T_SituacaoTributaria').AsInteger = TAX_SUBSTITUICAO) then
        sInfoSub := 'SUBSTITUIÇÃO TRIB. ICMS CONF. DECRETO Nº 41.961/2009';

      // -----------------------------------------------------------------------
      // IMPOSTO
      // -----------------------------------------------------------------------
        {
         //cst
         - Tributação do ICMS: 00 – Tributada integralmente.
         - Tributação do ICMS: 10 - Tributada e com cobrança do ICMS por substituição tributária
         - Tributação do ICMS: 20 - Com redução de base de cálculo
         - Tributação do ICMS: 30 - Isenta ou não tributada e com cobrança do ICMS por substituição tributária
         - Tributação do ICMS: 40 - Isenta
         - Tributação do ICMS: 41 - Não tributada
         - Tributação do ICMS: 50 - Suspensão
         - Tributação do ICMS: 51 - Diferimento A exigência do preenchimento das informações do ICMS diferido fica a critério de cada UF.
         - Tributação do ICMS: 60 - ICMS cobrado anteriormente por substituição tributária
         - Tributação do ICMS: 70 - Com redução de base de cálculo e cobrança do ICMS por substituição tributária
         - Tributação do ICMS: 90 – Outros
        }
      with dciItem.Imposto.ICMS do begin
        // Origem da mercadoria
        orig := oeNacional;

        case FieldByName('T_SituacaoTributaria').AsInteger of

          TAX_NENHUMA,
          TAX_ISENTO,
          TAX_NAOTRIBUTAVEL,
          TAX_ISS,
          TAX_TRIBUTAVEL :
            begin
              CST := cst00;

              // Modalidade de determinação da BC do ICMS
              modBC := dbiPrecoTabelado;

              // Alíquota do imposto
              pICMS := FieldByName('T_Aliquota').AsFloat;

              // Base de calculo do ICMS
              vBC := dciItem.Prod.vProd;

              // Valor do ICMS
              vICMS := vBC * (pICMS/100);
            end;


          TAX_SUBSTITUICAO :
            begin
              //Substituição Tributaria
              CST := cst10;

              //Modalidade de determinação da BC do ICMS: 0 - Margem Valor Agregado (%); 1 - Pauta (Valor); 2 - Preço Tabelado Máx. (valor); 3 - valor da operação.
              //modBC := 0;

              //Base de calculo do ICMS
              vBC := dciItem.Prod.vProd;

              //Alíquota do imposto loja
              pICMS := FieldByName('T_Aliquota').AsFloat;

              // Valor do ICMS loja
              vICMS := vBC * (pICMS/100);

              //Modalidade de determinação da BC do ICMS ST: 0 – Preço tabelado ou máximo sugerido; 1 - Lista Negativa (valor); 2 - Lista Positiva (valor); 3 - Lista Neutra (valor); 4 - Margem Valor Agregado (%); 5 - Pauta (valor);
              modBCST := dbisPrecoTabelado;

              //Percentual da margem de valor Adicionado do ICMS ST
              pMVAST := FieldByName('MVAPercent').AsCurrency;

              //Percentual da Redução de BC do ICMS ST
              pRedBCST := 0;

              //Alíquota do imposto substituicao
              pICMSST := FieldByName('T_AliquotaST').AsCurrency;

              //Valor Base de calculo do ICMS Substituicao
              vBCST := (dciItem.Prod.vProd + (dciItem.Prod.vProd * (pICMSST/100)));

              //Valor do ICMS Substituicao
              vICMSST := ((vBCST * (pICMS/100)) - vICMS);
            end;

          {
          TAX_ISENTO :
            begin
              CST := cst40;
            end;

          TAX_NAOTRIBUTAVEL :
            begin
              CST := cst41;
            end;


          TAX_ISS :
            begin
            end;
          }
        end;
      end;

      // -----------------------------------------------------------------------
      // Adiciona o item aos totais da nota
      // -----------------------------------------------------------------------
      with aNFe.Total.ICMSTot do begin
        // Base de Cálculo do ICMS
        vBC := vBC + dciItem.Imposto.ICMS.vBC;

        // Base de Cálculo do ICMS Substituicao
        vBCST := vBCST + dciItem.Imposto.ICMS.vBCST;

        // Valor Total do ICMS
        vICMS := vICMS + dciItem.Imposto.ICMS.vICMS;

        // Valor Total do ICMS Substituicao
        vST := vST + dciItem.Imposto.ICMS.vICMSST;

        // Valor Total da NF-e / vST = verificar
        vNF := vNF + dciItem.Prod.vProd + dciItem.Imposto.ICMS.vICMSST;

        // Valor Total dos produtos e serviços
        vProd := vProd + dciItem.Prod.vProd;

        // Valor Total do Frete
        vFrete := vFrete + dciItem.Prod.vFrete;

        // Valor Total de Desconto
        vDesc := vDesc + (dciItem.Prod.vDesc * dciItem.Prod.qCom);

      end;

      //Verifica Numero de Serie do produto
      if FieldByName('M_SerialNumber').AsBoolean then
        sSerialNum := sSerialNum + FieldByName('M_Model').AsString + ' N/S:' + GetModelSerialNumber(FieldByName('IDInventoryMov').AsInteger) +'. ';

      Next;
      Inc(iCount);
    end;

    if sSerialNum <> '' then
      aNFe.InfAdic.infCpl := sSerialNum + ' .' + aNFe.InfAdic.infCpl;

    if (sInfoSub <> '') then
      aNFe.InfAdic.infCpl := aNFe.InfAdic.infCpl + sInfoSub;

  finally
    Close;
  end;
end;

function TdmSQL.GetNotaFiscalSQL(iSituacaoIndex: integer; sOrigem, sReferencia: String;
                                  dtInicio, dtFim: TDateTime): String;
var
  slSQL: TStringList;
begin
  slSQL := TStringList.Create;
  with slSQL do
    try
      Add('SELECT');
      Add('  NF.IDNotaFiscal,');
      Add('  Convert(bit, 0) as Selecionado,');
      Add('  NF.Origem,');
      Add('  NF.Referencia,');
      Add('  NF.Situacao,');
      Add('  NF.DataSolicitacao,');
      Add('  NF.DataUltimoEnvio,');
      Add('  NF.DataResultado,');
      Add('  NF.DataUltimaImpressao,');
      Add('  NF.XMLEnviado,');
      Add('  NF.XMLRecebido,');
      Add('  NF.DetalhamentoErro,');
      Add('  NF.QtdEnvios,');
      Add('  NF.QtdImpressao,');
      Add('  NF.Chave,');
      Add('  I.InvoiceCode,');
      Add('  I.SaleCode,');
      Add('  (CASE Origem WHEN ' + QuotedStr('Venda') + ' THEN I.InvoiceCode ELSE MT.Number END) as NumeroNota');
      Add('FROM');
      Add('  NFE_NotaFiscal NF (NOLOCK)');
      Add('  LEFT JOIN Invoice I (NOLOCK) ON (I.IDInvoice = NF.Referencia )');
      Add('  LEFT JOIN ModelTransf MT (NOLOCK) ON (MT.IDModelTransf = NF.Referencia AND MT.TransferType = 0)');
      Add('WHERE');

      case iSituacaoIndex of
        CMB_SITUACAO_PENDENTE: begin
          Add('  NF.Situacao IN (' + QuotedStr(SQL_NF_SITUACAO_PENDENTE) + ',');
          Add('                  ' + QuotedStr(SQL_NF_SITUACAO_ERRO_ENVIO) + ')');
          Add('  AND');
        end;
        CMB_SITUACAO_AGUARDANDO: begin
          Add('  NF.Situacao IN (' + QuotedStr(SQL_NF_SITUACAO_AGUARDANDO) + ')');
          Add('  AND');
        end;
        CMB_SITUACAO_APROVADA: begin
          Add('  NF.Situacao IN (' + QuotedStr(SQL_NF_SITUACAO_APROVADA) + ')');
          Add('  AND');
        end;
        CMB_SITUACAO_REJEITADA: begin
          Add('  NF.Situacao IN (' + QuotedStr(SQL_NF_SITUACAO_REJEITADA) + ')');
          Add('  AND');
        end;
        CMB_SITUACAO_IMPRESSA: begin
          Add('  NF.Situacao IN (' + QuotedStr(SQL_NF_SITUACAO_IMPRESSA) + ')');
          Add('  AND');
        end;
        CMB_SITUACAO_CANCELADA: begin
          Add('  NF.Situacao IN (' + QuotedStr(SQL_NF_SITUACAO_CANCELADA) + ')');
          Add('  AND');
        end;
        CMB_SITUACAO_ERROR: begin
          Add('  NF.Situacao IN (' + QuotedStr(SQL_NF_SITUACAO_ERRO_ENVIO) + ')');
          Add('  AND');
        end;
        CMB_SITUACAO_TODAS: begin
          // Nada
        end;
      end;

      Add('  NF.Origem = ' + QuotedStr(sOrigem));
      Add('  AND');

      if sReferencia <> '' then
      begin
        if FTipoNota = TIPO_NOTA_VENDA then
          Add('  I.InvoiceCode = ' + QuotedStr(sReferencia))
        else
          Add('  MT.Number = ' + QuotedStr(sReferencia));
      end
      else
      begin
        if FTipoNota = TIPO_NOTA_VENDA then
        begin
          Add('  I.InvoiceDate >= ' + DateAsSring(Trunc(dtInicio)));
          Add('  AND');
          Add('  I.InvoiceDate < ' + DateAsSring(Trunc(dtFim) + 1));
        end
        else
        begin
          Add('  MT.Data >= ' + DateAsSring(Trunc(dtInicio)));
          Add('  AND');
          Add('  MT.Data < ' + DateAsSring(Trunc(dtFim) + 1));
        end;
      end;

      Result := Text;
    finally
      slSQL.Free;
    end;

end;

procedure TdmSQL.AbreCdsNotaFiscal(iSituacaoIndex: integer; sOrigem, sReferencia: String;
                                dtInicio, dtFim: TDateTime);
begin
  with adodsNotaFiscal do
  begin
    Close;
    CommandText := GetNotaFiscalSQL(  iSituacaoIndex,
                                      sOrigem,
                                      sReferencia,
                                      dtInicio,
                                      dtFim );
    Open;
    FieldByName('Selecionado').ReadOnly := False;
  end;

  with cdsNotaFiscal do begin
    Close;
    Open;
  end;

  adodsNotaFiscal.Close;

end;

function TdmSQL.DateAsSring(aDateTime: TDateTime): String;
begin
  result := QuotedStr(FormatDateTime(SQL_FORMATACAO_DATA, aDateTime));
end;

function TdmSQL.MontaCNPJCPF(sCNPJ, sCPF: String;
  bJuridico: boolean): String;
begin
  if bJuridico then
    Result := sCNPJ
  else
    Result := sCPF;

  Result := RetChar(Result);
end;

procedure TdmSQL.PreecheNotaFiscal(aNFe: TNFe);
begin
  // ECOSTA completar transferencia
  with cdsNotaFiscal do
    case FTipoNota of
      TIPO_NOTA_VENDA :
        begin
          PreencheVenda(FieldByName('Referencia').AsInteger, aNFe);
          PreencheVendaItem(FieldByName('Referencia').AsInteger, aNFe);
        end;

      TIPO_NOTA_TRANSFERENCIA :
        begin
          PreencheTransferencia(FieldByName('Referencia').AsInteger, aNFe);
          PreencheTransferenciaItem(FieldByName('Referencia').AsInteger, aNFe);
        end;
    end;
end;

procedure TdmSQL.DataModuleCreate(Sender: TObject);
var
  sResult : String;
  bAbort, ExitConnection : Boolean;
  FrmServrInfo : TFrmServerInfo;
  UserName, PW, DBAlias, Server, Status : String;
  WinLogin, UseNetLib : Boolean;
begin

  FrmServrInfo := TFrmServerInfo.Create(self);
  try

    sResult := FrmServrInfo.Start('4', False, '', bAbort);
    ExitConnection := bAbort;

    While not ExitConnection do
    try
      Server    := ParseParam(sResult, SV_SERVER);
      DBAlias   := ParseParam(sResult, SV_DATABASE);
      UserName  := ParseParam(sResult, SV_USER);
      PW        := ParseParam(sResult, SV_PASSWORD);
      WinLogin  := (ParseParam(sResult, SV_WIN_LOGIN)[1] in ['Y']);
      UseNetLib := (ParseParam(sResult, SV_USE_NETLIB)[1] = 'Y');
      Status    := SQL_STATUS_NO_CONNECTED;

      if not WinLogin then
         if UseNetLib then
            sResult := SetConnectionStr(UserName, PW, DBAlias, Server)
         else
            sResult := SetConnectionStrNoNETLIB(UserName, PW, DBAlias, Server)
      else
         if UseNetLib then
            sResult := SetWinConnectionStr(DBAlias, Server)
         else
            sResult := SetWinConnectionStrNoNETLIB(DBAlias, Server);

      ADOConnection.ConnectionString := sResult;
      ExitConnection := True;
    except
      on E: Exception do
        begin
        sResult := FrmServrInfo.Start('4', True, E.Message, bAbort);
        ExitConnection := bAbort;
        end;
     end;

  finally
    FreeAndNil(FrmServrInfo);
  end;

  daNotaFiscal := TdaNotaFiscal.create;
  
end;

procedure TdmSQL.DataModuleDestroy(Sender: TObject);
begin
  daNotaFiscal.Free;
end;

procedure TdmSQL.SalvaImpressao;
var
  slSQL: TStringList;
begin
  slSQL := TStringList.Create;
  with slSQL do
    try
      Add('UPDATE Nfe_NotaFiscal SET');
      Add('  Situacao = ' + QuotedStr(SQL_NF_SITUACAO_IMPRESSA) + ',');
      Add('  DataUltimaImpressao = GetDate(),');
      Add('  QtdImpressao = (IsNull(QtdImpressao, 0) + 1)');
      Add('WHERE IDNotaFiscal = ' + cdsNotaFiscal.FieldByName('IDNotaFiscal').AsString);
      ADOConnection.Execute(Text);
    finally
      Free;
    end;
end;

procedure TdmSQL.SalvaEnvioCompleto(sXMLEnviado, sXMLRecebido: WideString;
  sChave : String);
var
  slSQL: TStringList;
begin
  slSQL := TStringList.Create;
  with slSQL do
    try
      Add('UPDATE Nfe_NotaFiscal SET');
      Add('  Situacao = ' + QuotedStr(SQL_NF_SITUACAO_IMPRESSA) + ',');
      Add('  DataUltimoEnvio = GetDate(),');
      Add('  DataResultado = GetDate(),');
      Add('  DataUltimaImpressao = GetDate(),');
      Add('  QtdEnvios = (IsNull(QtdEnvios, 0) + 1),');
      Add('  QtdImpressao = (IsNull(QtdImpressao, 0) + 1),');
      Add('  Chave = ' + QuotedStr(sChave) + ',');
      Add('  XMLEnviado = ' + QuotedStr(sXMLEnviado) + ',');
      Add('  XMLRecebido = ' + QuotedStr(sXMLRecebido));
      Add('WHERE IDNotaFiscal = ' + cdsNotaFiscal.FieldByName('IDNotaFiscal').AsString);
      ADOConnection.Execute(Text);
    finally
      Free;
    end;
end;


procedure TdmSQL.SalvaFalhaEnvio(sXMLEnviado, sXMLRecebido, sMensagemErro: WideString);
var
  slSQL: TStringList;
begin
  slSQL := TStringList.Create;
  with slSQL do
    try
      Add('UPDATE Nfe_NotaFiscal SET');
      Add('  Situacao = ' + QuotedStr(SQL_NF_SITUACAO_ERRO_ENVIO) + ',');
      Add('  DataUltimoEnvio = GetDate(),');
      Add('  QtdEnvios = (IsNull(QtdEnvios, 0) + 1),');
      Add('  XMLEnviado = ' + QuotedStr(sXMLEnviado) + ',');
      Add('  XMLRecebido = ' + QuotedStr(sXMLRecebido) + ',');
      Add('  DetalhamentoErro = ' + QuotedStr(sMensagemErro) );
      Add('WHERE IDNotaFiscal = ' + cdsNotaFiscal.FieldByName('IDNotaFiscal').AsString);
      ADOConnection.Execute(Text);
    finally
      Free;
    end;
end;

procedure TdmSQL.SalvaSucessoEnvio(sXMLEnviado, sXMLRecebido: WideString;
  sChave : String);
var
  slSQL: TStringList;
begin
  slSQL := TStringList.Create;
  with slSQL do
    try
      Add('UPDATE Nfe_NotaFiscal SET');
      Add('  Situacao = ' + QuotedStr(SQL_NF_SITUACAO_AGUARDANDO) + ',');
      Add('  DataUltimoEnvio = GetDate(),');
      Add('  QtdEnvios = (IsNull(QtdEnvios, 0) + 1),');
      Add('  XMLEnviado = ' + QuotedStr(sXMLEnviado) + ',');
      Add('  XMLRecebido = ' + QuotedStr(sXMLRecebido) + ',');
      Add('  Chave = ' + QuotedStr(sChave) + ',');
      Add('  DetalhamentoErro = ' + QuotedStr('') );
      Add('WHERE IDNotaFiscal = ' + cdsNotaFiscal.FieldByName('IDNotaFiscal').AsString);
      ADOConnection.Execute(Text);
    finally
      Free;
    end;
end;

procedure TdmSQL.SalvaCancelamentoEnvio(sXMLRecebido: WideString);
var
  slSQL: TStringList;
begin
  slSQL := TStringList.Create;
  with slSQL do
    try
      Add('UPDATE Nfe_NotaFiscal SET');
      Add('  Situacao = ' + QuotedStr(SQL_NF_SITUACAO_CANCELADA) + ',');
      Add('  DataUltimoEnvio = GetDate(),');
      Add('  XMLRecebido = ' + QuotedStr(sXMLRecebido));
      Add('WHERE IDNotaFiscal = ' + cdsNotaFiscal.FieldByName('IDNotaFiscal').AsString);
      ADOConnection.Execute(Text);
    finally
      Free;
    end;
end;

procedure TdmSQL.SalvaAprovacaoEnvio(sXMLRecebido: WideString);
var
  slSQL: TStringList;
begin
  slSQL := TStringList.Create;
  with slSQL do
    try
      Add('UPDATE Nfe_NotaFiscal SET');
      Add('  Situacao = ' + QuotedStr(SQL_NF_SITUACAO_APROVADA) + ',');
      Add('  DataResultado = GetDate(),');
      Add('  XMLRecebido = ' + QuotedStr(sXMLRecebido) + ',');
      Add('  DetalhamentoErro = ' + QuotedStr('') );
      Add('WHERE IDNotaFiscal = ' + cdsNotaFiscal.FieldByName('IDNotaFiscal').AsString);
      ADOConnection.Execute(Text);
    finally
      Free;
    end;
end;

procedure TdmSQL.SelectAll(bSelected: boolean);
begin
  with dmSQL.cdsNotaFiscal do
  try
    DisableControls;
    First;
    while not EOF do begin
      Edit;
      FieldByName('Selecionado').AsBoolean := bSelected;
      Post;
      Next;
    end;
    First;
  finally
    EnableControls
  end;
end;

function TdmSQL.InserirMovimento(AOrigem: String; AID: Integer): boolean;
begin

  Result := False;

  with cmdInsertMovimento do
  begin
    Parameters.ParamByName('IDNotaFiscal').Value      := GetNextID('NFE_NotaFiscal.IDNotaFiscal');
    Parameters.ParamByName('DataSolicitacao').Value   := Now;
    Parameters.ParamByName('Situacao').Value          := 'Pendente';
    Parameters.ParamByName('Origem').Value            := AOrigem;
    Parameters.ParamByName('Referencia').Value        := AID;
    Parameters.ParamByName('IDUserSolicitacao').Value := 1;
    Execute;
  end;

  Result := True;
  
end;

function TdmSQL.GetNextID(const sTabela: String): LongInt;
begin

  with spGetNextID do
  begin
    Parameters.ParamByName('@Tabela').Value := sTabela;
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
  end;

end;

function TdmSQL.RetornaXMLNotaFiscal: String;
begin
  Result := dmSQL.cdsNotaFiscal.FieldByName('XMLEnviado').AsString;
end;

procedure TdmSQL.PreencheTransferencia(IDTransferencia: integer;
  aNFe: TNFe);
begin
  with dsTransferencia do
  try
    Parameters.ParamByName('IDModelTransf').value := IDTransferencia;
    Open;

    aNFe.infNFe.ID  := FieldByName('I_InvoiceCode').AsString;

    // -------------------------------------------------------------------------
    // Identificacao
    // -------------------------------------------------------------------------
    with aNFe.Ide do begin
      verProc := NFE_VERSAO;
      tpAmb   := FAmbiente;

      // Descrição da Natureza da Operação
      natOp := FieldByName('CFOP_Description').AsString;

      // Número do Documento Fiscal
      nNF := FieldByName('I_InvoiceCode').AsInteger;

      // Código numérico que compõe a Chave de Acesso. Número
      // aleatório gerado pelo emitente para cada NF-e para evitar
      // acessos indevidos da NF-e.
      cNF := FieldByName('I_InvoiceCode').AsInteger;

      // Utilizar o código 55 para identificação da NF-e, emitida em
      // substituição ao modelo 1 ou 1A.
      modelo := 55;

      // Série do Documento Fiscal, informar 0 (zero) para série única.
      serie := 1;

      // Data de emissão do Documento Fiscal
      dEmi := FieldByName('I_InvoiceDate').AsDateTime;

      // Data de Saída ou da Entrada da Mercadoria/Produto
      dSaiEnt := FieldByName('I_InvoiceDate').AsDateTime;

      // Tipo do Documento Fiscal (Entrada / Saida)
      tpNF := GetTpNF(FieldByName('I_SubTotal').AsCurrency);

      // Pagamento a vista ou parcelado?
      indPag := GetindPag(FieldByName('I_IDFormOfPayment').AsInteger);

      // Código da UF do emitente do Documento Fiscal
      cUF := StrToIntDef(FieldByName('E_UFCodigo').AsString, 0);

      // Código do Município de Ocorrência do Fato Gerador
      cMunFG := StrToIntDef(FieldByName('E_MunicipioCode').AsString, 0);
    end;

    // -------------------------------------------------------------------------
    // Emitente
    // -------------------------------------------------------------------------
    with aNFe.Emit do begin
      // Autoexplicativo
      CNPJCPF := RetChar(FieldByName('E_CGC').AsString);

      // Inscricao estadual
      IE := RetChar(FieldByName('E_InscricaoEstadual').AsString);

      // Razão Social ou Nome do Emitente
      xNome := FieldByName('E_RazaoSocial').AsString;

      // Nome fantasia
      xFant := FieldByName('E_NomeFantasia').AsString;
    end;

    // -------------------------------------------------------------------------
    // Endereco do Emitente
    // -------------------------------------------------------------------------
    with aNFe.Emit.EnderEmit do begin
      // Logradouro
      xLgr := FieldByName('E_Endereco').AsString;

      // Numero
      nro := FieldByName('E_Numero').AsString;

      // Complemento
      xCpl := FieldByName('E_Coplemento').AsString;

      // Bairro
      xBairro := FieldByName('E_Bairro').AsString;

      // Codigo do municipio segundo o IBGE
      cMun := StrToIntDef(FieldByName('E_MunicipioCode').AsString, 0);

      // Nome do município
      xMun := FieldByName('E_Municipio').AsString;

      // Sigla da UF
      UF := FieldByName('E_IDEstado').AsString;

      CEP   := AcertaCEP(FieldByName('E_CEP').AsString);
      cPais := 1058;
      xPais := 'BRASIL';

      // Preencher com Código DDD + número do telefone
      fone := FieldByName('E_Telefone').AsString;

    end;

    // -------------------------------------------------------------------------
    // Destinatario
    // -------------------------------------------------------------------------
    with aNFe.Dest do begin
      // CNPJ ou CPF
      CNPJCPF := RetChar(FieldByName('P_CPF').AsString);

      // Inscricao Estadual
      // Informar a IE quando o destinatário for contribuinto do ICMS.
      // Informar ISENTO quando o destinatário for contribuinto do
      // ICMS, mas não estiver obrigado à inscrição no cadastro de
      // contribuintes do ICMS. Não informar o conteúdo da TAG
      // se o destinatário não for contribuinte do ICMS.
      IE := RetChar(FieldByName('P_InscEstadual').AsString);

      //Razão Social ou nome do destinatário
      xNome := FieldByName('P_Pessoa').AsString;
    end;

    // -------------------------------------------------------------------------
    // Endereco do destinatario
    // -------------------------------------------------------------------------
    with aNFe.Dest.EnderDest do begin
      xLgr    := FieldByName('P_Endereco').AsString;
      nro     := FieldByName('P_ComplementoNum').AsString;
      xCpl    := FieldByName('P_Complemento').AsString;
      xBairro := FieldByName('P_Bairro').AsString;
      cMun    := StrToIntDef(FieldByName('P_MunicipioCode').AsString, 0);
      xMun    := FieldByName('P_Municipio').AsString;
      UF      := FieldByName('P_IDEstado').AsString;
      CEP     := AcertaCEP(FieldByName('P_CEP').AsString);
      cPais   := 1058;
      xPais   := 'BRASIL';

      // Preencher com Código DDD + número do telefone
      Fone := Trim( FieldByName('P_PhoneAreaCode').AsString +
                    FieldByName('P_Telefone').AsString );
    end;

  finally
    Close;
  end;

end;

procedure TdmSQL.PreencheTransferenciaItem(IDTransferencia: integer;
  aNFe: TNFe);
var
  dciItem: TDetCollectionItem;
  iCount: integer;
begin
  iCount := 1;
  with dsTransferenciaItem do
  try
    Parameters.ParamByName('IDTransfer').value := IDTransferencia;
    Open;

    // Zera os totais
    with aNFe.Total.ICMSTot do begin
      vBC   := 0;
      vICMS := 0;
      vNF   := 0;
      vProd := 0;
    end;

    while not EOF do begin
      // Adiciona um novo item a nota
      dciItem := aNFe.Det.Add;

      // -----------------------------------------------------------------------
      // Produto
      // -----------------------------------------------------------------------
      with dciItem.Prod do begin
        // Numero do item na nota
        nItem := iCount;

        // Código do produto ou serviço
        cProd := FieldByName('M_Model').AsString;

        // Descrição do produto ou serviço
        xProd := FieldByName('M_Description').AsString;

        // Valor Unitário de comercialização
        vUnCom := ABS(FieldByName('IM_SalePrice').AsCurrency);

        // Valor Unitário de tributação
        vUnTrib := ABS(FieldByName('IM_SalePrice').AsCurrency);

        // Quantidade Comercial
        qCom := ABS(FieldByName('IM_QTY').AsCurrency);

        // Quantidade Tributável
        qTrib := ABS(FieldByName('IM_QTY').AsCurrency);

        // Valor Total Bruto dos Produtos ou Serviços
        vProd := TruncDecimal(vUnCom * qCom, 2);

        // Unidade Comercial
        uCom := GetUnidade(FieldByName('U_Sigla').AsString);

        // Unidade Tributável
        uTrib := GetUnidade(FieldByName('U_Sigla').AsString);

        // Código Fiscal de Operações e Prestações
        CFOP := FieldByName('CFOP_Number').AsString;
        //CFOP := '5949';
      end;

      // -----------------------------------------------------------------------
      // ICMS 00
      // -----------------------------------------------------------------------
      //TODO
      with dciItem.Imposto.ICMS do begin
        // Origem da mercadoria
        orig := oeNacional;

        // Tributação do ICMS. cst00 – Tributada integralmente.
        CST := cst00;

        // Modalidade de determinação da BC do ICMS
        modBC := dbiPrecoTabelado;

        // Alíquota do imposto
        pICMS := FieldByName('T_Aliquota').AsFloat;

        // Base de calculo do ICMS
        vBC := dciItem.Prod.vProd;

        // Valor do ICMS
        vICMS := vBC * (pICMS/100);

      end;

      // -----------------------------------------------------------------------
      // Adiciona o item aos totais da nota
      // -----------------------------------------------------------------------
      with aNFe.Total.ICMSTot do begin
        // Base de Cálculo do ICMS
        vBC := vBC + dciItem.Imposto.ICMS.vBC;

        // Valor Total do ICMS
        vICMS := vICMS + dciItem.Imposto.ICMS.vICMS;

        // Valor Total da NF-e
        vNF := vNF + dciItem.Prod.vProd;

        // Valor Total dos produtos e serviços
        vProd := vProd + dciItem.Prod.vProd;;
      end;

      Next;
      Inc(iCount);
    end;
  finally
    Close;
  end;
end;


procedure TdmSQL.dsInvoiceItemCalcFields(DataSet: TDataSet);
begin

  //ICMS Tributavel
  case dsInvoiceItem.FieldByName('T_SituacaoTributaria').AsInteger of
    TAX_TRIBUTAVEL :
      begin
        //Mesmo Estato
        if dsInvoiceItem.FieldByName('EstadoCliente').AsString = dsInvoiceItem.FieldByName('EstadoLoja').AsString then
          dsInvoiceItemT_Aliquota.AsCurrency := dsInvoiceItem.FieldByName('TaxCategoriaPer').AsCurrency
        else
        begin
          if dsInvoiceItem.FieldByName('TaxEstadoPerc').AsCurrency <> 0 then
            dsInvoiceItemT_Aliquota.AsCurrency := dsInvoiceItem.FieldByName('TaxEstadoPerc').AsCurrency
          else
            dsInvoiceItemT_Aliquota.AsCurrency := dsInvoiceItem.FieldByName('TaxCategoriaPer').AsCurrency
        end;

        dsInvoiceItem.FieldByName('AliquotaDesc').AsString := 'ICMS: ' + FormatFloat('0.00', dsInvoiceItemT_Aliquota.AsCurrency);
      end;

    TAX_SUBSTITUICAO :
    begin
      if dsInvoiceItem.FieldByName('EstadoCliente').AsString = dsInvoiceItem.FieldByName('EstadoLoja').AsString then
        dsInvoiceItem.FieldByName('MVAPercent').AsCurrency := dsInvoiceItem.FieldByName('MVAInterno').AsCurrency
      else
        dsInvoiceItem.FieldByName('MVAPercent').AsCurrency := dsInvoiceItem.FieldByName('MVAInterestadual').AsCurrency;

      dsInvoiceItemT_Aliquota.AsCurrency := dsInvoiceItem.FieldByName('TaxCategoriaPer').AsCurrency;

      dsInvoiceItem.FieldByName('AliquotaDesc').AsString := '(ICMS: ' + FormatFloat('0.00', dsInvoiceItemT_Aliquota.AsCurrency) +
                                                            ') (MVA: ' + FormatFloat('0.00', dsInvoiceItem.FieldByName('MVAPercent').AsCurrency) +
                                                            ') (ICMS-ST: ' + FormatFloat('0.00', dsInvoiceItem.FieldByName('T_AliquotaST').AsCurrency) + ')';

    end
    else
    begin
      dsInvoiceItemT_Aliquota.AsCurrency := dsInvoiceItem.FieldByName('TaxCategoriaPer').AsCurrency;
      dsInvoiceItem.FieldByName('AliquotaDesc').AsString := 'ICMS: ' + FormatFloat('0.00', dsInvoiceItemT_Aliquota.AsCurrency);
    end;
  end;


  dsInvoiceItemCFOP_Number.AsString  := FCFOP;

  {
  //Industria
  if dsInvoiceItemSituacaoTributariaItem.AsInteger <> TAX_NENHUMA then
  begin
    dsInvoiceItemT_Aliquota.AsCurrency          := dsInvoiceItemItemTax.AsCurrency;
  end
  else
  begin
    if dsInvoiceItemSituacaoTributaria.AsInteger in [TAX_TRIBUTAVEL, TAX_SUBSTITUICAO, TAX_ISS] then
    begin
      if dsInvoiceItemTaxEstadoPerc.AsCurrency = 0 then
        dsInvoiceItemT_Aliquota.AsCurrency := dsInvoiceItemTaxEstoquePer.AsCurrency
      else
        dsInvoiceItemT_Aliquota.AsCurrency := dsInvoiceItemTaxEstadoPerc.AsCurrency;
    end
    else
      dsInvoiceItemT_Aliquota.AsCurrency := 0;

  end;
  }
end;

procedure TdmSQL.dsInvoiceAfterOpen(DataSet: TDataSet);
begin
  // Numero da Natureza da Operação
  FCFOP := dsInvoice.FieldByName('CFOP_Number').AsString;
end;

procedure TdmSQL.dsTransferenciaItemCalcFields(DataSet: TDataSet);
begin
  dsTransferenciaItemCFOP_Number.AsString  := FCFOP;
  dsTransferenciaItem.FieldByName('AliquotaDesc').AsString := 'ICMS: ' + FormatFloat('0.00', dsTransferenciaItemT_Aliquota.AsCurrency);
end;

procedure TdmSQL.dsTransferenciaAfterOpen(DataSet: TDataSet);
begin

  // Numero da Natureza da Operação
  FCFOP := dsTransferencia.FieldByName('CFOP_Number').AsString;

end;

function TdmSQL.GetModelSerialNumber(iIDInvMov: Integer): String;
begin

  Result := '';

  with dsInvItemSerial do
  try
    Parameters.ParamByName('InventoryMovID').Value := iIDInvMov;
    Open;
    First;

    While not EOF do
    begin
      Result := Result + Trim(FieldbyName('SerialNumber').AsString);
      Next;
      if not EOF then
        Result := Result + '/';
    end;
  finally
    Close;
  end;

end;

function TdmSQL.GetIDEmpresa: Variant;
begin

  if FIDEmpresaVenda = 0 then
    Result := Null
  else
    Result := FIDEmpresaVenda;

end;

function TdmSQL.IsAmbienteProducao: Boolean;
begin
  Result := (FAmbiente = taProducao); 
end;

end.
