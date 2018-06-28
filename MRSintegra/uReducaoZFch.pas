unit uReducaoZFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, DBClient, cxLookAndFeelPainters,
  StdCtrls, cxButtons, ExtCtrls, DB, cxDBLookupComboBox, cxLookupEdit,
  cxDBLookupEdit, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDBData, ADODB, Provider, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid;

type
  TReducaoZFch = class(TForm)
    deMovDate: TcxDBDateEdit;
    edNumReducao: TcxDBTextEdit;
    edCOOInicial: TcxDBTextEdit;
    edCOOFinal: TcxDBTextEdit;
    edNumCancel: TcxDBTextEdit;
    edValCancel: TcxDBTextEdit;
    edValDesc: TcxDBTextEdit;
    edGTInicial: TcxDBTextEdit;
    edGTFinal: TcxDBTextEdit;
    edSubstTrib: TcxDBTextEdit;
    edIsencao: TcxDBTextEdit;
    pnlBottom: TPanel;
    btCancel: TcxButton;
    btOk: TcxButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    dsFch: TDataSource;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label21: TLabel;
    Label26: TLabel;
    dsTributacao: TDataSource;
    cdsTributacao: TClientDataSet;
    Panel2: TPanel;
    grdTributacao: TcxGrid;
    grdTributacaoDBTableView: TcxGridDBTableView;
    grdTributacaoLevel: TcxGridLevel;
    Panel1: TPanel;
    dspTributacao: TDataSetProvider;
    quTributacao: TADOQuery;
    cdsTributacaoIDReducaoZ: TIntegerField;
    cdsTributacaoAliquota: TFloatField;
    cdsTributacaoBaseCalculo: TBCDField;
    cdsTributacaoValImposto: TBCDField;
    cdsTributacaoIDTributacaoECF: TIntegerField;
    grdTributacaoDBTableViewIDTributacaoECF: TcxGridDBColumn;
    grdTributacaoDBTableViewIDReducaoZ: TcxGridDBColumn;
    grdTributacaoDBTableViewAliquota: TcxGridDBColumn;
    grdTributacaoDBTableViewBaseCalculo: TcxGridDBColumn;
    grdTributacaoDBTableViewValImposto: TcxGridDBColumn;
    Label12: TLabel;
    Label13: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label27: TLabel;
    edLoja: TcxDBTextEdit;
    edECF: TcxDBTextEdit;
    Label23: TLabel;
    edNumeroSerie: TcxDBTextEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btOkClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure cdsTributacaoNewRecord(DataSet: TDataSet);
  private
    FDataSet: TClientDataSet;
    procedure OpenTributacao;
    procedure CloseTributacao;
    function GetTaxTotal: Currency;
    function ValidateReducaoZ: Boolean;
    function ValidateRequiredFields: Boolean;
    function ValidateGrandeTotal: Boolean;
  public
    procedure Start(ADataSet: TClientDataSet);
    procedure NewRecord;
    procedure EditRecord;
  end;

var
  ReducaoZFch: TReducaoZFch;

implementation

uses uDMSintegra, uReducaoZList;

{$R *.dfm}

{ TReducaoZFch }

procedure TReducaoZFch.EditRecord;
begin
  FDataSet.Edit;
  OpenTributacao;
  ShowModal;
  CloseTributacao;
end;

procedure TReducaoZFch.NewRecord;
begin
  FDataSet.Append;

  with DMSintegra.spGetNextCode do
  begin
    Parameters.ParamByName('@Tabela').Value := 'Sal_ReducaoZ.IDReducaoZ';
    ExecProc;
    FDataSet.FieldByName('IDReducaoZ').AsInteger := Parameters.ParamByName('@NovoCodigo').Value;
  end;

  OpenTributacao;
  ShowModal;
  CloseTributacao;  
end;

procedure TReducaoZFch.Start(ADataSet: TClientDataSet);
begin
  FDataSet := ADataSet;
  dsFch.DataSet := FDataSet;
end;

procedure TReducaoZFch.btOkClick(Sender: TObject);
begin
  if ValidateRequiredFields and ValidateReducaoZ and ValidateGrandeTotal then
  begin
    if FDataSet.State in dsEditModes then
      FDataSet.Post;
    FDataSet.ApplyUpdates(-1);
    cdsTributacao.ApplyUpdates(-1);
    Close;
  end;
end;

