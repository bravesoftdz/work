unit ufrmGerenciaEnvioNF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxContainer, cxTextEdit, cxMemo, cxDBEdit, ExtCtrls, ComCtrls, OleCtrls,
  SHDocVw, Buttons;

type
  TfrmGerenciaEnvioNF = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1Selecionado: TcxGridDBColumn;
    cxGrid1DBTableView1Referencia: TcxGridDBColumn;
    cxGrid1DBTableView1Situacao: TcxGridDBColumn;
    cxGrid1DBTableView1DataSolicitacao: TcxGridDBColumn;
    cxGrid1DBTableView1DataUltimoEnvio: TcxGridDBColumn;
    cxGrid1DBTableView1DataResultado: TcxGridDBColumn;
    cxGrid1DBTableView1DataUltimaImpressao: TcxGridDBColumn;
    cxGrid1DBTableView1XMLEnviado: TcxGridDBColumn;
    cxGrid1DBTableView1XMLRecebido: TcxGridDBColumn;
    cxGrid1DBTableView1DetalhamentoErro: TcxGridDBColumn;
    cxGrid1DBTableView1QtdEnvios: TcxGridDBColumn;
    cxGrid1DBTableView1QtdImpressao: TcxGridDBColumn;
    cxGrid1DBTableView1IDNotaFiscal: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    cxStyleRepository1: TcxStyleRepository;
    cxStylePreview: TcxStyle;
    wbEnviado: TWebBrowser;
    TabSheet3: TTabSheet;
    wbRecebido: TWebBrowser;
    cxDBMemo2: TcxDBMemo;
    Panel1: TPanel;
    cbAll: TCheckBox;
    cxDBMemo1: TcxDBMemo;
    pnlBasicFilter: TPanel;
    pblGO: TPanel;
    btGO: TButton;
    cmbSituacao: TcxComboBox;
    cmbOrigem: TcxComboBox;
    deInicio: TcxDateEdit;
    deFim: TcxDateEdit;
    meReferencia: TcxMaskEdit;
    Label5: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel2: TPanel;
    Bevel1: TBevel;
    cxGrid1DBTableView1NumeroNota: TcxGridDBColumn;
    cxDBMemo3: TcxDBMemo;
    cxDBMemo4: TcxDBMemo;
    btEnviar: TBitBtn;
    btConsultar: TBitBtn;
    btCancelar: TBitBtn;
    btImprimir: TBitBtn;
    btInutilizar: TBitBtn;
    btnAbrirNota: TBitBtn;
    btConf: TBitBtn;
    lbVersion: TLabel;
    cbViewBeforeSend: TCheckBox;
    btnAjuda: TBitBtn;
    lbAmbiente: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure cmbSituacaoPropertiesChange(Sender: TObject);
    procedure btGOClick(Sender: TObject);
    procedure btEnviarClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure cbAllClick(Sender: TObject);
    procedure btConfClick(Sender: TObject);
    procedure btnAbrirNotaClick(Sender: TObject);
    procedure btConsultarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure btImprimirClick(Sender: TObject);
    procedure btInutilizarClick(Sender: TObject);
    procedure btnAjudaClick(Sender: TObject);
  private
    FImportarVendas, FImportarTransferencias : Boolean;
    function FiltroEstaPreenchido: boolean;
    function ExibeDetalheNota(APodeEnviar : Boolean) : Boolean;

    procedure InitFilter;
    procedure SetButton;
    procedure Refresh;

    procedure ImportData;
  public
    { Public declarations }
  end;

const
  CMB_SITUACAO_PENDENTE   = 0;
  CMB_SITUACAO_AGUARDANDO = 1;
  CMB_SITUACAO_APROVADA   = 2;
  CMB_SITUACAO_REJEITADA  = 3;
  CMB_SITUACAO_IMPRESSA   = 4;
  CMB_SITUACAO_CANCELADA  = 5;
  CMB_SITUACAO_ERROR      = 6;
  CMB_SITUACAO_TODAS      = 7;

  CMB_ORIGEM_VENDA         = 0;
  CMB_ORGIEM_TRANSFERENCIA = 1;

  DX_DATA_VAZIA = -700000;

