unit uFrmJoinHold;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  Grids, DBGrids, SMDBGrid, DB, ADODB, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, ComCtrls;

const
  START_ONE = 0;
  START_ALL = 1;


type
  TFrmJoinHold = class(TFrmParentAll)
    quPreSale: TADOQuery;
    quPreSaleIDPreSale: TIntegerField;
    quPreSalePreSaleDate: TDateTimeField;
    quPreSaleTotInvoice: TFloatField;
    quPreSalePessoaFirstName: TStringField;
    quPreSalePessoaLastName: TStringField;
    quPreSaleIDTouristGroup: TIntegerField;
    quPreSaleOtherComissionID: TIntegerField;
    quPreSalePessoa: TStringField;
    quPreSaleSaleCode: TStringField;
    dsPreSale: TDataSource;
    btnSave: TButton;
    quPreSaleIDPessoa: TIntegerField;
    quPreSaleNote: TStringField;
    spUpHold: TADOStoredProc;
    pgSearch: TPageControl;
    tsInvoiceShipping: TTabSheet;
    tsHold: TTabSheet;
    pnlInvoiceType: TPanel;
    lbSearchOption: TLabel;
    cbxOption: TComboBox;
    pnlFilter: TPanel;
    Label4: TLabel;
    lbTo: TLabel;
    edtHold: TEdit;
    btnExec: TButton;
    edtLastHold: TEdit;
    grdInvoice: TcxGrid;
    grdInvoiceDB: TcxGridDBTableView;
    grdInvoiceDBSaleCode: TcxGridDBColumn;
    grdInvoiceDBPessoaFirstName: TcxGridDBColumn;
    grdInvoiceDBPessoaLastName: TcxGridDBColumn;
    grdInvoiceDBPessoa: TcxGridDBColumn;
    grdInvoiceDBPreSaleDate: TcxGridDBColumn;
    grdInvoiceDBTotInvoice: TcxGridDBColumn;
    grdInvoiceLevel: TcxGridLevel;
    pnlSearchSH: TPanel;
    Label1: TLabel;
    edtInvoiceNum: TEdit;
    btnSearchSH: TButton;
    griInvoice: TcxGrid;
    griInvoiceDBTableView: TcxGridDBTableView;
    griInvoiceLevel1: TcxGridLevel;
    quSHInvoice: TADODataSet;
    dsSHInvoice: TDataSource;
    quSHInvoiceIDPreSale: TIntegerField;
    quSHInvoicePreSaleDate: TDateTimeField;
    quSHInvoiceSaleCode: TStringField;
    quSHInvoiceInvoiceCode: TStringField;
    quSHInvoiceInvoiceDate: TDateTimeField;
    quSHInvoiceNote: TStringField;
    quSHInvoicePessoaFirstName: TStringField;
    quSHInvoicePessoaLastName: TStringField;
    quSHInvoicePessoa: TStringField;
    quSHInvoiceIDPessoa: TIntegerField;
    quSHInvoiceTotInvoice: TBCDField;
    quSHInvoiceShipDate: TDateTimeField;
    quSHInvoiceTracking: TStringField;
    quSHInvoiceIDDeliverType: TIntegerField;
    quSHInvoiceAddressName: TStringField;
    quSHInvoiceAddress: TStringField;
    quSHInvoiceCity: TStringField;
    quSHInvoiceZIP: TStringField;
    quSHInvoiceIDEstado: TStringField;
    quSHInvoiceIDPais: TIntegerField;
    quSHInvoiceShipVia: TStringField;
    griInvoiceDBTableViewPreSaleDate: TcxGridDBColumn;
    griInvoiceDBTableViewSaleCode: TcxGridDBColumn;
    griInvoiceDBTableViewInvoiceCode: TcxGridDBColumn;
    griInvoiceDBTableViewInvoiceDate: TcxGridDBColumn;
    griInvoiceDBTableViewNote: TcxGridDBColumn;
    griInvoiceDBTableViewPessoaFirstName: TcxGridDBColumn;
    griInvoiceDBTableViewPessoaLastName: TcxGridDBColumn;
    griInvoiceDBTableViewPessoa: TcxGridDBColumn;
    griInvoiceDBTableViewTotInvoice: TcxGridDBColumn;
    griInvoiceDBTableViewShipDate: TcxGridDBColumn;
    griInvoiceDBTableViewTracking: TcxGridDBColumn;
    griInvoiceDBTableViewAddressName: TcxGridDBColumn;
    griInvoiceDBTableViewAddress: TcxGridDBColumn;
    griInvoiceDBTableViewCity: TcxGridDBColumn;
    griInvoiceDBTableViewZIP: TcxGridDBColumn;
    griInvoiceDBTableViewIDEstado: TcxGridDBColumn;
    griInvoiceDBTableViewShipVia: TcxGridDBColumn;
    cbSearchFor: TComboBox;
    edtParamText: TEdit;
    lbSelection: TLabel;
    lbTrack: TLabel;
    edtTracNum: TEdit;
    grdInvoiceDBDBColumn1: TcxGridDBColumn;
    procedure btnExecClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtHoldEnter(Sender: TObject);
    procedure edtHoldKeyPress(Sender: TObject; var Key: Char);
    procedure btnSearchSHClick(Sender: TObject);
  private
    fIDPreSaleNew,
    fIDPreSaleAtual : Integer;
    FStartType: Integer;
    procedure JoinHolds;
  public
    { Public declarations }
    function Start(IDPreSaleAtual:Integer; var fCustomer, fOBS : String;
                   ShowOption : Boolean):Integer;

    function StartJoinAll(IDPreSaleAtual:Integer):Boolean;
    function StartInvoiceShip : Integer;
  end;

