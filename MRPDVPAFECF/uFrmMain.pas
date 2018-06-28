unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mrPafEcf, StdCtrls, DB, ADODB, Provider, DBClient, xmldom,
  XMLIntf, msxmldom, XMLDoc, dxCntner, dxEditor, dxExEdtr, dxEdLib;

type
  TFrmMain = class(TForm)
    btnGerarEstoque: TButton;
    mrPafEcf: TmrPafEcf;
    ADOConnection: TADOConnection;
    cdsEstoque: TClientDataSet;
    qryEstoque: TADOQuery;
    dspEstoque: TDataSetProvider;
    cdsEstoqueModel: TStringField;
    cdsEstoqueDescription: TStringField;
    cdsEstoqueUnidade: TStringField;
    cdsEstoqueQuantidade: TBCDField;
    cdsEstoqueDataEstoque: TDateTimeField;
    btnGerarMercServ: TButton;
    cdsMercadoriaServico: TClientDataSet;
    qryMercadoriaServico: TADOQuery;
    dspMercadoriaServico: TDataSetProvider;
    cdsMercadoriaServicoModel: TStringField;
    cdsMercadoriaServicoDescription: TStringField;
    cdsMercadoriaServicoUnidade: TStringField;
    cdsMercadoriaServicoIAT: TStringField;
    cdsMercadoriaServicoIPPT: TStringField;
    cdsMercadoriaServicoSituacaoTributaria: TStringField;
    cdsMercadoriaServicoAliquota: TBCDField;
    cdsMercadoriaServicoValorUnitario: TBCDField;
    btnGerarOperacao: TButton;
    deInicial: TdxDateEdit;
    deFinal: TdxDateEdit;
    cdsReducaoZ: TClientDataSet;
    qryReducaoZ: TADOQuery;
    dspReducaoZ: TDataSetProvider;
    cdsReducaoZMFAdicional: TStringField;
    cdsReducaoZTipoECF: TStringField;
    cdsReducaoZMarcaECF: TStringField;
    cdsReducaoZModeloECF: TStringField;
    cdsReducaoZVersaoSBECF: TStringField;
    cdsReducaoZDataInstalacaoSBECF: TDateTimeField;
    cdsReducaoZNumeroECF: TIntegerField;
    cdsReducaoZContadorReducaoZ: TIntegerField;
    cdsReducaoZContadorOrdemOperacao: TIntegerField;
    cdsReducaoZContadorReinicioOperacao: TIntegerField;
    cdsReducaoZNumeroUsuarioECF: TIntegerField;
    cdsReducaoZVendaBruta: TBCDField;
    cdsReducaoZIncideISSQN: TBooleanField;
    cdsReducaoZDataInicial: TDateTimeField;
    cdsReducaoZDataFinal: TDateTimeField;
    cdsReducaoZMovDate: TDateTimeField;
    cdsReducaoZNumeroFabricacao: TStringField;
    cdsReducaoZDataEmissao: TDateTimeField;
    cdsTotalizadorParcial: TClientDataSet;
    qryTotalizadorParcial: TADOQuery;
    dspTotalizadorParcial: TDataSetProvider;
    cdsTotalizadorParcialNumeroFabricacao: TStringField;
    cdsTotalizadorParcialMFAdicional: TStringField;
    cdsTotalizadorParcialModeloECF: TStringField;
    cdsTotalizadorParcialContadorReducaoZ: TIntegerField;
    cdsTotalizadorParcialNumeroUsuarioECF: TIntegerField;
    cdsTotalizadorParcialCodigo: TStringField;
    cdsTotalizadorParcialValorAcumulado: TBCDField;
    cdsVenda: TClientDataSet;
    qryVenda: TADOQuery;
    dspVenda: TDataSetProvider;
    cdsItemVenda: TClientDataSet;
    qryItemVenda: TADOQuery;
    dspItemVenda: TDataSetProvider;
    cdsVendaNumeroFabricacao: TStringField;
    cdsVendaMFAdicional: TStringField;
    cdsVendaModeloECF: TStringField;
    cdsVendaNumeroUsuarioECF: TIntegerField;
    cdsVendaContadorDocumento: TIntegerField;
    cdsVendaContadorOrdemOperacao: TIntegerField;
    cdsVendaDataInicioEmissao: TDateTimeField;
    cdsVendaValorSubTotal: TBCDField;
    cdsVendaValorDesconto: TBCDField;
    cdsVendaIndicadorDesconto: TStringField;
    cdsVendaValorAcrescimo: TBCDField;
    cdsVendaIndicadorAcrescimo: TStringField;
    cdsVendaValorTotalLiquido: TBCDField;
    cdsVendaIndicadorCancelamento: TStringField;
    cdsVendaCancelamentoAcrescimo: TBCDField;
    cdsVendaOrdemAplicacaoDA: TStringField;
    cdsVendaNomeCliente: TStringField;
    cdsVendaDocumentoCliente: TStringField;
    cdsItemVendaNumeroFabricacao: TStringField;
    cdsItemVendaMFAdicional: TStringField;
    cdsItemVendaModeloECF: TStringField;
    cdsItemVendaNumeroUsuarioECF: TIntegerField;
    cdsItemVendaContadorOrdemOperacao: TIntegerField;
    cdsItemVendaContadorDocumento: TIntegerField;
    cdsItemVendaNumeroItem: TIntegerField;
    cdsItemVendaCodigoProduto: TStringField;
    cdsItemVendaDescricaoProduto: TStringField;
    cdsItemVendaQuantidade: TBCDField;
    cdsItemVendaUnidade: TStringField;
    cdsItemVendaValorUnitario: TBCDField;
    cdsItemVendaDesconto: TBCDField;
    cdsItemVendaAcrescimo: TBCDField;
    cdsItemVendaValorTotalLiquido: TBCDField;
    cdsItemVendaTotalizadorParcial: TStringField;
    cdsItemVendaIndicadorCancelamento: TStringField;
    cdsItemVendaQuantidadeCancelada: TBCDField;
    cdsItemVendaValorCancelado: TBCDField;
    cdsItemVendaCancelamentoAcrescimo: TBCDField;
    cdsItemVendaIAT: TStringField;
    cdsItemVendaIPPT: TStringField;
    cdsItemVendaNumCasaDecQtd: TIntegerField;
    cdsItemVendaNumCasaDecVal: TIntegerField;
    cdsDocumentoGeral: TClientDataSet;
    qryDocumentoGeral: TADOQuery;
    dspDocumentoGeral: TDataSetProvider;
    cdsPagamento: TClientDataSet;
    qryPagamento: TADOQuery;
    dspPagamento: TDataSetProvider;
    cdsDocumentoGeralNumeroFabricacao: TStringField;
    cdsDocumentoGeralMFAdicional: TStringField;
    cdsDocumentoGeralModeloECF: TStringField;
    cdsDocumentoGeralNumeroUsuarioECF: TIntegerField;
    cdsDocumentoGeralCOO: TIntegerField;
    cdsDocumentoGeralGNF: TIntegerField;
    cdsDocumentoGeralCDC: TIntegerField;
    cdsDocumentoGeralDenominacao: TStringField;
    cdsDocumentoGeralDataEmissao: TDateTimeField;
    cdsPagamentoNumeroFabricacao: TStringField;
    cdsPagamentoMFAdicional: TStringField;
    cdsPagamentoModeloECF: TStringField;
    cdsPagamentoNumeroUsuarioECF: TIntegerField;
    cdsPagamentoCOO: TIntegerField;
    cdsPagamentoCCF: TStringField;
    cdsPagamentoGNF: TIntegerField;
    cdsPagamentoMeioPagamento: TStringField;
    cdsPagamentoValorPago: TBCDField;
    cdsPagamentoIndicadorEstorno: TStringField;
    cdsPagamentoValorEstorno: TBCDField;
    cdsDocumentoGeralGRG: TIntegerField;
    procedure btnGerarEstoqueClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGerarMercServClick(Sender: TObject);
    procedure btnGerarOperacaoClick(Sender: TObject);
    function GetConnectionStr:String;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses Registry, uParamFunctions, uEncryptFunctions;

