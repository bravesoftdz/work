unit uFrmServiceOrderSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  Mask, SuperComboADO, Buttons, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ADODB, DateBox, DBClient, Provider;

type
  TFrmServiceOrderSearch = class(TFrmParent)
    pnlBasicFilter: TPanel;
    Label4: TLabel;
    pblGO: TPanel;
    pnlAviso: TPanel;
    btnExec: TSpeedButton;
    csStatus: TSuperComboADO;
    btStatusC: TButton;
    grdServiceOrder: TcxGrid;
    grdServiceOrderDB: TcxGridDBTableView;
    grdServiceOrderView: TcxGridLevel;
    quSearchSO: TADODataSet;
    dsSearchSO: TDataSource;
    Label3: TLabel;
    cmbStore: TSuperComboADO;
    btStoreC: TButton;
    lbFrom: TLabel;
    DateInicio: TDateBox;
    lbTo: TLabel;
    DateFim: TDateBox;
    btnOK: TButton;
    Label1: TLabel;
    scProduct: TSuperComboADO;
    btProducts: TButton;
    Label2: TLabel;
    csCustomer: TSuperComboADO;
    Label5: TLabel;
    edtSerialNum: TEdit;
    btCustomerC: TButton;
    dspSearchSO: TDataSetProvider;
    cdsSearchSO: TClientDataSet;
    cdsSearchSOIDServiceOrder: TIntegerField;
    cdsSearchSOSONumber: TStringField;
    cdsSearchSOSODate: TDateTimeField;
    cdsSearchSOSOCloseDate: TDateTimeField;
    cdsSearchSOPessoa: TStringField;
    cdsSearchSOPhoneAreaCode: TStringField;
    cdsSearchSOTelefone: TStringField;
    cdsSearchSOCellAreaCode: TStringField;
    cdsSearchSOCellular: TStringField;
    cdsSearchSOEmail: TStringField;
    cdsSearchSOSOStatus: TStringField;
    cdsSearchSOColor: TStringField;
    cdsSearchSOStore: TStringField;
    cdsSearchSOSalePrice: TBCDField;
    cdsSearchSOCPhone: TStringField;
    cdsSearchSOCCell: TStringField;
    grdServiceOrderDBSONumber: TcxGridDBColumn;
    grdServiceOrderDBSODate: TcxGridDBColumn;
    grdServiceOrderDBSOCloseDate: TcxGridDBColumn;
    grdServiceOrderDBPessoa: TcxGridDBColumn;
    grdServiceOrderDBEmail: TcxGridDBColumn;
    grdServiceOrderDBSOStatus: TcxGridDBColumn;
    grdServiceOrderDBStore: TcxGridDBColumn;
    grdServiceOrderDBSalePrice: TcxGridDBColumn;
    grdServiceOrderDBCPhone: TcxGridDBColumn;
    grdServiceOrderDBCCell: TcxGridDBColumn;
    grdServiceOrderDBColor: TcxGridDBColumn;
    lbCustDoc: TLabel;
    edtCustDoc: TEdit;
    grdServiceOrderDBSerialNumber: TcxGridDBColumn;
    cdsSearchSOSerialNumber: TStringField;
    lbSONumber: TLabel;
    edtSONumber: TEdit;
    procedure btCloseClick(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure cdsSearchSOCalcFields(DataSet: TDataSet);
    procedure btnOKClick(Sender: TObject);
    procedure grdServiceOrderDBCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btStoreCClick(Sender: TObject);
    procedure btCustomerCClick(Sender: TObject);
    procedure btStatusCClick(Sender: TObject);
    procedure btProductsClick(Sender: TObject);
    procedure grdServiceOrderDBDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FResult : Boolean;
  public
    function Start : Integer;
  end;

implementation

uses uDM, uDMGlobal, uDMServiceOrder, uDateTimeFunctions, uSqlFunctions,
  uSystemConst;

{$R *.dfm}

{ TFrmServiceOrderSearch }

function TFrmServiceOrderSearch.Start: Integer;
begin
  DateInicio.Date      := FirstDateMonth;
  DateFim.Date         := LastDateMonth;
  cmbStore.LookUpValue := IntToStr(DM.fStore.ID);
  FResult              := False;

  ShowModal;

  if FResult and cdsSearchSO.Active and not (cdsSearchSO.IsEmpty) then
    Result := cdsSearchSO.FieldByName('IDServiceOrder').AsInteger
  else
    Result := -1;

  cdsSearchSO.Close;

end;

procedure TFrmServiceOrderSearch.btCloseClick(Sender: TObject);
begin
  inherited;
  FResult := False;
  Close;
end;

procedure TFrmServiceOrderSearch.btnExecClick(Sender: TObject);
var
  sWhere : String;
begin
  inherited;

  if cmbStore.LookUpValue <> '' then
    sWhere := ' SO.IDStore = ' + cmbStore.LookUpValue
  else
    sWhere := ' SO.IDStore IN ('+ DM.fStore.StoreList +')';

  if edtSONumber.Text = '' then
  begin
    if DateInicio.Text <> '' then
      sWhere := sWhere + ' AND SO.SODate >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy', (Trunc(DateInicio.Date))));

    if DateFim.Text <> '' then
      sWhere := sWhere + ' AND SO.SODate < ' + QuotedStr(FormatDateTime('mm/dd/yyyy', (Trunc(DateFim.Date + 1))));
  end
  else
     sWhere := sWhere + ' AND SO.SONumber like ' + QuotedStr('%' + edtSONumber.Text + '%');

  if csCustomer.LookUpValue <> '' then
    sWhere := sWhere + ' AND SO.IDCustomer = ' + csCustomer.LookUpValue;

  if csStatus.LookUpValue <> '' then
    sWhere := sWhere + ' AND SO.IDSOStatus = ' + csStatus.LookUpValue;

  if scProduct.LookUpValue <> '' then
    sWhere := sWhere + ' AND SOI.IDSOCustomerProduct = ' + scProduct.LookUpValue;

  if edtSerialNum.Text <> '' then
    sWhere := sWhere + ' AND SOI.SerialNumber like ' + QuotedStr('%' + Trim(edtSerialNum.Text) + '%');

  if edtCustDoc.Text <> '' then
    sWhere := sWhere + ' AND (P.CPF like ' + QuotedStr('%' + Trim(edtCustDoc.Text) + '%') +
                       ' OR P.InscEstadual like ' + QuotedStr('%' + Trim(edtCustDoc.Text) + '%') + ')';
  cdsSearchSO.Close;
  quSearchSO.CommandText := ChangeWhereClause(quSearchSO.CommandText, sWhere, True);
  cdsSearchSO.Open;