procedure TReducaoZFch.btCancelClick(Sender: TObject);
begin
  FDataSet.Cancel;
  cdsTributacao.Cancel;
  Close;
end;

procedure TReducaoZFch.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FDataSet.State in dsEditModes then
    FDataSet.Cancel;
end;

function TReducaoZFch.ValidateReducaoZ: Boolean;
begin
  with DMSintegra.quFreeSQL do
  begin
    SQL.Text := 'SELECT * FROM Sal_ReducaoZ WHERE IDReducaoZ <> :IDReducaoZ AND NumeroSerie = :NumeroSerie AND MovDate = :MovDate';
    Parameters.ParamByName('IDReducaoZ').Value := FDataSet.FieldByName('IDReducaoZ').Value;
    Parameters.ParamByName('NumeroSerie').Value := edNumeroSerie.Text;
    Parameters.ParamByName('MovDate').Value := deMovDate.Date;
    Open;
    Result := IsEmpty;

    if not Result then
      ShowMessage('Redução Z já cadastrada para este número de série nesta data.');
  end;
end;

function TReducaoZFch.ValidateRequiredFields: Boolean;
begin
  Result := False;

  if deMovDate.Text = '' then
  begin
    ShowMessage('Data não preenchida.');
    Exit;
  end;

  if edNumReducao.Text = '' then
  begin
    ShowMessage('Leitura X não preenchida.');
    Exit;
  end;

  if edCOOInicial.Text = '' then
  begin
    ShowMessage('COO Inicial não preenchido.');
    Exit;
  end;

  if edCOOFinal.Text = '' then
  begin
    ShowMessage('COO Final não preenchido.');
    Exit;
  end;

  if edNumCancel.Text = '' then
  begin
    ShowMessage('Número de cancelamentos não preenchido.');
    Exit;
  end;

  if edValCancel.Text = '' then
  begin
    ShowMessage('Valor de cancelamentos não preenchido.');
    Exit;
  end;

  if edValDesc.Text = '' then
  begin
    ShowMessage('Valor de descontos não preenchido.');
    Exit;
  end;

  if edGTInicial.Text = '' then
  begin
    ShowMessage('Grande total inicial não preenchido.');
    Exit;
  end;

  if edGTFinal.Text = '' then
  begin
    ShowMessage('Grande total final não preenchido.');
    Exit;
  end;

  if edSubstTrib.Text = '' then
  begin
    ShowMessage('Substituição tributária não preenchida.');
    Exit;
  end;

  if edIsencao.Text = '' then
  begin
    ShowMessage('Isenção não preenchida.');
    Exit;
  end;

  Result := True;
end;

procedure TReducaoZFch.CloseTributacao;
begin
  if cdsTributacao.Active then
    cdsTributacao.Close;
end;

procedure TReducaoZFch.OpenTributacao;
begin
  with cdsTributacao do
  begin
    FetchParams;
    Params.ParamByName('IDReducaoZ').Value := FDataSet.FieldByName('IDReducaoZ').Value;
    Open;
  end;
end;

procedure TReducaoZFch.cdsTributacaoNewRecord(DataSet: TDataSet);
begin
  with DMSintegra.spGetNextCode do
  begin
    Parameters.ParamByName('@Tabela').Value := 'Sal_TributacaoECF.IDTributacaoECF';
    ExecProc;
    DataSet.FieldByName('IDTributacaoECF').AsInteger := Parameters.ParamByName('@NovoCodigo').Value;
  end;

  DataSet.FieldByName('IDReducaoZ').Value := FDataSet.FieldByName('IDReducaoZ').Value;
end;

function TReducaoZFch.ValidateGrandeTotal: Boolean;
begin
  with FDataSet do
    Result := (GetTaxTotal +
               FieldByName('ValCancelamentos').Value +
               FieldByName('ValDescontos').Value +
               FieldByName('SubstituicaoTrib').Value +
               FieldByName('Isencao').Value) =
              (FieldByName('GTFinal').Value - FieldByName('GTInicial').Value);

  if not Result then
    ShowMessage('Valores inconsistentes!');
end;

function TReducaoZFch.GetTaxTotal: Currency;
begin
  Result := 0;

  with cdsTributacao do
  begin
    First;
    while not Eof do
    begin
      Result := Result + FieldByName('ValImposto').Value;
      Next;
    end;
  end;
end;

end.