implementation

uses uDM, uDMGlobal, uSystemConst, uCharFunctions, uSqlFunctions;

{$R *.dfm}

{ TFrmJoinHold }

function TFrmJoinHold.Start(IDPreSaleAtual:Integer; var fCustomer, fOBS : String;
    ShowOption : Boolean): Integer;
begin

   fIDPreSaleAtual := IDPreSaleAtual;
   fIDPreSaleNew   := -1;

   pnlInvoiceType.Visible := ShowOption;

   FStartType := START_ONE;

   tsHold.TabVisible := True;
   tsInvoiceShipping.TabVisible := False;

   ShowModal;

   Result     := fIDPreSaleNew;

   if Result <> -1 then
      begin
      fCustomer  := quPreSalePessoaFirstName.AsString + ' ' +
                    quPreSalePessoaLastName.AsString;
      fOBS       := quPreSaleNote.AsString;
      end;

   quPreSale.Close;

end;

procedure TFrmJoinHold.btnExecClick(Sender: TObject);
var
  IsLayaway, sSQL : String;
begin
  inherited;
  with quPreSale do
    begin
    if Active then
       Close;

    if not pnlInvoiceType.Visible then
      IsLayaway := '0'
    else
      if cbxOption.ItemIndex = 0 then
         IsLayaway := '0'
      else
         IsLayaway := '1';

    if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
       sSQL := 'SELECT I.IDPreSale, I.PreSaleDate, I.SaleCode, I.Note, P.PessoaFirstName, ' +
                   'P.PessoaLastName, P.Pessoa, P.IDPessoa, p.juridico  ' +
                   '(I.SubTotal - I.InvoiceDiscount - I.ItemDiscount + I.Tax + IsNull(I.AditionalExpenses, 0)) as TotInvoice, ' +
                   'I.IDTouristGroup, I.OtherComissionID FROM Invoice I (NOLOCK) ' +
                   'JOIN Pessoa P (NOLOCK) ON I.IDCustomer = P.IDPessoa ' +
                   'JOIN TipoPessoa TP (NOLOCK) ON TP.IDTipoPessoa = P.IDTipoPessoa ' +
                   'WHERE TP.PATH like '+QuotedStr('.001%') + ' AND I.IDInvoice Is Null AND I.Layaway = ' + IsLayaway +
                   ' AND I.Canceled = 0 AND I.PreSaleDate <= GetDate() ' +
                   ' AND I.IDPreSale NOT IN (Select IDPreSaleParent From Invoice Where IDPreSaleParent IS NOT NULL) '
    else
       //sSQL := 'SELECT I.IDPreSale, I.PreSaleDate, I.SaleCode, I.Note, P.PessoaFirstName, ' +
       //            'P.PessoaLastName, P.Pessoa, P.IDPessoa, ' +
         sSQL := 'select ' +
                 '  i.IdPresale ' +
                 ', i.PresaleDate ' +
                 ', i.SaleCode ' +
                 ', i.Note ' +
                 ',(case when p.Juridico = 1 ' +
                 '       then isnull(p.PessoaFirstName, p.pessoa) ' +
                 '       else p.PessoaFirstName end) as PessoaFirstName ' +
                 ',(case when p.Juridico = 1 ' +
                 '     then isnull(p.PessoaLastName, p.pessoa) ' +
                 '     else p.PessoaLastName ' +
                 'end) as PessoaLastName ' +
                 ', p.pessoa ' +
                 ', p.idpessoa ' +
                 ', p.juridico ' +
                 ', (I.SubTotal - I.InvoiceDiscount - I.ItemDiscount + I.Tax + IsNull(I.AditionalExpenses, 0)) as TotInvoice, ' +
                 'I.IDTouristGroup, I.OtherComissionID ' +
                 ' FROM Invoice I  ' +
                 'JOIN Pessoa P ON I.IDCustomer = P.IDPessoa ' +
                 'WHERE I.IDInvoice Is Null ' +

                 //MR-197 - under test
                 ' and I.Tax Is Not Null ' +
                 ' AND I.Layaway = ' + IsLayaway +
                 ' AND I.Canceled = 0 ' + //amfsouza 10.06.2011 AND I.PreSaleDate <= GetDate() ' +
                 ' AND I.IDPreSale NOT IN (Select IDPreSaleParent From Invoice Where IDPreSaleParent IS NOT NULL) ';



    if (Trim(edtHold.Text) <> '') then
      sSQL :=  sSQL + ' AND CAST(REPLACE(I.SaleCode,'+QuotedStr('-')+','''') AS int) >= ' + Trim(edtHold.Text);

    if (Trim(edtLastHold.Text) <> '') then
      sSQL :=  sSQL + ' AND CAST(REPLACE(I.SaleCode,'+QuotedStr('-')+','''') AS int) <= ' + Trim(edtLastHold.Text);

    if FStartType = START_ALL then
      sSQL :=  sSQL + ' AND I.IDPreSale <> ' + IntToStr(fIDPreSaleAtual);

    SQL.Text := sSQL;
    Open;

    if RecordCount > 0  then
       begin
       grdInvoice.SetFocus;
       btnExec.Default := False;
       btnSave.Default := True;
       end;
    end;
