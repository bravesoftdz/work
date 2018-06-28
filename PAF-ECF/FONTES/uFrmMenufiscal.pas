unit uFrmMenufiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, dxCntner, dxEditor,
  dxExEdtr, dxEdLib, DB, Provider, ADODB, DBClient, mrPafEcf;

type
  TFrmMenufiscal = class(TForm)
    pnlButtom: TPanel;
    lblUserName: TLabel;
    Label15: TLabel;
    hhh: TPanel;
    spHelp: TSpeedButton;
    btClose: TButton;
    pgFiscal: TPageControl;
    tsMenuFiscal: TTabSheet;
    tsPAF: TTabSheet;
    btnLeituraX: TBitBtn;
    btnLeituraXSerial: TBitBtn;
    btnReducaoZ: TBitBtn;
    GroupBox1: TGroupBox;
    btnMFPorData: TBitBtn;
    btnMFPorDataMDF: TBitBtn;
    btnMFPorSerialMDF: TBitBtn;
    btnMFPorReducao: TBitBtn;
    btnMFPorReducaoMDF: TBitBtn;
    btnMFSerialPorReducaoMDF: TBitBtn;
    mrPafEcf: TmrPafEcf;
    cdsEstoque: TClientDataSet;
    cdsEstoqueModel: TStringField;
    cdsEstoqueDescription: TStringField;
    cdsEstoqueUnidade: TStringField;
    cdsEstoqueQuantidade: TBCDField;
    cdsEstoqueDataEstoque: TDateTimeField;
    qryEstoque: TADOQuery;
    dspEstoque: TDataSetProvider;
    cdsMercadoriaServico: TClientDataSet;
    cdsMercadoriaServicoModel: TStringField;
    cdsMercadoriaServicoDescription: TStringField;
    cdsMercadoriaServicoUnidade: TStringField;
    cdsMercadoriaServicoIAT: TStringField;
    cdsMercadoriaServicoIPPT: TStringField;
    cdsMercadoriaServicoSituacaoTributaria: TStringField;
    cdsMercadoriaServicoAliquota: TBCDField;
    cdsMercadoriaServicoValorUnitario: TBCDField;
    qryMercadoriaServico: TADOQuery;
    dspMercadoriaServico: TDataSetProvider;
    cdsReducaoZ: TClientDataSet;
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
    qryReducaoZ: TADOQuery;
    dspReducaoZ: TDataSetProvider;
    cdsTotalizadorParcial: TClientDataSet;
    cdsTotalizadorParcialNumeroFabricacao: TStringField;
    cdsTotalizadorParcialMFAdicional: TStringField;
    cdsTotalizadorParcialModeloECF: TStringField;
    cdsTotalizadorParcialContadorReducaoZ: TIntegerField;
    cdsTotalizadorParcialNumeroUsuarioECF: TIntegerField;
    cdsTotalizadorParcialCodigo: TStringField;
    cdsTotalizadorParcialValorAcumulado: TBCDField;
    qryTotalizadorParcial: TADOQuery;
    dspTotalizadorParcial: TDataSetProvider;
    cdsVenda: TClientDataSet;
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
    qryVenda: TADOQuery;
    dspVenda: TDataSetProvider;
    cdsItemVenda: TClientDataSet;
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
    qryItemVenda: TADOQuery;
    dspItemVenda: TDataSetProvider;
    cdsDocumentoGeral: TClientDataSet;
    cdsDocumentoGeralNumeroFabricacao: TStringField;
    cdsDocumentoGeralMFAdicional: TStringField;
    cdsDocumentoGeralModeloECF: TStringField;
    cdsDocumentoGeralNumeroUsuarioECF: TIntegerField;
    cdsDocumentoGeralCOO: TIntegerField;
    cdsDocumentoGeralGNF: TIntegerField;
    cdsDocumentoGeralGRG: TIntegerField;
    cdsDocumentoGeralCDC: TIntegerField;
    cdsDocumentoGeralDenominacao: TStringField;
    cdsDocumentoGeralDataEmissao: TDateTimeField;
    qryDocumentoGeral: TADOQuery;
    dspDocumentoGeral: TDataSetProvider;
    cdsPagamento: TClientDataSet;
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
    qryPagamento: TADOQuery;
    dspPagamento: TDataSetProvider;
    btnGerarMercServ: TButton;
    btnGerarEstoque: TButton;
    GroupBox2: TGroupBox;
    deFinal: TdxDateEdit;
    deInicial: TdxDateEdit;
    btnGerarOperacao: TButton;
    Label1: TLabel;
    Label2: TLabel;
    btnEspelhoData: TBitBtn;
    btnArqMdf: TBitBtn;
    btnEspelhoCOO: TBitBtn;
    btnInformacao: TButton;
    cdsMeioPagamento: TClientDataSet;
    dspMeioPagamento: TDataSetProvider;
    qryMeioPagamento: TADOQuery;
    btnMeioDePagto: TButton;
    cdsMeioPagamentoMeioPag: TStringField;
    cdsMeioPagamentoValorPagamento: TBCDField;
    cdsMeioPagamentoDataPagamento: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure btnLeituraXClick(Sender: TObject);
    procedure btnLeituraXSerialClick(Sender: TObject);
    procedure btnReducaoZClick(Sender: TObject);
    procedure btnMFPorDataClick(Sender: TObject);
    procedure btnMFPorDataMDFClick(Sender: TObject);
    procedure btnMFPorSerialMDFClick(Sender: TObject);
    procedure btnMFPorReducaoClick(Sender: TObject);
    procedure btnMFPorReducaoMDFClick(Sender: TObject);
    procedure btnMFSerialPorReducaoMDFClick(Sender: TObject);
    procedure btnGerarMercServClick(Sender: TObject);
    procedure btnGerarEstoqueClick(Sender: TObject);
    procedure btnGerarOperacaoClick(Sender: TObject);
    procedure btnMeioDePagtoClick(Sender: TObject);
    procedure btnEspelhoDataClick(Sender: TObject);
    procedure btnArqMdfClick(Sender: TObject);
    procedure btnEspelhoCOOClick(Sender: TObject);
    procedure btnInformacaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    function Start : Boolean;
  end;