var
  frmGerenciaEnvioNF: TfrmGerenciaEnvioNF;

implementation

uses udmSQL, udmNFe, uFrmProgresso, ufrmConfiguracao, uFrmImportarNotas,
  uDateTimeFunctions, uFrmDetalheNota, uWebFunctions;

{$R *.dfm}

procedure TfrmGerenciaEnvioNF.cmbSituacaoPropertiesChange(Sender: TObject);
begin
  SetButton;
end;

procedure TfrmGerenciaEnvioNF.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  InitFilter;
  SetButton;
  Refresh;
end;

procedure TfrmGerenciaEnvioNF.InitFilter;
begin
  with cmbSituacao do begin
    with Properties.Items do begin
      Clear;
      Add('Pendente');
      Add('Aguardando');
      Add('Aprovada');
      Add('Rejeitada');
      Add('Impressa');
      Add('Cancelada');
      Add('Erro');
      Add('[Todas]');
    end;
    ItemIndex := CMB_SITUACAO_PENDENTE;
  end;

  with cmbOrigem do begin
    with Properties.Items do begin
      Clear;
      Add('Venda');
      Add('Transferencia');
    end;
    ItemIndex := CMB_ORIGEM_VENDA;
  end;

  deInicio.Date := FirstDateMonth;
  deFim.Date    := LastDateMonth;

  meReferencia.Text := '';

  lbVersion.Caption := lbVersion.Caption + ' ' + NFE_VERSAO;

end;

procedure TfrmGerenciaEnvioNF.SetButton;
var
  iIndex: integer;
begin
  iIndex := cmbSituacao.ItemIndex;

  btEnviar.Enabled    := (iIndex = CMB_SITUACAO_PENDENTE) or
                         (iIndex = CMB_SITUACAO_REJEITADA) or
                         (iIndex = CMB_SITUACAO_ERROR);

  btConsultar.Enabled := (iIndex = CMB_SITUACAO_AGUARDANDO);

  btImprimir.Enabled  := (iIndex = CMB_SITUACAO_APROVADA) or
                         (iIndex = CMB_SITUACAO_IMPRESSA);

  btCancelar.Enabled  := (iIndex = CMB_SITUACAO_APROVADA) or
                         (iIndex = CMB_SITUACAO_IMPRESSA);

  btInutilizar.Enabled := True;
end;

function TfrmGerenciaEnvioNF.FiltroEstaPreenchido: boolean;
begin
  result :=   (cmbSituacao.ItemIndex <> -1) and
              (cmbOrigem.ItemIndex <> -1) and
              (
                (meReferencia.Text <> '') or ((deInicio.Date <> DX_DATA_VAZIA) and (deFim.Date <> DX_DATA_VAZIA))
              );
end;

procedure TfrmGerenciaEnvioNF.btGOClick(Sender: TObject);
begin

  if (cmbSituacao.ItemIndex = 0) and (not FImportarVendas) then
  begin
    ImportData;
    FImportarVendas := True;
  end;

  if (cmbSituacao.ItemIndex = 1) and (not FImportarTransferencias) then
  begin
    ImportData;
    FImportarTransferencias := True;
  end;

  if FiltroEstaPreenchido then
  begin
    dmSQL.FTipoNota := cmbOrigem.ItemIndex;
    Refresh;
  end
  else
    ShowMessage(' Preencha todos os filtros ');
end;