end;

procedure TFrmServiceOrderSearch.cdsSearchSOCalcFields(DataSet: TDataSet);
begin
  inherited;

  if cdsSearchSOCellAreaCode.AsString <> '' then
    cdsSearchSOCCell.AsString := cdsSearchSOCellAreaCode.AsString + ' ' + cdsSearchSOCellular.AsString
  else
    cdsSearchSOCCell.AsString := cdsSearchSOCellular.AsString;

  if cdsSearchSOPhoneAreaCode.AsString <> '' then
    cdsSearchSOCPhone.AsString := cdsSearchSOPhoneAreaCode.AsString + ' ' + cdsSearchSOTelefone.AsString
  else
    cdsSearchSOCPhone.AsString := cdsSearchSOTelefone.AsString;
    
end;

procedure TFrmServiceOrderSearch.btnOKClick(Sender: TObject);
begin
  inherited;
  FResult := True;
  Close;
end;

procedure TFrmServiceOrderSearch.grdServiceOrderDBCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.GridRecord.Values[grdServiceOrderDBColor.Index] <> '' then
    ACanvas.Font.Color := StringToColor(AViewInfo.GridRecord.Values[grdServiceOrderDBColor.Index]);
end;

procedure TFrmServiceOrderSearch.btStoreCClick(Sender: TObject);
begin
  inherited;
  cmbStore.LookUpValue := '';
  cmbStore.Text := '';
end;

procedure TFrmServiceOrderSearch.btCustomerCClick(Sender: TObject);
begin
  inherited;
  csCustomer.LookUpValue := '';
  csCustomer.Text := '';
end;

procedure TFrmServiceOrderSearch.btStatusCClick(Sender: TObject);
begin
  inherited;
  csStatus.LookUpValue := '';
  csStatus.Text := '';
end;

procedure TFrmServiceOrderSearch.btProductsClick(Sender: TObject);
begin
  inherited;
  scProduct.LookUpValue := '';
  scProduct.Text := '';
end;

procedure TFrmServiceOrderSearch.grdServiceOrderDBDblClick(
  Sender: TObject);
begin
  inherited;
  btnOKClick(btnOK);
end;

procedure TFrmServiceOrderSearch.FormShow(Sender: TObject);
begin
  inherited;

  if DM.fSystem.SrvParam[PARAM_SO_TYPE] = 1 then
    case DMGlobal.IDLanguage of
      LANG_ENGLISH:
      begin
        Label5.Caption                        := 'Plate Number:';
        grdServiceOrderDBSerialNumber.Caption := 'Plate Number';
      end;

      LANG_PORTUGUESE:
      begin
        Label5.Caption                        := 'Nº da placa :';
        grdServiceOrderDBSerialNumber.Caption := 'Nº da placa';
      end;

      LANG_SPANISH :
      begin
        Label5.Caption                        := 'Nº da placa :';
        grdServiceOrderDBSerialNumber.Caption := 'Nº da placa';
      end;
    end;

end;

end.
