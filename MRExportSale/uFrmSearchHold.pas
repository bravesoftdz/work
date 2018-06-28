unit uFrmSearchHold;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid,
  cxLookAndFeelPainters, cxContainer, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, StdCtrls, cxButtons, ExtCtrls, ADODB,
  DBClient, Provider;

type
  TFrmSearchHold = class(TForm)
    grdHolds: TcxGrid;
    grdHoldsDB: TcxGridDBTableView;
    grdHoldsLevel: TcxGridLevel;
    dsSearchHold: TDataSource;
    qrySearchHold: TADOQuery;
    pnlBottom: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    pnlFilter: TPanel;
    edtDataIni: TcxDateEdit;
    edtDataFim: TcxDateEdit;
    qrySearchHoldSaleCode: TStringField;
    qrySearchHoldPreSaleDate: TDateTimeField;
    qrySearchHoldPessoa: TStringField;
    qrySearchHoldIDPreSale: TIntegerField;
    grdHoldsDBIDPreSale: TcxGridDBColumn;
    grdHoldsDBSaleCode: TcxGridDBColumn;
    grdHoldsDBPreSaleDate: TcxGridDBColumn;
    grdHoldsDBPessoa: TcxGridDBColumn;
    lblDataIni: TLabel;
    lblDataFim: TLabel;
    btnProcurar: TcxButton;
    lblNumPedido: TLabel;
    edtNumPedido: TcxTextEdit;
    qryHasService: TADOQuery;
    qryHasServiceTotalService: TIntegerField;
    dspSearchHold: TDataSetProvider;
    cdsSearchHold: TClientDataSet;
    cdsSearchHoldIDPreSale: TIntegerField;
    cdsSearchHoldSaleCode: TStringField;
    cdsSearchHoldPreSaleDate: TDateTimeField;
    cdsSearchHoldPessoa: TStringField;
    qryHasChange: TADOQuery;
    qryHasChangeTotalChange: TIntegerField;
    procedure btnProcurarClick(Sender: TObject);
    procedure grdHoldsDBDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cdsSearchHoldAfterOpen(DataSet: TDataSet);
  private
    function HasService: Boolean;
    function HasChange: Boolean;
  public
    function Start: Integer;
  end;

implementation

uses uFrmMain, DateUtils, uStringFunctions;

{$R *.dfm}

{ TFrmSearchHold }

function TFrmSearchHold.Start: Integer;
begin
  Result := -1;

  ShowModal;

  if (ModalResult = mrOk) and (not cdsSearchHold.IsEmpty) then
    Result := cdsSearchHoldIDPreSale.AsInteger;
end;

procedure TFrmSearchHold.btnProcurarClick(Sender: TObject);
var
  sSQL: String;
begin
  sSQL := 'SELECT ' +
          '  I.IDPreSale, ' +
          '  I.SaleCode, ' +
          '  I.PreSaleDate, ' +
          '  P.Pessoa ' +
          'FROM ' +
          '  Invoice I ' +
          '  JOIN Pessoa P ON (I.IDCustomer = P.IDPessoa) ' +
          'WHERE ' +
          '  I.IDInvoice IS NULL ';// +
          //'  AND I.DeliverConfirmation = 1 ';

  with qrySearchHold do
  begin
    if edtNumPedido.Text <> '' then
      sSQL := sSQL + '  AND SaleCode = ' + QuotedStr(edtNumPedido.Text)
    else
      sSQL := sSQL + '  AND DeliverDate >= ' + QuotedStr(FormatDateTime('yyyymmdd', Trunc(edtDataIni.Date))) +
                     '  AND DeliverDate <= ' + QuotedStr(FormatDateTime('yyyymmdd', Trunc(IncDay(edtDataFim.Date))));
    SQL.Text := sSQL;
  end;

  with cdsSearchHold do
  begin
    if Active then
      Close;
    Open;
  end;
end;

procedure TFrmSearchHold.grdHoldsDBDblClick(Sender: TObject);
begin
  btnOkClick(Sender);
end;

procedure TFrmSearchHold.FormCreate(Sender: TObject);
begin
  edtDataIni.Date := Date;
  edtDataFim.Date := Date;
end;

function TFrmSearchHold.HasService: Boolean;
begin
  with qryHasService do
  begin
    if Active then
      Close;

    Parameters.ParamByName('IDPreSale').Value := cdsSearchHoldIDPreSale.AsInteger;
    Open;
    Result := FieldByName('TotalService').AsInteger > 0;
    Close;
  end;
end;

procedure TFrmSearchHold.btnOkClick(Sender: TObject);
begin
  if cdsSearchHold.IsEmpty then
    MessageDlg('Nenhum pedido foi selecionado.', mtWarning, [mbOK], 0)
  else if HasService then
    MessageDlg('Este pedido possui serviço(s) e não pode ser faturado.', mtWarning, [mbOK], 0)
  else
    ModalResult := mrOk;
end;

procedure TFrmSearchHold.cdsSearchHoldAfterOpen(DataSet: TDataSet);
begin
  with cdsSearchHold do
  try
    DisableControls;
    First;
    while not Eof do
    begin
      if HasChange then
        Delete
      else
        Next;
    end;
    First;
  finally
    EnableControls;
  end;
end;

function TFrmSearchHold.HasChange: Boolean;
begin
  with qryHasChange do
  begin
    if Active then
      Close;

    Parameters.ParamByName('IDPreSale').Value := cdsSearchHoldIDPreSale.AsInteger;
    Open;
    Result := FieldByName('TotalChange').AsInteger > 0;
    Close;
  end;
end;

end.