implementation

uses uDM, uFrmMemoriaFiscal, uDateTimeFunctions, uSystemConst;

{$R *.dfm}

procedure TFrmMenufiscal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TFrmMenufiscal.btCloseClick(Sender: TObject);
begin
  Close;
end;

function TFrmMenufiscal.Start: Boolean;
begin

  mrPafEcf.Init;
  mrPafEcf.CaminhoArquivos := Application.GetNamePath;
  mrPafEcf.PAFECFUsuario.RazaoSocial        := 'SOFTVAR SOLUCOES EM INFORMATICA LTDA';
  mrPafEcf.PAFECFUsuario.CNPJ               := '06246012000187';
  mrPafEcf.PAFECFUsuario.InscricaoEstadual  := 'ISENTO';
  mrPafEcf.PAFECFUsuario.InscricaoMunicipal := '3828071';

  deInicial.Date := InicioDoMes(Now);
  deFinal.Date   := FimMes(Now);

  ShowModal;
  Result := True;
end;

procedure TFrmMenufiscal.btnLeituraXClick(Sender: TObject);
var opcao: char;
begin
  inherited;

  if MessageDlg('Abre vinculado [N]?', mtConfirmation,[mbYes, mbNo], 0) = mrYes then
     opcao:='S'
  else
     opcao:='N';

  if MessageDlg('Continua Emissão da Leitura X ?', mtConfirmation,[mbYes, mbNo], 0) = mrYes then
    DM.EFiscal1.EmiteLeituraX(opcao);

end;

procedure TFrmMenufiscal.btnLeituraXSerialClick(Sender: TObject);
var
  opcao: char;
begin

  {colocar condicao se abre vinculado S sim ou N nao}
  if MessageDlg('Abre vinculado [N]?', mtConfirmation,[mbYes, mbNo], 0) = mrYes then
     opcao:='S'
  else
     opcao:='N';

  if MessageDlg('Continua Emissão da Leitura X pela Serial ?', mtConfirmation,[mbYes, mbNo], 0) = mrYes then
    DM.EFiscal1.EmiteLeituraXSerial(opcao);

end;

procedure TFrmMenufiscal.btnReducaoZClick(Sender: TObject);
var
  sData: String;