{$R *.dfm}

procedure TFrmMain.btnGerarEstoqueClick(Sender: TObject);
begin

  Screen.Cursor := crHourGlass;

  try
    with cdsEstoque do
    begin
      Close;
      FetchParams;
      Params.ParamByName('IDStore').Value := 9;
      Open;
      SaveToFile(mrPafEcf.CaminhoArquivos + ARQUIVO_ESTOQUE_XML, dfXMLUTF8);
      Close;
    end;

    mrPafEcf.GerarArquivoEstoque;
    DeleteFile(mrPafEcf.CaminhoArquivos + ARQUIVO_ESTOQUE_XML);

    ShowMessage('Arquivo gerado com sucesso!');
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  mrPafEcf.Init;
  mrPafEcf.CaminhoArquivos := Application.GetNamePath;
  mrPafEcf.PAFECFUsuario.RazaoSocial := 'SUPPLY, MUNDO DO PRAZER COM. DE ALIM. E PROD. LTDA';
  mrPafEcf.PAFECFUsuario.CNPJ := '07855733000157';
  mrPafEcf.PAFECFUsuario.InscricaoEstadual := '104059311';
  mrPafEcf.PAFECFUsuario.InscricaoMunicipal := '2308827';

  deInicial.Date := StrToDate('6/1/09');
  deFinal.Date := StrToDate('8/30/09');

  ADOConnection.ConnectionString := GetConnectionStr;
