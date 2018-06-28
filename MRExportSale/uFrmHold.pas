unit uFrmHold;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  DB, cxDBData, SuperComboADO, StdCtrls, Mask, DateBox, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, DBCtrls, Buttons, ExtCtrls, ADODB,
  cxContainer, cxTextEdit, uFrmSearchHold, cxMaskEdit, cxDropDownEdit,
  cxCalc, cxSpinEdit, Provider, DBClient, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox;

type
  TFrmHold = class(TForm)
    pnlClient: TPanel;
    pnlBottom: TPanel;
    grdItems: TcxGrid;
    grdItemsDB: TcxGridDBTableView;
    grdItemsLevel: TcxGridLevel;
    pnlTop: TPanel;
    lbDate: TLabel;
    lbHoldNum: TLabel;
    lblPedido: TDBText;
    pnlButton: TPanel;
    btnProcurar: TSpeedButton;
    btnImprimir: TSpeedButton;
    Panel1: TPanel;
    lblDataPedido: TDBText;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblCliente: TDBText;
    lblEndereco: TDBText;
    lblBairro: TDBText;
    lblCEP: TDBText;
    lblTel: TDBText;
    lblMunicipio: TDBText;
    lblUF: TDBText;
    lblInscEstadual: TDBText;
    qryPedido: TADODataSet;
    qryPedidoIDPreSale: TIntegerField;
    qryPedidoPreSaleDate: TDateTimeField;
    qryPedidoSaleCode: TStringField;
    qryPedidoCliente: TStringField;
    qryPedidoEndereco: TStringField;
    qryPedidoBairro: TStringField;
    qryPedidoCidade: TStringField;
    qryPedidoCEP: TStringField;
    qryPedidoUF: TStringField;
    qryPedidoInscEstadual: TStringField;
    qryPedidoTelefone: TStringField;
    qryPedidoDocumento: TStringField;
    qryPedidoItem: TADODataSet;
    qryPedidoItemIDPreInventoryMov: TIntegerField;
    qryPedidoItemPrecoVenda: TBCDField;
    qryPedidoItemQtd: TFloatField;
    qryPedidoItemVendedor: TStringField;
    qryPedidoItemModelo: TStringField;
    qryPedidoItemDescricao: TStringField;
    dsPedido: TDataSource;
    dsPedidoItem: TDataSource;
    btnExportar: TSpeedButton;
    qryPedidoItemUnidade: TStringField;
    lblTransportador: TLabel;
    Label2: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edtEnderecoTrans: TcxTextEdit;
    edtBairroTrans: TcxTextEdit;
    edtCEPTrans: TcxTextEdit;
    edtCNPJTrans: TcxTextEdit;
    edtMunicipioTrans: TcxTextEdit;
    edtUFTrans: TcxTextEdit;
    edtFreteTrans: TcxTextEdit;
    Label17: TLabel;
    edtInscEstTrans: TcxTextEdit;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    edtEspecieEmb: TcxTextEdit;
    edtMarcaEmb: TcxTextEdit;
    edtNumeroEmb: TcxTextEdit;
    Bevel1: TBevel;
    lbOtherExpenses: TLabel;
    edtOtherCosts: TDBText;
    lbDiscount: TLabel;
    edtDiscount: TDBText;
    lbSubTotal: TLabel;
    edtSubTotal: TDBText;
    lbInvoiceTotal: TLabel;
    DBText1: TDBText;
    Bevel5: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    qryPedidoOutrosCustos: TBCDField;
    qryPedidoSubTotal: TBCDField;
    qryPedidoItemDesconto: TBCDField;
    grdItemsDBIDPreInventoryMov: TcxGridDBColumn;
    grdItemsDBPrecoVenda: TcxGridDBColumn;
    grdItemsDBQtd: TcxGridDBColumn;
    grdItemsDBVendedor: TcxGridDBColumn;
    grdItemsDBModelo: TcxGridDBColumn;
    grdItemsDBDescricao: TcxGridDBColumn;
    grdItemsDBUnidade: TcxGridDBColumn;
    grdItemsDBDesconto: TcxGridDBColumn;
    strepSaleItem: TcxStyleRepository;
    cxStyle: TcxStyle;
    cxStyleContent: TcxStyle;
    cxStyleContentEven: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    cxStyle7: TcxStyle;
    cxStyle8: TcxStyle;
    cxStyleHeader: TcxStyle;
    cxStyle10: TcxStyle;
    cxStyle11: TcxStyle;
    cxStyle12: TcxStyle;
    cxStyle13: TcxStyle;
    cxStyleSelection: TcxStyle;
    cxStyleContent2: TcxStyle;
    cxStyleSelection2: TcxStyle;
    cxStyleHeader2: TcxStyle;
    GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet;
    Bevel6: TBevel;
    btnSair: TSpeedButton;
    qryPedidoItemCodTrib: TStringField;
    edtFreteEmb: TcxCalcEdit;
    edtSeguroEmb: TcxCalcEdit;
    edtOutrosCustosEmb: TcxCalcEdit;
    edtPesoLiqEmb: TcxSpinEdit;
    edtPesoBrutoEmb: TcxSpinEdit;
    edtQtdEmb: TcxSpinEdit;
    cdsPedido: TClientDataSet;
    dspPedido: TDataSetProvider;
    cdsPedidoIDPreSale: TIntegerField;
    cdsPedidoPreSaleDate: TDateTimeField;
    cdsPedidoSaleCode: TStringField;
    cdsPedidoCliente: TStringField;
    cdsPedidoEndereco: TStringField;
    cdsPedidoBairro: TStringField;
    cdsPedidoCidade: TStringField;
    cdsPedidoCEP: TStringField;
    cdsPedidoUF: TStringField;
    cdsPedidoInscEstadual: TStringField;
    cdsPedidoTelefone: TStringField;
    cdsPedidoDocumento: TStringField;
    cdsPedidoOutrosCustos: TBCDField;
    cdsPedidoSubTotal: TBCDField;
    qryPedidoValorDesconto: TBCDField;
    qryPedidoTotal: TBCDField;
    cdsPedidoValorDesconto: TBCDField;
    cdsPedidoTotal: TBCDField;
    cbxTransp: TcxLookupComboBox;
    qryTransp: TADODataSet;
    qryTranspPessoa: TStringField;
    dsTransp: TDataSource;
    qryTranspIDPessoa: TIntegerField;
    qryTranspProp: TADODataSet;
    qryTranspPropEndereco: TStringField;
    qryTranspPropBairro: TStringField;
    qryTranspPropCidade: TStringField;
    qryTranspPropIDEstado: TStringField;
    qryTranspPropCEP: TStringField;
    qryTranspPropCGC: TStringField;
    qryTranspPropInscEstadual: TStringField;
    grdItemsDBTotal: TcxGridDBColumn;
    qryPedidoItemTotal: TBCDField;
    lblDocumento: TDBText;
    procedure btnExportarClick(Sender: TObject);
    procedure btnProcurarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure cdsPedidoAfterScroll(DataSet: TDataSet);
    procedure qryPedidoItemAfterOpen(DataSet: TDataSet);
    procedure cbxTranspPropertiesEditValueChanged(Sender: TObject);
  private
    FfrmSearchHold: TFrmSearchHold;
    FFileName: String;
    FTextFile: TextFile;
    FIDPreSale: Integer;

    procedure OpenHold;
    procedure ExportarArquivo;

    procedure RegistroTipo1;
    procedure RegistroTipo2;
    procedure RegistroTipo3;
    procedure RegistroTipo4;
    procedure RegistroTipo5;
    procedure RegistroTipo6;
    procedure RegistroTipo7;

    procedure CalcInvoiceValues;

    function DadosValidos: Boolean;
  public
    procedure Start;
  end;