begin

  if MessageDlg('A Redução Z impossibilitará novas impressões'+#13+'de Cupons Fiscais!'
                 +#13+#13+'Deseja Emitir a Redução Z e fechar o dia ?', mtConfirmation,[mbYes, mbNo], 0) = mrYes then
  begin
    sData := DateToStr(Date - 1);
    if InputQuery('Data para Redução', 'Dia a Fechar', sData) then
      DM.EFiscal1.ReducaoZ(StrToDate(sData), TimeToStr(time));
  end;

end;

procedure TFrmMenufiscal.btnMFPorDataClick(Sender: TObject);
var
  sD1, sD2, sOpt : String;
begin
  inherited;

  with TFrmMemoriaFiscal.Create(Self) do
    if StartDate(sD1, sD2, sOpt, False) then
    begin
      if sOpt = 'c' then
        DM.EFiscal1.MFD_LeituraMemoriaFiscal('1')
      else
        DM.EFiscal1.MFD_LeituraMemoriaFiscal('0');

      DM.EFiscal1.LeituraMemoriaFiscalData(sD1, sD2);
    end;

end;

procedure TFrmMenufiscal.btnMFPorDataMDFClick(Sender: TObject);
var
  sD1, sD2, sOpt : String;
begin
  inherited;

  with TFrmMemoriaFiscal.Create(Self) do
    if StartDate(sD1, sD2, sOpt, True) then
    begin
      if sOpt = 'c' then
        DM.EFiscal1.MFD_LeituraMemoriaFiscal('1')
      else
        DM.EFiscal1.MFD_LeituraMemoriaFiscal('0');

      DM.EFiscal1.LeituraMemoriaFiscalDataMFD(sD1, sD2, sOpt);
    end;

end;

procedure TFrmMenufiscal.btnMFPorSerialMDFClick(Sender: TObject);
var
  sD1, sD2, sOpt : String;
begin
  inherited;

  with TFrmMemoriaFiscal.Create(Self) do
    if StartDate(sD1, sD2, sOpt, True) then
    begin
      if sOpt = 'c' then
        DM.EFiscal1.MFD_LeituraMemoriaFiscal('1')
      else
        DM.EFiscal1.MFD_LeituraMemoriaFiscal('0');

      DM.EFiscal1.LeituraMemoriaFiscalSerialDataMFD(sD1, sD2, sOpt);
      mrPafEcf.GerarRegistroEAD('C:\RETORNO.TXT');
    end;
end;

procedure TFrmMenufiscal.btnMFPorReducaoClick(Sender: TObject);
var
  sR1, sR2, sOpt : String;
begin
  inherited;

  with TFrmMemoriaFiscal.Create(Self) do
    if StartReducao(sR1, sR2, sOpt, False) then
    begin
      if sOpt = 'c' then
        DM.EFiscal1.MFD_LeituraMemoriaFiscal('1')
      else
        DM.EFiscal1.MFD_LeituraMemoriaFiscal('0');

      DM.EFiscal1.LeituraMemoriaFiscalReducao(sR1, sR2);
    end;

end;

procedure TFrmMenufiscal.btnMFPorReducaoMDFClick(Sender: TObject);
var
  sR1, sR2, sOpt : String;
begin
  inherited;

  with TFrmMemoriaFiscal.Create(Self) do
    if StartReducao(sR1, sR2, sOpt, True) then
    begin
      if sOpt = 'c' then
        DM.EFiscal1.MFD_LeituraMemoriaFiscal('1')
      else
        DM.EFiscal1.MFD_LeituraMemoriaFiscal('0');

      DM.EFiscal1.LeituraMemoriaFiscalReducaoMFD(sR1, sR2, sOpt);
    end;

end;

procedure TFrmMenufiscal.btnMFSerialPorReducaoMDFClick(Sender: TObject);
var
  sR1, sR2, sOpt : String;
begin
  inherited;

  with TFrmMemoriaFiscal.Create(Self) do
    if StartReducao(sR1, sR2, sOpt, True) then
    begin
      if sOpt = 'c' then
        DM.EFiscal1.MFD_LeituraMemoriaFiscal('1')
      else
        DM.EFiscal1.MFD_LeituraMemoriaFiscal('0');

      DM.EFiscal1.LeituraMemoriaFiscalSerialReducaoMFD(sR1, sR2, sOpt);
      mrPafEcf.GerarRegistroEAD('C:\RETORNO.TXT');
    end;
end;

procedure TFrmMenufiscal.btnGerarMercServClick(Sender: TObject);
begin

  Screen.Cursor := crHourGlass;

  try
    with cdsMercadoriaServico do
    begin
      Close;
      FetchParams;
      Params.ParamByName('IDStore').Value := DM.fStore.ID;
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

procedure TFrmMenufiscal.btnGerarEstoqueClick(Sender: TObject);
begin

  Screen.Cursor := crHourGlass;

  try
    with cdsEstoque do
    begin
      Close;
      FetchParams;
      Params.ParamByName('IDStore').Value := DM.fStore.ID;
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

procedure TFrmMenufiscal.btnGerarOperacaoClick(Sender: TObject);
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
      Params.ParamByName('IDCashRegister1').Value := DM.fCashRegister.IDDefault;
      Params.ParamByName('DataInicial1').Value := deInicial.Date;
      Params.ParamByName('DataFinal1').Value := deFinal.Date;
      Params.ParamByName('IDCashRegister2').Value := DM.fCashRegister.IDDefault;
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
      Params.ParamByName('IDCashRegister1').Value := DM.fCashRegister.IDDefault;
      Params.ParamByName('DataInicial1').Value := deInicial.Date;
      Params.ParamByName('DataFinal1').Value := deFinal.Date;
      Params.ParamByName('IDCashRegister2').Value := DM.fCashRegister.IDDefault;
      Params.ParamByName('DataInicial2').Value := deInicial.Date;
      Params.ParamByName('DataFinal2').Value := deFinal.Date;
      Params.ParamByName('IDCashRegister3').Value := DM.fCashRegister.IDDefault;
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
      Params.ParamByName('IDCashRegister1').Value := DM.fCashRegister.IDDefault;
      Params.ParamByName('DataInicial1').Value := deInicial.Date;
      Params.ParamByName('DataFinal1').Value := deFinal.Date;
      Params.ParamByName('IDCashRegister2').Value := DM.fCashRegister.IDDefault;
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
      Params.ParamByName('IDCashRegister').Value := DM.fCashRegister.IDDefault;
      Params.ParamByName('DataInicial').Value := deInicial.Date;
      Params.ParamByName('DataFinal').Value := deFinal.Date;
      Open;
      First;
      SaveToFile(mrPafEcf.CaminhoArquivos + ARQUIVO_PAGAMENTO_XML, dfXMLUTF8);
      Close;
    end;

    try
      mrPafEcf.GerarArquivoOperacao(deInicial.Date, deFinal.Date);
      ShowMessage('Arquivo gerado com sucesso!');
    except
      ShowMessage('Erro ao gerar arquivo!');
    end;
  finally
    DeleteFile(mrPafEcf.CaminhoArquivos + ARQUIVO_REDUCAOZ_XML);
    DeleteFile(mrPafEcf.CaminhoArquivos + ARQUIVO_TOTALIZADOR_PARCIAL_XML);
    DeleteFile(mrPafEcf.CaminhoArquivos + ARQUIVO_VENDA_XML);
    DeleteFile(mrPafEcf.CaminhoArquivos + ARQUIVO_ITEM_VENDA_XML);
    DeleteFile(mrPafEcf.CaminhoArquivos + ARQUIVO_DOCUMENTO_GERAL_XML);
    DeleteFile(mrPafEcf.CaminhoArquivos + ARQUIVO_PAGAMENTO_XML);

    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmMenufiscal.btnMeioDePagtoClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;

  try
    with cdsMeioPagamento do
    begin
      Close;
      FetchParams;
      Params.ParamByName('IDCashRegister').Value := DM.fCashRegister.IDDefault;
      Params.ParamByName('DataInicial').Value := deInicial.Date;
      Params.ParamByName('DataFinal').Value := deFinal.Date;
      Open;
      First;

      DM.EFiscal1.AbreRelatorioGerencial('');
      DM.EFiscal1.RelatorioGerencial('MEIOS DE PAGAMENTO');

      while not Eof do
      begin
        DM.EFiscal1.RelatorioGerencial(FieldByName('DataPagamento').AsString + '   ' + FieldByName('MeioPag').AsString + ': ' + FormatCurr('#,##0.00', FieldByName('ValorPagamento').AsCurrency));
        Next;
      end;

      DM.EFiscal1.FechaRelatorioGerencial;

      SaveToFile(mrPafEcf.CaminhoArquivos + ARQUIVO_MEIO_PAGAMENTO_XML, dfXMLUTF8);
      Close;
    end;

    try
      mrPafEcf.GerarArquivoMeioPagamento;
      ShowMessage('Arquivo gerado com sucesso!');
    except
      ShowMessage('Erro ao gerar arquivo!');
    end;
  finally
    DeleteFile(mrPafEcf.CaminhoArquivos + ARQUIVO_MEIO_PAGAMENTO_XML);
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmMenufiscal.btnEspelhoDataClick(Sender: TObject);
var
  sD1, sD2, sOpt : String;
begin
  with TFrmMemoriaFiscal.Create(Self) do
    if StartDate(sD1, sD2, sOpt, False) then
    try
      Screen.Cursor := crHourGlass;
      sD1 := FormatDateTime('dd/mm/yy', StrToDate(sD1));
      sD2 := FormatDateTime('dd/mm/yy', StrToDate(sD2));
      if DM.EFiscal1.FIMFD_DownloadDaMFD(sD1, sD2, '1') then
      begin
        ShowMessage('Arquivo gerado com sucesso!');
        mrPafEcf.GerarRegistroEAD('C:\RETORNO.TXT');
      end;
    finally
      Screen.Cursor := crDefault;
    end;
end;

procedure TFrmMenufiscal.btnArqMdfClick(Sender: TObject);
begin
  ShowMessage('Função não suportada pelo modelo de ECF utilizado');
end;

procedure TFrmMenufiscal.btnEspelhoCOOClick(Sender: TObject);
var
  sR1, sR2, sOpt : String;
begin
  with TFrmMemoriaFiscal.Create(Self) do
    if StartCOO(sR1, sR2, sOpt, False) then
    try
      Screen.Cursor := crHourGlass;
      if DM.EFiscal1.FIMFD_DownloadDaMFD(sR1, sR2, '2') then
      begin
        ShowMessage('Arquivo gerado com sucesso!');
        mrPafEcf.GerarRegistroEAD('C:\RETORNO.TXT');
      end;
    finally
      Screen.Cursor := crDefault;
    end;
end;

procedure TFrmMenufiscal.btnInformacaoClick(Sender: TObject);
begin

  DM.EFiscal1.AbreRelatorioGerencial('');
  DM.EFiscal1.RelatorioGerencial('Identificação do PAF-ECF');
  DM.EFiscal1.RelatorioGerencial('Número do Laudo: FVC0042009');
  DM.EFiscal1.RelatorioGerencial('Razão Social: SOFTVAR Solucoes em Informatica');
  DM.EFiscal1.RelatorioGerencial('CNPJ: 06.246.012/0001-87');
  DM.EFiscal1.RelatorioGerencial('Endereço: Av. N. S. de Copacabana 647/1010');
  DM.EFiscal1.RelatorioGerencial('Copacabana, Rio de Janeiro - RJ');
  DM.EFiscal1.RelatorioGerencial('CEP:22050-002');
  DM.EFiscal1.RelatorioGerencial('Telefone:(21) 2548-4452');
  DM.EFiscal1.RelatorioGerencial('Contato:Rodrigo Costa / Maximiliano Muniz');
  DM.EFiscal1.RelatorioGerencial('Nome Comercial: MainRetail - Cash Register');
  DM.EFiscal1.RelatorioGerencial('Versão: 1.6');
  DM.EFiscal1.RelatorioGerencial('Nome Executável: CashRegister.exe');
  DM.EFiscal1.RelatorioGerencial('Código do MD-5:' + DM.FMD5);
  DM.EFiscal1.RelatorioGerencial('Outros Arquivos:');
  DM.EFiscal1.FechaRelatorioGerencial;

end;

procedure TFrmMenufiscal.FormShow(Sender: TObject);
begin
  mrPafEcf.CodigoMD5 := DM.FMD5;
end;

end.