end;

procedure TFrmJoinHold.btCloseClick(Sender: TObject);
begin
  inherited;
  fIDPreSaleNew := -1;
  Close;
end;

procedure TFrmJoinHold.btnSaveClick(Sender: TObject);
begin
  inherited;

  if tsHold.TabVisible then
  begin
    if quPreSale.Active then
       fIDPreSaleNew := quPreSaleIDPreSale.AsInteger;
  end
  else if tsInvoiceShipping.TabVisible then
  begin
    if quSHInvoice.Active then
       fIDPreSaleNew := quSHInvoiceIDPreSale.AsInteger;
  end;

  Close;
end;

procedure TFrmJoinHold.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmJoinHold.edtHoldEnter(Sender: TObject);
begin
  inherited;
  btnExec.Default := True;
  btnSave.Default := False;
end;

function TFrmJoinHold.StartJoinAll(IDPreSaleAtual: Integer): Boolean;
begin

   fIDPreSaleAtual := IDPreSaleAtual;
   pnlInvoiceType.Visible := False;
   fIDPreSaleNew := -1;
   tsInvoiceShipping.TabVisible := False;

   FStartType := START_ALL;

   ShowModal;

   Result := (fIDPreSaleNew <> -1);

   if Result then
     JoinHolds;

end;

procedure TFrmJoinHold.JoinHolds;
begin

  with quPreSale do
  try
    DisableControls;
    First;
    while not EOF do
    begin
      spUpHold.Parameters.ParambyName('@IDPreSaleOrigem').Value  := quPreSaleIDPreSale.AsInteger;
      spUpHold.Parameters.ParambyName('@IDPreSaleDestino').Value := fIDPreSaleAtual;
      spUpHold.Parameters.ParambyName('@Date').Value             := Now;
      spUpHold.Parameters.ParambyName('@IDUser').Value           := DM.fUser.ID;
      spUpHold.ExecProc;
      Next;
    end;
  finally
    EnableControls;
  end;
end;

procedure TFrmJoinHold.edtHoldKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  Key := ValidateNumbers(Key);
end;

function TFrmJoinHold.StartInvoiceShip: Integer;
begin

  tsHold.TabVisible := False;
  tsInvoiceShipping.TabVisible := True;
  fIDPreSaleNew := -1;

  ShowModal;

  if (fIDPreSaleNew = -1) or (not quSHInvoice.Active) or (quSHInvoiceIDPreSale.AsInteger = 0) then
    Result := -1
  else
    Result := quSHInvoiceIDPreSale.AsInteger;

end;

procedure TFrmJoinHold.btnSearchSHClick(Sender: TObject);
var
  sSQL, sWhere, sField, sName : String;
begin
  inherited;

  sSQL := quSHInvoice.CommandText;

  sWhere := 'P.IDTipoPessoa = 1 AND I.IDInvoice IS NOT NULL AND I.Canceled = 0 ';

  if Trim(edtInvoiceNum.Text) <> '' then
    sWhere :=  sWhere + ' AND I.InvoiceCode like '+ QuotedStr('%'+edtInvoiceNum.Text+'%');

  if Trim(edtParamText.Text) <> '' then
  begin
    Case cbSearchFor.ItemIndex of
      0 : sField := 'P.Pessoa';
      1 : sField := 'P.PessoaFirstName';
      2 : sField := 'P.PessoaLastName';
      3 : sField := 'P.CustomerCard';
      4 : sField := 'P.Telefone';
      5 : sField := 'P.CEP';
    end;

    sWhere :=  sWhere + ' AND ' + sField + ' Like ' + QuotedStr('%'+edtParamText.Text+'%');
  end;

  if Trim(edtTracNum.Text) <> '' then
    sWhere :=  sWhere + ' AND S.Tracking like '+ QuotedStr('%'+edtTracNum.Text+'%');


  quSHInvoice.Close;
  quSHInvoice.CommandText := ChangeWhereClause(quSHInvoice.CommandText, sWhere, True);
  quSHInvoice.Open;

end;

end.