implementation

uses uStringFunctions, uFrmMain;

{$R *.dfm}

{ TfrmHold }

procedure TFrmHold.ExportarArquivo;
begin
  try
    AssignFile(FTextFile, FFileName);
    Rewrite(FTextFile);

    RegistroTipo1;
    RegistroTipo2;
    RegistroTipo3;
    RegistroTipo4;
    RegistroTipo5;
    RegistroTipo6;
    RegistroTipo7;
  finally
    CloseFile(FTextFile);
  end;
end;

procedure TFrmHold.OpenHold;
begin
  with cdsPedido do
  begin
    if Active then
      Close;
    FetchParams;
    Params.ParamByName('IDPreSale').Value := FIDPreSale;
    Open;
  end;

  with qryPedidoItem do
  begin
    if Active then
      Close;
    Parameters.ParamByName('IDPreSale').Value := FIDPreSale;
    Open;
  end;
end;

procedure TFrmHold.RegistroTipo1;
var
  sLinha: String;
begin
  // TODO: campos a preencher
  // Dados dos produtos
  with qryPedidoItem do
  begin
    First;
    while not Eof do
    begin
      sLinha := '1';
      sLinha := sLinha + AE(FieldByName('Modelo').AsString, 16);
      sLinha := sLinha + Replace(FormatFloat('0000.00', FieldByName('Qtd').AsFloat), ',', '');
      sLinha := sLinha + Replace(FormatFloat('000000000.00', FieldByName('Total').AsFloat / FieldByName('Qtd').AsFloat), ',', '');
      sLinha := sLinha + FieldByName('CodTrib').AsString; //COD TRIB;
      sLinha := sLinha + AE(FieldByName('Descricao').AsString, 40);
      sLinha := sLinha + '000'; //COD SUB TRIB
      sLinha := sLinha + FieldByName('Unidade').AsString;
      sLinha := sLinha + '0000'; //ALIQ IPI;
      Writeln(FTextFile, sLinha);
      Next;
    end;
    First;
  end;
