unit uFrmQuickBooksConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParent, siComp, StdCtrls, ExtCtrls, uDMQuickBooks, uDMImportExport,
  DB, DBClient, Provider, ADODB, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, Grids;

type
  TFrmQuickBooksConfig = class(TFrmParent)
    Panel1: TPanel;
    Label9: TLabel;
    imgPeachtree: TImage;
    Shape8: TShape;
    pnlComple: TPanel;
    btnClose: TButton;
    btnSave: TButton;
    Label1: TLabel;
    cbxAccounts: TComboBox;
    lbVersion: TLabel;
    Label2: TLabel;
    cbxPayments: TComboBox;
    Label3: TLabel;
    cbxRefound: TComboBox;
    Label4: TLabel;
    cbxTimePayroll: TComboBox;
    Label5: TLabel;
    cdsPayment: TClientDataSet;
    cdsPaymentIDMeioPag: TIntegerField;
    cdsPaymentIDLancamentoTipo: TIntegerField;
    cdsPaymentMeioPag: TStringField;
    cdsPaymentTipo: TIntegerField;
    sgColumns: TStringGrid;
    cbColumns: TComboBox;
    Label6: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure sgColumnsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure cbColumnsChange(Sender: TObject);
    procedure cbColumnsExit(Sender: TObject);
  private
    FDMQuickBooks : TDMQuickBooks;
    procedure FillAccounList;
    procedure FillPaymentList;
    procedure LoadValues;
    procedure SetValues;

    procedure OpenPayments;
    procedure ClosePayments;

    procedure LoadColumns;
    procedure SaveGridColumns;
  public
    function Start : Boolean;
  end;


implementation

uses Math, uParamFunctions;

{$R *.dfm}

{ TFrmQuickBooksConfig }

function TFrmQuickBooksConfig.Start: Boolean;
begin

  with FDMQuickBooks do
  begin
    ConnectionMode  := CON_TYPE_DONT_CARE;
    ApplicationName := 'MainRetail';
    CompanyFile     := '';
    Result          := Connect;
    FillAccounList;
    FillPaymentList;
    LoadValues;
    OpenPayments;
    ShowModal;
  end;

end;

procedure TFrmQuickBooksConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(FDMQuickBooks);
  ClosePayments;
end;

procedure TFrmQuickBooksConfig.FormCreate(Sender: TObject);
begin
  inherited;
  FDMQuickBooks := TDMQuickBooks.Create(Self);
end;

procedure TFrmQuickBooksConfig.FillAccounList;
begin
  cbxAccounts.Clear;
  cbxAccounts.Items.Text    :=  FDMQuickBooks.GetAccountByType(1);
  cbxRefound.Items.Text     := cbxAccounts.Items.Text;
  cbColumns.Items.Text      := FDMQuickBooks.GetPaymentMethod;

  //cbxTimePayroll.Items.Text := FDMQuickBooks.GetPayrollList;
end;

procedure TFrmQuickBooksConfig.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmQuickBooksConfig.LoadValues;
begin
  cbxAccounts.ItemIndex := cbxAccounts.Items.IndexOf(DMImportExport.GetAppProperty('QuickBooks', 'SalesAccDes'));
  cbxPayments.ItemIndex := cbxPayments.Items.IndexOf(DMImportExport.GetAppProperty('QuickBooks', 'PaymentMethod'));
  cbxRefound.ItemIndex  := cbxRefound.Items.IndexOf(DMImportExport.GetAppProperty('QuickBooks', 'RefoundAccDes'));
end;

procedure TFrmQuickBooksConfig.SetValues;
var
  sSalesAcc,
  sRefoundAcc : String;
begin
  sSalesAcc   := Trim(Copy(cbxAccounts.Text, 0, Pos('[', cbxAccounts.Text)-1));
  sRefoundAcc := Trim(Copy(cbxRefound.Text, 0, Pos('[', cbxRefound.Text)-1));

  DMImportExport.SetAppProperty('QuickBooks', 'SalesAcc', sSalesAcc);
  DMImportExport.SetAppProperty('QuickBooks', 'SalesAccDes', cbxAccounts.Text);
  DMImportExport.SetAppProperty('QuickBooks', 'RefoundAcc', sRefoundAcc);
  DMImportExport.SetAppProperty('QuickBooks', 'RefoundAccDes', cbxRefound.Text);
  DMImportExport.SetAppProperty('QuickBooks', 'PaymentMethod', cbxPayments.Text);

  SaveGridColumns;