procedure TfrmGerenciaEnvioNF.Refresh;
begin
  dmSQL.AbreCdsNotaFiscal( cmbSituacao.ItemIndex,
                           cmbOrigem.Text,
                           meReferencia.Text,
                           deInicio.Date,
                           deFim.Date);
  cbAll.Checked := False;


  if (cmbSituacao.ItemIndex = CMB_SITUACAO_IMPRESSA) then
    cxGrid1DBTableView1.Preview.Visible := False
  else
    cxGrid1DBTableView1.Preview.Visible := True;

  if not dmSQL.IsAmbienteProducao then
  begin
    lbAmbiente.Font.Color := clRed;
    lbAmbiente.Caption    := 'Ambiente de Homologação';
  end
  else
  begin
    lbAmbiente.Font.Color := clBlack;
    lbAmbiente.Caption    := 'Ambiente de Produção';
  end;
    
end;

procedure TfrmGerenciaEnvioNF.btEnviarClick(Sender: TObject);
begin
  dmSQL.FTipoNota := cmbOrigem.ItemIndex;
  if (not cbViewBeforeSend.Checked) or (cbViewBeforeSend.Checked and ExibeDetalheNota(True)) then
  begin
    dmNFe.EnviaNotasSelecionadas;
    Refresh;
  end;
end;

procedure TfrmGerenciaEnvioNF.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePageIndex <> 0 then
  with TStringList.Create do
  try
    if PageControl1.ActivePageIndex = 1 then
    begin
      text:= dmSQL.cdsNotaFiscal.FieldByName('XMLEnviado').AsString;
      SaveToFile('C:\temp.xml');
      wbEnviado.Navigate('C:\temp.xml');
    end;

    if PageControl1.ActivePageIndex = 2 then
    begin
      text := dmSQL.cdsNotaFiscal.FieldByName('XMLRecebido').AsString;
      SaveToFile('C:\temp2.xml');
      wbRecebido.Navigate('C:\temp2.xml');
    end;

  finally
    Free;
  end;
end;

procedure TfrmGerenciaEnvioNF.cbAllClick(Sender: TObject);
begin
  dmSQL.SelectAll(cbAll.Checked);
end;

procedure TfrmGerenciaEnvioNF.btConfClick(Sender: TObject);
begin
  with TfrmConfiguracao.create(self) do
  try
    Start;
  finally
    Free;
  end;
end;

procedure TfrmGerenciaEnvioNF.ImportData;
var
  dDataIni, dDataEnd : TDateTime;
begin

  if (cmbOrigem.Text <> '') then
  begin
    dDataIni := deInicio.Date;
    dDataEnd := deFim.Date+1;
    with TFrmImportarNotas.Create(Self) do
    try
      Start(cmbOrigem.Text, dDataIni, dDataEnd);
    finally
      Free;
      end;
  end;
  
end;

procedure TfrmGerenciaEnvioNF.btnAbrirNotaClick(Sender: TObject);
begin

  if (cmbOrigem.Text <> '') and (dmSQL.cdsNotaFiscal.Active) then
    ExibeDetalheNota(False);

end;

procedure TfrmGerenciaEnvioNF.btConsultarClick(Sender: TObject);
begin

 dmNFe.ConsultaNotasSelecionadas;
 Refresh;

end;

procedure TfrmGerenciaEnvioNF.btCancelarClick(Sender: TObject);
begin

 dmNFe.CancelaNotasSelecionadas;
 Refresh;

end;

procedure TfrmGerenciaEnvioNF.btImprimirClick(Sender: TObject);
begin
  dmNFe.ImprimirNotasSelecionadas;
end;

procedure TfrmGerenciaEnvioNF.btInutilizarClick(Sender: TObject);
begin

 dmNFe.InutilizaNotas;
 Refresh;
 
end;

function TfrmGerenciaEnvioNF.ExibeDetalheNota(APodeEnviar: Boolean) : Boolean;
begin

  with TFrmDetalheNota.Create(Self) do
  try
    Result := Start(cmbOrigem.Text, dmSQL.cdsNotaFiscal.FieldByName('Referencia').AsInteger, APodeEnviar);
  finally
    Free;
  end;

end;

procedure TfrmGerenciaEnvioNF.btnAjudaClick(Sender: TObject);
begin
  OpenURL('http://www.mainretail.com.br/treinamento/NFe/nfe.htm');
end;

end.


