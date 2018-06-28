unit uFrmTrackPackage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, ADODB,
  Mask, SuperComboADO;

type
  TFrmTrackPackage = class(TFrmParentAll)
    pnlSearchSH: TPanel;
    Label1: TLabel;
    lbSelection: TLabel;
    lbTrack: TLabel;
    edtInvoiceNum: TEdit;
    btnSearchSH: TButton;
    cbSearchFor: TComboBox;
    edtParamText: TEdit;
    edtTracNum: TEdit;
    gdTrackPackge: TcxGrid;
    gdTrackPackgeDBTableView: TcxGridDBTableView;
    gdTrackPackgeLevel: TcxGridLevel;
    Label2: TLabel;
    quSHInvoice: TADODataSet;
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
    dsSHInvoice: TDataSource;
    gdTrackPackgeDBTableViewInvoiceCode: TcxGridDBColumn;
    gdTrackPackgeDBTableViewInvoiceDate: TcxGridDBColumn;
    gdTrackPackgeDBTableViewPessoa: TcxGridDBColumn;
    gdTrackPackgeDBTableViewTotInvoice: TcxGridDBColumn;
    gdTrackPackgeDBTableViewShipDate: TcxGridDBColumn;
    gdTrackPackgeDBTableViewTracking: TcxGridDBColumn;
    gdTrackPackgeDBTableViewAddressName: TcxGridDBColumn;
    gdTrackPackgeDBTableViewAddress: TcxGridDBColumn;
    gdTrackPackgeDBTableViewCity: TcxGridDBColumn;
    gdTrackPackgeDBTableViewZIP: TcxGridDBColumn;
    gdTrackPackgeDBTableViewIDEstado: TcxGridDBColumn;
    gdTrackPackgeDBTableViewIDPais: TcxGridDBColumn;
    gdTrackPackgeDBTableViewShipVia: TcxGridDBColumn;
    quSHInvoiceWebsite: TStringField;
    gdTrackPackgeDBTableViewWebsite: TcxGridDBColumn;
    scDeliverType: TSuperComboADO;
    btnDeliverClear: TButton;
    strepPredefined: TcxStyleRepository;
    cxWebLink: TcxStyle;
    GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure btnSearchSHClick(Sender: TObject);
    procedure btnDeliverClearClick(Sender: TObject);
    procedure gdTrackPackgeDBTableViewCellClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
  public
    function Start:Boolean;
  end;

implementation

uses uDM, uDMGlobal, uSystemConst, uCharFunctions, uSqlFunctions, uWebFunctions,
     ClipBrd;

{$R *.dfm}

{ TFrmTrackPackage }

function TFrmTrackPackage.Start: Boolean;
begin
  ShowModal;
end;

procedure TFrmTrackPackage.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmTrackPackage.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmTrackPackage.btnSearchSHClick(Sender: TObject);
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

  if (scDeliverType.LookUpValue <> '') then
    sWhere :=  sWhere + ' AND D.IDDeliverType = '+ scDeliverType.LookUpValue;

  quSHInvoice.Close;
  quSHInvoice.CommandText := ChangeWhereClause(quSHInvoice.CommandText, sWhere, True);
  quSHInvoice.Open;

end;

procedure TFrmTrackPackage.btnDeliverClearClick(Sender: TObject);
begin
  inherited;

  scDeliverType.LookUpValue := '';
  
end;

procedure TFrmTrackPackage.gdTrackPackgeDBTableViewCellClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  if ACellViewInfo.Item.Name = 'gdTrackPackgeDBTableViewWebsite' then
    if (ACellViewInfo.GridRecord.Values[gdTrackPackgeDBTableViewWebsite.Index] <> Null) then
    begin
      Clipboard.AsText := ACellViewInfo.GridRecord.Values[gdTrackPackgeDBTableViewTracking.Index];
      OpenURL(ACellViewInfo.GridRecord.Values[gdTrackPackgeDBTableViewWebsite.Index]);
    end;


end;

end.