end;

procedure TFrmHold.RegistroTipo2;
var
  sLinha: String;
begin
  // Dados do cliente
  with cdsPedido do
  begin
    sLinha := '2';
    sLinha := sLinha + AE(FieldByName('Cliente').AsString, 30);
    sLinha := sLinha + AE(FieldByName('Endereco').AsString, 30);
    sLinha := sLinha + AE(FieldByName('Bairro').AsString, 20);
    sLinha := sLinha + AE(FieldByName('Cidade').AsString, 20);
    sLinha := sLinha + AE(FieldByName('Documento').AsString, 20);
    sLinha := sLinha + AE(FieldByName('CEP').AsString, 8);
    sLinha := sLinha + AE(FieldByName('UF').AsString, 2);
    sLinha := sLinha + AE(FieldByName('InscEstadual').AsString, 20);
    sLinha := sLinha + AE(FieldByName('Telefone').AsString, 15);
    Writeln(FTextFile, sLinha);
  end;
end;

procedure TFrmHold.RegistroTipo3;
var
  sLinha: String;
begin
  // Desconto total em percentual
  sLinha := '3';
  sLinha := sLinha + '00000';
  Writeln(FTextFile, sLinha);
end;

procedure TFrmHold.RegistroTipo4;
var
  sLinha: String;
begin
  // Desconto total em valor
  sLinha := '4';
  //sLinha := sLinha + Replace(FormatFloat('000000.00', cdsPedido.FieldByName('ValorDesconto').AsFloat), ',', '');
  sLinha := sLinha + Replace(FormatFloat('000000.00', 0), ',', '');  
  Writeln(FTextFile, sLinha);
end;

procedure TFrmHold.RegistroTipo5;
var
  sLinha: String;
begin
  // Nome do vendedor
  sLinha := '5';
  sLinha := sLinha + AE(qryPedidoItem.FieldByName('Vendedor').AsString, 10);
  Writeln(FTextFile, sLinha);
end;

procedure TFrmHold.RegistroTipo6;
var
  sLinha: String;
begin
  // Dados transportador
  sLinha := '6';
  sLinha := sLinha + AE(cbxTransp.Text, 30);
  sLinha := sLinha + AE(edtEnderecoTrans.Text, 30);
  sLinha := sLinha + AE(edtBairroTrans.Text, 20);
  sLinha := sLinha + AE(edtMunicipioTrans.Text, 20);
  sLinha := sLinha + AE(edtCEPTrans.Text, 8);
  sLinha := sLinha + AE(edtUFTrans.Text, 2);
  sLinha := sLinha + AE(edtCNPJTrans.Text, 20);
  sLinha := sLinha + AE(edtInscEstTrans.Text, 20);
  sLinha := sLinha + AE(edtFreteTrans.Text, 1);
  Writeln(FTextFile, sLinha);
end;

procedure TFrmHold.RegistroTipo7;
var
  sLinha: String;
begin
  // Dados da embalagem
  sLinha := '7';
  sLinha := sLinha + FormatFloat('000', edtQtdEmb.EditValue);
  sLinha := sLinha + AE(edtEspecieEmb.Text, 20);
  sLinha := sLinha + AE(edtMarcaEmb.Text, 20);
  sLinha := sLinha + AE(edtNumeroEmb.Text, 10);
  sLinha := sLinha + Replace(FormatFloat('0000.00', edtPesoBrutoEmb.Value), ',', '');
  sLinha := sLinha + Replace(FormatFloat('0000.00', edtPesoLiqEmb.Value), ',', '');
  sLinha := sLinha + Replace(FormatFloat('0000.00', edtFreteEmb.Value), ',', '');
  sLinha := sLinha + Replace(FormatFloat('0000.00', edtSeguroEmb.Value), ',', '');
  sLinha := sLinha + Replace(FormatFloat('0000.00', edtOutrosCustosEmb.Value), ',', '');
  Writeln(FTextFile, sLinha);