end;

procedure TFrmMain.btnGerarMercServClick(Sender: TObject);
begin

  Screen.Cursor := crHourGlass;

  try
    with cdsMercadoriaServico do
    begin
      Close;
      FetchParams;
      Params.ParamByName('IDStore').Value := 9;
      Open;
      SaveToFile(mrPafEcf.CaminhoArquivos + ARQUIVO_MERCADORIA_SERVICO_XML, dfXMLUTF8);
      Close;
    end;

    mrPafEcf.GerarArquivoMercadoriaServico;
    DeleteFile(mrPafEcf.CaminhoArquivos + ARQUIVO_MERCADORIA_SERVICO_XML);

    ShowMessage('Arquivo gerado com sucesso!');
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmMain.btnGerarOperacaoClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;

  try
    with cdsReducaoZ do
    begin
      Close;
      FetchParams;
      Params.ParamByName('DataInicial').Value := deInicial.Date;
      Params.ParamByName('DataFinal').Value := deFinal.Date;
      Open;
      First;
      Edit;
      FieldByName('DataInicial').Value := deInicial.Date;
      FieldByName('DataFinal').Value := deFinal.Date;
      Post;
      SaveToFile(mrPafEcf.CaminhoArquivos + ARQUIVO_REDUCAOZ_XML, dfXMLUTF8);
      Close;
    end;

    with cdsTotalizadorParcial do
    begin
      Close;
      FetchParams;
      Params.ParamByName('DataInicial').Value := deInicial.Date;
      Params.ParamByName('DataFinal').Value := deFinal.Date;
      Open;
      First;
      SaveToFile(mrPafEcf.CaminhoArquivos + ARQUIVO_TOTALIZADOR_PARCIAL_XML, dfXMLUTF8);
      Close;
    end;

    with cdsVenda do
    begin
      Close;
      FetchParams;
      Params.ParamByName('IDCashRegister1').Value := 2;
      Params.ParamByName('DataInicial1').Value := deInicial.Date;
      Params.ParamByName('DataFinal1').Value := deFinal.Date;
      Params.ParamByName('IDCashRegister2').Value := 2;
      Params.ParamByName('DataInicial2').Value := deInicial.Date;
      Params.ParamByName('DataFinal2').Value := deFinal.Date;
      Open;
      First;
      SaveToFile(mrPafEcf.CaminhoArquivos + ARQUIVO_VENDA_XML, dfXMLUTF8);
      Close;
    end;

    with cdsItemVenda do
    begin
      Close;
      FetchParams;
      Params.ParamByName('IDCashRegister1').Value := 2;
      Params.ParamByName('DataInicial1').Value := deInicial.Date;
      Params.ParamByName('DataFinal1').Value := deFinal.Date;
      Params.ParamByName('IDCashRegister2').Value := 2;
      Params.ParamByName('DataInicial2').Value := deInicial.Date;
      Params.ParamByName('DataFinal2').Value := deFinal.Date;
      Params.ParamByName('IDCashRegister3').Value := 2;
      Params.ParamByName('DataInicial3').Value := deInicial.Date;
      Params.ParamByName('DataFinal3').Value := deFinal.Date;
      Open;
      First;
      SaveToFile(mrPafEcf.CaminhoArquivos + ARQUIVO_ITEM_VENDA_XML, dfXMLUTF8);
      Close;
    end;

    with cdsDocumentoGeral do
    begin
      Close;
      FetchParams;
      Params.ParamByName('IDCashRegister1').Value := 2;
      Params.ParamByName('DataInicial1').Value := deInicial.Date;
      Params.ParamByName('DataFinal1').Value := deFinal.Date;
      Params.ParamByName('IDCashRegister2').Value := 2;
      Params.ParamByName('DataInicial2').Value := deInicial.Date;
      Params.ParamByName('DataFinal2').Value := deFinal.Date;
      Open;
      First;
      SaveToFile(mrPafEcf.CaminhoArquivos + ARQUIVO_DOCUMENTO_GERAL_XML, dfXMLUTF8);
      Close;
    end;

    with cdsPagamento do
    begin
      Close;
      FetchParams;
      Params.ParamByName('IDCashRegister').Value := 2;
      Params.ParamByName('DataInicial').Value := deInicial.Date;
      Params.ParamByName('DataFinal').Value := deFinal.Date;
      Open;
      First;
      SaveToFile(mrPafEcf.CaminhoArquivos + ARQUIVO_PAGAMENTO_XML, dfXMLUTF8);
      Close;
    end;

    mrPafEcf.GerarArquivoOperacao(deInicial.Date, deFinal.Date);
    DeleteFile(mrPafEcf.CaminhoArquivos + ARQUIVO_REDUCAOZ_XML);
    DeleteFile(mrPafEcf.CaminhoArquivos + ARQUIVO_TOTALIZADOR_PARCIAL_XML);
    DeleteFile(mrPafEcf.CaminhoArquivos + ARQUIVO_VENDA_XML);
    DeleteFile(mrPafEcf.CaminhoArquivos + ARQUIVO_ITEM_VENDA_XML);
    DeleteFile(mrPafEcf.CaminhoArquivos + ARQUIVO_DOCUMENTO_GERAL_XML);
    DeleteFile(mrPafEcf.CaminhoArquivos + ARQUIVO_PAGAMENTO_XML);

    ShowMessage('Arquivo gerado com sucesso!');
  finally
    Screen.Cursor := crDefault  ;
  end;
end;

function TFrmMain.GetConnectionStr: String;
var
  sPW, sUser, sDBAlias, sServer, sResult : String;
  Reg : TRegistry;
begin

  try
    //Pega as info local
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    Reg.OpenKey('SOFTWARE\AppleNet', True);

    sResult := DecodeServerInfo(Reg.ReadString('ServerInfo'), 'Server', CIPHER_TEXT_STEALING, FMT_UU);

    sServer  := ParseParam(sResult, '#SRV#=');
    sDBAlias := ParseParam(sResult, '#DB#=');
    sUser    := ParseParam(sResult, '#USER#=');
    sPW      := ParseParam(sResult, '#PW#=');

    Result := SetConnectionStrNoNETLIB(sUser, sPw, SDBAlias, sServer);

    //Fechar o Registry
    Reg.CloseKey;
    Reg.Free;
  except
    ShowMessage('Erro ao conectar no bando de dados!');
    Abort;
  end;

end;

end.