end;

procedure TFrmQuickBooksConfig.btnSaveClick(Sender: TObject);
begin
  inherited;
  SetValues;
  Close;
end;

procedure TFrmQuickBooksConfig.FillPaymentList;
begin
  cbxPayments.Clear;
  cbxPayments.Items.Text := FDMQuickBooks.GetPaymentMethod;
end;

procedure TFrmQuickBooksConfig.sgColumnsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
begin
  //Somente na Coluna desejada
  if ((ACol = 1) AND (ARow <> 0)) then
  begin
   {Size and position the combo box to fit the cell}
    R := sgColumns.CellRect(ACol, ARow);
    R.Left := R.Left + sgColumns.Left;
    R.Right := R.Right + sgColumns.Left;
    R.Top := R.Top + sgColumns.Top;
    R.Bottom := R.Bottom + sgColumns.Top;
    cbColumns.Left := R.Left + 1;
    cbColumns.Top := R.Top + 1;
    cbColumns.Width := (R.Right + 1) - R.Left;
    cbColumns.Height := (R.Bottom + 1) - R.Top;
   {Show the combobox}
    cbColumns.Text := sgColumns.Cells[ACol, ARow];
    cbColumns.Visible := True;
    cbColumns.SetFocus;
  end;
  CanSelect := True;
end;

procedure TFrmQuickBooksConfig.ClosePayments;
begin
  with cdsPayment do
    if Active then
      Close;
end;

procedure TFrmQuickBooksConfig.OpenPayments;
begin
  with cdsPayment do
    if not Active then
    begin
      Open;
      LoadColumns;
    end;
end;

procedure TFrmQuickBooksConfig.LoadColumns;
var
  i : Integer;
  sColumn : String;
  sResult : String;
begin

  sgColumns.Cells[0,0] := 'Main Retail';
  sgColumns.Cells[1,0] := 'QuickBooks';

  i := 1;

  sColumn := DMImportExport.GetAppProperty('QuickBooks', 'PaymentColumns');

  with cdsPayment do
  begin
    First;
    While not EOF do
    begin
      sgColumns.Cells[0,i] := FieldByName('MeioPag').AsString;
      sResult := ParseParam(sColumn, FieldByName('MeioPag').AsString);
      if (sResult <> '') then
        sgColumns.Cells[1,i] := sResult;
      sColumn := DeleteParam(sColumn, FieldByName('MeioPag').AsString);
      inc(i);
      Next;
    end;
  end;

  sgColumns.RowCount := i;

end;

procedure TFrmQuickBooksConfig.cbColumnsChange(Sender: TObject);
begin
  inherited;

  sgColumns.Cells[sgColumns.Col, sgColumns.Row] := cbColumns.Items[cbColumns.ItemIndex];

  cbColumns.Visible := False;
  sgColumns.SetFocus;
  
end;

procedure TFrmQuickBooksConfig.cbColumnsExit(Sender: TObject);
begin
  inherited;
  sgColumns.Cells[sgColumns.Col, sgColumns.Row] := cbColumns.Items[cbColumns.ItemIndex];
  cbColumns.Visible := False;
  sgColumns.SetFocus;
end;

procedure TFrmQuickBooksConfig.SaveGridColumns;
var
  sColumn : String;
  i       : integer;
begin

  for i:=1 to sgColumns.RowCount-1 do
    if Trim(sgColumns.Cells[0,i]) <> '' then
      sColumn := sColumn + sgColumns.Cells[0,i] + '=' + sgColumns.Cells[1,i] + ';';

  if sColumn = '' then
     Exit;

  DMImportExport.SetAppProperty('QuickBooks', 'PaymentColumns', sColumn);

end;

end.