end;

procedure TFrmHold.btnExportarClick(Sender: TObject);
var
  sFilePath: String;
begin
  try
    if not DadosValidos then
      Exit;

    sFilePath := FrmMain.GetAppProperty('Default', 'FilePath');

    if sFilePath = '' then
    begin
      MessageDlg('O caminho para o arquivo não foi configurado!', mtInformation, [mbOK], 0);
      Exit;
    end;

    FFileName := sFilePath + cdsPedidoSaleCode.AsString + '.txt';
    ExportarArquivo;

    MessageDlg('Arquivo exportado com sucesso!', mtInformation, [mbOK], 0);
  except
    MessageDlg('Erro ao exportar arquivo.', mtError, [mbOK], 0);
  end;
end;

procedure TFrmHold.btnProcurarClick(Sender: TObject);
begin
  if not Assigned(FfrmSearchHold) then
    FfrmSearchHold := TFrmSearchHold.Create(Self);

  FIDPreSale := FfrmSearchHold.Start;
  if FIDPreSale <> -1 then
    OpenHold;
end;

procedure TFrmHold.Start;
begin
  btnProcurarClick(Self);

  if FIDPreSale <> -1 then
  begin
    qryTransp.Open;
    ShowModal;
    qryTransp.Close;
  end;
end;

procedure TFrmHold.btnSairClick(Sender: TObject);
begin
  Close;
end;

function TFrmHold.DadosValidos: Boolean;
begin
  Result := False;

  if cbxTransp.EditValue = NULL then
  begin
    MessageDlg('Transportador deve ser preenchido.', mtWarning, [mbOK], 0);
    cbxTransp.SetFocus;
    Exit;
  end;

  Result := True;
end;

procedure TFrmHold.CalcInvoiceValues;
var
  cInvoiceDiscount, cInvoiceSubTotal: Currency;
begin
  with qryPedidoItem do
  try
    DisableControls;
    First;
    cInvoiceDiscount := 0;
    cInvoiceSubTotal := 0;

    while not Eof do
    begin
      cInvoiceSubTotal := cInvoiceSubTotal + (qryPedidoItemQtd.AsFloat * qryPedidoItemPrecoVenda.AsCurrency);
      cInvoiceDiscount := cInvoiceDiscount + qryPedidoItemDesconto.AsCurrency;
      Next;
    end;

    First;
  finally
    EnableControls;
  end;

  with cdsPedido do
  begin
    Edit;
    FieldByName('SubTotal').AsCurrency := cInvoiceSubTotal;
    FieldByName('ValorDesconto').AsCurrency := cInvoiceDiscount;
    FieldByName('Total').AsCurrency := cInvoiceSubTotal - cInvoiceDiscount;
    Post;
  end;
end;

procedure TFrmHold.cdsPedidoAfterScroll(DataSet: TDataSet);
begin
  btnImprimir.Enabled := not cdsPedido.IsEmpty;
  btnExportar.Enabled := btnImprimir.Enabled;
end;

procedure TFrmHold.qryPedidoItemAfterOpen(DataSet: TDataSet);
begin
  CalcInvoiceValues;
  edtQtdEmb.Value := qryPedidoItem.RecordCount;
end;

procedure TFrmHold.cbxTranspPropertiesEditValueChanged(Sender: TObject);
begin
  with qryTranspProp do
  begin
    if Active then
      Close;

    Parameters.ParamByName('IDPessoa').Value := cbxTransp.EditValue;
    Open;

    edtEnderecoTrans.Text  := qryTranspPropEndereco.AsString;
    edtBairroTrans.Text    := qryTranspPropBairro.AsString;
    edtCEPTrans.Text       := qryTranspPropCEP.AsString;
    edtMunicipioTrans.Text := qryTranspPropCidade.AsString;
    edtUFTrans.Text        := qryTranspPropIDEstado.AsString;
    edtCNPJTrans.Text      := qryTranspPropInscEstadual.AsString;
    edtInscEstTrans.Text   := qryTranspPropCGC.AsString;

    Close;
  end;
end;

end.
